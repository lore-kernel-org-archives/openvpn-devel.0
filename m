Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6067F606A59A
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T1Vx2BVO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I8BJC2OK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Nnutby9w;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xdu1KmC/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MFqLwA6skmSXQT9cu52LYlB+jvdCmgEFZq1xs38Tq4I=; b=T1Vx2BVOy95t/oLrPPdFHdOn4v
	vanw4g+Kld0Vx5rqRYGnJPVzNjUeaD4ziselRiq0QA88FXsi4y/QK6M1fJz3LqzXPNRiLSpgA5eza
	0YdMTym70Rp/y+zuOD290s+B09DixGCF+gTePiJoR37Xmlyfkogr5oXTnn5VlGL95nIw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNuRJ-000000005mF-1Rkx;
	Mon, 02 Nov 2026 15:59:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNuRH-000000005m0-35lK
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:59:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0mh26+FiDypJASUKHQJSKT+6VRpbGLaFEPCS5IrsMTA=; b=I8BJC2OKuDSixBAbebonAf3myO
 O9m9GeFDPpLB/pEHC73Lab6y+LtRlZabW4Coj4VWm6tpGnA6wsDYRb9cvK3mWp2svz6ELLKAaUT7q
 yuqCkyBewUPEFSqpVrBqK33wo+HIH5JJQj97Ye/9HIPYaKVKpDDKf24GY1XSfFEd/tFA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0mh26+FiDypJASUKHQJSKT+6VRpbGLaFEPCS5IrsMTA=; b=Nnutby9wbhtqJDvrI0qzNa8Gnh
 wNbe6r6txtHpw3GQvKT+MEAQ4AIR9Iv9g21chFsO1Rmg7iI4nkAMHQPHzwOzQmzNL9MUNUWuIWTMd
 i29OXaER8cmHb8ofFl3eO0eld17eOYSPm9aXETesq2wgsDm72BPe41/Tk018uyGmbkQA=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNuRG-000000004SS-47C7 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 15:59:15 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso1940538f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 07:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793635148; x=1794239948; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0mh26+FiDypJASUKHQJSKT+6VRpbGLaFEPCS5IrsMTA=;
 b=Xdu1KmC/lu00QGlAfZrAIAAvPUof4DNo/JSCWSw0Iw4KKZ+IReSgoupJIIKS7oS262
 fwwW1ohv6Ar6KCP2VU5xYC00DYNkn93hlAWAxXze/Wf5BXzrAUhqSTtiUvmrKXMntzNA
 HKaxklrQNmHv1ADqLC/1pkkfGwUciCWMkhG/oE5pCvsx495MF2AUDhFZ/GFtuNM52Hm2
 RHdryVdi+Kc4QzsaB+cQtqOElBByhlfgNS4V7Gewq9hOKBEq1yZo2eF6cRNlTwXg5YST
 zJH/keuDLmu1HkZfZtHC6wJ8GTYkA69Tn1QofI68Xlcg4+2C1pGbVmqOdnHQetXF/cAp
 eIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793635148; x=1794239948;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0mh26+FiDypJASUKHQJSKT+6VRpbGLaFEPCS5IrsMTA=;
 b=B88SUdg8Wj16fJHnxRx0PGghblG9k25yXi2KxyHf/Gpd/Ca8Syyz6fytDU89ySCYN8
 hO9qDgq6DgVpKHMLVgs58qTsVQ5my1aZZ6gehWrtmGNG2EEWgmV23+dzxIa9JkhFPDWw
 sS1nBXJkL0hSqixHnIyHb4kQhT3yyizPfVHMgWyufxnaJUZQeArPgbtHKPoT3WM+Hohc
 ndCReT1zjpvTQ3hzQgO8IgHpLHa1c/aoKmpEeEbQmCUUVC2aW7ot+d40TgmMbkNfFWr4
 O3aFOwhXYWbLWh0LpB3J+zQIvnt4UZFJU6hwm4TM+mLjQKzQereYAINJJR2faELKET8Y
 jbbQ==
X-Gm-Message-State: APuU4Z/d1ZEar2KRjmkGLfnpNAsulrM5qFESoYiiNs7Sy+wxDVU9l5K4
 apN990EKTDhG8q5EehQUbFrMuh19nY41ykBh22eHHM8Ogv7mvRnbPZY31aziUC06OF8iCOYIWV2
 HM0ARVLSP2hVjeMepaVTwHSQBLPG52iOF8D7pxD9x5ZuGuQMhrqTsXlUnbSh+SquL+yly
X-Gm-Gg: AYBFou1va1GD6mNihJOx03WL3yttouRBNXPQKhlNmWecVlkUNnZdWIAQCkFaVGnBVpP
 oeKGPYlG3jXJr8PJ+7pGHDhC3+57zfPUQpQ9dlzmTNnHCAZJ6HcgBqeo0jDqIEP/XhZirrnA7qc
 wyX67Nnchlub8g+IbVzyCMGOVbjgRxulGJTFm73uzxQA99cXotiV1M6ZIVNMobKKnWKwIF/B52F
 gTapUY1f4YjRSj1LIdX7hn7lIqpB+hP/RYpTYYvxhoYlon007G7p5QdzlQcvzKmeJX5w2hh13Uc
 nEqmInSZFfE6BVyRPAK0bdT4Ey16CousD03qn3e/xdeC2Zzqiipc2Lw0cujp4+/zNt0SI8DXXhx
 7ofQzp3RZMduWQye3AUhXHDJJEZrIVcDNHINdMOEifoZzC27ssql7UlEOYbSO/pgzOWD7Csg2nt
 3TlrFH0Gif62g+8FqpFnDJf/qA1UXwL+LxQjb8X1ggBDcdfFiHU4iGKaiXd7h5GVKVy4jqdvUP+
 sLP0u0zvkL+Qr6SNpA2pWOGgcFe0qISWQ5ccITZP9SbHM1ke5yfELz+nIAeJeuQyo9vzL+oFPiC
 BpNdauX1DX39crTW2gjbDai3RIBHUS54conIhRKtby9lkOa38StejGp3SgxDmWhJoMEZE65t9PC
 JfIggR2eZ78pNeADYBBQ8pfAtDkCWNPLG5c9fn51lrtajsj6ulSMw1Jy81AYcTm3+VyQYsScdXZ
 cIXaRJzRj9oW51IQ==
X-Received: by 2002:a05:6000:4b04:b0:48d:f391:5c45 with SMTP id
 ffacd0b85a97d-48e6e4f8ae4mr25956810f8f.42.1793635148295; 
 Mon, 02 Nov 2026 07:59:08 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b78a6bsm20380288f8f.27.2026.11.02.07.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:59:07 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 15:59:04 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb
X-Gerrit-Change-Number: 2085
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2085?usp=email>
X-Gerrit-Commit: 15992f390eefad52a497d7de88aa9adc45e75eb9
In-Reply-To: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
References: <gerrit.1793619070000.Ib9164e1c8f5e02a2253bbb3b2363a4f9f31c8bdb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE5MDcwMDAwLkliOTE2NGUxYzhmNWUwMmEyMjUzYmJiM2IyMzYzYTRmOWYzMWM4YmRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fae7e7457d58fdf420e83775567a9d5b8c157c37-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNuRG-000000004SS-47C7
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: check
 parameters for NULL before strlen() in send_cc_message
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6716871633387589505=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6716871633387589505==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="akloJ1hzRdw="; charset=UTF-8

--akloJ1hzRdw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2085?usp=3Demail

to look at the new patch set (#4)=2E

The foll=
owing approvals got outdated and were removed:
Code-Review-1 by Frank Licht=
enheld


Change subject: init: check parameters for NULL before strlen() in=
 send_cc_message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

init: check parameters for NULL before strlen() in send_cc_message

ma=
nagement_callback_send_cc_message() called strlen(parameters) before
its ow=
n NULL check=2E Only count parameters and the separator when set,
and drop =
the cppcheck suppression for it=2E

Change-Id: Ib9164e1c8f5e02a2253bbb3b236=
3a4f9f31c8bdb
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M =
dev-tools/cppcheck-suppressions=2Exml
M src/openvpn/init=2Ec
2 files change=
d, 5 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/85/2085/4

diff --git a/dev-tools/cppcheck-sup=
pressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index 33337cf=2E=2E=
926ecde 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/=
cppcheck-suppressions=2Exml
@@ -198,12 +198,6 @@
     <fileName>src/openvpn=
/dco_freebsd=2Ec</fileName>
     <symbolName>buf</symbolName>
   </suppress=
>
-  <!-- IGN: strlen(NULL) is not nice code, but seems to work -->
-  <sup=
press>
-    <id>nullPointerRedundantCheck</id>
-    <fileName>src/openvpn/i=
nit=2Ec</fileName>
-    <symbolName>parameters</symbolName>
-  </suppress>
=
   <!-- FP: cppcheck doesn't understand ZeroMemory -->
   <suppress>
     <=
id>redundantAssignment</id>
diff --git a/src/openvpn/init=2Ec b/src/openvpn=
/init=2Ec
index 24cf532=2E=2E6c87865 100644
--- a/src/openvpn/init=2Ec
+++ =
b/src/openvpn/init=2Ec
@@ -299,7 +299,11 @@
 management_callback_send_cc_me=
ssage(void *arg, const char *command, const char *parameters)
 {
     struc=
t context *c =3D (struct context *)arg;
-    size_t len =3D strlen(command)=
 + 1 + strlen(parameters) + 1;
+    size_t len =3D strlen(command) + 1;
+  =
  if (parameters)
+    {
+        len +=3D 1 + strlen(parameters);
+    }
 =
    if (len > PUSH_BUNDLE_SIZE)
     {
         return false;

-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib9164e1c8f5e02a2253bbb3b236=
3a4f9f31c8bdb
Gerrit-Change-Number: 2085
Gerrit-PatchSet: 4
Gerrit-Owner: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>

--akloJ1hzRdw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #4</strong> to =
this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2085?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review-1 by Frank Lichtenheld</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">ini=
t: check parameters for NULL before strlen() in send_cc_message<br><br>mana=
gement_callback_send_cc_message() called strlen(parameters) before<br>its o=
wn NULL check=2E Only count parameters and the separator when set,<br>and d=
rop the cppcheck suppression for it=2E<br><br>Change-Id: Ib9164e1c8f5e02a22=
53bbb3b2363a4f9f31c8bdb<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt;<br>---<br>M dev-tools/cppcheck-suppressions=2Exml<br>M src/ope=
nvpn/init=2Ec<br>2 files changed, 5 insertions(+), 7 deletions(-)<br><br></=
pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/85/2085/4</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppressions=2Exm=
l b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>index 33337cf=2E=
=2E926ecde 100644</span><br><span>--- a/dev-tools/cppcheck-suppressions=2Ex=
ml</span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</span><br><s=
pan>@@ -198,12 +198,6 @@</span><br><span>     &lt;fileName&gt;src/openvpn/d=
co_freebsd=2Ec&lt;/fileName&gt;</span><br><span>     &lt;symbolName&gt;buf&=
lt;/symbolName&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- IGN: strlen(NULL) is not nice c=
ode, but seems to work --&gt;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  &lt;suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    &lt;id&gt;nullPointerRedundantCheck&lt;/id&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    &lt;fileName&gt;src/openvpn/init=2Ec&=
lt;/fileName&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &=
lt;symbolName&gt;parameters&lt;/symbolName&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span>   &lt;!-- FP:=
 cppcheck doesn&#39;t understand ZeroMemory --&gt;</span><br><span>   &lt;s=
uppress&gt;</span><br><span>     &lt;id&gt;redundantAssignment&lt;/id&gt;</=
span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</sp=
an><br><span>index 24cf532=2E=2E6c87865 100644</span><br><span>--- a/src/op=
envpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@=
@ -299,7 +299,11 @@</span><br><span> management_callback_send_cc_message(vo=
id *arg, const char *command, const char *parameters)</span><br><span> {</s=
pan><br><span>     struct context *c =3D (struct context *)arg;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    size_t len =3D strlen(command=
) + 1 + strlen(parameters) + 1;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    size_t len =3D strlen(command) + 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (parameters)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        len +=3D 1 + strlen(parameters);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     if (len=
 &gt; PUSH_BUNDLE_SIZE)</span><br><span>     {</span><br><span>         ret=
urn false;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2085?usp=3Demail">change 2085</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2085?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib9164e1c8f5e02a22=
53bbb3b2363a4f9f31c8bdb </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2085 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel=
@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--akloJ1hzRdw=--


--===============6716871633387589505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6716871633387589505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6716871633387589505==--

