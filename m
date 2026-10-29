Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85534606A321
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KygPdnN0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KNdMTj1J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bVRg7dur;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GY1oa2zl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=5ihvvVzHWAZ8i4Vd41rKkRCp/o7PkABDonFBZ+TAZOs=; b=KygPdnN0SZTGILzQ9hs701JLH0
	gUe0xCRVXLZ7WbW4zIlUxLdnB2HVlcWL51L9ci1UprCkmE0JOnwptNZcaR0OhwNP2zrOJWUVniDNs
	aDHJ+hE2TGkiDQEbDi8RD3Dcgyq3RE2ugj5un4yEfd0q91pto/Y4BsSVec4gWign/PAE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMRtN-000000002CE-0H4H;
	Thu, 29 Oct 2026 15:18:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMRtK-000000002C5-0RcU
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:18:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y1+25hTHZU+TBdDdRNcBLGe2J6XW2dYyWI6iRqw0qL8=; b=KNdMTj1JGQRezHwZkRWXcxMNUP
 JH4+R91KtPzVu6UZrZeNGPHaAUNKmfQiBIUFDwePiJek8dmIcmyA07UwI1ltY7VnolNzeWBykD4h7
 z0zfHZ5LrTVnhsioxWCs4kMaKySx4plluA1XK4dk++0hEjbVX4E2rvfgAq0Yr9k9k72E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y1+25hTHZU+TBdDdRNcBLGe2J6XW2dYyWI6iRqw0qL8=; b=bVRg7durygYwFwE4HFf6q0mgU7
 kmWfyhkE3+N3Jp6qIuxEpUJns7wvLsDdZflQtvKShc9w7yBnUVxJBAfCN7krRtlQceEJr3fPqI3xW
 fpQ0x9GNLquX7mHWwEpo8wB6EA1f0vPgnHaV+1WKJspAMOst5itH5Y6TGzbOr1vTuCO0=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMRtC-000000005oI-1iq1 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 15:18:09 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so24998385e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 08:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793287076; x=1793891876; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=y1+25hTHZU+TBdDdRNcBLGe2J6XW2dYyWI6iRqw0qL8=;
 b=GY1oa2zlMkWSDI2A56d+jDOCvABN39tkAUQqZ0DYNNu3Z4uwo8oby9omAb9LJvKQia
 n7QSG8d2jf4Hbcv/5TL+PXStyEl4vH4TS+g7Japrbor6bA3ulop+JVwjzoijmINi1Mot
 cgAKyK86xq2X1nW38J1fJDz/GGmneG0xgxr0txRaNN+8Zg1xQ3Swjs42qd7IyMiBx/Qe
 vZGe7yiLxpXDZZNYQ01heIhcaicIftkeIG6bc1JgWV7EAcMrwoAKZJ1Sz1Ud9XHZOOOp
 0V1Ubr/vN5UlJNPMXH6mAzUv9X9BfQlHinfQo9/djMwf9nQA53zLaYqU1gAxXRd4vuRG
 IjbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287076; x=1793891876;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=y1+25hTHZU+TBdDdRNcBLGe2J6XW2dYyWI6iRqw0qL8=;
 b=BVRRLpTJKIH2lFJCwJgNnM0ceCuVDJ43GbiMEBHkARV57Rnjk+FcFZJyeDzeSgxqlz
 llHdWSHBBXsFqGRQQ/bHVsc1DYq/wk4/FMvU9Q2kkH+iuXqqx0x+/LE58zd2A6PbrElC
 bilYZGm0FdhmVk25/fUPCJXAVQZQfo1gYGrT7eo2xaPOLScHUNZFph+Ev+Y6A1XW9o5Y
 hWDO2G9uRS9QmiuGynhk7SCxD4+f8K4TtupQXXc7WYn4CDtmYHe5o6IAt6hJVRnG3Ggm
 mBQN2QK7DbE2YWhhEoD/UEbmb9PatIABXfjp050C4yScw87ltE5rpTrt2iBzc89NpgYW
 u+oQ==
X-Gm-Message-State: AFq9FYJLlUlQeJdeFqcqqMu195DHtYUteUdfqdCKGfQUvq4b+lTCdAXT
 Kf9XZQK6ZVhFxCXgDejnABiTAgyngsblwFOsqTo7eXjTQb4f37jY4ffEySBSqRk/m3+o20WPu2k
 Mm/EDu5IUwmhUP/ymifM3W67eLnDapU3rC+J+LVUtUPxkFa/2Df2q/NAHso0d6PHDGaeO
X-Gm-Gg: AYBFou01gVRaFkwgfuVza09xJHjF/G8w12+UFwVzDQcAS/7QZjv+itMcaXuNLKj3zxu
 +OFXMCHTA6bD/lLJIzjxDW8we57D/tXamRrpJ6EwngeQ6gaPdWZqXN0jDoXX17/W9/tSak5qAEk
 1YVix2DEkmrOwDj0fMBCOFGNhe7xppVGlmnQ8RKgDtnfzIWXoBqCNXpUgih8prceAxmKZICq3yq
 b5eTXMUbSsN+CruIeqr3jgjeQsmZnGaxApp2Zot2AKpJ35hnjPvugxbrTKqcLle9ViVVJWrDkDW
 s1fx+DbbHLkXfRNTQrXbgkpJGPG3/ezGoYsBXsh4Hzj9cuDh7cTDJkkXlKgNQHCVcrxvQGx0VQg
 b5Oc/O6s+g50M2GbwikqfTxM21oDNpWzaGVv3yrMHDYm/n7VdiVZ57CFJAsX158711+jpHILUu5
 CotaaxjDP4VOlmxs52kUwWohu6//vA4AwZa+q7MlwNhIX226GX1jni6/Qx42RCDChlqMlQ56Ova
 elWp4yHJjOn/t3l9k5EjKDiiDzQaYyrsNBRglIIGTpFYhRG/oBiFsBD3tdJldp3AP0uDYcMzHTu
 SUmajsGEtPx//iPZgLgzx13OeOvg2qu1vGm3kei9AHKvY7HBgBF6aewkdA5zFwW4yzrsClrwHs7
 eZ/HOa0M41uY37y4tZAi84P1dZ/MSxPaPuhesFRMijkOnqCM7W2yUlAI3AH7Ynu6Dv++eZuv2EH
 ya4UJj4Vq6d8jWzHw=
X-Received: by 2002:a05:600c:6088:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4a9677ca203mr139287875e9.27.1793287074566; 
 Thu, 29 Oct 2026 08:17:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f418afbsm84486055e9.6.2026.10.29.08.17.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:17:53 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 15:17:52 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 22
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: cfb4a164d8c2f37f6f910e0237d470ebd1ee3cdf
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9d832d9ab92303f2e98df605da4d14c0e461eb32-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMRtC-000000005oI-1iq1
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
 chugly <charlie.vigue@openvpn.com>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1579897994874457107=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1579897994874457107==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gGpYsIFKM8c="; charset=UTF-8

--gGpYsIFKM8c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858?usp=3Demail

to look at the new patch set (#22)=2E

The following=
 approvals got outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojo=
caru


Change subject: Implement sending/receiving app custom control proto=
col messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Implement sending/receiving app custom control protocol messages

This al=
lows openvpn GUI/front-ends and server via management
to use the OpenVPN co=
ntrol channel to pass messages between each other
while OpenVPN handles the=
 marshalling/unmarshalling of these and
negotiate the common app custom con=
trol protocols=2E

This provides an easy to use secure channel that does no=
t depend on
the network itself to work and can also be used before fully
au=
thenticating the client=2E See the management-notes=2Etxt for more
details =
how to use this feature=2E An upcoming patch will also add
some example pyt=
hon scripts that showcase this feature=2E

Change-Id: I4a6a6ef41e15896b8b79=
d795b2a6de86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M=
 CMakeLists=2Etxt
M doc/man-sections/client-options=2Erst
M doc/man-section=
s/management-options=2Erst
M doc/man-sections/script-options=2Erst
M doc/ma=
nagement-notes=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/acc=2Ec
A sr=
c/openvpn/acc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/op=
envpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/multi=2Ec
M src/ope=
nvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/ope=
nvpn/push=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M tests/un=
it_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mock_management=
=2Ec
M tests/unit_tests/openvpn/mock_push_dependencies=2Ec
A tests/unit_tes=
ts/openvpn/test_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/uni=
t_tests/openvpn/test_common=2Eh
M tests/unit_tests/openvpn/test_ssl=2Ec
26 =
files changed, 1,536 insertions(+), 23 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/22

diff --git a/CMak=
eLists=2Etxt b/CMakeLists=2Etxt
index 184a95a=2E=2E4deabe7 100644
--- a/CMa=
keLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -435,6 +435,8 @@
     src/compat/co=
mpat-strlcpy=2Ec
     src/compat/compat-strsep=2Ec
     src/compat/compat-s=
trtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/openvpn/acc=2Eh
     src/open=
vpn/argv=2Ec
     src/openvpn/argv=2Eh
     src/openvpn/base64=2Ec
@@ -826,=
6 +828,8 @@
             tests/unit_tests/openvpn/mock_management=2Ec
     =
        tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
             tes=
ts/unit_tests/openvpn/mock_win32_execve=2Ec
+            tests/unit_tests/o=
penvpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
             src/openv=
pn/argv=2Ec
             src/openvpn/base64=2Ec
             src/openvpn/cr=
ypto_epoch=2Ec
@@ -842,6 +846,7 @@
             src/openvpn/packet_id=2Ec
 =
            src/openvpn/run_command=2Ec
             src/openvpn/ssl_mbedtl=
s=2Ec
+            src/openvpn/ssl_ncp=2Ec
             src/openvpn/ssl_ope=
nssl=2Ec
             src/openvpn/ssl_util=2Ec
             src/openvpn/ssl=
_verify_mbedtls=2Ec
diff --git a/doc/man-sections/client-options=2Erst b/do=
c/man-sections/client-options=2Erst
index 87c138a=2E=2E16309f9 100644
--- a=
/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client-option=
s=2Erst
@@ -437,6 +437,12 @@
         Additional authentication methods sup=
ported by the client=2E
         This may be set by the client UI/GUI using=
 ``--setenv``=2E
 
+  :code:`IV_ACC=3D<max_msg_len>,<flags>,<protocols>`
+ =
       If the option ``--app-custom-control`` is set, the client will
+    =
    send the supported max ACC message length, the supported formats
+     =
   as (:code:`A:6`) and the list of configured protocols (e=2Eg=2E
+       =
 :code:`flower:happy:power`)
+
   The following flags depend on which compr=
ession formats are compiled in
   and whether compression is allowed by opt=
ions=2E See `Protocol options`_
   for more details=2E
diff --git a/doc/man=
-sections/management-options=2Erst b/doc/man-sections/management-options=2E=
rst
index 2c79d05=2E=2E315e567 100644
--- a/doc/man-sections/management-opt=
ions=2Erst
+++ b/doc/man-sections/management-options=2Erst
@@ -144,3 +144,1=
7 @@
 
 --management-up-down
   Report tunnel up/down events to management =
interface=2E
+
+--app-custom-control protocol-list
+  Sets the list of supp=
orted app custom control protocols=2E
+  These protocols are announced to t=
he server via the IV_ACC peer info
+  variable when this option is used on =
a client=2E
+  If the option is set on a server it will negotiate common pr=
otocols
+  with the client=2E
+
+  The protocol-list is a : separated list =
of protocol identifiers=2E Protocol
+  identifiers must consist of alphanum=
eric characters, :code:`-`, and
+  :code:`_`=2E
+
+  See management-notes=
=2Etxt in the OpenVPN distribution and the OpenVPN RFC
+  draft for a descr=
iption of app custom control protocol support=2E
diff --git a/doc/man-secti=
ons/script-options=2Erst b/doc/man-sections/script-options=2Erst
index f420=
380f=2E=2E474c7fd 100644
--- a/doc/man-sections/script-options=2Erst
+++ b/=
doc/man-sections/script-options=2Erst
@@ -1006,3 +1006,12 @@
        X509_1=
_L=3DBISHKEK
        X509_1_ST=3DNA
        X509_1_C=3DKG
+
+:code:`acc_pro=
tocols`
+    If ``--app-custom-control`` is configured and the client suppo=
rts any of the
+    protocols that server also supports, this variable cont=
ains a list of
+    common protocols separated by :=2E
+
+:code:`acc_messag=
e_len`
+    if :code:`acc_protocols` is set, this variable contains the max=
imum
+    message length for app custom protocol message=2E
diff --git a/do=
c/management-notes=2Etxt b/doc/management-notes=2Etxt
index 4d726c4=2E=2Ea6=
dcc2f 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2E=
txt
@@ -828,6 +828,58 @@
 that is required to continue the connection (unli=
ke MFA or opening a browser)
 this message is not negotiated but can just b=
e sent as a gratuitous message=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is passed=
 as {EXTRA} OpenVPN will determine
+the common app custom protocols between=
 the client and the server and instruct
+the client that the server will se=
nd control messages to the client using
+the ACC protocol=2E
+
+The server =
should then use client-acc-msg command to send app custom
+control messages=
 to the client to facilitate the pending authentication=2E
+
+COMMAND -- cl=
ient-acc-msg (OpenVPN 2=2E8 or higher)
+-----------------------------------=
--------------
+
+On an OpenVPN instance running in server mode this comman=
d sends an
+app custom control message to a client=2E The format of the com=
mand is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {messa=
ge}
+  END
+
+CID,KID -- client ID and Key ID=2E See documentation for ">CL=
IENT:"
+notification for more info=2E
+
+protocol -- the ACC protocol ident=
ifier that this message should be
+            tagged with=2E
+
+flags    -=
- a colon separated list of the encoding and the flag if
+            the m=
essage is a fragment=2E E=2Eg=2E "6:F" for a base64 encoded
+            me=
ssage that is also a fragment and not complete yet=2E
+
+message  -- The me=
ssage encoded in the encoding specified in flags
+
+
+COMMAND -- acc-msg (O=
penVPN 2=2E8 or higher)
+------------------------------------------
+
+When=
 OpenVPN is running in --client mode this command sends an app
+custom comm=
and to the server=2E The format of the command is
+
+  acc-msg
+  {protocol=
}
+  {flags}
+  {message}
+  END
+
+See the client-acc-msg command for more=
 details about the format of the
+message=2E Since a client has only one pe=
er there is no need to specify the
+client id and key id=2E
+
+
 COMMAND --=
 client-deny  (OpenVPN 2=2E1 or higher)
 ----------------------------------=
-------------
 
@@ -1302,6 +1354,47 @@
    response=2E Mechanisms that need=
 multiple rounds or more complex answers
    should implement a different r=
esponse type than CR_RESPONSE=2E
 
+(6) App custom control message
+
+    T=
his message is an application specific payload message that is transported
=
+    over the OpenVPN control channel=2E
+
+    In server mode:
+
+    >CLI=
ENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}
+
+    In client mod=
e:
+
+    >ACC:{protocol},{fragment},{msg_base64}
+
+    The protocol is a =
short ascii string identifying the app specific custom
+    protocol=2E If =
fragment is set to 1, the message is not complete and the
+    next message=
 should be concatenated to this message to form a complete
+    message=2E
=
+
+    Note that the OpenVPN implementation operates here with the robustne=
ss
+    principle ("be conservative in what you send, be liberal in what yo=
u
+    accept" - RFC 793 and others) and allows receiving messages longer t=
han
+    maximum allowed message length=2E Implementations should be prepar=
ed to
+    handle messages that are longer than the maximum allowed message=
 length=2E
+
+
+(7) App custom control protocol message
+
+   This message =
informs the client about the common ACC
+   protocols and the maximum messa=
ge length for an ACC message=2E
+
+   In client mode:
+
+   >ACC_PROTOCOLS:=
protocols=3D{protocol_list},message_len=3D{max_msg_len}
+
+   protocol_list=
 is the list of supported protocols by both server and client=2E
+   For ex=
ample flower:power:sys_info would indicate these three protocols
+   are su=
pported=2E max_msg_len specifies the maximum message length that the
+   pe=
er supports=2E
+
+   In server mode these information are available in the =
acc_protocols and
+   acc_message_len variables of the client environment=
=2E
 
 Variables:
 
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Ma=
kefile=2Eam
index 8a60a94=2E=2Eebc4db6 100644
--- a/src/openvpn/Makefile=2E=
am
+++ b/src/openvpn/Makefile=2Eam
@@ -45,6 +45,7 @@
 sbin_PROGRAMS =3D ope=
nvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=2Ec argv=2Eh \
 	a=
uth_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
@@ -124,7 +125,8 @=
@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=
=2Ec push_util=2Ec push=2Eh \
+	push=2Ec push=2Eh \
+	push_util=2Ec \
 	pus=
hlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliab=
le=2Eh \
diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec
new file mo=
de 100644
index 0000000=2E=2E860ffa8
--- /dev/null
+++ b/src/openvpn/acc=2E=
c
@@ -0,0 +1,451 @@
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
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2E=
net>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
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
+ *  with this program; if not, write to the Free Software Founda=
tion, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#inclu=
de "syshead=2Eh"
+
+#include <string=2Eh>
+#include "buffer=2Eh"
+#include =
"error=2Eh"
+#include "acc=2Eh"
+#include "forward=2Eh"
+#include "options_=
util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_ncp=2Eh"
+#include "multi=
=2Eh"
+
+enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII =3D 1,
+    =
ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
=
+
+
+static void
+log_acc_message(struct context *c, const struct buffer *b=
uf, int payload_len,
+                const char *protocol, int flags)
+{
+=
    bool fragment =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MA=
NAGEMENT
+    struct gc_arena gc =3D gc_new();
+    const char *payload_msg=
 =3D NULL;
+
+    /* For simplicity, we always encode payload to be base64 =
encoded
+     * if not already in base64 format */
+    if (flags & ACC_MES=
SAGE_FLAGS_ASCII)
+    {
+        char *b64out =3D NULL;
+        ASSERT(op=
envpn_base64_encode(CBPTR(buf), payload_len, &b64out) >=3D 0);
+        gc_=
addspecial(b64out, free, &gc);
+        payload_msg =3D b64out;
+    }
+   =
 else
+    {
+        payload_msg =3D CBSTR(buf);
+    }
+
+    if (managem=
ent)
+    {
+        struct tls_session *session =3D &c->c2=2Etls_multi->se=
ssion[TM_ACTIVE];
+
+        if (c->options=2Emode =3D=3D MODE_SERVER)
+   =
     {
+            /* server mode=2E Report client context */
+           =
 struct man_def_auth_context *mda =3D session->opt->mda_context;
+         =
   unsigned int mda_key_id =3D get_primary_key(c->c2=2Etls_multi)->mda_key_=
id;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+            =
    mda->cid, mda_key_id, protocol, fragment, payload_msg);
+        }
+   =
     else
+        {
+            /* Client mode=2E Do not a report a CLIEN=
T id */
+            msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, pay=
load_msg);
+        }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MAN=
AGEMENT */
+    msg(D_PUSH, "Received custom app control message (protocol =
'%s'%s)",
+        protocol, fragment ? ", fragment" : "");
+}
+
+
+/**
+ *=
  Parses the flags field of an app control message and moves the
+ *  buffe=
r past the flags string=2E If there is an
+ *  error parsing the flags fiel=
d the method returns -1 and
+ *  puts the error reason in err_reason
+ */
+=
static int
+parse_acc_message_flags(struct buffer *buf, const char **err_re=
ason, struct gc_arena *gc)
+{
+    const char *flags =3D buf_extract_field(=
buf, ',', gc);
+
+    if (!flags)
+    {
+        *err_reason =3D "could no=
t extract flags field";
+        return -1;
+    }
+
+
+    int acc_flags =
=3D 0;
+
+    for (const char *flag =3D flags; *flag !=3D '\0'; flag++)
+  =
  {
+        if (*flag =3D=3D 'A')
+        {
+            acc_flags |=3D A=
CC_MESSAGE_FLAGS_ASCII;
+        }
+        else if (*flag =3D=3D '6')
+   =
     {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_BASE64;
+        }
+  =
      else if (*flag =3D=3D 'F')
+        {
+            acc_flags |=3D ACC=
_MESSAGE_FLAGS_FRAGMENT;
+        }
+        else
+        {
+            *=
err_reason =3D "Unknown flag in flags";
+            return -1;
+        }
=
+    }
+    /* The message should be encoded with exactly one encoding=2E E=
nsure that
+     * only one of the flags is present */
+    bool asciienc =
=3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc =3D (b=
ool)(acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc=
 !=3D 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, gc);
+        snpr=
intf(tmp, 512, "number of encodings must be exactly one "
+                =
           "(B64=3D%d, ASCII=3D%d)",
+                 base64enc, asciienc)=
;
+        *err_reason =3D tmp;
+        return -1;
+    }
+
+    return ac=
c_flags;
+}
+
+
+void
+receive_acc_message(struct context *c, const struct =
buffer *buffer)
+{
+    struct gc_arena gc =3D gc_new();
+    const char *e=
rr_reason =3D "";
+
+    /* Example message: ACC,muppets,15,A,I am Miss Pig=
gy */
+    struct buffer buf =3D *buffer;
+
+    const struct tls_multi *mu=
lti =3D c->c2=2Etls_multi;
+    if (!multi->acc_negotiated_protocols)
+    =
{
+        err_reason =3D "ACC not enabled or no negotiated protocols";
+  =
      goto err;
+    }
+
+    if (!buf_advance(&buf, strlen("ACC")) || buf_=
read_u8(&buf) !=3D ',')
+    {
+        err_reason =3D "missing , after ACC=
";
+        goto err;
+    }
+
+    /* extract protocol, payload length, fl=
ags substrings */
+    const char *protocol =3D buf_extract_field(&buf, ','=
, &gc);
+    if (!protocol)
+    {
+        err_reason =3D "could not extra=
ct protocol field";
+        goto err;
+    }
+
+    if (!tls_item_in_ciphe=
r_list(protocol, multi->acc_negotiated_protocols))
+    {
+        struct b=
uffer msg_buf =3D alloc_buf_gc(1024, &gc);
+        buf_printf(&msg_buf, "p=
rotocol '%s' not in list of negotiated protocols '%s'",
+                  =
 protocol, multi->acc_negotiated_protocols);
+        err_reason =3D buf_cs=
tr(&msg_buf);
+
+
+        goto err;
+    }
+
+    /* We do not check the l=
ength here=2E We make no promises to support
+     * anything larger than o=
ur announced message length but according to
+     * the robustness princip=
le
+     * ("be conservative in what you send, be liberal in what you accep=
t" - RFC 793 and others)
+     * we accept also longer messages */
+
+    i=
nt payload_len;
+    const char *payload_len_str =3D buf_extract_field(&buf=
, ',', &gc);
+    if (!payload_len_str
+        || !atoi_constrained(payloa=
d_len_str, &payload_len, "acc_payload_len", 0, TLS_CHANNEL_BUF_SIZE - 1, D_=
PUSH_ERRORS))
+    {
+        err_reason =3D "could not extract payload len=
gth field";
+        goto err;
+    }
+
+    int flags =3D parse_acc_messag=
e_flags(&buf, &err_reason, &gc);
+
+    if (flags < 0)
+    {
+        goto=
 err;
+    }
+
+    /* We should have a final NUL byte in the control messa=
ge buffer
+     * and thus the length of the buffer should be payload_len +=
 1 */
+    if (buf_len(&buf) !=3D payload_len + 1)
+    {
+        char *tm=
p =3D gc_malloc(512, 1, &gc);
+        snprintf(tmp, 512, "field length %d,=
 payload length %d mismatch",
+                 payload_len, buf_len(&buf) =
- 1);
+        err_reason =3D tmp;
+        goto err;
+    }
+
+
+    log_a=
cc_message(c, &buf, payload_len, protocol, flags);
+    gc_free(&gc);
+    =
return;
+
+err:
+    msg(D_PUSH_ERRORS, "WARNING: Received malformed custom=
 app control channel "
+                       "message (%s): %s",
+       =
 err_reason,
+        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+ =
   gc_free(&gc);
+}
+
+
+bool
+send_acc_message(struct context *c,
+       =
          struct tls_multi *multi,
+                 struct tls_session *se=
ssion,
+                 const char *protocol, bool fragment,
+            =
     const char *msg, bool base64)
+{
+    /*
+     * length of the protoco=
l string + one ','
+     * 2 for the encoding (A or 6), potential F (fragme=
nt), and 1 for the ',',
+     * 4 for the message size itself and one comma=

+     * 1 for the comma before the message itself */
+    const size_t max=
_header_size =3D strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+  =
  size_t len =3D max_header_size + strlen(msg);
+
+    if (len > TLS_CHANNE=
L_BUF_SIZE)
+    {
+        msg(M_CLIENT, "message length (%zu) exceeds max=
imum possible message length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        re=
turn false;
+    }
+
+    if ((int)len > multi->acc_max_message_length)
+  =
  {
+        msg(M_CLIENT, "header (%zu) + message size (%zu) length (%zu) =
exceeds "
+                      "maximum allowed length negotiated with pe=
er (%d)",
+            max_header_size, strlen(msg), len,
+            mult=
i->acc_max_message_length);
+        return false;
+    }
+
+    struct gc_=
arena gc =3D gc_new();
+    /* add 1 for the final \0 */
+    struct buffer=
 buf =3D alloc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC,muppets=
,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protoc=
ol,
+               strlen(msg),
+               base64 ? "6" : "A",
+     =
          fragment ? "F" : "",
+               msg);
+
+    bool ret =3D se=
nd_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
+    resched=
ule_multi_process(c);
+    gc_free(&gc);
+    return ret;
+}
+
+char *
+par=
se_acc_parameters(const char *capabilities,
+                     const cha=
r *delim,
+                     int *max_acc_len,
+                     boo=
l server,
+                     struct gc_arena *gc)
+{
+    char *tmp_mess=
age =3D string_alloc(capabilities, NULL);
+    char *tmp_message_orig =3D t=
mp_message;
+    char *lasts =3D NULL;
+
+    const char *token =3D strtok_=
r(tmp_message, delim, &lasts);
+
+    int p =3D 0;
+    int acclen =3D 0;
+=
    const char *protocols =3D NULL;
+    char *ret =3D NULL;
+
+    /* In s=
erver mode we allow more capabilities than our own, in client
+     * mode =
we reject if we should use capabilities that we do not support */
+    int =
allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token=
)
+    {
+        if (p =3D=3D 0 && !atoi_constrained(token, &acclen, "ACC =
message length", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+       =
 {
+            goto done;
+        }
+
+        if (p =3D=3D 1 && (!tls_it=
em_in_cipher_list("A", token) || !tls_item_in_cipher_list("6", token)))
+  =
      {
+            msg(D_PUSH_ERRORS, "App custom control encoding must i=
nclude base64 and ascii");
+            goto done;
+        }
+
+        if=
 (p =3D=3D 1 && !server && strcmp(token, "A:6") && strcmp(token, "6:A"))
+ =
       {
+            msg(D_PUSH_ERRORS, "App custom control encoding must =
be exactly base64 and ascii");
+            goto done;
+        }
+
+      =
  if (p =3D=3D 2)
+        {
+            protocols =3D token;
+        }
+=

+        if (p =3D=3D 3)
+        {
+            msg(D_PUSH_ERRORS, "Too m=
any parameters for INFO ACC message/IV_ACC=2E");
+            goto done;
+ =
       }
+
+        token =3D strtok_r(NULL, delim, &lasts);
+        p++;
=
+    }
+
+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);
+    ret =
=3D string_alloc(protocols, gc);
+
+done:
+    free(tmp_message_orig);
+   =
 return ret;
+}
+
+struct buffer
+get_list_intersection(struct gc_arena *gc=
, const char *list1, const char *list2)
+{
+    char *tmp =3D string_alloc(=
list1, NULL);
+    char *lasts =3D NULL;
+    const char *token =3D strtok_=
r(tmp, ":", &lasts);
+
+    /* The maximum possible length is the shorter o=
f the two input lists */
+    size_t max_len =3D min_size(strlen(list1), st=
rlen(list2));
+
+    struct buffer common_protocols =3D alloc_buf_gc(max_le=
n + 1, gc);
+
+    while (token)
+    {
+        /* check for every items i=
s in both lists and not already in the
+         * common list */
+        =
if (tls_item_in_cipher_list(token, list2)
+            && !tls_item_in_ciph=
er_list(token, buf_cstr(&common_protocols)))
+        {
+            if (bu=
f_len(&common_protocols) > 0)
+            {
+                buf_write_u8(=
&common_protocols, ':');
+            }
+            buf_printf(&common_pro=
tocols, "%s", token);
+        }
+        token =3D strtok_r(NULL, ":", &la=
sts);
+    }
+    free(tmp);
+    return common_protocols;
+}
+
+void
+dete=
rmine_common_acc_protocols(struct tls_multi *multi, struct tls_session *ses=
sion)
+{
+    if (!multi->opt=2Eacc_protocols)
+    {
+        /* No app cu=
stom protocols have been configured server-side=2E */
+        return;
+   =
 }
+
+    if (multi->acc_negotiated_protocols)
+    {
+        /* We alread=
y have determined the common protocols=2E */
+        return;
+    }
+
+   =
 struct gc_arena gc =3D gc_new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6=
:A,flower:power */
+    const char *peer_info =3D multi->peer_info;
+    co=
nst char *iv_acc =3D extract_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+ =
   if (!iv_acc)
+    {
+        gc_free(&gc);
+        return;
+    }
+
+  =
  int max_acc_len =3D 0;
+    const char *protocols =3D parse_acc_parameter=
s(iv_acc, ",", &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+   =
     gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info v=
ariable of peer is malformed");
+        return;
+    }
+
+    struct buffe=
r common_protocols =3D get_list_intersection(&gc, multi->opt=2Eacc_protocol=
s, protocols);
+
+    if (buf_len(&common_protocols) =3D=3D 0)
+    {
+    =
    msg(D_PUSH_DEBUG, "WARNING: No common app custom control protocol=2E");=

+        gc_free(&gc);
+        return;
+    }
+
+    multi->acc_negotiate=
d_protocols =3D string_alloc(buf_str(&common_protocols), NULL);
+    multi-=
>acc_max_message_length =3D max_acc_len;
+
+    setenv_str(session->opt->es=
, "acc_protocols", multi->acc_negotiated_protocols);
+    setenv_int(sessio=
n->opt->es, "acc_message_len", multi->acc_max_message_length);
+
+    gc_fr=
ee(&gc);
+}
+
+void
+notify_client_acc_protocols(struct tls_multi *multi)
+=
{
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        msg(M_CLIE=
NT, ">ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d",
+            multi->a=
cc_negotiated_protocols, multi->acc_max_message_length);
+    }
+#endif
+}
=
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644=

index 0000000=2E=2E2fe9efd
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0=
 +1,113 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP network=
s
+ *             over a single TCP/UDP port, with support for SSL/TLS-base=
d
+ *             session authentication and key exchange,
+ *             =
packet encryption, packet authentication, and
+ *             packet compre=
ssion=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ * =
 Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
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
+ *  with this program; if not, write to the Free Software Foundation, Inc=
=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ *=
/
+
+#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_=
MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses =
an app custom control message and delivers it to the
+ * management interfa=
ce=2E We leave reassembly of fragmented messages to the
+ * management inte=
rface=2E
+ *
+ * @param c            The context struct
+ * @param buffer  =
     Buffer containing the control message with ACC
+ */
+void
+receive_acc=
_message(struct context *c, const struct buffer *buffer);
+
+
+bool
+send_a=
cc_message(struct context *c,
+                 struct tls_multi *tls_multi=
,
+                 struct tls_session *session,
+                 const ch=
ar *protocol, bool fragment,
+                 const char *msg, bool base64=
);
+
+
+/**
+ * Parses an info message from the server that contains app cu=
stom control info
+ * information prior to the PUSH_REPLY to be able to use=
 app custom control
+ * protocols before sending
+ *
+ * In client mode onl=
y allow what we support ourselves=2E In server mode
+ * allow also capabili=
ties that we not support ourselves=2E
+ *
+ * @param capabilities      The =
string to parse
+ * @param delim             The delimiter to use when pars=
ing the string=2E
+ *                          IV_ACC uses "," as delimiter=
 while the
+ *                          custom-control PUSH message uses " =
" as "," is
+ *                          already used to separate different=
 push directives
+ * @param max_acc_len       Set to the maximum ACC messag=
e length
+ * @param server            Whether we are server or client
+ * @=
param gc                The gc arena to use for allocating the resulting st=
ring
+ * @return                  The resulting protocol string or NULL on =
error
+ */
+char *
+parse_acc_parameters(const char *capabilities,
+       =
              const char *delim,
+                     int *max_acc_len,
+ =
                    bool server,
+                     struct gc_arena *gc)=
;
+
+/**
+ * Parses the IV_ACC of the peer and sets multi=2Eacc_negotiated_=
protocols
+ * to the common protocols of server and client and
+ * multi=2E=
acc_max_message_length  to the maximum length of the ACC message
+ * suppor=
t by both server and client=2E
+ *
+ * If there is no common protocol or th=
e client does not support any app custom
+ * protocol multi=2Eacc_negotiate=
d_protocols will be set to NULL=2E
+ *
+ * @param multi      the multi inst=
ance to use the set the app custom protocols=2E
+ * @param session    the s=
ession to read the client env from
+ */
+void
+determine_common_acc_protoco=
ls(struct tls_multi *multi, struct tls_session *session);
+
+/**
+ * Calcul=
ates the intersection of two list that are both separated by :
+ * Items in=
 the result will have the same ordering as in the list1
+ * parameters
+ * =
@param gc            Returned buffer will be allocated in this gc
+ * @para=
m list1         First list to intersect
+ * @param list2         Second lis=
t to intersect=2E
+ * @return A (potentially empty) buffer containing an in=
tersection list
+ */
+struct buffer
+get_list_intersection(struct gc_arena =
*gc, const char *list1, const char *list2);
+
+/**
+ * Notifies a client vi=
a management interface of the negotiated app
+ * custom protocols
+ * @para=
m multi the tls_multi instance of the connection
+ */
+void
+notify_client_=
acc_protocols(struct tls_multi *multi);
+#endif
diff --git a/src/openvpn/fo=
rward=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=2Eeb41d03 100644
--- a=
/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #=
include "dco=2Eh"
 #include "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#i=
nclude "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -257,11 +258,11 @@
     }
  =
   else if (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        ser=
ver_pushed_info(buf, 8);
+        peer_pushed_info(c, buf, 8);
     }
     =
else if (buf_string_match_head_str(buf, "INFO"))
     {
-        server_pus=
hed_info(buf, 4);
+        peer_pushed_info(c, buf, 4);
     }
     else if=
 (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -271,6 +272,10 @=
@
     {
         receive_auth_pending(c, buf);
     }
+    else if (buf_st=
ring_match_head_str(buf, "ACC"))
+    {
+        receive_acc_message(c, buf=
);
+    }
     else if (buf_string_match_head_str(buf, "EXIT"))
     {
    =
     receive_exit_message(c);
diff --git a/src/openvpn/init=2Ec b/src/openv=
pn/init=2Ec
index 1b8b2a5=2E=2Ee0b99a4 100644
--- a/src/openvpn/init=2Ec
++=
+ b/src/openvpn/init=2Ec
@@ -56,6 +56,7 @@
 #include "schedule=2Eh"
 #inclu=
de "options_string=2Eh"
 #include "resolve=2Eh"
+#include "acc=2Eh"
 
 #inc=
lude "memdbg=2Eh"
 
@@ -2279,6 +2280,13 @@
         }
     }
 
+    struct =
tls_multi *multi =3D c->c2=2Etls_multi;
+    if (multi && multi->acc_negoti=
ated_protocols)
+    {
+        buf_printf(&out, " custom-control %d A:6 %s=
",
+                   multi->acc_max_message_length, multi->acc_negotiated=
_protocols);
+    }
+
     if (BLENZ(&out) > strlen(header))
     {
       =
  msg(D_HANDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +2530,11 @@
         flags=
 |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_pro=
tocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }
+
     return flags;
 =
}
 
@@ -2730,6 +2743,18 @@
         frame->tun_mtu =3D min_int(frame->tun_m=
ax_mtu, c->options=2Ece=2Etun_mtu);
     }
 
+    if (found & OPT_P_ACC && =
c->options=2Epushed_acc_negotiated_protocols)
+    {
+        struct tls_mu=
lti *multi =3D c->c2=2Etls_multi;
+        free(multi->acc_negotiated_proto=
cols);
+        multi->acc_negotiated_protocols =3D string_alloc(c->options=
=2Epushed_acc_negotiated_protocols, NULL);
+        multi->acc_max_message_=
length =3D c->options=2Epushed_acc_max_message_length;
+
+        msg(D_PUS=
H, "OPTIONS IMPORT: ACC protocols: %s, msg len: %d",
+            multi->ac=
c_negotiated_protocols, multi->acc_max_message_length);
+        notify_cli=
ent_acc_protocols(multi);
+    }
+
     return true;
 }
 
@@ -3352,6 +3377,=
7 @@
     to=2Everify_hash_depth =3D options->verify_hash_depth;
     to=2E=
verify_hash_no_ca =3D options->verify_hash_no_ca;
     memcpy(to=2Ex509_use=
rname_field, options->x509_username_field, sizeof(to=2Ex509_username_field)=
);
+    to=2Eacc_protocols =3D options->acc_protocols;
     to=2Ees =3D c->=
c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4306,6 +4332,24 @@
 }
 #e=
ndif /* ifdef TARGET_ANDROID */
 
+static bool
+management_acc_msg(void *ar=
g,
+                   struct buffer_list *input) /* ownership transferred =
*/
+{
+    struct context *c =3D arg;
+
+    bool ret =3D false;
+    if (b=
uffer_list_defined(input) && c->c2=2Etls_multi)
+    {
+        struct tls_=
multi *multi =3D c->c2=2Etls_multi;
+        struct tls_session *session =
=3D &multi->session[TM_ACTIVE];
+
+        ret =3D management_send_acc_mess=
age(c, multi, session, input);
+    }
+
+    buffer_list_free(input);
+    =
return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4322,6 +43=
66,7 @@
         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;
        =
 cb=2Eremote_cmd =3D management_callback_remote_cmd;
         cb=2Esend_cc_=
message =3D management_callback_send_cc_message;
+        cb=2Eacc_msg =3D =
management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Enetwork_change =3D=
 management_callback_network_change;
 #endif
diff --git a/src/openvpn/manag=
e=2Ec b/src/openvpn/manage=2Ec
index ac3d4b7=2E=2E5e4e416 100644
--- a/src/=
openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -45,9 +45,11 @@
 #includ=
e "push=2Eh"
 #include "multi=2Eh"
 #include "resolve=2Eh"
+#include "acc=
=2Eh"
 
 #include "memdbg=2Eh"
 #include "run_command=2Eh"
+#include "ssl_n=
cp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -1081,6 +1083,35 =
@@
             }
             break;
 
+        case IEC_CLIENT_ACC_MSG:
+=
            if (man->persist=2Ecallback=2Eclient_acc_msg)
+            {
+ =
               bool status =3D (*man->persist=2Ecallback=2Eclient_acc_msg)(=
man->persist=2Ecallback=2Earg,
+                                           =
                           man->connection=2Ein_extra_cid,
+               =
                                                       man->connection=2Ein=
_extra_kid,
+                                                              =
        man->connection=2Ein_extra);
+                man->connection=2Ein_=
extra =3D NULL;
+                report_command_status(status, "client-acc-=
msg");
+            }
+            else
+            {
+                man=
_command_unsupported("client-acc-msg");
+            }
+            break;
=
+
+        case IEC_ACC_MSG:
+            if (man->persist=2Ecallback=2Eacc=
_msg)
+            {
+                bool status =3D (*man->persist=2Ecall=
back=2Eacc_msg)(man->persist=2Ecallback=2Earg,
+                           =
                                    man->connection=2Ein_extra);
+         =
       man->connection=2Ein_extra =3D NULL;
+                report_command=
_status(status, "acc-msg");
+            }
+            else
+            {=

+                man_command_unsupported("acc-msg");
+            }
+     =
       break;
         case IEC_PK_SIGN:
             man->connection=2Eext=
_key_state =3D EKS_READY;
             buffer_list_free(man->connection=2Ee=
xt_key_input);
@@ -1205,6 +1236,29 @@
 }
 
 static void
+man_client_acc_msg=
(struct management *man, const char *cid_str,
+                   const cha=
r *kid_str)
+{
+    struct man_connection *mc =3D &man->connection;
+    mc=
->in_extra_cid =3D 0;
+    mc->in_extra_kid =3D 0;
+    if (parse_cid(cid_s=
tr, &mc->in_extra_cid)
+        && parse_uint(kid_str, "KID", &mc->in_extra=
_kid))
+    {
+        mc->in_extra_cmd =3D IEC_CLIENT_ACC_MSG;
+        in=
_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void
+man_acc_msg(struct man=
agement *man)
+{
+    struct man_connection *mc =3D &man->connection;
+    =
mc->in_extra_cmd =3D IEC_ACC_MSG;
+    in_extra_reset(mc, IER_NEW);
+}
+
+s=
tatic void
 man_client_auth(struct management *man, const char *cid_str, co=
nst char *kid_str, const bool extra)
 {
     struct man_connection *mc =3D =
&man->connection;
@@ -1759,6 +1813,17 @@
             man_client_pending_au=
th(man, p[1], p[2], p[3], p[4]);
         }
     }
+    else if (streq(p[0]=
, "client-acc-msg"))
+    {
+        if (man_need(p, 2, 0))
+        {
+   =
         man_client_acc_msg(man, p[1], p[2]);
+        }
+    }
+    else i=
f (streq(p[0], "acc-msg"))
+    {
+        man_acc_msg(man);
+    }
     el=
se if (streq(p[0], "rsa-sig"))
     {
         man_pk_sig(man, "rsa-sig");
=
@@ -2975,7 +3040,9 @@
                                        "bytes_sent=
=3D",
                                        "bytes_received=3D",
        =
                                "session_id=3D",
-                         =
              "session_state=3D" };
+                                      =
 "session_state=3D",
+                                       "acc_protocols=
=3D",
+                                       "acc_message_len=3D" };
 
   =
  if (env_filter_level =3D=3D 0)
     {
@@ -3130,6 +3197,7 @@
     }
 }
 
+=

 void
 management_connection_established(struct management *man, struct ma=
n_def_auth_context *mdac,
                                   const struct e=
nv_set *es)
@@ -4372,6 +4440,64 @@
     }
 }
 
+bool
+management_send_acc_m=
essage(struct context *c, struct tls_multi *multi, struct tls_session *sess=
ion,
+                            struct buffer_list *input)
+{
+    /* als=
o ensures that are enough inputs in the list to safely call
+     * buffer_=
list_peek without extra NULL checks */
+    if (!input || input->size < 3)
=
+    {
+        msg(M_CLIENT, "not enough input lines for sending acc messa=
ge, "
+                      "missing protocol, flag and/or messages lines"=
);
+        return false;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
=
+    const struct buffer *proto_buf =3D buffer_list_peek(input);
+    const=
 char *protocol =3D string_alloc(CBSTR(proto_buf), &gc);
+    buffer_list_p=
op(input);
+
+    struct buffer *encoding_buf =3D buffer_list_peek(input);
=
+    char *encoding =3D buf_str(encoding_buf);
+    const char *flag =3D NU=
LL;
+    bool b64encoding =3D false;
+    bool fragment =3D false;
+
+    w=
hile ((flag =3D strsep(&encoding, ":")))
+    {
+        if (!strcmp(flag, =
"6"))
+        {
+            b64encoding =3D true;
+        }
+        els=
e if (!strcmp(flag, "F"))
+        {
+            fragment =3D true;
+     =
   }
+    }
+    buffer_list_pop(input);
+
+    buffer_list_aggregate_separ=
ator(input, 10000, "");
+    const struct buffer *acc_msg_buf =3D buffer_li=
st_peek(input);
+
+    if (!multi->acc_negotiated_protocols
+        || !tl=
s_item_in_cipher_list(protocol, multi->acc_negotiated_protocols))
+    {
+ =
       msg(M_CLIENT, "protocol not in the list of negotiated protocols: %s"=
,
+            np(multi->acc_negotiated_protocols));
+        goto error;
+=
    }
+
+    bool ret =3D send_acc_message(c, multi, session, protocol,
+  =
                              fragment, buf_cstr(acc_msg_buf),
+           =
                     b64encoding);
+    gc_free(&gc);
+    return ret;
+err=
or:
+    gc_free(&gc);
+    return false;
+}
 #else /* ifdef ENABLE_MANAGEM=
ENT */
 
 #include "win32=2Eh"
diff --git a/src/openvpn/manage=2Eh b/src/op=
envpn/manage=2Eh
index 157039d=2E=2Ecc9c264 100644
--- a/src/openvpn/manage=
=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 @@
     int (*n_client=
s)(void *arg);
     bool (*send_cc_message)(void *arg, const char *message,=
 const char *parameter);
     bool (*kill_by_cid)(void *arg, const unsigned=
 long cid, const char *kill_msg);
+
     bool (*client_auth)(void *arg, con=
st unsigned long cid, const unsigned int mda_key_id,
                      =
   const bool auth, const char *reason, const char *client_reason,
        =
                 struct buffer_list *cc_config); /* ownership transferred *=
/
     bool (*client_pending_auth)(void *arg, const unsigned long cid, cons=
t unsigned int kid,
                                 const char *extra, uns=
igned int timeout);
     char *(*get_peer_info)(void *arg, const unsigned l=
ong cid);
+    bool (*client_acc_msg)(void *arg,
+                         =
  const unsigned long cid,
+                           const unsigned int m=
da_key_id,
+                           struct buffer_list *msg);
+    bool =
(*acc_msg)(void *arg,
+                    struct buffer_list *msg);
     b=
ool (*proxy_cmd)(void *arg, const char **p);
     bool (*remote_cmd)(void *=
arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@
     str=
uct command_line *in;
     struct buffer_list *out;
 
-#define IEC_UNDEF   =
    0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#define IEC=
_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */
-#defi=
ne IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SIGN     5
=
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN       3
+#define IEC_CERTI=
FICATE    4
+#define IEC_PK_SIGN        5
+#define IEC_PASSWORD       6
+#d=
efine IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG        8
     int in_extra_=
cmd;
     struct buffer_list *in_extra;
     unsigned long in_extra_cid;
@@=
 -503,6 +512,14 @@
 
 void man_persist_client_stats(struct management *man,=
 struct context *c);
 
+/** Parses the ACC message from the input buffer_li=
st and send to the
+ * session identified by session and multi
+ */
+struct=
 tls_session;
+struct tls_multi;
+bool
+management_send_acc_message(struct =
context *c, struct tls_multi *multi,
+                            struct tl=
s_session *session, struct buffer_list *input);
 #endif /* ifdef ENABLE_MAN=
AGEMENT */
 
 /**
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c
index e302a81=2E=2Ea3eb3ca 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/o=
penvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #include "ssl_util=2Eh"
 #include "dco=
=2Eh"
 #include "reflect_filter=2Eh"
+#include "acc=2Eh"
 
 /*#define MULTI=
_DEBUG_EVENT_LOOP*/
 
@@ -4085,6 +4086,26 @@
     }
 }
 
+static const char=
 *
+calculate_app_control_extra(struct multi_instance *mi, struct gc_arena =
*gc)
+{
+    struct context *c =3D &mi->context;
+    struct tls_multi *mul=
ti =3D c->c2=2Etls_multi;
+
+    if (!multi->acc_negotiated_protocols)
+   =
 {
+        msg(M_CLIENT, "ACC: No negotiated protocols");
+        return =
NULL;
+    }
+
+    struct buffer buf =3D alloc_buf_gc(1024, gc);
+
+    bu=
f_printf(&buf, "ACC:%d A:6 %s", multi->acc_max_message_length,
+           =
    multi->acc_negotiated_protocols);
+    return buf_str(&buf);
+}
+
+
 st=
atic bool
 management_client_pending_auth(void *arg, const unsigned long ci=
d, const unsigned int mda_key_id,
                                const cha=
r *extra, unsigned int timeout)
@@ -4095,10 +4116,22 @@
     if (mi)
     {=

         struct tls_multi *multi =3D mi->context=2Ec2=2Etls_multi;
+
+    =
    struct gc_arena gc =3D gc_new();
+        if (!strcmp(extra, "ACC"))
+ =
       {
+            extra =3D calculate_app_control_extra(mi, &gc);
+    =
        if (!extra)
+            {
+                gc_free(&gc);
+        =
        return false;
+            }
+        }
         struct tls_session=
 *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);
 
         i=
f (!session)
         {
+            gc_free(&gc);
             return fals=
e;
         }
 
@@ -4106,6 +4139,7 @@
         bool ret =3D send_auth_pendi=
ng_messages(multi, session, extra, timeout);
         reschedule_multi_proc=
ess(&mi->context);
         multi_schedule_context_wakeup(m, mi);
+        =
gc_free(&gc);
         return ret;
     }
     return false;
@@ -4149,6 +41=
83,37 @@
     return ret;
 }
 
+
+static bool
+management_client_acc_msg(vo=
id *arg,
+                          const unsigned long cid,
+             =
             const unsigned int mda_key_id,
+                          stru=
ct buffer_list *input) /* ownership transferred */
+{
+    struct multi_con=
text *m =3D (struct multi_context *)arg;
+    struct multi_instance *mi =3D=
 lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+    if (mi && buffer_li=
st_defined(input))
+    {
+        struct tls_multi *multi =3D mi->context=
=2Ec2=2Etls_multi;
+        struct tls_session *session =3D lookup_session_=
by_mda_key_id(multi, mda_key_id);
+        if (!session)
+        {
+      =
      msg(M_CLIENT, "client session not found");
+            buffer_list_f=
ree(input);
+            return false;
+        }
+
+        ret =3D manage=
ment_send_acc_message(&mi->context, multi, session, input);
+        multi_=
schedule_context_wakeup(m, mi);
+    }
+
+    buffer_list_free(input);
+   =
 return ret;
+}
+
+
 static char *
 management_get_peer_info(void *arg, con=
st unsigned long cid)
 {
@@ -4185,6 +4250,7 @@
         cb=2En_clients =3D =
management_callback_n_clients;
         cb=2Ekill_by_cid =3D management_kil=
l_by_cid;
         cb=2Eclient_auth =3D management_client_auth;
+        cb=
=2Eclient_acc_msg =3D management_client_acc_msg;
         cb=2Eclient_pendi=
ng_auth =3D management_client_pending_auth;
         cb=2Eget_peer_info =3D=
 management_get_peer_info;
         cb=2Epush_update_broadcast =3D manageme=
nt_callback_send_push_update_broadcast;
diff --git a/src/openvpn/options=2E=
c b/src/openvpn/options=2Ec
index fb319ae=2E=2Ea5e7396 100644
--- a/src/ope=
nvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6 +35,7 @@
 
 #includ=
e "syshead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=2Eh"
 #include "err=
or=2Eh"
 #include "common=2Eh"
@@ -2552,6 +2553,8 @@
     o->push_option_ty=
pes_found =3D 0;
     o->push_update_options_found =3D 0;
     o->imported_=
protocol_flags =3D 0;
+    o->pushed_acc_max_message_length =3D 0;
+    o->=
pushed_acc_negotiated_protocols =3D NULL;
 }
 
 static void
@@ -7107,6 +711=
0,47 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->force_=
key_material_export =3D true;
     }
+    else if (streq(p[0], "app-custom-=
control") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL=
);
+        if (!string_class(p[1], CC_ALNUM | CC_COLON | CC_UNDERBAR | CC_=
DASH, 0))
+        {
+            msg(msglevel, "App custom control protoco=
ls must only contain "
+                          "alphanumeric characters,=
 '-', and '_'=2E");
+            goto err;
+        }
+        options->acc=
_protocols =3D p[1];
+    }
+    else if (streq(p[0], "custom-control") && =
p[1] && p[2] && p[3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_ACC)=
;
+
+        /* check if the list from the server is a real subset of our l=
ist */
+        struct gc_arena gc_local =3D gc_new();
+        struct buff=
er common_list =3D get_list_intersection(&gc_local, p[3], options->acc_prot=
ocols);
+
+        if (buf_len(&common_list) =3D=3D 0 || !streq(p[3], buf_c=
str(&common_list)))
+        {
+            msg(msglevel, "App custom contr=
ol list from server contains "
+                          "unsupported prot=
ocols");
+            gc_free(&gc_local);
+            goto err;
+        }=

+        gc_free(&gc_local);
+
+        if (!streq(p[2], "6:A") && !streq(=
p[2], "A:6"))
+        {
+            msg(msglevel, "App custom control enc=
oding must be base64 and ascii");
+            goto err;
+        }
+
+    =
    if (!atoi_constrained(p[1], &options->pushed_acc_max_message_length,
+ =
                             "app custom message message length", ACC_MIN_M=
SG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        {
+            goto err;
+    =
    }
+        options->pushed_acc_negotiated_protocols =3D p[3];
+    }
  =
   else if (streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WAR=
N, "NOTICE: --prng option ignored (SSL library PRNG is used)");
diff --git =
a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index 6a3bf61=2E=2Eb794=
5e0 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -=
715,6 +715,18 @@
     /* force using TLS key material export for data chann=
el key generation */
     bool force_key_material_export;
 
+    /** The ap=
p custom control protocols we should announce as supported */
+    const ch=
ar *acc_protocols;
+
+    /** the protocols that are negotiated with the pe=
er=2E This is a
+     *  a temporary variable since options=2Ec push parser=
 cannot access
+     *  tls multi struct */
+    const char *pushed_acc_neg=
otiated_protocols;
+
+    /** the maximum length of an ACC control channel =
message via push message
+     * */
+    int pushed_acc_max_message_length;=

+
     bool vlan_tagging;
     enum vlan_acceptable_frames vlan_accept;
  =
   uint16_t vlan_pvid;
@@ -764,8 +776,10 @@
 #define OPT_P_INLINE          =
(1u << 29)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_T=
ABLE     (1u << 31)
+#define OPT_P_ACC             (1ull << 32)
 
-#define =
OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull)=
)
+/* Options allowed in the normal configuration file (vs pushed options o=
r in ccd files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MO=
DE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((opt)->pull)=

 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 42259c3=
=2E=2Ea18f33b 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
=
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh"
+
+#includ=
e "acc=2Eh"
 #include "options=2Eh"
 #include "crypto=2Eh"
 #include "ssl=
=2Eh"
@@ -221,9 +223,56 @@
 #endif
 }
 
+static void
+parse_server_pushed_i=
nfo_acc(struct context *c, struct buffer *buf)
+{
+    int max_acc_len =3D =
0;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (multi->ac=
c_negotiated_protocols)
+    {
+        return;
+    }
+
+    if (!multi->o=
pt=2Eacc_protocols || !c->options=2Epull)
+    {
+        msg(D_PUSH_ERRORS=
, "Peer tried to push app custom control list "
+                          =
 "without client announcing support for it");
+        return;
+    }
+
+  =
  /* example string to parse: ACC:1400 A:6 flower:happy */
+    /* Skip ove=
r the ACC: prefix */
+    buf_advance(buf, 4);
+
+    struct gc_arena gc =
=3D gc_new();
+    const char *protocols =3D parse_acc_parameters(buf_cstr(=
buf), " ", &max_acc_len, false, &gc);
+    if (!protocols)
+    {
+        =
msg(D_PUSH_ERRORS, "WARNING: Received ACC info command with invalid paramet=
ers");
+        gc_free(&gc);
+        return;
+    }
+
+    /* check if th=
e list from the server is a real subset of our list */
+    struct buffer c=
ommon_list =3D get_list_intersection(&gc, protocols, multi->opt=2Eacc_proto=
cols);
+
+    if (buf_len(&common_list) =3D=3D 0 || !streq(protocols, buf_c=
str(&common_list)))
+    {
+        msg(D_PUSH_ERRORS, "App custom control =
list from server contains "
+                           "unsupported protoc=
ols");
+        gc_free(&gc);
+        return;
+    }
+
+    multi->acc_neg=
otiated_protocols =3D string_alloc(protocols, NULL);
+    multi->acc_max_me=
ssage_length =3D max_acc_len;
+    notify_client_acc_protocols(multi);
+   =
 gc_free(&gc);
+}
 
 void
-server_pushed_info(const struct buffer *buffer, =
const int adv)
+peer_pushed_info(struct context *c, const struct buffer *bu=
ffer, const int adv)
 {
     const char *m =3D "";
     struct buffer buf =
=3D *buffer;
@@ -233,6 +282,12 @@
         m =3D BSTR(&buf);
     }
 
+    =
if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        parse_server_pushed_inf=
o_acc(c, &buf);
+        return;
+    }
+
 #ifdef ENABLE_MANAGEMENT
     st=
ruct gc_arena gc;
     if (management)
@@ -257,7 +312,7 @@
         gc_free=
(&gc);
     }
 #endif
-    msg(D_PUSH, "Info command was pushed by server (=
'%s')", m);
+    msg(D_PUSH, "Info command was pushed by peer ('%s')", m);
=
 }
 
 void
@@ -285,6 +340,7 @@
     msg(D_PUSH, "CR response was sent by cl=
ient ('%s')", m);
 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING re=
quest
  * @param buffer                buffer containing the keywords, the =
buffer's
@@ -441,7 +497,6 @@
     const char *const peer_info =3D tls_multi=
->peer_info;
     unsigned int proto =3D extract_iv_proto(peer_info);
 
-
 =
    /* Calculate the maximum timeout and subtract the time we already waite=
d */
     unsigned int max_timeout =3D
         max_uint(tls_multi->opt=2Er=
enegotiate_seconds / 2, tls_multi->opt=2Ehandshake_window);
@@ -732,6 +787,=
12 @@
                 client_max_mtu, o->ce=2Etun_mtu, o->ce=2Etun_mtu);
 =
        }
     }
+
+    if (tls_multi->acc_negotiated_protocols)
+    {
+  =
      push_option_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s",
+=
                        tls_multi->acc_max_message_length, tls_multi->acc_n=
egotiated_protocols);
+    }
 }
 
 static bool
diff --git a/src/openvpn/pus=
h=2Eh b/src/openvpn/push=2Eh
index 39302f6=2E=2Ee08cd66 100644
--- a/src/op=
envpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +52,7 @@
 
 int process_=
incoming_push_request(struct context *c);
 
+
 /**
  * @brief Handles the r=
eceiving of a push-update message and applies updates to the specified
  * =
options=2E
@@ -92,7 +93,15 @@
 
 void receive_exit_message(struct context *=
c);
 
-void server_pushed_info(const struct buffer *buffer, const int adv);=

+/**
+ * This message is called when an INFO or INFO_PRE message is receiv=
ed from
+ * a peer=2E
+ *
+ * @param c         Context of the peer=2E
+ * @=
param buffer    Buffer containing the INFO/INFO_PRE message=2E
+ * @param a=
dv       number of character to advance past the INFO/INFO_PRE header
+ */
=
+void peer_pushed_info(struct context *c, const struct buffer *buffer, cons=
t int adv);
 
 void receive_cr_response(struct context *c, const struct buf=
fer *buffer);
 
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
inde=
x 086a6fc=2E=2E0a25149 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/s=
sl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"=

+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #include "ssl_backend=2Eh"=

 #include "ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
     free(multi->locked_cn);=

     free(multi->locked_username);
     free(multi->locked_original_userna=
me);
+    free(multi->acc_negotiated_protocols);
 
     cert_hash_free(mult=
i->locked_cert_hash_set);
 
@@ -2098,6 +2100,11 @@
 #endif
         }
 
+  =
      if (session->opt->acc_protocols)
+        {
+            buf_printf(&=
out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);=

+        }
+
         if (session->opt->push_peer_info_detail > 1)
       =
  {
             struct env_set *es =3D session->opt->es;
@@ -2398,6 +2405,=
8 @@
         multi->remote_ciphername =3D string_alloc("none", NULL);
    =
 }
 
+    determine_common_acc_protocols(multi, session);
+
     if (userna=
me_len < 0 || password_len < 0)
     {
         msg(D_TLS_ERRORS, "TLS Erro=
r: Username (%d) or password (%d) too long", abs(username_len),
diff --git =
a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9a55ead=2E=
=2E436770b 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_co=
mmon=2Eh
@@ -457,6 +457,9 @@
     size_t ekm_size;
 
     bool dco_enabled;=
 /**< Whether keys have to be installed in DCO or not */
+
+    /** The app=
 custom control protocols we should announce as supported */
+    const cha=
r *acc_protocols;
 };
 
 /** @addtogroup control_processor
@@ -730,6 +733,1=
2 @@
     int dco_peer_id;
 
     dco_context_t *dco;
+
+    /** the protoc=
ols that are negotiated with the peer=2E */
+    char *acc_negotiated_proto=
cols;
+
+    /** the maximum length of an ACC control channel message */
+ =
   int acc_max_message_length;
 };
 
 /**  gets an item  of \c key_state ob=
jects in the
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/un=
it_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E6a73e1e 100644
--- a/test=
s/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=
=2Eam
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TE=
ST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=
=2Ec \
+	test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_commo=
n=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_exec=
ve=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/sr=
c/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/=
src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -132,6=
 +134,7 @@
 	$(top_srcdir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+=
	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_ut=
il=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdi=
r)/src/openvpn/ssl_verify_openssl=2Ec \
diff --git a/tests/unit_tests/openv=
pn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index=
 fff4c2b=2E=2Ef572dbb 100644
--- a/tests/unit_tests/openvpn/mock_management=
=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
 =

 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 
=
 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/unit_tests/openvpn/mock_push_d=
ependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
index=
 bf2ccf3=2E=2Ef083f89 100644
--- a/tests/unit_tests/openvpn/mock_push_depen=
dencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ -4=
3,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_=
SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SHAP=
ER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      | OPT_P=
_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-         =
            | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OP=
T_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH=
_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
     =
return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tes=
ts/unit_tests/openvpn/test_acc=2Ec
new file mode 100644
index 0000000=2E=2E=
9364d12
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,0 +=
1,353 @@
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
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  C=
opyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This progr=
am is free software; you can redistribute it and/or modify
+ *  it under th=
e terms of the GNU General Public License version 2
+ *  as published by th=
e Free Software Foundation=2E
+ *
+ *  This program is distributed in the h=
ope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the=
 implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPO=
SE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ * =
 You should have received a copy of the GNU General Public License along
+ =
*  with this program; if not, write to the Free Software Foundation, Inc=2E=
,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+=

+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=
=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+#include <stdarg=2Eh>=

+#include <string=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#i=
nclude "acc=2Eh"
+#include "test_acc=2Eh"
+#include "test_common=2Eh"
+
+#i=
nclude "mock_msg=2Eh"
+#include "multi=2Eh"
+
+char control_channel_message=
_sent[2048];
+
+/* Mock functions */
+bool
+send_control_channel_string_dow=
ork(struct tls_session *session,
+                                   const =
char *str, unsigned int msglevel)
+{
+    assert_int_in_range(strlen(str), =
0, 2047);
+
+    strcpy(control_channel_message_sent, str);
+    return tru=
e;
+}
+
+void
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
=
+void
+auth_set_client_reason(struct tls_multi *multi, const char *reason)
=
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"     =
           \
+                    "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/n=
otFT0cF1d60nTS" \
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyq=
wCvALwCewCTAKABrwCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BA=
AEAAAsABAMAAQIACgAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBA=
AWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwg=
ECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIB=
AQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9=
eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_messages(void **state)
+{
+=
#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    /* ensure that the messa=
ges get to mock_msg */
+    x_debug_level =3D 3;
+    management =3D (void =
*)0x12345678;
+    struct gc_arena gc =3D gc_new();
+
+    /* contains a TL=
S 1=2E3 ClientHello */
+    const char msg[] =3D "ACC,cck1,384,6," MSG_PAYL=
OAD;
+
+    struct buffer msg_buf;
+    struct context c =3D { 0 };
+    c=
=2Eoptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_m=
ulti, struct tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->session[TM_ACTIVE]=
=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->session[TM_AC=
TIVE]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
+    buf_set_read(&msg_=
buf, (void *)msg, sizeof(msg));
+
+    receive_acc_message(&c, &msg_buf);
+=
    assert_string_equal(mock_msg_buf, "WARNING: Received malformed custom a=
pp control channel message (ACC not enabled or no negotiated protocols): 41=
43432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more=
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
Gerrit-PatchSet: 22
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <=
charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--gGpYsIFKM8c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #22</strong> to this change=2E</p><p>=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vie=
w Change</a></p><p>The following approvals got outdated and were removed:
C=
ode-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">Implement sending/rec=
eiving app custom control protocol messages<br><br>This allows openvpn GUI/=
front-ends and server via management<br>to use the OpenVPN control channel =
to pass messages between each other<br>while OpenVPN handles the marshallin=
g/unmarshalling of these and<br>negotiate the common app custom control pro=
tocols=2E<br><br>This provides an easy to use secure channel that does not =
depend on<br>the network itself to work and can also be used before fully<b=
r>authenticating the client=2E See the management-notes=2Etxt for more<br>d=
etails how to use this feature=2E An upcoming patch will also add<br>some e=
xample python scripts that showcase this feature=2E<br><br>Change-Id: I4a6a=
6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Schwabe &lt;arn=
e@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sections/clie=
nt-options=2Erst<br>M doc/man-sections/management-options=2Erst<br>M doc/ma=
n-sections/script-options=2Erst<br>M doc/management-notes=2Etxt<br>M src/op=
envpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=2Eh<br>M =
src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=
=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvp=
n/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M s=
rc/openvpn/push=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2E=
h<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn=
/mock_management=2Ec<br>M tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Ec<br>A tests/unit_tests/openv=
pn/test_acc=2Eh<br>M tests/unit_tests/openvpn/test_common=2Eh<br>M tests/un=
it_tests/openvpn/test_ssl=2Ec<br>26 files changed, 1,536 insertions(+), 23 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/58/1858/22</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2E=
txt b/CMakeLists=2Etxt</span><br><span>index 184a95a=2E=2E4deabe7 100644</s=
pan><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt=
</span><br><span>@@ -435,6 +435,8 @@</span><br><span>     src/compat/compat=
-strlcpy=2Ec</span><br><span>     src/compat/compat-strsep=2Ec</span><br><s=
pan>     src/compat/compat-strtok_r=2Ec</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</span><br><span>     src/op=
envpn/argv=2Ec</span><br><span>     src/openvpn/argv=2Eh</span><br><span>  =
   src/openvpn/base64=2Ec</span><br><span>@@ -826,6 +828,8 @@</span><br><sp=
an>             tests/unit_tests/openvpn/mock_management=2Ec</span><br><spa=
n>             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec</span><br=
><span>             tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests=
/openvpn/test_acc=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            src/openvpn/acc=2Ec</span><br><span>             src/openvpn/=
argv=2Ec</span><br><span>             src/openvpn/base64=2Ec</span><br><spa=
n>             src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -842,6 +846,=
7 @@</span><br><span>             src/openvpn/packet_id=2Ec</span><br><span=
>             src/openvpn/run_command=2Ec</span><br><span>             src/=
openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            src/openvpn/ssl_ncp=2Ec</span><br><span>             src/op=
envpn/ssl_openssl=2Ec</span><br><span>             src/openvpn/ssl_util=2Ec=
</span><br><span>             src/openvpn/ssl_verify_mbedtls=2Ec</span><br>=
<span>diff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections=
/client-options=2Erst</span><br><span>index 87c138a=2E=2E16309f9 100644</sp=
an><br><span>--- a/doc/man-sections/client-options=2Erst</span><br><span>++=
+ b/doc/man-sections/client-options=2Erst</span><br><span>@@ -437,6 +437,12=
 @@</span><br><span>         Additional authentication methods supported by=
 the client=2E</span><br><span>         This may be set by the client UI/GU=
I using ``--setenv``=2E</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  :code:`IV_ACC=3D&lt;max_msg_len&gt;,&lt;flags&gt;,&=
lt;protocols&gt;`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      If the option ``--app-custom-control`` is set, the client will</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        send the supported=
 max ACC message length, the supported formats</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        as (:code:`A:6`) and the list of configu=
red protocols (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        :code:`flower:happy:power`)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>   The following flags depend on which=
 compression formats are compiled in</span><br><span>   and whether compres=
sion is allowed by options=2E See `Protocol options`_</span><br><span>   fo=
r more details=2E</span><br><span>diff --git a/doc/man-sections/management-=
options=2Erst b/doc/man-sections/management-options=2Erst</span><br><span>i=
ndex 2c79d05=2E=2E315e567 100644</span><br><span>--- a/doc/man-sections/man=
agement-options=2Erst</span><br><span>+++ b/doc/man-sections/management-opt=
ions=2Erst</span><br><span>@@ -144,3 +144,17 @@</span><br><span> </span><br=
><span> --management-up-down</span><br><span>   Report tunnel up/down event=
s to management interface=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-cust=
om-control protocol-list</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  Sets the list of supported app custom control protocols=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  These protocols are announc=
ed to the server via the IV_ACC peer info</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  variable when this option is used on a client=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  If the option is set=
 on a server it will negotiate common protocols</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  with the client=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  The protocol-list is a : separated list of protocol identifiers=
=2E Protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ident=
ifiers must consist of alphanumeric characters, :code:`-`, and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  :code:`_`=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  See management-notes=2Etxt in the OpenVPN distribution=
 and the OpenVPN RFC</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  draft for a description of app custom control protocol support=2E</span>=
<br><span>diff --git a/doc/man-sections/script-options=2Erst b/doc/man-sect=
ions/script-options=2Erst</span><br><span>index f420380f=2E=2E474c7fd 10064=
4</span><br><span>--- a/doc/man-sections/script-options=2Erst</span><br><sp=
an>+++ b/doc/man-sections/script-options=2Erst</span><br><span>@@ -1006,3 +=
1006,12 @@</span><br><span>        X509_1_L=3DBISHKEK</span><br><span>     =
   X509_1_ST=3DNA</span><br><span>        X509_1_C=3DKG</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+:code:`acc_protocols`</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    If ``--app-custom-control`` is configured and the cl=
ient supports any of the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    protocols that server also supports, this variable contains a list=
 of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    common proto=
cols separated by :=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`acc_messa=
ge_len`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if :code=
:`acc_protocols` is set, this variable contains the maximum</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    message length for app custom p=
rotocol message=2E</span><br><span>diff --git a/doc/management-notes=2Etxt =
b/doc/management-notes=2Etxt</span><br><span>index 4d726c4=2E=2Ea6dcc2f 100=
644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span>+++ b/=
doc/management-notes=2Etxt</span><br><span>@@ -828,6 +828,58 @@</span><br><=
span> that is required to continue the connection (unlike MFA or opening a =
browser)</span><br><span> this message is not negotiated but can just be se=
nt as a gratuitous message=2E</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+app custom control</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+If the specia=
l string &quot;ACC&quot; is passed as {EXTRA} OpenVPN will determine</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+the common app custom prot=
ocols between the client and the server and instruct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+the client that the server will send cont=
rol messages to the client using</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+the ACC protocol=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The se=
rver should then use client-acc-msg command to send app custom</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+control messages to the client t=
o facilitate the pending authentication=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+COMMAND -- client-acc-msg (OpenVPN 2=2E8 or higher)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+---------------------------------------=
----------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+On an OpenVPN instance runni=
ng in server mode this command sends an</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+app custom control message to a client=2E The format of=
 the command is:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  client-acc-msg {CID}=
 {KID}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {protocol}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {flags}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  {message}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+CID,KID -- client ID and Key ID=2E See documentation for &quot;&gt;CLIE=
NT:&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+notificati=
on for more info=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+protocol -- the ACC=
 protocol identifier that this message should be</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            tagged with=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+flags    -- a colon separated list of the encoding and the=
 flag if</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 the message is a fragment=2E E=2Eg=2E &quot;6:F&quot; for a base64 encoded=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            message=
 that is also a fragment and not complete yet=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+message  -- The message encoded in the encoding specified in flag=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+COMMAND -- acc-msg (OpenVPN 2=2E8 or higher)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+-------------------------------=
-----------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+When OpenVPN is running in =
--client mode this command sends an app</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+custom command to the server=2E The format of the comma=
nd is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  acc-msg</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+See the client-acc-msg c=
ommand for more details about the format of the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+message=2E Since a client has only one peer the=
re is no need to specify the</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+client id and key id=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> COMMAND -- client-deny  (OpenVPN 2=2E1 or higher)</span><br><sp=
an> -----------------------------------------------</span><br><span> </span=
><br><span>@@ -1302,6 +1354,47 @@</span><br><span>    response=2E Mechanism=
s that need multiple rounds or more complex answers</span><br><span>    sho=
uld implement a different response type than CR_RESPONSE=2E</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+(6) App custom co=
ntrol message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    This message is an ap=
plication specific payload message that is transported</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    over the OpenVPN control channel=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    In server mode:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    &gt;CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_=
base64}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    In client mode:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    &gt;ACC:{protocol},{fragment},{msg_base64}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    The protocol is a short ascii string =
identifying the app specific custom</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    protocol=2E If fragment is set to 1, the message is not=
 complete and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  next message should be concatenated to this message to form a complete</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    message=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    Note that the OpenVPN implementation opera=
tes here with the robustness</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    principle (&quot;be conservative in what you send, be liberal =
in what you</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    acce=
pt&quot; - RFC 793 and others) and allows receiving messages longer than</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    maximum allowed me=
ssage length=2E Implementations should be prepared to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    handle messages that are longer than =
the maximum allowed message length=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+(7) App custom contr=
ol protocol message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   This message inf=
orms the client about the common ACC</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+   protocols and the maximum message length for an ACC mes=
sage=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+   In client mode:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list},me=
ssage_len=3D{max_msg_len}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protocol_l=
ist is the list of supported protocols by both server and client=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   For example flower:power=
:sys_info would indicate these three protocols</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   are supported=2E max_msg_len specifies the ma=
ximum message length that the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   peer supports=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   In ser=
ver mode these information are available in the acc_protocols and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   acc_message_len variables =
of the client environment=2E</span><br><span> </span><br><span> Variables:<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/=
src/openvpn/Makefile=2Eam</span><br><span>index 8a60a94=2E=2Eebc4db6 100644=
</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/=
openvpn/Makefile=2Eam</span><br><span>@@ -45,6 +45,7 @@</span><br><span> sb=
in_PROGRAMS =3D openvpn</span><br><span> </span><br><span> openvpn_SOURCES =
=3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec acc=
=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=
=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><=
span>@@ -124,7 +125,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br>=
<span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \<=
/span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec refle=
ct_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br><sp=
an>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2E860ffa8</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</span><br><span=
>@@ -0,0 +1,451 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An =
application to securely tunnel IP networks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne =
Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
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
 40%);">+ *  with this program; if not, write to the Free Software Foundati=
on, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
yshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;error=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;forward=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_util=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;ssl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;multi=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum ac=
c_message_flag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_A=
SCII =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ACC_=
MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+log_acc_message(struct context *c, co=
nst struct buffer *buf, int payload_len,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                const char *protocol, int flags)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool fragment =3D flags &amp; ACC_MES=
SAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *payload_msg =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* For simplicity, we always encode payload to be=
 base64 encoded</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * if not already in base64 format */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (flags &amp; ACC_MESSAGE_FLAGS_ASCII)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        char *b64out =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(openvpn_base64_encod=
e(CBPTR(buf), payload_len, &amp;b64out) &gt;=3D 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(b64out, free, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        payload=
_msg =3D b64out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D CBSTR(buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (management)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;se=
ssion[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;opt=
ions=2Emode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* server mode=2E Report client context */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            struct man_def_auth_contex=
t *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            unsigned int mda_key_id =3D get_primary=
_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;CLIENT:ACC,%lu,%=
u,%s,%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              mda-&gt;cid, mda_key_id, protocol, fragment, payload_msg);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* Client mode=2E Do not a report a C=
LIENT id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol, fragment, payload=
_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENABLE_MANAGEMENT *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_PUSH, &q=
uot;Received custom app control message (protocol &#39;%s&#39;%s)&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        protocol, frag=
ment ? &quot;, fragment&quot; : &quot;&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Parses the flags field of an app control =
message and moves the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  buffer past the flags string=2E If there is an</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  error parsing the flags field the met=
hod returns -1 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  puts the error reason in err_reason</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_=
acc_message_flags(struct buffer *buf, const char **err_reason, struct gc_ar=
ena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const char *flags =3D buf=
_extract_field(buf, &#39;,&#39;, gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *err_reason=
 =3D &quot;could not extract flags field&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return -1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int acc_flags =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (const char *flag =3D flags; *f=
lag !=3D &#39;\0&#39;; flag++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (*flag =3D=3D &#39;A&#39;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#39;6&#39;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            acc_flags |=3D ACC_MESS=
AGE_FLAGS_BASE64;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
 if (*flag =3D=3D &#39;F&#39;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            *err_reason =3D &quot;Unknown flag in flags&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            return -1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* The message should be encoded with ex=
actly one encoding=2E Ensure that</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * only one of the flags is present */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool asciienc =3D (bool)(acc_flags=
 &amp; ACC_MESSAGE_FLAGS_ASCII);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    bool base64enc =3D (bool)(acc_flags &amp; ACC_MESSAGE_FLAG=
S_BASE64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (base64enc + asciienc=
 !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *tmp =3D gc_=
malloc(512, 1, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        snprintf(tmp, 512, &quot;number of encodings must be exactly one &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
            &quot;(B64=3D%d, ASCII=3D%d)&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                 base64enc, asciienc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        *err_reason =3D tmp;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -1;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return acc_flags;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, const st=
ruct buffer *buffer)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *err_reason =3D &quot;&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D *bu=
ffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct tls_multi *multi=
 =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!multi-&gt;acc_negotiated_protocols)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        err_reason =3D &quot;ACC not enabled or no nego=
tiated protocols&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_advance(&amp;buf, =
strlen(&quot;ACC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,&#39;)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;missing , af=
ter ACC&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* extract protocol, payload length,=
 flags substrings */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *protocol =3D buf_extract_field(&amp;buf, &#39;,&#39;, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!proto=
col)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;=
could not extract protocol field&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!tls_it=
em_in_cipher_list(protocol, multi-&gt;acc_negotiated_protocols))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct buffer msg_buf =3D alloc_buf_=
gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       buf_printf(&amp;msg_buf, &quot;protocol &#39;%s&#39; not in list of =
negotiated protocols &#39;%s&#39;&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                   protocol, multi-&gt;acc_negotiated_=
protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
err_reason =3D buf_cstr(&amp;msg_buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* We do not check the length here=2E We make no p=
romises to support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * anything larger than our announced message length but according to</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the robustness =
principle</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (&q=
uot;be conservative in what you send, be liberal in what you accept&quot; -=
 RFC 793 and others)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * we accept also longer messages */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    int payload_len;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const char *payload_len_str =3D buf_extract_field(&amp;buf, &#39;,&=
#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!payload_len_str</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        || !atoi_constrained(payload_len_str, &amp;payload_len, &quot;acc_=
payload_len&quot;, 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;could not extrac=
t payload length field&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags =3D parse_a=
cc_message_flags(&amp;buf, &amp;err_reason, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (flags &lt; 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* We should have a final NU=
L byte in the control message buffer</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * and thus the length of the buffer should be payload=
_len + 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
buf_len(&amp;buf) !=3D payload_len + 1)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        char *tmp =3D gc_malloc(512, 1, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &quot;field =
length %d, payload length %d mismatch&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 payload_len, buf_len(&amp;buf) - =
1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reas=
on =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    log_acc_message(c, &amp;buf, payload_len, protocol, flag=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING: Received malformed=
 custom app control channel &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                       &quot;message (%s): %s&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        format_hex(CBPTR(bu=
ffer), BLEN(buffer), 80, &amp;gc));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+send_acc_message(struct context *c,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 struct tls_multi *mu=
lti,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  struct tls_session *session,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                 const char *protocol, bool fragment,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                 const char *m=
sg, bool base64)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+     * length of the protocol stri=
ng + one &#39;,&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * 2 for the encoding (A or 6), potential F (fragment), and 1 for the =
&#39;,&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
4 for the message size itself and one comma</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * 1 for the comma before the message itself */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t ma=
x_header_size =3D strlen(&quot;ACC,&quot;) + strlen(protocol) + 1 + 4 + 1 +=
 2 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t l=
en =3D max_header_size + strlen(msg);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (len &gt; TLS_CHANNEL_BUF_SIZE)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_CLIENT, &quot;message length (%zu) exceeds maximum possib=
le message length (%d)&quot;, len, TLS_CHANNEL_BUF_SIZE);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if ((int)len &gt; multi-&gt;acc_max_message_length)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;header (%zu) + mes=
sage size (%zu) length (%zu) exceeds &quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                      &quot;maximum allowed length =
negotiated with peer (%d)&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            max_header_size, strlen(msg), len,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_max_messa=
ge_length);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* add 1 for the f=
inal \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer buf =3D alloc_buf_gc(len + 1, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, =
&quot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+               strlen(msg),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+               base64 ? &quot;6&quot; : &quot=
;A&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
     fragment ? &quot;F&quot; : &quot;&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+               msg);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool ret =3D send_control_channel_string_dowork(session, BSTR(&=
amp;buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   reschedule_multi_process(c);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const char *capabil=
ities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
        const char *delim,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     int *max_acc_len,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     bool server,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_message =3D strin=
g_alloc(capabilities, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    char *tmp_message_orig =3D tmp_message;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_message, delim,=
 &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *=
ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we =
allow more capabilities than our own, in client</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * mode we reject if we should use capabili=
ties that we do not support */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span style=
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
=2E=2E2fe9efd</span><br><span>--- /dev/null</span><br><span>+++ b/src/openv=
pn/acc=2Eh</span><br><span>@@ -0,0 +1,113 @@</span><br><span style=3D"color=
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
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct context *c,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 str=
uct tls_multi *tls_multi,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 struct tls_session *session,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const char *protocol, bo=
ol fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
          const char *msg, bool base64);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Parses an info message from th=
e server that contains app custom control info</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * information prior to the PUSH_REPLY to be abl=
e to use app custom control</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * protocols before sending</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* In client mode only allow what we support ourselves=2E In server mode</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allow also capabilit=
ies that we not support ourselves=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param capabilities      The string to parse</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param delim             The delimiter to us=
e when parsing the string=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *                          IV_ACC uses &quot;,&quot; as delimiter=
 while the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
                   custom-control PUSH message uses &quot; &quot; as &quot;=
,&quot; is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
                   already used to separate different push directives</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len    =
   Set to the maximum ACC message length</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param server            Whether we are server or c=
lient</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc  =
              The gc arena to use for allocating the resulting string</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return               =
   The resulting protocol string or NULL on error</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+parse_acc_parameters(const char *capabilities,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                     const char *delim,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     int *m=
ax_acc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
             bool server,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                     struct gc_arena *gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Par=
ses the IV_ACC of the peer and sets multi=2Eacc_negotiated_protocols</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * to the common protocols=
 of server and client and</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * multi=2Eacc_max_message_length  to the maximum length of the ACC m=
essage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * support by=
 both server and client=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If ther=
e is no common protocol or the client does not support any app custom</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocol multi=2Eacc_n=
egotiated_protocols will be set to NULL=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param multi      the multi instance to use the set the app custom=
 protocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram session    the session to read the client env from</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+determine_common_acc_protocols(struct tls_multi *multi, struct tls_sess=
ion *session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Calculates the intersection of two li=
st that are both separated by :</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Items in the result will have the same ordering as in the li=
st1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * parameters</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc          =
  Returned buffer will be allocated in this gc</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param list1         First list to intersect<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param list2     =
    Second list to intersect=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return A (potentially empty) buffer containing an intersect=
ion list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+get_list_intersection(struct gc_a=
rena *gc, const char *list1, const char *list2);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Not=
ifies a client via management interface of the negotiated app</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * custom protocols</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param multi the tls_multi ins=
tance of the connection</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+notify_client_acc_protocols=
(struct tls_multi *multi);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/op=
envpn/forward=2Ec</span><br><span>index 681210d=2E=2Eeb41d03 100644</span><=
br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/fo=
rward=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot=
;dco=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&quot;</span><=
br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> </s=
pan><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br>=
<span>@@ -257,11 +258,11 @@</span><br><span>     }</span><br><span>     els=
e if (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server=
_pushed_info(buf, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        peer_pushed_info(c, buf, 8);</span><br><span>     }</span><br><sp=
an>     else if (buf_string_match_head_str(buf, &quot;INFO&quot;))</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 server_pushed_info(buf, 4);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        peer_pushed_info(c, buf, 4);</span><br><span>     }</span>=
<br><span>     else if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&qu=
ot;))</span><br><span>     {</span><br><span>@@ -271,6 +272,10 @@</span><br=
><span>     {</span><br><span>         receive_auth_pending(c, buf);</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (buf_string_match_head_str(buf, &quot;ACC&quot;))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        receive_acc_message(c, buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else i=
f (buf_string_match_head_str(buf, &quot;EXIT&quot;))</span><br><span>     {=
</span><br><span>         receive_exit_message(c);</span><br><span>diff --g=
it a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 1b8b=
2a5=2E=2Ee0b99a4 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><b=
r><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -56,6 +56,7 @@</span>=
<br><span> #include &quot;schedule=2Eh&quot;</span><br><span> #include &quo=
t;options_string=2Eh&quot;</span><br><span> #include &quot;resolve=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=
=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quo=
t;</span><br><span> </span><br><span>@@ -2279,6 +2280,13 @@</span><br><span=
>         }</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=
=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (multi &amp;&amp; multi-&gt;acc_negotiated_protocols)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        buf_printf(&amp;out, &quot; custom-control %d =
A:6 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
             multi-&gt;acc_max_message_length, multi-&gt;acc_negotiated_pro=
tocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if =
(BLENZ(&amp;out) &gt; strlen(header))</span><br><span>     {</span><br><spa=
n>         msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><br><spa=
n>@@ -2522,6 +2530,11 @@</span><br><span>         flags |=3D (OPT_P_ROUTE |=
 OPT_P_DHCPDNS);</span><br><span>     }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_protocols=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_ACC;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return flags;<=
/span><br><span> }</span><br><span> </span><br><span>@@ -2730,6 +2743,18 @@=
</span><br><span>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tun_max_m=
tu, c-&gt;options=2Ece=2Etun_mtu);</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (found &amp;=
 OPT_P_ACC &amp;&amp; c-&gt;options=2Epushed_acc_negotiated_protocols)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D c-=
&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        free(multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        multi-&gt;acc_negotiated_protocols =
=3D string_alloc(c-&gt;options=2Epushed_acc_negotiated_protocols, NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_=
max_message_length =3D c-&gt;options=2Epushed_acc_max_message_length;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPORT: AC=
C protocols: %s, msg len: %d&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            multi-&gt;acc_negotiated_protocols, multi-&gt;a=
cc_max_message_length);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        notify_client_acc_protocols(multi);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     return true;</span><br><span> }</span><=
br><span> </span><br><span>@@ -3352,6 +3377,7 @@</span><br><span>     to=2E=
verify_hash_depth =3D options-&gt;verify_hash_depth;</span><br><span>     t=
o=2Everify_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br><span>  =
   memcpy(to=2Ex509_username_field, options-&gt;x509_username_field, sizeof=
(to=2Ex509_username_field));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    to=2Eacc_protocols =3D options-&gt;acc_protocols;</span><br><s=
pan>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx =3D &=
amp;c-&gt;net_ctx;</span><br><span> </span><br><span>@@ -4306,6 +4332,24 @@=
</span><br><span> }</span><br><span> #endif /* ifdef TARGET_ANDROID */</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_acc=
_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
               struct buffer_list *input) /* ownership transferred */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D arg;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (buffer_list_defined(input) &amp;&amp;=
 c-&gt;c2=2Etls_multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct tls_session *session =3D &amp;mul=
ti-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =
=3D management_send_acc_message(c, multi, session, input);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buffer_list_free(input);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><b=
r><span> </span><br><span> void</span><br><span>@@ -4322,6 +4366,7 @@</span=
><br><span>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</span=
><br><span>         cb=2Eremote_cmd =3D management_callback_remote_cmd;</sp=
an><br><span>         cb=2Esend_cc_message =3D management_callback_send_cc_=
message;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=
=2Eacc_msg =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROID</=
span><br><span>         cb=2Enetwork_change =3D management_callback_network=
_change;</span><br><span> #endif</span><br><span>diff --git a/src/openvpn/m=
anage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ac3d4b7=2E=2E5e4e4=
16 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ =
b/src/openvpn/manage=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><br><span=
> #include &quot;push=2Eh&quot;</span><br><span> #include &quot;multi=2Eh&q=
uot;</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><=
span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> #i=
nclude &quot;run_command=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span><br=
><span> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&quo=
t;</span><br><span>@@ -1081,6 +1083,35 @@</span><br><span>             }</s=
pan><br><span>             break;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;pers=
ist=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                bool status =3D (*man-&gt;persist=2Ecallback=2Eclien=
t_acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                                  =
                    man-&gt;connection=2Ein_extra_cid,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
                              man-&gt;connection=2Ein_extra_kid,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
                                        man-&gt;connection=2Ein_extra);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt=
;connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                report_command_status(status, &quot;client-acc=
-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                man_co=
mmand_unsupported(&quot;client-acc-msg&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        case IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                bool status =3D (*man-&g=
t;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                                  man-&gt;connection=2Ein_extra);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;conne=
ction=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                report_command_status(status, &quot;acc-msg&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                man_command_unsuppo=
rted(&quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            break;</span><br><span>         case IEC_PK_SIGN:</span><br><s=
pan>             man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><b=
r><span>             buffer_list_free(man-&gt;connection=2Eext_key_input);<=
/span><br><span>@@ -1205,6 +1236,29 @@</span><br><span> }</span><br><span> =
</span><br><span> static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+man_client_acc_msg(struct management *man, const char *cid_str,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   co=
nst char *kid_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_conn=
ection *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &amp;m=
c-&gt;in_extra_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_extr=
a_kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra_cm=
d =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        in_extra_reset(mc, IER_NEW);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+man_acc_msg(struct management *man)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &amp=
;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span> man_client_auth(struct management *man, const ch=
ar *cid_str, const char *kid_str, const bool extra)</span><br><span> {</spa=
n><br><span>     struct man_connection *mc =3D &amp;man-&gt;connection;</sp=
an><br><span>@@ -1759,6 +1813,17 @@</span><br><span>             man_client=
_pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (streq(p[0], &quot;client-acc-msg&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            man_client_acc_msg(man, p[1], p[2]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     els=
e if (streq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br><s=
pan>         man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2975=
,7 +3040,9 @@</span><br><span>                                        &quot=
;bytes_sent=3D&quot;,</span><br><span>                                     =
   &quot;bytes_received=3D&quot;,</span><br><span>                         =
               &quot;session_id=3D&quot;,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                                       &quot;session_st=
ate=3D&quot; };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                   &quot;session_state=3D&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
         &quot;acc_protocols=3D&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                       &quot;acc_message=
_len=3D&quot; };</span><br><span> </span><br><span>     if (env_filter_leve=
l =3D=3D 0)</span><br><span>     {</span><br><span>@@ -3130,6 +3197,7 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><spa=
n> management_connection_established(struct management *man, struct man_def=
_auth_context *mdac,</span><br><span>                                   con=
st struct env_set *es)</span><br><span>@@ -4372,6 +4440,64 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+management_send_acc_message(struct context *c, struct tls_multi=
 *multi, struct tls_session *session,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                            struct buffer_list *input)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* also ensures that are enough inpu=
ts in the list to safely call</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * buffer_list_peek without extra NULL checks */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;size=
 &lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &qu=
ot;not enough input lines for sending acc message, &quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                      &quot;missing p=
rotocol, flag and/or messages lines&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 struct buffer *proto_buf =3D buffer_list_peek(input);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char *protocol =3D string_allo=
c(CBSTR(proto_buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buffer_list_pop(input);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer *encoding_buf =3D buffer_list_peek(input);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(enco=
ding_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 char *flag =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool b64encoding =3D false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    bool fragment =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    while ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            b64encoding =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!strcmp(flag=
, &quot;F&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
fragment =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_aggregate_separator(=
input, 10000, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct buffer *acc_msg_buf =3D buffer_list_peek(input);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_proto=
cols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !tls=
_item_in_cipher_list(protocol, multi-&gt;acc_negotiated_protocols))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not =
in the list of negotiated protocols: %s&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            np(multi-&gt;acc_negotiated_protocol=
s));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto er=
ror;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool ret =3D send_acc_message(c, multi, sess=
ion, protocol,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                           fragment, buf_cstr(acc_msg_buf),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                b64=
encoding);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+error:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else=
 /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> #include =
&quot;win32=2Eh&quot;</span><br><span>diff --git a/src/openvpn/manage=2Eh b=
/src/openvpn/manage=2Eh</span><br><span>index 157039d=2E=2Ecc9c264 100644</=
span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openv=
pn/manage=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><br><span>     in=
t (*n_clients)(void *arg);</span><br><span>     bool (*send_cc_message)(voi=
d *arg, const char *message, const char *parameter);</span><br><span>     b=
ool (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     bool (*client_auth)(void *arg, const unsigned long cid, const unsigned=
 int mda_key_id,</span><br><span>                         const bool auth, =
const char *reason, const char *client_reason,</span><br><span>            =
             struct buffer_list *cc_config); /* ownership transferred */</s=
pan><br><span>     bool (*client_pending_auth)(void *arg, const unsigned lo=
ng cid, const unsigned int kid,</span><br><span>                           =
      const char *extra, unsigned int timeout);</span><br><span>     char *=
(*get_peer_info)(void *arg, const unsigned long cid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
    const unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                           const unsigned int mda_key_id,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           s=
truct buffer_list *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool (*acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    struct buffer_list *msg);</span><br><sp=
an>     bool (*proxy_cmd)(void *arg, const char **p);</span><br><span>     =
bool (*remote_cmd)(void *arg, const char **p);</span><br><span> #ifdef TARG=
ET_ANDROID</span><br><span>@@ -292,13 +299,15 @@</span><br><span>     struc=
t command_line *in;</span><br><span>     struct buffer_list *out;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_U=
NDEF       0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define I=
EC_CLIENT_AUTH 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine IEC_UNDEF          0</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define IEC_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT_P=
F   2 *REMOVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define IEC_RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define IEC_PK_SIGN     5</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define IEC_PASSWORD    6</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define IEC_RSA_SIGN       3</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD   =
    6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CL=
IENT_ACC_MSG 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne IEC_ACC_MSG        8</span><br><span>     int in_extra_cmd;</span><br><s=
pan>     struct buffer_list *in_extra;</span><br><span>     unsigned long i=
n_extra_cid;</span><br><span>@@ -503,6 +512,14 @@</span><br><span> </span><=
br><span> void man_persist_client_stats(struct management *man, struct cont=
ext *c);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/** Parses the ACC message from the input buffer_list and send to th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * session identif=
ied by session and multi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_=
session;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_=
multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+management_send_acc_message(=
struct context *c, struct tls_multi *multi,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                            struct tls_session *ses=
sion, struct buffer_list *input);</span><br><span> #endif /* ifdef ENABLE_M=
ANAGEMENT */</span><br><span> </span><br><span> /**</span><br><span>diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e=
302a81=2E=2Ea3eb3ca 100644</span><br><span>--- a/src/openvpn/multi=2Ec</spa=
n><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</=
span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include=
 &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ac=
c=2Eh&quot;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_=
LOOP*/</span><br><span> </span><br><span>@@ -4085,6 +4086,26 @@</span><br><=
span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+calculate_app_control_extra(struct multi_insta=
nce *mi, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct context *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protoco=
ls)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;AC=
C: No negotiated protocols&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 buf =3D alloc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_printf(&amp;buf, &quot;ACC:%d A:6 %s&quot;, multi-&gt;acc_max_message_len=
gth,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return buf_str(&amp;buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static bool</span><br><span> management_client_pending_auth(void *a=
rg, const unsigned long cid, const unsigned int mda_key_id,</span><br><span=
>                                const char *extra, unsigned int timeout)</=
span><br><span>@@ -4095,10 +4116,22 @@</span><br><span>     if (mi)</span><=
br><span>     {</span><br><span>         struct tls_multi *multi =3D mi-&gt=
;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!strcmp(extra, &quot;ACC&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            extra =3D calculate_app_control_extra(m=
i, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (!extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                return false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span>         struct tls_session *session =3D=
 lookup_session_by_mda_key_id(multi, mda_key_id);</span><br><span> </span><=
br><span>         if (!session)</span><br><span>         {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span>=
<br><span>             return false;</span><br><span>         }</span><br><=
span> </span><br><span>@@ -4106,6 +4139,7 @@</span><br><span>         bool =
ret =3D send_auth_pending_messages(multi, session, extra, timeout);</span><=
br><span>         reschedule_multi_process(&amp;mi-&gt;context);</span><br>=
<span>         multi_schedule_context_wakeup(m, mi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
>         return ret;</span><br><span>     }</span><br><span>     return fa=
lse;</span><br><span>@@ -4149,6 +4183,37 @@</span><br><span>     return ret=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manageme=
nt_client_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                          const unsigned long cid,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                          const uns=
igned int mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                          struct buffer_list *input) /* ownership transfe=
rred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =
=3D (struct multi_context *)arg;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct multi_instance *mi =3D lookup_by_cid(m, cid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buffer_list_define=
d(input))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi=
 *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct tls_session *session =3D lookup_ses=
sion_by_mda_key_id(multi, mda_key_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (!session)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            msg(M_CLIENT, &quot;client session not found&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buffer_=
list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D managemen=
t_send_acc_message(&amp;mi-&gt;context, multi, session, input);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        multi_schedule_context_=
wakeup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buffer_list_free(input);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> static char *</span><br><span> management_get_peer_i=
nfo(void *arg, const unsigned long cid)</span><br><span> {</span><br><span>=
@@ -4185,6 +4250,7 @@</span><br><span>         cb=2En_clients =3D managemen=
t_callback_n_clients;</span><br><span>         cb=2Ekill_by_cid =3D managem=
ent_kill_by_cid;</span><br><span>         cb=2Eclient_auth =3D management_c=
lient_auth;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cb=2Eclient_acc_msg =3D management_client_acc_msg;</span><br><span>        =
 cb=2Eclient_pending_auth =3D management_client_pending_auth;</span><br><sp=
an>         cb=2Eget_peer_info =3D management_get_peer_info;</span><br><spa=
n>         cb=2Epush_update_broadcast =3D management_callback_send_push_upd=
ate_broadcast;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/o=
penvpn/options=2Ec</span><br><span>index fb319ae=2E=2Ea5e7396 100644</span>=
<br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/o=
ptions=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><s=
pan> #include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br>=
<span> #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;erro=
r=2Eh&quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><spa=
n>@@ -2552,6 +2553,8 @@</span><br><span>     o-&gt;push_option_types_found =
=3D 0;</span><br><span>     o-&gt;push_update_options_found =3D 0;</span><b=
r><span>     o-&gt;imported_protocol_flags =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    o-&gt;pushed_acc_max_message_length =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;pushed_a=
cc_negotiated_protocols =3D NULL;</span><br><span> }</span><br><span> </spa=
n><br><span> static void</span><br><span>@@ -7107,6 +7110,47 @@</span><br><=
span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         op=
tions-&gt;force_key_material_export =3D true;</span><br><span>     }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &=
quot;app-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!string_cl=
ass(p[1], CC_ALNUM | CC_COLON | CC_UNDERBAR | CC_DASH, 0))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom con=
trol protocols must only contain &quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                          &quot;alphanumeric characters=
, &#39;-&#39;, and &#39;_&#39;=2E&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        options-&gt;acc_protocols =3D p[1];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;custom-control&quot;=
) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* check if the list from the ser=
ver is a real subset of our list */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct gc_arena gc_local =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct buffer common_lis=
t =3D get_list_intersection(&amp;gc_local, p[3], options-&gt;acc_protocols)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (buf_len(&amp;common_list)=
 =3D=3D 0 || !streq(p[3], buf_cstr(&amp;common_list)))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control=
 list from server contains &quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                          &quot;unsupported protocols&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free=
(&amp;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_=
free(&amp;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq=
(p[2], &quot;6:A&quot;) &amp;&amp; !streq(p[2], &quot;A:6&quot;))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App cus=
tom control encoding must be base64 and ascii&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;pushed_acc_max_=
message_length,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                          &quot;app custom message message length&quot;, AC=
C_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        options-&gt;pushed_acc_negotiated_protocols =3D p[3];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     e=
lse if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</sp=
an><br><span>     {</span><br><span>         msg(M_WARN, &quot;NOTICE: --pr=
ng option ignored (SSL library PRNG is used)&quot;);</span><br><span>diff -=
-git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>in=
dex 6a3bf61=2E=2Eb7945e0 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -715,=
6 +715,18 @@</span><br><span>     /* force using TLS key material export fo=
r data channel key generation */</span><br><span>     bool force_key_materi=
al_export;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /** The app custom control protocols we should announce as sup=
ported */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *acc_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the protoc=
ols that are negotiated with the peer=2E This is a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     *  a temporary variable since options=
=2Ec push parser cannot access</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     *  tls multi struct */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *pushed_acc_negotiated_protocols;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC control c=
hannel message via push message</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int pushed_acc_max_message_length;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span>     bool vlan_tagging;</span><br><sp=
an>     enum vlan_acceptable_frames vlan_accept;</span><br><span>     uint1=
6_t vlan_pvid;</span><br><span>@@ -764,8 +776,10 @@</span><br><span> #defin=
e OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><span> #define OPT_P_PUS=
H_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TABLE   =
  (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OPT_P_ACC             (1ull &lt;&lt; 32)</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(OPT_P_=
INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Options allowed in the normal configur=
ation file (vs pushed options or in ccd files) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT=
_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> </span><br><spa=
n> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span><br><=
span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><sp=
an>index 42259c3=2E=2Ea18f33b 100644</span><br><span>--- a/src/openvpn/push=
=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27,6 +2=
7,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;push=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;option=
s=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><spa=
n> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -221,9 +223,56 @@</span>=
<br><span> #endif</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+parse_server_pushed_info_acc(struct context *c, =
struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_acc_le=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=
=2Eacc_protocols || !c-&gt;options=2Epull)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(D_PUSH_ERRORS, &quot;Peer tried to push app custom con=
trol list &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                        &quot;without client announcing support for it&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* example string to parse: ACC:1400 A:6 flower:h=
appy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Skip =
over the ACC: prefix */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    buf_advance(buf, 4);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *protocols =3D parse_acc_parameters(buf_cstr(buf), &q=
uot; &quot;, &amp;max_acc_len, false, &amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!protocols)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING: Received ACC info c=
ommand with invalid parameters&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check=
 if the list from the server is a real subset of our list */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_list =3D =
get_list_intersection(&amp;gc, protocols, multi-&gt;opt=2Eacc_protocols);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;common_list) =3D=3D=
 0 || !streq(protocols, buf_cstr(&amp;common_list)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;App custom control lis=
t from server contains &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                           &quot;unsupported protocols&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    multi-&gt;acc_negotiated_protocols =3D string_all=
oc(protocols, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    notify_client_acc_protocols(multi);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>=
 </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-server_pushed_info(const struct buffer *buffer, const int adv)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+peer_pushed_info(struct contex=
t *c, const struct buffer *buffer, const int adv)</span><br><span> {</span>=
<br><span>     const char *m =3D &quot;&quot;;</span><br><span>     struct =
buffer buf =3D *buffer;</span><br><span>@@ -233,6 +282,12 @@</span><br><spa=
n>         m =3D BSTR(&amp;buf);</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strncmp(m, &q=
uot;ACC:&quot;, 4) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   parse_server_pushed_info_acc(c, &amp;buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     str=
uct gc_arena gc;</span><br><span>     if (management)</span><br><span>@@ -2=
57,7 +312,7 @@</span><br><span>         gc_free(&amp;gc);</span><br><span> =
    }</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    msg(D_PUSH, &quot;Info command was pushed by server (&#39;%s&#3=
9;)&quot;, m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg(D_PUSH, &quot;Info command was pushed by peer (&#39;%s&#39;)&quot;, m);<=
/span><br><span> }</span><br><span> </span><br><span> void</span><br><span>=
@@ -285,6 +340,7 @@</span><br><span>     msg(D_PUSH, &quot;CR response was =
sent by client (&#39;%s&#39;)&quot;, m);</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /**</span><br><span>  * Parse the keyword for the AUTH_PENDING request</sp=
an><br><span>  * @param buffer                buffer containing the keyword=
s, the buffer&#39;s</span><br><span>@@ -441,7 +497,6 @@</span><br><span>   =
  const char *const peer_info =3D tls_multi-&gt;peer_info;</span><br><span>=
     unsigned int proto =3D extract_iv_proto(peer_info);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
/* Calculate the maximum timeout and subtract the time we already waited */=
</span><br><span>     unsigned int max_timeout =3D</span><br><span>        =
 max_uint(tls_multi-&gt;opt=2Erenegotiate_seconds / 2, tls_multi-&gt;opt=2E=
handshake_window);</span><br><span>@@ -732,6 +787,12 @@</span><br><span>   =
              client_max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=2Etun_mtu);</spa=
n><br><span>         }</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (tls_multi-&gt;acc_negotiated_protocols)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;=
custom-control %d A:6 %s&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        tls_multi-&gt;acc_max_message_length, t=
ls_multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><s=
pan> static bool</span><br><span>diff --git a/src/openvpn/push=2Eh b/src/op=
envpn/push=2Eh</span><br><span>index 39302f6=2E=2Ee08cd66 100644</span><br>=
<span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh=
</span><br><span>@@ -52,6 +52,7 @@</span><br><span> </span><br><span> int p=
rocess_incoming_push_request(struct context *c);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span>=
<br><span>  * @brief Handles the receiving of a push-update message and app=
lies updates to the specified</span><br><span>  * options=2E</span><br><spa=
n>@@ -92,7 +93,15 @@</span><br><span> </span><br><span> void receive_exit_m=
essage(struct context *c);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void server_pushed_info(const struct buffer *buffer,=
 const int adv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This message is =
called when an INFO or INFO_PRE message is received from</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * a peer=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param c         Context of the peer=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param buffer    Buffer containing t=
he INFO/INFO_PRE message=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param adv       number of character to advance past the INFO/IN=
FO_PRE header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void peer_pushed_info(=
struct context *c, const struct buffer *buffer, const int adv);</span><br><=
span> </span><br><span> void receive_cr_response(struct context *c, const s=
truct buffer *buffer);</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2E0a2=
5149 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b=
/src/openvpn/ssl=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><br><span> </s=
pan><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #incl=
ude &quot;ssl=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot;ssl_verify=
=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&quot;</span><br>=
<span> #include &quot;ssl_ncp=2Eh&quot;</span><br><span>@@ -1279,6 +1280,7 =
@@</span><br><span>     free(multi-&gt;locked_cn);</span><br><span>     fre=
e(multi-&gt;locked_username);</span><br><span>     free(multi-&gt;locked_or=
iginal_username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  free(multi-&gt;acc_negotiated_protocols);</span><br><span> </span><br><sp=
an>     cert_hash_free(multi-&gt;locked_cert_hash_set);</span><br><span> </=
span><br><span>@@ -2098,6 +2100,11 @@</span><br><span> #endif</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (session-&gt;opt-&gt;acc_protocols)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot;IV_ACC=
=3D%d,6:A,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (=
session-&gt;opt-&gt;push_peer_info_detail &gt; 1)</span><br><span>         =
{</span><br><span>             struct env_set *es =3D session-&gt;opt-&gt;e=
s;</span><br><span>@@ -2398,6 +2405,8 @@</span><br><span>         multi-&gt=
;remote_ciphername =3D string_alloc(&quot;none&quot;, NULL);</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    determine_common_acc_protocols(multi, session);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (username_l=
en &lt; 0 || password_len &lt; 0)</span><br><span>     {</span><br><span>  =
       msg(D_TLS_ERRORS, &quot;TLS Error: Username (%d) or password (%d) to=
o long&quot;, abs(username_len),</span><br><span>diff --git a/src/openvpn/s=
sl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9a55ead=2E=
=2E436770b 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -457,6 +457,9 @=
@</span><br><span>     size_t ekm_size;</span><br><span> </span><br><span> =
    bool dco_enabled; /**&lt; Whether keys have to be installed in DCO or n=
ot */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /** The app custom control pr=
otocols we should announce as supported */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *acc_protocols;</span><br><span> };</=
span><br><span> </span><br><span> /** @addtogroup control_processor</span><=
br><span>@@ -730,6 +733,12 @@</span><br><span>     int dco_peer_id;</span><=
br><span> </span><br><span>     dco_context_t *dco;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /** the protocols that are negotiated with the peer=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *acc_nego=
tiated_protocols;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the maximum l=
ength of an ACC control channel message */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int acc_max_message_length;</span><br><span> };<=
/span><br><span> </span><br><span> /**  gets an item  of \c key_state objec=
ts in the</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2E=
am b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 43a6743=
=2E=2E6a73e1e 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><=
br><span>@@ -107,10 +107,12 @@</span><br><span> 	@TEST_CFLAGS@</span><br><s=
pan> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</sp=
an><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	test_acc=2Ec test_acc=2Eh \</span><br>=
<span> 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_=
management=2Ec \</span><br><span> 	mock_ssl_dependencies=2Ec mock_win32_exe=
cve=2Ec \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/acc=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/buffer=2Ec \</span><br><span>@@ -132,6 +134,7 @@</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/run_command=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \</span><br><span> 	$(top_srcdir=
)/src/openvpn/ssl_mbedtls=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/ssl_util=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/ssl_verify_mbedtls=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/=
ssl_verify_openssl=2Ec \</span><br><span>diff --git a/tests/unit_tests/open=
vpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec</spa=
n><br><span>index fff4c2b=2E=2Ef572dbb 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/mock_management=2Ec</span><br><span>+++ b/tests/unit_test=
s/openvpn/mock_management=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br><=
span> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=
=2Eh&gt;</span><br><span> #include &quot;manage=2Eh&quot;</span><br><span> =
</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn=
/mock_push_dependencies=2Ec</span><br><span>index bf2ccf3=2E=2Ef083f89 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_dependencies=2E=
c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec=
</span><br><span>@@ -43,7 +43,8 @@</span><br><span>     uint64_t flags =3D =
OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span><br><=
span>                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OP=
T_P_COMP | OPT_P_PERSIST</span><br><span>                      | OPT_P_MESS=
AGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_PEER_ID =
| OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_PEER_I=
D | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_ACC;<=
/span><br><span>     return flags;</span><br><span> }</span><br><span> </sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tests/uni=
t_tests/openvpn/test_acc=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2E9364d12</span><br><span>--- /dev/null</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -0,0 +1=
,353 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application=
 to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             over a single TCP/UDP port, with support for SSL=
/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      session authentication and key exchange,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet encryption, packet authent=
ication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
        packet compression=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Cop=
yright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schwabe &lt=
;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softw=
are; you can redistribute it and/or modify</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lic=
ense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  a=
s published by the Free Software Foundation=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is distributed in the hope that it will be usefu=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  GNU General Public License for more details=2E</span><br><span style=
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
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdar=
g=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+char control_channel_message_sent[2048];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* Mock functions */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+send_control_channel_string_dowork(struct tls_session *session,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
              const char *str, unsigned int msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_in_range(strlen(str), 0, 2047);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    strcpy(control_channel_message_sent, str);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send=
_push_reply_auth_token(struct tls_multi *multi)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+auth_set_client_reason(struct tls_multi *=
multi, const char *reason)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBARkBAAEVAwNanUalkE=
DDxLBpZw9JnjI3tBM&quot;                \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    &quot;r4engpg/cDgS48DMaxyCdbzofNjQ=
JU9Y0DD66z/notFT0cF1d60nTS&quot; \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    &quot;4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMy=
qwCvALwCewCTAKABrwCP&quot; \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    &quot;AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAM=
AAQIACgAWABQAH&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    &quot;QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAM=
FAwYDCAc&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgA=
rA&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ&quo=
t; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     &quot;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_pa=
rse_client_messages(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    skip();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* ensure that t=
he messages get to mock_msg */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    x_debug_level =3D 3;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    management =3D (void *)0x12345678;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* contains a TLS 1=2E3 ClientHello *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg=
[] =3D &quot;ACC,cck1,384,6,&quot; MSG_PAYLOAD;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer msg_buf;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct context c =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    c=2Eoptions=2Emode =3D MODE_SERVER;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2Ec2=2Etls_multi, str=
uct tls_multi, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Et=
ls_multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2Etls_multi-&gt;opt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_mul=
ti-&gt;session[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp;c=2Ec2=2Emda_conte=
xt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read=
(&amp;msg_buf, (void *)msg, sizeof(msg));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;W=
ARNING: Received malformed custom app control channel message (ACC not enab=
led or no negotiated protocols): 4143432c 63636b31 2c333834 2c362c46 674d42=
41 526b4241 41455641 774e616[more=2E=2E=2E]&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_bu=
f, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Ec2=2Etls_mult=
i-&gt;acc_negotiated_protocols =3D &quot;no:common:protocol&quot;;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp=
;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(mock_msg_buf, &quot;WARNING: Received malformed cust=
om app control channel message (protocol &#39;cck1&#39; not in list of nego=
tiated protocols &#39;no:common:protocol&#39;): 4143432c 63636b31 2c333834 =
2c362c46 674d4241 526b4241 41455641 774e616[more=2E=2E=2E]&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock=
_managment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=2E=
c2=2Etls_multi-&gt;acc_negotiated_protocols =3D &quot;cck1:flower:power:for=
tune&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rece=
ive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(mock_msg_buf, &quot;Received custom app control mes=
sage (protocol &#39;cck1&#39;)&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CL=
IENT:ACC,0,0,cck1,0,&quot; MSG_PAYLOAD);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char flower_msg[] =3D &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD=
//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg, siz=
eof(flower_msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;Receiv=
ed custom app control message (protocol &#39;flower&#39;)&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_=
managment_buf, &quot;&gt;CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aG=
Ug77+94oCPZnJvZyEAAA=3D=3D&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char msg_incorrect_len[] =3D &quot;ACC,fortune,62,6,InsgIm=
1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg=
_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &a=
mp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *error =3D &quot;WARNING: Received malformed custom app control cha=
nnel &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                &quot;message (field length 62, payload length 64 mismatch)=
: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             &quot;4143432c 666f7274 756e652c 36322c36 2c496e73 67496d31 &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         &quot;6c496a6f 67496d5[more=2E=2E=2E]&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(mock_msg_buf, error);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_manag=
ment_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock=
_managment_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char msg_fragment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&=
amp;msg_buf, (void *)msg_fragment, sizeof(msg_fragment));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;=
msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(mock_msg_buf, &quot;Received custom app control message (prot=
ocol &#39;power&#39;, fragment)&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;C=
LIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* check two encoding present */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg_two_encs[] =
=3D &quot;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=
=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_set_read(&amp;msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_two=
_encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive=
_acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 error =3D &quot;WARNING: Received malformed custom app control channel mes=
sage &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &quot;(number of encodings must be exactly one (B64=3D1, ASCII=3D1)): &=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;4143432c 666c6f77 65722c34 382c3641 2c535342 68625341 41494574 &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;6c6=
36d3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(mock_msg_buf, error);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* no encoding present */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_msg_no_en=
cs[] =3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAA=
A=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_set_read(&amp;msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_=
encs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_=
acc_message(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
error =3D &quot;WARNING: Received malformed custom app control channel mess=
age &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;(number of encodings must be exactly one (B64=3D0, ASCII=3D0)): &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;4143432c 666c6f77 65722c34 382c2c53 53426862 53414149 45746c63 &quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;6d31=
706[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(mock_msg_buf, error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_bu=
f, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    x_debug_level =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    management =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_parse_acc_parameters(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* parameters to INFO message */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *info_acc_msg =3D &quo=
t;4096 A:6 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
max_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, =
&amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ma=
x_len, 1280);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a client does not =
accept a length longer than it supports */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg,=
 &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* message with lower limit than our, should work for c=
lient and server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    info_acc_msg =3D &quot;1111 A:6 flower:happy&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(=
info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, =
&quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(max_len, 1111);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &a=
mp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_=
len, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* more encodings than =
supported=2E Server should be okay, client should fail */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1200 A:6:B=
 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;m=
ax_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pr=
otocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len,=
 true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_string_equal(protocols, &quot;flower:happy&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len, 1200);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* extra parameter */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1400 =
A:6 flower:happy 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, =
&amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_null(protocols);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max=
_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc_capa=
bilities =3D &quot;1400,A:6,flower:happy:power&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(iv=
_acc_capabilities, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protoco=
ls, &quot;flower:happy:power&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* too small protocol length */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    info_acc_msg =3D &quot;32 A:6 flower:happy&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc=
_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocol=
s);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* non-numerical protocol lengt=
h */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info_acc_ms=
g =3D &quot;abff A:6 flower:happy&quot;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(info_acc_msg, &=
quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_acc_common_protocols(void **st=
ate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct co=
ntext *c =3D &amp;mi=2Econtext;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &a=
mp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2E=
tls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower=
:happy:power&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    c-&gt;options=2Eacc_protocols =3D &quot;power:flower:star&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *mult=
i =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    multi-&gt;opt=2Eacc_protocols =3D c-&gt;options=2Eacc_protocols=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;sess=
ion[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;opt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Ees =3D env_set_create(&amp;c-&=
gt;options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common_=
acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(multi-&gt;acc_max_me=
ssage_length, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(multi-&gt;acc_negotiated_protocols, &qu=
ot;power:flower&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(env_set_get(multi-&gt;opt=2Ees, &quot;acc_protocols&quot;), &quot;=
acc_protocols=3Dpower:flower&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &q=
uot;acc_message_len&quot;), &quot;acc_message_len=3D1280&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_protocols);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;=
options=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_acc_send_message(void **state)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct multi_instance mi =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi=2Eco=
ntext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;opt=
ions=2Egc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_C=
LEAR_GC(c-&gt;c2=2Etls_multi, struct tls_multi, &amp;c-&gt;options=2Egc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *multi=
 =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    c-&gt;options=2Eacc_protocols =3D &quot;power:flower:emergency&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;=
opt=2Eacc_protocols =3D c-&gt;options=2Eacc_protocols;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =
=3D &amp;multi-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    multi-&gt;opt=2Ees =3D env_set_create(&amp;c-&gt;options=2Egc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =
=3D &quot;IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:emergency:power&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    determine_common=
_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_session *session =3D &amp;=
c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot;=
emergency&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                           &quot;EMERGENCY BROADCAST MESSAGE - THIS IS N=
OT A DRILL:&quot;, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(control_channel_message_sent,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        &quot;ACC,emergency,50,AF,E=
MERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, se=
ssion, &quot;emergency&quot;, false,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                           &quot;THE GOVERNMENT HAS ISSUED=
 A RAINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(control_cha=
nnel_message_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A=
 RAINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* te=
st a long message (&gt; 1000) with fragment to get the maximum header size =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char long_mes=
sage[1200] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =
=3D 0; i &lt; 1024; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        l=
ong_message[i] =3D (char)(&#39; &#39; + (i % 95));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* last char of the message is a i and then a \0 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1023], =
&#39;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(long_message[1024], &#39;\0&#39;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &=
quot;emergency&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                           long_message, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    size_t cc_len =3D strlen(control_channel_message_se=
nt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(control_channel_message_sent[cc_len - 1], &#39;i&#39;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *expected_start_cc=
 =3D &quot;ACC,emergency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memor=
y_equal(control_channel_message_sent, expected_start_cc, strlen(expected_st=
art_cc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negoti=
ated_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_list_intersection(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *empty =3D &quot;&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *pr=
otos =3D &quot;power:flower:emergency&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer t1 =3D get_list_intersection(&amp;gc, empty, protos);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(buf_len(&amp;t1), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er t2 =3D get_list_intersection(&amp;gc, protos, empty);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t2),=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t3 =3D get_list_=
intersection(&amp;gc, protos, protos);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t3), protos);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *protos2 =3D &quot;flower:=
emergency:power:mario&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer t4 =3D get_list_intersection(&amp;gc, protos2, p=
rotos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(buf_cstr(&amp;t4), &quot;flower:emergency:power&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *protos3 =3D &quot;super:paper:=
mario:flower&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer t5 =3D get_list_intersection(&amp;gc, protos2, protos3);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_eq=
ual(buf_cstr(&amp;t5), &quot;flower:mario&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const char *proto4 =3D &quot;flower:flower:flower:flower&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffe=
r t6 =3D get_list_intersection(&amp;gc, proto4, &quot;flower&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(bu=
f_cstr(&amp;t6), &quot;flower&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openv=
pn/test_acc=2Eh</span><br><span>new file mode 100644</span><br><span>index =
0000000=2E=2E32421fb</span><br><span>--- /dev/null</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single UDP port, with support for SSL/TLS-based</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session au=
thentication and key exchange,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet encryption, packet authentication, and</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet c=
ompression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-=
2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is free software; you can redistribute it and/or m=
odify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under t=
he terms of the GNU General Public License version 2</span><br><span style=
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
yle=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt=
;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_client_message=
s(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_parse_acc_pa=
rameters(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_c=
ommon_protocols(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tes=
t_acc_send_message(void **state);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
test_list_intersection(void **state);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</span><br><s=
pan>index 8db4ea6=2E=2Ec865142 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_common=2Eh</span><br><span>@@ -43,11 +43,13 @@</span><br><span> #define =
LargestIntegralType uintmax_t</span><br><span> #endif</span><br><span> /* r=
edefine 2=2Ex API in terms of 1=2Ex API */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define CMockaValueData             LargestIntegralTyp=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define check_expect=
ed_uint         check_expected</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define expect_uint_value           expect_value</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define expect_check_data           exp=
ect_check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define cast=
_ptr_to_cmocka_value(x) (x)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define CMockaValueData                       LargestIntegralType</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define check_expecte=
d_uint                   check_expected</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define expect_uint_value                     expect_va=
lue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_c=
heck_data                     expect_check</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define cast_ptr_to_cmocka_value(x)           (x)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define assert_int_in_=
range(value, min, max)  assert_in_range((value), (min), (max))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define assert_uint_in_range(val=
ue, min, max) assert_in_range((value), (min), (max))</span><br><span> #endi=
f</span><br><span> </span><br><span> /**</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</s=
pan><br><span>index 4baf8cc=2E=2E4987dd0 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/ope=
nvpn/test_ssl=2Ec</span><br><span>@@ -52,6 +52,8 @@</span><br><span> #inclu=
de &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;openvpn=2Eh&q=
uot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> /* Mock function to be allowed to includ=
e win32=2Ec which is required for</span><br><span>  * getting the temp dire=
ctory */</span><br><span> #ifdef _WIN32</span><br><span>@@ -86,6 +88,20 @@<=
/span><br><span> {</span><br><span>     return;</span><br><span> }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+reschedule_multi_process(struct context *=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* Define a dummy dco cipher option to avoid linking against all the DCO=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * units */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_DCO)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+const char *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dco_get_supported_ciphers(void=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return &quot;AES-192-GCM:AES-128=
-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span> </span><br><span> /* generated usin=
g</span><br><span>  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_cur=
ve:secp384r1 -keyout - \</span><br><span>@@ -1111,8 +1127,12 @@</span><br><=
span>         cmocka_unit_test(ssl_test_extract_last_matching_field),</span=
><br><span>         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),=
</span><br><span>         cmocka_unit_test(ssl_test_escape_rfc_2253_chars_i=
n_subject),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cm=
ocka_unit_test(ssl_test_extract_peer_info)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(ssl_test_extract_peer_info),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_parse=
_client_messages),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_parse_acc_parameters),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_acc_common_=
protocols),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_acc_send_message),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_list_intersection)</span=
><br><span>     };</span><br><span> </span><br><span> #if defined(ENABLE_CR=
YPTO_OPENSSL)</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896=
b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 22 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@o=
penvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--gGpYsIFKM8c=--


--===============1579897994874457107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1579897994874457107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1579897994874457107==--

