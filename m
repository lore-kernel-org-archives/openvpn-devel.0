Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF7C606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=febF9yo0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=e0x0XwyJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GyVfCy/s;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=c5xexUAM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=QcnqJxBlMvydhEP02BptTuU0OPUcVRJasyBZ+HbojwA=; b=febF9yo06YW+a0/6RJvp9VuL+N
	Poz3WowcGD9OBETDNd15NnduVvUZpzzkKPJWwhfA/9v09F5azxZkHyE3IvbLxhBwYgOdeM+nMGaqd
	3tTyUxJbIkcOkyg9V0gdHh5LZ8MjqjGAfrdbx5SniTYiR8gvugqpfOBYsNoe/xiKumNc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLiNM-000000004ko-2xSJ;
	Tue, 27 Oct 2026 14:42:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLiNK-000000004kZ-4Bo1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 14:42:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JDiN8CyWL9LML0qPWZdC2VhHdwVw6DXIYXnVRgOeAiw=; b=e0x0XwyJVFsoJdNAdy4wU7kV1B
 9CSa3+zK84FGqygND4rl6Dsq4himdDxjVQ/fa6LQ6UqgElFuMXEXCjyjNo3mO+4voS17fUYOJ6AFJ
 bxwIFnfOCMx3tFOdAK3dY2P8L8erwaGW8ulLGX3s8wLEf93hm2Gy8jU/33tM8A9r4acA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JDiN8CyWL9LML0qPWZdC2VhHdwVw6DXIYXnVRgOeAiw=; b=GyVfCy/sN+CRPpQDyTlVpl8faX
 qfWblKaubc7M7MdQOsEJSk3TOYNGuyCyGPu6GPAZFDAJ8eme/o62IBWSl5mVnna7k9H9jglPNAFIF
 h0TFJyfc7uB1wBEOEkCPsBwnbj6I2H3LkDMW1rKv3bYhyYbcG5JtSixUqwqsQnF+DCzk=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLiND-0000000019i-0ZcG for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 14:42:06 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so48482855e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 07:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793112112; x=1793716912; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JDiN8CyWL9LML0qPWZdC2VhHdwVw6DXIYXnVRgOeAiw=;
 b=c5xexUAMAq4/N+1WKDxGbrRCO/82tuMWc5IIABtDR+Kp7bxx94LnVocUkIxqjI4HF6
 +QwJCFE50F+NSMGURS+ejEBxLGbzcwuFchq2feYalUjzyRzxsb4fcsbVMspa7rOA+jrf
 twnDkBSI1ZbTI9xBWaCIQ0Z6kzqEX7g3i6bXhaXRr9d9FJZjOHokJ7QeS9OVsm2BACUl
 hkgdExHWKfMarWgLSQFvzHb/hFb2LNirczNuryheCTi00ws9FeLBdMBN2CTVrOmagapw
 IzfJNAglV6pynvYK8D++9j8kwVQbJZm9lLHpvNUfbYypAK8yYTFJiM08OBxdGzpMAlyv
 RwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112112; x=1793716912;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JDiN8CyWL9LML0qPWZdC2VhHdwVw6DXIYXnVRgOeAiw=;
 b=NvEEsjP6UmkH7EBYvS2JyMRg6kCEqvaIKgxowfVtRXVotXWVsM7fsU5KoXKHSe3P/g
 hfGW1bkJyCUJAoPC2MKB7gyMbul5u99TDs2QICDO6bVGxVQaFRuR49MCKOb59U16sXzv
 Z/krwKThiE4giqxlx9faf16niC8GXxdhNWbzqZCP7XiWpFEVJGPsQPCMsvxgl3fphhaB
 jwzNRyhJMCHLUhKkDGeu2BXnH1m+VCWBzH0WzM+LV3Hozloy1hy45dGcBblj7dGKOBGO
 VmfcS5qFLEtBWSq96C1dlNRcmwzFUELWzZGLm+Vv/ObgF8sJEIkDSYAlwTxJn5qeFQQA
 poVg==
X-Gm-Message-State: AFq9FYJvxC+5PSL6kHK6nsiaXL+FcddQj1MQBcGiAjRSLM5u9RiWURkS
 iqk+r2oThw0P5rnLSSBD+5+jmdzz2uaMM1CAFvZD+v4hYErOepltiNSg941ugxv0oeAwrP+dWUp
 XtBNxRs+kllXG80jJnRaXjPcgxXOUDVOg7snzINk+Y9lontwXcZLYVB8tphGJfFIQju04
X-Gm-Gg: AYBFou3a7bkB29c7g7TKSPEKlyFCon7OUKAkfKjR8Xv1DFvgmI+by+z8zVrAftUkC+X
 JWJ9K308kt3XZwkpGEWhssfMywFMaVaxHUs/I7die3XQnq+CkKjtXkb2T6XAmr+JsBB6kUSVsej
 CE7gfcPt70NTf7F3VHeku8qbdf+Hazyb9iTZmWWj/+gPNkFbtK6Jt+Hai4P4k18PmlT7zzIYNkT
 cP71JGWCeM026svWm3OvR30IBp80SbEo+INrD/LilMaUyXMH6rNnGapxjZe53Uo0HjkiQF18bO0
 PSZCrKQZJblwMHsvd1fYsVBc6JshPX3BdTbT/vF1/x+5j85NrOLXxCo4NutPTyGB03x8pv30g2v
 anHwo9UXi/PhePUlMle+fJIR5N5DdA6N2WeSPKuKoJfqm8nVQ11VlqqVMUaDIqjLcHQL6hp6T6C
 USSc0Tad0MxiafVCoJUKLZR17+0XWD1QdhJiABwok2tUsaRFAkEb1t3haTz8jKghMzCnpfdryFj
 Avfb5bnPltCQwCaJteFwpsPJ3psB8jlEOL8ej+21iO2Ztq8/91vdwZntd96u1Kqv8okHPm9ft3I
 R/jsr/xzLMpz/0QyTJV/iZXCZ3WPggK4MxLsbu6Ejap4eeDHn3jS//RYl7T7H+gk02DJgmUhSHQ
 td85/5KkGoqKeG3hm0GtJPbPIVCbXdsrzVxZhPSmfAg==
X-Received: by 2002:a05:600c:3b93:b0:4a2:fe3:121b with SMTP id
 5b1f17b1804b1-4a35acb0791mr207702035e9.28.1793112111078; 
 Tue, 27 Oct 2026 07:41:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a59d998sm281567815e9.15.2026.10.27.07.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:41:50 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 14:41:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 6380386c5690d29661f083b8501d2f65ee967f24
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f3a9da145b46d2e99f4e16031e104fcaabf8a25c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLiND-0000000019i-0ZcG
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
Content-Type: multipart/mixed; boundary="===============8928659501275689304=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8928659501275689304==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9Iesq/fCFXA="; charset=UTF-8

--9Iesq/fCFXA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Frank Lichtenheld, R=C4=83zvan Cojocaru, 

I'd l=
ike you to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail

to look at the new patch set (#16)=2E
=

The following approvals got outdated and were removed:
Code-Review-1 by R=
=C4=83zvan Cojocaru


Change subject: Implement sending/receiving app custo=
m control protocol messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Implement sending/receiving app custom control protocol me=
ssages

This allows openvpn GUI/front-ends and server via management
to use=
 the OpenVPN control channel to pass messages between each other
while Open=
VPN handles the marshalling/unmarshalling of these and
negotiate the common=
 app custom control protocols=2E

This provides an easy to use secure chann=
el that does not depend on
the network itself to work and can also used bef=
ore fully authenticating
the client=2E See the management-notes=2Etxt for m=
ore details how to use
this feature=2E An upcoming patch will also add some=
 example python
script that showcase this feature=2E

Change-Id: I4a6a6ef41=
e15896b8b79d795b2a6de86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M CMakeLists=2Etxt
M doc/man-sections/client-options=2Erst
M do=
c/man-sections/management-options=2Erst
M doc/man-sections/script-options=
=2Erst
M doc/management-notes=2Etxt
M src/openvpn/Makefile=2Eam
A src/openv=
pn/acc=2Ec
A src/openvpn/acc=2Eh
M src/openvpn/forward=2Ec
M src/openvpn/in=
it=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/mult=
i=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/pus=
h=2Ec
M src/openvpn/push=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=
=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/mo=
ck_management=2Ec
A tests/unit_tests/openvpn/mock_management=2Eh
M tests/un=
it_tests/openvpn/mock_push_dependencies=2Ec
A tests/unit_tests/openvpn/test=
_acc=2Ec
A tests/unit_tests/openvpn/test_acc=2Eh
M tests/unit_tests/openvpn=
/test_common=2Eh
M tests/unit_tests/openvpn/test_misc=2Ec
M tests/unit_test=
s/openvpn/test_ssl=2Ec
28 files changed, 1,518 insertions(+), 26 deletions(=
-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/=
1858/16

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 184a95a=2E=
=2E00caa2d 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -435,6 +=
435,8 @@
     src/compat/compat-strlcpy=2Ec
     src/compat/compat-strsep=
=2Ec
     src/compat/compat-strtok_r=2Ec
+    src/openvpn/acc=2Ec
+    src/=
openvpn/acc=2Eh
     src/openvpn/argv=2Ec
     src/openvpn/argv=2Eh
     sr=
c/openvpn/base64=2Ec
@@ -571,8 +573,8 @@
     src/openvpn/ps=2Ec
     src/o=
penvpn/ps=2Eh
     src/openvpn/push=2Ec
-    src/openvpn/push_util=2Ec
    =
 src/openvpn/push=2Eh
+    src/openvpn/push_util=2Ec
     src/openvpn/pushl=
ist=2Eh
     src/openvpn/reflect_filter=2Ec
     src/openvpn/reflect_filter=
=2Eh
@@ -826,7 +828,10 @@
             tests/unit_tests/openvpn/mock_manage=
ment=2Ec
             tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
  =
           tests/unit_tests/openvpn/mock_win32_execve=2Ec
+            test=
s/unit_tests/openvpn/test_acc=2Ec
+            src/openvpn/acc=2Ec
        =
     src/openvpn/argv=2Ec
+            src/openvpn/auth_token=2Ec
         =
    src/openvpn/base64=2Ec
             src/openvpn/crypto_epoch=2Ec
      =
       src/openvpn/crypto_mbedtls=2Ec
@@ -840,8 +845,11 @@
             src=
/openvpn/options_util=2Ec
             src/openvpn/otime=2Ec
             s=
rc/openvpn/packet_id=2Ec
+            src/openvpn/reliable=2Ec
+           =
 src/openvpn/session_id=2Ec
             src/openvpn/run_command=2Ec
      =
       src/openvpn/ssl_mbedtls=2Ec
+            src/openvpn/ssl_ncp=2Ec
   =
          src/openvpn/ssl_openssl=2Ec
             src/openvpn/ssl_util=2Ec=

             src/openvpn/ssl_verify_mbedtls=2Ec
@@ -858,6 +866,8 @@
     t=
arget_sources(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_=
random=2Ec
         tests/unit_tests/openvpn/test_schedule=2Ec
+        tes=
ts/unit_tests/openvpn/mock_management=2Ec
+        src/openvpn/base64=2Ec
 =
        src/openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
       =
  src/openvpn/ssl_util=2Ec
diff --git a/doc/man-sections/client-options=2Er=
st b/doc/man-sections/client-options=2Erst
index 87c138a=2E=2Eb204d6a 10064=
4
--- a/doc/man-sections/client-options=2Erst
+++ b/doc/man-sections/client=
-options=2Erst
@@ -12,6 +12,17 @@
   When this option is set, OpenVPN will =
not drop incoming tun packets with
   same destination as host=2E
 
+--app-=
custom-control protocollist
+  Sets the list of supported app custom contro=
l protocols=2E
+  These protocols are announced to the server when this opt=
ion is used
+  as a client=2E If the option is set on a server it will nego=
tiate the
+  common protocols with the client=2E
+
+  The protocollist is a=
 : separated list of protocol identifiers=2E
+
+  See management-notes=2Etx=
t in the OpenVPN distribution and the OpenVPN RFC
+  draft for a descriptio=
n of app custom control protocol support=2E
+
 --auth-token token
   This i=
s not an option to be used directly in any configuration files,
   but rath=
er push this option from a ``--client-connect`` script or a
@@ -437,6 +448,=
12 @@
         Additional authentication methods supported by the client=2E=

         This may be set by the client UI/GUI using ``--setenv``=2E
 
+  :=
code:`IV_ACC=3D<max_msg_len>,<flags>,<protocols>`
+        If the option ``=
--app-custom-control`` is set, the client will
+        send the supported =
max ACC message length, the supported formats
+        as (:code:`A:6`) and=
 the list of configured protocols (e=2Eg=2E
+        :code:`flower:happy:po=
wer`)
+
   The following flags depend on which compression formats are comp=
iled in
   and whether compression is allowed by options=2E See `Protocol o=
ptions`_
   for more details=2E
diff --git a/doc/man-sections/management-op=
tions=2Erst b/doc/man-sections/management-options=2Erst
index 2c79d05=2E=2E=
a7f7ead 100644
--- a/doc/man-sections/management-options=2Erst
+++ b/doc/ma=
n-sections/management-options=2Erst
@@ -144,3 +144,9 @@
 
 --management-up-=
down
   Report tunnel up/down events to management interface=2E
+
+--app-cu=
stom-control protocol-list
+  Sets the app custom control protocols that ar=
e supported and should be
+  negotiated=2E protocol-list is a list of allow=
ed protocols separated by :
+  A client will announce these protocols via t=
he IV_ACC variable and the
+  server will notify the client about the commo=
n protocols=2E
diff --git a/doc/man-sections/script-options=2Erst b/doc/man=
-sections/script-options=2Erst
index f420380f=2E=2E9c17c3b 100644
--- a/doc=
/man-sections/script-options=2Erst
+++ b/doc/man-sections/script-options=2E=
rst
@@ -1006,3 +1006,12 @@
        X509_1_L=3DBISHKEK
        X509_1_ST=3DN=
A
        X509_1_C=3DKG
+
+:code:`acc_protocols`
+    If ``--app-custom-con=
trol`` is configured and the client supports any of the
+    protocols that=
 server also supports, this variable contains a list of
+    common protoco=
ls separated by :=2E
+
+:code:`acc_message_len`
+    if :code:`acc_protocol=
s` is set, this variable contains the maximum
+    message length for app c=
ustom protocol message=2E
\ No newline at end of file
diff --git a/doc/mana=
gement-notes=2Etxt b/doc/management-notes=2Etxt
index 4d726c4=2E=2E159d0f5 =
100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@=
 -828,6 +828,58 @@
 that is required to continue the connection (unlike MFA=
 or opening a browser)
 this message is not negotiated but can just be sent=
 as a gratuitous message=2E
 
+app custom control
+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+If the special string "ACC" is passed as {E=
XTRA} OpenVPN will determine
+the common app custom protocols between the c=
lient and the server and instruct
+the client that the server will send con=
trol messages to the client using
+the ACC protocol=2E
+
+The server should=
 then use client-acc-msg command to send app custom
+control messages to th=
e client to facilitate the pending authentication=2E
+
+COMMAND -- client-a=
cc-msg (OpenVPN 2=2E8 or higher)
+-----------------------------------------=
-
+
+On an OpenVPN instance running in server mode this command sends an
+a=
pp custom control message to a client=2E The format of the command is:
+
+ =
 client-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
=
+CID,KID -- client ID and Key ID=2E See documentation for ">CLIENT:"
+notif=
ication for more info=2E
+
+protocol -- the ACC protocol identifier that th=
is message should be
+            tagged with=2E
+
+flags    -- a colon sep=
arated list of the encoding and the flag if
+            the message is a f=
ragment=2E E=2Eg=2E "6:F" for a base64 encoded
+            message that is=
 also a fragment and not complete yet=2E
+
+message  -- The message encoded=
 in the encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2=2E8 =
or higher)
+------------------------------------------
+
+When OpenVPN is r=
unning in --client mode this command sends an app
+custom command to the se=
rver=2E The format of the command is
+
+  acc-msg
+  {protocol}
+  {flags}
=
+  {message}
+  END
+
+See the client-acc-msg command for more details abou=
t the format of the
+message=2E Since a client has only one peer there is n=
o need to specify the
+client id and key id=2E
+
+
 COMMAND -- client-deny =
 (OpenVPN 2=2E1 or higher)
 -----------------------------------------------=

 
@@ -1302,6 +1354,39 @@
    response=2E Mechanisms that need multiple rou=
nds or more complex answers
    should implement a different response type =
than CR_RESPONSE=2E
 
+(6) App custom control message
+
+    This message i=
s an application specific payload message that is transported
+    over the=
 OpenVPN control channel=2E
+
+    In server mode:
+
+    >CLIENT:ACC,{CID}=
,{KID},{protocol},{fragment},{msg_base64}
+
+    In client mode:
+
+    >AC=
C:{protocol},{fragment},{msg_base64}
+
+    The protocol is a short ascii s=
tring identifying the app specific custom
+    protocol=2E If fragment is s=
et to 1, the message is not complete and the
+    next message should be co=
ncatenated to this message to form a complete
+    message=2E
+
+(7) App cu=
stom control protocol message
+
+   This message informs the client about t=
he common ACC
+   protocols and the maximum message length for an ACC messa=
ge=2E
+
+   In client mode:
+
+   >ACC_PROTOCOLS:protocols=3D{protocol_list=
},message_len=3D{max_msg_len}
+
+   protocol_list is a list of supported pr=
otocols by the client=2E For example
+   flower:power:sys_info would indica=
te these three protocols to be supported=2E
+   max_msg_len specifies the m=
aximum message length that the peer supports=2E
+
+   In server mode these =
are available in the acc_protocols and
+   acc_message_len variables of the=
 client environment=2E
 
 Variables:
 
diff --git a/src/openvpn/Makefile=2E=
am b/src/openvpn/Makefile=2Eam
index 8a60a94=2E=2Eebc4db6 100644
--- a/src/=
openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -45,6 +45,7 @@
 sb=
in_PROGRAMS =3D openvpn
 
 openvpn_SOURCES =3D \
+	acc=2Ec acc=2Eh \
 	argv=
=2Ec argv=2Eh \
 	auth_token=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \=

@@ -124,7 +125,8 @@
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=
=2Ec ps=2Eh \
-	push=2Ec push_util=2Ec push=2Eh \
+	push=2Ec push=2Eh \
+	p=
ush_util=2Ec \
 	pushlist=2Eh \
 	reflect_filter=2Ec reflect_filter=2Eh \
 =
	reliable=2Ec reliable=2Eh \
diff --git a/src/openvpn/acc=2Ec b/src/openvpn=
/acc=2Ec
new file mode 100644
index 0000000=2E=2E2d2d1f8
--- /dev/null
+++ =
b/src/openvpn/acc=2Ec
@@ -0,0 +1,413 @@
+/*
+ *  OpenVPN -- An application =
to securely tunnel IP networks
+ *             over a single TCP/UDP port, =
with support for SSL/TLS-based
+ *             session authentication and k=
ey exchange,
+ *             packet encryption, packet authentication, and
=
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2025 OpenVPN I=
nc <sales@openvpn=2Enet>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549=
=2Eorg>
+ *
+ *
+ *  This program is free software; you can redistribute it=
 and/or modify
+ *  it under the terms of the GNU General Public License ve=
rsion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This =
program is distributed in the hope that it will be useful,
+ *  but WITHOUT=
 ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or=
 FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Licen=
se for more details=2E
+ *
+ *  You should have received a copy of the GNU =
General Public License along
+ *  with this program; if not, write to the F=
ree Software Foundation, Inc=2E,
+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh=
"
+#endif
+
+#include "syshead=2Eh"
+
+#include <string=2Eh>
+#include "buf=
fer=2Eh"
+#include "error=2Eh"
+#include "acc=2Eh"
+#include "forward=2Eh"
=
+#include "options_util=2Eh"
+#include "ssl_util=2Eh"
+#include "ssl_ncp=2E=
h"
+#include "multi=2Eh"
+
+enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS=
_ASCII =3D 1,
+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,
+    ACC_MESSAGE_FLAGS_F=
RAGMENT =3D 4,
+};
+
+
+static void
+log_acc_message(struct context *c, con=
st struct buffer *buf, int payload_len,
+                const char *protoc=
ol, int flags)
+{
+    bool fragment =3D flags & ACC_MESSAGE_FLAGS_FRAGMENT=
;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc =3D gc_new();
+    cons=
t char *payload_msg =3D NULL;
+
+    /* For simplicity, we always encode pa=
yload to be base64 encoded
+     * if not already in base64 format */
+    =
if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+        char *b64out =3D NULL;=

+        ASSERT(openvpn_base64_encode(CBPTR(buf), payload_len, &b64out) >=
=3D 0);
+        gc_addspecial(b64out, free, &gc);
+        payload_msg =3D=
 b64out;
+    }
+    else
+    {
+        payload_msg =3D CBSTR(buf);
+    =
}
+
+    if (management)
+    {
+        struct tls_session *session =3D &c=
->c2=2Etls_multi->session[TM_ACTIVE];
+
+        if (c->options=2Emode =3D=
=3D MODE_SERVER)
+        {
+            /* server mode=2E Report client co=
ntext */
+            struct man_def_auth_context *mda =3D session->opt->md=
a_context;
+            unsigned int mda_key_id =3D get_primary_key(c->c2=
=2Etls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%=
s,%d,%s",
+                mda->cid, mda_key_id, protocol, fragment, payloa=
d_msg);
+        }
+        else
+        {
+            /* Client mode=2E =
Do not a report a CLIENT id */
+            msg(M_CLIENT, ">ACC:%s,%d,%s", =
protocol, fragment, payload_msg);
+        }
+    }
+    gc_free(&gc);
+#en=
dif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Received custom app con=
trol message (protocol '%s'%s)",
+        protocol, fragment ? ", fragment"=
 : "");
+}
+
+
+/**
+ *  Parses the flags field of an app control message a=
nd moves the
+ *  buffer past the flags string=2E If there is an
+ *  error=
 parsing the flags field the method returns -1 and
+ *  puts the error reas=
on in err_reason
+ */
+static int
+parse_acc_message_flags(struct buffer *b=
uf, const char **err_reason, struct gc_arena *gc)
+{
+    const char *flags=
 =3D buf_extract_field(buf, ',', gc);
+
+    if (!flags)
+    {
+        *e=
rr_reason =3D "could not extract flags field";
+        return -1;
+    }
+=

+
+    int acc_flags =3D 0;
+
+    for (const char *flag =3D flags; *flag =
!=3D '\0'; flag++)
+    {
+        if (*flag =3D=3D 'A')
+        {
+      =
      acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;
+        }
+        else if (=
*flag =3D=3D '6')
+        {
+            acc_flags |=3D ACC_MESSAGE_FLAGS_=
BASE64;
+        }
+        else if (*flag =3D=3D 'F')
+        {
+        =
    acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;
+        }
+        else
+  =
      {
+            *err_reason =3D "Unknown flag in flags";
+            =
return -1;
+        }
+    }
+    /* The message should be encoded with exa=
ctly one encoding=2E Ensure that
+     * only one of the flags is present *=
/
+    bool asciienc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    =
bool base64enc =3D (bool)(acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+    if =
(base64enc + asciienc !=3D 1)
+    {
+        char *tmp =3D gc_malloc(512, =
1, gc);
+        snprintf(tmp, 512, "number of encodings must be exactly on=
e "
+                           "(B64=3D%d, ASCII=3D%d)",
+                =
 base64enc, asciienc);
+        *err_reason =3D tmp;
+        return -1;
+ =
   }
+
+    return acc_flags;
+}
+
+
+void
+receive_acc_message(struct cont=
ext *c, const struct buffer *buffer)
+{
+    struct gc_arena gc =3D gc_new(=
);
+    const char *err_reason =3D "";
+
+    /* Example message: ACC,muppe=
ts,15,A,I am Miss Piggy */
+    struct buffer buf =3D *buffer;
+
+    if (!=
buf_advance(&buf, strlen("ACC")) || buf_read_u8(&buf) !=3D ',')
+    {
+   =
     err_reason =3D "missing , after ACC";
+        goto err;
+    }
+
+   =
 /* extract protocol, payload length, flags substrings */
+    const char *=
protocol =3D buf_extract_field(&buf, ',', &gc);
+    if (!protocol)
+    {
=
+        err_reason =3D "could not extract protocol field";
+        goto e=
rr;
+    }
+
+    int payload_len;
+    const char *payload_len_str =3D buf=
_extract_field(&buf, ',', &gc);
+    if (!payload_len_str || !((payload_len=
 =3D atoi(payload_len_str))))
+    {
+        err_reason =3D "could not ext=
ract payload length field";
+        goto err;
+    }
+
+    int flags =3D =
parse_acc_message_flags(&buf, &err_reason, &gc);
+
+    if (flags < 0)
+   =
 {
+        goto err;
+    }
+
+    /* We should have a final NUL byte in t=
he control message buffer
+     * and thus the length of the buffer should =
be payload_len + 1 */
+    if (buf_len(&buf) !=3D payload_len + 1)
+    {
+=
        char *tmp =3D gc_malloc(512, 1, &gc);
+        snprintf(tmp, 512, "=
field length %d, payload length %d mismatch",
+                 payload_len=
, buf_len(&buf) - 1);
+        err_reason =3D tmp;
+        goto err;
+    =
}
+
+
+    log_acc_message(c, &buf, payload_len, protocol, flags);
+    gc_=
free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERRORS, "WARNING: Received =
malformed custom app control channel "
+                       "(%s) messag=
e control message: %s",
+        err_reason,
+        format_hex(BPTR(&buf)=
, BLEN(&buf), 80, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send_acc_message(=
struct context *c,
+                 struct tls_multi *multi,
+            =
     struct tls_session *session,
+                 const char *protocol, b=
ool fragment,
+                 const char *msg, bool base64)
+{
+    /*
+ =
    * length of the protocol string + one ','
+     * 2 for the encoding (A=
 or 6), potential F (fragment), and 1 for the ',',
+     * 4 for the messag=
e size itself and one comma
+     * 1 for the comma before the message itse=
lf */
+    const size_t max_header_size =3D strlen("ACC,") + strlen(protoco=
l) + 1 + 4 + 1 + 2 + 1;
+    size_t len =3D max_header_size + strlen(msg);
=
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_CLIENT, "messa=
ge length (%zu) exceeds maximum possible message length (%d)", len, TLS_CHA=
NNEL_BUF_SIZE);
+        return false;
+    }
+
+    if ((int)len > multi->=
acc_max_message_length)
+    {
+        msg(M_CLIENT, "header (%zu) + messa=
ge size (%zu) length (%zu) exceeds "
+                      "maximum allowe=
d length negotiated with peer (%d)",
+            max_header_size, strlen(m=
sg), len,
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
+               strlen(msg),
+              =
 base64 ? "6" : "A",
+               fragment ? "F" : "",
+               m=
sg);
+
+    send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH)=
;
+    reschedule_multi_process(c);
+    gc_free(&gc);
+    return true;
+}=

+
+char *
+parse_acc_parameters(const char *capabilities,
+               =
      const char *delim,
+                     int *max_acc_len,
+         =
            bool server,
+                     struct gc_arena *gc)
+{
+   =
 char *tmp_message =3D string_alloc(capabilities, NULL);
+    char *tmp_mes=
sage_orig =3D tmp_message;
+    char *lasts =3D NULL;
+
+    const char *to=
ken =3D strtok_r(tmp_message, delim, &lasts);
+
+    int p =3D 0;
+    int =
acclen =3D 0;
+    const char *protocols =3D NULL;
+    char *ret =3D NULL;=

+
+    /* In server mode we allow more capabilities than our own, in clien=
t
+     * mode we reject if we should use capabilities that we do not suppo=
rt */
+    int allowed_acc_len =3D server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+ =
   while (token)
+    {
+        if (p =3D=3D 0 && !atoi_constrained(token,=
 &acclen, "ACC message length", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ER=
RORS))
+        {
+            goto done;
+        }
+
+        if (p =3D=
=3D 1 && (!tls_item_in_cipher_list("A", token) || !tls_item_in_cipher_list(=
"6", token)))
+        {
+            msg(D_PUSH_ERRORS, "App custom contro=
l encoding must include base64 and ascii");
+            goto done;
+      =
  }
+
+        if (p =3D=3D 1 && !server && strcmp(token, "A:6") && strcmp(=
token, "6:A"))
+        {
+            msg(D_PUSH_ERRORS, "App custom contr=
ol encoding must exactly base64 and ascii");
+            goto done;
+     =
   }
+
+        if (p =3D=3D 2)
+        {
+            protocols =3D token=
;
+        }
+
+        if (p =3D=3D 3)
+        {
+            msg(D_PUSH_=
ERRORS, "Too many parameters for INFO ACC message/IV_ACC=2E");
+           =
 goto done;
+        }
+
+        token =3D strtok_r(NULL, delim, &lasts);
=
+        p++;
+    }
+
+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LE=
N);
+    ret =3D string_alloc(protocols, gc);
+
+done:
+    free(tmp_messag=
e_orig);
+    return ret;
+}
+
+struct buffer
+get_list_intersection(struct=
 gc_arena *gc, const char *list1, const char *list2)
+{
+    char *tmp =3D =
strdup(list1);
+    char *lasts =3D NULL;
+    const char *token =3D strtok=
_r(tmp, ":", &lasts);
+
+    /* The maximum possible length is the shorter =
of the two input lists */
+    size_t max_len =3D min_size(strlen(list1), s=
trlen(list2));
+
+    struct buffer common_protocols =3D alloc_buf_gc(max_l=
en + 1, gc);
+
+    while (token)
+    {
+        if (tls_item_in_cipher_li=
st(token, list2))
+        {
+            /* protocol is in both server and=
 client list */
+            if (buf_len(&common_protocols) > 0)
+         =
   {
+                buf_write_u8(&common_protocols, ':');
+            }
=
+            buf_printf(&common_protocols, "%s", token);
+        }
+      =
  token =3D strtok_r(NULL, ":", &lasts);
+    }
+    free(tmp);
+    return=
 common_protocols;
+}
+
+void
+determine_common_acc_protocols(struct tls_mu=
lti *multi, struct tls_session *session)
+{
+    if (!multi->opt=2Eacc_prot=
ocols)
+    {
+        /* No app custom protocols have been configured serv=
er-side=2E */
+        return;
+    }
+
+    if (multi->acc_negotiated_prot=
ocols)
+    {
+        /* We already have determined the common protocols=
=2E Doing this
+         * again would just add an extra string allocation =
to options->gc */
+        return;
+    }
+
+    struct gc_arena gc =3D gc_=
new();
+
+    /* example IV_ACC: IV_ACC=3D2048,6:A,flower:power */
+    con=
st char *peer_info =3D multi->peer_info;
+    const char *iv_acc =3D extrac=
t_var_peer_info(peer_info, "IV_ACC=3D", &gc);
+    if (!iv_acc)
+    {
+   =
     gc_free(&gc);
+        return;
+    }
+
+    int max_acc_len =3D 0;
+ =
   const char *protocols =3D parse_acc_parameters(iv_acc, ",", &max_acc_len=
, true, &gc);
+
+    if (!protocols)
+    {
+        gc_free(&gc);
+       =
 msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable of peer is malforme=
d");
+        return;
+    }
+
+    struct buffer common_protocols =3D get_=
list_intersection(&gc, session->opt->acc_protocols, protocols);
+
+    if (=
buf_len(&common_protocols) =3D=3D 0)
+    {
+        msg(D_PUSH_DEBUG, "WAR=
NING: No common app custom control protocol=2E");
+        gc_free(&gc);
+ =
       return;
+    }
+
+    multi->acc_negotiated_protocols =3D string_all=
oc(buf_str(&common_protocols), NULL);
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
diff --git a=
/src/openvpn/acc=2Eh b/src/openvpn/acc=2Eh
new file mode 100644
index 00000=
00=2E=2E4a388f7
--- /dev/null
+++ b/src/openvpn/acc=2Eh
@@ -0,0 +1,105 @@
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

+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (=
C) 2025 Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *
+ *  This program is free=
 software; you can redistribute it and/or modify
+ *  it under the terms of=
 the GNU General Public License version 2
+ *  as published by the Free Sof=
tware Foundation=2E
+ *
+ *  This program is distributed in the hope that i=
t will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied w=
arranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See=
 the
+ *  GNU General Public License for more details=2E
+ *
+ *  You shoul=
d have received a copy of the GNU General Public License along
+ *  with th=
is program; if not, write to the Free Software Foundation, Inc=2E,
+ *  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
+ */
+
+#ifndef =
ACC_H
+#define ACC_H
+
+#include "openvpn=2Eh"
+
+#define ACC_MIN_MSG_LEN 6=
4
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom=
 control message and delivers it to the
+ * management interface=2E We leav=
e reassembly of fragmented messages to the
+ * management interface=2E
+ *
=
+ * @param c            The context struct
+ * @param buffer       Buffer c=
ontaining the control message with ACC
+ */
+void
+receive_acc_message(stru=
ct context *c, const struct buffer *buffer);
+
+
+bool
+send_acc_message(st=
ruct context *c,
+                 struct tls_multi *tls_multi,
+          =
       struct tls_session *session,
+                 const char *protocol,=
 bool fragment,
+                 const char *msg, bool base64);
+
+
+/**
+=
 * Parses an info message from the server that contains app custom control =
info
+ * information prior to the PUSH_REPLY to be able to use app custom c=
ontrol
+ * protocols before sending
+ *
+ * In client mode only allow what =
we support ourselves=2E In server mode
+ * allow also capabilities that we =
not support ourselves=2E
+ *
+ * @param capabilities      The string to par=
se
+ * @param delim             The delimiter to use when parsing the strin=
g=2E
+ *                          IV_ACC uses "," as delimiter while the
+ =
*                          custom-control PUSH message uses " " as "," is
+=
 *                          already used to separate different push directi=
ves
+ * @param max_acc_len       Set to the maximum ACC message length
+ * =
@param server            Whether we are server or client
+ * @param gc     =
           The gc arena to use for allocating the resulting string
+ * @ret=
urn                  The resulting protocol string or NULL on error
+ */
+c=
har *
+parse_acc_parameters(const char *capabilities,
+                    =
 const char *delim,
+                     int *max_acc_len,
+              =
       bool server,
+                     struct gc_arena *gc);
+
+/**
+ * =
Parses the IV_ACC of the peer and sets multi=2Eacc_negotiated_protocols
+ *=
 to the common protocols of server and client and
+ * multi=2Eacc_max_messa=
ge_length  to the maximum length of the ACC message
+ * support by both ser=
ver and client=2E
+ *
+ * If there is no common protocol or the client does=
 not support any app custom
+ * protocol multi=2Eacc_negotiated_protocols w=
ill be set to NULL=2E
+ *
+ * @param multi      the multi instance to use t=
he set the app custom protocols=2E
+ * @param session    the session to rea=
d the client env from
+ */
+void
+determine_common_acc_protocols(struct tls=
_multi *multi, struct tls_session *session);
+
+/**
+ * Calculates the inte=
rsection of two list that are both separated by :
+ * Items in the result w=
ill have the same ordering as in the list1
+ * parameters
+ * @param gc    =
        Returned buffer will be allocated in this gc
+ * @param list1      =
   First list to intersect
+ * @param list2         Second list to intersec=
t=2E
+ * @return A (potentially empty) buffer containing an intersection li=
st
+ */
+struct buffer
+get_list_intersection(struct gc_arena *gc, const ch=
ar *list1, const char *list2);
+#endif
diff --git a/src/openvpn/forward=2Ec=
 b/src/openvpn/forward=2Ec
index 681210d=2E=2E7923b5e 100644
--- a/src/open=
vpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -42,6 +42,7 @@
 #include "=
dco=2Eh"
 #include "auth_token=2Eh"
 #include "tun_afunix=2Eh"
+#include "a=
cc=2Eh"
 
 #include "memdbg=2Eh"
 
@@ -257,11 +258,11 @@
     }
     else i=
f (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        server_pushe=
d_info(buf, 8);
+        server_pushed_info(c, buf, 8);
     }
     else if=
 (buf_string_match_head_str(buf, "INFO"))
     {
-        server_pushed_inf=
o(buf, 4);
+        server_pushed_info(c, buf, 4);
     }
     else if (buf=
_string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -271,6 +272,10 @@
   =
  {
         receive_auth_pending(c, buf);
     }
+    else if (buf_string_=
match_head_str(buf, "ACC"))
+    {
+        receive_acc_message(c, buf);
+ =
   }
     else if (buf_string_match_head_str(buf, "EXIT"))
     {
         =
receive_exit_message(c);
diff --git a/src/openvpn/init=2Ec b/src/openvpn/in=
it=2Ec
index 1b8b2a5=2E=2E031b18b 100644
--- a/src/openvpn/init=2Ec
+++ b/s=
rc/openvpn/init=2Ec
@@ -2279,6 +2279,13 @@
         }
     }
 
+    struct =
tls_multi *multi =3D c->c2=2Etls_multi;
+    if (multi->acc_negotiated_prot=
ocols)
+    {
+        buf_printf(&out, " custom-control %d,A:6,%s",
+     =
              multi->acc_max_message_length, multi->acc_negotiated_protocol=
s);
+    }
+
     if (BLENZ(&out) > strlen(header))
     {
         msg(D_H=
ANDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +2529,11 @@
         flags |=3D (OP=
T_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->options=2Eacc_protocols)
+=
    {
+        flags |=3D OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -2=
730,6 +2742,17 @@
         frame->tun_mtu =3D min_int(frame->tun_max_mtu, c=
->options=2Ece=2Etun_mtu);
     }
 
+    if (found & OPT_P_ACC && c->option=
s=2Epushed_acc_negotiated_protocols)
+    {
+        struct tls_multi *mult=
i =3D c->c2=2Etls_multi;
+        free(multi->acc_negotiated_protocols);
+ =
       multi->acc_negotiated_protocols =3D string_alloc(c->options=2Epushed=
_acc_negotiated_protocols, NULL);
+        multi->acc_max_message_length =
=3D c->options=2Epushed_acc_max_message_length;
+
+        msg(D_PUSH, "OPT=
IONS IMPORT: ACC protocols: %s, msg len: %d",
+            multi->acc_negot=
iated_protocols, multi->acc_max_message_length);
+    }
+
     return true;=

 }
 
@@ -3352,6 +3375,7 @@
     to=2Everify_hash_depth =3D options->verify=
_hash_depth;
     to=2Everify_hash_no_ca =3D options->verify_hash_no_ca;
  =
   memcpy(to=2Ex509_username_field, options->x509_username_field, sizeof(to=
=2Ex509_username_field));
+    to=2Eacc_protocols =3D options->acc_protocol=
s;
     to=2Ees =3D c->c2=2Ees;
     to=2Enet_ctx =3D &c->net_ctx;
 
@@ -43=
06,6 +4330,24 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+mana=
gement_acc_msg(void *arg,
+                   struct buffer_list *input) /*=
 ownership transferred */
+{
+    struct context *c =3D arg;
+
+    bool re=
t =3D false;
+    if (buffer_list_defined(input) && c->c2=2Etls_multi)
+   =
 {
+        struct tls_multi *multi =3D c->c2=2Etls_multi;
+        struct =
tls_session *session =3D &multi->session[TM_ACTIVE];
+
+        ret =3D man=
agement_send_acc_message(c, multi, session, input);
+    }
+
+    buffer_li=
st_free(input);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 =

 void
@@ -4322,6 +4364,7 @@
         cb=2Eproxy_cmd =3D management_callbac=
k_proxy_cmd;
         cb=2Eremote_cmd =3D management_callback_remote_cmd;
 =
        cb=2Esend_cc_message =3D management_callback_send_cc_message;
+    =
    cb=2Eacc_msg =3D management_acc_msg;
 #ifdef TARGET_ANDROID
         cb=
=2Enetwork_change =3D management_callback_network_change;
 #endif
diff --gi=
t a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ac3d4b7=2E=2E5e4e=
416 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -45=
,9 +45,11 @@
 #include "push=2Eh"
 #include "multi=2Eh"
 #include "resolve=
=2Eh"
+#include "acc=2Eh"
 
 #include "memdbg=2Eh"
 #include "run_command=
=2Eh"
+#include "ssl_ncp=2Eh"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11=2Eh=
"
@@ -1081,6 +1083,35 @@
             }
             break;
 
+        case=
 IEC_CLIENT_ACC_MSG:
+            if (man->persist=2Ecallback=2Eclient_acc_=
msg)
+            {
+                bool status =3D (*man->persist=2Ecallb=
ack=2Eclient_acc_msg)(man->persist=2Ecallback=2Earg,
+                     =
                                                 man->connection=2Ein_extra=
_cid,
+                                                                    =
  man->connection=2Ein_extra_kid,
+                                        =
                              man->connection=2Ein_extra);
+               =
 man->connection=2Ein_extra =3D NULL;
+                report_command_statu=
s(status, "client-acc-msg");
+            }
+            else
+            =
{
+                man_command_unsupported("client-acc-msg");
+            =
}
+            break;
+
+        case IEC_ACC_MSG:
+            if (man->pe=
rsist=2Ecallback=2Eacc_msg)
+            {
+                bool status =3D=
 (*man->persist=2Ecallback=2Eacc_msg)(man->persist=2Ecallback=2Earg,
+     =
                                                          man->connection=
=2Ein_extra);
+                man->connection=2Ein_extra =3D NULL;
+      =
          report_command_status(status, "acc-msg");
+            }
+       =
     else
+            {
+                man_command_unsupported("acc-msg"=
);
+            }
+            break;
         case IEC_PK_SIGN:
          =
   man->connection=2Eext_key_state =3D EKS_READY;
             buffer_list_=
free(man->connection=2Eext_key_input);
@@ -1205,6 +1236,29 @@
 }
 
 static =
void
+man_client_acc_msg(struct management *man, const char *cid_str,
+    =
               const char *kid_str)
+{
+    struct man_connection *mc =3D &=
man->connection;
+    mc->in_extra_cid =3D 0;
+    mc->in_extra_kid =3D 0;
=
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+        && parse_uint(kid_s=
tr, "KID", &mc->in_extra_kid))
+    {
+        mc->in_extra_cmd =3D IEC_CLI=
ENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void=

+man_acc_msg(struct management *man)
+{
+    struct man_connection *mc =3D=
 &man->connection;
+    mc->in_extra_cmd =3D IEC_ACC_MSG;
+    in_extra_res=
et(mc, IER_NEW);
+}
+
+static void
 man_client_auth(struct management *man,=
 const char *cid_str, const char *kid_str, const bool extra)
 {
     struct=
 man_connection *mc =3D &man->connection;
@@ -1759,6 +1813,17 @@
          =
   man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
=
+    else if (streq(p[0], "client-acc-msg"))
+    {
+        if (man_need(p=
, 2, 0))
+        {
+            man_client_acc_msg(man, p[1], p[2]);
+    =
    }
+    }
+    else if (streq(p[0], "acc-msg"))
+    {
+        man_acc_=
msg(man);
+    }
     else if (streq(p[0], "rsa-sig"))
     {
         man_=
pk_sig(man, "rsa-sig");
@@ -2975,7 +3040,9 @@
                             =
           "bytes_sent=3D",
                                        "bytes_=
received=3D",
                                        "session_id=3D",
-   =
                                    "session_state=3D" };
+                =
                       "session_state=3D",
+                               =
        "acc_protocols=3D",
+                                       "acc_me=
ssage_len=3D" };
 
     if (env_filter_level =3D=3D 0)
     {
@@ -3130,6 +3=
197,7 @@
     }
 }
 
+
 void
 management_connection_established(struct mana=
gement *man, struct man_def_auth_context *mdac,
                           =
        const struct env_set *es)
@@ -4372,6 +4440,64 @@
     }
 }
 
+bool
=
+management_send_acc_message(struct context *c, struct tls_multi *multi, st=
ruct tls_session *session,
+                            struct buffer_list =
*input)
+{
+    /* also ensures that are enough inputs in the list to safel=
y call
+     * buffer_list_peek without extra NULL checks */
+    if (!inpu=
t || input->size < 3)
+    {
+        msg(M_CLIENT, "not enough input lines=
 for sending acc message, "
+                      "missing protocol, flag =
and/or messages lines");
+        return false;
+    }
+
+    struct gc_are=
na gc =3D gc_new();
+
+    const struct buffer *proto_buf =3D buffer_list_p=
eek(input);
+    const char *protocol =3D string_alloc(CBSTR(proto_buf), &g=
c);
+    buffer_list_pop(input);
+
+    struct buffer *encoding_buf =3D buf=
fer_list_peek(input);
+    char *encoding =3D buf_str(encoding_buf);
+    c=
onst char *flag =3D NULL;
+    bool b64encoding =3D false;
+    bool fragme=
nt =3D false;
+
+    while ((flag =3D strsep(&encoding, ":")))
+    {
+    =
    if (!strcmp(flag, "6"))
+        {
+            b64encoding =3D true;
+=
        }
+        else if (!strcmp(flag, "F"))
+        {
+            fra=
gment =3D true;
+        }
+    }
+    buffer_list_pop(input);
+
+    buffe=
r_list_aggregate_separator(input, 10000, "");
+    const struct buffer *acc=
_msg_buf =3D buffer_list_peek(input);
+
+    if (!multi->acc_negotiated_pro=
tocols
+        || !tls_item_in_cipher_list(protocol, multi->acc_negotiated=
_protocols))
+    {
+        msg(M_CLIENT, "protocol not in the list of neg=
otiated protocols: %s",
+            np(multi->acc_negotiated_protocols));
=
+        goto error;
+    }
+
+    bool ret =3D send_acc_message(c, multi, =
session, protocol,
+                                fragment, buf_cstr(acc_=
msg_buf),
+                                b64encoding);
+    gc_free(&gc);=

+    return ret;
+error:
+    gc_free(&gc);
+    return false;
+}
 #else /=
* ifdef ENABLE_MANAGEMENT */
 
 #include "win32=2Eh"
diff --git a/src/openv=
pn/manage=2Eh b/src/openvpn/manage=2Eh
index 157039d=2E=2Ecc9c264 100644
--=
- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -184,12 +184,19 =
@@
     int (*n_clients)(void *arg);
     bool (*send_cc_message)(void *arg=
, const char *message, const char *parameter);
     bool (*kill_by_cid)(voi=
d *arg, const unsigned long cid, const char *kill_msg);
+
     bool (*clien=
t_auth)(void *arg, const unsigned long cid, const unsigned int mda_key_id,
=
                         const bool auth, const char *reason, const char *c=
lient_reason,
                         struct buffer_list *cc_config); /* o=
wnership transferred */
     bool (*client_pending_auth)(void *arg, const u=
nsigned long cid, const unsigned int kid,
                                 =
const char *extra, unsigned int timeout);
     char *(*get_peer_info)(void =
*arg, const unsigned long cid);
+    bool (*client_acc_msg)(void *arg,
+   =
                        const unsigned long cid,
+                         =
  const unsigned int mda_key_id,
+                           struct buffer_=
list *msg);
+    bool (*acc_msg)(void *arg,
+                    struct buf=
fer_list *msg);
     bool (*proxy_cmd)(void *arg, const char **p);
     boo=
l (*remote_cmd)(void *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,=
13 +299,15 @@
     struct command_line *in;
     struct buffer_list *out;
 =

-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF  =
        0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMO=
VED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#def=
ine IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN     =
  3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN        5
+#define IE=
C_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG      =
  8
     int in_extra_cmd;
     struct buffer_list *in_extra;
     unsigned=
 long in_extra_cid;
@@ -503,6 +512,14 @@
 
 void man_persist_client_stats(s=
truct management *man, struct context *c);
 
+/** Parses the ACC message fr=
om the input buffer_list and send to the
+ * session identified by session =
and multi
+ */
+struct tls_session;
+struct tls_multi;
+bool
+management_se=
nd_acc_message(struct context *c, struct tls_multi *multi,
+               =
             struct tls_session *session, struct buffer_list *input);
 #end=
if /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/multi=2Ec =
b/src/openvpn/multi=2Ec
index e302a81=2E=2E0ae503d 100644
--- a/src/openvpn=
/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -53,6 +53,7 @@
 #include "ssl_uti=
l=2Eh"
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
+#include "acc=2E=
h"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -1735,8 +1736,9 @@
  * - peer=
 id
  */
 static bool
-multi_client_set_protocol_options(struct context *c)=

+multi_client_set_protocol_options(struct multi_instance *mi)
 {
+    stru=
ct context *c =3D &mi->context;
     struct tls_multi *tls_multi =3D c->c2=
=2Etls_multi;
     const char *const peer_info =3D tls_multi->peer_info;
  =
   struct options *o =3D &c->options;
@@ -2380,7 +2382,7 @@
      * peer mu=
st be added before iroutes=2E For other platforms it doesn't matter=2E */
 =

     /* authentication complete, calculate dynamic client specific options=
 */
-    if (!multi_client_set_protocol_options(&mi->context))
+    if (!mu=
lti_client_set_protocol_options(mi))
     {
         mi->context=2Ec2=2Etls=
_multi->multi_state =3D CAS_FAILED;
     }
@@ -4085,6 +4087,26 @@
     }
 }=

 
+static const char *
+calculate_app_control_extra(struct multi_instance =
*mi, struct gc_arena *gc)
+{
+    struct context *c =3D &mi->context;
+    =
struct tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!multi->acc_negot=
iated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No negotiated protocol=
s");
+        return NULL;
+    }
+
+    struct buffer buf =3D alloc_buf_gc=
(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", multi->acc_max_message=
_length,
+               multi->acc_negotiated_protocols);
+    return buf_=
str(&buf);
+}
+
+
 static bool
 management_client_pending_auth(void *arg, c=
onst unsigned long cid, const unsigned int mda_key_id,
                    =
            const char *extra, unsigned int timeout)
@@ -4095,10 +4117,22 @=
@
     if (mi)
     {
         struct tls_multi *multi =3D mi->context=2Ec2=
=2Etls_multi;
+
+        struct gc_arena gc =3D gc_new();
+        if (!str=
cmp(extra, "ACC"))
+        {
+            extra =3D calculate_app_control_=
extra(mi, &gc);
+            if (!extra)
+            {
+                gc=
_free(&gc);
+                return false;
+            }
+        }
      =
   struct tls_session *session =3D lookup_session_by_mda_key_id(multi, mda_=
key_id);
 
         if (!session)
         {
+            gc_free(&gc);
   =
          return false;
         }
 
@@ -4106,6 +4140,7 @@
         bool re=
t =3D send_auth_pending_messages(multi, session, extra, timeout);
         =
reschedule_multi_process(&mi->context);
         multi_schedule_context_wak=
eup(m, mi);
+        gc_free(&gc);
         return ret;
     }
     return =
false;
@@ -4149,6 +4184,37 @@
     return ret;
 }
 
+
+static bool
+managem=
ent_client_acc_msg(void *arg,
+                          const unsigned lon=
g cid,
+                          const unsigned int mda_key_id,
+         =
                 struct buffer_list *input) /* ownership transferred */
+{
=
+    struct multi_context *m =3D (struct multi_context *)arg;
+    struct m=
ulti_instance *mi =3D lookup_by_cid(m, cid);
+
+    bool ret =3D false;
+  =
  if (mi && buffer_list_defined(input))
+    {
+        struct tls_multi *m=
ulti =3D mi->context=2Ec2=2Etls_multi;
+        struct tls_session *session=
 =3D lookup_session_by_mda_key_id(multi, mda_key_id);
+        if (!session=
)
+        {
+            msg(M_CLIENT, "client session not found");
+     =
       buffer_list_free(input);
+            return false;
+        }
+
+  =
      ret =3D management_send_acc_message(&mi->context, multi, session, inp=
ut);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
+    buffer_li=
st_free(input);
+    return ret;
+}
+
+
 static char *
 management_get_peer=
_info(void *arg, const unsigned long cid)
 {
@@ -4185,6 +4251,7 @@
        =
 cb=2En_clients =3D management_callback_n_clients;
         cb=2Ekill_by_ci=
d =3D management_kill_by_cid;
         cb=2Eclient_auth =3D management_clie=
nt_auth;
+        cb=2Eclient_acc_msg =3D management_client_acc_msg;
      =
   cb=2Eclient_pending_auth =3D management_client_pending_auth;
         cb=
=2Eget_peer_info =3D management_get_peer_info;
         cb=2Epush_update_br=
oadcast =3D management_callback_send_push_update_broadcast;
diff --git a/sr=
c/openvpn/options=2Ec b/src/openvpn/options=2Ec
index fb319ae=2E=2E04b553e =
100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -35,6=
 +35,7 @@
 
 #include "syshead=2Eh"
 
+#include "acc=2Eh"
 #include "buffer=
=2Eh"
 #include "error=2Eh"
 #include "common=2Eh"
@@ -7107,6 +7108,41 @@
 =
        VERIFY_PERMISSION(OPT_P_GENERAL);
         options->force_key_mater=
ial_export =3D true;
     }
+    else if (streq(p[0], "app-custom-control")=
 && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+     =
   options->acc_protocols =3D p[1];
+    }
+    else if (streq(p[0], "custo=
m-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+        VERIFY_PERMIS=
SION(OPT_P_ACC);
+
+        /* check if the list from the server is a real =
subset of our list */
+        struct gc_arena gc =3D gc_new();
+        st=
ruct buffer common_list =3D get_list_intersection(&gc, p[3], options->acc_p=
rotocols);
+
+        if (buf_len(&common_list) =3D=3D 0 || !streq(p[3], bu=
f_cstr(&common_list)))
+        {
+            msg(msglevel, "App custom co=
ntrol list from server contains "
+                          "unsupported p=
rotocols");
+            gc_free(&gc);
+            goto err;
+        }
+ =
       gc_free(&gc);
+
+        if (!streq(p[2], "A:6") && !streq(p[2], "6:=
A"))
+        {
+            msg(msglevel, "App custom control encoding mus=
t be base64 and ascii");
+            goto err;
+        }
+
+        if (!=
atoi_constrained(p[1], &options->pushed_acc_max_message_length,
+          =
                    "app custom message message length", ACC_MIN_MSG_LEN, A=
CC_MAX_MSG_LEN, msglevel))
+        {
+            goto err;
+        }
+  =
      options->pushed_acc_negotiated_protocols =3D p[3];
+    }
     else i=
f (streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTIC=
E: --prng option ignored (SSL library PRNG is used)");
diff --git a/src/ope=
nvpn/options=2Eh b/src/openvpn/options=2Eh
index 6a3bf61=2E=2Eb7945e0 10064=
4
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -715,6 +71=
5,18 @@
     /* force using TLS key material export for data channel key ge=
neration */
     bool force_key_material_export;
 
+    /** The app custom =
control protocols we should announce as supported */
+    const char *acc_p=
rotocols;
+
+    /** the protocols that are negotiated with the peer=2E Thi=
s is a
+     *  a temporary variable since options=2Ec push parser cannot a=
ccess
+     *  tls multi struct */
+    const char *pushed_acc_negotiated_p=
rotocols;
+
+    /** the maximum length of an ACC control channel message v=
ia push message
+     * */
+    int pushed_acc_max_message_length;
+
     b=
ool vlan_tagging;
     enum vlan_acceptable_frames vlan_accept;
     uint16=
_t vlan_pvid;
@@ -764,8 +776,10 @@
 #define OPT_P_INLINE          (1u << 29=
)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     =
(1u << 31)
+#define OPT_P_ACC             (1ull << 32)
 
-#define OPT_P_DEF=
AULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Opt=
ions allowed in the normal configuration file (vs pushed options or in ccd =
files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_=
P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
diff -=
-git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 42259c3=2E=2Edf057=
46 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -27,6 +2=
7,8 @@
 #include "syshead=2Eh"
 
 #include "push=2Eh"
+
+#include "acc=2Eh"=

 #include "options=2Eh"
 #include "crypto=2Eh"
 #include "ssl=2Eh"
@@ -221=
,9 +223,56 @@
 #endif
 }
 
+static void
+parse_server_pushed_info_acc(struc=
t context *c, struct buffer *buf)
+{
+    int max_acc_len =3D 0;
+    struc=
t tls_multi *multi =3D c->c2=2Etls_multi;
+
+    if (!multi->opt=2Eacc_prot=
ocols)
+    {
+        msg(D_PUSH_ERRORS, "Server tried to push app custom =
control list "
+                           "without client announcing suppo=
rt for it");
+        return;
+    }
+
+    /* example string to parse: ACC=
:1400 A:6 flower:happy */
+    /* Skip over the ACC: prefix */
+    buf_adv=
ance(buf, 4);
+
+    struct gc_arena gc =3D gc_new();
+    const char *prot=
ocols =3D parse_acc_parameters(buf_cstr(buf), " ", &max_acc_len, false, &gc=
);
+    if (!protocols)
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Receiv=
ed ACC info command with invalid parameters");
+        return;
+    }
+
+ =
   /* check if the list from the server is a real subset of our list */
+  =
  struct buffer common_list =3D get_list_intersection(&gc, protocols, multi=
->opt=2Eacc_protocols);
+
+    if (buf_len(&common_list) =3D=3D 0 || !streq=
(protocols, buf_cstr(&common_list)))
+    {
+        msg(D_PUSH_ERRORS, "Ap=
p custom control list from server contains "
+                           "u=
nsupported protocols");
+        gc_free(&gc);
+        return;
+    }
+
+ =
   multi->acc_negotiated_protocols =3D string_alloc(protocols, NULL);
+    =
multi->acc_max_message_length =3D max_acc_len;
+
+#ifdef ENABLE_MANAGEMENT
=
+    if (management)
+    {
+        msg(M_CLIENT, ">ACC_PROTOCOLS:protocol=
s=3D%s,message_len=3D%d", protocols, max_acc_len);
+    }
+#endif
+    gc_f=
ree(&gc);
+}
 
 void
-server_pushed_info(const struct buffer *buffer, const=
 int adv)
+server_pushed_info(struct context *c, const struct buffer *buffe=
r, const int adv)
 {
     const char *m =3D "";
     struct buffer buf =3D =
*buffer;
@@ -233,6 +282,12 @@
         m =3D BSTR(&buf);
     }
 
+    if (=
strncmp(m, "ACC:", 4) =3D=3D 0)
+    {
+        parse_server_pushed_info_ac=
c(c, &buf);
+        return;
+    }
+
 #ifdef ENABLE_MANAGEMENT
     struct=
 gc_arena gc;
     if (management)
@@ -285,6 +340,7 @@
     msg(D_PUSH, "CR=
 response was sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keyword=
 for the AUTH_PENDING request
  * @param buffer                buffer conta=
ining the keywords, the buffer's
@@ -441,7 +497,6 @@
     const char *const=
 peer_info =3D tls_multi->peer_info;
     unsigned int proto =3D extract_iv=
_proto(peer_info);
 
-
     /* Calculate the maximum timeout and subtract t=
he time we already waited */
     unsigned int max_timeout =3D
         max=
_uint(tls_multi->opt=2Erenegotiate_seconds / 2, tls_multi->opt=2Ehandshake_=
window);
@@ -732,6 +787,12 @@
                 client_max_mtu, o->ce=2Etun_=
mtu, o->ce=2Etun_mtu);
         }
     }
+
+    if (tls_multi->acc_negotiat=
ed_protocols)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "cust=
om-control %d A:6 %s",
+                        tls_multi->acc_max_message_=
length, tls_multi->acc_negotiated_protocols);
+    }
 }
 
 static bool
diff=
 --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index 39302f6=2E=2Eb66=
95bc 100644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -52,6 =
+52,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /**
=
  * @brief Handles the receiving of a push-update message and applies updat=
es to the specified
  * options=2E
@@ -92,7 +93,7 @@
 
 void receive_exit_m=
essage(struct context *c);
 
-void server_pushed_info(const struct buffer *=
buffer, const int adv);
+void server_pushed_info(struct context *c, const s=
truct buffer *buffer, const int adv);
 
 void receive_cr_response(struct co=
ntext *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec
index 086a6fc=2E=2Ee84d32d 100644
--- a/src/openvpn/s=
sl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -55,6 +55,7 @@
 
 #include "crypto_epoc=
h=2Eh"
 #include "ssl=2Eh"
+#include "acc=2Eh"
 #include "ssl_verify=2Eh"
 =
#include "ssl_backend=2Eh"
 #include "ssl_ncp=2Eh"
@@ -1279,6 +1280,7 @@
  =
   free(multi->locked_cn);
     free(multi->locked_username);
     free(mul=
ti->locked_original_username);
+    free(multi->acc_negotiated_protocols);
=
 
     cert_hash_free(multi->locked_cert_hash_set);
 
@@ -2117,6 +2119,11 @=
@
                     }
                 }
             }
+
+            i=
f (session->opt->acc_protocols)
+            {
+                buf_printf(=
&out, "IV_ACC=3D%d,6:A,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols)=
;
+            }
         }
     }
 
@@ -2398,6 +2405,8 @@
         multi->=
remote_ciphername =3D string_alloc("none", NULL);
     }
 
+    determine_c=
ommon_acc_protocols(multi, session);
+
     if (username_len < 0 || passwor=
d_len < 0)
     {
         msg(D_TLS_ERRORS, "TLS Error: Username (%d) or p=
assword (%d) too long", abs(username_len),
diff --git a/src/openvpn/ssl_com=
mon=2Eh b/src/openvpn/ssl_common=2Eh
index 9a55ead=2E=2E436770b 100644
--- =
a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -457,6 +45=
7,9 @@
     size_t ekm_size;
 
     bool dco_enabled; /**< Whether keys hav=
e to be installed in DCO or not */
+
+    /** The app custom control protoc=
ols we should announce as supported */
+    const char *acc_protocols;
 };
=
 
 /** @addtogroup control_processor
@@ -730,6 +733,12 @@
     int dco_peer=
_id;
 
     dco_context_t *dco;
+
+    /** the protocols that are negotiate=
d with the peer=2E */
+    char *acc_negotiated_protocols;
+
+    /** the m=
aximum length of an ACC control channel message */
+    int acc_max_message=
_length;
 };
 
 /**  gets an item  of \c key_state objects in the
diff --gi=
t a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makef=
ile=2Eam
index 43a6743=2E=2E86326af 100644
--- a/tests/unit_tests/openvpn/M=
akefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -107,10 +107,1=
2 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL=
_CRYPTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
+	test_acc=2Ec tes=
t_acc=2Eh \
 	mock_msg=2Ec mock_msg=2Eh test_common=2Eh \
 	mock_management=
=2Ec \
 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \
 	$(top_srcdir)/=
src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn/acc=2Ec \
 	$(t=
op_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
=
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
@@ -132,6 +134,7 @@
 	$(top_srcdir=
)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_openssl=2Ec=
 \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2Ec \
+	$(top_srcdir)/src/openvp=
n/ssl_ncp=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
 	$(top_srcdir)/=
src/openvpn/ssl_verify_mbedtls=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_verify=
_openssl=2Ec \
@@ -392,9 +395,11 @@
 
 misc_testdriver_SOURCES =3D test_mis=
c=2Ec \
 	test_schedule=2Ec test_schedule=2Eh \
+	mock_management=2Ec mock_=
management=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
=
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
+	$(top_srcdir)/src/openvpn=
/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/=
openvpn/options_util=2Ec \
 	$(top_srcdir)/src/openvpn/ssl_util=2Ec \
@@ -4=
07,6 +412,7 @@
 	$(top_srcdir)/src/openvpn/siphash_reference=2Ec \
 	$(top_=
srcdir)/src/openvpn/session_id=2Ec
 
+
 push_update_msg_testdriver_CFLAGS =
=3D -I$(top_srcdir)/src/openvpn \
 	-I$(top_srcdir)/src/compat \
 	-I$(top_=
srcdir)/tests/unit_tests/openvpn \
diff --git a/tests/unit_tests/openvpn/mo=
ck_management=2Ec b/tests/unit_tests/openvpn/mock_management=2Ec
index fff4=
c2b=2E=2Ef572dbb 100644
--- a/tests/unit_tests/openvpn/mock_management=2Ec
=
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -29,6 +29,7 @@
 
 #in=
clude "syshead=2Eh"
 
+#include <stdlib=2Eh>
 #include "manage=2Eh"
 
 #ifd=
ef ENABLE_MANAGEMENT
diff --git a/tests/unit_tests/openvpn/mock_management=
=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh
new file mode 100644
in=
dex 0000000=2E=2E80dcfc2
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_=
management=2Eh
@@ -0,0 +1,29 @@
+/*
+ *  OpenVPN -- An application to secur=
ely tunnel IP networks
+ *             over a single UDP port, with support=
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
+#ifndef MOCK_MANAGEMENT_H
+#defi=
ne MOCK_MANAGEMENT_H
+void init_mock_management(void);
+
+void uninit_mock_=
management(void);
+
+#endif
diff --git a/tests/unit_tests/openvpn/mock_push=
_dependencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
ind=
ex bf2ccf3=2E=2Ef083f89 100644
--- a/tests/unit_tests/openvpn/mock_push_dep=
endencies=2Ec
+++ b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
@@ =
-43,7 +43,8 @@
     uint64_t flags =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_=
P_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SH=
APER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      | OPT=
_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-       =
              | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | =
OPT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PU=
SH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
   =
  return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/t=
ests/unit_tests/openvpn/test_acc=2Ec
new file mode 100644
index 0000000=2E=
=2Ea41fa63
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc=2Ec
@@ -0,=
0 +1,339 @@
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
+char control_channel_mesag=
e_sent[2048];
+
+/* Mock functions */
+bool
+send_control_channel_string_do=
work(struct tls_session *session,
+                                   const=
 char *str, unsigned int msglevel)
+{
+    assert_int_in_range(strlen(str),=
 0, 2048);
+
+    memcpy(control_channel_mesage_sent, str, strlen(str));
+ =
   return true;
+}
+
+void
+send_push_reply_auth_token(struct tls_multi *mu=
lti)
+{
+}
+
+void
+auth_set_client_reason(struct tls_multi *multi, const c=
har *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9J=
njI3tBM"                \
+                    "r4engpg/cDgS48DMaxyCdbzofNj=
QJU9Y0DD66z/notFT0cF1d60nTS" \
+                    "4md4OJwoQAwEwITAxMBwCz=
AMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+                    "AJwBnwArAFAA5wAnA=
EwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+                    "QAXAB4AGQAYA=
QABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                    "ICAgaCB=
sIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+                    "AU=
EAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                  =
  "93rQwityP9eKSijXgcQ=3D=3D"
+
+void
+test_acc_parse_client_messages(void =
**state)
+{
+#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    /* ensure t=
hat the messages get to mock_msg */
+    x_debug_level =3D 3;
+    manageme=
nt =3D (void *)0x12345678;
+    struct gc_arena gc =3D gc_new();
+
+    /* =
contains a TLS 1=2E3 ClientHello */
+    const char msg[] =3D "ACC,cck1,384=
,6," MSG_PAYLOAD;
+
+    struct buffer msg_buf;
+    struct context c =3D {=
 0 };
+    c=2Eoptions=2Emode =3D MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c=
=2Ec2=2Etls_multi, struct tls_multi, &gc);
+
+    c=2Ec2=2Etls_multi->sessi=
on[TM_ACTIVE]=2Eopt =3D &c=2Ec2=2Etls_multi->opt;
+    c=2Ec2=2Etls_multi->=
session[TM_ACTIVE]=2Eopt->mda_context =3D &c=2Ec2=2Emda_context;
+    buf_s=
et_read(&msg_buf, (void *)msg, sizeof(msg));
+    receive_acc_message(&c, &=
msg_buf);
+
+    assert_string_equal(mock_msg_buf, "Received custom app con=
trol message (protocol 'cck1')");
+    assert_string_equal(mock_managment_b=
uf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLOAD);
+
+    const char flower_msg[] =
=3D "ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";=

+    buf_set_read(&msg_buf, (void *)flower_msg, sizeof(flower_msg));
+    =
receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "=
Received custom app control message (protocol 'flower')");
+    assert_stri=
ng_equal(mock_managment_buf, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD/=
/SB0aGUg77+94oCPZnJvZyEAAA=3D=3D");
+
+    CLEAR(mock_managment_buf);
+    =
const char msg_incorrect_len[] =3D "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLC=
AAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D";
+    buf_set_read(&msg_buf=
, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));
+    receive_acc_m=
essage(&c, &msg_buf);
+    const char *error =3D "WARNING: Received malform=
ed custom app control channel "
+                        "(field length 62,=
 payload length 64 mismatch) message "
+                        "control me=
ssage: 496e7367 496d316c 496a6f67 496d5a79 "
+                        "6232=
6369 4c434141 65475a6d 2f534a7[more=2E=2E=2E]";
+
+    assert_string_equal(=
mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+=
    CLEAR(mock_managment_buf);
+    const char msg_fragment[] =3D "ACC,powe=
r,12,6F,aGVsbG8gdw=3D=3D";
+    buf_set_read(&msg_buf, (void *)msg_fragment=
, sizeof(msg_fragment));
+    receive_acc_message(&c, &msg_buf);
+    asser=
t_string_equal(mock_msg_buf, "Received custom app control message (protocol=
 'power', fragment)");
+    assert_string_equal(mock_managment_buf, ">CLIEN=
T:ACC,0,0,power,1,aGVsbG8gdw=3D=3D");
+
+    CLEAR(mock_managment_buf);
+  =
  /* check two encoding present */
+    const char flower_msg_two_encs[] =
=3D "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D"=
;
+    buf_set_read(&msg_buf, (void *)flower_msg_two_encs, sizeof(flower_ms=
g_two_encs));
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WAR=
NING: Received malformed custom app control channel (number of "
+         =
   "encodings must be exactly one (B64=3D1, ASCII=3D1)) message control "
+=
            "message: 53534268 62534141 4945746c 636d3170 6443442f 2f534230=
 "
+            "61475567 37372b3[more=2E=2E=2E]";
+    assert_string_equal=
(mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
=
+    /* no encoding present */
+    const char flower_msg_no_encs[] =3D "AC=
C,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D";
+    bu=
f_set_read(&msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs)=
);
+    receive_acc_message(&c, &msg_buf);
+
+    error =3D "WARNING: Recei=
ved malformed custom app control channel (number of "
+            "encodin=
gs must be exactly one (B64=3D0, ASCII=3D0)) message control "
+           =
 "message: 53534268 62534141 4945746c 636d3170 6443442f 2f534230 "
+       =
     "61475567 37372b3[more=2E=2E=2E]";
+    assert_string_equal(mock_msg_b=
uf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+    x_debu=
g_level =3D 0;
+    management =3D NULL;
+    gc_free(&gc);
+#endif
+}
+
+v=
oid
+test_parse_acc_parameters(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    /* parameters to INFO message */
+    const char *info_acc_=
msg =3D "4096 A:6 flower:happy";
+
+    int max_len =3D 0;
+    const char =
*protocols =3D parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc)=
;
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equa=
l(max_len, 1280);
+
+    /* a client does not accept a length longer than i=
t supports */
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &m=
ax_len, false, &gc);
+    assert_null(protocols);
+
+    /* message with lo=
wer limit than our, should work for client and server */
+    info_acc_msg =
=3D "1111 A:6 flower:happy";
+    protocols =3D parse_acc_parameters(info_a=
cc_msg, " ", &max_len, false, &gc);
+    assert_string_equal(protocols, "fl=
ower:happy");
+    assert_int_equal(max_len, 1111);
+
+    protocols =3D pa=
rse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_str=
ing_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1111);=

+
+    /* more encodings than supported=2E Server should be okay, client s=
hould fail */
+    info_acc_msg =3D "1200 A:6:B flower:happy";
+    protoco=
ls =3D parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    =
assert_null(protocols);
+
+    protocols =3D parse_acc_parameters(info_acc_=
msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower=
:happy");
+    assert_int_equal(max_len, 1200);
+
+    /* extra parameter *=
/
+    info_acc_msg =3D "1400 A:6 flower:happy 77";
+    protocols =3D pars=
e_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(=
protocols);
+
+    protocols =3D parse_acc_parameters(info_acc_msg, " ", &m=
ax_len, false, &gc);
+    assert_null(protocols);
+
+
+    const char *iv_a=
cc_capabilities =3D "1400,A:6,flower:happy:power";
+    protocols =3D parse=
_acc_parameters(iv_acc_capabilities, ",", &max_len, true, &gc);
+    assert=
_string_equal(protocols, "flower:happy:power");
+
+    /* too small protoco=
l length */
+    info_acc_msg =3D "32 A:6 flower:happy";
+    protocols =3D=
 parse_acc_parameters(info_acc_msg, ",", &max_len, true, &gc);
+    assert_=
null(protocols);
+
+    /* non-numerical protocol length */
+    info_acc_m=
sg =3D "abff A:6 flower:happy 77";
+    protocols =3D parse_acc_parameters(=
info_acc_msg, ",", &max_len, true, &gc);
+    assert_null(protocols);
+
+  =
  /* non-numerical protocol length */
+    info_acc_msg =3D "abff A:6 flowe=
r:happy 77";
+    protocols =3D parse_acc_parameters(info_acc_msg, ",", &ma=
x_len, true, &gc);
+    assert_null(protocols);
+
+    gc_free(&gc);
+}
+
+=
void
+test_acc_common_protocols(void **state)
+{
+    struct multi_instance=
 mi =3D { 0 };
+    struct context *c =3D &mi=2Econtext;
+    c->options=2E=
gc =3D gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_mu=
lti, &c->options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV_PROTO=
=3D4321\nIV_ACC=3D1400,A:6,flower:happy:power";
+    c->options=2Eacc_proto=
cols =3D "power:flower:star";
+    struct tls_multi *multi =3D c->c2=2Etls_=
multi;
+    multi->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+   =
 multi->session[TM_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2Ees =3D =
env_set_create(&c->options=2Egc);
+
+    determine_common_acc_protocols(mul=
ti, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    assert_int_equal(multi-=
>acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_string_equal(multi->=
acc_negotiated_protocols, "power:flower");
+
+    assert_string_equal(env_s=
et_get(multi->opt=2Ees, "acc_protocols"), "acc_protocols=3Dpower:flower");
=
+    assert_string_equal(env_set_get(multi->opt=2Ees, "acc_message_len"), "=
acc_message_len=3D1280");
+
+    gc_free(&c->options=2Egc);
+}
+
+void
+tes=
t_acc_send_message(void **state)
+{
+    struct multi_instance mi =3D { 0 }=
;
+    struct context *c =3D &mi=2Econtext;
+    c->options=2Egc =3D gc_new=
();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2=2Etls_multi, struct tls_multi, &c->opti=
ons=2Egc);
+    bool ret;
+    struct tls_multi *multi =3D c->c2=2Etls_mult=
i;
+    c->options=2Eacc_protocols =3D "power:flower:emergency";
+    multi=
->opt=2Eacc_protocols =3D c->options=2Eacc_protocols;
+    multi->session[T=
M_ACTIVE]=2Eopt =3D &multi->opt;
+    multi->opt=2Ees =3D env_set_create(&c=
->options=2Egc);
+
+    c->c2=2Etls_multi->peer_info =3D "IV_PROTO=3D4321\n=
IV_ACC=3D1400,A:6,flower:emergency:power";
+    determine_common_acc_protoc=
ols(multi, &c->c2=2Etls_multi->session[TM_ACTIVE]);
+
+    struct tls_sessi=
on *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
+
+    ret =3D send=
_acc_message(c, c->c2=2Etls_multi, session, "emergency", true,
+           =
                "EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false=
);
+
+    assert_true(ret);
+    assert_string_equal(control_channel_mesage=
_sent,
+                        "ACC,emergency,50,AF,EMERGENCY BROADCAST ME=
SSAGE - THIS IS NOT A DRILL:");
+
+    ret =3D send_acc_message(c, c->c2=2E=
tls_multi, session, "emergency", false,
+                           "THE GO=
VERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA=2E", false);
+  =
  assert_true(ret);
+    assert_string_equal(control_channel_mesage_sent,
+=
                        "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAI=
NBOW COLOURED ALERT FOR YOUR AREA=2E");
+
+
+    /* test a long message (> =
1000) with fragment to get the maximum header size */
+    char long_messag=
e[1200] =3D { 0 };
+
+    for (int i =3D 0; i < 1024; i++)
+    {
+        =
long_message[i] =3D (char)(' ' + (i % 95));
+    }
+
+    /* last char of t=
he message is a i and then a \0 */
+    assert_int_equal(long_message[1023]=
, 'i');
+    assert_int_equal(long_message[1024], '\0');
+
+    ret =3D sen=
d_acc_message(c, c->c2=2Etls_multi, session, "emergency", true,
+          =
                 long_message, false);
+
+    assert_true(ret);
+    size_t=
 cc_len =3D strlen(control_channel_mesage_sent);
+    assert_int_equal(cont=
rol_channel_mesage_sent[cc_len - 1], 'i');
+    const char *expected_start_=
cc =3D "ACC,emergency,1024,AF, !\"#$%&'()*+,-=2E/012345";
+    assert_memor=
y_equal(control_channel_mesage_sent, expected_start_cc, sizeof(expected_sta=
rt_cc));
+
+    gc_free(&c->options=2Egc);
+}
+
+void
+test_list_intersecti=
on(void **state)
+{
+    const char *empty =3D "";
+    const char *protos =
=3D "power:flower:emergency";
+
+    struct gc_arena gc =3D gc_new();
+
+  =
  struct buffer t1 =3D get_list_intersection(&gc, empty, protos);
+    asse=
rt_int_equal(buf_len(&t1), 0);
+
+    struct buffer t2 =3D get_list_interse=
ction(&gc, protos, empty);
+    assert_int_equal(buf_len(&t2), 0);
+
+    s=
truct buffer t3 =3D get_list_intersection(&gc, protos, protos);
+    assert=
_string_equal(buf_cstr(&t3), protos);
+
+    const char *protos2 =3D "flowe=
r:emergency:power:mario";
+    struct buffer t4 =3D get_list_intersection(&=
gc, protos2, protos);
+    assert_string_equal(buf_cstr(&t4), "flower:emerg=
ency:power");
+
+    const char *protos3 =3D "super:paper:mario:flower";
+ =
   struct buffer t5 =3D get_list_intersection(&gc, protos2, protos3);
+    =
assert_string_equal(buf_cstr(&t5), "flower:mario");
+
+    gc_free(&gc);
+}=

diff --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/open=
vpn/test_acc=2Eh
new file mode 100644
index 0000000=2E=2E32421fb
--- /dev/n=
ull
+++ b/tests/unit_tests/openvpn/test_acc=2Eh
@@ -0,0 +1,35 @@
+/*
+ *  O=
penVPN -- An application to securely tunnel IP networks
+ *             ove=
r a single UDP port, with support for SSL/TLS-based
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
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H
+void test_acc_parse_client_messa=
ges(void **state);
+
+void test_parse_acc_parameters(void **state);
+
+void=
 test_acc_common_protocols(void **state);
+
+void test_acc_send_message(voi=
d **state);
+
+void test_list_intersection(void **state);
+#endif
diff --gi=
t a/tests/unit_tests/openvpn/test_common=2Eh b/tests/unit_tests/openvpn/tes=
t_common=2Eh
index 8db4ea6=2E=2Ec865142 100644
--- a/tests/unit_tests/openv=
pn/test_common=2Eh
+++ b/tests/unit_tests/openvpn/test_common=2Eh
@@ -43,11=
 +43,13 @@
 #define LargestIntegralType uintmax_t
 #endif
 /* redefine 2=2E=
x API in terms of 1=2Ex API */
-#define CMockaValueData             Largest=
IntegralType
-#define check_expected_uint         check_expected
-#define e=
xpect_uint_value           expect_value
-#define expect_check_data         =
  expect_check
-#define cast_ptr_to_cmocka_value(x) (x)
+#define CMockaValu=
eData                       LargestIntegralType
+#define check_expected_uin=
t                   check_expected
+#define expect_uint_value              =
       expect_value
+#define expect_check_data                     expect_c=
heck
+#define cast_ptr_to_cmocka_value(x)           (x)
+#define assert_int=
_in_range(value, min, max)  assert_in_range((value), (min), (max))
+#define=
 assert_uint_in_range(value, min, max) assert_in_range((value), (min), (max=
))
 #endif
 
 /**
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tes=
ts/unit_tests/openvpn/test_misc=2Ec
index aea40f0=2E=2E7405198 100644
--- a=
/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test=
_misc=2Ec
@@ -41,10 +41,34 @@
 #include "mock_msg=2Eh"
 #include "crypto=2E=
h"
 #include "sid_hash=2Eh"
+#include "test_schedule=2Eh"
+#include "multi=
=2Eh"
+
 #ifdef _WIN32
 #include "win32-util=2Eh"
 #endif
-#include "test_s=
chedule=2Eh"
+
+/* extra mocks */
+bool
+apply_push_options(struct context =
*c, struct options *options, struct buffer *buf,
+                   uint64=
_t permission_mask, uint64_t *option_types_found,
+                   struc=
t env_set *es, bool is_update)
+{
+    return true;
+}
+
+bool
+send_contro=
l_channel_string(struct context *c, const char *str, msglvl_t msglevel)
+{
=
+    check_expected_ptr(str);
+    return true;
+}
+
+struct multi_instance=
 *
+lookup_by_cid(struct multi_context *m, const unsigned long cid)
+{
+   =
 return *(m->instances);
+}
 
 static void
 test_compat_lzo_string(void **s=
tate)
diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/unit_tests=
/openvpn/test_ssl=2Ec
index 4baf8cc=2E=2E4987dd0 100644
--- a/tests/unit_te=
sts/openvpn/test_ssl=2Ec
+++ b/tests/unit_tests/openvpn/test_ssl=2Ec
@@ -52=
,6 +52,8 @@
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
 
+#include =
"test_acc=2Eh"
+
 /* Mock function to be allowed to include win32=2Ec which=
 is required for
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6 =
+88,20 @@
 {
     return;
 }
+void
+reschedule_multi_process(struct context=
 *c)
+{
+}
+
+/* Define a dummy dco cipher option to avoid linking against =
all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_su=
pported_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:A=
ES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl=
 req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -=
1111,8 +1127,12 @@
         cmocka_unit_test(ssl_test_extract_last_matching=
_field),
         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
 =
        cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
-     =
   cmocka_unit_test(ssl_test_extract_peer_info)
-
+        cmocka_unit_test=
(ssl_test_extract_peer_info),
+        cmocka_unit_test(test_acc_parse_clie=
nt_messages),
+        cmocka_unit_test(test_parse_acc_parameters),
+      =
  cmocka_unit_test(test_acc_common_protocols),
+        cmocka_unit_test(te=
st_acc_send_message),
+        cmocka_unit_test(test_list_intersection)
   =
  };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)

-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerri=
t-Change-Number: 1858
Gerrit-PatchSet: 16
Gerrit-Owner: Arne Schwabe <arne-=
openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--9Iesq/fCFXA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #16</strong> to this ch=
ange=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?us=
p=3Demail">View Change</a></p><p>The following approvals got outdated and w=
ere removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Impleme=
nt sending/receiving app custom control protocol messages<br><br>This allow=
s openvpn GUI/front-ends and server via management<br>to use the OpenVPN co=
ntrol channel to pass messages between each other<br>while OpenVPN handles =
the marshalling/unmarshalling of these and<br>negotiate the common app cust=
om control protocols=2E<br><br>This provides an easy to use secure channel =
that does not depend on<br>the network itself to work and can also used bef=
ore fully authenticating<br>the client=2E See the management-notes=2Etxt fo=
r more details how to use<br>this feature=2E An upcoming patch will also ad=
d some example python<br>script that showcase this feature=2E<br><br>Change=
-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84<br>Signed-off-by: Arne Schwa=
be &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc/man-sec=
tions/client-options=2Erst<br>M doc/man-sections/management-options=2Erst<b=
r>M doc/man-sections/script-options=2Erst<br>M doc/management-notes=2Etxt<b=
r>M src/openvpn/Makefile=2Eam<br>A src/openvpn/acc=2Ec<br>A src/openvpn/acc=
=2Eh<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvp=
n/manage=2Ec<br>M src/openvpn/manage=2Eh<br>M src/openvpn/multi=2Ec<br>M sr=
c/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2E=
c<br>M src/openvpn/push=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_c=
ommon=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests=
/openvpn/mock_management=2Ec<br>A tests/unit_tests/openvpn/mock_management=
=2Eh<br>M tests/unit_tests/openvpn/mock_push_dependencies=2Ec<br>A tests/un=
it_tests/openvpn/test_acc=2Ec<br>A tests/unit_tests/openvpn/test_acc=2Eh<br=
>M tests/unit_tests/openvpn/test_common=2Eh<br>M tests/unit_tests/openvpn/t=
est_misc=2Ec<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>28 files changed=
, 1,518 insertions(+), 26 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1858/16</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 184a=
95a=2E=2E00caa2d 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><s=
pan>+++ b/CMakeLists=2Etxt</span><br><span>@@ -435,6 +435,8 @@</span><br><s=
pan>     src/compat/compat-strlcpy=2Ec</span><br><span>     src/compat/comp=
at-strsep=2Ec</span><br><span>     src/compat/compat-strtok_r=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Ec</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/acc=2Eh</=
span><br><span>     src/openvpn/argv=2Ec</span><br><span>     src/openvpn/a=
rgv=2Eh</span><br><span>     src/openvpn/base64=2Ec</span><br><span>@@ -571=
,8 +573,8 @@</span><br><span>     src/openvpn/ps=2Ec</span><br><span>     s=
rc/openvpn/ps=2Eh</span><br><span>     src/openvpn/push=2Ec</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    src/openvpn/push_util=2Ec</span><=
br><span>     src/openvpn/push=2Eh</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    src/openvpn/push_util=2Ec</span><br><span>     src/openv=
pn/pushlist=2Eh</span><br><span>     src/openvpn/reflect_filter=2Ec</span><=
br><span>     src/openvpn/reflect_filter=2Eh</span><br><span>@@ -826,7 +828=
,10 @@</span><br><span>             tests/unit_tests/openvpn/mock_managemen=
t=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_ssl_depend=
encies=2Ec</span><br><span>             tests/unit_tests/openvpn/mock_win32=
_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    tests/unit_tests/openvpn/test_acc=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            src/openvpn/acc=2Ec</span><br><span>     =
        src/openvpn/argv=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            src/openvpn/auth_token=2Ec</span><br><span>           =
  src/openvpn/base64=2Ec</span><br><span>             src/openvpn/crypto_ep=
och=2Ec</span><br><span>             src/openvpn/crypto_mbedtls=2Ec</span><=
br><span>@@ -840,8 +845,11 @@</span><br><span>             src/openvpn/opti=
ons_util=2Ec</span><br><span>             src/openvpn/otime=2Ec</span><br><=
span>             src/openvpn/packet_id=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            src/openvpn/reliable=2Ec</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/session_id=
=2Ec</span><br><span>             src/openvpn/run_command=2Ec</span><br><sp=
an>             src/openvpn/ssl_mbedtls=2Ec</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            src/openvpn/ssl_ncp=2Ec</span><br><span=
>             src/openvpn/ssl_openssl=2Ec</span><br><span>             src/=
openvpn/ssl_util=2Ec</span><br><span>             src/openvpn/ssl_verify_mb=
edtls=2Ec</span><br><span>@@ -858,6 +866,8 @@</span><br><span>     target_s=
ources(test_misc PRIVATE</span><br><span>         tests/unit_tests/openvpn/=
mock_get_random=2Ec</span><br><span>         tests/unit_tests/openvpn/test_=
schedule=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 tests/unit_tests/openvpn/mock_management=2Ec</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        src/openvpn/base64=2Ec</span><br><span>  =
       src/openvpn/options_util=2Ec</span><br><span>         src/openvpn/ot=
ime=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec</span><br><span>d=
iff --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client=
-options=2Erst</span><br><span>index 87c138a=2E=2Eb204d6a 100644</span><br>=
<span>--- a/doc/man-sections/client-options=2Erst</span><br><span>+++ b/doc=
/man-sections/client-options=2Erst</span><br><span>@@ -12,6 +12,17 @@</span=
><br><span>   When this option is set, OpenVPN will not drop incoming tun p=
ackets with</span><br><span>   same destination as host=2E</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-custom-contr=
ol protocollist</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Se=
ts the list of supported app custom control protocols=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  These protocols are announced to the=
 server when this option is used</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  as a client=2E If the option is set on a server it will nego=
tiate the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  common p=
rotocols with the client=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The proto=
collist is a : separated list of protocol identifiers=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  See management-notes=2Etxt in the OpenVPN distribution =
and the OpenVPN RFC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  draft for a description of app custom control protocol support=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --auth-to=
ken token</span><br><span>   This is not an option to be used directly in a=
ny configuration files,</span><br><span>   but rather push this option from=
 a ``--client-connect`` script or a</span><br><span>@@ -437,6 +448,12 @@</s=
pan><br><span>         Additional authentication methods supported by the c=
lient=2E</span><br><span>         This may be set by the client UI/GUI usin=
g ``--setenv``=2E</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  :code:`IV_ACC=3D&lt;max_msg_len&gt;,&lt;flags&gt;,&lt;pro=
tocols&gt;`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
If the option ``--app-custom-control`` is set, the client will</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        send the supported max A=
CC message length, the supported formats</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        as (:code:`A:6`) and the list of configured pr=
otocols (e=2Eg=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      :code:`flower:happy:power`)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>   The following flags depend on which compr=
ession formats are compiled in</span><br><span>   and whether compression i=
s allowed by options=2E See `Protocol options`_</span><br><span>   for more=
 details=2E</span><br><span>diff --git a/doc/man-sections/management-option=
s=2Erst b/doc/man-sections/management-options=2Erst</span><br><span>index 2=
c79d05=2E=2Ea7f7ead 100644</span><br><span>--- a/doc/man-sections/managemen=
t-options=2Erst</span><br><span>+++ b/doc/man-sections/management-options=
=2Erst</span><br><span>@@ -144,3 +144,9 @@</span><br><span> </span><br><spa=
n> --management-up-down</span><br><span>   Report tunnel up/down events to =
management interface=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--app-custom-co=
ntrol protocol-list</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  Sets the app custom control protocols that are supported and should be</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  negotiated=2E protoc=
ol-list is a list of allowed protocols separated by :</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  A client will announce these protocols =
via the IV_ACC variable and the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  server will notify the client about the common protocols=2E</=
span><br><span>diff --git a/doc/man-sections/script-options=2Erst b/doc/man=
-sections/script-options=2Erst</span><br><span>index f420380f=2E=2E9c17c3b =
100644</span><br><span>--- a/doc/man-sections/script-options=2Erst</span><b=
r><span>+++ b/doc/man-sections/script-options=2Erst</span><br><span>@@ -100=
6,3 +1006,12 @@</span><br><span>        X509_1_L=3DBISHKEK</span><br><span>=
        X509_1_ST=3DNA</span><br><span>        X509_1_C=3DKG</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+:code:`acc_protocols`</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    If ``--app-custom-control`` is configured and t=
he client supports any of the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    protocols that server also supports, this variable contains a=
 list of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    common =
protocols separated by :=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+:code:`acc_=
message_len`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
:code:`acc_protocols` is set, this variable contains the maximum</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    message length for app cus=
tom protocol message=2E</span><br><span>\ No newline at end of file</span><=
br><span>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Et=
xt</span><br><span>index 4d726c4=2E=2E159d0f5 100644</span><br><span>--- a/=
doc/management-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt=
</span><br><span>@@ -828,6 +828,58 @@</span><br><span> that is required to =
continue the connection (unlike MFA or opening a browser)</span><br><span> =
this message is not negotiated but can just be sent as a gratuitous message=
=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+app custom control</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+If the special string &quot;ACC&quot; i=
s passed as {EXTRA} OpenVPN will determine</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+the common app custom protocols between the client a=
nd the server and instruct</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+the client that the server will send control messages to the client =
using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the ACC protoc=
ol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+The server should then use client=
-acc-msg command to send app custom</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+control messages to the client to facilitate the pending au=
thentication=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- client-acc-m=
sg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+------------------------------------------</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+On an OpenVPN instance running in server mode this command s=
ends an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+app custom c=
ontrol message to a client=2E The format of the command is:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  client-acc-msg {CID} {KID}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  {protocol}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  {flags}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  {message}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+CID,KID -- client ID and Key=
 ID=2E See documentation for &quot;&gt;CLIENT:&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+notification for more info=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+protocol -- the ACC protocol identifier that this =
message should be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          tagged with=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+flags    -- a =
colon separated list of the encoding and the flag if</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            the message is a fragment=2E =
E=2Eg=2E &quot;6:F&quot; for a base64 encoded</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            message that is also a fragment and n=
ot complete yet=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+message  -- The mess=
age encoded in the encoding specified in flags</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+COMMAND -- =
acc-msg (OpenVPN 2=2E8 or higher)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+------------------------------------------</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+When OpenVPN is running in --client mode this command sen=
ds an app</span><br><span style=3D"color: hsl(120, 100%, 40%);">+custom com=
mand to the server=2E The format of the command is</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  acc-msg</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  {protocol}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {fl=
ags}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  {message}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  END</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+See the client-acc-msg command for more details about th=
e format of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mess=
age=2E Since a client has only one peer there is no need to specify the</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+client id and key id=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- client-de=
ny  (OpenVPN 2=2E1 or higher)</span><br><span> ----------------------------=
-------------------</span><br><span> </span><br><span>@@ -1302,6 +1354,39 @=
@</span><br><span>    response=2E Mechanisms that need multiple rounds or m=
ore complex answers</span><br><span>    should implement a different respon=
se type than CR_RESPONSE=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+(6) App custom control message</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    This message is an application specific payload messa=
ge that is transported</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    over the OpenVPN control channel=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    In server mode:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;CLIENT:=
ACC,{CID},{KID},{protocol},{fragment},{msg_base64}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    In client mode:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt=
;ACC:{protocol},{fragment},{msg_base64}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    The protocol is a short ascii string identifying the app specific cust=
om</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocol=2E I=
f fragment is set to 1, the message is not complete and the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    next message should be concaten=
ated to this message to form a complete</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    message=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(7) =
App custom control protocol message</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
This message informs the client about the common ACC</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   protocols and the maximum message leng=
th for an ACC message=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   In client m=
ode:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+   &gt;ACC_PROTOCOLS:protocols=3D{=
protocol_list},message_len=3D{max_msg_len}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+   protocol_list is a list of supported protocols by the client=2E For =
example</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   flower:po=
wer:sys_info would indicate these three protocols to be supported=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   max_msg_len specifies t=
he maximum message length that the peer supports=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   In server mode these are available in the acc_protocols a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   acc_message_le=
n variables of the client environment=2E</span><br><span> </span><br><span>=
 Variables:</span><br><span> </span><br><span>diff --git a/src/openvpn/Make=
file=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 8a60a94=2E=2Eeb=
c4db6 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><spa=
n>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -45,6 +45,7 @@</span><=
br><span> sbin_PROGRAMS =3D openvpn</span><br><span> </span><br><span> open=
vpn_SOURCES =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	a=
cc=2Ec acc=2Eh \</span><br><span> 	argv=2Ec argv=2Eh \</span><br><span> 	au=
th_token=2Ec auth_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</sp=
an><br><span>@@ -124,7 +125,8 @@</span><br><span> 	proto=2Ec proto=2Eh \</s=
pan><br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	push=2Ec push_util=2Ec p=
ush=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push=2Ec =
push=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	push_uti=
l=2Ec \</span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=
=2Ec reflect_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</sp=
an><br><span>diff --git a/src/openvpn/acc=2Ec b/src/openvpn/acc=2Ec</span><=
br><span>new file mode 100644</span><br><span>index 0000000=2E=2E2d2d1f8</s=
pan><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/acc=2Ec</span=
><br><span>@@ -0,0 +1,413 @@</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Open=
VPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
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
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;error=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;forward=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;ssl_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+enum acc_message_flag</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    AC=
C_MESSAGE_FLAGS_ASCII =3D 1,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ACC_MESSAGE_FLAGS_BASE64 =3D 2,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ACC_MESSAGE_FLAGS_FRAGMENT =3D 4,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+log_acc_message(stru=
ct context *c, const struct buffer *buf, int payload_len,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                const char *protocol,=
 int flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    bool fragment =3D flag=
s &amp; ACC_MESSAGE_FLAGS_FRAGMENT;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *payload_msg =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* For simplicity, we always encod=
e payload to be base64 encoded</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     * if not already in base64 format */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; ACC_MESSAGE_FLAGS_ASC=
II)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        char *b64out =3D NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(open=
vpn_base64_encode(CBPTR(buf), payload_len, &amp;b64out) &gt;=3D 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(b64ou=
t, free, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       payload_msg =3D b64out;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        payload_msg =3D CBST=
R(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (management)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct tls_session *session =3D &amp;c-&gt;c2=2Etls=
_multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (c-&gt;options=2Emode =3D=3D MODE_SERVER)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* server mode=2E Report client context */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct man_de=
f_auth_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            unsigned int mda_key_id =
=3D get_primary_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;&gt;C=
LIENT:ACC,%lu,%u,%s,%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                mda-&gt;cid, mda_key_id, protocol, fragment, p=
ayload_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            /* Client mode=2E Do n=
ot a report a CLIENT id */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(M_CLIENT, &quot;&gt;ACC:%s,%d,%s&quot;, protocol, fr=
agment, payload_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef ENAB=
LE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(D_PUSH, &quot;Received custom app control message (protocol &#39;%s&#3=
9;%s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 protocol, fragment ? &quot;, fragment&quot; : &quot;&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  Parses the flags field of =
an app control message and moves the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  buffer past the flags string=2E If there is an</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  error parsing the flags=
 field the method returns -1 and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  puts the error reason in err_reason</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+parse_acc_message_flags(struct buffer *buf, const char **err_reaso=
n, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 *flags =3D buf_extract_field(buf, &#39;,&#39;, gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!flags)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     *err_reason =3D &quot;could not extract flags field&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int a=
cc_flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const char *fl=
ag =3D flags; *flag !=3D &#39;\0&#39;; flag++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (*flag =3D=3D &#39;A&#39;)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_ASCII;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        else if (*flag =3D=3D &#=
39;6&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            acc_fla=
gs |=3D ACC_MESSAGE_FLAGS_BASE64;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        else if (*flag =3D=3D &#39;F&#39;)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            acc_flags |=3D ACC_MESSAGE_FLAGS_FRAGMENT;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            *err_reason =3D &quot;Unknown flag in =
flags&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* The message should be=
 encoded with exactly one encoding=2E Ensure that</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * only one of the flags is present */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool asciienc =3D =
(bool)(acc_flags &amp; ACC_MESSAGE_FLAGS_ASCII);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool base64enc =3D (bool)(acc_flags &amp; =
ACC_MESSAGE_FLAGS_BASE64);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (base=
64enc + asciienc !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
har *tmp =3D gc_malloc(512, 1, gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        snprintf(tmp, 512, &quot;number of encodings must b=
e exactly one &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           &quot;(B64=3D%d, ASCII=3D%d)&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                 base64enc, asc=
iienc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *err=
_reason =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return acc_flags;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct cont=
ext *c, const struct buffer *buffer)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *err_reason =3D &quot;&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* Example message: ACC,muppets,15,A,I am Miss Pi=
ggy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer buf =3D *buffer;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_adva=
nce(&amp;buf, strlen(&quot;ACC&quot;)) || buf_read_u8(&amp;buf) !=3D &#39;,=
&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quo=
t;missing , after ACC&quot;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* extract protocol, p=
ayload length, flags substrings */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *protocol =3D buf_extract_field(&amp;buf, &#3=
9;,&#39;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!protocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_rea=
son =3D &quot;could not extract protocol field&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int payload_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char *payload_len_str =3D buf_extract_field(&amp;buf, &#39;,&#3=
9;, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (!payload_len_str || !((payload_len =3D atoi(payload_len_str))))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        err_reason =3D &quot;could not ex=
tract payload length field&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto err;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int flags =3D par=
se_acc_message_flags(&amp;buf, &amp;err_reason, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (flags &lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* We should have a fina=
l NUL byte in the control message buffer</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * and thus the length of the buffer should be pay=
load_len + 1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (buf_len(&amp;buf) !=3D payload_len + 1)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        char *tmp =3D gc_malloc(512, 1, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tmp, 512, &quot;fi=
eld length %d, payload length %d mismatch&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                 payload_len, buf_len(&amp;buf=
) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        err_=
reason =3D tmp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    log_acc_message(c, &amp;buf, payload_len, protocol, fl=
ags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(D_PUSH_ERRORS, &quot;WARNING: Received malform=
ed custom app control channel &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                       &quot;(%s) message control message:=
 %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
rr_reason,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
ormat_hex(BPTR(&amp;buf), BLEN(&amp;buf), 80, &amp;gc));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct context =
*c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
 struct tls_multi *multi,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                 struct tls_session *session,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 const char *protocol, bo=
ol fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
          const char *msg, bool base64)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * leng=
th of the protocol string + one &#39;,&#39;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * 2 for the encoding (A or 6), potential F (fr=
agment), and 1 for the &#39;,&#39;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * 4 for the message size itself and one comma</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * 1 for the comma befor=
e the message itself */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const size_t max_header_size =3D strlen(&quot;ACC,&quot;) + strlen(=
protocol) + 1 + 4 + 1 + 2 + 1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    size_t len =3D max_header_size + strlen(msg);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (len &gt; TLS_CHANNEL_BUF_SIZE)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;message length (%zu)=
 exceeds maximum possible message length (%d)&quot;, len, TLS_CHANNEL_BUF_S=
IZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if ((int)len &gt; multi-&gt;acc_max_messa=
ge_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &=
quot;header (%zu) + message size (%zu) length (%zu) exceeds &quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                      &quot;=
maximum allowed length negotiated with peer (%d)&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            max_header_size, strlen(msg=
), len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
multi-&gt;acc_max_message_length);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* add 1 for the final \0 */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(len + 1, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Example message: ACC,muppets,15,A,=
I am Miss Piggy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_printf(&amp;buf, &quot;ACC,%s,%zu,%s%s,%s&quot;, protocol,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+               strlen(msg),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+               base64=
 ? &quot;6&quot; : &quot;A&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+               fragment ? &quot;F&quot; : &quot;&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+               msg);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    send_control_channel_string_dowork(se=
ssion, BSTR(&amp;buf), D_PUSH);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    reschedule_multi_process(c);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+char *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+parse_acc_parameters(const=
 char *capabilities,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     const char *delim,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     int *max_acc_len,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     bool server,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *tmp_mes=
sage =3D string_alloc(capabilities, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char *tmp_message_orig =3D tmp_message;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    char *lasts =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *token =3D strtok_r(tmp_me=
ssage, delim, &amp;lasts);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int p =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int accle=
n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *protocols =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char *ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In =
server mode we allow more capabilities than our own, in client</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * mode we reject if we shou=
ld use capabilities that we do not support */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int allowed_acc_len =3D server ? INT_MAX : AC=
C_MAX_MSG_LEN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (token)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 0 &amp;&amp; !atoi_=
constrained(token, &amp;acclen, &quot;ACC message length&quot;, ACC_MIN_MSG=
_LEN, allowed_acc_len, D_PUSH_ERRORS))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            goto done;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=
=3D 1 &amp;&amp; (!tls_item_in_cipher_list(&quot;A&quot;, token) || !tls_it=
em_in_cipher_list(&quot;6&quot;, token)))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App custom control encodin=
g must include base64 and ascii&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            goto done;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (p =3D=3D 1 &amp;&amp; !server &amp;&amp; strcmp(token, &quot;A:6&quot=
;) &amp;&amp; strcmp(token, &quot;6:A&quot;))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(D_PUSH_ERRORS, &quot;App custom control enc=
oding must exactly base64 and ascii&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto done;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (p =3D=3D 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    protocols =3D token;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p =3D=3D 3)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_PUSH_ERRORS,=
 &quot;Too many parameters for INFO ACC message/IV_ACC=2E&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            goto done;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        token =3D strtok_r(NULL, delim, &amp;lasts);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        p++;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    *max_acc_len =3D min_int(acclen, ACC_MAX_MSG_LEN);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D string_alloc(=
protocols, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    free(tmp_message_orig);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct buffer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+g=
et_list_intersection(struct gc_arena *gc, const char *list1, const char *li=
st2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    char *tmp =3D strdup(list1);<=
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
e=3D"color: hsl(120, 100%, 40%);">+        if (tls_item_in_cipher_list(toke=
n, list2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* prot=
ocol is in both server and client list */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (buf_len(&amp;common_protocols) &gt; 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_writ=
e_u8(&amp;common_protocols, &#39;:&#39;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            buf_printf(&amp;common_protocols, &quot;%s&quot=
;, token);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        token =3D s=
trtok_r(NULL, &quot;:&quot;, &amp;lasts);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    free(tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return common_protocols;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+determine_common_acc_protocols(struct tl=
s_multi *multi, struct tls_session *session)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!multi-&gt;opt=2Eacc_protocols)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        /* No app custom protocols have been configured server=
-side=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated_protocols)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* We already have determin=
ed the common protocols=2E Doing this</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+         * again would just add an extra string allocatio=
n to options-&gt;gc */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* example IV_ACC: IV_ACC=3D2048=
,6:A,flower:power */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *peer_info =3D multi-&gt;peer_info;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *iv_acc =3D extract_var_pe=
er_info(peer_info, &quot;IV_ACC=3D&quot;, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!iv_acc)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max_ac=
c_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *protocols =3D parse_acc_parameters(iv_acc, &quot;,&quot;, &amp;max=
_acc_len, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!prot=
ocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_ER=
RORS, &quot;WARNING: IV_ACC peer info variable of peer is malformed&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct buffer common_protocols =3D get_list_intersec=
tion(&amp;gc, session-&gt;opt-&gt;acc_protocols, protocols);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (buf_len(&amp;common_protocols) =3D=3D 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(D_PUSH_DEBUG, &quot;WARNIN=
G: No common app custom control protocol=2E&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    multi-&gt;acc_negotiated_protocols =3D string_alloc(buf_str(&amp;com=
mon_protocols), NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    setenv_str(session-&gt;opt-&gt;es, &quot;acc_protocol=
s&quot;, multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    setenv_int(session-&gt;opt-&gt;es, &quot;acc_=
message_len&quot;, multi-&gt;acc_max_message_length);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/acc=2Eh b/src/o=
penvpn/acc=2Eh</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E4a388f7</span><br><span>--- /dev/null</span><br><span>+++ b/src=
/openvpn/acc=2Eh</span><br><span>@@ -0,0 +1,105 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over =
a single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2025 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  This program is free software; you can redistribute it and=
/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it un=
der the terms of the GNU General Public License version 2</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software=
 Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is di=
stributed in the hope that it will be useful,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the im=
plied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licens=
e for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should =
have received a copy of the GNU General Public License along</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, wri=
te to the Free Software Foundation, Inc=2E,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 021=
10-1301 USA=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#ifndef ACC_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define ACC_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &quot;openvpn=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine ACC_MIN_MSG_LEN 64</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define ACC_MAX_MSG_LEN 1280</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This method parses=
 an app custom control message and delivers it to the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * management interface=2E We leave reass=
embly of fragmented messages to the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * management interface=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param c            The context struct</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param buffer       Buffer containing the co=
ntrol message with ACC</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+receive_acc_message(struct c=
ontext *c, const struct buffer *buffer);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+send_acc_message(struct context =
*c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
 struct tls_multi *tls_multi,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 struct tls_session *session,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                 const char *protocol, =
bool fragment,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
            const char *msg, bool base64);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Parses an info message from =
the server that contains app custom control info</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * information prior to the PUSH_REPLY to be a=
ble to use app custom control</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * protocols before sending</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * In client mode only allow what we support ourselves=2E In server mode</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * allow also capabil=
ities that we not support ourselves=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param capabilities      The string to parse</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param delim             The delimiter to =
use when parsing the string=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *                          IV_ACC uses &quot;,&quot; as delimit=
er while the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
                     custom-control PUSH message uses &quot; &quot; as &quo=
t;,&quot; is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *     =
                     already used to separate different push directives</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param max_acc_len  =
     Set to the maximum ACC message length</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param server            Whether we are server or=
 client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param gc=
                The gc arena to use for allocating the resulting string</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return             =
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
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git a/sr=
c/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 68121=
0d=2E=2E7923b5e 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span>=
<br><span>+++ b/src/openvpn/forward=2Ec</span><br><span>@@ -42,6 +42,7 @@</=
span><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quo=
t;auth_token=2Eh&quot;</span><br><span> #include &quot;tun_afunix=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=
=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2Eh&quo=
t;</span><br><span> </span><br><span>@@ -257,11 +258,11 @@</span><br><span>=
     }</span><br><span>     else if (buf_string_match_head_str(buf, &quot;I=
NFO_PRE&quot;))</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        server_pushed_info(buf, 8);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        server_pushed_info(c, buf, 8);</s=
pan><br><span>     }</span><br><span>     else if (buf_string_match_head_st=
r(buf, &quot;INFO&quot;))</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        server_pushed_info(buf, 4);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        server_pushed_info(c, bu=
f, 4);</span><br><span>     }</span><br><span>     else if (buf_string_matc=
h_head_str(buf, &quot;CR_RESPONSE&quot;))</span><br><span>     {</span><br>=
<span>@@ -271,6 +272,10 @@</span><br><span>     {</span><br><span>         =
receive_auth_pending(c, buf);</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (buf_string_match_head_str(bu=
f, &quot;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        recei=
ve_acc_message(c, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span>     else if (buf_string_match_head_str(buf, &quo=
t;EXIT&quot;))</span><br><span>     {</span><br><span>         receive_exit=
_message(c);</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvp=
n/init=2Ec</span><br><span>index 1b8b2a5=2E=2E031b18b 100644</span><br><spa=
n>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</sp=
an><br><span>@@ -2279,6 +2279,13 @@</span><br><span>         }</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;acc_negotiated=
_protocols)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&am=
p;out, &quot; custom-control %d,A:6,%s&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                   multi-&gt;acc_max_message_leng=
th, multi-&gt;acc_negotiated_protocols);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     if (BLENZ(&amp;out) &gt; strlen(header))</span=
><br><span>     {</span><br><span>         msg(D_HANDSHAKE, &quot;%s&quot;,=
 BSTR(&amp;out));</span><br><span>@@ -2522,6 +2529,11 @@</span><br><span>  =
       flags |=3D (OPT_P_ROUTE | OPT_P_DHCPDNS);</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (c-&gt;options=2Eacc_protocols)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        flags |=3D OPT_P_ACC;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     return flags;</span><br><span> }</span><br><span> </span>=
<br><span>@@ -2730,6 +2742,17 @@</span><br><span>         frame-&gt;tun_mtu=
 =3D min_int(frame-&gt;tun_max_mtu, c-&gt;options=2Ece=2Etun_mtu);</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (found &amp; OPT_P_ACC &amp;&amp; c-&gt;options=2Epushe=
d_acc_negotiated_protocols)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        free(multi-&gt;acc_negotiated_pro=
tocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mul=
ti-&gt;acc_negotiated_protocols =3D string_alloc(c-&gt;options=2Epushed_acc=
_negotiated_protocols, NULL);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        multi-&gt;acc_max_message_length =3D c-&gt;options=2Epush=
ed_acc_max_message_length;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
D_PUSH, &quot;OPTIONS IMPORT: ACC protocols: %s, msg len: %d&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;acc_n=
egotiated_protocols, multi-&gt;acc_max_message_length);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     return true;</span><br><span> }=
</span><br><span> </span><br><span>@@ -3352,6 +3375,7 @@</span><br><span>  =
   to=2Everify_hash_depth =3D options-&gt;verify_hash_depth;</span><br><spa=
n>     to=2Everify_hash_no_ca =3D options-&gt;verify_hash_no_ca;</span><br>=
<span>     memcpy(to=2Ex509_username_field, options-&gt;x509_username_field=
, sizeof(to=2Ex509_username_field));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    to=2Eacc_protocols =3D options-&gt;acc_protocols;</spa=
n><br><span>     to=2Ees =3D c-&gt;c2=2Ees;</span><br><span>     to=2Enet_c=
tx =3D &amp;c-&gt;net_ctx;</span><br><span> </span><br><span>@@ -4306,6 +43=
30,24 @@</span><br><span> }</span><br><span> #endif /* ifdef TARGET_ANDROID=
 */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+manage=
ment_acc_msg(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                   struct buffer_list *input) /* ownership transferred =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct context *c =3D arg;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (buffer_list_defined(input) &a=
mp;&amp; c-&gt;c2=2Etls_multi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        struct tls_session *session =3D =
&amp;multi-&gt;session[TM_ACTIVE];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ret =3D management_send_acc_message(c, multi, session, input);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buffer_list_free(input);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */=
</span><br><span> </span><br><span> void</span><br><span>@@ -4322,6 +4364,7=
 @@</span><br><span>         cb=2Eproxy_cmd =3D management_callback_proxy_c=
md;</span><br><span>         cb=2Eremote_cmd =3D management_callback_remote=
_cmd;</span><br><span>         cb=2Esend_cc_message =3D management_callback=
_send_cc_message;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cb=2Eacc_msg =3D management_acc_msg;</span><br><span> #ifdef TARGET_A=
NDROID</span><br><span>         cb=2Enetwork_change =3D management_callback=
_network_change;</span><br><span> #endif</span><br><span>diff --git a/src/o=
penvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ac3d4b7=2E=
=2E5e4e416 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -45,9 +45,11 @@</span><=
br><span> #include &quot;push=2Eh&quot;</span><br><span> #include &quot;mul=
ti=2Eh&quot;</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</sp=
an><br><span> </span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><=
span> #include &quot;run_command=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;ssl_ncp=2Eh&quot;</span><br><span> </=
span><br><span> #ifdef ENABLE_PKCS11</span><br><span> #include &quot;pkcs11=
=2Eh&quot;</span><br><span>@@ -1081,6 +1083,35 @@</span><br><span>         =
    }</span><br><span>             break;</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        case IEC_CLIENT_ACC_MSG:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (man-&g=
t;persist=2Ecallback=2Eclient_acc_msg)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                bool status =3D (*man-&gt;persist=2Ecallback=
=2Eclient_acc_msg)(man-&gt;persist=2Ecallback=2Earg,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
                             man-&gt;connection=2Ein_extra_cid,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                                       man-&gt;connection=2Ein_extra_kid,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                                                 man-&gt;connection=2Ein_ex=
tra);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  man-&gt;connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                report_command_status(status, &quot;c=
lient-acc-msg&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   man_command_unsupported(&quot;client-acc-msg&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        case IEC_ACC_MSG:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (man-&gt;persist=2Ecallback=2Eacc_msg)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                bool status =3D=
 (*man-&gt;persist=2Ecallback=2Eacc_msg)(man-&gt;persist=2Ecallback=2Earg,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
                                           man-&gt;connection=2Ein_extra);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                man-=
&gt;connection=2Ein_extra =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                report_command_status(status, &quot;acc-msg=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                man_comman=
d_unsupported(&quot;acc-msg&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            break;</span><br><span>         case IEC_PK_SIGN:</sp=
an><br><span>             man-&gt;connection=2Eext_key_state =3D EKS_READY;=
</span><br><span>             buffer_list_free(man-&gt;connection=2Eext_key=
_input);</span><br><span>@@ -1205,6 +1236,29 @@</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+man_client_acc_msg(struct management *man, const char *c=
id_str,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
       const char *kid_str)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 man_connection *mc =3D &amp;man-&gt;connection;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cid =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_kid =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (parse_cid(cid_st=
r, &amp;mc-&gt;in_extra_cid)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &amp;&amp; parse_uint(kid_str, &quot;KID&quot;, &amp;mc-&g=
t;in_extra_kid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mc-&gt;in=
_extra_cmd =3D IEC_CLIENT_ACC_MSG;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        in_extra_reset(mc, IER_NEW);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+man_acc_msg(struct manage=
ment *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *=
mc =3D &amp;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mc-&gt;in_extra_cmd =3D IEC_ACC_MSG;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span> man_client_auth(struct management *m=
an, const char *cid_str, const char *kid_str, const bool extra)</span><br><=
span> {</span><br><span>     struct man_connection *mc =3D &amp;man-&gt;con=
nection;</span><br><span>@@ -1759,6 +1813,17 @@</span><br><span>           =
  man_client_pending_auth(man, p[1], p[2], p[3], p[4]);</span><br><span>   =
      }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else if (streq(p[0], &quot;client-acc-msg&quot;))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (man_need(p, 2, 0))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            man_client_acc_msg(man, p[1],=
 p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;acc-m=
sg&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        man_acc_msg(man=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span>     else if (streq(p[0], &quot;rsa-sig&quot;))</span><br><span>     {=
</span><br><span>         man_pk_sig(man, &quot;rsa-sig&quot;);</span><br><=
span>@@ -2975,7 +3040,9 @@</span><br><span>                                =
        &quot;bytes_sent=3D&quot;,</span><br><span>                        =
                &quot;bytes_received=3D&quot;,</span><br><span>            =
                            &quot;session_id=3D&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                                       &qu=
ot;session_state=3D&quot; };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                       &quot;session_state=3D&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                      &quot;acc_protocols=3D&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                       &q=
uot;acc_message_len=3D&quot; };</span><br><span> </span><br><span>     if (=
env_filter_level =3D=3D 0)</span><br><span>     {</span><br><span>@@ -3130,=
6 +3197,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void=
</span><br><span> management_connection_established(struct management *man,=
 struct man_def_auth_context *mdac,</span><br><span>                       =
            const struct env_set *es)</span><br><span>@@ -4372,6 +4440,64 @=
@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+management_send_acc_message(struct context *c, s=
truct tls_multi *multi, struct tls_session *session,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            struct buffer=
_list *input)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* also ensures that=
 are enough inputs in the list to safely call</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * buffer_list_peek without extra NULL checks=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!input |=
| input-&gt;size &lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_CLIENT, &quot;not enough input lines for sending acc message, &quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
 &quot;missing protocol, flag and/or messages lines&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const struct buffer *proto_buf =3D buffer_list_peek(input);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *protocol=
 =3D string_alloc(CBSTR(proto_buf), &amp;gc);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buffer_list_pop(input);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer *encoding_buf =3D buffer_list_peek(input);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *encoding =
=3D buf_str(encoding_buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const char *flag =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool b64encoding =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    bool fragment =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    while ((flag =3D strsep(&amp;encoding, &quot;:&quot=
;)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(flag, &qu=
ot;6&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b64en=
coding =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else =
if (!strcmp(flag, &quot;F&quot;))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            fragment =3D true;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffe=
r_list_pop(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buffer_list_aggr=
egate_separator(input, 10000, &quot;&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct buffer *acc_msg_buf =3D buffer_li=
st_peek(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;acc_=
negotiated_protocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        || !tls_item_in_cipher_list(protocol, multi-&gt;acc_negotiated_pro=
tocols))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &qu=
ot;protocol not in the list of negotiated protocols: %s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            np(multi-&gt;acc_neg=
otiated_protocols));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D send_acc_messag=
e(c, multi, session, protocol,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                fragment, buf_cstr(acc_msg_buf),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
             b64encoding);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+error:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_f=
ree(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span> #else /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br>=
<span> #include &quot;win32=2Eh&quot;</span><br><span>diff --git a/src/open=
vpn/manage=2Eh b/src/openvpn/manage=2Eh</span><br><span>index 157039d=2E=2E=
cc9c264 100644</span><br><span>--- a/src/openvpn/manage=2Eh</span><br><span=
>+++ b/src/openvpn/manage=2Eh</span><br><span>@@ -184,12 +184,19 @@</span><=
br><span>     int (*n_clients)(void *arg);</span><br><span>     bool (*send=
_cc_message)(void *arg, const char *message, const char *parameter);</span>=
<br><span>     bool (*kill_by_cid)(void *arg, const unsigned long cid, cons=
t char *kill_msg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     bool (*client_auth)(void *arg, const unsigned long cid=
, const unsigned int mda_key_id,</span><br><span>                         c=
onst bool auth, const char *reason, const char *client_reason,</span><br><s=
pan>                         struct buffer_list *cc_config); /* ownership t=
ransferred */</span><br><span>     bool (*client_pending_auth)(void *arg, c=
onst unsigned long cid, const unsigned int kid,</span><br><span>           =
                      const char *extra, unsigned int timeout);</span><br><=
span>     char *(*get_peer_info)(void *arg, const unsigned long cid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool (*client_acc_msg=
)(void *arg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                    const unsigned long cid,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                           const unsigned int mda_=
key_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
               struct buffer_list *msg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool (*acc_msg)(void *arg,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    struct buffer_list *m=
sg);</span><br><span>     bool (*proxy_cmd)(void *arg, const char **p);</sp=
an><br><span>     bool (*remote_cmd)(void *arg, const char **p);</span><br>=
<span> #ifdef TARGET_ANDROID</span><br><span>@@ -292,13 +299,15 @@</span><b=
r><span>     struct command_line *in;</span><br><span>     struct buffer_li=
st *out;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define IEC_UNDEF       0</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define IEC_CLIENT_AUTH 1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define IEC_UNDEF          0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define IEC_CLIENT_AUTH    1</span><br><span> /* #d=
efine IEC_CLIENT_PF   2 *REMOVED FEATURE* */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define IEC_RSA_SIGN    3</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define IEC_CERTIFICATE 4</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define IEC_PK_SIGN     5</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define IEC_PASSWORD    6</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define IEC_RSA_SIGN       3</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_CERTIFICATE =
   4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PK_=
SIGN        5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e IEC_PASSWORD       6</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define IEC_CLIENT_ACC_MSG 7</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define IEC_ACC_MSG        8</span><br><span>     int in_extra_=
cmd;</span><br><span>     struct buffer_list *in_extra;</span><br><span>   =
  unsigned long in_extra_cid;</span><br><span>@@ -503,6 +512,14 @@</span><b=
r><span> </span><br><span> void man_persist_client_stats(struct management =
*man, struct context *c);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/** Parses the ACC message from the input buffer_li=
st and send to the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* session identified by session and multi</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+struct tls_session;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+struct tls_multi;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_=
send_acc_message(struct context *c, struct tls_multi *multi,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                            struct=
 tls_session *session, struct buffer_list *input);</span><br><span> #endif =
/* ifdef ENABLE_MANAGEMENT */</span><br><span> </span><br><span> /**</span>=
<br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span>=
<br><span>index e302a81=2E=2E0ae503d 100644</span><br><span>--- a/src/openv=
pn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@=
 -53,6 +53,7 @@</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><b=
r><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;refle=
ct_filter=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;acc=2Eh&quot;</span><br><span> </span><br><span> /*#define M=
ULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><span>@@ -1735,8 +1736,=
9 @@</span><br><span>  * - peer id</span><br><span>  */</span><br><span> st=
atic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_client=
_set_protocol_options(struct context *c)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+multi_client_set_protocol_options(struct multi_instanc=
e *mi)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct context *c =3D &amp;mi-&gt;context;</span><br><span>     s=
truct tls_multi *tls_multi =3D c-&gt;c2=2Etls_multi;</span><br><span>     c=
onst char *const peer_info =3D tls_multi-&gt;peer_info;</span><br><span>   =
  struct options *o =3D &amp;c-&gt;options;</span><br><span>@@ -2380,7 +238=
2,7 @@</span><br><span>      * peer must be added before iroutes=2E For oth=
er platforms it doesn&#39;t matter=2E */</span><br><span> </span><br><span>=
     /* authentication complete, calculate dynamic client specific options =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!multi_clie=
nt_set_protocol_options(&amp;mi-&gt;context))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!multi_client_set_protocol_options(mi))</=
span><br><span>     {</span><br><span>         mi-&gt;context=2Ec2=2Etls_mu=
lti-&gt;multi_state =3D CAS_FAILED;</span><br><span>     }</span><br><span>=
@@ -4085,6 +4087,26 @@</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const=
 char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+calculate_ap=
p_control_extra(struct multi_instance *mi, struct gc_arena *gc)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct context *c =3D &amp;mi-&gt;context;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct tls_multi *=
multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!multi-&gt;acc_negotiated_protocols)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_CLIENT, &quot;ACC: No negotiated protocols&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1024, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf_printf(&amp;buf, &quot;ACC:%d A:6 %s&qu=
ot;, multi-&gt;acc_max_message_length,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+               multi-&gt;acc_negotiated_protocols);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_str(&amp;=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> mana=
gement_client_pending_auth(void *arg, const unsigned long cid, const unsign=
ed int mda_key_id,</span><br><span>                                const ch=
ar *extra, unsigned int timeout)</span><br><span>@@ -4095,10 +4117,22 @@</s=
pan><br><span>     if (mi)</span><br><span>     {</span><br><span>         =
struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new();</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(extra, &quot=
;ACC&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            extra=
 =3D calculate_app_control_extra(mi, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!extra)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>      =
   struct tls_session *session =3D lookup_session_by_mda_key_id(multi, mda_=
key_id);</span><br><span> </span><br><span>         if (!session)</span><br=
><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          gc_free(&amp;gc);</span><br><span>             return false;</spa=
n><br><span>         }</span><br><span> </span><br><span>@@ -4106,6 +4140,7=
 @@</span><br><span>         bool ret =3D send_auth_pending_messages(multi,=
 session, extra, timeout);</span><br><span>         reschedule_multi_proces=
s(&amp;mi-&gt;context);</span><br><span>         multi_schedule_context_wak=
eup(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
gc_free(&amp;gc);</span><br><span>         return ret;</span><br><span>    =
 }</span><br><span>     return false;</span><br><span>@@ -4149,6 +4184,37 @=
@</span><br><span>     return ret;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+management_client_acc_msg(void *arg,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                          const =
unsigned long cid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                         const unsigned int mda_key_id,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                          struct buffer=
_list *input) /* ownership transferred */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct multi_context *m =3D (struct multi_context *)arg;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance *mi =
=3D lookup_by_cid(m, cid);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret=
 =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
mi &amp;&amp; buffer_list_defined(input))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct tls_multi *multi =3D mi-&gt;context=2Ec2=2Etls_multi=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct tls=
_session *session =3D lookup_session_by_mda_key_id(multi, mda_key_id);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!session)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;=
client session not found&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            buffer_list_free(input);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ret =3D management_send_acc_message(&amp;mi-&gt;context, mul=
ti, session, input);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        multi_schedule_context_wakeup(m, mi);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
ffer_list_free(input);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static char *</span>=
<br><span> management_get_peer_info(void *arg, const unsigned long cid)</sp=
an><br><span> {</span><br><span>@@ -4185,6 +4251,7 @@</span><br><span>     =
    cb=2En_clients =3D management_callback_n_clients;</span><br><span>     =
    cb=2Ekill_by_cid =3D management_kill_by_cid;</span><br><span>         c=
b=2Eclient_auth =3D management_client_auth;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cb=2Eclient_acc_msg =3D management_client_a=
cc_msg;</span><br><span>         cb=2Eclient_pending_auth =3D management_cl=
ient_pending_auth;</span><br><span>         cb=2Eget_peer_info =3D manageme=
nt_get_peer_info;</span><br><span>         cb=2Epush_update_broadcast =3D m=
anagement_callback_send_push_update_broadcast;</span><br><span>diff --git a=
/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index fb=
319ae=2E=2E04b553e 100644</span><br><span>--- a/src/openvpn/options=2Ec</sp=
an><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -35,6 +35,7 @=
@</span><br><span> </span><br><span> #include &quot;syshead=2Eh&quot;</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;acc=2Eh&quot;</span><br><span> #include &quot;buffer=2Eh&quot;</spa=
n><br><span> #include &quot;error=2Eh&quot;</span><br><span> #include &quot=
;common=2Eh&quot;</span><br><span>@@ -7107,6 +7108,41 @@</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&=
gt;force_key_material_export =3D true;</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;ap=
p-custom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;acc_proto=
cols =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(=
p[0], &quot;custom-control&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp=
; p[3] &amp;&amp; !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        V=
ERIFY_PERMISSION(OPT_P_ACC);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 check if the list from the server is a real subset of our list */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct buffer common_list =3D get_list_intersection(&amp;gc, p[3], option=
s-&gt;acc_protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (buf_l=
en(&amp;common_list) =3D=3D 0 || !streq(p[3], buf_cstr(&amp;common_list)))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quo=
t;App custom control list from server contains &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                          &quot;unsupport=
ed protocols&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (!streq(p[2], &quot;A:6&quot;) &amp;&amp; !streq(p[2], &quot;6:A&quot;))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot=
;App custom control encoding must be base64 and ascii&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;pushed_=
acc_max_message_length,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                              &quot;app custom message message length&q=
uot;, ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            goto err;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        options-&gt;pushed_acc_negotiated_protocols =3D p[3];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n>     else if (streq(p[0], &quot;prng&quot;) &amp;&amp; p[1] &amp;&amp; !p=
[3])</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;NOTI=
CE: --prng option ignored (SSL library PRNG is used)&quot;);</span><br><spa=
n>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br>=
<span>index 6a3bf61=2E=2Eb7945e0 100644</span><br><span>--- a/src/openvpn/o=
ptions=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@=
 -715,6 +715,18 @@</span><br><span>     /* force using TLS key material exp=
ort for data channel key generation */</span><br><span>     bool force_key_=
material_export;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /** The app custom control protocols we should announce =
as supported */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const char *acc_protocols;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the =
protocols that are negotiated with the peer=2E This is a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     *  a temporary variable since opt=
ions=2Ec push parser cannot access</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     *  tls multi struct */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const char *pushed_acc_negotiated_protocols;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC cont=
rol channel message via push message</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int pushed_acc_max_message_length;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     bool vlan_tagging;</span><b=
r><span>     enum vlan_acceptable_frames vlan_accept;</span><br><span>     =
uint16_t vlan_pvid;</span><br><span>@@ -764,8 +776,10 @@</span><br><span> #=
define OPT_P_INLINE          (1u &lt;&lt; 29)</span><br><span> #define OPT_=
P_PUSH_MTU        (1u &lt;&lt; 30)</span><br><span> #define OPT_P_ROUTE_TAB=
LE     (1u &lt;&lt; 31)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OPT_P_ACC             (1ull &lt;&lt; 32)</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define OPT_P_DEFAULT (~(O=
PT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* Options allowed in the normal con=
figuration file (vs pushed options or in ccd files) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE =
| OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))</span><br><span> </span><br=
><span> #define PULL_DEFINED(opt) ((opt)-&gt;pull)</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><b=
r><span>index 42259c3=2E=2Edf05746 100644</span><br><span>--- a/src/openvpn=
/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -27=
,6 +27,8 @@</span><br><span> #include &quot;syshead=2Eh&quot;</span><br><sp=
an> </span><br><span> #include &quot;push=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;acc=2Eh&quot;</span><br><span> #include &quot=
;options=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&quot;</span><=
br><span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -221,9 +223,56 @@=
</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+parse_server_pushed_info_acc(struct conte=
xt *c, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int max=
_acc_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!multi-&gt;opt=2Eacc_protocols)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;Server tried to push app =
custom control list &quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                           &quot;without client announcing support f=
or it&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* example string to parse: ACC:1400 =
A:6 flower:happy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Skip over the ACC: prefix */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    buf_advance(buf, 4);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *protocols =3D parse_acc_parameters(buf_c=
str(buf), &quot; &quot;, &amp;max_acc_len, false, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!protocols)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;WARNING: Receive=
d ACC info command with invalid parameters&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 check if the list from the server is a real subset of our list */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer common_lis=
t =3D get_list_intersection(&amp;gc, protocols, multi-&gt;opt=2Eacc_protoco=
ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;common_list) =
=3D=3D 0 || !streq(protocols, buf_cstr(&amp;common_list)))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(D_PUSH_ERRORS, &quot;App custom contro=
l list from server contains &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                           &quot;unsupported protocols&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    multi-&gt;acc_negotiated_protocols =3D strin=
g_alloc(protocols, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    multi-&gt;acc_max_message_length =3D max_acc_len;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (management)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        msg(M_CLIENT, &quot;&gt;ACC_PROTOCOLS:protocols=3D%s,me=
ssage_len=3D%d&quot;, protocols, max_acc_len);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-server_pushed_info(const struct buffer *buffer, const=
 int adv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+server_pus=
hed_info(struct context *c, const struct buffer *buffer, const int adv)</sp=
an><br><span> {</span><br><span>     const char *m =3D &quot;&quot;;</span>=
<br><span>     struct buffer buf =3D *buffer;</span><br><span>@@ -233,6 +28=
2,12 @@</span><br><span>         m =3D BSTR(&amp;buf);</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (strncmp(m, &quot;ACC:&quot;, 4) =3D=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        parse_server_pushed_info_acc(c, &amp;buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</s=
pan><br><span>     struct gc_arena gc;</span><br><span>     if (management)=
</span><br><span>@@ -285,6 +340,7 @@</span><br><span>     msg(D_PUSH, &quot=
;CR response was sent by client (&#39;%s&#39;)&quot;, m);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> /**</span><br><span>  * Parse the keyword for the AUTH_PE=
NDING request</span><br><span>  * @param buffer                buffer conta=
ining the keywords, the buffer&#39;s</span><br><span>@@ -441,7 +497,6 @@</s=
pan><br><span>     const char *const peer_info =3D tls_multi-&gt;peer_info;=
</span><br><span>     unsigned int proto =3D extract_iv_proto(peer_info);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     /* Calculate the maximum timeout and subtract the time we =
already waited */</span><br><span>     unsigned int max_timeout =3D</span><=
br><span>         max_uint(tls_multi-&gt;opt=2Erenegotiate_seconds / 2, tls=
_multi-&gt;opt=2Ehandshake_window);</span><br><span>@@ -732,6 +787,12 @@</s=
pan><br><span>                 client_max_mtu, o-&gt;ce=2Etun_mtu, o-&gt;ce=
=2Etun_mtu);</span><br><span>         }</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (tls_multi-&gt;acc_negotiated_protocols)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        push_option_fmt(gc, push_list=
, M_USAGE, &quot;custom-control %d A:6 %s&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        tls_multi-&gt;acc_max_=
message_length, tls_multi-&gt;acc_negotiated_protocols);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><sp=
an> </span><br><span> static bool</span><br><span>diff --git a/src/openvpn/=
push=2Eh b/src/openvpn/push=2Eh</span><br><span>index 39302f6=2E=2Eb6695bc =
100644</span><br><span>--- a/src/openvpn/push=2Eh</span><br><span>+++ b/src=
/openvpn/push=2Eh</span><br><span>@@ -52,6 +52,7 @@</span><br><span> </span=
><br><span> int process_incoming_push_request(struct context *c);</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /**</span><br><span>  * @brief Handles the receiving of a push-updat=
e message and applies updates to the specified</span><br><span>  * options=
=2E</span><br><span>@@ -92,7 +93,7 @@</span><br><span> </span><br><span> vo=
id receive_exit_message(struct context *c);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void server_pushed_info(const struc=
t buffer *buffer, const int adv);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void server_pushed_info(struct context *c, const struct buffe=
r *buffer, const int adv);</span><br><span> </span><br><span> void receive_=
cr_response(struct context *c, const struct buffer *buffer);</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec<=
/span><br><span>index 086a6fc=2E=2Ee84d32d 100644</span><br><span>--- a/src=
/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>=
@@ -55,6 +55,7 @@</span><br><span> </span><br><span> #include &quot;crypto_=
epoch=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;acc=2Eh&quot;</spa=
n><br><span> #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include =
&quot;ssl_backend=2Eh&quot;</span><br><span> #include &quot;ssl_ncp=2Eh&quo=
t;</span><br><span>@@ -1279,6 +1280,7 @@</span><br><span>     free(multi-&g=
t;locked_cn);</span><br><span>     free(multi-&gt;locked_username);</span><=
br><span>     free(multi-&gt;locked_original_username);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    free(multi-&gt;acc_negotiated_proto=
cols);</span><br><span> </span><br><span>     cert_hash_free(multi-&gt;lock=
ed_cert_hash_set);</span><br><span> </span><br><span>@@ -2117,6 +2119,11 @@=
</span><br><span>                     }</span><br><span>                 }<=
/span><br><span>             }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (session-&gt;opt-&gt;acc_protocols)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                buf_printf(&amp;out, &quot;IV_ACC=3D%d,6:A=
,%s\n&quot;, ACC_MAX_MSG_LEN, session-&gt;opt-&gt;acc_protocols);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
>         }</span><br><span>     }</span><br><span> </span><br><span>@@ -23=
98,6 +2405,8 @@</span><br><span>         multi-&gt;remote_ciphername =3D st=
ring_alloc(&quot;none&quot;, NULL);</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    determine_comm=
on_acc_protocols(multi, session);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     if (username_len &lt; 0 || password_len=
 &lt; 0)</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, =
&quot;TLS Error: Username (%d) or password (%d) too long&quot;, abs(usernam=
e_len),</span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openv=
pn/ssl_common=2Eh</span><br><span>index 9a55ead=2E=2E436770b 100644</span><=
br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn=
/ssl_common=2Eh</span><br><span>@@ -457,6 +457,9 @@</span><br><span>     si=
ze_t ekm_size;</span><br><span> </span><br><span>     bool dco_enabled; /**=
&lt; Whether keys have to be installed in DCO or not */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /** The app custom control protocols we should announc=
e as supported */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *acc_protocols;</span><br><span> };</span><br><span> </span><b=
r><span> /** @addtogroup control_processor</span><br><span>@@ -730,6 +733,1=
2 @@</span><br><span>     int dco_peer_id;</span><br><span> </span><br><spa=
n>     dco_context_t *dco;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** the =
protocols that are negotiated with the peer=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *acc_negotiated_protocols;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /** the maximum length of an ACC control cha=
nnel message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int acc_max_message_length;</span><br><span> };</span><br><span> </span><br=
><span> /**  gets an item  of \c key_state objects in the</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openv=
pn/Makefile=2Eam</span><br><span>index 43a6743=2E=2E86326af 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/=
tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -107,10 +107,12 @=
@</span><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =
=3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span> ssl_testdriver=
_SOURCES =3D test_ssl=2Ec \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	test_acc=2Ec test_acc=2Eh \</span><br><span> 	mock_msg=2Ec mock_ms=
g=2Eh test_common=2Eh \</span><br><span> 	mock_management=2Ec \</span><br><=
span> 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \</span><br><span> 	=
$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/acc=2Ec \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/=
src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \</span><br><span>@@ -132,6 +134,7 @@</span><br><span> 	$(top_srcdir)/=
src/openvpn/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/s=
sl_openssl=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_mbedtls=2E=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/s=
rc/openvpn/ssl_ncp=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_ut=
il=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_verify_openssl=2Ec \</sp=
an><br><span>@@ -392,9 +395,11 @@</span><br><span> </span><br><span> misc_t=
estdriver_SOURCES =3D test_misc=2Ec \</span><br><span> 	test_schedule=2Ec t=
est_schedule=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
mock_management=2Ec mock_management=2Eh \</span><br><span> 	mock_msg=2Ec te=
st_common=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><span> 	=
$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/options_util=2Ec \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/ssl_util=2Ec \</span><br><span>@@ -407,6 +412,7 @@</span><br><span> 	$=
(top_srcdir)/src/openvpn/siphash_reference=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/session_id=2Ec</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> push_update_msg_testdriver=
_CFLAGS =3D -I$(top_srcdir)/src/openvpn \</span><br><span> 	-I$(top_srcdir)=
/src/compat \</span><br><span> 	-I$(top_srcdir)/tests/unit_tests/openvpn \<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b=
/tests/unit_tests/openvpn/mock_management=2Ec</span><br><span>index fff4c2b=
=2E=2Ef572dbb 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_ma=
nagement=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_management=
=2Ec</span><br><span>@@ -29,6 +29,7 @@</span><br><span> </span><br><span> #=
include &quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span> =
#include &quot;manage=2Eh&quot;</span><br><span> </span><br><span> #ifdef E=
NABLE_MANAGEMENT</span><br><span>diff --git a/tests/unit_tests/openvpn/mock=
_management=2Eh b/tests/unit_tests/openvpn/mock_management=2Eh</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000=2E=2E80dcfc2</span><=
br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/mock_=
management=2Eh</span><br><span>@@ -0,0 +1,29 @@</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a s=
ingle UDP port, with support for SSL/TLS-based</span><br><span style=3D"col=
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
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef MOCK_MANAGEMENT_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define MOCK_MANAGEMENT_H</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void init_mock_manageme=
nt(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void uninit_mock_management(v=
oid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tests/o=
penvpn/mock_push_dependencies=2Ec</span><br><span>index bf2ccf3=2E=2Ef083f8=
9 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_push_dependenc=
ies=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_push_dependenci=
es=2Ec</span><br><span>@@ -43,7 +43,8 @@</span><br><span>     uint64_t flag=
s =3D OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS</span=
><br><span>                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIME=
R | OPT_P_COMP | OPT_P_PERSIST</span><br><span>                      | OPT_=
P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                     | OPT_P_PE=
ER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P_=
PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                     | OPT_P=
_ACC;</span><br><span>     return flags;</span><br><span> }</span><br><span=
> </span><br><span>diff --git a/tests/unit_tests/openvpn/test_acc=2Ec b/tes=
ts/unit_tests/openvpn/test_acc=2Ec</span><br><span>new file mode 100644</sp=
an><br><span>index 0000000=2E=2Ea41fa63</span><br><span>--- /dev/null</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_acc=2Ec</span><br><span>@@ -=
0,0 +1,339 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             over a single TCP/UDP port, with support f=
or SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            session authentication and key exchange,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet =
authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             packet compression=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2025 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2025 Arne Schw=
abe &lt;arne@rfc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fre=
e software; you can redistribute it and/or modify</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pub=
lic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  as published by the Free Software Foundation=2E</span><br><span style=
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
);">+ *  with this program; if not, write to the Free Software Foundation, =
Inc=2E,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Frank=
lin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshe=
ad=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdio=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;string=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;acc=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;test_acc=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+char control_channel_mesage_sent[2048];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* Mock functions */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+send_control_channel_string_dowork(struct tls_session *sess=
ion,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                    const char *str, unsigned int msglevel)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_in_range(strlen(str), 0, 2048);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    memcpy(control_channel_mesage_sent, str, =
strlen(str));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+send_push_reply_auth_token(struct tls_multi *multi)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_set_client_reason(s=
truct tls_multi *multi, const char *reason)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define MSG_PAYLOAD &quot;FgMBA=
RkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM&quot;                \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &quot;r4engpg/cDg=
S48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    &quot;4md4OJwoQAwEwIT=
AxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP&quot; \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &quot;AJwBnwArAFAA5wAnAEwAz=
AQAAnP8BAAEAAAsABAMAAQIACgAWABQAH&quot; \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &quot;QAXAB4AGQAYAQABAQECAQMBBAAW=
AAAAFwAAAA0AMAAuBAMFAwYDCAc&quot; \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    &quot;ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEG=
AQMDAwEDAgQCBQIGAgArA&quot; \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    &quot;AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2=
FsxOfOIV4gn/NyJ&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    &quot;93rQwityP9eKSijXgcQ=3D=3D&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_acc_parse_client_messages(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    skip();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* ensure that the messages get to mock_msg */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    x_debug_level =3D 3;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    management =3D (void *)0x12345678;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena =
gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* contains a TLS =
1=2E3 ClientHello */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char msg[] =3D &quot;ACC,cck1,384,6,&quot; MSG_PAYLOAD;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer msg_buf;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct context c =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    c=2Eoptions=2Emode =3D M=
ODE_SERVER;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c=2E=
c2=2Etls_multi, struct tls_multi, &amp;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;c=2Ec2=2E=
tls_multi-&gt;opt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   c=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Eopt-&gt;mda_context =3D &amp=
;c=2Ec2=2Emda_context;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    buf_set_read(&amp;msg_buf, (void *)msg, sizeof(msg));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &a=
mp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mo=
ck_msg_buf, &quot;Received custom app control message (protocol &#39;cck1&#=
39;)&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:ACC,0,0,cck1,0,&quot;=
 MSG_PAYLOAD);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char flower_ms=
g[] =3D &quot;ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAA=
A=3D=3D&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
uf_set_read(&amp;msg_buf, (void *)flower_msg, sizeof(flower_msg));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp=
;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(mock_msg_buf, &quot;Received custom app control mess=
age (protocol &#39;flower&#39;)&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;C=
LIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managment_buf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char msg_=
incorrect_len[] =3D &quot;ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJt=
c2ciOiAiSSBhbSAAS2VybWl0IiB9Ig=3D=3D&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)msg_incorrec=
t_len, sizeof(msg_incorrect_len));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const char *error =3D &quot;W=
ARNING: Received malformed custom app control channel &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        &quot;(fie=
ld length 62, payload length 64 mismatch) message &quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        &quot;control =
message: 496e7367 496d316c 496a6f67 496d5a79 &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;62326369 4c=
434141 65475a6d 2f534a7[more=2E=2E=2E]&quot;;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(mock_msg_buf, error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managment_bu=
f, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_managm=
ent_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char msg_fragment[] =3D &quot;ACC,power,12,6F,aGVsbG8gdw=3D=3D&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(&amp;msg=
_buf, (void *)msg_fragment, sizeof(msg_fragment));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(mock_msg_buf, &quot;Received custom app control message (protocol &#=
39;power&#39;, fragment)&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(mock_managment_buf, &quot;&gt;CLIENT:A=
CC,0,0,power,1,aGVsbG8gdw=3D=3D&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    CLEAR(mock_managment_buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* check two encoding present */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char flower_msg_two_encs[] =3D &quot=
;ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(=
&amp;msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    receive_acc_messag=
e(&amp;c, &amp;msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D =
&quot;WARNING: Received malformed custom app control channel (number of &qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;encodings must be exactly one (B64=3D1, ASCII=3D1)) message control &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;=
message: 53534268 62534141 4945746c 636d3170 6443442f 2f534230 &quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;6147556=
7 37372b3[more=2E=2E=2E]&quot;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(mock_msg_buf, error);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_managmen=
t_buf, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no encodin=
g present */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char flower_msg_no_encs[] =3D &quot;ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//=
SB0aGUg77+94oCPZnJvZyEAAA=3D=3D&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_set_read(&amp;msg_buf, (void *)flower_msg_no_enc=
s, sizeof(flower_msg_no_encs));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    receive_acc_message(&amp;c, &amp;msg_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    error =3D &quot;WARNING: Received malformed custom =
app control channel (number of &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;encodings must be exactly one (B64=3D0,=
 ASCII=3D0)) message control &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;message: 53534268 62534141 4945746c 636d3=
170 6443442f 2f534230 &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;61475567 37372b3[more=2E=2E=2E]&quot;;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_=
msg_buf, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_string_equal(mock_managment_buf, &quot;&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    x_debug_level =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    management =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_parse_acc_parameters(void **sta=
te)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new(=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* parameters=
 to INFO message */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *info_acc_msg =3D &quot;4096 A:6 flower:happy&quot;;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int max_len =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *protocols =3D parse_acc_p=
arameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(pr=
otocols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(max_len, 1280);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* a client does not accept a length longer than it supp=
orts */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    protocol=
s =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, false=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* message with=
 lower limit than our, should work for client and server */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;1111 A:6=
 flower:happy&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    protocols =3D parse_acc_parameters(info_acc_msg, &quot; &quot;, &amp;m=
ax_len, false, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(protocols, &quot;flower:happy&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(max_len=
, 1111);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_pa=
rameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(pro=
tocols, &quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(max_len, 1111);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* more encodings than supported=2E Server should be oka=
y, client should fail */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    info_acc_msg =3D &quot;1200 A:6:B flower:happy&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_para=
meters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parameters(=
info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(protocols, &=
quot;flower:happy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(max_len, 1200);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* extra parameter */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    info_acc_msg =3D &quot;1400 A:6 flower:happy 77&quot;;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_ac=
c_parameters(info_acc_msg, &quot; &quot;, &amp;max_len, true, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protoco=
ls);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_parame=
ters(info_acc_msg, &quot; &quot;, &amp;max_len, false, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
;,&quot;, &amp;max_len, true, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_null(protocols);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* non-numerical protocol length */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    info_acc_msg =3D &quot;abff A:6 flower:hap=
py 77&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pro=
tocols =3D parse_acc_parameters(info_acc_msg, &quot;,&quot;, &amp;max_len, =
true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_null(protocols);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-nume=
rical protocol length */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    info_acc_msg =3D &quot;abff A:6 flower:happy 77&quot;;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    protocols =3D parse_acc_par=
ameters(info_acc_msg, &quot;,&quot;, &amp;max_len, true, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(protocols);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_acc_commo=
n_protocols(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct m=
ulti_instance mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct context *c =3D &amp;mi=2Econtext;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Egc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(c-&gt;c2=2Etls_mul=
ti, struct tls_multi, &amp;c-&gt;options=2Egc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    c-&gt;c2=2Etls_multi-&gt;peer_info =3D &quot;IV_PROTO=3D4321\n=
IV_ACC=3D1400,A:6,flower:happy:power&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    c-&gt;options=2Eacc_protocols =3D &quot;power:f=
lower:star&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct tls_multi *multi =3D c-&gt;c2=2Etls_multi;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Eacc_protocols =3D c-&=
gt;options=2Eacc_protocols;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    multi-&gt;session[TM_ACTIVE]=2Eopt =3D &amp;multi-&gt;opt;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi-&gt;opt=2Ees =
=3D env_set_create(&amp;c-&gt;options=2Egc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    determine_common_acc_protocols(multi, &amp;c-&gt;c2=2Etls_multi-&=
gt;session[TM_ACTIVE]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(multi-&gt;acc_max_message_length, ACC_MAX_MSG_LEN);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(multi-&gt;acc=
_negotiated_protocols, &quot;power:flower&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(env_set_get(multi-&gt;opt=2Ees, &quot;ac=
c_protocols&quot;), &quot;acc_protocols=3Dpower:flower&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(env_set_=
get(multi-&gt;opt=2Ees, &quot;acc_message_len&quot;), &quot;acc_message_len=
=3D1280&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
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
_string_equal(control_channel_mesage_sent,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        &quot;ACC,emergency,50,AF,EM=
ERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, ses=
sion, &quot;emergency&quot;, false,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                           &quot;THE GOVERNMENT HAS ISSUED =
A RAINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ret);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(control_chan=
nel_mesage_sent,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     &quot;ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A R=
AINBOW COLOURED ALERT FOR YOUR AREA=2E&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* test=
 a long message (&gt; 1000) with fragment to get the maximum header size */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char long_messa=
ge[1200] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
0; i &lt; 1024; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        long_=
message[i] =3D (char)(&#39; &#39; + (i % 95));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 last char of the message is a i and then a \0 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(long_message[1023], &#39=
;i&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(long_message[1024], &#39;\0&#39;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    ret =3D send_acc_message(c, c-&gt;c2=2Etls_multi, session, &quot=
;emergency&quot;, true,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                           long_message, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(ret);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    size_t cc_len =3D strlen(control_channel_mesage_sent);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(control_channel_mesage_sent[cc_len - 1], &#39;i&#39;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *expected_start_cc =3D =
&quot;ACC,emergency,1024,AF, !\&quot;#$%&amp;&#39;()*+,-=2E/012345&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equ=
al(control_channel_mesage_sent, expected_start_cc, sizeof(expected_start_cc=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;c-&gt;options=2Egc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_list_intersection(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const char *empty =3D &quot;&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const char *protos =3D &quot;power:flower:emer=
gency&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D=
 gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t1 =3D get=
_list_intersection(&amp;gc, empty, protos);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(buf_len(&amp;t1), 0);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer t2 =3D get_list_intersection(=
&amp;gc, protos, empty);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(buf_len(&amp;t2), 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer t3 =3D get_list_intersection(&amp;gc, protos, pr=
otos);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(buf_cstr(&amp;t3), protos);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *protos2 =3D &quot;flower:emergency:power:mario&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t4 =3D =
get_list_intersection(&amp;gc, protos2, protos);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t4), &qu=
ot;flower:emergency:power&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *protos3 =3D &quot;super:paper:mario:flower&quot;;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer t5 =3D get_list_=
intersection(&amp;gc, protos2, protos3);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(buf_cstr(&amp;t5), &quot;flowe=
r:mario&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_acc=2Eh b/tests/unit_tests/openvpn/=
test_acc=2Eh</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2E32421fb</span><br><span>--- /dev/null</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_acc=2Eh</span><br><span>@@ -0,0 +1,35 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunn=
el IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          over a single UDP port, with support for SSL/TLS-based</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             session authent=
ication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             packet encryption, packet authentication, and</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compre=
ssion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 =
OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is free software; you can redistribute it and/or modify=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the te=
rms of the GNU General Public License version 2</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundatio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed =
in the hope that it will be useful,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more=
 details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_ACC_H</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define TEST_ACC_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void test_acc_parse_client_messages(void=
 **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void test_parse_acc_paramete=
rs(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_common_=
protocols(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_acc_=
send_message(void **state);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_l=
ist_intersection(void **state);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_common=2Eh b/tests/unit_tests/openvpn/test_common=2Eh</span><br><span>in=
dex 8db4ea6=2E=2Ec865142 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_common=2Eh</span><br><span>+++ b/tests/unit_tests/openvpn/test_com=
mon=2Eh</span><br><span>@@ -43,11 +43,13 @@</span><br><span> #define Larges=
tIntegralType uintmax_t</span><br><span> #endif</span><br><span> /* redefin=
e 2=2Ex API in terms of 1=2Ex API */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#define CMockaValueData             LargestIntegralType</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define check_expected_uin=
t         check_expected</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define expect_uint_value           expect_value</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define expect_check_data           expect_=
check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define cast_ptr=
_to_cmocka_value(x) (x)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define CMockaValueData                       LargestIntegralType</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define check_expected_ui=
nt                   check_expected</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define expect_uint_value                     expect_value<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_check=
_data                     expect_check</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define cast_ptr_to_cmocka_value(x)           (x)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define assert_int_in_rang=
e(value, min, max)  assert_in_range((value), (min), (max))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define assert_uint_in_range(value, =
min, max) assert_in_range((value), (min), (max))</span><br><span> #endif</s=
pan><br><span> </span><br><span> /**</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</spa=
n><br><span>index aea40f0=2E=2E7405198 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_misc=2Ec</span><br><span>@@ -41,10 +41,34 @@</span><br><span> #inc=
lude &quot;mock_msg=2Eh&quot;</span><br><span> #include &quot;crypto=2Eh&qu=
ot;</span><br><span> #include &quot;sid_hash=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_schedule=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #ifdef _WIN32</span><br><span> #include &quot;win32-util=2Eh&quot;=
</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#include &quot;test_schedule=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* extra mocks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+apply_push_opt=
ions(struct context *c, struct options *options, struct buffer *buf,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                   uint64_=
t permission_mask, uint64_t *option_types_found,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                   struct env_set *es, bool is=
_update)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+send_cont=
rol_channel_string(struct context *c, const char *str, msglvl_t msglevel)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(str);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+struct multi_instance *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+lookup_by_cid(struct multi_context *m, const unsigned long cid)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return *(m-&gt;instances);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br=
><span> static void</span><br><span> test_compat_lzo_string(void **state)</=
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
"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojoc=
aru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>

</body></html>
--9Iesq/fCFXA=--


--===============8928659501275689304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8928659501275689304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8928659501275689304==--

