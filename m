Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60299606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jlvTqYdr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YPLvzbtn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WfscO24F;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eWCj8bhj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=HSPMXQ1Jn4UkL30C59fZhkMiA2IzRT3syM7i2yvuHmE=; b=jlvTqYdrdHM5WKwtmdZGiMD/w5
	BLfCSSdHs+iFKs8lx9bLKWtKxAeZDks2Gz6jOYpgduaETbIYaBqIIPpzq6WCI1Ocf8tZtnG4j3eKX
	bcNKOd3rUzv4/JL2JYfoTVFkwSFLGS870x0uS87npFpdpWc+lXE7gnckG3lqVUgb78t4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTYe-000000008G5-0CH8;
	Thu, 29 Oct 2026 17:04:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTYb-000000008Fx-0gIw
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:04:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=09Xr0TFJ12xRoybMUrz6iMI/Zrsp3yYy45ZbiTmTrJw=; b=YPLvzbtnodMAhp+pvY40FZMGPn
 ojG1rBPVzjhavopeUHJx7A0ca1NkdIPuR2SULxSuRaqB17mh344lETGCKzLkYQZcJTNxyRWc0A/iY
 IxlJ61NyMfzh4xS5uX9QMSCqAhPdO7o+0eTkp8Fbx2UrbRDc+QeYn+n5seugBCRXnvU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=09Xr0TFJ12xRoybMUrz6iMI/Zrsp3yYy45ZbiTmTrJw=; b=WfscO24FOlFCGJY8gc7TPeaBVc
 pSixV4IgsrE2Hyz+UQKpaMaw/gEd03fg66D7T0p7c+U8NvN2QWJQ0fyvUv55y1sdUdXjqzWC1qvA9
 LNDyZJj1/5+RSN1+BVQFAkIAwhElKFWMEbUAr3LfhlrfzJULVfIgXMVCdpgfT5M8K4Ro=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTYO-000000000Qc-1rCi for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:04:53 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48afcd7ba9bso1839126f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793293474; x=1793898274; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=09Xr0TFJ12xRoybMUrz6iMI/Zrsp3yYy45ZbiTmTrJw=;
 b=eWCj8bhjmC+/MB6IksymTw3rhXBlqKveiNVLFFXwQIiYYcP1Skw78ch+uLdPxSpRjl
 6P/3rUtNgEhS01xpjeuMm1HM9AELsthm/LRAqih4EWhjS+4QEn5N3boo2UNFwN54Rq/r
 RvCD/mQX8NQpEV1PvgSMDB686QR5l2npH2LGy4AujMO2xrYPW7+KthKD2FMoA3HTmSWZ
 0VRKy4qSGmMEHBGXDB2uLsORTc2UTbD3Z+3AimLa09aY5+FbL5GRQpFfqulbvoJ2Dzno
 b6/QIxSZCIdBhESaanZ8s+h9h5MofzS3a4qtezTH9/vp1tV7BVuCvyCBbUVmPIQYrdZc
 //tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793293474; x=1793898274;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=09Xr0TFJ12xRoybMUrz6iMI/Zrsp3yYy45ZbiTmTrJw=;
 b=1RMBurYF21jb7B9g7cQEEMYOxdHmQ+ZjJeGulGK5bhWNatolnVvNQ7dL9ig6IRoyFw
 cHfWg4uj+BTyt8OtoH8yJLT/+UPDpYE13zTyk5H+5FHjjZicWGdX8XSnfXog1wYARcNG
 17XR+K97ifhDkC395NNQfc155mQj/d6qxAw51hX0NRiFPGHGVcmdUV4mq0hI+BdF/d5T
 wl2i0IPKov7BIFHaXCBsNZX2ZSQWgLsqbAe/SWfX621irTEdQdJSu3KOTg0naG9I8VBR
 GmCGcYauAB0Wt1A6PvBw7II529XTDhDE3CweZ4e/IOQScetyLzaGM8D7mTjQP0RfRVSx
 u8VQ==
X-Gm-Message-State: AFq9FYI8nESbT528ABG5Ar6ub9meC0GiTNDdRWuys1zyWgBVFawouUxP
 LujbqAnYLkZ02nx8aPKHFSU8xLeXle8ZnmRfR2fymMItmy1rvqKiOmdrUhHhXnu2u5h7z3Kj7eL
 yvJS8mFxEUEn4iI3qAJ68YJus1l2hrT8+jRkUwBoxNZTNoFf4XPPe2Q1jd4A82YObVxBo
X-Gm-Gg: AYBFou2KEtPLkbk1QNIZIy9+SoLFUEkvqJQmEgL10rFIUky/vyGMir1StZCa4tZ26V7
 FmT4VKeWk0FVE4ZeLL5xdIz/CKZZY/xDDwVRcWtuqGBmQZrcOko+1FD95vPvBORIKQpOznBNd+i
 +FDWJeNblaAhOueUIWF9A7FeFMNBf7/IbxHs8nzz1/7r4ufhOusTMuPfJEjKIfMdxSsec2VSuw1
 RuZCOIN/nV/Urp7dpIa9k2uifPxQKEZfEu2AdmTN5qDl16NEBylh8D224gG+qFmrfCgsFphEKxW
 du6mWRi1apwGx89hkD6KklmxOncfZT1HlUWeHHnSFqpJjvocNMRGDAZe0Fv+79io/vYVjZrmYya
 wXq8kDEbanBWCwlz2snKwq23q+zLHTa/aWR3ww0lR6m+MaxIOY/mNnXexFRJ3oAxmC1M4IJCgrB
 hguaqej01+5n+9WoudCY+lqnb+yTg3JV4QxIoNLHHfE5BvOTV60r3V/dLJENACUi/1DmDcydxS1
 x7QJSJnl+PRJ9WqFZKJsNAQ5GWOKsL0+gsBRvEag/bibQOrb5FlXom81ehKd4CvXwYQpL7RyFNP
 X2K1/2dF60d9ryQngyhIW6DlTOPVmyeSexXUtlZGSw8I/GfpFfrGOx/gv4rq9nIClmPhMlwg5iG
 7WpSdYFyngL63zZwguPcdxKgWq/03DxhWxkPP3Y9V/1zB58BakyjK0NZk1uxkIHbJvBYVAYVHzy
 zegT0rC/gMPgNh7rA=
X-Received: by 2002:a5d:5d13:0:b0:48e:103e:846f with SMTP id
 ffacd0b85a97d-48e6e2f91b5mr14141f8f.9.1793293472282; 
 Thu, 29 Oct 2026 10:04:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87fdbsm357809f8f.13.2026.10.29.10.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:04:31 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:04:27 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 0d8719830b6fb0a55223b6d99b9b458ddfdb63cd
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <05ddd4dd255944d9c5ef6934622f2e9699f93767-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMTYO-000000000Qc-1rCi
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
Content-Type: multipart/mixed; boundary="===============2011913975574717014=="
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2011913975574717014==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WX9d2FE4syk="; charset=UTF-8

--WX9d2FE4syk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd like you to ree=
xamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858?usp=3Demail

to look at the new patch set (#23)=2E

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
files changed, 1,546 insertions(+), 23 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/23

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
index 4d726c4=2E=2E13=
97861 100644
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
 
@@ -1302,6 +1354,52 @@
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
+    OpenVPN does not verify that the message is valid base64=
=2E A peer that
+    sends invalid base64 payload will be passed to the man=
agement interface=2E
+    An implementation should be prepared to handle in=
valid base64 and
+    handle accordingly (e=2Eg=2E disconnect the client vi=
a client-deny or
+    ignore such messages)=2E
+
+(7) App custom control pr=
otocol message
+
+   This message informs the client about the common ACC
+=
   protocols and the maximum message length for an ACC message=2E
+
+   In =
client mode:
+
+   >ACC_PROTOCOLS:protocols=3D{protocol_list},message_len=
=3D{max_msg_len}
+
+   protocol_list is the list of supported protocols by =
both server and client=2E
+   For example flower:power:sys_info would indic=
ate these three protocols
+   are supported=2E max_msg_len specifies the ma=
ximum message length that the
+   peer supports=2E
+
+   In server mode the=
se information are available in the acc_protocols and
+   acc_message_len v=
ariables of the client environment=2E
 
 Variables:
 
diff --git a/src/open=
vpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2Eebc4db6 10=
0644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -45=
,6 +45,7 @@
 sbin_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec a=
cc=2Eh \
 	argv=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=2Eh \
 	base64=
=2Ec base64=2Eh \
@@ -124,7 +125,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec p=
roxy=2Eh \
 	ps=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2Ec=
 push=2Eh \
+	push_util=2Ec \
 	pushlist=2Eh \
 	reflect_filter=2Ec reflect=
_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
diff --git a/src/openvpn/acc=2E=
c b/src/openvpn/acc=2Ec
new file mode 100644
index 0000000=2E=2Ee203755
---=
 /dev/null
+++ b/src/openvpn/acc=2Ec
@@ -0,0 +1,451 @@
+/*
+ *  OpenVPN -- =
An application to securely tunnel IP networks
+ *             over a single=
 TCP/UDP port, with support for SSL/TLS-based
+ *             session authe=
ntication and key exchange,
+ *             packet encryption, packet authe=
ntication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C)=
 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwab=
e <arne@rfc2549=2Eorg>
+ *
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
 write to the Free Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fi=
fth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#incl=
ude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <string=2Eh>=

+#include "buffer=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#include=
 "forward=2Eh"
+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
+#incl=
ude "ssl_ncp=2Eh"
+#include "multi=2Eh"
+
+enum acc_message_flag
+{
+    AC=
C_MESSAGE_FLAGS_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_=
MESSAGE_FLAGS_FRAGMENT =3D 4,
+};
+
+
+static void
+log_acc_message(struct =
context *c, const struct buffer *buf, int payload_len,
+                con=
st char *protocol, int flags)
+{
+    bool fragment =3D flags & ACC_MESSAGE=
_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc =3D gc_n=
ew();
+    const char *payload_msg =3D NULL;
+
+    /* For simplicity, we a=
lways encode payload to be base64 encoded
+     * if not already in base64 =
format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+        char *b=
64out =3D NULL;
+        ASSERT(openvpn_base64_encode(CBPTR(buf), payload_l=
en, &b64out) >=3D 0);
+        gc_addspecial(b64out, free, &gc);
+        p=
ayload_msg =3D b64out;
+    }
+    else
+    {
+        payload_msg =3D CBS=
TR(buf);
+    }
+
+    if (management)
+    {
+        struct tls_session *=
session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+        if (c->optio=
ns=2Emode =3D=3D MODE_SERVER)
+        {
+            /* server mode=2E Rep=
ort client context */
+            struct man_def_auth_context *mda =3D ses=
sion->opt->mda_context;
+            unsigned int mda_key_id =3D get_primar=
y_key(c->c2=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CLIENT:A=
CC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_key_id, protocol, fragm=
ent, payload_msg);
+        }
+        else
+        {
+            /* Clie=
nt mode=2E Do not a report a CLIENT id */
+            msg(M_CLIENT, ">ACC:=
%s,%d,%s", protocol, fragment, payload_msg);
+        }
+    }
+    gc_free=
(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Received cus=
tom app control message (protocol '%s'%s)",
+        protocol, fragment ? "=
, fragment" : "");
+}
+
+
+/**
+ *  Parses the flags field of an app contro=
l message and moves the
+ *  buffer past the flags string=2E If there is an=

+ *  error parsing the flags field the method returns -1 and
+ *  puts the=
 error reason in err_reason
+ */
+static int
+parse_acc_message_flags(struc=
t buffer *buf, const char **err_reason, struct gc_arena *gc)
+{
+    const =
char *flags =3D buf_extract_field(buf, ',', gc);
+
+    if (!flags)
+    {
=
+        *err_reason =3D "could not extract flags field";
+        return -=
1;
+    }
+
+
+    int acc_flags =3D 0;
+
+    for (const char *flag =3D fl=
ags; *flag !=3D '\0'; flag++)
+    {
+        if (*flag =3D=3D 'A')
+      =
  {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;
+        }
+      =
  else if (*flag =3D=3D '6')
+        {
+            acc_flags |=3D ACC_MES=
SAGE_FLAGS_BASE64;
+        }
+        else if (*flag =3D=3D 'F')
+        =
{
+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;
+        }
+     =
   else
+        {
+            *err_reason =3D "Unknown flag in flags";
+ =
           return -1;
+        }
+    }
+    /* The message should be encod=
ed with exactly one encoding=2E Ensure that
+     * only one of the flags i=
s present */
+    bool asciienc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_AS=
CII);
+    bool base64enc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_BASE64);=

+
+    if (base64enc + asciienc !=3D 1)
+    {
+        char *tmp =3D gc_m=
alloc(512, 1, gc);
+        snprintf(tmp, 512, "number of encodings must be=
 exactly one "
+                           "(B64=3D%d, ASCII=3D%d)",
+     =
            base64enc, asciienc);
+        *err_reason =3D tmp;
+        re=
turn -1;
+    }
+
+    return acc_flags;
+}
+
+
+void
+receive_acc_message(=
struct context *c, const struct buffer *buffer)
+{
+    struct gc_arena gc =
=3D gc_new();
+    const char *err_reason =3D "";
+
+    /* Example message=
: ACC,muppets,15,A,I am Miss Piggy */
+    struct buffer buf =3D *buffer;
+=

+    const struct tls_multi *multi =3D c->c2=2Etls_multi;
+    if (!multi-=
>acc_negotiated_protocols)
+    {
+        err_reason =3D "ACC not enabled =
or no negotiated protocols";
+        goto err;
+    }
+
+    if (!buf_adva=
nce(&buf, strlen("ACC")) || buf_read_u8(&buf) !=3D ',')
+    {
+        err=
_reason =3D "missing , after ACC";
+        goto err;
+    }
+
+    /* extr=
act protocol, payload length, flags substrings */
+    const char *protocol=
 =3D buf_extract_field(&buf, ',', &gc);
+    if (!protocol)
+    {
+       =
 err_reason =3D "could not extract protocol field";
+        goto err;
+   =
 }
+
+    if (!tls_item_in_cipher_list(protocol, multi->acc_negotiated_prot=
ocols))
+    {
+        struct buffer msg_buf =3D alloc_buf_gc(1024, &gc);
=
+        buf_printf(&msg_buf, "protocol '%s' not in list of negotiated prot=
ocols '%s'",
+                   protocol, multi->acc_negotiated_protocols)=
;
+        err_reason =3D buf_cstr(&msg_buf);
+
+
+        goto err;
+    }=

+
+    /* We do not check the length here=2E We make no promises to suppor=
t
+     * anything larger than our announced message length but according t=
o
+     * the robustness principle
+     * ("be conservative in what you se=
nd, be liberal in what you accept" - RFC 793 and others)
+     * we accept =
also longer messages */
+
+    int payload_len;
+    const char *payload_le=
n_str =3D buf_extract_field(&buf, ',', &gc);
+    if (!payload_len_str
+   =
     || !atoi_constrained(payload_len_str, &payload_len, "acc_payload_len",=
 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))
+    {
+        err_reason =
=3D "could not extract payload length field";
+        goto err;
+    }
+
+=
    int flags =3D parse_acc_message_flags(&buf, &err_reason, &gc);
+
+    i=
f (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We should have a f=
inal NUL byte in the control message buffer
+     * and thus the length of =
the buffer should be payload_len + 1 */
+    if (buf_len(&buf) !=3D payload=
_len + 1)
+    {
+        char *tmp =3D gc_malloc(512, 1, &gc);
+        sn=
printf(tmp, 512, "field length %d, payload length %d mismatch",
+          =
       payload_len, buf_len(&buf) - 1);
+        err_reason =3D tmp;
+     =
   goto err;
+    }
+
+
+    log_acc_message(c, &buf, payload_len, protocol=
, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERRORS, "=
WARNING: Received malformed custom app control channel "
+                 =
      "message (%s): %s",
+        err_reason,
+        format_hex(CBPTR(bu=
ffer), BLEN(buffer), 80, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send_acc_m=
essage(struct context *c,
+                 struct tls_multi *multi,
+     =
            struct tls_session *session,
+                 const char *prot=
ocol, bool fragment,
+                 const char *acc_msg_payload, bool ba=
se64)
+{
+    /*
+     * length of the protocol string + one ','
+     * 2 =
for the encoding (A or 6), potential F (fragment), and 1 for the ',',
+    =
 * 4 for the message size itself and one comma
+     * 1 for the comma befo=
re the message itself */
+    const size_t max_header_size =3D strlen("ACC,=
") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len =3D max_header_s=
ize + strlen(acc_msg_payload);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+    =
{
+        msg(M_CLIENT, "message length (%zu) exceeds maximum possible mes=
sage length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+    =
}
+
+    if ((int)len > multi->acc_max_message_length)
+    {
+        msg(=
M_CLIENT, "header (%zu) + message size (%zu) length (%zu) exceeds "
+      =
                "maximum allowed length negotiated with peer (%d)",
+      =
      max_header_size, strlen(acc_msg_payload), len,
+            multi->ac=
c_max_message_length);
+        return false;
+    }
+
+    struct gc_arena=
 gc =3D gc_new();
+    /* add 1 for the final \0 */
+    struct buffer buf =
=3D alloc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC,muppets,15,A=
,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protocol,
+=
               strlen(acc_msg_payload),
+               base64 ? "6" : "A",=

+               fragment ? "F" : "",
+               acc_msg_payload);
+
+=
    bool ret =3D send_control_channel_string_dowork(session, BSTR(&buf), D_=
PUSH);
+    reschedule_multi_process(c);
+    gc_free(&gc);
+    return ret=
;
+}
+
+char *
+parse_acc_parameters(const char *capabilities,
+           =
          const char *delim,
+                     int *max_acc_len,
+     =
                bool server,
+                     struct gc_arena *gc)
+{
=
+    char *tmp_message =3D string_alloc(capabilities, NULL);
+    char *tmp=
_message_orig =3D tmp_message;
+    char *lasts =3D NULL;
+
+    const char=
 *token =3D strtok_r(tmp_message, delim, &lasts);
+
+    int p =3D 0;
+    =
int acclen =3D 0;
+    const char *protocols =3D NULL;
+    char *ret =3D N=
ULL;
+
+    /* In server mode we allow more capabilities than our own, in c=
lient
+     * mode we reject if we should use capabilities that we do not s=
upport */
+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
=
+
+    while (token)
+    {
+        if (p =3D=3D 0 && !atoi_constrained(to=
ken, &acclen, "ACC message length", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUS=
H_ERRORS))
+        {
+            goto done;
+        }
+
+        if (p =
=3D=3D 1 && (!tls_item_in_cipher_list("A", token) || !tls_item_in_cipher_li=
st("6", token)))
+        {
+            msg(D_PUSH_ERRORS, "App custom con=
trol encoding must include base64 and ascii");
+            goto done;
+   =
     }
+
+        if (p =3D=3D 1 && !server && strcmp(token, "A:6") && strc=
mp(token, "6:A"))
+        {
+            msg(D_PUSH_ERRORS, "App custom co=
ntrol encoding must be exactly base64 and ascii");
+            goto done;
=
+        }
+
+        if (p =3D=3D 2)
+        {
+            protocols =3D=
 token;
+        }
+
+        if (p =3D=3D 3)
+        {
+            msg(D=
_PUSH_ERRORS, "Too many parameters for INFO ACC message/IV_ACC=2E");
+     =
       goto done;
+        }
+
+        token =3D strtok_r(NULL, delim, &la=
sts);
+        p++;
+    }
+
+    *max_acc_len =3D min_int(acclen, ACC_MAX_=
MSG_LEN);
+    ret =3D string_alloc(protocols, gc);
+
+done:
+    free(tmp_=
message_orig);
+    return ret;
+}
+
+struct buffer
+get_list_intersection(=
struct gc_arena *gc, const char *list1, const char *list2)
+{
+    char *tm=
p =3D string_alloc(list1, NULL);
+    char *lasts =3D NULL;
+    const char=
 *token =3D strtok_r(tmp, ":", &lasts);
+
+    /* The maximum possible leng=
th is the shorter of the two input lists */
+    size_t max_len =3D min_siz=
e(strlen(list1), strlen(list2));
+
+    struct buffer common_protocols =3D =
alloc_buf_gc(max_len + 1, gc);
+
+    while (token)
+    {
+        /* chec=
k for every items is in both lists and not already in the
+         * commo=
n list */
+        if (tls_item_in_cipher_list(token, list2)
+            &=
& !tls_item_in_cipher_list(token, buf_cstr(&common_protocols)))
+        {
=
+            if (buf_len(&common_protocols) > 0)
+            {
+          =
      buf_write_u8(&common_protocols, ':');
+            }
+            buf=
_printf(&common_protocols, "%s", token);
+        }
+        token =3D strt=
ok_r(NULL, ":", &lasts);
+    }
+    free(tmp);
+    return common_protocol=
s;
+}
+
+void
+determine_common_acc_protocols(struct tls_multi *multi, stru=
ct tls_session *session)
+{
+    if (!multi->opt=2Eacc_protocols)
+    {
+ =
       /* No app custom protocols have been configured server-side=2E */
+ =
       return;
+    }
+
+    if (multi->acc_negotiated_protocols)
+    {
+ =
       /* We already have determined the common protocols=2E */
+        re=
turn;
+    }
+
+    struct gc_arena gc =3D gc_new();
+
+    /* example IV_A=
CC: IV_ACC=3D2048,6:A,flower:power */
+    const char *peer_info =3D multi-=
>peer_info;
+    const char *iv_acc =3D extract_var_peer_info(peer_info, "I=
V_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+        gc_free(&gc);
+        r=
eturn;
+    }
+
+    int max_acc_len =3D 0;
+    const char *protocols =3D =
parse_acc_parameters(iv_acc, ",", &max_acc_len, true, &gc);
+
+    if (!pro=
tocols)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING:=
 IV_ACC peer info variable of peer is malformed");
+        return;
+    }
=
+
+    struct buffer common_protocols =3D get_list_intersection(&gc, multi-=
>opt=2Eacc_protocols, protocols);
+
+    if (buf_len(&common_protocols) =3D=
=3D 0)
+    {
+        msg(D_PUSH_DEBUG, "WARNING: No common app custom con=
trol protocol=2E");
+        gc_free(&gc);
+        return;
+    }
+
+    m=
ulti->acc_negotiated_protocols =3D string_alloc(buf_str(&common_protocols),=
 NULL);
+    multi->acc_max_message_length =3D max_acc_len;
+
+    setenv_s=
tr(session->opt->es, "acc_protocols", multi->acc_negotiated_protocols);
+  =
  setenv_int(session->opt->es, "acc_message_len", multi->acc_max_message_le=
ngth);
+
+    gc_free(&gc);
+}
+
+void
+notify_client_acc_protocols(struct =
tls_multi *multi)
+{
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
=
+        msg(M_CLIENT, ">ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d",
+ =
           multi->acc_negotiated_protocols, multi->acc_max_message_length);=

+    }
+#endif
+}
diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
n=
ew file mode 100644
index 0000000=2E=2E4ee94d3
--- /dev/null
+++ b/src/open=
vpn/acc=2Eh
@@ -0,0 +1,112 @@
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
+ *  Copyright (C) 2025 OpenVPN Inc <sales@=
openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ =
*
+ *
+ *  This program is free software; you can redistribute it and/or mo=
dify
+ *  it under the terms of the GNU General Public License version 2
+ =
*  as published by the Free Software Foundation=2E
+ *
+ *  This program is=
 distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRA=
NTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS F=
OR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for mor=
e details=2E
+ *
+ *  You should have received a copy of the GNU General Pu=
blic License along
+ *  with this program; if not, write to the Free Softwa=
re Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA=2E
+ */
+
+#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn=2E=
h"
+
+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * T=
his method parses an app custom control message and delivers it to the
+ * =
management interface=2E We leave reassembly of fragmented messages to the
+=
 * management interface=2E
+ *
+ * @param c            The context struct
+=
 * @param buffer       Buffer containing the control message with ACC
+ */
=
+void
+receive_acc_message(struct context *c, const struct buffer *buffer);=

+
+bool
+send_acc_message(struct context *c,
+                 struct tls_=
multi *tls_multi,
+                 struct tls_session *session,
+         =
        const char *protocol, bool fragment,
+                 const char *=
msg, bool base64);
+
+
+/**
+ * Parses an info message from the server that=
 contains app custom control info
+ * information prior to the PUSH_REPLY t=
o be able to use app custom control
+ * protocols before sending
+ *
+ * In=
 client mode only allow what we support ourselves=2E In server mode
+ * all=
ow also capabilities that we not support ourselves=2E
+ *
+ * @param capabi=
lities      The string to parse
+ * @param delim             The delimiter =
to use when parsing the string=2E
+ *                          IV_ACC uses =
"," as delimiter while the
+ *                          custom-control PUSH=
 message uses " " as "," is
+ *                          already used to se=
parate different push directives
+ * @param max_acc_len       Set to the ma=
ximum ACC message length
+ * @param server            Whether we are server=
 or client
+ * @param gc                The gc arena to use for allocating =
the resulting string
+ * @return                  The resulting protocol st=
ring or NULL on error
+ */
+char *
+parse_acc_parameters(const char *capabi=
lities,
+                     const char *delim,
+                     int =
*max_acc_len,
+                     bool server,
+                     stru=
ct gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of the peer and sets multi=
=2Eacc_negotiated_protocols
+ * to the common protocols of server and clien=
t and
+ * multi=2Eacc_max_message_length  to the maximum length of the ACC =
message
+ * support by both server and client=2E
+ *
+ * If there is no com=
mon protocol or the client does not support any app custom
+ * protocol mul=
ti=2Eacc_negotiated_protocols will be set to NULL=2E
+ *
+ * @param multi  =
    the multi instance to use the set the app custom protocols=2E
+ * @para=
m session    the session to read the client env from
+ */
+void
+determine_=
common_acc_protocols(struct tls_multi *multi, struct tls_session *session);=

+
+/**
+ * Calculates the intersection of two list that are both separated=
 by :
+ * Items in the result will have the same ordering as in the list1
+=
 * parameters
+ * @param gc            Returned buffer will be allocated in=
 this gc
+ * @param list1         First list to intersect
+ * @param list2 =
        Second list to intersect=2E
+ * @return A (potentially empty) buffe=
r containing an intersection list
+ */
+struct buffer
+get_list_intersectio=
n(struct gc_arena *gc, const char *list1, const char *list2);
+
+/**
+ * No=
tifies a client via management interface of the negotiated app
+ * custom p=
rotocols
+ * @param multi the tls_multi instance of the connection
+ */
+vo=
id
+notify_client_acc_protocols(struct tls_multi *multi);
+#endif
diff --gi=
t a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 681210d=2E=2Eeb=
41d03 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@=
 -42,6 +42,7 @@
 #include "dco=2Eh"
 #include "auth_token=2Eh"
 #include "t=
un_afunix=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -257,11 +2=
58,11 @@
     }
     else if (buf_string_match_head_str(buf, "INFO_PRE"))
 =
    {
-        server_pushed_info(buf, 8);
+        peer_pushed_info(c, buf=
, 8);
     }
     else if (buf_string_match_head_str(buf, "INFO"))
     {
-=
        server_pushed_info(buf, 4);
+        peer_pushed_info(c, buf, 4);
 =
    }
     else if (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
@=
@ -271,6 +272,10 @@
     {
         receive_auth_pending(c, buf);
     }
+ =
   else if (buf_string_match_head_str(buf, "ACC"))
+    {
+        receive_=
acc_message(c, buf);
+    }
     else if (buf_string_match_head_str(buf, "E=
XIT"))
     {
         receive_exit_message(c);
diff --git a/src/openvpn/in=
it=2Ec b/src/openvpn/init=2Ec
index 1b8b2a5=2E=2Ee0b99a4 100644
--- a/src/o=
penvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -56,6 +56,7 @@
 #include "sch=
edule=2Eh"
 #include "options_string=2Eh"
 #include "resolve=2Eh"
+#include=
 "acc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -2279,6 +2280,13 @@
         }
   =
  }
 
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    if (multi &&=
 multi->acc_negotiated_protocols)
+    {
+        buf_printf(&out, " custom=
-control %d A:6 %s",
+                   multi->acc_max_message_length, mul=
ti->acc_negotiated_protocols);
+    }
+
     if (BLENZ(&out) > strlen(heade=
r))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +2530,11=
 @@
         flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c-=
>options=2Eacc_protocols)
+    {
+        flags |=3D OPT_P_ACC;
+    }
+
  =
   return flags;
 }
 
@@ -2730,6 +2743,18 @@
         frame->tun_mtu =3D mi=
n_int(frame->tun_max_mtu, c->options=2Ece=2Etun_mtu);
     }
 
+    if (fou=
nd & OPT_P_ACC && c->options=2Epushed_acc_negotiated_protocols)
+    {
+   =
     struct tls_multi *multi =3D c->c2=2Etls_multi;
+        free(multi->ac=
c_negotiated_protocols);
+        multi->acc_negotiated_protocols =3D strin=
g_alloc(c->options=2Epushed_acc_negotiated_protocols, NULL);
+        multi=
->acc_max_message_length =3D c->options=2Epushed_acc_max_message_length;
+
=
+        msg(D_PUSH, "OPTIONS IMPORT: ACC protocols: %s, msg len: %d",
+   =
         multi->acc_negotiated_protocols, multi->acc_max_message_length);
+=
        notify_client_acc_protocols(multi);
+    }
+
     return true;
 }
 =

@@ -3352,6 +3377,7 @@
     to=2Everify_hash_depth =3D options->verify_hash=
_depth;
     to=2Everify_hash_no_ca =3D options->verify_hash_no_ca;
     me=
mcpy(to=2Ex509_username_field, options->x509_username_field, sizeof(to=2Ex5=
09_username_field));
+    to=2Eacc_protocols =3D options->acc_protocols;
  =
   to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -4306,6 =
+4332,24 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+managemen=
t_acc_msg(void *arg,
+                   struct buffer_list *input) /* owne=
rship transferred */
+{
+    struct context *c =3D arg;
+
+    bool ret =3D=
 false;
+    if (buffer_list_defined(input) && c->c2=2Etls_multi)
+    {
+ =
       struct tls_multi *multi =3D c->c2=2Etls_multi;
+        struct tls_s=
ession *session =3D &multi->session[TM_ACTIVE];
+
+        ret =3D manageme=
nt_send_acc_message(c, multi, session, input);
+    }
+
+    buffer_list_fr=
ee(input);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 voi=
d
@@ -4322,6 +4366,7 @@
         cb=2Eproxy_cmd =3D management_callback_pro=
xy_cmd;
         cb=2Eremote_cmd =3D management_callback_remote_cmd;
      =
   cb=2Esend_cc_message =3D management_callback_send_cc_message;
+        c=
b=2Eacc_msg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=2Ene=
twork_change =3D management_callback_network_change;
 #endif
diff --git a/s=
rc/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ac3d4b7=2E=2E2b6b901 1=
00644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -45,9 +4=
5,11 @@
 #include "push=2Eh"
 #include "multi=2Eh"
 #include "resolve=2Eh"
=
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 #include "run_command=2Eh"
+#=
include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh"
@@ -10=
81,6 +1083,35 @@
             }
             break;
 
+        case IEC_CLI=
ENT_ACC_MSG:
+            if (man->persist=2Ecallback=2Eclient_acc_msg)
+  =
          {
+                bool status =3D (*man->persist=2Ecallback=2Ecl=
ient_acc_msg)(man->persist=2Ecallback=2Earg,
+                             =
                                         man->connection=2Ein_extra_cid,
+ =
                                                                     man->c=
onnection=2Ein_extra_kid,
+                                                =
                      man->connection=2Ein_extra);
+                man->co=
nnection=2Ein_extra =3D NULL;
+                report_command_status(status=
, "client-acc-msg");
+            }
+            else
+            {
+     =
           man_command_unsupported("client-acc-msg");
+            }
+     =
       break;
+
+        case IEC_ACC_MSG:
+            if (man->persist=2E=
callback=2Eacc_msg)
+            {
+                bool status =3D (*man->=
persist=2Ecallback=2Eacc_msg)(man->persist=2Ecallback=2Earg,
+             =
                                                  man->connection=2Ein_extr=
a);
+                man->connection=2Ein_extra =3D NULL;
+                =
report_command_status(status, "acc-msg");
+            }
+            else
=
+            {
+                man_command_unsupported("acc-msg");
+      =
      }
+            break;
         case IEC_PK_SIGN:
             man->co=
nnection=2Eext_key_state =3D EKS_READY;
             buffer_list_free(man->=
connection=2Eext_key_input);
@@ -1205,6 +1236,29 @@
 }
 
 static void
+man_=
client_acc_msg(struct management *man, const char *cid_str,
+              =
     const char *kid_str)
+{
+    struct man_connection *mc =3D &man->conne=
ction;
+    mc->in_extra_cid =3D 0;
+    mc->in_extra_kid =3D 0;
+    if (p=
arse_cid(cid_str, &mc->in_extra_cid)
+        && parse_uint(kid_str, "KID",=
 &mc->in_extra_kid))
+    {
+        mc->in_extra_cmd =3D IEC_CLIENT_ACC_MS=
G;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void
+man_acc_=
msg(struct management *man)
+{
+    struct man_connection *mc =3D &man->con=
nection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+    in_extra_reset(mc, IER=
_NEW);
+}
+
+static void
 man_client_auth(struct management *man, const cha=
r *cid_str, const char *kid_str, const bool extra)
 {
     struct man_conne=
ction *mc =3D &man->connection;
@@ -1759,6 +1813,17 @@
             man_cli=
ent_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
+    else =
if (streq(p[0], "client-acc-msg"))
+    {
+        if (man_need(p, 2, 0))
+=
        {
+            man_client_acc_msg(man, p[1], p[2]);
+        }
+   =
 }
+    else if (streq(p[0], "acc-msg"))
+    {
+        man_acc_msg(man);
=
+    }
     else if (streq(p[0], "rsa-sig"))
     {
         man_pk_sig(man=
, "rsa-sig");
@@ -2975,7 +3040,9 @@
                                       =
 "bytes_sent=3D",
                                        "bytes_received=
=3D",
                                        "session_id=3D",
-           =
                            "session_state=3D" };
+                        =
               "session_state=3D",
+                                       =
"acc_protocols=3D",
+                                       "acc_message_le=
n=3D" };
 
     if (env_filter_level =3D=3D 0)
     {
@@ -3130,6 +3197,7 @@=

     }
 }
 
+
 void
 management_connection_established(struct management *=
man, struct man_def_auth_context *mdac,
                                   =
const struct env_set *es)
@@ -4372,6 +4440,70 @@
     }
 }
 
+bool
+managem=
ent_send_acc_message(struct context *c, struct tls_multi *multi, struct tls=
_session *session,
+                            struct buffer_list *input)
=
+{
+    /* also ensures that are enough inputs in the list to safely call
+=
     * buffer_list_peek without extra NULL checks */
+    if (!input || inp=
ut->size < 3)
+    {
+        msg(M_CLIENT, "not enough input lines for sen=
ding acc message, "
+                      "missing protocol, flag and/or m=
essages lines");
+        return false;
+    }
+
+    struct gc_arena gc =
=3D gc_new();
+
+    const struct buffer *proto_buf =3D buffer_list_peek(in=
put);
+    const char *protocol =3D string_alloc(CBSTR(proto_buf), &gc);
+ =
   buffer_list_pop(input);
+
+    struct buffer *encoding_buf =3D buffer_li=
st_peek(input);
+    char *encoding =3D buf_str(encoding_buf);
+    const c=
har *flag =3D NULL;
+    bool b64encoding =3D false;
+    bool fragment =3D=
 false;
+
+    while ((flag =3D strsep(&encoding, ":")))
+    {
+        if=
 (!strcmp(flag, "6"))
+        {
+            b64encoding =3D true;
+      =
  }
+        else if (!strcmp(flag, "F"))
+        {
+            fragment =
=3D true;
+        }
+        else
+        {
+            msg(M_CLIENT, "p=
rotocol '%s' not in the list of supported flags",
+                flag);
+=
            goto error;
+        }
+    }
+    buffer_list_pop(input);
+
+ =
   buffer_list_aggregate_separator(input, 10000, "");
+    const struct buf=
fer *acc_msg_buf =3D buffer_list_peek(input);
+
+    if (!multi->acc_negoti=
ated_protocols
+        || !tls_item_in_cipher_list(protocol, multi->acc_ne=
gotiated_protocols))
+    {
+        msg(M_CLIENT, "protocol not in the lis=
t of negotiated protocols: %s",
+            np(multi->acc_negotiated_proto=
cols));
+        goto error;
+    }
+
+    bool ret =3D send_acc_message(c,=
 multi, session, protocol,
+                                fragment, buf_c=
str(acc_msg_buf),
+                                b64encoding);
+    gc_fr=
ee(&gc);
+    return ret;
+error:
+    gc_free(&gc);
+    return false;
+}
=
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
diff --git a/s=
rc/openvpn/manage=2Eh b/src/openvpn/manage=2Eh
index 157039d=2E=2Ecc9c264 1=
00644
--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 =
+184,19 @@
     int (*n_clients)(void *arg);
     bool (*send_cc_message)(v=
oid *arg, const char *message, const char *parameter);
     bool (*kill_by_=
cid)(void *arg, const unsigned long cid, const char *kill_msg);
+
     bool=
 (*client_auth)(void *arg, const unsigned long cid, const unsigned int mda_=
key_id,
                         const bool auth, const char *reason, const=
 char *client_reason,
                         struct buffer_list *cc_confi=
g); /* ownership transferred */
     bool (*client_pending_auth)(void *arg,=
 const unsigned long cid, const unsigned int kid,
                         =
        const char *extra, unsigned int timeout);
     char *(*get_peer_inf=
o)(void *arg, const unsigned long cid);
+    bool (*client_acc_msg)(void *a=
rg,
+                           const unsigned long cid,
+                 =
          const unsigned int mda_key_id,
+                           struct=
 buffer_list *msg);
+    bool (*acc_msg)(void *arg,
+                    st=
ruct buffer_list *msg);
     bool (*proxy_cmd)(void *arg, const char **p);
=
     bool (*remote_cmd)(void *arg, const char **p);
 #ifdef TARGET_ANDROID
=
@@ -292,13 +299,15 @@
     struct command_line *in;
     struct buffer_list=
 *out;
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#define IEC=
_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF  =
 2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE=
 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#define IEC_RSA_S=
IGN       3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN        5
+#d=
efine IEC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_M=
SG        8
     int in_extra_cmd;
     struct buffer_list *in_extra;
     =
unsigned long in_extra_cid;
@@ -503,6 +512,14 @@
 
 void man_persist_client=
_stats(struct management *man, struct context *c);
 
+/** Parses the ACC me=
ssage from the input buffer_list and send to the
+ * session identified by =
session and multi
+ */
+struct tls_session;
+struct tls_multi;
+bool
+manag=
ement_send_acc_message(struct context *c, struct tls_multi *multi,
+       =
                     struct tls_session *session, struct buffer_list *input=
);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/mu=
lti=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2Ea3eb3ca 100644
--- a/src=
/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #include =
"ssl_util=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#include=
 "acc=2Eh"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -4085,6 +4086,26 @@
 =
    }
 }
 
+static const char *
+calculate_app_control_extra(struct multi_i=
nstance *mi, struct gc_arena *gc)
+{
+    struct context *c =3D &mi->contex=
t;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!multi->a=
cc_negotiated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No negotiated =
protocols");
+        return NULL;
+    }
+
+    struct buffer buf =3D allo=
c_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", multi->acc_max=
_message_length,
+               multi->acc_negotiated_protocols);
+    ret=
urn buf_str(&buf);
+}
+
+
 static bool
 management_client_pending_auth(void=
 *arg, const unsigned long cid, const unsigned int mda_key_id,
            =
                    const char *extra, unsigned int timeout)
@@ -4095,10 +4=
116,22 @@
     if (mi)
     {
         struct tls_multi *multi =3D mi->cont=
ext=2Ec2=2Etls_multi;
+
+        struct gc_arena gc =3D gc_new();
+        =
if (!strcmp(extra, "ACC"))
+        {
+            extra =3D calculate_app_=
control_extra(mi, &gc);
+            if (!extra)
+            {
+          =
      gc_free(&gc);
+                return false;
+            }
+        =
}
         struct tls_session *session =3D lookup_session_by_mda_key_id(mul=
ti, mda_key_id);
 
         if (!session)
         {
+            gc_free(&=
gc);
             return false;
         }
 
@@ -4106,6 +4139,7 @@
        =
 bool ret =3D send_auth_pending_messages(multi, session, extra, timeout);
 =
        reschedule_multi_process(&mi->context);
         multi_schedule_con=
text_wakeup(m, mi);
+        gc_free(&gc);
         return ret;
     }
    =
 return false;
@@ -4149,6 +4183,37 @@
     return ret;
 }
 
+
+static bool
=
+management_client_acc_msg(void *arg,
+                          const unsi=
gned long cid,
+                          const unsigned int mda_key_id,
+ =
                         struct buffer_list *input) /* ownership transferre=
d */
+{
+    struct multi_context *m =3D (struct multi_context *)arg;
+    =
struct multi_instance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D fa=
lse;
+    if (mi && buffer_list_defined(input))
+    {
+        struct tls_=
multi *multi =3D mi->context=2Ec2=2Etls_multi;
+        struct tls_session =
*session =3D lookup_session_by_mda_key_id(multi, mda_key_id);
+        if (=
!session)
+        {
+            msg(M_CLIENT, "client session not found")=
;
+            buffer_list_free(input);
+            return false;
+       =
 }
+
+        ret =3D management_send_acc_message(&mi->context, multi, sess=
ion, input);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
+    b=
uffer_list_free(input);
+    return ret;
+}
+
+
 static char *
 management_=
get_peer_info(void *arg, const unsigned long cid)
 {
@@ -4185,6 +4250,7 @@
=
         cb=2En_clients =3D management_callback_n_clients;
         cb=2Eki=
ll_by_cid =3D management_kill_by_cid;
         cb=2Eclient_auth =3D managem=
ent_client_auth;
+        cb=2Eclient_acc_msg =3D management_client_acc_msg=
;
         cb=2Eclient_pending_auth =3D management_client_pending_auth;
   =
      cb=2Eget_peer_info =3D management_get_peer_info;
         cb=2Epush_u=
pdate_broadcast =3D management_callback_send_push_update_broadcast;
diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index fb319ae=2E=2E=
a5e7396 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
=
@@ -35,6 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #include=
 "buffer=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -2552,6 +2553=
,8 @@
     o->push_option_types_found =3D 0;
     o->push_update_options_fo=
und =3D 0;
     o->imported_protocol_flags =3D 0;
+    o->pushed_acc_max_me=
ssage_length =3D 0;
+    o->pushed_acc_negotiated_protocols =3D NULL;
 }
 
=
 static void
@@ -7107,6 +7110,47 @@
         VERIFY_PERMISSION(OPT_P_GENERA=
L);
         options->force_key_material_export =3D true;
     }
+    else =
if (streq(p[0], "app-custom-control") && p[1] && !p[2])
+    {
+        VER=
IFY_PERMISSION(OPT_P_GENERAL);
+        if (!string_class(p[1], CC_ALNUM | =
CC_COLON | CC_UNDERBAR | CC_DASH, 0))
+        {
+            msg(msglevel,=
 "App custom control protocols must only contain "
+                       =
   "alphanumeric characters, '-', and '_'=2E");
+            goto err;
+   =
     }
+        options->acc_protocols =3D p[1];
+    }
+    else if (streq=
(p[0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+        =
VERIFY_PERMISSION(OPT_P_ACC);
+
+        /* check if the list from the serv=
er is a real subset of our list */
+        struct gc_arena gc_local =3D gc=
_new();
+        struct buffer common_list =3D get_list_intersection(&gc_lo=
cal, p[3], options->acc_protocols);
+
+        if (buf_len(&common_list) =
=3D=3D 0 || !streq(p[3], buf_cstr(&common_list)))
+        {
+            m=
sg(msglevel, "App custom control list from server contains "
+             =
             "unsupported protocols");
+            gc_free(&gc_local);
+  =
          goto err;
+        }
+        gc_free(&gc_local);
+
+        if (=
!streq(p[2], "6:A") && !streq(p[2], "A:6"))
+        {
+            msg(msg=
level, "App custom control encoding must be base64 and ascii");
+          =
  goto err;
+        }
+
+        if (!atoi_constrained(p[1], &options->pus=
hed_acc_max_message_length,
+                              "app custom mess=
age message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        =
{
+            goto err;
+        }
+        options->pushed_acc_negotiated=
_protocols =3D p[3];
+    }
     else if (streq(p[0], "prng") && p[1] && !p=
[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL librar=
y PRNG is used)");
diff --git a/src/openvpn/options=2Eh b/src/openvpn/optio=
ns=2Eh
index 6a3bf61=2E=2Eb7945e0 100644
--- a/src/openvpn/options=2Eh
+++ =
b/src/openvpn/options=2Eh
@@ -715,6 +715,18 @@
     /* force using TLS key =
material export for data channel key generation */
     bool force_key_mate=
rial_export;
 
+    /** The app custom control protocols we should announce=
 as supported */
+    const char *acc_protocols;
+
+    /** the protocols t=
hat are negotiated with the peer=2E This is a
+     *  a temporary variable=
 since options=2Ec push parser cannot access
+     *  tls multi struct */
+=
    const char *pushed_acc_negotiated_protocols;
+
+    /** the maximum len=
gth of an ACC control channel message via push message
+     * */
+    int =
pushed_acc_max_message_length;
+
     bool vlan_tagging;
     enum vlan_acc=
eptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -764,8 +776,10 @@
 =
#define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_MTU        (1u=
 << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC       =
      (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_=
MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal configura=
tion file (vs pushed options or in ccd files) */
+#define OPT_P_DEFAULT (~(=
OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define P=
ULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push=2Ec b/src/op=
envpn/push=2Ec
index 42259c3=2E=2Ea18f33b 100644
--- a/src/openvpn/push=2Ec=

+++ b/src/openvpn/push=2Ec
@@ -27,6 +27,8 @@
 #include "syshead=2Eh"
 
 #i=
nclude "push=2Eh"
+
+#include "acc=2Eh"
 #include "options=2Eh"
 #include "=
crypto=2Eh"
 #include "ssl=2Eh"
@@ -221,9 +223,56 @@
 #endif
 }
 
+static v=
oid
+parse_server_pushed_info_acc(struct context *c, struct buffer *buf)
+{=

+    int max_acc_len =3D 0;
+    struct tls_multi *multi =3D c->c2=2Etls_m=
ulti;
+
+    if (multi->acc_negotiated_protocols)
+    {
+        return;
+=
    }
+
+    if (!multi->opt=2Eacc_protocols || !c->options=2Epull)
+    {
=
+        msg(D_PUSH_ERRORS, "Peer tried to push app custom control list "
+=
                           "without client announcing support for it");
+  =
      return;
+    }
+
+    /* example string to parse: ACC:1400 A:6 flower=
:happy */
+    /* Skip over the ACC: prefix */
+    buf_advance(buf, 4);
+
=
+    struct gc_arena gc =3D gc_new();
+    const char *protocols =3D parse_=
acc_parameters(buf_cstr(buf), " ", &max_acc_len, false, &gc);
+    if (!pro=
tocols)
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC info comm=
and with invalid parameters");
+        gc_free(&gc);
+        return;
+   =
 }
+
+    /* check if the list from the server is a real subset of our list=
 */
+    struct buffer common_list =3D get_list_intersection(&gc, protocols=
, multi->opt=2Eacc_protocols);
+
+    if (buf_len(&common_list) =3D=3D 0 ||=
 !streq(protocols, buf_cstr(&common_list)))
+    {
+        msg(D_PUSH_ERRO=
RS, "App custom control list from server contains "
+                      =
     "unsupported protocols");
+        gc_free(&gc);
+        return;
+   =
 }
+
+    multi->acc_negotiated_protocols =3D string_alloc(protocols, NULL)=
;
+    multi->acc_max_message_length =3D max_acc_len;
+    notify_client_ac=
c_protocols(multi);
+    gc_free(&gc);
+}
 
 void
-server_pushed_info(const=
 struct buffer *buffer, const int adv)
+peer_pushed_info(struct context *c,=
 const struct buffer *buffer, const int adv)
 {
     const char *m =3D "";
=
     struct buffer buf =3D *buffer;
@@ -233,6 +282,12 @@
         m =3D BST=
R(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        =
parse_server_pushed_info_acc(c, &buf);
+        return;
+    }
+
 #ifdef EN=
ABLE_MANAGEMENT
     struct gc_arena gc;
     if (management)
@@ -257,7 +31=
2,7 @@
         gc_free(&gc);
     }
 #endif
-    msg(D_PUSH, "Info command=
 was pushed by server ('%s')", m);
+    msg(D_PUSH, "Info command was pushe=
d by peer ('%s')", m);
 }
 
 void
@@ -285,6 +340,7 @@
     msg(D_PUSH, "CR =
response was sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keyword =
for the AUTH_PENDING request
  * @param buffer                buffer contai=
ning the keywords, the buffer's
@@ -441,7 +497,6 @@
     const char *const =
peer_info =3D tls_multi->peer_info;
     unsigned int proto =3D extract_iv_=
proto(peer_info);
 
-
     /* Calculate the maximum timeout and subtract th=
e time we already waited */
     unsigned int max_timeout =3D
         max_=
uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake_w=
indow);
@@ -732,6 +787,12 @@
                 client_max_mtu, o->ce=2Etun_m=
tu, o->ce=2Etun_mtu);
         }
     }
+
+    if (tls_multi->acc_negotiate=
d_protocols)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "custo=
m-control %d A:6 %s",
+                        tls_multi->acc_max_message_l=
ength, tls_multi->acc_negotiated_protocols);
+    }
 }
 
 static bool
diff =
--git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index 39302f6=2E=2Ee08c=
d66 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 +=
52,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /**
 =
 * @brief Handles the receiving of a push-update message and applies update=
s to the specified
  * options=2E
@@ -92,7 +93,15 @@
 
 void receive_exit_m=
essage(struct context *c);
 
-void server_pushed_info(const struct buffer *=
buffer, const int adv);
+/**
+ * This message is called when an INFO or INF=
O_PRE message is received from
+ * a peer=2E
+ *
+ * @param c         Conte=
xt of the peer=2E
+ * @param buffer    Buffer containing the INFO/INFO_PRE =
message=2E
+ * @param adv       number of character to advance past the INF=
O/INFO_PRE header
+ */
+void peer_pushed_info(struct context *c, const stru=
ct buffer *buffer, const int adv);
 
 void receive_cr_response(struct conte=
xt *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/ssl=2Ec b/s=
rc/openvpn/ssl=2Ec
index 086a6fc=2E=2E97ef9b0 100644
--- a/src/openvpn/ssl=
=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch=
=2Eh"
 #include "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 #=
include "ssl_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
   =
  free(multi->locked_cn);
     free(multi->locked_username);
     free(mult=
i->locked_original_username);
+    free(multi->acc_negotiated_protocols);
 =

     cert_hash_free(multi->locked_cert_hash_set);
 
@@ -2098,6 +2100,11 @@=

 #endif
         }
 
+        if (session->opt->acc_protocols)
+        {
=
+            buf_printf(&out, "IV_ACC=3D%d,A:6,%s\n", ACC_MAX_MSG_LEN, sess=
ion->opt->acc_protocols);
+        }
+
         if (session->opt->push_peer=
_info_detail > 1)
         {
             struct env_set *es =3D session->o=
pt->es;
@@ -2398,6 +2405,8 @@
         multi->remote_ciphername =3D string_=
alloc("none", NULL);
     }
 
+    determine_common_acc_protocols(multi, se=
ssion);
+
     if (username_len < 0 || password_len < 0)
     {
         ms=
g(D_TLS_ERRORS, "TLS Error: Username (%d) or password (%d) too long", abs(u=
sername_len),
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_com=
mon=2Eh
index 9a55ead=2E=2E436770b 100644
--- a/src/openvpn/ssl_common=2Eh
=
+++ b/src/openvpn/ssl_common=2Eh
@@ -457,6 +457,9 @@
     size_t ekm_size;
=
 
     bool dco_enabled; /**< Whether keys have to be installed in DCO or n=
ot */
+
+    /** The app custom control protocols we should announce as sup=
ported */
+    const char *acc_protocols;
 };
 
 /** @addtogroup control_pr=
ocessor
@@ -730,6 +733,12 @@
     int dco_peer_id;
 
     dco_context_t *dc=
o;
+
+    /** the protocols that are negotiated with the peer=2E */
+    ch=
ar *acc_negotiated_protocols;
+
+    /** the maximum length of an ACC contr=
ol channel message */
+    int acc_max_message_length;
 };
 
 /**  gets an =
item  of \c key_state objects in the
diff --git a/tests/unit_tests/openvpn/=
Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E6=
a73e1e 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit=
_tests/openvpn/Makefile=2Eam
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_tes=
tdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver=
_SOURCES =3D test_ssl=2Ec \
+	test_acc=2Ec test_acc=2Eh \
 	mock_msg=2Ec mo=
ck_msg=2Eh test_common=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencie=
s=2Ec mock_win32_execve=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec=
 \
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(top_srcdir)/src/openvpn/argv=
=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn=
/buffer=2Ec \
@@ -132,6 +134,7 @@
 	$(top_srcdir)/src/openvpn/run_command=
=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec \
 	$(top_srcdir)/src/op=
envpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src/openvpn/ssl_ncp=2Ec \
 	$(top_s=
rcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_mb=
edtls=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \
diff --git=
 a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/=
mock_management=2Ec
index fff4c2b=2E=2Ef572dbb 100644
--- a/tests/unit_test=
s/openvpn/mock_management=2Ec
+++ b/tests/unit_tests/openvpn/mock_managemen=
t=2Ec
@@ -29,6 +29,7 @@
 
 #include "syshead=2Eh"
 
+#include <stdlib=2Eh>
=
 #include "manage=2Eh"
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/unit_=
tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/openvpn/mock_pu=
sh_dependencies=2Ec
index bf2ccf3=2E=2Ef083f89 100644
--- a/tests/unit_test=
s/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_pu=
sh_dependencies=2Ec
@@ -43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OP=
T_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
                      | =
OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
    =
                  | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | O=
PT_P_PULL_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PU=
SH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+                     | OPT_P_PEER_ID=
 | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+              =
       | OPT_P_ACC;
     return flags;
 }
 
diff --git a/tests/unit_tests/o=
penvpn/test_acc=2Ec b/tests/unit_tests/openvpn/test_acc=2Ec
new file mode 1=
00644
index 0000000=2E=2E9364d12
--- /dev/null
+++ b/tests/unit_tests/openv=
pn/test_acc=2Ec
@@ -0,0 +1,353 @@
+/*
+ *  OpenVPN -- An application to sec=
urely tunnel IP networks
+ *             over a single TCP/UDP port, with s=
upport for SSL/TLS-based
+ *             session authentication and key exc=
hange,
+ *             packet encryption, packet authentication, and
+ *   =
          packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=2Eorg=
>
+ *
+ *
+ *  This program is free software; you can redistribute it and/o=
r modify
+ *  it under the terms of the GNU General Public License version =
2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This progra=
m is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY W=
ARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for=
 more details=2E
+ *
+ *  You should have received a copy of the GNU Genera=
l Public License along
+ *  with this program; if not, write to the Free So=
ftware Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Boston, MA=
 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#en=
dif
+
+#include "syshead=2Eh"
+
+#include <stdio=2Eh>
+#include <stdlib=2Eh=
>
+#include <stdarg=2Eh>
+#include <string=2Eh>
+#include <setjmp=2Eh>
+#in=
clude <cmocka=2Eh>
+
+#include "acc=2Eh"
+#include "test_acc=2Eh"
+#include=
 "test_common=2Eh"
+
+#include "mock_msg=2Eh"
+#include "multi=2Eh"
+
+char=
 control_channel_message_sent[2048];
+
+/* Mock functions */
+bool
+send_co=
ntrol_channel_string_dowork(struct tls_session *session,
+                 =
                  const char *str, unsigned int msglevel)
+{
+    assert_in=
t_in_range(strlen(str), 0, 2047);
+
+    strcpy(control_channel_message_sen=
t, str);
+    return true;
+}
+
+void
+send_push_reply_auth_token(struct tl=
s_multi *multi)
+{
+}
+
+void
+auth_set_client_reason(struct tls_multi *mul=
ti, const char *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalk=
EDDxLBpZw9JnjI3tBM"                \
+                    "r4engpg/cDgS48DM=
axyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+                    "4md4OJwoQAw=
EwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+                    "AJwBnw=
ArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+                    "Q=
AXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                 =
   "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+            =
        "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+       =
             "93rQwityP9eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_mes=
sages(void **state)
+{
+#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    =
/* ensure that the messages get to mock_msg */
+    x_debug_level =3D 3;
+ =
   management =3D (void *)0x12345678;
+    struct gc_arena gc =3D gc_new();=

+
+    /* contains a TLS 1=2E3 ClientHello */
+    const char msg[] =3D "A=
CC,cck1,384,6," MSG_PAYLOAD;
+
+    struct buffer msg_buf;
+    struct cont=
ext c =3D { 0 };
+    c=2Eoptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_=
CLEAR_GC(c=2Ec2=2Etls_multi, struct tls_multi, &gc);
+
+    c=2Ec2=2Etls_mu=
lti->session[TM_ACTIVE]=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Et=
ls_multi->session[TM_ACTIVE]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
=
+    buf_set_read(&msg_buf, (void *)msg, sizeof(msg));
+
+    receive_acc_m=
essage(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "WARNING: Rece=
ived malformed custom app control channel message (ACC not enabled or no ne=
gotiated protocols): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 =
41455641 774e616[more=2E=2E=2E]");
+    assert_string_equal(mock_managment_=
buf, "");
+
+    c=2Ec2=2Etls_multi->acc_negotiated_protocols =3D "no:commo=
n:protocol";
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equ=
al(mock_msg_buf, "WARNING: Received malformed custom app control channel me=
ssage (protocol 'cck1' not in list of negotiated protocols 'no:common:proto=
col'): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e6=
16[more=2E=2E=2E]");
+    assert_string_equal(mock_managment_buf, "");
+
+ =
   c=2Ec2=2Etls_multi->acc_negotiated_protocols =3D "cck1:flower:power:fort=
une";
+    receive_acc_message(&c, &msg_buf);
+
+    assert_string_equal(mo=
ck_msg_buf, "Received custom app control message (protocol 'cck1')");
+    =
assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLO=
AD);
+
+    const char flower_msg[] =3D "ACC,flower,48,6,SSBhbSAAIEtlcm1pdC=
D//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)fl=
ower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_buf);
+   =
 assert_string_equal(mock_msg_buf, "Received custom app control message (pr=
otocol 'flower')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:A=
CC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+=
    CLEAR(mock_managment_buf);
+    const char msg_incorrect_len[] =3D "ACC=
,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9I=
g=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_len, sizeof(msg=
_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+    const char *=
error =3D "WARNING: Received malformed custom app control channel "
+      =
                  "message (field length 62, payload length 64 mismatch): "=

+                        "4143432c 666f7274 756e652c 36322c36 2c496e73 674=
96d31 "
+                        "6c496a6f 67496d5[more=2E=2E=2E]";
+
+    =
assert_string_equal(mock_msg_buf, error);
+    assert_string_equal(mock_man=
agment_buf, "");
+
+    CLEAR(mock_managment_buf);
+    const char msg_frag=
ment[] =3D "ACC,power,12,6F,aGVsbG8gdw=3D=3D";
+    buf_set_read(&msg_buf, =
(void *)msg_fragment, sizeof(msg_fragment));
+    receive_acc_message(&c, &=
msg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom app contr=
ol message (protocol 'power', fragment)");
+    assert_string_equal(mock_ma=
nagment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock=
_managment_buf);
+    /* check two encoding present */
+    const char flow=
er_msg_two_encs[] =3D "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oC=
PZnJvZyEAAA=3D=3D";
+    buf_set_read(&msg_buf, (void *)flower_msg_two_encs=
, sizeof(flower_msg_two_encs));
+    receive_acc_message(&c, &msg_buf);
+
+=
    error =3D "WARNING: Received malformed custom app control channel messa=
ge "
+            "(number of encodings must be exactly one (B64=3D1, ASCII=
=3D1)): "
+            "4143432c 666c6f77 65722c34 382c3641 2c535342 686253=
41 41494574 "
+            "6c636d3[more=2E=2E=2E]";
+
+    assert_string_e=
qual(mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "")=
;
+
+    /* no encoding present */
+    const char flower_msg_no_encs[] =3D=
 "ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+  =
  buf_set_read(&msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_e=
ncs));
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: R=
eceived malformed custom app control channel message "
+            "(numbe=
r of encodings must be exactly one (B64=3D0, ASCII=3D0)): "
+            "4=
143432c 666c6f77 65722c34 382c2c53 53426862 53414149 45746c63 "
+          =
  "6d31706[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_buf, error);
=
+    assert_string_equal(mock_managment_buf, "");
+
+    x_debug_level =3D =
0;
+    management =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_pa=
rse_acc_parameters(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    /* parameters to INFO message */
+    const char *info_acc_msg =3D "409=
6 A:6 flower:happy";
+
+    int max_len =3D 0;
+    const char *protocols =
=3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    asse=
rt_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, =
1280);
+
+    /* a client does not accept a length longer than it supports =
*/
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, fal=
se, &gc);
+    assert_null(protocols);
+
+    /* message with lower limit t=
han our, should work for client and server */
+    info_acc_msg =3D "1111 A=
:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, " "=
, &max_len, false, &gc);
+    assert_string_equal(protocols, "flower:happy"=
);
+    assert_int_equal(max_len, 1111);
+
+    protocols =3D parse_acc_par=
ameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(p=
rotocols, "flower:happy");
+    assert_int_equal(max_len, 1111);
+
+    /* =
more encodings than supported=2E Server should be okay, client should fail =
*/
+    info_acc_msg =3D "1200 A:6:B flower:happy";
+    protocols =3D pars=
e_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null=
(protocols);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &=
max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy");
+=
    assert_int_equal(max_len, 1200);
+
+    /* extra parameter */
+    info=
_acc_msg =3D "1400 A:6 flower:happy 77";
+    protocols =3D parse_acc_param=
eters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);=

+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, fal=
se, &gc);
+    assert_null(protocols);
+
+
+    const char *iv_acc_capabili=
ties =3D "1400,A:6,flower:happy:power";
+    protocols =3D parse_acc_parame=
ters(iv_acc_capabilities, ",", &max_len, true, &gc);
+    assert_string_equ=
al(protocols, "flower:happy:power");
+
+    /* too small protocol length */=

+    info_acc_msg =3D "32 A:6 flower:happy";
+    protocols =3D parse_acc_=
parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protoc=
ols);
+
+    /* non-numerical protocol length */
+    info_acc_msg =3D "abf=
f A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_acc_msg, =
" ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    gc_free(&gc)=
;
+}
+
+void
+test_acc_common_protocols(void **state)
+{
+    struct multi_=
instance mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+    c->op=
tions=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struc=
t tls_multi, &c->options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV=
_PROTO=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c->options=2Eacc=
_protocols =3D "power:flower:star";
+    struct tls_multi *multi =3D c->c2=
=2Etls_multi;
+    multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocol=
s;
+    multi->session[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2E=
es =3D env_set_create(&c->options=2Egc);
+
+    determine_common_acc_protoc=
ols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    assert_int_equal=
(multi->acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_string_equal(=
multi->acc_negotiated_protocols, "power:flower");
+
+    assert_string_equa=
l(env_set_get(multi->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flo=
wer");
+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_message_l=
en"), "acc_message_len=3D1280");
+
+    free(multi->acc_negotiated_protocol=
s);
+    gc_free(&c->options=2Egc);
+}
+
+void
+test_acc_send_message(void =
**state)
+{
+    struct multi_instance mi =3D { 0 };
+    struct context *c=
 =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new();
+
+    ALLOC_OBJ_CLE=
AR_GC(c->c2=2Etls_multi, struct tls_multi, &c->options=2Egc);
+    bool ret=
;
+    struct tls_multi *multi =3D c->c2=2Etls_multi;
+    c->options=2Eacc=
_protocols =3D "power:flower:emergency";
+    multi->opt=2Eacc_protocols =
=3D c->options=2Eacc_protocols;
+    multi->session[TM_ACTIVE]=2Eopt =3D &m=
ulti->opt;
+    multi->opt=2Ees =3D env_set_create(&c->options=2Egc);
+
+  =
  c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\nIV_ACC=3D1400,A:6,flow=
er:emergency:power";
+    determine_common_acc_protocols(multi, &c->c2=2Etl=
s_multi->session[TM_ACTIVE]);
+
+    struct tls_session *session =3D &c->c2=
=2Etls_multi->session[TM_ACTIVE];
+
+    ret =3D send_acc_message(c, c->c2=
=2Etls_multi, session, "emergency", true,
+                           "EMER=
GENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false);
+
+    assert_true=
(ret);
+    assert_string_equal(control_channel_message_sent,
+            =
            "ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT =
A DRILL:");
+
+    ret =3D send_acc_message(c, c->c2=2Etls_multi, session, =
"emergency", false,
+                           "THE GOVERNMENT HAS ISSUED =
A RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+    assert_true(ret);
=
+    assert_string_equal(control_channel_message_sent,
+                   =
     "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT=
 FOR YOUR AREA=2E");
+
+
+    /* test a long message (> 1000) with fragment=
 to get the maximum header size */
+    char long_message[1200] =3D { 0 };
=
+
+    for (int i =3D 0; i < 1024; i++)
+    {
+        long_message[i] =3D=
 (char)(' ' + (i % 95));
+    }
+
+    /* last char of the message is a i a=
nd then a \0 */
+    assert_int_equal(long_message[1023], 'i');
+    assert=
_int_equal(long_message[1024], '\0');
+
+    ret =3D send_acc_message(c, c-=
>c2=2Etls_multi, session, "emergency", true,
+                           lo=
ng_message, false);
+
+    assert_true(ret);
+    size_t cc_len =3D strlen(=
control_channel_message_sent);
+    assert_int_equal(control_channel_messag=
e_sent[cc_len - 1], 'i');
+    const char *expected_start_cc =3D "ACC,emerg=
ency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memory_equal(control_c=
hannel_message_sent, expected_start_cc, strlen(expected_start_cc));
+
+    =
free(multi->acc_negotiated_protocols);
+    gc_free(&c->options=2Egc);
+}
+=

+void
+test_list_intersection(void **state)
+{
+    const char *empty =3D =
"";
+    const char *protos =3D "power:flower:emergency";
+
+    struct gc_=
arena gc =3D gc_new();
+
+    struct buffer t1 =3D get_list_intersection(&g=
c, empty, protos);
+    assert_int_equal(buf_len(&t1), 0);
+
+    struct bu=
ffer t2 =3D get_list_intersection(&gc, protos, empty);
+    assert_int_equa=
l(buf_len(&t2), 0);
+
+    struct buffer t3 =3D get_list_intersection(&gc, =
protos, protos);
+    assert_string_equal(buf_cstr(&t3), protos);
+
+    co=
nst char *protos2 =3D "flower:emergency:power:mario";
+    struct buffer t4=
 =3D get_list_intersection(&gc, protos2, protos);
+    assert_string_equal(=
buf_cstr(&t4), "flower:emergency:power");
+
+    const char *protos3 =3D "s=
uper:paper:mario:flower";
+    struct buffer t5 =3D get_list_intersection(&=
gc, protos2, protos3);
+    assert_string_equal(buf_cstr(&t5), "flower:mari=
o");
+
+    const char *proto4 =3D "flower:flower:flower:flower";
+    stru=
ct buffer t6 =3D get_list_intersection(&gc, proto4, "flower");
+    assert_=
string_equal(buf_cstr(&t6), "flower");
+
+
+    gc_free(&gc);
+}
diff --git=
 a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/test_ac=
c=2Eh
new file mode 100644
index 0000000=2E=2E32421fb
--- /dev/null
+++ b/t=
ests/unit_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- A=
n application to securely tunnel IP networks
+ *             over a single =
UDP port, with support for SSL/TLS-based
+ *             session authentica=
tion and key exchange,
+ *             packet encryption, packet authentica=
tion, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002=
-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free softw=
are; you can redistribute it and/or modify
+ *  it under the terms of the G=
NU General Public License version 2
+ *  as published by the Free Software =
Foundation=2E
+ *
+ *  This program is distributed in the hope that it will=
 be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warrant=
y of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+=
 *  GNU General Public License for more details=2E
+ *
+ *  You should have=
 received a copy of the GNU General Public License along
+ *  with this pro=
gram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+
+#ifndef =
TEST_ACC_H
+#define TEST_ACC_H
+void test_acc_parse_client_messages(void **=
state);
+
+void test_parse_acc_parameters(void **state);
+
+void test_acc_c=
ommon_protocols(void **state);
+
+void test_acc_send_message(void **state);=

+
+void test_list_intersection(void **state);
+#endif
diff --git a/tests/u=
nit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/test_common=2E=
h
index 8db4ea6=2E=2Ec865142 100644
--- a/tests/unit_tests/openvpn/test_com=
mon=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -43,11 +43,13 @@
=
 #define LargestIntegralType uintmax_t
 #endif
 /* redefine 2=2Ex API in te=
rms of 1=2Ex API */
-#define CMockaValueData             LargestIntegralTyp=
e
-#define check_expected_uint         check_expected
-#define expect_uint_=
value           expect_value
-#define expect_check_data           expect_ch=
eck
-#define cast_ptr_to_cmocka_value(x) (x)
+#define CMockaValueData      =
                 LargestIntegralType
+#define check_expected_uint          =
         check_expected
+#define expect_uint_value                     expe=
ct_value
+#define expect_check_data                     expect_check
+#defi=
ne cast_ptr_to_cmocka_value(x)           (x)
+#define assert_int_in_range(v=
alue, min, max)  assert_in_range((value), (min), (max))
+#define assert_uin=
t_in_range(value, min, max) assert_in_range((value), (min), (max))
 #endif
=
 
 /**
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_test=
s/openvpn/test_ssl=2Ec
index 4baf8cc=2E=2E4987dd0 100644
--- a/tests/unit_t=
ests/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -5=
2,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include=
 "test_acc=2Eh"
+
 /* Mock function to be allowed to include win32=2Ec whic=
h is required for
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6=
 +88,20 @@
 {
     return;
 }
+void
+reschedule_multi_process(struct contex=
t *c)
+{
+}
+
+/* Define a dummy dco cipher option to avoid linking against=
 all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_s=
upported_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:=
AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generated using
  * openss=
l req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ =
-1111,8 +1127,12 @@
         cmocka_unit_test(ssl_test_extract_last_matchin=
g_field),
         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
=
         cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
-    =
    cmocka_unit_test(ssl_test_extract_peer_info)
-
+        cmocka_unit_tes=
t(ssl_test_extract_peer_info),
+        cmocka_unit_test(test_acc_parse_cli=
ent_messages),
+        cmocka_unit_test(test_parse_acc_parameters),
+     =
   cmocka_unit_test(test_acc_common_protocols),
+        cmocka_unit_test(t=
est_acc_send_message),
+        cmocka_unit_test(test_list_intersection)
  =
   };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Ge=
rrit-Change-Number: 1858
Gerrit-PatchSet: 23
Gerrit-Owner: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>

--WX9d2FE4syk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe <strong>uploaded patch set #23</strong> to this change=2E</p><p>=
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
it_tests/openvpn/test_ssl=2Ec<br>26 files changed, 1,546 insertions(+), 23 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/58/1858/23</pre><pre style=3D"font-family: mo=
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
b/doc/management-notes=2Etxt</span><br><span>index 4d726c4=2E=2E1397861 100=
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
><br><span>@@ -1302,6 +1354,52 @@</span><br><span>    response=2E Mechanism=
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
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   OpenVPN does not verify that the message is valid base64=2E A peer that<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sends invalid ba=
se64 payload will be passed to the management interface=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    An implementation should be prep=
ared to handle invalid base64 and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    handle accordingly (e=2Eg=2E disconnect the client via cl=
ient-deny or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ign=
ore such messages)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(7) App custom co=
ntrol protocol message</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   This message =
informs the client about the common ACC</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+   protocols and the maximum message length for an ACC =
message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+   In client mode:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{protocol_list}=
,message_len=3D{max_msg_len}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   protoco=
l_list is the list of supported protocols by both server and client=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+   For example flower:po=
wer:sys_info would indicate these three protocols</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+   are supported=2E max_msg_len specifies the=
 maximum message length that the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+   peer supports=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   In =
server mode these information are available in the acc_protocols and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   acc_message_len variabl=
es of the client environment=2E</span><br><span> </span><br><span> Variable=
s:</span><br><span> </span><br><span>diff --git a/src/openvpn/Makefile=2Eam=
 b/src/openvpn/Makefile=2Eam</span><br><span>index 8a60a94=2E=2Eebc4db6 100=
644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/s=
rc/openvpn/Makefile=2Eam</span><br><span>@@ -45,6 +45,7 @@</span><br><span>=
 sbin_PROGRAMS =3D openvpn</span><br><span> </span><br><span> openvpn_SOURC=
ES =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	acc=2Ec ac=
c=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	auth_token=
=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><=
span>@@ -124,7 +125,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</span><br>=
<span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec push=2Eh =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec push=2Eh=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push_util=2Ec \<=
/span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec refle=
ct_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br><sp=
an>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2Ee203755</span><br><s=
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
<span style=3D"color: hsl(120, 100%, 40%);">+                 const char *a=
cc_msg_payload, bool base64)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * length of the p=
rotocol string + one &#39;,&#39;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * 2 for the encoding (A or 6), potential F (fragment), an=
d 1 for the &#39;,&#39;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * 4 for the message size itself and one comma</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * 1 for the comma before the messa=
ge itself */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st size_t max_header_size =3D strlen(&quot;ACC,&quot;) + strlen(protocol) +=
 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    size_t len =3D max_header_size + strlen(acc_msg_payload);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNEL_BUF_SIZE)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;message length (%zu=
) exceeds maximum possible message length (%d)&quot;, len, TLS_CHANNEL_BUF_=
SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if ((int)len &gt; multi-&gt;acc_max_mess=
age_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, =
&quot;header (%zu) + message size (%zu) length (%zu) exceeds &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      &quot=
;maximum allowed length negotiated with peer (%d)&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            max_header_size, strlen(ac=
c_msg_payload), len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            multi-&gt;acc_max_message_length);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* add 1 for the final \0 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(len + 1, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Example message: ACC,m=
uppets,15,A,I am Miss Piggy */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, protoco=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               st=
rlen(acc_msg_payload),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+               base64 ? &quot;6&quot; : &quot;A&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+               fragment ? &quot;F&quo=
t; : &quot;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
              acc_msg_payload);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    boo=
l ret =3D send_control_channel_string_dowork(session, BSTR(&amp;buf), D_PUS=
H);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reschedule_m=
ulti_process(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+char *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+parse_acc_parameters(const char *capabilities,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                     const =
char *delim,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              int *max_acc_len,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     bool server,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                     struct gc_arena *gc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *tmp_message =3D string_alloc(capabi=
lities, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
har *tmp_message_orig =3D tmp_message;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *lasts =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *token =3D strtok_r(tmp_message, delim, &amp;lasts);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int p =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int acclen =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* In server mode we allow more ca=
pabilities than our own, in client</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * mode we reject if we should use capabilities that we =
do not support */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    while (token)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_constrained(token, &amp;accl=
en, &quot;ACC message length&quot;, ACC_MIN_MSG_LEN, allowed_acc_len, D_PUS=
H_ERRORS))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto do=
ne;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; (!tls_item_=
in_cipher_list(&quot;A&quot;, token) || !tls_item_in_cipher_list(&quot;6&qu=
ot;, token)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
D_PUSH_ERRORS, &quot;App custom control encoding must include base64 and as=
cii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 1 &amp;&amp; =
!server &amp;&amp; strcmp(token, &quot;A:6&quot;) &amp;&amp; strcmp(token, =
&quot;6:A&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(D_PUSH_ERRORS, &quot;App custom control encoding must be exactly base64=
 and ascii&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 2)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            protocols =3D token;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;Too many parameter=
s for INFO ACC message/IV_ACC=2E&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            goto done;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   token =3D strtok_r(NULL, delim, &amp;lasts);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        p++;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *max_acc=
_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ret =3D string_alloc(protocols, gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    free(tmp_message_orig);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+get_list_intersection(struct=
 gc_arena *gc, const char *list1, const char *list2)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char *tmp =3D string_alloc(list1, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D st=
rtok_r(tmp, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* The maximum possible length is the shorter of the two input lists *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t max_len=
 =3D min_size(strlen(list1), strlen(list2));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer common_protocols =3D alloc_buf_gc(max_len + 1, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    while (token)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        /* check for every items is in both lists and =
not already in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
        * common list */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (tls_item_in_cipher_list(token, list2)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !tls_item_in_ciph=
er_list(token, buf_cstr(&amp;common_protocols)))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (buf_len(&amp;common_protocols) &gt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_write_u=
8(&amp;common_protocols, &#39;:&#39;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            buf_printf(&amp;common_protocols, &quot;%s&quot;, =
token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D strt=
ok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free(tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return common_protocols;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct tls=
_multi *multi, struct tls_session *session)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!multi-&gt;opt=2Eacc_protocols)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* No app custom protocols have been configured server-=
side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_protocols)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* We already have determine=
d the common protocols=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=
=3D2048,6:A,flower:power */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char *peer_info =3D multi-&gt;peer_info;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc =3D extract_v=
ar_peer_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max=
_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *protocols =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;=
max_acc_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!p=
rotocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH=
_ERRORS, &quot;WARNING: IV_ACC peer info variable of peer is malformed&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer common_protocols =3D get_list_inter=
section(&amp;gc, multi-&gt;opt=2Eacc_protocols, protocols);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (buf_len(&amp;common_protocols) =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNING=
: No common app custom control protocol=2E&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    multi-&gt;acc_negotiated_protocols =3D string_alloc(buf_str(&amp;commo=
n_protocols), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    setenv_str(session-&gt;opt-&gt;es, &quot;acc_protocols&=
quot;, multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    setenv_int(session-&gt;opt-&gt;es, &quot;acc_me=
ssage_len&quot;, multi-&gt;acc_max_message_length);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+notify_client_acc_protocols(struct =
tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGE=
MENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (managem=
ent)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;&=
gt;ACC_PROTOCOLS:protocols=3D%s,message_len=3D%d&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_negotiated_pr=
otocols, multi-&gt;acc_max_message_length);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh</span=
><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E4ee94d3<=
/span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Eh</sp=
an><br><span>@@ -0,0 +1,112 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Op=
enVPN -- An application to securely tunnel IP networks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (=
C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License version 2</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Free Sof=
tware Foundation, Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define ACC_H</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_MIN_MSG_=
LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ACC_M=
AX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * This method parses an app custom con=
trol message and delivers it to the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * management interface=2E We leave reassembly of fragmente=
d messages to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 management interface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c =
           The context struct</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param buffer       Buffer containing the control message with=
 ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+receive_acc_message(struct context *c, const s=
truct buffer *buffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct context=
 *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
  struct tls_multi *tls_multi,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                 struct tls_session *session,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                 const char *protocol,=
 bool fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
             const char *msg, bool base64);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Parses an info message from=
 the server that contains app custom control info</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * information prior to the PUSH_REPLY to be =
able to use app custom control</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * protocols before sending</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * In client mode only allow what we support ourselves=2E In server mode<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allow also capabi=
lities that we not support ourselves=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param capabilities      The string to parse</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param delim             The delimiter to=
 use when parsing the string=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *                          IV_ACC uses &quot;,&quot; as delimi=
ter while the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
                      custom-control PUSH message uses &quot; &quot; as &qu=
ot;,&quot; is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
                      already used to separate different push directives</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len =
      Set to the maximum ACC message length</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param server            Whether we are server o=
r client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param g=
c                The gc arena to use for allocating the resulting string</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return            =
      The resulting protocol string or NULL on error</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+char *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+parse_acc_parameters(const char *capabilities,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                     const char *delim,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
int *max_acc_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                   bool server,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                     struct gc_arena *gc);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Parses the IV_ACC of the peer and sets multi=2Eacc_negotiated_protocols<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to the common pro=
tocols of server and client and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * multi=2Eacc_max_message_length  to the maximum length of the=
 ACC message</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * supp=
ort by both server and client=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * I=
f there is no common protocol or the client does not support any app custom=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * protocol multi=
=2Eacc_negotiated_protocols will be set to NULL=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param multi      the multi instance to use the set the ap=
p custom protocols=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param session    the session to read the client env from</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+determine_common_acc_protocols(struct tls_multi *multi, struct =
tls_session *session);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Calculates the intersection o=
f two list that are both separated by :</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Items in the result will have the same ordering as i=
n the list1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * param=
eters</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc  =
          Returned buffer will be allocated in this gc</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param list1         First list to in=
tersect</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param li=
st2         Second list to intersect=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return A (potentially empty) buffer containing an i=
ntersection list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+get_list_intersection(str=
uct gc_arena *gc, const char *list1, const char *list2);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Notifies a client via management interface of the negotiated app</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * custom protocols</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi the tls_m=
ulti instance of the connection</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+notify_client_acc_p=
rotocols(struct tls_multi *multi);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#endif</span><br><span>diff --git a/src/openvpn/forward=2Ec =
b/src/openvpn/forward=2Ec</span><br><span>index 681210d=2E=2Eeb41d03 100644=
</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/op=
envpn/forward=2Ec</span><br><span>@@ -42,6 +42,7 @@</span><br><span> #inclu=
de &quot;dco=2Eh&quot;</span><br><span> #include &quot;auth_token=2Eh&quot;=
</span><br><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><s=
pan> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </s=
pan><br><span>@@ -257,11 +258,11 @@</span><br><span>     }</span><br><span>=
     else if (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  server_pushed_info(buf, 8);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        peer_pushed_info(c, buf, 8);</span><br><span>     }</span=
><br><span>     else if (buf_string_match_head_str(buf, &quot;INFO&quot;))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        server_pushed_info(buf, 4);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        peer_pushed_info(c, buf, 4);</span><br><span>     =
}</span><br><span>     else if (buf_string_match_head_str(buf, &quot;CR_RES=
PONSE&quot;))</span><br><span>     {</span><br><span>@@ -271,6 +272,10 @@</=
span><br><span>     {</span><br><span>         receive_auth_pending(c, buf)=
;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else if (buf_string_match_head_str(buf, &quot;ACC&quot;))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        receive_acc_message(c, buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>  =
   else if (buf_string_match_head_str(buf, &quot;EXIT&quot;))</span><br><sp=
an>     {</span><br><span>         receive_exit_message(c);</span><br><span=
>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>i=
ndex 1b8b2a5=2E=2Ee0b99a4 100644</span><br><span>--- a/src/openvpn/init=2Ec=
</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -56,6 +56,7 =
@@</span><br><span> #include &quot;schedule=2Eh&quot;</span><br><span> #inc=
lude &quot;options_string=2Eh&quot;</span><br><span> #include &quot;resolve=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;acc=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdb=
g=2Eh&quot;</span><br><span> </span><br><span>@@ -2279,6 +2280,13 @@</span>=
<br><span>         }</span><br><span>     }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *multi =3D c=
-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (multi &amp;&amp; multi-&gt;acc_negotiated_protocols)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot; custom-cont=
rol %d A:6 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                   multi-&gt;acc_max_message_length, multi-&gt;acc_negotia=
ted_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    if (BLENZ(&amp;out) &gt; strlen(header))</span><br><span>     {</span><=
br><span>         msg(D_HANDSHAKE, &quot;%s&quot;, BSTR(&amp;out));</span><=
br><span>@@ -2522,6 +2530,11 @@</span><br><span>         flags |=3D (OPT_P_=
ROUTE | OPT_P_DHCPDNS);</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options=2Eacc_pr=
otocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        flags |=3D OPT_P_=
ACC;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return =
flags;</span><br><span> }</span><br><span> </span><br><span>@@ -2730,6 +274=
3,18 @@</span><br><span>         frame-&gt;tun_mtu =3D min_int(frame-&gt;tu=
n_max_mtu, c-&gt;options=2Ece=2Etun_mtu);</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (foun=
d &amp; OPT_P_ACC &amp;&amp; c-&gt;options=2Epushed_acc_negotiated_protocol=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi=
 =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        free(multi-&gt;acc_negotiated_protocols);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;acc_negotiated_proto=
cols =3D string_alloc(c-&gt;options=2Epushed_acc_negotiated_protocols, NULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt=
;acc_max_message_length =3D c-&gt;options=2Epushed_acc_max_message_length;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH, &quot;OPTIONS IMPOR=
T: ACC protocols: %s, msg len: %d&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            multi-&gt;acc_negotiated_protocols, multi-=
&gt;acc_max_message_length);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        notify_client_acc_protocols(multi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     return true;</span><br><span> }</=
span><br><span> </span><br><span>@@ -3352,6 +3377,7 @@</span><br><span>    =
 to=2Everify_hash_depth =3D options-&gt;verify_hash_depth;</span><br><span>=
     to=2Everify_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br><s=
pan>     memcpy(to=2Ex509_username_field, options-&gt;x509_username_field, =
sizeof(to=2Ex509_username_field));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    to=2Eacc_protocols =3D options-&gt;acc_protocols;</span>=
<br><span>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_ctx=
 =3D &amp;c-&gt;net_ctx;</span><br><span> </span><br><span>@@ -4306,6 +4332=
,24 @@</span><br><span> }</span><br><span> #endif /* ifdef TARGET_ANDROID *=
/</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manageme=
nt_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                   struct buffer_list *input) /* ownership transferred */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D arg;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (buffer_list_defined(input) &amp;&=
amp; c-&gt;c2=2Etls_multi)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        struct tls_session *session =3D &amp=
;multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ret =3D management_send_acc_message(c, multi, session, input);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buffer_list_free(input);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</spa=
n><br><span> </span><br><span> void</span><br><span>@@ -4322,6 +4366,7 @@</=
span><br><span>         cb=2Eproxy_cmd =3D management_callback_proxy_cmd;</=
span><br><span>         cb=2Eremote_cmd =3D management_callback_remote_cmd;=
</span><br><span>         cb=2Esend_cc_message =3D management_callback_send=
_cc_message;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cb=2Eacc_msg =3D management_acc_msg;</span><br><span> #ifdef TARGET_ANDROI=
D</span><br><span>         cb=2Enetwork_change =3D management_callback_netw=
ork_change;</span><br><span> #endif</span><br><span>diff --git a/src/openvp=
n/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ac3d4b7=2E=2E2b=
6b901 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+=
++ b/src/openvpn/manage=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><br><s=
pan> #include &quot;push=2Eh&quot;</span><br><span> #include &quot;multi=2E=
h&quot;</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><b=
r><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span>=
 #include &quot;run_command=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </span>=
<br><span> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=2Eh&=
quot;</span><br><span>@@ -1081,6 +1083,35 @@</span><br><span>             }=
</span><br><span>             break;</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&gt;per=
sist=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                bool status =3D (*man-&gt;persist=2Ecallback=2Eclie=
nt_acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                                 =
                     man-&gt;connection=2Ein_extra_cid,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
                               man-&gt;connection=2Ein_extra_kid,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
                                         man-&gt;connection=2Ein_extra);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                man-&g=
t;connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                report_command_status(status, &quot;client-ac=
c-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                man_c=
ommand_unsupported(&quot;client-acc-msg&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        case IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (man-&gt;persist=2Ecallback=2Eacc_msg)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                bool status =3D (*man-&=
gt;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
                                   man-&gt;connection=2Ein_extra);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                man-&gt;conn=
ection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                report_command_status(status, &quot;acc-msg&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                man_command_unsupp=
orted(&quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            break;</span><br><span>         case IEC_PK_SIGN:</span><br><=
span>             man-&gt;connection=2Eext_key_state =3D EKS_READY;</span><=
br><span>             buffer_list_free(man-&gt;connection=2Eext_key_input);=
</span><br><span>@@ -1205,6 +1236,29 @@</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+man_client_acc_msg(struct management *man, const char *cid_str,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   c=
onst char *kid_str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_con=
nection *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_str, &am=
p;mc-&gt;in_extra_cid)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&gt;in_e=
xtra_kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in_extra=
_cmd =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        in_extra_reset(mc, IER_NEW);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+man_acc_msg(struct management *ma=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &=
amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span> man_client_auth(struct management *man, const=
 char *cid_str, const char *kid_str, const bool extra)</span><br><span> {</=
span><br><span>     struct man_connection *mc =3D &amp;man-&gt;connection;<=
/span><br><span>@@ -1759,6 +1813,17 @@</span><br><span>             man_cli=
ent_pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>         }</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (streq(p[0], &quot;client-acc-msg&quot;))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            man_client_acc_msg(man, p[1], p[2]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;acc-msg&quot;))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        man_acc_msg(man);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     =
else if (streq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {</span><br=
><span>         man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><span>@@ -2=
975,7 +3040,9 @@</span><br><span>                                        &q=
uot;bytes_sent=3D&quot;,</span><br><span>                                  =
      &quot;bytes_received=3D&quot;,</span><br><span>                      =
                  &quot;session_id=3D&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                       &quot;session=
_state=3D&quot; };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                      &quot;session_state=3D&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
            &quot;acc_protocols=3D&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                       &quot;acc_mess=
age_len=3D&quot; };</span><br><span> </span><br><span>     if (env_filter_l=
evel =3D=3D 0)</span><br><span>     {</span><br><span>@@ -3130,6 +3197,7 @@=
</span><br><span>     }</span><br><span> }</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><=
span> management_connection_established(struct management *man, struct man_=
def_auth_context *mdac,</span><br><span>                                   =
const struct env_set *es)</span><br><span>@@ -4372,6 +4440,70 @@</span><br>=
<span>     }</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+management_send_acc_message(struct context *c, struct tls_mu=
lti *multi, struct tls_session *session,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            struct buffer_list *input)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* also ensures that are enough i=
nputs in the list to safely call</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * buffer_list_peek without extra NULL checks */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!input || input-&gt;s=
ize &lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, =
&quot;not enough input lines for sending acc message, &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                      &quot;missin=
g protocol, flag and/or messages lines&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct buffer *proto_buf =3D buffer_list_peek(input);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *protocol =3D string_a=
lloc(CBSTR(proto_buf), &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    buffer_list_pop(input);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer *encoding_buf =3D buffer_list_peek(input);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    char *encoding =3D buf_str(e=
ncoding_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst char *flag =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool b64encoding =3D false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bool fragment =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    while ((flag =3D strsep(&amp;encoding, &quot;:&quot;)))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(flag, &quot;6&quot;))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            b64encoding =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!strcmp(=
flag, &quot;F&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    fragment =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT=
, &quot;protocol &#39;%s&#39; not in the list of supported flags&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                flag);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err=
or;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buffer_list_aggregate_separator(input, 10000, &=
quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct buffer *acc_msg_buf =3D buffer_list_peek(input);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        || !tls_item_in_cipher=
_list(protocol, multi-&gt;acc_negotiated_protocols))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_CLIENT, &quot;protocol not in the list of=
 negotiated protocols: %s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            np(multi-&gt;acc_negotiated_protocols));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool ret =3D send_acc_message(c, multi, session, protoco=
l,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
               fragment, buf_cstr(acc_msg_buf),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                b64encoding);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+error:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> #else /* ifdef EN=
ABLE_MANAGEMENT */</span><br><span> </span><br><span> #include &quot;win32=
=2Eh&quot;</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvp=
n/manage=2Eh</span><br><span>index 157039d=2E=2Ecc9c264 100644</span><br><s=
pan>--- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=
=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><br><span>     int (*n_cli=
ents)(void *arg);</span><br><span>     bool (*send_cc_message)(void *arg, c=
onst char *message, const char *parameter);</span><br><span>     bool (*kil=
l_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     bool=
 (*client_auth)(void *arg, const unsigned long cid, const unsigned int mda_=
key_id,</span><br><span>                         const bool auth, const cha=
r *reason, const char *client_reason,</span><br><span>                     =
    struct buffer_list *cc_config); /* ownership transferred */</span><br><=
span>     bool (*client_pending_auth)(void *arg, const unsigned long cid, c=
onst unsigned int kid,</span><br><span>                                 con=
st char *extra, unsigned int timeout);</span><br><span>     char *(*get_pee=
r_info)(void *arg, const unsigned long cid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool (*client_acc_msg)(void *arg,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                           const=
 unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                           const unsigned int mda_key_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                           struct buf=
fer_list *msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
bool (*acc_msg)(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    struct buffer_list *msg);</span><br><span>     b=
ool (*proxy_cmd)(void *arg, const char **p);</span><br><span>     bool (*re=
mote_cmd)(void *arg, const char **p);</span><br><span> #ifdef TARGET_ANDROI=
D</span><br><span>@@ -292,13 +299,15 @@</span><br><span>     struct command=
_line *in;</span><br><span>     struct buffer_list *out;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_UNDEF     =
  0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define IEC_CLIENT=
_AUTH 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_=
UNDEF          0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine IEC_CLIENT_AUTH    1</span><br><span> /* #define IEC_CLIENT_PF   2 *RE=
MOVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine IEC_RSA_SIGN    3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define IEC_CERTIFICATE 4</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define IEC_PK_SIGN     5</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define IEC_PASSWORD    6</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define IEC_RSA_SIGN       3</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define IEC_CERTIFICATE    4</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define IEC_PK_SIGN        5</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD       6</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CLIENT_ACC_=
MSG 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_AC=
C_MSG        8</span><br><span>     int in_extra_cmd;</span><br><span>     =
struct buffer_list *in_extra;</span><br><span>     unsigned long in_extra_c=
id;</span><br><span>@@ -503,6 +512,14 @@</span><br><span> </span><br><span>=
 void man_persist_client_stats(struct management *man, struct context *c);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
* Parses the ACC message from the input buffer_list and send to the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * session identified by se=
ssion and multi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_session;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_multi;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+management_send_acc_message(struct co=
ntext *c, struct tls_multi *multi,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                            struct tls_session *session, str=
uct buffer_list *input);</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT=
 */</span><br><span> </span><br><span> /**</span><br><span>diff --git a/src=
/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e302a81=2E=
=2Ea3eb3ca 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -53,6 +53,7 @@</span><br>=
<span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #include &quot;dc=
o=2Eh&quot;</span><br><span> #include &quot;reflect_filter=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quo=
t;</span><br><span> </span><br><span> /*#define MULTI_DEBUG_EVENT_LOOP*/</s=
pan><br><span> </span><br><span>@@ -4085,6 +4086,26 @@</span><br><span>    =
 }</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static const char *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+calculate_app_control_extra(struct multi_instance *mi, =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct contex=
t *c =3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_negotiated_protocols)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ACC: No neg=
otiated protocols&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D =
alloc_buf_gc(1024, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(=
&amp;buf, &quot;ACC:%d A:6 %s&quot;, multi-&gt;acc_max_message_length,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+               multi-&gt=
;acc_negotiated_protocols);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return buf_str(&amp;buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic bool</span><br><span> management_client_pending_auth(void *arg, const=
 unsigned long cid, const unsigned int mda_key_id,</span><br><span>        =
                        const char *extra, unsigned int timeout)</span><br>=
<span>@@ -4095,10 +4116,22 @@</span><br><span>     if (mi)</span><br><span>=
     {</span><br><span>         struct tls_multi *multi =3D mi-&gt;context=
=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!strcmp(extra, &quot;ACC&quot;))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            extra =3D calculate_app_control_extra(mi, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(!extra)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span>         struct tls_session *session =3D lookup_=
session_by_mda_key_id(multi, mda_key_id);</span><br><span> </span><br><span=
>         if (!session)</span><br><span>         {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><spa=
n>             return false;</span><br><span>         }</span><br><span> </=
span><br><span>@@ -4106,6 +4139,7 @@</span><br><span>         bool ret =3D =
send_auth_pending_messages(multi, session, extra, timeout);</span><br><span=
>         reschedule_multi_process(&amp;mi-&gt;context);</span><br><span>  =
       multi_schedule_context_wakeup(m, mi);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span>        =
 return ret;</span><br><span>     }</span><br><span>     return false;</spa=
n><br><span>@@ -4149,6 +4183,37 @@</span><br><span>     return ret;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_client=
_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                          const unsigned long cid,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                          const unsigned int=
 mda_key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                   struct buffer_list *input) /* ownership transferred */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct multi_context *m =3D (struct=
 multi_context *)arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct multi_instance *mi =3D lookup_by_cid(m, cid);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool ret =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (mi &amp;&amp; buffer_list_defined(input))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct tls_multi *multi =3D=
 mi-&gt;context=2Ec2=2Etls_multi;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct tls_session *session =3D lookup_session_by_mda=
_key_id(multi, mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!session)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(M_CLIENT, &quot;client session not found&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            buffer_list_free(i=
nput);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        ret =3D management_send_acc_=
message(&amp;mi-&gt;context, multi, session, input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_schedule_context_wakeup(m, =
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buffer_list_free(input);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static char *</span><br><span> management_get_peer_info(void=
 *arg, const unsigned long cid)</span><br><span> {</span><br><span>@@ -4185=
,6 +4250,7 @@</span><br><span>         cb=2En_clients =3D management_callba=
ck_n_clients;</span><br><span>         cb=2Ekill_by_cid =3D management_kill=
_by_cid;</span><br><span>         cb=2Eclient_auth =3D management_client_au=
th;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cb=2Ecli=
ent_acc_msg =3D management_client_acc_msg;</span><br><span>         cb=2Ecl=
ient_pending_auth =3D management_client_pending_auth;</span><br><span>     =
    cb=2Eget_peer_info =3D management_get_peer_info;</span><br><span>      =
   cb=2Epush_update_broadcast =3D management_callback_send_push_update_broa=
dcast;</span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/o=
ptions=2Ec</span><br><span>index fb319ae=2E=2Ea5e7396 100644</span><br><spa=
n>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=
=2Ec</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><span> #=
include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span>=
 #include &quot;buffer=2Eh&quot;</span><br><span> #include &quot;error=2Eh&=
quot;</span><br><span> #include &quot;common=2Eh&quot;</span><br><span>@@ -=
2552,6 +2553,8 @@</span><br><span>     o-&gt;push_option_types_found =3D 0;=
</span><br><span>     o-&gt;push_update_options_found =3D 0;</span><br><spa=
n>     o-&gt;imported_protocol_flags =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    o-&gt;pushed_acc_max_message_length =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    o-&gt;pushed_acc_neg=
otiated_protocols =3D NULL;</span><br><span> }</span><br><span> </span><br>=
<span> static void</span><br><span>@@ -7107,6 +7110,47 @@</span><br><span> =
        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-=
&gt;force_key_material_export =3D true;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;a=
pp-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!string_class(p[=
1], CC_ALNUM | CC_COLON | CC_UNDERBAR | CC_DASH, 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control =
protocols must only contain &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                          &quot;alphanumeric characters, &#3=
9;-&#39;, and &#39;_&#39;=2E&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;acc_protocols =3D p[1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else if (streq(p[0], &quot;custom-control&quot;) &a=
mp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_ACC);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* check if the list from the server i=
s a real subset of our list */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct gc_arena gc_local =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct buffer common_list =3D=
 get_list_intersection(&amp;gc_local, p[3], options-&gt;acc_protocols);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (buf_len(&amp;common_list) =3D=
=3D 0 || !streq(p[3], buf_cstr(&amp;common_list)))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(msglevel, &quot;App custom control lis=
t from server contains &quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                          &quot;unsupported protocols&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&am=
p;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free=
(&amp;gc_local);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!streq(p[2=
], &quot;6:A&quot;) &amp;&amp; !streq(p[2], &quot;A:6&quot;))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;App custo=
m control encoding must be base64 and ascii&quot;);</span><br><span style=
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
penvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 086a6fc=2E=2E97e=
f9b0 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b=
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
=3D%d,A:6,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);<=
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
<div style=3D"display:none"> Gerrit-PatchSet: 23 </div=
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
--WX9d2FE4syk=--


--===============2011913975574717014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2011913975574717014==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2011913975574717014==--

