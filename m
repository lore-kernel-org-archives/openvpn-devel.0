Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D619606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=S9K+12vM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OTaM82a+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R2KXK7kE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Hg3AW2gP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JkKz+UIn9I7g0maSnWR8j3nUAnQ3Q9PLYyhDSTKf6dc=; b=S9K+12vMy11tZxaYv9wezDzIXn
	Z+JO4e4Jr0Zh6toT3oa4Ljk4/9TRjysqxcP6pyKN41hkkiPAHY0dGi9BcU18JRlXnjbnlegQRt27n
	BJ8j7HeUEJe/pDgSEHZ6npl35/NmLOpiMDNbbzTewW6r/0Msco9azpCvZsW9JFO88jCE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMpVH-000000001DL-1puW;
	Fri, 30 Oct 2026 16:30:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMpVG-000000001D7-0RwN
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:30:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yLStHYjN/ZRfmNAGGg6DNmjbyDn3Uu9LRqG+r16bRRs=; b=OTaM82a+EPjnD2i/aV1sUhevVd
 OgTcnzdUZiKnNjWnP2n6iofVPkiS7FGlVI6/XHCl2bGuYDq0RNa8/Gxi5eIR5/7imrAYYLd8r6BxB
 nmd1K1VVgrMEHrvghNqam/fctJZwVT6OU/C4Vz6sygA+xQK2wfdSqpZ5OLEposOnjBFE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yLStHYjN/ZRfmNAGGg6DNmjbyDn3Uu9LRqG+r16bRRs=; b=R2KXK7kEseYRzmuhoEmM8QHuQC
 eRTz2vABlkGvJxuMXdbnzna3z5S2TBaNNDpSdfI18KMn4e3XWuF6cvthcaAFp6dlZ2QuGYrAIZDpg
 tSeX7/K+Ac4oU8xZHffvcRf3IQ1Ua98laDmiVVHHxOq6uUcn3h8tNrw8kBKE9hVOkdkU=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMpV8-000000006ep-2a6i for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 16:30:54 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so588599f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793377840; x=1793982640; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yLStHYjN/ZRfmNAGGg6DNmjbyDn3Uu9LRqG+r16bRRs=;
 b=Hg3AW2gPn+ELAeKWS5uOcUjX+pQlfzg4EzjqgqcRd+Q+i4RlxaupFLTXOTVgJiiVrc
 HJhnSFHQHEh+auNXetvHmGOSjz//1VBT+R1g4AZRqAvp+5KQ7TTV6b5lrTd+eGoIfVxw
 0c15R3pWnCkHzTbBd9K9OsOtLPk5kv5K0sXxFecrBBAI2O0bHQensionHPGqO6zfAvxe
 ZQpE5FZ+vWB2RW6ozbZDQo/tWLK1i4KzQo3tKjaP5bNwG1lX7GsbmfsrlOvOddD5O8ig
 IJxwIFeGNz+gDqcjJQSa2B1NOUFlRjAbSoJL+VNoN7sPmZp2AyDfpYt2RyvTYf1uiG1+
 KMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793377840; x=1793982640;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yLStHYjN/ZRfmNAGGg6DNmjbyDn3Uu9LRqG+r16bRRs=;
 b=Rf/dz9v1/+gShMss/BzQBS/jfEj/ne5MUQOfaCuLLy9zROyUoEqsM7/MaFfVlluvys
 wfugTPTTUkfjcUt9MvNTcs/AvrgHl/1ARnygiGIuGaPak2nbX0LDjCUCbeJWbS4ualMF
 i9+sjby+e6thvIqGDPUgXvHi1WyW2FeUFvtH39u9xcjztXpZrU3imxN5aT13kbzvh5fP
 Fh2+6w8WRozejDaYoC34EjFr9qw/eQ7+lJmP/CveBpjWANZrW2zO1+M3OHuNjRCINnle
 64ArEMDciTYPPGeUJCDH8SFD7td73ZH2DeqvIK8ZjvKYrmBQXJswIi7IDPpIaoh+PU5Z
 YHsg==
X-Gm-Message-State: AFq9FYJbz5zq/HChGYWYb+ErTck/DdbCwniVF+7iKUv/SUW2r03l2nYZ
 +4MwETVioCQBGy/3XdCnHL8kEcBGuu0DTs8wF+G3lsJyjauR545345N9qMV66xYCrkVcGwfGnwW
 YcdWCP+7Ni7stlXwa0teT+rAuYOHF2cOYPo4jqOwsF+Xv7oIkHG79/xV3bvgHsPsD8peS
X-Gm-Gg: AYBFou3E1P2RdQTL1/l2qUiLPJDXuG7wCZCzPN+wb7o3wGp88BCPRLfajOcShxEy7cK
 7rSYu5ufnJLtFsVTFqukdZBwFZTcF7svKUNtBJptnsxNa/NcLntys2TID6lhZowNCRJSNIZwubK
 jx0XwFV4l+14Ok43361fACUzr4IPqgpIplLltqw5Hbe855tiVw9YTVCK4Hbb4DuT2a6fxuoIl8O
 /OLcRkipe/gCtIEcATa3h1KxPOH37PMqxSUYuNJo28b9zKy15cabeju8lIlYQUvCYfGGH6mj7T9
 AARtgv3VxUTULRGaAhYVNcYaKHHV3Uyw7K+5I4T0JTYD/3roC5ZGup46xw9yGHonEsA4vGYzoGW
 7zAVjkcY2WdRuffpz+VbC7uX25p/PwLiVNL93L1bsHPHc4jGTWKhrlW5G806XaexVWec34//oEc
 S83SJnnzsGg+mDHeDHkpSRC1R8knl7646f3MgWCK6QpTXXK7vinn/9u+WexBmW2b5xRdmJ4vzk2
 wprvIRmdy0fIlEIX9XZWfycBgzqwq+cHq0kMy6QhyuPNtw0Mt6q+QhuFolYAr2MY2LTPh78Dqkp
 Hl1djfBT25VHx0GNO7oteJZ5rJbKqE1vuIl/FdYMbHJv9RNKf0HiFIl/DXZyVxnSrayS07lH8yU
 16UdOAZ+RF2yfvsyQFgW9Nxh5xTQ5P4QrOtg3+LOUrCGmxyppKVRsuNShw7S+axUYLDSHlgCAeW
 eCUHOArrwoG9yMmSq15plq+7ZkVBLp11WyzHoh
X-Received: by 2002:a05:6000:4b0b:b0:48e:1b11:7ed0 with SMTP id
 ffacd0b85a97d-48e6e2ff15bmr6218595f8f.33.1793377838809; 
 Fri, 30 Oct 2026 09:30:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7246fsm4118080f8f.19.2026.10.30.09.30.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 09:30:38 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 16:30:35 +0000
To: chugly <charlie.vigue@openvpn.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: a91bc1d13f39e6ec5e0dac0426c2cb4afe4ad3fe
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7af4feff86dd378f96eef79edaba3ff6dc4fa5a8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMpV8-000000006ep-2a6i
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5536261697860362696=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5536261697860362696==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z1EQSURmR40="; charset=UTF-8

--Z1EQSURmR40=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru, chugly=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru,=
 chugly, 

I'd like you to reexamine a change=2E Please visit

    https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail

to look at the new pat=
ch set (#25)=2E

The following approvals got outdated and were removed:
Cod=
e-Review+2 by R=C4=83zvan Cojocaru


Change subject: Implement sending/rece=
iving app custom control protocol messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Implement sending/receiving app custom cont=
rol protocol messages

This allows openvpn GUI/front-ends and server via ma=
nagement
to use the OpenVPN control channel to pass messages between each o=
ther
while OpenVPN handles the marshalling/unmarshalling of these and
negot=
iate the common app custom control protocols=2E

This provides an easy to u=
se secure channel that does not depend on
the network itself to work and ca=
n also be used before fully
authenticating the client=2E See the management=
-notes=2Etxt for more
details how to use this feature=2E An upcoming patch =
will also add
some example python scripts that showcase this feature=2E

Ch=
ange-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Signed-off-by: Arne Schw=
abe <arne@rfc2549=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-sections/client-o=
ptions=2Erst
M doc/man-sections/management-options=2Erst
M doc/man-sections=
/script-options=2Erst
M doc/management-notes=2Etxt
M src/openvpn/Makefile=
=2Eam
A src/openvpn/acc=2Ec
A src/openvpn/acc=2Eh
M src/openvpn/forward=2Ec=

M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M=
 src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
=
M src/openvpn/push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/ssl=2Ec
M src/o=
penvpn/ssl_common=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit=
_tests/openvpn/mock_management=2Ec
M tests/unit_tests/openvpn/mock_push_dep=
endencies=2Ec
A tests/unit_tests/openvpn/test_acc=2Ec
A tests/unit_tests/op=
envpn/test_acc=2Eh
M tests/unit_tests/openvpn/test_common=2Eh
M tests/unit_=
tests/openvpn/test_ssl=2Ec
26 files changed, 1,547 insertions(+), 23 deleti=
ons(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/58/1858/25

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 184a95a=
=2E=2E4deabe7 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -435,=
6 +435,8 @@
     src/compat/compat-strlcpy=2Ec
     src/compat/compat-strse=
p=2Ec
     src/compat/compat-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src=
/openvpn/acc=2Eh
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     s=
rc/openvpn/base64=2Ec
@@ -826,6 +828,8 @@
             tests/unit_tests/ope=
nvpn/mock_management=2Ec
             tests/unit_tests/openvpn/mock_ssl_dep=
endencies=2Ec
             tests/unit_tests/openvpn/mock_win32_execve=2Ec
+=
            tests/unit_tests/openvpn/test_acc=2Ec
+            src/openvpn/=
acc=2Ec
             src/openvpn/argv=2Ec
             src/openvpn/base64=
=2Ec
             src/openvpn/crypto_epoch=2Ec
@@ -842,6 +846,7 @@
        =
     src/openvpn/packet_id=2Ec
             src/openvpn/run_command=2Ec
   =
          src/openvpn/ssl_mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
=
             src/openvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=
=2Ec
             src/openvpn/ssl_verify_mbedtls=2Ec
diff --git a/doc/man-s=
ections/client-options=2Erst b/doc/man-sections/client-options=2Erst
index =
87c138a=2E=2E16309f9 100644
--- a/doc/man-sections/client-options=2Erst
+++=
 b/doc/man-sections/client-options=2Erst
@@ -437,6 +437,12 @@
         Addi=
tional authentication methods supported by the client=2E
         This may =
be set by the client UI/GUI using ``--setenv``=2E
 
+  :code:`IV_ACC=3D<max=
_msg_len>,<flags>,<protocols>`
+        If the option ``--app-custom-contro=
l`` is set, the client will
+        send the supported max ACC message len=
gth, the supported formats
+        as (:code:`A:6`) and the list of config=
ured protocols (e=2Eg=2E
+        :code:`flower:happy:power`)
+
   The foll=
owing flags depend on which compression formats are compiled in
   and whet=
her compression is allowed by options=2E See `Protocol options`_
   for mor=
e details=2E
diff --git a/doc/man-sections/management-options=2Erst b/doc/m=
an-sections/management-options=2Erst
index 2c79d05=2E=2E315e567 100644
--- =
a/doc/man-sections/management-options=2Erst
+++ b/doc/man-sections/manageme=
nt-options=2Erst
@@ -144,3 +144,17 @@
 
 --management-up-down
   Report tun=
nel up/down events to management interface=2E
+
+--app-custom-control proto=
col-list
+  Sets the list of supported app custom control protocols=2E
+  T=
hese protocols are announced to the server via the IV_ACC peer info
+  vari=
able when this option is used on a client=2E
+  If the option is set on a s=
erver it will negotiate common protocols
+  with the client=2E
+
+  The pro=
tocol-list is a : separated list of protocol identifiers=2E Protocol
+  ide=
ntifiers must consist of alphanumeric characters, :code:`-`, and
+  :code:`=
_`=2E
+
+  See management-notes=2Etxt in the OpenVPN distribution and the O=
penVPN RFC
+  draft for a description of app custom control protocol suppor=
t=2E
diff --git a/doc/man-sections/script-options=2Erst b/doc/man-sections/=
script-options=2Erst
index f420380f=2E=2E474c7fd 100644
--- a/doc/man-secti=
ons/script-options=2Erst
+++ b/doc/man-sections/script-options=2Erst
@@ -10=
06,3 +1006,12 @@
        X509_1_L=3DBISHKEK
        X509_1_ST=3DNA
        =
X509_1_C=3DKG
+
+:code:`acc_protocols`
+    If ``--app-custom-control`` is =
configured and the client supports any of the
+    protocols that server al=
so supports, this variable contains a list of
+    common protocols separat=
ed by :=2E
+
+:code:`acc_message_len`
+    if :code:`acc_protocols` is set,=
 this variable contains the maximum
+    message length for app custom prot=
ocol message=2E
diff --git a/doc/management-notes=2Etxt b/doc/management-no=
tes=2Etxt
index 4d726c4=2E=2E3f12c83 100644
--- a/doc/management-notes=2Etx=
t
+++ b/doc/management-notes=2Etxt
@@ -828,6 +828,59 @@
 that is required t=
o continue the connection (unlike MFA or opening a browser)
 this message i=
s not negotiated but can just be sent as a gratuitous message=2E
 
+app cus=
tom control
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the=
 special string "ACC" is passed as {EXTRA} OpenVPN will determine
+the comm=
on app custom protocols between the client and the server and instruct
+the=
 client that the server will send control messages to the client using
+the=
 ACC protocol=2E
+
+The server should then use client-acc-msg command to se=
nd app custom
+control messages to the client to facilitate the pending aut=
hentication=2E
+
+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher)
+----=
---------------------------------------------
+
+On an OpenVPN instance run=
ning in server mode this command sends an
+app custom control message to a =
client=2E The format of the command is:
+
+  client-acc-msg {CID} {KID}
+  =
{protocol}
+  {flags}
+  {message}
+  END
+
+CID,KID -- client ID and Key I=
D=2E See documentation for ">CLIENT:"
+notification for more info=2E
+
+pro=
tocol -- the ACC protocol identifier that this message should be
+         =
   tagged with=2E
+
+flags    -- a concatenation of letters for the encodin=
g ('A' or '6')
+            and the lette 'F' if the message is a fragment=
=2E E=2Eg=2E
+            "6F" for a base64 encoded message that is also a =
fragment
+            and not complete yet=2E
+
+message  -- The message en=
coded in the encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=
=2E8 or higher)
+------------------------------------------
+
+When OpenVPN=
 is running in --client mode this command sends an app
+custom command to t=
he server=2E The format of the command is
+
+  acc-msg
+  {protocol}
+  {fl=
ags}
+  {message}
+  END
+
+See the client-acc-msg command for more details=
 about the format of the
+message=2E Since a client has only one peer there=
 is no need to specify the
+client id and key id=2E
+
+
 COMMAND -- client-=
deny  (OpenVPN 2=2E1 or higher)
 ------------------------------------------=
-----
 
@@ -1302,6 +1355,52 @@
    response=2E Mechanisms that need multipl=
e rounds or more complex answers
    should implement a different response =
type than CR_RESPONSE=2E
 
+(6) App custom control message
+
+    This mess=
age is an application specific payload message that is transported
+    ove=
r the OpenVPN control channel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,=
{CID},{KID},{protocol},{fragment},{msg_base64}
+
+    In client mode:
+
+  =
  >ACC:{protocol},{fragment},{msg_base64}
+
+    The protocol is a short as=
cii string identifying the app specific custom
+    protocol=2E If fragment=
 is set to 1, the message is not complete and the
+    next message should =
be concatenated to this message to form a complete
+    message=2E
+
+    N=
ote that the OpenVPN implementation operates here with the robustness
+    =
principle ("be conservative in what you send, be liberal in what you
+    a=
ccept" - RFC 793 and others) and allows receiving messages longer than
+   =
 maximum allowed message length=2E Implementations should be prepared to
+ =
   handle messages that are longer than the maximum allowed message length=
=2E
+
+    OpenVPN does not verify that the message is valid base64=2E A pe=
er that
+    sends invalid base64 payload will be passed to the management =
interface=2E
+    An implementation should be prepared to handle invalid ba=
se64 and
+    handle accordingly (e=2Eg=2E disconnect the client via client=
-deny or
+    ignore such messages)=2E
+
+(7) App custom control protocol m=
essage
+
+   This message informs the client about the common ACC
+   proto=
cols and the maximum message length for an ACC message=2E
+
+   In client m=
ode:
+
+   >ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=3D{max_ms=
g_len}
+
+   protocol_list is the list of supported protocols by both serve=
r and client=2E
+   For example flower:power:sys_info would indicate these =
three protocols
+   are supported=2E max_msg_len specifies the maximum mess=
age length that the
+   peer supports=2E
+
+   In server mode these informa=
tion are available in the acc_protocols and
+   acc_message_len variables o=
f the client environment=2E
 
 Variables:
 
diff --git a/src/openvpn/Makefi=
le=2Eam b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2Eebc4db6 100644
--- a=
/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -45,6 +45,7 @=
@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 =
	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=
=2Eh \
@@ -124,7 +125,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
=
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2Ec push=2Eh \=

+	push_util=2Ec \
 	pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh=
 \
 	reliable=2Ec reliable=2Eh \
diff --git a/src/openvpn/acc=2Ec b/src/ope=
nvpn/acc=2Ec
new file mode 100644
index 0000000=2E=2E455f56d
--- /dev/null
=
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,445 @@
+/*
+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks
+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based
+ *             session authentication a=
nd key exchange,
+ *             packet encryption, packet authentication, =
and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenV=
PN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc=
2549=2Eorg>
+ *
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
+ *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <string=2Eh>
+#include =
"buffer=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#include "forward=
=2Eh"
+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_=
ncp=2Eh"
+#include "multi=2Eh"
+
+static void
+log_acc_message(struct conte=
xt *c, const struct buffer *buf, int payload_len,
+                const ch=
ar *protocol, int flags)
+{
+    bool fragment =3D flags & ACC_MESSAGE_FLAG=
S_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc =3D gc_new();=

+    const char *payload_msg =3D NULL;
+
+    /* For simplicity, we always=
 encode payload to be base64 encoded
+     * if not already in base64 forma=
t */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+        char *b64out=
 =3D NULL;
+        ASSERT(openvpn_base64_encode(CBPTR(buf), payload_len, &=
b64out) >=3D 0);
+        gc_addspecial(b64out, free, &gc);
+        payloa=
d_msg =3D b64out;
+    }
+    else
+    {
+        payload_msg =3D CBSTR(bu=
f);
+    }
+
+    if (management)
+    {
+        struct tls_session *sessi=
on =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+        if (c->options=2E=
mode =3D=3D MODE_SERVER)
+        {
+            /* server mode=2E Report c=
lient context */
+            struct man_def_auth_context *mda =3D session-=
>opt->mda_context;
+            unsigned int mda_key_id =3D get_primary_key=
(c->c2=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CLIENT:ACC,%l=
u,%u,%s,%d,%s",
+                mda->cid, mda_key_id, protocol, fragment, =
payload_msg);
+        }
+        else
+        {
+            /* Client mo=
de=2E Do not a report a CLIENT id */
+            msg(M_CLIENT, ">ACC:%s,%d=
,%s", protocol, fragment, payload_msg);
+        }
+    }
+    gc_free(&gc)=
;
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Received custom a=
pp control message (protocol '%s'%s)",
+        protocol, fragment ? ", fra=
gment" : "");
+}
+
+
+int
+parse_acc_message_flags(const char *flags, const=
 char **err_reason, struct gc_arena *gc)
+{
+    int acc_flags =3D 0;
+
+  =
  for (const char *flag =3D flags; *flag !=3D '\0'; flag++)
+    {
+       =
 if (*flag =3D=3D 'A')
+        {
+            acc_flags |=3D ACC_MESSAGE_F=
LAGS_ASCII;
+        }
+        else if (*flag =3D=3D '6')
+        {
+    =
        acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else i=
f (*flag =3D=3D 'F')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLA=
GS_FRAGMENT;
+        }
+        else
+        {
+            *err_reason =
=3D "Unknown flag in flags";
+            return -1;
+        }
+    }
+   =
 /* The message should be encoded with exactly one encoding=2E Ensure that
=
+     * only one of the flags is present */
+    bool asciienc =3D (bool)(a=
cc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (bool)(acc_fla=
gs & ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc !=3D 1)
+  =
  {
+        char *tmp =3D gc_malloc(512, 1, gc);
+        snprintf(tmp, 51=
2, "number of encodings must be exactly one "
+                           "=
(B64=3D%d, ASCII=3D%d)",
+                 base64enc, asciienc);
+        *=
err_reason =3D tmp;
+        return -1;
+    }
+
+    return acc_flags;
+}
=
+
+/**
+ * Wrapper around parse_acc_message_flags to also include the step =
of
+ * extracting the flags from the buffer and forwarding the buffer
+ * b=
eyond the flags field=2E
+ */
+static int
+parse_acc_message_flags_buf(stru=
ct buffer *buf, const char **err_reason, struct gc_arena *gc)
+{
+    const=
 char *flags =3D buf_extract_field(buf, ',', gc);
+
+    if (!flags)
+    {=

+        *err_reason =3D "could not extract flags field";
+        return =
-1;
+    }
+    return parse_acc_message_flags(flags, err_reason, gc);
+}
+=

+void
+receive_acc_message(struct context *c, const struct buffer *buffer)=

+{
+    struct gc_arena gc =3D gc_new();
+    const char *err_reason =3D "=
";
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    stru=
ct buffer buf =3D *buffer;
+
+    const struct tls_multi *multi =3D c->c2=
=2Etls_multi;
+    if (!multi->acc_negotiated_protocols)
+    {
+        er=
r_reason =3D "ACC not enabled or no negotiated protocols";
+        goto er=
r;
+    }
+
+    if (!buf_advance(&buf, strlen("ACC")) || buf_read_u8(&buf)=
 !=3D ',')
+    {
+        err_reason =3D "missing , after ACC";
+        g=
oto err;
+    }
+
+    /* extract protocol, payload length, flags substring=
s */
+    const char *protocol =3D buf_extract_field(&buf, ',', &gc);
+    =
if (!protocol)
+    {
+        err_reason =3D "could not extract protocol f=
ield";
+        goto err;
+    }
+
+    if (!tls_item_in_cipher_list(protoc=
ol, multi->acc_negotiated_protocols))
+    {
+        struct buffer msg_buf=
 =3D alloc_buf_gc(1024, &gc);
+        buf_printf(&msg_buf, "protocol '%s' =
not in list of negotiated protocols '%s'",
+                   protocol, mu=
lti->acc_negotiated_protocols);
+        err_reason =3D buf_cstr(&msg_buf);=

+
+
+        goto err;
+    }
+
+    /* We do not check the length here=2E=
 We make no promises to support
+     * anything larger than our announced =
message length but according to
+     * the robustness principle
+     * ("=
be conservative in what you send, be liberal in what you accept" - RFC 793 =
and others)
+     * we accept also longer messages */
+
+    int payload_le=
n;
+    const char *payload_len_str =3D buf_extract_field(&buf, ',', &gc);
=
+    if (!payload_len_str
+        || !atoi_constrained(payload_len_str, &p=
ayload_len, "acc_payload_len", 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))=

+    {
+        err_reason =3D "could not extract payload length field";
+=
        goto err;
+    }
+
+    int flags =3D parse_acc_message_flags_buf(&=
buf, &err_reason, &gc);
+
+    if (flags < 0)
+    {
+        goto err;
+  =
  }
+
+    /* We should have a final NUL byte in the control message buffer=

+     * and thus the length of the buffer should be payload_len + 1 */
+  =
  if (buf_len(&buf) !=3D payload_len + 1)
+    {
+        char *tmp =3D gc_=
malloc(512, 1, &gc);
+        snprintf(tmp, 512, "field length %d, payload =
length %d mismatch",
+                 payload_len, buf_len(&buf) - 1);
+  =
      err_reason =3D tmp;
+        goto err;
+    }
+
+
+    log_acc_messag=
e(c, &buf, payload_len, protocol, flags);
+    gc_free(&gc);
+    return;
+=

+err:
+    msg(D_PUSH_ERRORS, "WARNING: Received malformed custom app cont=
rol channel "
+                       "message (%s): %s",
+        err_reas=
on,
+        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+    gc_fre=
e(&gc);
+}
+
+
+bool
+send_acc_message(struct context *c,
+                =
 struct tls_multi *multi,
+                 struct tls_session *session,
+ =
                const char *protocol, bool fragment,
+                 cons=
t char *acc_msg_payload, bool base64)
+{
+    /*
+     * length of the prot=
ocol string + one ','
+     * 2 for the encoding (A or 6), potential F (fra=
gment), and 1 for the ',',
+     * 4 for the message size itself and one co=
mma
+     * 1 for the comma before the message itself */
+    const size_t =
max_header_size =3D strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
=
+    size_t len =3D max_header_size + strlen(acc_msg_payload);
+
+    if (l=
en > TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_CLIENT, "message length (%=
zu) exceeds maximum possible message length (%d)", len, TLS_CHANNEL_BUF_SIZ=
E);
+        return false;
+    }
+
+    if ((int)len > multi->acc_max_mess=
age_length)
+    {
+        msg(M_CLIENT, "header (%zu) + message size (%zu=
) length (%zu) exceeds "
+                      "maximum allowed length neg=
otiated with peer (%d)",
+            max_header_size, strlen(acc_msg_paylo=
ad), len,
+            multi->acc_max_message_length);
+        return fals=
e;
+    }
+
+    struct gc_arena gc =3D gc_new();
+    /* add 1 for the fin=
al \0 */
+    struct buffer buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* E=
xample message: ACC,muppets,15,A,I am Miss Piggy */
+    buf_printf(&buf, "=
ACC,%s,%zu,%s%s,%s", protocol,
+               strlen(acc_msg_payload),
+  =
             base64 ? "6" : "A",
+               fragment ? "F" : "",
+    =
           acc_msg_payload);
+
+    bool ret =3D send_control_channel_strin=
g_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c);
+ =
   gc_free(&gc);
+    return ret;
+}
+
+char *
+parse_acc_parameters(const =
char *capabilities,
+                     const char *delim,
+             =
        int *max_acc_len,
+                     bool server,
+             =
        struct gc_arena *gc)
+{
+    char *tmp_message =3D string_alloc(cap=
abilities, NULL);
+    char *tmp_message_orig =3D tmp_message;
+    char *l=
asts =3D NULL;
+
+    const char *token =3D strtok_r(tmp_message, delim, &l=
asts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+    const char *protocol=
s =3D NULL;
+    char *ret =3D NULL;
+
+    /* In server mode we allow more=
 capabilities than our own, in client
+     * mode we reject if we should u=
se capabilities that we do not support */
+    int allowed_acc_len =3D serv=
er ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if (p =
=3D=3D 0 && !atoi_constrained(token, &acclen, "ACC message length", ACC_MIN=
_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto don=
e;
+        }
+
+        if (p =3D=3D 1 && (!tls_item_in_cipher_list("A", t=
oken) || !tls_item_in_cipher_list("6", token)))
+        {
+            msg=
(D_PUSH_ERRORS, "App custom control encoding must include base64 and ascii"=
);
+            goto done;
+        }
+
+        if (p =3D=3D 1 && !server =
&& strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+            ms=
g(D_PUSH_ERRORS, "App custom control encoding must be exactly base64 and as=
cii");
+            goto done;
+        }
+
+        if (p =3D=3D 2)
+     =
   {
+            protocols =3D token;
+        }
+
+        if (p =3D=3D 3=
)
+        {
+            msg(D_PUSH_ERRORS, "Too many parameters for INFO =
ACC message/IV_ACC=2E");
+            goto done;
+        }
+
+        toke=
n =3D strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_acc_l=
en =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =3D string_alloc(protocol=
s, gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}
+
+struct=
 buffer
+get_list_intersection(struct gc_arena *gc, const char *list1, cons=
t char *list2)
+{
+    char *tmp =3D string_alloc(list1, NULL);
+    char *=
lasts =3D NULL;
+    const char *token =3D strtok_r(tmp, ":", &lasts);
+
+ =
   /* The maximum possible length is the shorter of the two input lists */
=
+    size_t max_len =3D min_size(strlen(list1), strlen(list2));
+
+    stru=
ct buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc);
+
+    while =
(token)
+    {
+        /* check for every items is in both lists and not a=
lready in the
+         * common list */
+        if (tls_item_in_cipher_li=
st(token, list2)
+            && !tls_item_in_cipher_list(token, buf_cstr(&=
common_protocols)))
+        {
+            if (buf_len(&common_protocols) =
> 0)
+            {
+                buf_write_u8(&common_protocols, ':');
=
+            }
+            buf_printf(&common_protocols, "%s", token);
+  =
      }
+        token =3D strtok_r(NULL, ":", &lasts);
+    }
+    free(tm=
p);
+    return common_protocols;
+}
+
+void
+determine_common_acc_protocol=
s(struct tls_multi *multi, struct tls_session *session)
+{
+    if (!multi-=
>opt=2Eacc_protocols)
+    {
+        /* No app custom protocols have been =
configured server-side=2E */
+        return;
+    }
+
+    if (multi->acc_=
negotiated_protocols)
+    {
+        /* We already have determined the com=
mon protocols=2E */
+        return;
+    }
+
+    struct gc_arena gc =3D g=
c_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+    c=
onst char *peer_info =3D multi->peer_info;
+    const char *iv_acc =3D extr=
act_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+ =
       gc_free(&gc);
+        return;
+    }
+
+    int max_acc_len =3D 0;
=
+    const char *protocols =3D parse_acc_parameters(iv_acc, ",", &max_acc_l=
en, true, &gc);
+
+    if (!protocols)
+    {
+        gc_free(&gc);
+     =
   msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable of peer is malfor=
med");
+        return;
+    }
+
+    struct buffer common_protocols =3D ge=
t_list_intersection(&gc, multi->opt=2Eacc_protocols, protocols);
+
+    if =
(buf_len(&common_protocols) =3D=3D 0)
+    {
+        msg(D_PUSH_DEBUG, "WA=
RNING: No common app custom control protocol=2E");
+        gc_free(&gc);
+=
        return;
+    }
+
+    multi->acc_negotiated_protocols =3D string_al=
loc(buf_str(&common_protocols), NULL);
+    multi->acc_max_message_length =
=3D max_acc_len;
+
+    setenv_str(session->opt->es, "acc_protocols", multi=
->acc_negotiated_protocols);
+    setenv_int(session->opt->es, "acc_message=
_len", multi->acc_max_message_length);
+
+    gc_free(&gc);
+}
+
+void
+not=
ify_client_acc_protocols(struct tls_multi *multi)
+{
+#ifdef ENABLE_MANAGEM=
ENT
+    if (management)
+    {
+        msg(M_CLIENT, ">ACC_PROTOCOLS:prot=
ocols=3D%s,message_len=3D%d",
+            multi->acc_negotiated_protocols,=
 multi->acc_max_message_length);
+    }
+#endif
+}
diff --git a/src/openvpn=
/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 0000000=2E=2E9c99=
b11
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,130 @@
+/*
+ *  Open=
VPN -- An application to securely tunnel IP networks
+ *             over a=
 single TCP/UDP port, with support for SSL/TLS-based
+ *             sessio=
n authentication and key exchange,
+ *             packet encryption, packe=
t authentication, and
+ *             packet compression=2E
+ *
+ *  Copyri=
ght (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne=
 Schwabe <arne@rfc2549=2Eorg>
+ *
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
if not, write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#defi=
ne ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 64
+#define A=
CC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom control mes=
sage and delivers it to the
+ * management interface=2E We leave reassembly=
 of fragmented messages to the
+ * management interface=2E
+ *
+ * @param c=
            The context struct
+ * @param buffer       Buffer containing th=
e control message with ACC
+ */
+void
+receive_acc_message(struct context *=
c, const struct buffer *buffer);
+
+bool
+send_acc_message(struct context *=
c,
+                 struct tls_multi *tls_multi,
+                 struct =
tls_session *session,
+                 const char *protocol, bool fragment=
,
+                 const char *msg, bool base64);
+
+
+/**
+ * Parses an i=
nfo message from the server that contains app custom control info
+ * infor=
mation prior to the PUSH_REPLY to be able to use app custom control
+ * pro=
tocols before sending
+ *
+ * In client mode only allow what we support our=
selves=2E In server mode
+ * allow also capabilities that we not support ou=
rselves=2E
+ *
+ * @param capabilities      The string to parse
+ * @param =
delim             The delimiter to use when parsing the string=2E
+ *      =
                    IV_ACC uses "," as delimiter while the
+ *             =
             custom-control PUSH message uses " " as "," is
+ *            =
              already used to separate different push directives
+ * @param=
 max_acc_len       Set to the maximum ACC message length
+ * @param server =
           Whether we are server or client
+ * @param gc                The=
 gc arena to use for allocating the resulting string
+ * @return           =
       The resulting protocol string or NULL on error
+ */
+char *
+parse_a=
cc_parameters(const char *capabilities,
+                     const char *d=
elim,
+                     int *max_acc_len,
+                     bool se=
rver,
+                     struct gc_arena *gc);
+
+/**
+ * Parses the IV_=
ACC of the peer and sets multi=2Eacc_negotiated_protocols
+ * to the common=
 protocols of server and client and
+ * multi=2Eacc_max_message_length  to =
the maximum length of the ACC message
+ * support by both server and client=
=2E
+ *
+ * If there is no common protocol or the client does not support a=
ny app custom
+ * protocol multi=2Eacc_negotiated_protocols will be set to =
NULL=2E
+ *
+ * @param multi      the multi instance to use the set the app=
 custom protocols=2E
+ * @param session    the session to read the client e=
nv from
+ */
+void
+determine_common_acc_protocols(struct tls_multi *multi,=
 struct tls_session *session);
+
+/**
+ * Flags returned by the parse_acc_m=
essage_flags method
+ */
+enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_A=
SCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRA=
GMENT =3D 4,
+};
+
+/**
+ *  Parses the flags field of an app control messa=
ge If there is an
+ *  error parsing the flags field the method returns -1 =
and
+ *  puts the error reason in err_reason
+ */
+int
+parse_acc_message_f=
lags(const char *flags, const char **err_reason, struct gc_arena *gc);
+
+/=
**
+ * Calculates the intersection of two list that are both separated by :=

+ * Items in the result will have the same ordering as in the list1
+ * pa=
rameters
+ * @param gc            Returned buffer will be allocated in this=
 gc
+ * @param list1         First list to intersect
+ * @param list2      =
   Second list to intersect=2E
+ * @return A (potentially empty) buffer con=
taining an intersection list
+ */
+struct buffer
+get_list_intersection(str=
uct gc_arena *gc, const char *list1, const char *list2);
+
+/**
+ * Notifie=
s a client via management interface of the negotiated app
+ * custom protoc=
ols
+ * @param multi the tls_multi instance of the connection
+ */
+void
+n=
otify_client_acc_protocols(struct tls_multi *multi);
+#endif
diff --git a/s=
rc/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=2Eeb41d03=
 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,=
6 +42,7 @@
 #include "dco=2Eh"
 #include "auth_token=2Eh"
 #include "tun_af=
unix=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -257,11 +258,11=
 @@
     }
     else if (buf_string_match_head_str(buf, "INFO_PRE"))
     {=

-        server_pushed_info(buf, 8);
+        peer_pushed_info(c, buf, 8);=

     }
     else if (buf_string_match_head_str(buf, "INFO"))
     {
-     =
   server_pushed_info(buf, 4);
+        peer_pushed_info(c, buf, 4);
     }=

     else if (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -27=
1,6 +272,10 @@
     {
         receive_auth_pending(c, buf);
     }
+    el=
se if (buf_string_match_head_str(buf, "ACC"))
+    {
+        receive_acc_m=
essage(c, buf);
+    }
     else if (buf_string_match_head_str(buf, "EXIT")=
)
     {
         receive_exit_message(c);
diff --git a/src/openvpn/init=2E=
c b/src/openvpn/init=2Ec
index 1b8b2a5=2E=2Ee0b99a4 100644
--- a/src/openvp=
n/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -56,6 +56,7 @@
 #include "schedule=
=2Eh"
 #include "options_string=2Eh"
 #include "resolve=2Eh"
+#include "acc=
=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -2279,6 +2280,13 @@
         }
     }
 =

+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    if (multi && mult=
i->acc_negotiated_protocols)
+    {
+        buf_printf(&out, " custom-cont=
rol %d A:6 %s",
+                   multi->acc_max_message_length, multi->a=
cc_negotiated_protocols);
+    }
+
     if (BLENZ(&out) > strlen(header))
 =
    {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +2530,11 @@
 =
        flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->opti=
ons=2Eacc_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }
+
     re=
turn flags;
 }
 
@@ -2730,6 +2743,18 @@
         frame->tun_mtu =3D min_int=
(frame->tun_max_mtu, c->options=2Ece=2Etun_mtu);
     }
 
+    if (found & =
OPT_P_ACC && c->options=2Epushed_acc_negotiated_protocols)
+    {
+        =
struct tls_multi *multi =3D c->c2=2Etls_multi;
+        free(multi->acc_neg=
otiated_protocols);
+        multi->acc_negotiated_protocols =3D string_all=
oc(c->options=2Epushed_acc_negotiated_protocols, NULL);
+        multi->acc=
_max_message_length =3D c->options=2Epushed_acc_max_message_length;
+
+    =
    msg(D_PUSH, "OPTIONS IMPORT: ACC protocols: %s, msg len: %d",
+        =
    multi->acc_negotiated_protocols, multi->acc_max_message_length);
+     =
   notify_client_acc_protocols(multi);
+    }
+
     return true;
 }
 
@@ -=
3352,6 +3377,7 @@
     to=2Everify_hash_depth =3D options->verify_hash_dept=
h;
     to=2Everify_hash_no_ca =3D options->verify_hash_no_ca;
     memcpy(=
to=2Ex509_username_field, options->x509_username_field, sizeof(to=2Ex509_us=
ername_field));
+    to=2Eacc_protocols =3D options->acc_protocols;
     to=
=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4306,6 +4332=
,24 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+management_acc=
_msg(void *arg,
+                   struct buffer_list *input) /* ownership=
 transferred */
+{
+    struct context *c =3D arg;
+
+    bool ret =3D fals=
e;
+    if (buffer_list_defined(input) && c->c2=2Etls_multi)
+    {
+      =
  struct tls_multi *multi =3D c->c2=2Etls_multi;
+        struct tls_sessio=
n *session =3D &multi->session[TM_ACTIVE];
+
+        ret =3D management_se=
nd_acc_message(c, multi, session, input);
+    }
+
+    buffer_list_free(in=
put);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ =
-4322,6 +4366,7 @@
         cb=2Eproxy_cmd =3D management_callback_proxy_cm=
d;
         cb=2Eremote_cmd =3D management_callback_remote_cmd;
         cb=
=2Esend_cc_message =3D management_callback_send_cc_message;
+        cb=2Ea=
cc_msg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Enetwork=
_change =3D management_callback_network_change;
 #endif
diff --git a/src/op=
envpn/manage=2Ec b/src/openvpn/manage=2Ec
index ac3d4b7=2E=2Eaff8146 100644=

--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -45,9 +45,11 =
@@
 #include "push=2Eh"
 #include "multi=2Eh"
 #include "resolve=2Eh"
+#inc=
lude "acc=2Eh"
 
 #include "memdbg=2Eh"
 #include "run_command=2Eh"
+#inclu=
de "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -1081,6 =
+1083,35 @@
             }
             break;
 
+        case IEC_CLIENT_A=
CC_MSG:
+            if (man->persist=2Ecallback=2Eclient_acc_msg)
+       =
     {
+                bool status =3D (*man->persist=2Ecallback=2Eclient_=
acc_msg)(man->persist=2Ecallback=2Earg,
+                                  =
                                    man->connection=2Ein_extra_cid,
+      =
                                                                man->connec=
tion=2Ein_extra_kid,
+                                                     =
                 man->connection=2Ein_extra);
+                man->connect=
ion=2Ein_extra =3D NULL;
+                report_command_status(status, "cl=
ient-acc-msg");
+            }
+            else
+            {
+          =
      man_command_unsupported("client-acc-msg");
+            }
+          =
  break;
+
+        case IEC_ACC_MSG:
+            if (man->persist=2Ecallb=
ack=2Eacc_msg)
+            {
+                bool status =3D (*man->persi=
st=2Ecallback=2Eacc_msg)(man->persist=2Ecallback=2Earg,
+                  =
                                             man->connection=2Ein_extra);
+=
                man->connection=2Ein_extra =3D NULL;
+                repor=
t_command_status(status, "acc-msg");
+            }
+            else
+    =
        {
+                man_command_unsupported("acc-msg");
+           =
 }
+            break;
         case IEC_PK_SIGN:
             man->connect=
ion=2Eext_key_state =3D EKS_READY;
             buffer_list_free(man->conne=
ction=2Eext_key_input);
@@ -1205,6 +1236,29 @@
 }
 
 static void
+man_clien=
t_acc_msg(struct management *man, const char *cid_str,
+                   =
const char *kid_str)
+{
+    struct man_connection *mc =3D &man->connection=
;
+    mc->in_extra_cid =3D 0;
+    mc->in_extra_kid =3D 0;
+    if (parse_=
cid(cid_str, &mc->in_extra_cid)
+        && parse_uint(kid_str, "KID", &mc-=
>in_extra_kid))
+    {
+        mc->in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+ =
       in_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void
+man_acc_msg(s=
truct management *man)
+{
+    struct man_connection *mc =3D &man->connecti=
on;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+    in_extra_reset(mc, IER_NEW)=
;
+}
+
+static void
 man_client_auth(struct management *man, const char *ci=
d_str, const char *kid_str, const bool extra)
 {
     struct man_connection=
 *mc =3D &man->connection;
@@ -1759,6 +1813,17 @@
             man_client_p=
ending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
+    else if (s=
treq(p[0], "client-acc-msg"))
+    {
+        if (man_need(p, 2, 0))
+     =
   {
+            man_client_acc_msg(man, p[1], p[2]);
+        }
+    }
+ =
   else if (streq(p[0], "acc-msg"))
+    {
+        man_acc_msg(man);
+    =
}
     else if (streq(p[0], "rsa-sig"))
     {
         man_pk_sig(man, "rs=
a-sig");
@@ -2975,7 +3040,9 @@
                                        "byt=
es_sent=3D",
                                        "bytes_received=3D",
 =
                                       "session_id=3D",
-                  =
                     "session_state=3D" };
+                               =
        "session_state=3D",
+                                       "acc_pr=
otocols=3D",
+                                       "acc_message_len=3D" }=
;
 
     if (env_filter_level =3D=3D 0)
     {
@@ -3130,6 +3197,7 @@
     }=

 }
 
+
 void
 management_connection_established(struct management *man, st=
ruct man_def_auth_context *mdac,
                                   const s=
truct env_set *es)
@@ -4372,6 +4440,58 @@
     }
 }
 
+bool
+management_sen=
d_acc_message(struct context *c, struct tls_multi *multi, struct tls_sessio=
n *session,
+                            struct buffer_list *input)
+{
+   =
 /* also ensures that are enough inputs in the list to safely call
+     * =
buffer_list_peek without extra NULL checks */
+    if (!input || input->siz=
e < 3)
+    {
+        msg(M_CLIENT, "not enough input lines for sending ac=
c message, "
+                      "missing protocol, flag and/or messages=
 lines");
+        return false;
+    }
+
+    struct gc_arena gc =3D gc_ne=
w();
+
+    const struct buffer *proto_buf =3D buffer_list_peek(input);
+  =
  const char *protocol =3D string_alloc(CBSTR(proto_buf), &gc);
+    buffer=
_list_pop(input);
+
+    const struct buffer *encoding_buf =3D buffer_list_=
peek(input);
+
+    const char *acc_err_reason =3D NULL;
+    int acc_flags=
 =3D parse_acc_message_flags(buf_cstr(encoding_buf), &acc_err_reason, &gc);=

+    if (acc_flags < 0)
+    {
+        msg(M_CLIENT, "ERROR: parsing acc =
message flags failed: %s", acc_err_reason);
+        goto error;
+    }
+
+=
    buffer_list_pop(input);
+
+    buffer_list_aggregate_separator(input, 1=
0000, "");
+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input=
);
+
+    if (!multi->acc_negotiated_protocols
+        || !tls_item_in_cip=
her_list(protocol, multi->acc_negotiated_protocols))
+    {
+        msg(M_=
CLIENT, "ERROR: protocol not in the list of negotiated protocols: %s",
+   =
         np(multi->acc_negotiated_protocols));
+        goto error;
+    }
=
+
+    bool ret =3D send_acc_message(c, multi, session, protocol,
+        =
                        acc_flags & ACC_MESSAGE_FLAGS_FRAGMENT,
+          =
                      buf_cstr(acc_msg_buf),
+                             =
   acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+    gc_free(&gc);
+    return re=
t;
+error:
+    gc_free(&gc);
+    return false;
+}
 #else /* ifdef ENABLE_=
MANAGEMENT */
 
 #include "win32=2Eh"
diff --git a/src/openvpn/manage=2Eh b=
/src/openvpn/manage=2Eh
index 157039d=2E=2Ecc9c264 100644
--- a/src/openvpn=
/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 @@
     int (*n=
_clients)(void *arg);
     bool (*send_cc_message)(void *arg, const char *m=
essage, const char *parameter);
     bool (*kill_by_cid)(void *arg, const u=
nsigned long cid, const char *kill_msg);
+
     bool (*client_auth)(void *a=
rg, const unsigned long cid, const unsigned int mda_key_id,
               =
          const bool auth, const char *reason, const char *client_reason,
 =
                        struct buffer_list *cc_config); /* ownership transf=
erred */
     bool (*client_pending_auth)(void *arg, const unsigned long ci=
d, const unsigned int kid,
                                 const char *ext=
ra, unsigned int timeout);
     char *(*get_peer_info)(void *arg, const uns=
igned long cid);
+    bool (*client_acc_msg)(void *arg,
+                  =
         const unsigned long cid,
+                           const unsigne=
d int mda_key_id,
+                           struct buffer_list *msg);
+  =
  bool (*acc_msg)(void *arg,
+                    struct buffer_list *msg);=

     bool (*proxy_cmd)(void *arg, const char **p);
     bool (*remote_cmd)=
(void *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@
 =
    struct command_line *in;
     struct buffer_list *out;
 
-#define IEC_U=
NDEF       0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#def=
ine IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */=

-#define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SIGN=
     5
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN       3
+#define IE=
C_CERTIFICATE    4
+#define IEC_PK_SIGN        5
+#define IEC_PASSWORD     =
  6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG        8
     int in=
_extra_cmd;
     struct buffer_list *in_extra;
     unsigned long in_extra_=
cid;
@@ -503,6 +512,14 @@
 
 void man_persist_client_stats(struct managemen=
t *man, struct context *c);
 
+/** Parses the ACC message from the input bu=
ffer_list and send to the
+ * session identified by session and multi
+ */
=
+struct tls_session;
+struct tls_multi;
+bool
+management_send_acc_message(=
struct context *c, struct tls_multi *multi,
+                            st=
ruct tls_session *session, struct buffer_list *input);
 #endif /* ifdef ENA=
BLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/m=
ulti=2Ec
index e302a81=2E=2Ea3eb3ca 100644
--- a/src/openvpn/multi=2Ec
+++ =
b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #include "ssl_util=2Eh"
 #includ=
e "dco=2Eh"
 #include "reflect_filter=2Eh"
+#include "acc=2Eh"
 
 /*#define=
 MULTI_DEBUG_EVENT_LOOP*/
 
@@ -4085,6 +4086,26 @@
     }
 }
 
+static cons=
t char *
+calculate_app_control_extra(struct multi_instance *mi, struct gc_=
arena *gc)
+{
+    struct context *c =3D &mi->context;
+    struct tls_mult=
i *multi =3D c->c2=2Etls_multi;
+
+    if (!multi->acc_negotiated_protocols=
)
+    {
+        msg(M_CLIENT, "ACC: No negotiated protocols");
+        r=
eturn NULL;
+    }
+
+    struct buffer buf =3D alloc_buf_gc(1024, gc);
+
+=
    buf_printf(&buf, "ACC:%d A:6 %s", multi->acc_max_message_length,
+     =
          multi->acc_negotiated_protocols);
+    return buf_str(&buf);
+}
+=

+
 static bool
 management_client_pending_auth(void *arg, const unsigned l=
ong cid, const unsigned int mda_key_id,
                                con=
st char *extra, unsigned int timeout)
@@ -4095,10 +4116,22 @@
     if (mi)
=
     {
         struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+=

+        struct gc_arena gc =3D gc_new();
+        if (!strcmp(extra, "ACC=
"))
+        {
+            extra =3D calculate_app_control_extra(mi, &gc);=

+            if (!extra)
+            {
+                gc_free(&gc);
+  =
              return false;
+            }
+        }
         struct tls_s=
ession *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);
 
    =
     if (!session)
         {
+            gc_free(&gc);
             retur=
n false;
         }
 
@@ -4106,6 +4139,7 @@
         bool ret =3D send_auth=
_pending_messages(multi, session, extra, timeout);
         reschedule_mult=
i_process(&mi->context);
         multi_schedule_context_wakeup(m, mi);
+  =
      gc_free(&gc);
         return ret;
     }
     return false;
@@ -4149=
,6 +4183,37 @@
     return ret;
 }
 
+
+static bool
+management_client_acc_=
msg(void *arg,
+                          const unsigned long cid,
+       =
                   const unsigned int mda_key_id,
+                        =
  struct buffer_list *input) /* ownership transferred */
+{
+    struct mul=
ti_context *m =3D (struct multi_context *)arg;
+    struct multi_instance *=
mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+    if (mi && buf=
fer_list_defined(input))
+    {
+        struct tls_multi *multi =3D mi->co=
ntext=2Ec2=2Etls_multi;
+        struct tls_session *session =3D lookup_ses=
sion_by_mda_key_id(multi, mda_key_id);
+        if (!session)
+        {
+ =
           msg(M_CLIENT, "client session not found");
+            buffer_l=
ist_free(input);
+            return false;
+        }
+
+        ret =3D m=
anagement_send_acc_message(&mi->context, multi, session, input);
+        m=
ulti_schedule_context_wakeup(m, mi);
+    }
+
+    buffer_list_free(input);=

+    return ret;
+}
+
+
 static char *
 management_get_peer_info(void *arg=
, const unsigned long cid)
 {
@@ -4185,6 +4250,7 @@
         cb=2En_clients=
 =3D management_callback_n_clients;
         cb=2Ekill_by_cid =3D managemen=
t_kill_by_cid;
         cb=2Eclient_auth =3D management_client_auth;
+     =
   cb=2Eclient_acc_msg =3D management_client_acc_msg;
         cb=2Eclient_=
pending_auth =3D management_client_pending_auth;
         cb=2Eget_peer_inf=
o =3D management_get_peer_info;
         cb=2Epush_update_broadcast =3D man=
agement_callback_send_push_update_broadcast;
diff --git a/src/openvpn/optio=
ns=2Ec b/src/openvpn/options=2Ec
index fb319ae=2E=2Ea5e7396 100644
--- a/sr=
c/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @@
 
 #i=
nclude "syshead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #include=
 "error=2Eh"
 #include "common=2Eh"
@@ -2552,6 +2553,8 @@
     o->push_opti=
on_types_found =3D 0;
     o->push_update_options_found =3D 0;
     o->impo=
rted_protocol_flags =3D 0;
+    o->pushed_acc_max_message_length =3D 0;
+  =
  o->pushed_acc_negotiated_protocols =3D NULL;
 }
 
 static void
@@ -7107,6=
 +7110,47 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->f=
orce_key_material_export =3D true;
     }
+    else if (streq(p[0], "app-cu=
stom-control") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GE=
NERAL);
+        if (!string_class(p[1], CC_ALNUM | CC_COLON | CC_UNDERBAR =
| CC_DASH, 0))
+        {
+            msg(msglevel, "App custom control pr=
otocols must only contain "
+                          "alphanumeric charac=
ters, '-', and '_'=2E");
+            goto err;
+        }
+        options=
->acc_protocols =3D p[1];
+    }
+    else if (streq(p[0], "custom-control"=
) && p[1] && p[2] && p[3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P=
_ACC);
+
+        /* check if the list from the server is a real subset of =
our list */
+        struct gc_arena gc_local =3D gc_new();
+        struct=
 buffer common_list =3D get_list_intersection(&gc_local, p[3], options->acc=
_protocols);
+
+        if (buf_len(&common_list) =3D=3D 0 || !streq(p[3], =
buf_cstr(&common_list)))
+        {
+            msg(msglevel, "App custom =
control list from server contains "
+                          "unsupported=
 protocols");
+            gc_free(&gc_local);
+            goto err;
+    =
    }
+        gc_free(&gc_local);
+
+        if (!streq(p[2], "6:A") && !s=
treq(p[2], "A:6"))
+        {
+            msg(msglevel, "App custom contro=
l encoding must be base64 and ascii");
+            goto err;
+        }
+
=
+        if (!atoi_constrained(p[1], &options->pushed_acc_max_message_lengt=
h,
+                              "app custom message message length", ACC_=
MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        {
+            goto err;
=
+        }
+        options->pushed_acc_negotiated_protocols =3D p[3];
+   =
 }
     else if (streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(=
M_WARN, "NOTICE: --prng option ignored (SSL library PRNG is used)");
diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 6a3bf61=2E=
=2Eb7945e0 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=
=2Eh
@@ -715,6 +715,18 @@
     /* force using TLS key material export for d=
ata channel key generation */
     bool force_key_material_export;
 
+    /=
** The app custom control protocols we should announce as supported */
+   =
 const char *acc_protocols;
+
+    /** the protocols that are negotiated wi=
th the peer=2E This is a
+     *  a temporary variable since options=2Ec pu=
sh parser cannot access
+     *  tls multi struct */
+    const char *pushe=
d_acc_negotiated_protocols;
+
+    /** the maximum length of an ACC control=
 channel message via push message
+     * */
+    int pushed_acc_max_messag=
e_length;
+
     bool vlan_tagging;
     enum vlan_acceptable_frames vlan_a=
ccept;
     uint16_t vlan_pvid;
@@ -764,8 +776,10 @@
 #define OPT_P_INLINE =
         (1u << 29)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_=
P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC             (1ull << 32)
 
=
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID =
| 0x0ull))
+/* Options allowed in the normal configuration file (vs pushed =
options or in ccd files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_=
P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((op=
t)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index =
42259c3=2E=2Ea18f33b 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/pu=
sh=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh"
+
+=
#include "acc=2Eh"
 #include "options=2Eh"
 #include "crypto=2Eh"
 #include=
 "ssl=2Eh"
@@ -221,9 +223,56 @@
 #endif
 }
 
+static void
+parse_server_pus=
hed_info_acc(struct context *c, struct buffer *buf)
+{
+    int max_acc_len=
 =3D 0;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (mult=
i->acc_negotiated_protocols)
+    {
+        return;
+    }
+
+    if (!mul=
ti->opt=2Eacc_protocols || !c->options=2Epull)
+    {
+        msg(D_PUSH_E=
RRORS, "Peer tried to push app custom control list "
+                     =
      "without client announcing support for it");
+        return;
+    }
=
+
+    /* example string to parse: ACC:1400 A:6 flower:happy */
+    /* Ski=
p over the ACC: prefix */
+    buf_advance(buf, 4);
+
+    struct gc_arena =
gc =3D gc_new();
+    const char *protocols =3D parse_acc_parameters(buf_cs=
tr(buf), " ", &max_acc_len, false, &gc);
+    if (!protocols)
+    {
+     =
   msg(D_PUSH_ERRORS, "WARNING: Received ACC info command with invalid para=
meters");
+        gc_free(&gc);
+        return;
+    }
+
+    /* check if=
 the list from the server is a real subset of our list */
+    struct buffe=
r common_list =3D get_list_intersection(&gc, protocols, multi->opt=2Eacc_pr=
otocols);
+
+    if (buf_len(&common_list) =3D=3D 0 || !streq(protocols, bu=
f_cstr(&common_list)))
+    {
+        msg(D_PUSH_ERRORS, "App custom contr=
ol list from server contains "
+                           "unsupported pro=
tocols");
+        gc_free(&gc);
+        return;
+    }
+
+    multi->acc_=
negotiated_protocols =3D string_alloc(protocols, NULL);
+    multi->acc_max=
_message_length =3D max_acc_len;
+    notify_client_acc_protocols(multi);
+=
    gc_free(&gc);
+}
 
 void
-server_pushed_info(const struct buffer *buffe=
r, const int adv)
+peer_pushed_info(struct context *c, const struct buffer =
*buffer, const int adv)
 {
     const char *m =3D "";
     struct buffer bu=
f =3D *buffer;
@@ -233,6 +282,12 @@
         m =3D BSTR(&buf);
     }
 
+  =
  if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        parse_server_pushed_i=
nfo_acc(c, &buf);
+        return;
+    }
+
 #ifdef ENABLE_MANAGEMENT
     =
struct gc_arena gc;
     if (management)
@@ -257,7 +312,7 @@
         gc_fr=
ee(&gc);
     }
 #endif
-    msg(D_PUSH, "Info command was pushed by server=
 ('%s')", m);
+    msg(D_PUSH, "Info command was pushed by peer ('%s')", m)=
;
 }
 
 void
@@ -285,6 +340,7 @@
     msg(D_PUSH, "CR response was sent by =
client ('%s')", m);
 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING =
request
  * @param buffer                buffer containing the keywords, th=
e buffer's
@@ -441,7 +497,6 @@
     const char *const peer_info =3D tls_mul=
ti->peer_info;
     unsigned int proto =3D extract_iv_proto(peer_info);
 
-=

     /* Calculate the maximum timeout and subtract the time we already wai=
ted */
     unsigned int max_timeout =3D
         max_uint(tls_multi->opt=
=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake_window);
@@ -732,6 +=
787,12 @@
                 client_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu=
);
         }
     }
+
+    if (tls_multi->acc_negotiated_protocols)
+    {=

+        push_option_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s=
",
+                        tls_multi->acc_max_message_length, tls_multi->a=
cc_negotiated_protocols);
+    }
 }
 
 static bool
diff --git a/src/openvpn=
/push=2Eh b/src/openvpn/push=2Eh
index 39302f6=2E=2Ee08cd66 100644
--- a/sr=
c/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int proc=
ess_incoming_push_request(struct context *c);
 
+
 /**
  * @brief Handles t=
he receiving of a push-update message and applies updates to the specified
=
  * options=2E
@@ -92,7 +93,15 @@
 
 void receive_exit_message(struct conte=
xt *c);
 
-void server_pushed_info(const struct buffer *buffer, const int a=
dv);
+/**
+ * This message is called when an INFO or INFO_PRE message is re=
ceived from
+ * a peer=2E
+ *
+ * @param c         Context of the peer=2E
+=
 * @param buffer    Buffer containing the INFO/INFO_PRE message=2E
+ * @par=
am adv       number of character to advance past the INFO/INFO_PRE header
+=
 */
+void peer_pushed_info(struct context *c, const struct buffer *buffer, =
const int adv);
 
 void receive_cr_response(struct context *c, const struct=
 buffer *buffer);
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
=
index 086a6fc=2E=2E97ef9b0 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openv=
pn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include "ssl=
=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_backend=
=2Eh"
 #include "ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
     free(multi->locked=
_cn);
     free(multi->locked_username);
     free(multi->locked_original_u=
sername);
+    free(multi->acc_negotiated_protocols);
 
     cert_hash_free=
(multi->locked_cert_hash_set);
 
@@ -2098,6 +2100,11 @@
 #endif
         }
=
 
+        if (session->opt->acc_protocols)
+        {
+            buf_pri=
ntf(&out, "IV_ACC=3D%d,A:6,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protoc=
ols);
+        }
+
         if (session->opt->push_peer_info_detail > 1)
  =
       {
             struct env_set *es =3D session->opt->es;
@@ -2398,6 +=
2405,8 @@
         multi->remote_ciphername =3D string_alloc("none", NULL);=

     }
 
+    determine_common_acc_protocols(multi, session);
+
     if (u=
sername_len < 0 || password_len < 0)
     {
         msg(D_TLS_ERRORS, "TLS=
 Error: Username (%d) or password (%d) too long", abs(username_len),
diff -=
-git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9a55ea=
d=2E=2E436770b 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ss=
l_common=2Eh
@@ -457,6 +457,9 @@
     size_t ekm_size;
 
     bool dco_enab=
led; /**< Whether keys have to be installed in DCO or not */
+
+    /** The=
 app custom control protocols we should announce as supported */
+    const=
 char *acc_protocols;
 };
 
 /** @addtogroup control_processor
@@ -730,6 +7=
33,12 @@
     int dco_peer_id;
 
     dco_context_t *dco;
+
+    /** the pr=
otocols that are negotiated with the peer=2E */
+    char *acc_negotiated_p=
rotocols;
+
+    /** the maximum length of an ACC control channel message *=
/
+    int acc_max_message_length;
 };
 
 /**  gets an item  of \c key_stat=
e objects in the
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E6a73e1e 100644
--- a/=
tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makef=
ile=2Eam
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D =
@TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ss=
l=2Ec \
+	test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_comm=
on=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_exe=
cve=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/s=
rc/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)=
/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -132,=
6 +134,7 @@
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/s=
rc/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
=
+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_u=
til=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcd=
ir)/src/openvpn/ssl_verify_openssl=2Ec \
diff --git a/tests/unit_tests/open=
vpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
inde=
x fff4c2b=2E=2Ef572dbb 100644
--- a/tests/unit_tests/openvpn/mock_managemen=
t=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
=
 
 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 =

 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/unit_tests/openvpn/mock_push_=
dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
inde=
x bf2ccf3=2E=2Ef083f89 100644
--- a/tests/unit_tests/openvpn/mock_push_depe=
ndencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -=
43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P=
_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SHA=
PER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      | OPT_=
P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-        =
             | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | O=
PT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUS=
H_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
    =
 return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/te=
sts/unit_tests/openvpn/test_acc=2Ec
new file mode 100644
index 0000000=2E=
=2E9364d12
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,=
0 +1,353 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networ=
ks
+ *             over a single TCP/UDP port, with support for SSL/TLS-bas=
ed
+ *             session authentication and key exchange,
+ *            =
 packet encryption, packet authentication, and
+ *             packet compr=
ession=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *=
  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This pr=
ogram is free software; you can redistribute it and/or modify
+ *  it under=
 the terms of the GNU General Public License version 2
+ *  as published by=
 the Free Software Foundation=2E
+ *
+ *  This program is distributed in th=
e hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even =
the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+=
 *  You should have received a copy of the GNU General Public License along=

+ *  with this program; if not, write to the Free Software Foundation, Inc=
=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ *=
/
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshe=
ad=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2E=
h>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+=
#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include "test_common=2Eh"
+
+=
#include "mock_msg=2Eh"
+#include "multi=2Eh"
+
+char control_channel_messa=
ge_sent[2048];
+
+/* Mock functions */
+bool
+send_control_channel_string_d=
owork(struct tls_session *session,
+                                   cons=
t char *str, unsigned int msglevel)
+{
+    assert_int_in_range(strlen(str)=
, 0, 2047);
+
+    strcpy(control_channel_message_sent, str);
+    return t=
rue;
+}
+
+void
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
=
+
+void
+auth_set_client_reason(struct tls_multi *multi, const char *reason=
)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"   =
             \
+                    "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z=
/notFT0cF1d60nTS" \
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqM=
yqwCvALwCewCTAKABrwCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8=
BAAEAAAsABAMAAQIACgAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMB=
BAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoIC=
wgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAA=
IBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwity=
P9eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_messages(void **state)
+{=

+#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    /* ensure that the mes=
sages get to mock_msg */
+    x_debug_level =3D 3;
+    management =3D (voi=
d *)0x12345678;
+    struct gc_arena gc =3D gc_new();
+
+    /* contains a =
TLS 1=2E3 ClientHello */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PA=
YLOAD;
+
+    struct buffer msg_buf;
+    struct context c =3D { 0 };
+    =
c=2Eoptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_=
multi, struct tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE=
]=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_A=
CTIVE]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg=
_buf, (void *)msg, sizeof(msg));
+
+    receive_acc_message(&c, &msg_buf);
=
+    assert_string_equal(mock_msg_buf, "WARNING: Received malformed custom =
app control channel message (ACC not enabled or no negotiated protocols): 4=
143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=
=2E=2E=2E]");
+    assert_string_equal(mock_managment_buf, "");
+
+    c=2E=
c2=2Etls_multi->acc_negotiated_protocols =3D "no:common:protocol";
+    rec=
eive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "WAR=
NING: Received malformed custom app control channel message (protocol 'cck1=
' not in list of negotiated protocols 'no:common:protocol'): 4143432c 63636=
b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]");
=
+    assert_string_equal(mock_managment_buf, "");
+
+    c=2Ec2=2Etls_multi=
->acc_negotiated_protocols =3D "cck1:flower:power:fortune";
+    receive_ac=
c_message(&c, &msg_buf);
+
+    assert_string_equal(mock_msg_buf, "Received=
 custom app control message (protocol 'cck1')");
+    assert_string_equal(m=
ock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLOAD);
+
+    const cha=
r flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJ=
vZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower_msg, sizeof(flow=
er_msg));
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(=
mock_msg_buf, "Received custom app control message (protocol 'flower')");
+=
    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,flower,0,SSBhb=
SAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+    CLEAR(mock_managm=
ent_buf);
+    const char msg_incorrect_len[] =3D "ACC,fortune,62,6,InsgIm1=
lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D";
+    buf_se=
t_read(&msg_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));
+  =
  receive_acc_message(&c, &msg_buf);
+    const char *error =3D "WARNING: R=
eceived malformed custom app control channel "
+                        "me=
ssage (field length 62, payload length 64 mismatch): "
+                   =
     "4143432c 666f7274 756e652c 36322c36 2c496e73 67496d31 "
+            =
            "6c496a6f 67496d5[more=2E=2E=2E]";
+
+    assert_string_equal(m=
ock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+ =
   CLEAR(mock_managment_buf);
+    const char msg_fragment[] =3D "ACC,power=
,12,6F,aGVsbG8gdw=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_fragment,=
 sizeof(msg_fragment));
+    receive_acc_message(&c, &msg_buf);
+    assert=
_string_equal(mock_msg_buf, "Received custom app control message (protocol =
'power', fragment)");
+    assert_string_equal(mock_managment_buf, ">CLIENT=
:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+   =
 /* check two encoding present */
+    const char flower_msg_two_encs[] =3D=
 "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+=
    buf_set_read(&msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_t=
wo_encs));
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNIN=
G: Received malformed custom app control channel message "
+            "(n=
umber of encodings must be exactly one (B64=3D1, ASCII=3D1)): "
+          =
  "4143432c 666c6f77 65722c34 382c3641 2c535342 68625341 41494574 "
+      =
      "6c636d3[more=2E=2E=2E]";
+
+    assert_string_equal(mock_msg_buf, er=
ror);
+    assert_string_equal(mock_managment_buf, "");
+
+    /* no encodi=
ng present */
+    const char flower_msg_no_encs[] =3D "ACC,flower,48,,SSBh=
bSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_b=
uf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_a=
cc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Received malformed cus=
tom app control channel message "
+            "(number of encodings must b=
e exactly one (B64=3D0, ASCII=3D0)): "
+            "4143432c 666c6f77 6572=
2c34 382c2c53 53426862 53414149 45746c63 "
+            "6d31706[more=2E=2E=
=2E]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_string_eq=
ual(mock_managment_buf, "");
+
+    x_debug_level =3D 0;
+    management =
=3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc_parameters(=
void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    /* parameters t=
o INFO message */
+    const char *info_acc_msg =3D "4096 A:6 flower:happy"=
;
+
+    int max_len =3D 0;
+    const char *protocols =3D parse_acc_parame=
ters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(prot=
ocols, "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+    /* a c=
lient does not accept a length longer than it supports */
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    ass=
ert_null(protocols);
+
+    /* message with lower limit than our, should wo=
rk for client and server */
+    info_acc_msg =3D "1111 A:6 flower:happy";
=
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false,=
 &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int=
_equal(max_len, 1111);
+
+    protocols =3D parse_acc_parameters(info_acc_m=
sg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:=
happy");
+    assert_int_equal(max_len, 1111);
+
+    /* more encodings tha=
n supported=2E Server should be okay, client should fail */
+    info_acc_m=
sg =3D "1200 A:6:B flower:happy";
+    protocols =3D parse_acc_parameters(i=
nfo_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+  =
  protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc=
);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equ=
al(max_len, 1200);
+
+    /* extra parameter */
+    info_acc_msg =3D "1400=
 A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg=
, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    ass=
ert_null(protocols);
+
+
+    const char *iv_acc_capabilities =3D "1400,A:6=
,flower:happy:power";
+    protocols =3D parse_acc_parameters(iv_acc_capabi=
lities, ",", &max_len, true, &gc);
+    assert_string_equal(protocols, "flo=
wer:happy:power");
+
+    /* too small protocol length */
+    info_acc_msg=
 =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_ac=
c_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* no=
n-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flower:happy=
";
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, tru=
e, &gc);
+    assert_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test=
_acc_common_protocols(void **state)
+{
+    struct multi_instance mi =3D { =
0 };
+    struct context *c =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_=
new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c->o=
ptions=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_=
ACC=3D1400,A:6,flower:happy:power";
+    c->options=2Eacc_protocols =3D "po=
wer:flower:star";
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    =
multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+    multi->sess=
ion[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2Ees =3D env_set_crea=
te(&c->options=2Egc);
+
+    determine_common_acc_protocols(multi, &c->c2=
=2Etls_multi->session[TM_ACTIVE]);
+
+    assert_int_equal(multi->acc_max_m=
essage_length, ACC_MAX_MSG_LEN);
+    assert_string_equal(multi->acc_negoti=
ated_protocols, "power:flower");
+
+    assert_string_equal(env_set_get(mul=
ti->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flower");
+    asser=
t_string_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), "acc_messag=
e_len=3D1280");
+
+    free(multi->acc_negotiated_protocols);
+    gc_free(=
&c->options=2Egc);
+}
+
+void
+test_acc_send_message(void **state)
+{
+    =
struct multi_instance mi =3D { 0 };
+    struct context *c =3D &mi=2Econtex=
t;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls=
_multi, struct tls_multi, &c->options=2Egc);
+    bool ret;
+    struct tls=
_multi *multi =3D c->c2=2Etls_multi;
+    c->options=2Eacc_protocols =3D "p=
ower:flower:emergency";
+    multi->opt=2Eacc_protocols =3D c->options=2Eac=
c_protocols;
+    multi->session[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    mul=
ti->opt=2Ees =3D env_set_create(&c->options=2Egc);
+
+    c->c2=2Etls_multi=
->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power"=
;
+    determine_common_acc_protocols(multi, &c->c2=2Etls_multi->session[TM=
_ACTIVE]);
+
+    struct tls_session *session =3D &c->c2=2Etls_multi->sessi=
on[TM_ACTIVE];
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, sessio=
n, "emergency", true,
+                           "EMERGENCY BROADCAST MESS=
AGE - THIS IS NOT A DRILL:", false);
+
+    assert_true(ret);
+    assert_s=
tring_equal(control_channel_message_sent,
+                        "ACC,eme=
rgency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:");
+
+    r=
et =3D send_acc_message(c, c->c2=2Etls_multi, session, "emergency", false,
=
+                           "THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED A=
LERT FOR YOUR AREA=2E", false);
+    assert_true(ret);
+    assert_string_e=
qual(control_channel_message_sent,
+                        "ACC,emergency,=
65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E");=

+
+
+    /* test a long message (> 1000) with fragment to get the maximum =
header size */
+    char long_message[1200] =3D { 0 };
+
+    for (int i =
=3D 0; i < 1024; i++)
+    {
+        long_message[i] =3D (char)(' ' + (i %=
 95));
+    }
+
+    /* last char of the message is a i and then a \0 */
+ =
   assert_int_equal(long_message[1023], 'i');
+    assert_int_equal(long_me=
ssage[1024], '\0');
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, s=
ession, "emergency", true,
+                           long_message, false)=
;
+
+    assert_true(ret);
+    size_t cc_len =3D strlen(control_channel_me=
ssage_sent);
+    assert_int_equal(control_channel_message_sent[cc_len - 1]=
, 'i');
+    const char *expected_start_cc =3D "ACC,emergency,1024,AF, !\"#=
$%&'()*+,-=2E/012345";
+    assert_memory_equal(control_channel_message_sen=
t, expected_start_cc, strlen(expected_start_cc));
+
+    free(multi->acc_ne=
gotiated_protocols);
+    gc_free(&c->options=2Egc);
+}
+
+void
+test_list_=
intersection(void **state)
+{
+    const char *empty =3D "";
+    const cha=
r *protos =3D "power:flower:emergency";
+
+    struct gc_arena gc =3D gc_ne=
w();
+
+    struct buffer t1 =3D get_list_intersection(&gc, empty, protos);=

+    assert_int_equal(buf_len(&t1), 0);
+
+    struct buffer t2 =3D get_li=
st_intersection(&gc, protos, empty);
+    assert_int_equal(buf_len(&t2), 0)=
;
+
+    struct buffer t3 =3D get_list_intersection(&gc, protos, protos);
+=
    assert_string_equal(buf_cstr(&t3), protos);
+
+    const char *protos2 =
=3D "flower:emergency:power:mario";
+    struct buffer t4 =3D get_list_inte=
rsection(&gc, protos2, protos);
+    assert_string_equal(buf_cstr(&t4), "fl=
ower:emergency:power");
+
+    const char *protos3 =3D "super:paper:mario:f=
lower";
+    struct buffer t5 =3D get_list_intersection(&gc, protos2, proto=
s3);
+    assert_string_equal(buf_cstr(&t5), "flower:mario");
+
+    const =
char *proto4 =3D "flower:flower:flower:flower";
+    struct buffer t6 =3D g=
et_list_intersection(&gc, proto4, "flower");
+    assert_string_equal(buf_c=
str(&t6), "flower");
+
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_test=
s/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh
new file mod=
e 100644
index 0000000=2E=2E32421fb
--- /dev/null
+++ b/tests/unit_tests/op=
envpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An application to s=
ecurely tunnel IP networks
+ *             over a single UDP port, with sup=
port for SSL/TLS-based
+ *             session authentication and key excha=
nge,
+ *             packet encryption, packet authentication, and
+ *     =
        packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc =
<sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redis=
tribute it and/or modify
+ *  it under the terms of the GNU General Public =
License version 2
+ *  as published by the Free Software Foundation=2E
+ *
=
+ *  This program is distributed in the hope that it will be useful,
+ *  b=
ut WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Pu=
blic License for more details=2E
+ *
+ *  You should have received a copy o=
f the GNU General Public License along
+ *  with this program; if not, see =
<https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+
+#ifndef TEST_ACC_H
+#defin=
e TEST_ACC_H
+void test_acc_parse_client_messages(void **state);
+
+void te=
st_parse_acc_parameters(void **state);
+
+void test_acc_common_protocols(vo=
id **state);
+
+void test_acc_send_message(void **state);
+
+void test_list=
_intersection(void **state);
+#endif
diff --git a/tests/unit_tests/openvpn/=
test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh
index 8db4ea6=2E=
=2Ec865142 100644
--- a/tests/unit_tests/openvpn/test_common=2Eh
+++ b/test=
s/unit_tests/openvpn/test_common=2Eh
@@ -43,11 +43,13 @@
 #define LargestIn=
tegralType uintmax_t
 #endif
 /* redefine 2=2Ex API in terms of 1=2Ex API *=
/
-#define CMockaValueData             LargestIntegralType
-#define check_e=
xpected_uint         check_expected
-#define expect_uint_value           ex=
pect_value
-#define expect_check_data           expect_check
-#define cast_=
ptr_to_cmocka_value(x) (x)
+#define CMockaValueData                       L=
argestIntegralType
+#define check_expected_uint                   check_exp=
ected
+#define expect_uint_value                     expect_value
+#define =
expect_check_data                     expect_check
+#define cast_ptr_to_cmo=
cka_value(x)           (x)
+#define assert_int_in_range(value, min, max)  a=
ssert_in_range((value), (min), (max))
+#define assert_uint_in_range(value, =
min, max) assert_in_range((value), (min), (max))
 #endif
 
 /**
diff --git =
a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=
=2Ec
index 4baf8cc=2E=2E4987dd0 100644
--- a/tests/unit_tests/openvpn/test_=
ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52,6 +52,8 @@
 #inc=
lude "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include "test_acc=2Eh"
+
=
 /* Mock function to be allowed to include win32=2Ec which is required for
=
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6 +88,20 @@
 {
    =
 return;
 }
+void
+reschedule_multi_process(struct context *c)
+{
+}
+
+/* =
Define a dummy dco cipher option to avoid linking against all the DCO
+ * u=
nits */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported_ciphers(v=
oid)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA=
20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl req -x509 -newke=
y ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -1111,8 +1127,12 @=
@
         cmocka_unit_test(ssl_test_extract_last_matching_field),
        =
 cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
         cmocka_un=
it_test(ssl_test_escape_rfc_2253_chars_in_subject),
-        cmocka_unit_te=
st(ssl_test_extract_peer_info)
-
+        cmocka_unit_test(ssl_test_extract=
_peer_info),
+        cmocka_unit_test(test_acc_parse_client_messages),
+  =
      cmocka_unit_test(test_parse_acc_parameters),
+        cmocka_unit_tes=
t(test_acc_common_protocols),
+        cmocka_unit_test(test_acc_send_messa=
ge),
+        cmocka_unit_test(test_list_intersection)
     };
 
 #if defin=
ed(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail fil=
ters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: =
1858
Gerrit-PatchSet: 25
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: ch=
ugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@open=
vpn=2Ecom>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--Z1EQSURmR40=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
, chugly=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #25</strong> to=
 this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858?usp=3Demail">View Change</a></p><p>The following approvals got outdat=
ed and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>Implement sending/receiving app custom control protocol messages<br><br>Th=
is allows openvpn GUI/front-ends and server via management<br>to use the Op=
enVPN control channel to pass messages between each other<br>while OpenVPN =
handles the marshalling/unmarshalling of these and<br>negotiate the common =
app custom control protocols=2E<br><br>This provides an easy to use secure =
channel that does not depend on<br>the network itself to work and can also =
be used before fully<br>authenticating the client=2E See the management-not=
es=2Etxt for more<br>details how to use this feature=2E An upcoming patch w=
ill also add<br>some example python scripts that showcase this feature=2E<b=
r><br>Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by=
: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M=
 doc/man-sections/client-options=2Erst<br>M doc/man-sections/management-opt=
ions=2Erst<br>M doc/man-sections/script-options=2Erst<br>M doc/management-n=
otes=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src=
/openvpn/acc=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>=
M src/openvpn/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=
=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/ope=
nvpn/push=2Ec<br>M src/openvpn/push=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/o=
penvpn/ssl_common=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M test=
s/unit_tests/openvpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/mock=
_push_dependencies=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A test=
s/unit_tests/openvpn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_common=
=2Eh<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>26 files changed, 1,547 =
insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/25</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 184a95a=2E=
=2E4deabe7 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>++=
+ b/CMakeLists=2Etxt</span><br><span>@@ -435,6 +435,8 @@</span><br><span>  =
   src/compat/compat-strlcpy=2Ec</span><br><span>     src/compat/compat-str=
sep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</span><=
br><span>     src/openvpn/argv=2Ec</span><br><span>     src/openvpn/argv=2E=
h</span><br><span>     src/openvpn/base64=2Ec</span><br><span>@@ -826,6 +82=
8,8 @@</span><br><span>             tests/unit_tests/openvpn/mock_managemen=
t=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_ssl_depend=
encies=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_win32=
_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    tests/unit_tests/openvpn/test_acc=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            src/openvpn/acc=2Ec</span><br><span>     =
        src/openvpn/argv=2Ec</span><br><span>             src/openvpn/base6=
4=2Ec</span><br><span>             src/openvpn/crypto_epoch=2Ec</span><br><=
span>@@ -842,6 +846,7 @@</span><br><span>             src/openvpn/packet_id=
=2Ec</span><br><span>             src/openvpn/run_command=2Ec</span><br><sp=
an>             src/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            src/openvpn/ssl_ncp=2Ec</span><br><span=
>             src/openvpn/ssl_openssl=2Ec</span><br><span>             src/=
openvpn/ssl_util=2Ec</span><br><span>             src/openvpn/ssl_verify_mb=
edtls=2Ec</span><br><span>diff --git a/doc/man-sections/client-options=2Ers=
t b/doc/man-sections/client-options=2Erst</span><br><span>index 87c138a=2E=
=2E16309f9 100644</span><br><span>--- a/doc/man-sections/client-options=2Er=
st</span><br><span>+++ b/doc/man-sections/client-options=2Erst</span><br><s=
pan>@@ -437,6 +437,12 @@</span><br><span>         Additional authentication=
 methods supported by the client=2E</span><br><span>         This may be se=
t by the client UI/GUI using ``--setenv``=2E</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  :code:`IV_ACC=3D&lt;max_msg_le=
n&gt;,&lt;flags&gt;,&lt;protocols&gt;`</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        If the option ``--app-custom-control`` is set, t=
he client will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   send the supported max ACC message length, the supported formats</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        as (:code:`A:6`) an=
d the list of configured protocols (e=2Eg=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        :code:`flower:happy:power`)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The following =
flags depend on which compression formats are compiled in</span><br><span> =
  and whether compression is allowed by options=2E See `Protocol options`_<=
/span><br><span>   for more details=2E</span><br><span>diff --git a/doc/man=
-sections/management-options=2Erst b/doc/man-sections/management-options=2E=
rst</span><br><span>index 2c79d05=2E=2E315e567 100644</span><br><span>--- a=
/doc/man-sections/management-options=2Erst</span><br><span>+++ b/doc/man-se=
ctions/management-options=2Erst</span><br><span>@@ -144,3 +144,17 @@</span>=
<br><span> </span><br><span> --management-up-down</span><br><span>   Report=
 tunnel up/down events to management interface=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+--app-custom-control protocol-list</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  Sets the list of supported app custom control p=
rotocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  These =
protocols are announced to the server via the IV_ACC peer info</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  variable when this option is u=
sed on a client=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 If the option is set on a server it will negotiate common protocols</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  with the client=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  The protocol-list is a : separated list of=
 protocol identifiers=2E Protocol</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  identifiers must consist of alphanumeric characters, :code:=
`-`, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`_`=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  See management-notes=2Etxt in the=
 OpenVPN distribution and the OpenVPN RFC</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  draft for a description of app custom control proto=
col support=2E</span><br><span>diff --git a/doc/man-sections/script-options=
=2Erst b/doc/man-sections/script-options=2Erst</span><br><span>index f42038=
0f=2E=2E474c7fd 100644</span><br><span>--- a/doc/man-sections/script-option=
s=2Erst</span><br><span>+++ b/doc/man-sections/script-options=2Erst</span><=
br><span>@@ -1006,3 +1006,12 @@</span><br><span>        X509_1_L=3DBISHKEK<=
/span><br><span>        X509_1_ST=3DNA</span><br><span>        X509_1_C=3DK=
G</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+:code:`acc_protocols`</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    If ``--app-custom-control`` is =
configured and the client supports any of the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    protocols that server also supports, this var=
iable contains a list of</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    common protocols separated by :=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+:code:`acc_message_len`</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if :code:`acc_protocols` is set, this variable contains the ma=
ximum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    message le=
ngth for app custom protocol message=2E</span><br><span>diff --git a/doc/ma=
nagement-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 4d7=
26c4=2E=2E3f12c83 100644</span><br><span>--- a/doc/management-notes=2Etxt</=
span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -828,6 +=
828,59 @@</span><br><span> that is required to continue the connection (unl=
ike MFA or opening a browser)</span><br><span> this message is not negotiat=
ed but can just be sent as a gratuitous message=2E</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+app custom control</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+If the special string &quot;ACC&quot; is passed as {EXTRA} OpenVPN =
will determine</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the c=
ommon app custom protocols between the client and the server and instruct</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+the client that the s=
erver will send control messages to the client using</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+the ACC protocol=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+The server should then use client-acc-msg command to send ap=
p custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+control mes=
sages to the client to facilitate the pending authentication=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+------------------=
-------------------------------</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+On an O=
penVPN instance running in server mode this command sends an</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+app custom control message to a cl=
ient=2E The format of the command is:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 client-acc-msg {CID} {KID}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  {flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {messag=
e}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+CID,KID -- client ID and Key ID=2E See documentati=
on for &quot;&gt;CLIENT:&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+notification for more info=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+protocol -- the ACC protocol identifier that this message should be</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            tagged with=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+flags    -- a concatenation of lett=
ers for the encoding (&#39;A&#39; or &#39;6&#39;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            and the lette &#39;F&#39; if the =
message is a fragment=2E E=2Eg=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &quot;6F&quot; for a base64 encoded message that =
is also a fragment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           and not complete yet=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mess=
age  -- The message encoded in the encoding specified in flags</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+------------------------------------------</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+When OpenVPN is running in --client mode =
this command sends an app</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+custom command to the server=2E The format of the command is</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  acc-msg</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  {message}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+See the client-acc-msg command for more =
details about the format of the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+message=2E Since a client has only one peer there is no need to=
 specify the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+client =
id and key id=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMM=
AND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br><span> ------------=
-----------------------------------</span><br><span> </span><br><span>@@ -1=
302,6 +1355,52 @@</span><br><span>    response=2E Mechanisms that need mult=
iple rounds or more complex answers</span><br><span>    should implement a =
different response type than CR_RESPONSE=2E</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+(6) App custom control message</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    This message is an application specif=
ic payload message that is transported</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    over the OpenVPN control channel=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    In server mode:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    &gt;CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    In client mode:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &gt;ACC:{protocol},{fragment},{msg_base64}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    The protocol is a short ascii string identifying the a=
pp specific custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocol=2E If fragment is set to 1, the message is not complete and the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    next message sh=
ould be concatenated to this message to form a complete</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    message=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    Note that the OpenVPN implementation operates here with the=
 robustness</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prin=
ciple (&quot;be conservative in what you send, be liberal in what you</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    accept&quot; - RFC 79=
3 and others) and allows receiving messages longer than</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    maximum allowed message length=2E I=
mplementations should be prepared to</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    handle messages that are longer than the maximum allow=
ed message length=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN does n=
ot verify that the message is valid base64=2E A peer that</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    sends invalid base64 payload will=
 be passed to the management interface=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    An implementation should be prepared to handle in=
valid base64 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 handle accordingly (e=2Eg=2E disconnect the client via client-deny or</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ignore such messages=
)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+(7) App custom control protocol me=
ssage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+   This message informs the clien=
t about the common ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+   protocols and the maximum message length for an ACC message=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+   In client mode:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=3D{m=
ax_msg_len}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   protocol_list is the lis=
t of supported protocols by both server and client=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   For example flower:power:sys_info woul=
d indicate these three protocols</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+   are supported=2E max_msg_len specifies the maximum message =
length that the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   p=
eer supports=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+   In server mode these=
 information are available in the acc_protocols and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   acc_message_len variables of the clien=
t environment=2E</span><br><span> </span><br><span> Variables:</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/=
Makefile=2Eam</span><br><span>index 8a60a94=2E=2Eebc4db6 100644</span><br><=
span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Make=
file=2Eam</span><br><span>@@ -45,6 +45,7 @@</span><br><span> sbin_PROGRAMS =
=3D openvpn</span><br><span> </span><br><span> openvpn_SOURCES =3D \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=2Eh \</span><=
br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=2Ec auth_token=
=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><span>@@ -124,7 =
+125,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br><span> 	proxy=
=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \</span><br><sp=
an> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec reflect_filter=2Eh=
 \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br><span>diff --git=
 a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>new file mode =
100644</span><br><span>index 0000000=2E=2E455f56d</span><br><span>--- /dev/=
null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span>@@ -0,0 +1,4=
45 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application t=
o securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             over a single TCP/UDP port, with support for SSL/T=
LS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    session authentication and key exchange,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet encryption, packet authentic=
ation, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyr=
ight (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt;a=
rne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
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
  with this program; if not, write to the Free Software Foundation, Inc=2E,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Str=
eet, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+log_acc_message(struct co=
ntext *c, const struct buffer *buf, int payload_len,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                const char *protocol, int=
 flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bool fragment =3D flags &a=
mp; ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *payload_msg =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* For simplicity, we always encode p=
ayload to be base64 encoded</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * if not already in base64 format */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        char *b64out =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(openvpn_=
base64_encode(CBPTR(buf), payload_len, &amp;b64out) &gt;=3D 0);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(b64out, f=
ree, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   payload_msg =3D b64out;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D CBSTR(bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (management)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct tls_session *session =3D &amp;c-&gt;c2=2Etls_mul=
ti-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* server mode=2E Report client context */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            struct man_def_au=
th_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            unsigned int mda_key_id =3D g=
et_primary_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;CLIEN=
T:ACC,%lu,%u,%s,%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                mda-&gt;cid, mda_key_id, protocol, fragment, paylo=
ad_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* Client mode=2E Do not a=
 report a CLIENT id */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol, fragme=
nt, payload_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_M=
ANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_PUSH, &quot;Received custom app control message (protocol &#39;%s&#39;%s=
)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pro=
tocol, fragment ? &quot;, fragment&quot; : &quot;&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message_flags(const char=
 *flags, const char **err_reason, struct gc_arena *gc)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int acc_flags =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (const char *flag =3D flags; *flag !=3D &#39;\0&#39;; flag++)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (*flag =3D=3D &#39;A&#39;=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D A=
CC_MESSAGE_FLAGS_ASCII;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  else if (*flag =3D=3D &#39;6&#39;)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;F&#39;)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_M=
ESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            *err_reason =
=3D &quot;Unknown flag in flags&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return -1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* The message should be encoded with exactly one encoding=2E Ensure that=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * only one of =
the flags is present */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool asciienc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASCII);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool base64enc =
=3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (base64enc + asciienc !=3D 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &qu=
ot;number of encodings must be exactly one &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                           &quot;(B64=3D%d, A=
SCII=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
               base64enc, asciienc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        *err_reason =3D tmp;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn acc_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Wrapper around parse_acc_message_flags to also include=
 the step of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * extr=
acting the flags from the buffer and forwarding the buffer</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * beyond the flags field=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+parse_acc_message_flags_buf(struct buffer *buf, co=
nst char **err_reason, struct gc_arena *gc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *flags =3D buf_extract_field(buf, &#39;,&#39;, gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!flags)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        *err_reason =3D &quot;could not extract flags field=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return parse_acc_messag=
e_flags(flags, err_reason, gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, c=
onst struct buffer *buffer)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *err_reason =3D &quot;&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer bu=
f =3D *buffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct tls_mul=
ti *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        err_reason =3D &quot;ACC not enabled or =
no negotiated protocols&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_advance(&am=
p;buf, strlen(&quot;ACC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,&#39;)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;missi=
ng , after ACC&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* extract protocol, payload =
length, flags substrings */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *protocol =3D buf_extract_field(&amp;buf, &#39;,&#39=
;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!protocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D=
 &quot;could not extract protocol field&quot;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!tls_item_in_cipher_list(protocol, multi-&gt;acc_negotiated_protocols))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct buffer msg_buf =3D all=
oc_buf_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        buf_printf(&amp;msg_buf, &quot;protocol &#39;%s&#39; not in l=
ist of negotiated protocols &#39;%s&#39;&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                   protocol, multi-&gt;acc_nego=
tiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       err_reason =3D buf_cstr(&amp;msg_buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* We do not check the length here=2E We ma=
ke no promises to support</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * anything larger than our announced message length but accordin=
g to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the robu=
stness principle</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * (&quot;be conservative in what you send, be liberal in what you accept&=
quot; - RFC 793 and others)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * we accept also longer messages */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int payload_len;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *payload_len_str =3D buf_extract_field(&amp;buf, =
&#39;,&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!payload_len_str</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        || !atoi_constrained(payload_len_str, &amp;payload_len, &qu=
ot;acc_payload_len&quot;, 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;could not=
 extract payload length field&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags =3D =
parse_acc_message_flags_buf(&amp;buf, &amp;err_reason, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (flags &lt; 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We should have=
 a final NUL byte in the control message buffer</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * and thus the length of the buffer should=
 be payload_len + 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (buf_len(&amp;buf) !=3D payload_len + 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        char *tmp =3D gc_malloc(512, 1, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &=
quot;field length %d, payload length %d mismatch&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                 payload_len, buf_len(&=
amp;buf) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   err_reason =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    log_acc_message(c, &amp;buf, payload_len, proto=
col, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING: Received =
malformed custom app control channel &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                       &quot;message (%s): %s&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        format_hex=
(CBPTR(buffer), BLEN(buffer), 80, &amp;gc));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                 struct tls_=
multi *multi,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           struct tls_session *session,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 const char *protocol, bool fragment,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 cons=
t char *acc_msg_payload, bool base64)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * length=
 of the protocol string + one &#39;,&#39;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * 2 for the encoding (A or 6), potential F (frag=
ment), and 1 for the &#39;,&#39;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * 4 for the message size itself and one comma</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * 1 for the comma before =
the message itself */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const size_t max_header_size =3D strlen(&quot;ACC,&quot;) + strlen(pr=
otocol) + 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    size_t len =3D max_header_size + strlen(acc_msg_payload);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNEL_BUF_SIZE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;message =
length (%zu) exceeds maximum possible message length (%d)&quot;, len, TLS_C=
HANNEL_BUF_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if ((int)len &gt; multi-&gt;a=
cc_max_message_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_CLIENT, &quot;header (%zu) + message size (%zu) length (%zu) exceeds &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
      &quot;maximum allowed length negotiated with peer (%d)&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            max_header_size=
, strlen(acc_msg_payload), len,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            multi-&gt;acc_max_message_length);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* add 1 for the final \0 */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_g=
c(len + 1, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example mes=
sage: ACC,muppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quo=
t;, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
         strlen(acc_msg_payload),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+               base64 ? &quot;6&quot; : &quot;A&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+               fragment ? =
&quot;F&quot; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+               acc_msg_payload);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool ret =3D send_control_channel_string_dowork(session, BSTR(&amp;=
buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eschedule_multi_process(c);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabilitie=
s,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
    const char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     int *max_acc_len,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                     bool server,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                     struct gc_arena *g=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D string_al=
loc(capabilities, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *tmp_message_orig =3D tmp_message;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *token =3D strtok_r(tmp_message, delim, &amp=
;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D N=
ULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we allo=
w more capabilities than our own, in client</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * mode we reject if we should use capabilities=
 that we do not support */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_constrained(tok=
en, &amp;acclen, &quot;ACC message length&quot;, ACC_MIN_MSG_LEN, allowed_a=
cc_len, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp=
; (!tls_item_in_cipher_list(&quot;A&quot;, token) || !tls_item_in_cipher_li=
st(&quot;6&quot;, token)))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         msg(D_PUSH_ERRORS, &quot;App custom control encoding must include =
base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            goto done;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D =
1 &amp;&amp; !server &amp;&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; s=
trcmp(token, &quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_PUSH_ERRORS, &quot;App custom control encoding must be e=
xactly base64 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            goto done;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =
=3D=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            protocol=
s =3D token;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;Too =
many parameters for INFO ACC message/IV_ACC=2E&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto done;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        token =3D strtok_r(NULL, delim, &amp;lasts);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        p++;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(protocols, gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    free(tmp_message_orig);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_list_inte=
rsection(struct gc_arena *gc, const char *list1, const char *list2)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *tmp =3D string_alloc(list1, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *token =3D strtok_r(tmp, &quot;:&quot;, &amp;lasts);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* The maximum possible length is the shorter of the two=
 input lists */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
size_t max_len =3D min_size(strlen(list1), strlen(list2));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer common_protocols =3D alloc_buf_gc(max=
_len + 1, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* check for every items is in b=
oth lists and not already in the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+         * common list */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (tls_item_in_cipher_list(token, list2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !tl=
s_item_in_cipher_list(token, buf_cstr(&amp;common_protocols)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (buf_len(&amp;common_proto=
cols) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    buf_write_u8(&amp;common_protocols, &#39;:&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            buf_printf(&amp;common_protocols, &=
quot;%s&quot;, token);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 token =3D strtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    free(tmp);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return common_protocols;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protoco=
ls(struct tls_multi *multi, struct tls_session *session)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!multi-&gt;opt=2Eacc_protocols)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* No app custom protocols have been confi=
gured server-side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_=
protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* We already h=
ave determined the common protocols=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* example IV=
_ACC: IV_ACC=3D2048,6:A,flower:power */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *peer_info =3D multi-&gt;peer_info;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc =
=3D extract_var_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int max_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *protocols =3D parse_acc_parameters(iv_acc, &quot;=
,&quot;, &amp;max_acc_len, true, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (!protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc=
_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_PUSH_ERRORS, &quot;WARNING: IV_ACC peer info variable of peer is =
malformed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_protocols =3D =
get_list_intersection(&amp;gc, multi-&gt;opt=2Eacc_protocols, protocols);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;common_protocols) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG=
, &quot;WARNING: No common app custom control protocol=2E&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    multi-&gt;acc_negotiated_protocols =3D string_alloc(buf_=
str(&amp;common_protocols), NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    multi-&gt;acc_max_message_length =3D max_acc_len;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    setenv_str(session-&gt;opt-&gt;es, &quot;=
acc_protocols&quot;, multi-&gt;acc_negotiated_protocols);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    setenv_int(session-&gt;opt-&gt;es=
, &quot;acc_message_len&quot;, multi-&gt;acc_max_message_length);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+notify_client_acc_proto=
cols(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef E=
NABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (management)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLI=
ENT, &quot;&gt;ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_n=
egotiated_protocols, multi-&gt;acc_max_message_length);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/a=
cc=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E9c99b11</span><br><span>--- /dev/null</span><br><span>+++ b/src/openv=
pn/acc=2Eh</span><br><span>@@ -0,0 +1,130 @@</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             session authentication and key e=
xchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet encryption, packet authentication, and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@=
openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License fo=
r more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have=
 received a copy of the GNU General Public License along</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write t=
o the Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1=
301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method parses an =
app custom control message and delivers it to the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * management interface=2E We leave reassembl=
y of fragmented messages to the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * management interface=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param c            The context struct</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param buffer       Buffer containing the contro=
l message with ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct conte=
xt *c, const struct buffer *buffer);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(=
struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                struct tls_multi *tls_multi,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 struct tls_session *session,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 const c=
har *protocol, bool fragment,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 const char *msg, bool base64);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parses an inf=
o message from the server that contains app custom control info</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * information prior to the PUS=
H_REPLY to be able to use app custom control</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * protocols before sending</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * In client mode only allow what we support ourselves=2E =
In server mode</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * al=
low also capabilities that we not support ourselves=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param capabilities      The string to parse</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param delim             T=
he delimiter to use when parsing the string=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *                          IV_ACC uses &quot;,&=
quot; as delimiter while the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                          custom-control PUSH message uses &quot=
; &quot; as &quot;,&quot; is</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                          already used to separate different pus=
h directives</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am max_acc_len       Set to the maximum ACC message length</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param server            Whether =
we are server or client</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param gc                The gc arena to use for allocating the resu=
lting string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn                  The resulting protocol string or NULL on error</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     const =
char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              int *max_acc_len,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     bool server,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     struct gc_arena *gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Parses the IV_ACC of the peer and sets multi=2Eacc_negotia=
ted_protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to =
the common protocols of server and client and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * multi=2Eacc_max_message_length  to the maximum=
 length of the ACC message</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * support by both server and client=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * If there is no common protocol or the client does not support =
any app custom</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pr=
otocol multi=2Eacc_negotiated_protocols will be set to NULL=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param multi      the multi instance to use th=
e set the app custom protocols=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param session    the session to read the client env from<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct tls_multi *mu=
lti, struct tls_session *session);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Flags returned by=
 the parse_acc_message_flags method</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
enum acc_message_flag</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_=
FLAGS_ASCII =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ACC_MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Parses the fla=
gs field of an app control message If there is an</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  error parsing the flags field the method =
returns -1 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  p=
uts the error reason in err_reason</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_message=
_flags(const char *flags, const char **err_reason, struct gc_arena *gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Calculates the intersection of two list that are both =
separated by :</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It=
ems in the result will have the same ordering as in the list1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * parameters</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param gc            Returned buffer=
 will be allocated in this gc</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param list1         First list to intersect</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param list2         Second list t=
o intersect=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn A (potentially empty) buffer containing an intersection list</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+struct buffer</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_arena *gc, const c=
har *list1, const char *list2);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Notifies a client vi=
a management interface of the negotiated app</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * custom protocols</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param multi the tls_multi instance of the conn=
ection</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+notify_client_acc_protocols(struct tls_multi=
 *multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec=
</span><br><span>index 681210d=2E=2Eeb41d03 100644</span><br><span>--- a/sr=
c/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><=
br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;dco=2Eh&quot;</s=
pan><br><span> #include &quot;auth_token=2Eh&quot;</span><br><span> #includ=
e &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> #i=
nclude &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>@@ -257,11 =
+258,11 @@</span><br><span>     }</span><br><span>     else if (buf_string_=
match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(buf,=
 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        peer_pu=
shed_info(c, buf, 8);</span><br><span>     }</span><br><span>     else if (=
buf_string_match_head_str(buf, &quot;INFO&quot;))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_in=
fo(buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
peer_pushed_info(c, buf, 4);</span><br><span>     }</span><br><span>     el=
se if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&quot;))</span><br><=
span>     {</span><br><span>@@ -271,6 +272,10 @@</span><br><span>     {</sp=
an><br><span>         receive_auth_pending(c, buf);</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (buf_str=
ing_match_head_str(buf, &quot;ACC&quot;))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        receive_acc_message(c, buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (buf_string_mat=
ch_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {</span><br><span>=
         receive_exit_message(c);</span><br><span>diff --git a/src/openvpn/=
init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 1b8b2a5=2E=2Ee0b99a4 =
100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src=
/openvpn/init=2Ec</span><br><span>@@ -56,6 +56,7 @@</span><br><span> #inclu=
de &quot;schedule=2Eh&quot;</span><br><span> #include &quot;options_string=
=2Eh&quot;</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span=
><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><sp=
an> </span><br><span>@@ -2279,6 +2280,13 @@</span><br><span>         }</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi &amp;&amp;=
 multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        buf_printf(&amp;out, &quot; custom-control %d A:6 %s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   multi=
-&gt;acc_max_message_length, multi-&gt;acc_negotiated_protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (BLENZ(&amp;out)=
 &gt; strlen(header))</span><br><span>     {</span><br><span>         msg(D=
_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><span>@@ -2522,6 +25=
30,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     return flags;</span><br><span>=
 }</span><br><span> </span><br><span>@@ -2730,6 +2743,18 @@</span><br><span=
>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tun_max_mtu, c-&gt;option=
s=2Ece=2Etun_mtu);</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (found &amp; OPT_P_ACC &amp;=
&amp; c-&gt;options=2Epushed_acc_negotiated_protocols)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct tls_multi *multi =3D c-&gt;c2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(mul=
ti-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        multi-&gt;acc_negotiated_protocols =3D string_alloc(c=
-&gt;options=2Epushed_acc_negotiated_protocols, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_max_message_length=
 =3D c-&gt;options=2Epushed_acc_max_message_length;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT: ACC protocols: %s,=
 msg len: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            multi-&gt;acc_negotiated_protocols, multi-&gt;acc_max_message_l=
ength);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        noti=
fy_client_acc_protocols(multi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     return true;</span><br><span> }</span><br><span> </span=
><br><span>@@ -3352,6 +3377,7 @@</span><br><span>     to=2Everify_hash_dept=
h =3D options-&gt;verify_hash_depth;</span><br><span>     to=2Everify_hash_=
no_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>     memcpy(to=2Ex=
509_username_field, options-&gt;x509_username_field, sizeof(to=2Ex509_usern=
ame_field));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=
=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><span>     to=2Ee=
s =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &amp;c-&gt;net_c=
tx;</span><br><span> </span><br><span>@@ -4306,6 +4332,24 @@</span><br><spa=
n> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+management_acc_msg(void *arg,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
struct buffer_list *input) /* ownership transferred */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct context *c =3D arg;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    bool ret =3D false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (buffer_list_defined(input) &amp;&amp; c-&gt;c2=2Etls_m=
ulti)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *mu=
lti =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct tls_session *session =3D &amp;multi-&gt;session[TM=
_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_se=
nd_acc_message(c, multi, session, input);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_=
list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><=
br><span> void</span><br><span>@@ -4322,6 +4366,7 @@</span><br><span>      =
   cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span><br><span>      =
   cb=2Eremote_cmd =3D management_callback_remote_cmd;</span><br><span>    =
     cb=2Esend_cc_message =3D management_callback_send_cc_message;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Eacc_msg =3D man=
agement_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</span><br><span>   =
      cb=2Enetwork_change =3D management_callback_network_change;</span><br=
><span> #endif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/op=
envpn/manage=2Ec</span><br><span>index ac3d4b7=2E=2Eaff8146 100644</span><b=
r><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/mana=
ge=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><br><span> #include &quot;p=
ush=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&quot;</span><br><sp=
an> #include &quot;resolve=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br><=
span> #include &quot;memdbg=2Eh&quot;</span><br><span> #include &quot;run_c=
ommand=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENA=
BLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span=
>@@ -1081,6 +1083,35 @@</span><br><span>             }</span><br><span>    =
         break;</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Ecli=
ent_acc_msg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   bool status =3D (*man-&gt;persist=2Ecallback=2Eclient_acc_msg)(man-&gt;p=
ersist=2Ecallback=2Earg,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                                                      =
man-&gt;connection=2Ein_extra_cid,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                                            =
          man-&gt;connection=2Ein_extra_kid,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                                  =
                    man-&gt;connection=2Ein_extra);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ein_e=
xtra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           report_command_status(status, &quot;client-acc-msg&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                man_command_unsupported(=
&quot;client-acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case IEC_=
ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                bool status =3D (*man-&gt;persist=2Ecallba=
ck=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                               =
                man-&gt;connection=2Ein_extra);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                man-&gt;connection=2Ein_extra =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      report_command_status(status, &quot;acc-msg&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                man_command_unsupported(&quot;acc-=
msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span>         case IEC_PK_SIGN:</span><br><span>           =
  man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><br><span>       =
      buffer_list_free(man-&gt;connection=2Eext_key_input);</span><br><span=
>@@ -1205,6 +1236,29 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_c=
lient_acc_msg(struct management *man, const char *cid_str,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                   const char *kid_s=
tr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D =
&amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;mc-&gt;in_extra_=
cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&a=
mp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extra_kid))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cmd =3D IEC_CLIEN=
T_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
n_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp;man-&gt;conn=
ection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;i=
n_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span> man_client_auth(struct management *man, const char *cid_str, =
const char *kid_str, const bool extra)</span><br><span> {</span><br><span> =
    struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><span>=
@@ -1759,6 +1813,17 @@</span><br><span>             man_client_pending_auth=
(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;client-acc-msg&quot;))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (man_need(p, 2, 0))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            man_client_acc_msg(man, p[1], p[2]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (streq(p[=
0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br><span>         m=
an_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2975,7 +3040,9 @@<=
/span><br><span>                                        &quot;bytes_sent=3D=
&quot;,</span><br><span>                                        &quot;bytes=
_received=3D&quot;,</span><br><span>                                       =
 &quot;session_id=3D&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                       &quot;session_state=3D&quot; }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                     &quot;session_state=3D&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                       &quot=
;acc_protocols=3D&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                       &quot;acc_message_len=3D&quot; =
};</span><br><span> </span><br><span>     if (env_filter_level =3D=3D 0)</s=
pan><br><span>     {</span><br><span>@@ -3130,6 +3197,7 @@</span><br><span>=
     }</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> management_=
connection_established(struct management *man, struct man_def_auth_context =
*mdac,</span><br><span>                                   const struct env_=
set *es)</span><br><span>@@ -4372,6 +4440,58 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ma=
nagement_send_acc_message(struct context *c, struct tls_multi *multi, struc=
t tls_session *session,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                            struct buffer_list *input)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* also ensures that are enough inputs in the list=
 to safely call</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * buffer_list_peek without extra NULL checks */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size &lt; 3)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;not enough =
input lines for sending acc message, &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                      &quot;missing protocol, flag =
and/or messages lines&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer=
 *proto_buf =3D buffer_list_peek(input);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *protocol =3D string_alloc(CBSTR(proto_=
buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t buffer *encoding_buf =3D buffer_list_peek(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *acc_err_reason =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int acc_flags =3D parse_acc_message=
_flags(buf_cstr(encoding_buf), &amp;acc_err_reason, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (acc_flags &lt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR: parsin=
g acc message flags failed: %s&quot;, acc_err_reason);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buffer_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffe=
r_list_aggregate_separator(input, 10000, &quot;&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *acc_msg_buf =
=3D buffer_list_peek(input);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!m=
ulti-&gt;acc_negotiated_protocols</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        || !tls_item_in_cipher_list(protocol, multi-&gt;acc_n=
egotiated_protocols))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_CLIENT, &quot;ERROR: protocol not in the list of negotiated protocols: %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
np(multi-&gt;acc_negotiated_protocols));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto error;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret=
 =3D send_acc_message(c, multi, session, protocol,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                acc_flags &a=
mp; ACC_MESSAGE_FLAGS_FRAGMENT,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                buf_cstr(acc_msg_buf),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    acc_flags &amp; ACC_MESSAGE_FLAGS_BASE64);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+error:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span> #else /* ifdef ENABLE_MANAGEMENT */</span><b=
r><span> </span><br><span> #include &quot;win32=2Eh&quot;</span><br><span>d=
iff --git a/src/openvpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span=
>index 157039d=2E=2Ecc9c264 100644</span><br><span>--- a/src/openvpn/manage=
=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -184,1=
2 +184,19 @@</span><br><span>     int (*n_clients)(void *arg);</span><br><s=
pan>     bool (*send_cc_message)(void *arg, const char *message, const char=
 *parameter);</span><br><span>     bool (*kill_by_cid)(void *arg, const uns=
igned long cid, const char *kill_msg);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     bool (*client_auth)(void *arg, con=
st unsigned long cid, const unsigned int mda_key_id,</span><br><span>      =
                   const bool auth, const char *reason, const char *client_=
reason,</span><br><span>                         struct buffer_list *cc_con=
fig); /* ownership transferred */</span><br><span>     bool (*client_pendin=
g_auth)(void *arg, const unsigned long cid, const unsigned int kid,</span><=
br><span>                                 const char *extra, unsigned int t=
imeout);</span><br><span>     char *(*get_peer_info)(void *arg, const unsig=
ned long cid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool (*client_acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                           const unsigned long cid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           con=
st unsigned int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           struct buffer_list *msg);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool (*acc_msg)(void *arg,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    str=
uct buffer_list *msg);</span><br><span>     bool (*proxy_cmd)(void *arg, co=
nst char **p);</span><br><span>     bool (*remote_cmd)(void *arg, const cha=
r **p);</span><br><span> #ifdef TARGET_ANDROID</span><br><span>@@ -292,13 +=
299,15 @@</span><br><span>     struct command_line *in;</span><br><span>   =
  struct buffer_list *out;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define IEC_UNDEF       0</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define IEC_CLIENT_AUTH 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IEC_UNDEF          0</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_AUTH    1</sp=
an><br><span> /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_RSA_SIGN    3</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CERTIFICATE 4</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PK_SIGN     5=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_PASSWORD =
   6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_RSA=
_SIGN       3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e IEC_CERTIFICATE    4</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define IEC_PK_SIGN        5</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define IEC_PASSWORD       6</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define IEC_CLIENT_ACC_MSG 7</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define IEC_ACC_MSG        8</span><br><span>=
     int in_extra_cmd;</span><br><span>     struct buffer_list *in_extra;</=
span><br><span>     unsigned long in_extra_cid;</span><br><span>@@ -503,6 +=
512,14 @@</span><br><span> </span><br><span> void man_persist_client_stats(=
struct management *man, struct context *c);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Parses the ACC message from t=
he input buffer_list and send to the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * session identified by session and multi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct tls_session;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct tls_multi;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+management_send_acc_message(struct context *c, struct tls_multi *mul=
ti,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
            struct tls_session *session, struct buffer_list *input);</span>=
<br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br=
><span> /**</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index e302a81=2E=2Ea3eb3ca 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -53,6 +53,7 @@</span><br><span> #include &quot;ssl_util=
=2Eh&quot;</span><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #=
include &quot;reflect_filter=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </span><br=
><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><spa=
n>@@ -4085,6 +4086,26 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static con=
st char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+calculate_=
app_control_extra(struct multi_instance *mi, struct gc_arena *gc)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&gt;context;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi=
 *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_CLIENT, &quot;ACC: No negotiated protocols&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1024, gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC:%d A:6 %s&=
quot;, multi-&gt;acc_max_message_length,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+               multi-&gt;acc_negotiated_protocols);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&am=
p;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> ma=
nagement_client_pending_auth(void *arg, const unsigned long cid, const unsi=
gned int mda_key_id,</span><br><span>                                const =
char *extra, unsigned int timeout)</span><br><span>@@ -4095,10 +4116,22 @@<=
/span><br><span>     if (mi)</span><br><span>     {</span><br><span>       =
  struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &qu=
ot;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ext=
ra =3D calculate_app_control_extra(mi, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!extra)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
      struct tls_session *session =3D lookup_session_by_mda_key_id(multi, m=
da_key_id);</span><br><span> </span><br><span>         if (!session)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            gc_free(&amp;gc);</span><br><span>             return false;</=
span><br><span>         }</span><br><span> </span><br><span>@@ -4106,6 +413=
9,7 @@</span><br><span>         bool ret =3D send_auth_pending_messages(mul=
ti, session, extra, timeout);</span><br><span>         reschedule_multi_pro=
cess(&amp;mi-&gt;context);</span><br><span>         multi_schedule_context_=
wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   gc_free(&amp;gc);</span><br><span>         return ret;</span><br><span> =
    }</span><br><span>     return false;</span><br><span>@@ -4149,6 +4183,3=
7 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+management_client_acc_msg(void *arg,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                          cons=
t unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                          const unsigned int mda_key_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                          struct buff=
er_list *input) /* ownership transferred */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct multi_context *m =3D (struct multi_context *)arg;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *m=
i =3D lookup_by_cid(m, cid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool r=
et =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (mi &amp;&amp; buffer_list_defined(input))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct t=
ls_session *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!session)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quo=
t;client session not found&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            buffer_list_free(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ret =3D management_send_acc_message(&amp;mi-&gt;context,=
 multi, session, input);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi_schedule_context_wakeup(m, mi);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static char *</s=
pan><br><span> management_get_peer_info(void *arg, const unsigned long cid)=
</span><br><span> {</span><br><span>@@ -4185,6 +4250,7 @@</span><br><span> =
        cb=2En_clients =3D management_callback_n_clients;</span><br><span> =
        cb=2Ekill_by_cid =3D management_kill_by_cid;</span><br><span>      =
   cb=2Eclient_auth =3D management_client_auth;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =3D management_clie=
nt_acc_msg;</span><br><span>         cb=2Eclient_pending_auth =3D managemen=
t_client_pending_auth;</span><br><span>         cb=2Eget_peer_info =3D mana=
gement_get_peer_info;</span><br><span>         cb=2Epush_update_broadcast =
=3D management_callback_send_push_update_broadcast;</span><br><span>diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>ind=
ex fb319ae=2E=2Ea5e7396 100644</span><br><span>--- a/src/openvpn/options=2E=
c</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -35,6 +3=
5,7 @@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;acc=2Eh&quot;</span><br><span> #include &quot;buffer=2Eh&quot;=
</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> #include =
&quot;common=2Eh&quot;</span><br><span>@@ -2552,6 +2553,8 @@</span><br><spa=
n>     o-&gt;push_option_types_found =3D 0;</span><br><span>     o-&gt;push=
_update_options_found =3D 0;</span><br><span>     o-&gt;imported_protocol_f=
lags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&g=
t;pushed_acc_max_message_length =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    o-&gt;pushed_acc_negotiated_protocols =3D NULL;</spa=
n><br><span> }</span><br><span> </span><br><span> static void</span><br><sp=
an>@@ -7107,6 +7110,47 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_=
GENERAL);</span><br><span>         options-&gt;force_key_material_export =
=3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else if (streq(p[0], &quot;app-custom-control&quot;) &amp;=
&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!string_class(p[1], CC_ALNUM | CC_COLON | CC_U=
NDERBAR | CC_DASH, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(msglevel, &quot;App custom control protocols must only contain &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
          &quot;alphanumeric characters, &#39;-&#39;, and &#39;_&#39;=2E&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            go=
to err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ac=
c_protocols =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if =
(streq(p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &a=
mp;&amp; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      VERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* check if the list from the server is a real subset of our list */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_are=
na gc_local =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct buffer common_list =3D get_list_intersection(&amp;gc_l=
ocal, p[3], options-&gt;acc_protocols);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (buf_len(&amp;common_list) =3D=3D 0 || !streq(p[3], buf_cstr(&a=
mp;common_list)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(msglevel, &quot;App custom control list from server contains &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
   &quot;unsupported protocols&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            gc_free(&amp;gc_local);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        gc_free(&amp;gc_local);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!streq(p[2], &quot;6:A&quot;) &amp;&amp; !s=
treq(p[2], &quot;A:6&quot;))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(msglevel, &quot;App custom control encoding must be base64 a=
nd ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(=
p[1], &amp;options-&gt;pushed_acc_max_message_length,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              &quot;app c=
ustom message message length&quot;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msgle=
vel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;pushed_acc_n=
egotiated_protocols =3D p[3];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;prng&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span> =
        msg(M_WARN, &quot;NOTICE: --prng option ignored (SSL library PRNG i=
s used)&quot;);</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/=
openvpn/options=2Eh</span><br><span>index 6a3bf61=2E=2Eb7945e0 100644</span=
><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/=
options=2Eh</span><br><span>@@ -715,6 +715,18 @@</span><br><span>     /* fo=
rce using TLS key material export for data channel key generation */</span>=
<br><span>     bool force_key_material_export;</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom control=
 protocols we should announce as supported */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /** the protocols that are negotiated with the peer=
=2E This is a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
  a temporary variable since options=2Ec push parser cannot access</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     *  tls multi struct */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *push=
ed_acc_negotiated_protocols;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** th=
e maximum length of an ACC control channel message via push message</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+     * */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int pushed_acc_max_message_length=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    bool vlan_tagging;</span><br><span>     enum vlan_acceptable_frames vla=
n_accept;</span><br><span>     uint16_t vlan_pvid;</span><br><span>@@ -764,=
8 +776,10 @@</span><br><span> #define OPT_P_INLINE          (1u &lt;&lt; 29=
)</span><br><span> #define OPT_P_PUSH_MTU        (1u &lt;&lt; 30)</span><br=
><span> #define OPT_P_ROUTE_TABLE     (1u &lt;&lt; 31)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_ACC             (1ull &lt;=
&lt; 32)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER=
_ID | 0x0ull))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Op=
tions allowed in the normal configuration file (vs pushed options or in ccd=
 files) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
PT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_AC=
C))</span><br><span> </span><br><span> #define PULL_DEFINED(opt) ((opt)-&gt=
;pull)</span><br><span> </span><br><span>diff --git a/src/openvpn/push=2Ec =
b/src/openvpn/push=2Ec</span><br><span>index 42259c3=2E=2Ea18f33b 100644</s=
pan><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/=
push=2Ec</span><br><span>@@ -27,6 +27,8 @@</span><br><span> #include &quot;=
syshead=2Eh&quot;</span><br><span> </span><br><span> #include &quot;push=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</s=
pan><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &=
quot;crypto=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><=
br><span>@@ -221,9 +223,56 @@</span><br><span> #endif</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_server=
_pushed_info_acc(struct context *c, struct buffer *buf)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int max_acc_len =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_mul=
ti;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_pr=
otocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!multi-&gt;opt=2Eacc_protocols || !c-&gt;options=2Ep=
ull)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &q=
uot;Peer tried to push app custom control list &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           &quot;without =
client announcing support for it&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* example s=
tring to parse: ACC:1400 A:6 flower:happy */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* Skip over the ACC: prefix */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf, 4);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D p=
arse_acc_parameters(buf_cstr(buf), &quot; &quot;, &amp;max_acc_len, false, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!p=
rotocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERROR=
S, &quot;WARNING: Received ACC info command with invalid parameters&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* check if the list from the server is a real=
 subset of our list */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer common_list =3D get_list_intersection(&amp;gc, protoco=
ls, multi-&gt;opt=2Eacc_protocols);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (buf_len(&amp;common_list) =3D=3D 0 || !streq(protocols, buf_cstr(&amp;=
common_list)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_=
ERRORS, &quot;App custom control list from server contains &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                           &q=
uot;unsupported protocols&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc=
_negotiated_protocols =3D string_alloc(protocols, NULL);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;acc_max_message_length =
=3D max_acc_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 notify_client_acc_protocols(multi);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span> </span><br><span> void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-server_pushed_info(const struct buff=
er *buffer, const int adv)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+peer_pushed_info(struct context *c, const struct buffer *buffer, con=
st int adv)</span><br><span> {</span><br><span>     const char *m =3D &quot=
;&quot;;</span><br><span>     struct buffer buf =3D *buffer;</span><br><spa=
n>@@ -233,6 +282,12 @@</span><br><span>         m =3D BSTR(&amp;buf);</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (strncmp(m, &quot;ACC:&quot;, 4) =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        parse_server_pushed_info_acc(c, &=
amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENA=
BLE_MANAGEMENT</span><br><span>     struct gc_arena gc;</span><br><span>   =
  if (management)</span><br><span>@@ -257,7 +312,7 @@</span><br><span>     =
    gc_free(&amp;gc);</span><br><span>     }</span><br><span> #endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_PUSH, &quot;Info c=
ommand was pushed by server (&#39;%s&#39;)&quot;, m);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &quot;Info command was pu=
shed by peer (&#39;%s&#39;)&quot;, m);</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span>@@ -285,6 +340,7 @@</span><br><span>=
     msg(D_PUSH, &quot;CR response was sent by client (&#39;%s&#39;)&quot;,=
 m);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Parse the k=
eyword for the AUTH_PENDING request</span><br><span>  * @param buffer      =
          buffer containing the keywords, the buffer&#39;s</span><br><span>=
@@ -441,7 +497,6 @@</span><br><span>     const char *const peer_info =3D tl=
s_multi-&gt;peer_info;</span><br><span>     unsigned int proto =3D extract_=
iv_proto(peer_info);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     /* Calculate the maximum timeout and=
 subtract the time we already waited */</span><br><span>     unsigned int m=
ax_timeout =3D</span><br><span>         max_uint(tls_multi-&gt;opt=2Erenego=
tiate_seconds / 2, tls_multi-&gt;opt=2Ehandshake_window);</span><br><span>@=
@ -732,6 +787,12 @@</span><br><span>                 client_max_mtu, o-&gt;=
ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</span><br><span>         }</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_multi-&gt;acc_neg=
otiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_op=
tion_fmt(gc, push_list, M_USAGE, &quot;custom-control %d A:6 %s&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
tls_multi-&gt;acc_max_message_length, tls_multi-&gt;acc_negotiated_protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span> }</span><br><span> </span><br><span> static bool</span><br><span>dif=
f --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br><span>index=
 39302f6=2E=2Ee08cd66 100644</span><br><span>--- a/src/openvpn/push=2Eh</sp=
an><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -52,6 +52,7 @@</=
span><br><span> </span><br><span> int process_incoming_push_request(struct =
context *c);</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /**</span><br><span>  * @brief Handles the rec=
eiving of a push-update message and applies updates to the specified</span>=
<br><span>  * options=2E</span><br><span>@@ -92,7 +93,15 @@</span><br><span=
> </span><br><span> void receive_exit_message(struct context *c);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void server_p=
ushed_info(const struct buffer *buffer, const int adv);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * This message is called when an INFO or INFO_PRE mess=
age is received from</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * a peer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c         Con=
text of the peer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param buffer    Buffer containing the INFO/INFO_PRE message=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param adv       number o=
f character to advance past the INFO/INFO_PRE header</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void peer_pushed_info(struct context *c, const struct buf=
fer *buffer, const int adv);</span><br><span> </span><br><span> void receiv=
e_cr_response(struct context *c, const struct buffer *buffer);</span><br><s=
pan> </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2E=
c</span><br><span>index 086a6fc=2E=2E97ef9b0 100644</span><br><span>--- a/s=
rc/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><spa=
n>@@ -55,6 +55,7 @@</span><br><span> </span><br><span> #include &quot;crypt=
o_epoch=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</s=
pan><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #includ=
e &quot;ssl_backend=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&q=
uot;</span><br><span>@@ -1279,6 +1280,7 @@</span><br><span>     free(multi-=
&gt;locked_cn);</span><br><span>     free(multi-&gt;locked_username);</span=
><br><span>     free(multi-&gt;locked_original_username);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_pro=
tocols);</span><br><span> </span><br><span>     cert_hash_free(multi-&gt;lo=
cked_cert_hash_set);</span><br><span> </span><br><span>@@ -2098,6 +2100,11 =
@@</span><br><span> #endif</span><br><span>         }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session-&gt=
;opt-&gt;acc_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      buf_printf(&amp;out, &quot;IV_ACC=3D%d,A:6,%s\n&quot;, ACC_MAX_MSG_LE=
N, session-&gt;opt-&gt;acc_protocols);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>         if (session-&gt;opt-&gt;push_peer_info_d=
etail &gt; 1)</span><br><span>         {</span><br><span>             struc=
t env_set *es =3D session-&gt;opt-&gt;es;</span><br><span>@@ -2398,6 +2405,=
8 @@</span><br><span>         multi-&gt;remote_ciphername =3D string_alloc(=
&quot;none&quot;, NULL);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_acc_prot=
ocols(multi, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     if (username_len &lt; 0 || password_len &lt; 0)</s=
pan><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;TLS E=
rror: Username (%d) or password (%d) too long&quot;, abs(username_len),</sp=
an><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_comm=
on=2Eh</span><br><span>index 9a55ead=2E=2E436770b 100644</span><br><span>--=
- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=
=2Eh</span><br><span>@@ -457,6 +457,9 @@</span><br><span>     size_t ekm_si=
ze;</span><br><span> </span><br><span>     bool dco_enabled; /**&lt; Whethe=
r keys have to be installed in DCO or not */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /** The app custom control protocols we should announce as suppor=
ted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *acc_protocols;</span><br><span> };</span><br><span> </span><br><span> /*=
* @addtogroup control_processor</span><br><span>@@ -730,6 +733,12 @@</span>=
<br><span>     int dco_peer_id;</span><br><span> </span><br><span>     dco_=
context_t *dco;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protocols t=
hat are negotiated with the peer=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *acc_negotiated_protocols;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /** the maximum length of an ACC control channel messag=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int acc_max=
_message_length;</span><br><span> };</span><br><span> </span><br><span> /**=
  gets an item  of \c key_state objects in the</span><br><span>diff --git a=
/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 43a6743=2E=2E6a73e1e 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -107,10 +107,12 @@</span><br=
><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LD=
FLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D=
 test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	tes=
t_acc=2Ec test_acc=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh test_c=
ommon=2Eh \</span><br><span> 	mock_management=2Ec \</span><br><span> 	mock_=
ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br><span> 	$(top_srcdir=
)/src/compat/compat-strlcpy=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><span> 	$(top_=
srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span=
><br><span>@@ -132,6 +134,7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/=
run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_openssl=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn=
/ssl_ncp=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_t=
ests/openvpn/mock_management=2Ec</span><br><span>index fff4c2b=2E=2Ef572dbb=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_management=2Ec<=
/span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</span><b=
r><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><span> #include &quot=
;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span> #include &quo=
t;manage=2Eh&quot;</span><br><span> </span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_push_depende=
ncies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span><br><=
span>index bf2ccf3=2E=2Ef083f89 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec</span><br><span>+++ b/tests/unit_test=
s/openvpn/mock_push_dependencies=2Ec</span><br><span>@@ -43,7 +43,8 @@</spa=
n><br><span>     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_S=
OCKBUF | OPT_P_SOCKFLAGS</span><br><span>                      | OPT_P_SETE=
NV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST</span><br><spa=
n>                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_EC=
HO | OPT_P_PULL_MODE</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                    | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_RO=
UTE | OPT_P_DHCPDNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_=
ROUTE | OPT_P_DHCPDNS</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     | OPT_P_ACC;</span><br><span>     return flags;</spa=
n><br><span> }</span><br><span> </span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E9364d12</span=
><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_acc=2Ec</span><br><span>@@ -0,0 +1,353 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             session authentication and key ex=
change,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet encryption, packet authentication, and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@o=
penvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
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
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to t=
he Free Software Foundation, Inc=2E,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301=
 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_c=
ommon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mock_msg=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char control_chan=
nel_message_sent[2048];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Mock functio=
ns */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+send_control_channel_string_d=
owork(struct tls_session *session,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                   const char *str, unsigned=
 int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_in_range=
(strlen(str), 0, 2047);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(cont=
rol_channel_message_sent, str);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+send_push_reply_auth_token(struct tls_mul=
ti *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+auth=
_set_client_reason(struct tls_multi *multi, const char *reason)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MSG=
_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;               =
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   &quot;r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &qu=
ot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;AJw=
BnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    &quot;QAXAB4AGQ=
AYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;ICAgaCBsIHAgJCA=
oICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;AUEAwQDAwAtAAIBAQAzAC=
YAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;93rQwityP9eKSijXgcQ=3D=3D&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_acc_parse_client_messages(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    skip();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* ensure that the messages get to mock_msg */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 3;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management =3D =
(void *)0x12345678;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* contains a TLS 1=2E3 ClientHello */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char msg[] =3D &quot;ACC,cck1,384,6,&quot; M=
SG_PAYLOAD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer msg_buf;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct context c=
 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2E=
options=2Emode =3D MODE_SERVER;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALL=
OC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eop=
t =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;=
mda_context =3D &amp;c=2Ec2=2Emda_context;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg, sizeof(m=
sg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &=
amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(mock_msg_buf, &quot;WARNING: Received malformed custom ap=
p control channel message (ACC not enabled or no negotiated protocols): 414=
3432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=2E=
=2E=2E]&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;acc_negotiated_protocols =3D &qu=
ot;no:common:protocol&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &=
quot;WARNING: Received malformed custom app control channel message (protoc=
ol &#39;cck1&#39; not in list of negotiated protocols &#39;no:common:protoc=
ol&#39;): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 77=
4e616[more=2E=2E=2E]&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_multi-&gt;acc_negotiated_prot=
ocols =3D &quot;cck1:flower:power:fortune&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, =
&quot;Received custom app control message (protocol &#39;cck1&#39;)&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg[] =3D &quo=
t;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(=
&amp;msg_buf, (void *)flower_msg, sizeof(flower_msg));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg=
_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(mock_msg_buf, &quot;Received custom app control message (protoco=
l &#39;flower&#39;)&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,=
0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_incorrect_l=
en[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSB=
hbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_incorrect_len, size=
of(msg_incorrect_len));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *error =3D &quot;WARNING: Rec=
eived malformed custom app control channel &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        &quot;message (field =
length 62, payload length 64 mismatch): &quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        &quot;4143432c 666f7274 =
756e652c 36322c36 2c496e73 67496d31 &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        &quot;6c496a6f 67496d5[more=
=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char msg_fragment[] =3D &quot=
;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_fragment, s=
izeof(msg_fragment));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Re=
ceived custom app control message (protocol &#39;power&#39;, fragment)&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_strin=
g_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=
=3D&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check two=
 encoding present */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char flower_msg_two_encs[] =3D &quot;ACC,flower,48,6A,SSBhbSAAIE=
tlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower=
_msg_two_encs, sizeof(flower_msg_two_encs));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Received mal=
formed custom app control channel message &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;(number of encodings must be=
 exactly one (B64=3D1, ASCII=3D1)): &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;4143432c 666c6f77 65722c34 382c364=
1 2c535342 68625341 41494574 &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;6c636d3[more=2E=2E=2E]&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
mock_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* no encoding present */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char flower_msg_no_encs[] =3D &quot;ACC,flower,48,,SSBhbSAA=
IEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)fl=
ower_msg_no_encs, sizeof(flower_msg_no_encs));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    error =3D &quot;WARNING: Received ma=
lformed custom app control channel message &quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;(number of encodings must b=
e exactly one (B64=3D0, ASCII=3D0)): &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &quot;4143432c 666c6f77 65722c34 382c2c=
53 53426862 53414149 45746c63 &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;6d31706[more=2E=2E=2E]&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_m=
sg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    x_debug_level =3D 0;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    management =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_parse_acc_parameters(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* parameters =
to INFO message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *info_acc_msg =3D &quot;4096 A:6 flower:happy&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int max_len =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char *protocols =3D parse_acc_para=
meters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(proto=
cols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(max_len, 1280);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* a client does not accept a length longer than it supports=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =
=3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* message with l=
ower limit than our, should work for client and server */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1111 A:6 f=
lower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max=
_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, =
1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_para=
meters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(proto=
cols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* more encodings than supported=2E Server should be okay, c=
lient should fail */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    info_acc_msg =3D &quot;1200 A:6:B flower:happy&quot;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_paramete=
rs(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(in=
fo_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &qu=
ot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(max_len, 1200);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* extra parameter */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    info_acc_msg =3D &quot;1400 A:6 flower:happy 77&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_=
parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_paramete=
rs(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *iv_acc_capabilities =3D &quot;1400,A:6,flowe=
r:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    protocols =3D parse_acc_parameters(iv_acc_capabilities, &quot;,&quot;,=
 &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(protocols, &quot;flower:happy:power&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* too small protocol length */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =
=3D &quot;32 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot=
; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* non-numerical protocol length */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flower:hap=
py&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protoc=
ols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, tru=
e, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_acc_common_protocols(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct multi_instance mi =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=2Econtext;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eg=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(=
c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot=
;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power&quot;;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_protocols=
 =3D &quot;power:flower:star&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_p=
rotocols =3D c-&gt;options=2Eacc_protocols;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;mul=
ti-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mult=
i-&gt;opt=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    determine_common_acc_protocols(multi, &amp;c-&gt;c=
2=2Etls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(multi-&gt;acc_max_message_length, ACC_MAX_MSG_LEN);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(multi-&gt;acc_negotiated_protocols, &quot;power:flower&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_get(multi-&gt;opt=
=2Ees, &quot;acc_protocols&quot;), &quot;acc_protocols=3Dpower:flower&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;=
acc_message_len=3D1280&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free=
(multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_send_me=
ssage(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_i=
nstance mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct context *c =3D &amp;mi=2Econtext;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struc=
t tls_multi, &amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool ret;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_prot=
ocols =3D &quot;power:flower:emergency&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_protocols =3D c-&gt;optio=
ns=2Eacc_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;opt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Ees =3D env_s=
et_create(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D140=
0,A:6,flower:emergency:power&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Et=
ls_multi-&gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACT=
IVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message(c, c=
-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                           &quot;EME=
RGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;, false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(control_channel_message_s=
ent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         &quot;ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NO=
T A DRILL:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc=
_message(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, false,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
     &quot;THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=
=2E&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(control_channel_message_sent,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        &quot;ACC,emerge=
ncy,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=
=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* test a long message (&gt; 1000) with fr=
agment to get the maximum header size */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    char long_message[1200] =3D { 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 1024; i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        long_message[i] =3D (char)(&#39; &#39; +=
 (i % 95));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* last char of the message is a i an=
d then a \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(long_message[1023], &#39;i&#39;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1024], &#39=
;\0&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D send_acc_message=
(c, c-&gt;c2=2Etls_multi, session, &quot;emergency&quot;, true,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                           long=
_message, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t cc_len =
=3D strlen(control_channel_message_sent);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(control_channel_message_sent[cc_=
len - 1], &#39;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *expected_start_cc =3D &quot;ACC,emergency,1024,AF, !\&q=
uot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_memory_equal(control_channel_message_sent, =
expected_start_cc, strlen(expected_start_cc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free(multi-&gt;acc_negotiated_protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_list_intersection(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const char *empty =3D &quot;&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *protos =3D &quot;power:flower:emergency&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t1 =3D get_list_=
intersection(&amp;gc, empty, protos);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t1), 0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer t2 =3D get_list_intersection(&amp;g=
c, protos, empty);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(buf_len(&amp;t2), 0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer t3 =3D get_list_intersection(&amp;gc, protos, protos);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(buf_cstr(&amp;t3), protos);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *protos2 =3D &quot;flower:emergency:power:mario&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t4 =3D get_li=
st_intersection(&amp;gc, protos2, protos);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t4), &quot;flo=
wer:emergency:power&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *protos3 =3D &quot;super:paper:mario:flower&quot;;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer t5 =3D get_list_inters=
ection(&amp;gc, protos2, protos3);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t5), &quot;flower:mari=
o&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *proto4 =3D &q=
uot;flower:flower:flower:flower&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer t6 =3D get_list_intersection(&amp;gc, =
proto4, &quot;flower&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(buf_cstr(&amp;t6), &quot;flower&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_acc=2Eh b/tests/unit_tests/openvpn/test_acc=2Eh</span><br><span>new file=
 mode 100644</span><br><span>index 0000000=2E=2E32421fb</span><br><span>---=
 /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Eh</spa=
n><br><span>@@ -0,0 +1,35 @@</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Open=
VPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software=
; you can redistribute it and/or modify</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licens=
e version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as p=
ublished by the Free Software Foundation=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is distributed in the hope that it will be useful,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY =
WARRANTY; without even the implied warranty of</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  GNU General Public License for more details=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  You should have received a copy of the GNU General Public=
 License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  w=
ith this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define TEST_ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+v=
oid test_acc_parse_client_messages(void **state);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void test_parse_acc_parameters(void **state);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void test_acc_common_protocols(void **state);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void test_acc_send_message(void **state);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void test_list_intersection(void **state);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/ope=
nvpn/test_common=2Eh</span><br><span>index 8db4ea6=2E=2Ec865142 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>@@ -43,11 +4=
3,13 @@</span><br><span> #define LargestIntegralType uintmax_t</span><br><s=
pan> #endif</span><br><span> /* redefine 2=2Ex API in terms of 1=2Ex API */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CMockaValueDa=
ta             LargestIntegralType</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define check_expected_uint         check_expected</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define expect_uint_value        =
   expect_value</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e expect_check_data           expect_check</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define cast_ptr_to_cmocka_value(x) (x)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define CMockaValueData           =
            LargestIntegralType</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define check_expected_uint                   check_expected</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_uint_va=
lue                     expect_value</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define expect_check_data                     expect_check=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define cast_ptr_to=
_cmocka_value(x)           (x)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define assert_int_in_range(value, min, max)  assert_in_range((v=
alue), (min), (max))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define assert_uint_in_range(value, min, max) assert_in_range((value), (mi=
n), (max))</span><br><span> #endif</span><br><span> </span><br><span> /**</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/u=
nit_tests/openvpn/test_ssl=2Ec</span><br><span>index 4baf8cc=2E=2E4987dd0 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br=
><span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -52,6=
 +52,8 @@</span><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><s=
pan> #include &quot;openvpn=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_acc=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Mock=
 function to be allowed to include win32=2Ec which is required for</span><b=
r><span>  * getting the temp directory */</span><br><span> #ifdef _WIN32</s=
pan><br><span>@@ -86,6 +88,20 @@</span><br><span> {</span><br><span>     re=
turn;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reschedule=
_multi_process(struct context *c)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Define a dummy dco cipher option to av=
oid linking against all the DCO</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * units */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(ENABLE_DCO)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+const char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+dco_get_supported_ciphers(void)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn &quot;AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY13=
05&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span> /* generated using</span><br><span>  * openssl req -x509 -new=
key ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \</span><br><span>@@ =
-1111,8 +1127,12 @@</span><br><span>         cmocka_unit_test(ssl_test_extr=
act_last_matching_field),</span><br><span>         cmocka_unit_test(ssl_tes=
t_reject_null_in_cert_subject),</span><br><span>         cmocka_unit_test(s=
sl_test_escape_rfc_2253_chars_in_subject),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        cmocka_unit_test(ssl_test_extract_peer_info)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(ssl_test_extract=
_peer_info),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_acc_parse_client_messages),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_parse_acc_para=
meters),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_acc_common_protocols),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_send_message),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test=
(test_list_intersection)</span><br><span>     };</span><br><span> </span><b=
r><span> #if defined(ENABLE_CRYPTO_OPENSSL)</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">=
change 1858</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 25 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: chugly &lt=
;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--Z1EQSURmR40=--


--===============5536261697860362696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5536261697860362696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5536261697860362696==--

