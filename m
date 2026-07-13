Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CE4C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hjitVZKEhuCfpOIyjDLAoVHsx3CXKHVtY7KriNET4hA=; b=bjECCm3IYB6eH6bCMIhFNGP9AS
	1ljjWqVU0ZE0H9x36MmNmv8GHMtD5vyxYfD6ptXr4sYjmDgSalMnaFfcpqvlpzagz5A/oC7acbNU6
	t95iZateT1tVn+CHBYp+JMOm/z1HO4miQoDfgyqeOW6mjIrj2KH8ozDNeEg+wxJ26deo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjIzI-0007w5-9q;
	Mon, 13 Jul 2026 15:54:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjIzH-0007vs-4t
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:54:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GmiQw5cbIChORNQFUv/SxVefdv4giICD9w2lTTvExrg=; b=bRWSaRwf2kAu4Q9TeeQgeFLew+
 mKBucmIuEgGStcmoaXve8/3sCs5qFpoNOIdct7IQa8P140qavOgn3XVmx/K1IAeKmcIZAjOvc4xI3
 GQAD7Cev4p/w8ZApEP+Y9kylOVzWqbfTHCqaLgPda/+mM2UhcRBhEYI6CZcseI1nXGh0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GmiQw5cbIChORNQFUv/SxVefdv4giICD9w2lTTvExrg=; b=i
 ZALM1RDWRsrVD8NENECKVkcTz2VSVfHqnpF3cEtOM0qnCg6+iB35Bxd5puLYYZvQzSUybfp39M/Be
 lFPjvZCKV15HC05g29ATzuzL7Ks143EIJvZuuDyLCAbCViDHz4+6oPFgMLhJnmWidV7LVa/2AVic/
 F7V9Zyhrpg399QnE=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjIzH-0004HN-2S for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:54:31 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493bb510ce4so23689715e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 08:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783958064; x=1784562864; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GmiQw5cbIChORNQFUv/SxVefdv4giICD9w2lTTvExrg=;
 b=SESFom8HcE3NmQnKSJ/59Hr7DsUtCXHPSk3t225TGVNPyVNeymyGGHKcyz1x1RuJau
 rwobKOQaG3l7OCvxVNX/7hDuvuHShP+4AnukMO7+jA5qouSlI7E8R6rj2ecgZjw+7uic
 Neuc/Bz5oz4olC/7I7kSdoiyUvRSHAOd4Iw7QzyV3vzhL1Tr3xmP3ykCkYX7gNtVpUJA
 v6kDNa6blgpsPQszmctIgCMdpA/pRZhJkAUwdp+PvkGMx6Eu+zJJyKBH7AovEcGPjAbc
 3rCKnSefqOOgLtDSmc9hXY3hrII3naghQysd7AuMFxI/C8LSQYVWbjq1T3bh746so/B+
 jqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958064; x=1784562864;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GmiQw5cbIChORNQFUv/SxVefdv4giICD9w2lTTvExrg=;
 b=cbP1VkngzTf7m3hLXTkErtNIF9d8KmA4g0M8C/KONL8h+b8rO8yhjmRx9aUB22QSL6
 xe/+f3Q99r/7IefcGC43mn8v69PtOxTxBSi1l1BlitiWdwDF71EKYWyegdHw0/tOWDKZ
 SmFkq4IcOZc+HkEOt8XbwgzMHWJtmVrgMYsZ4OTonPK14K0xQ1ev7U07hExDTLnz8y9F
 QGJpMjNotwwJz8UEmicshhf+MMR+g9Vnt1zVZv1nngOFZfytoErda4V5Oc3IY97TmB4d
 zD7IaGUVMo/JZAcV8B/8zjhgiAKGxM1gkAIuleAA29CvRu/+Tc/WMxmqPPn4FIzI8sLN
 qeIQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9rMM4YT0p1g+hLcX9P2oYD2Yzoo97O580dwcvV+uRzVsfwtVy+M8mIAPB7hZ95qNoyam4fpwWllpOJJHC@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxJzmKftPKD7hOi8rhOQmURqSsteSfLnfLXG3vAamUvXYFznqAE
 Df1qFyP13Fy2oJPyfEb4lsgPkv2Yt6gNlZHGn5lUoMCyCaP0JlzohEWJwyQZJWAY+GsEnHX94Bz
 nZu99jwdAD1OEaF7QeJ5zLuGSsxaG7r/vAmOHUxlzuzIhshp1sHTOCVbnb4iKEbK08Ztg67U2Oz
 nj4oFWNQ==
X-Gm-Gg: AfdE7clBL5xaFLEJg+latXKMePm3Z0wR95f5v5kW1L7BF3Y+5ZWkELBe7cNAw+kzjd7
 70QMNjTK5b1gUECdfJHvC9MacKNcelGBHG8UssJgj9beVkvG/ypN/TKpTjeR1F28eMzI0pwm60d
 MYX0m8/E76C9szZXtMV+6eCqnV3ft+9CAiBm9Janw939/B83qJOWUGtUhKBabID1SIi35AbO/vL
 k+Yc23an3KMeheQDPWIbL/BFclZ3YZN4KlGdyS6mqFSRee0KPbORFCCiXDGs7kuKMPgZOvLWuhT
 ZikCgEvhF2lcXcStvurhNDrty+tZhGAVVdfyCv4QS5aKTfbvzhpoO/xXLtoR6wVavbP8f8VRmOB
 BN/XUm+CMh+llCEn5i/306DVv/0vk2wrAvm3wmg3Ac4saV7OHW2+OlnFqf9PDZy1WiaxOqsgivp
 K2ZUc+jEyRUBmBHFhdsusHNFfoTO57D09OlyQfqs7LDWzRCFaVsOywhhBbnSd4Miq66briuM9ZE
 H/2lWHNpiaOQ+vvHJLM20hWd4G1SY71ho6zFdy5qoEdzdNezK7DkSSKrNXGdu47S/zn0dJVjwVu
 7/I=
X-Received: by 2002:a05:600c:608f:b0:493:c634:952 with SMTP id
 5b1f17b1804b1-493f87d5d28mr103738825e9.7.1783958064336; 
 Mon, 13 Jul 2026 08:54:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a2f635dsm4457895e9.12.2026.07.13.08.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:54:23 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 15:54:23 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
X-Gerrit-Change-Number: 1739
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1739?usp=email>
X-Gerrit-Commit: 2c2fec4a965cf046b3d71b3250f8d84f6af81b89
In-Reply-To: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
References: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljYzE0YjI4NmYyNDA5NzM4YzczODczYWE3NTUwZGNjMDA1ZWU4Y2JiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4120d3efb93022c27bec8b6281324f7ca0503cf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjIzH-0004HN-2S
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CMake: detect
 cmocka_version.h via include path, not by linking
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5547928740966773513=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5547928740966773513==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NS7I+XRJqjI="; charset=UTF-8

--NS7I+XRJqjI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1739?usp=3Demail )

Change subject: CMake: detect cmocka_version=2Eh vi=
a include path, not by linking
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

CMake: detect cmocka_version=2Eh via include path, not =
by linking

check_include_files() was invoked with cmocka in CMAKE_REQUIRED=
_LIBRARIES,
which makes the probe link the (shared, imported) cmocka librar=
y=2E On some
platforms that link step fails inside the minimal probe, so th=
e header check
reports failure and HAVE_CMOCKA_VERSION_H is left undefined =
even though
cmocka_version=2Eh is present=2E

test_common=2Eh then selects =
its cmocka 1=2Ex compatibility shims and redefines
macros (check_expected_u=
int, expect_uint_value, =2E=2E=2E) that cmocka 2=2Ex already
provides, whic=
h breaks the -Werror build of every unit test driver=2E

Detecting a header=
 only needs the include search path, so pass cmocka's
INTERFACE_INCLUDE_DIR=
ECTORIES via CMAKE_REQUIRED_INCLUDES and drop the library
link requirement =
from the probe=2E

Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
Sig=
ned-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1739
Message-Id: <20260709144240=2E61362-1-frank@lichtenheld=2Ecom>
URL=
: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/=
msg37552=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M=
 CMakeLists=2Etxt
1 file changed, 9 insertions(+), 1 deletion(-)




diff -=
-git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 4779d69=2E=2E8de836a 10064=
4
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -385,12 +385,20 @@
     =
find_package(cmocka CONFIG)
     if (TARGET cmocka::cmocka)
         set(CM=
OCKA_LIBRARIES cmocka::cmocka)
+        get_target_property(CMOCKA_INCLUDE_=
DIRS cmocka::cmocka INTERFACE_INCLUDE_DIRECTORIES)
     else ()
         pk=
g_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
         set(CMOCKA=
_LIBRARIES PkgConfig::cmocka)
+        set(CMOCKA_INCLUDE_DIRS ${cmocka_INC=
LUDE_DIRS})
     endif ()
-    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRAR=
IES})
+    # cmocka_version=2Eh exists since cmocka 2=2E0; its absence sele=
cts the
+    # cmocka 1=2Ex compat shims in test_common=2Eh=2E Detecting a =
header only needs
+    # the include path - do NOT add cmocka to CMAKE_REQU=
IRED_LIBRARIES, as that
+    # makes check_include_files link the shared li=
brary, which can fail in the
+    # probe for unrelated reasons and wrongly=
 mis-detect cmocka 2=2Ex as < 2=2E0=2E
+    set(CMAKE_REQUIRED_INCLUDES ${C=
MOCKA_INCLUDE_DIRS})
     check_include_files(cmocka_version=2Eh HAVE_CMOCK=
A_VERSION_H)
+    unset(CMAKE_REQUIRED_INCLUDES)
 endif ()
 
 configure_fil=
e(config=2Eh=2Ecmake=2Ein config=2Eh)

-- 
To view, visit http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1739?usp=3Demail
To unsubscribe, or for help writi=
ng mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

=
Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
Gerrit-Change-Num=
ber: 1739
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>

--NS7I+XRJqjI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1739?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">CMake: detect cmocka_version=2Eh via inclu=
de path, not by linking<br><br>check_include_files() was invoked with cmock=
a in CMAKE_REQUIRED_LIBRARIES,<br>which makes the probe link the (shared, i=
mported) cmocka library=2E On some<br>platforms that link step fails inside=
 the minimal probe, so the header check<br>reports failure and HAVE_CMOCKA_=
VERSION_H is left undefined even though<br>cmocka_version=2Eh is present=2E=
<br><br>test_common=2Eh then selects its cmocka 1=2Ex compatibility shims a=
nd redefines<br>macros (check_expected_uint, expect_uint_value, =2E=2E=2E) =
that cmocka 2=2Ex already<br>provides, which breaks the -Werror build of ev=
ery unit test driver=2E<br><br>Detecting a header only needs the include se=
arch path, so pass cmocka&#39;s<br>INTERFACE_INCLUDE_DIRECTORIES via CMAKE_=
REQUIRED_INCLUDES and drop the library<br>link requirement from the probe=
=2E<br><br>Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1739<br>Message-Id: &lt;20260709144240=2E61362-1-frank@l=
ichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg37552=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>1 file chang=
ed, 9 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 4779d69=2E=2E8de836a 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -385,12 +385,20 @@</span><br><span>     find_package=
(cmocka CONFIG)</span><br><span>     if (TARGET cmocka::cmocka)</span><br><=
span>         set(CMOCKA_LIBRARIES cmocka::cmocka)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        get_target_property(CMOCKA_INCLUDE_D=
IRS cmocka::cmocka INTERFACE_INCLUDE_DIRECTORIES)</span><br><span>     else=
 ()</span><br><span>         pkg_search_module(cmocka cmocka REQUIRED IMPOR=
TED_TARGET)</span><br><span>         set(CMOCKA_LIBRARIES PkgConfig::cmocka=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(CMOCKA=
_INCLUDE_DIRS ${cmocka_INCLUDE_DIRS})</span><br><span>     endif ()</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    set(CMAKE_REQUIRED_LIBRAR=
IES ${CMOCKA_LIBRARIES})</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    # cmocka_version=2Eh exists since cmocka 2=2E0; its absence select=
s the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # cmocka 1=
=2Ex compat shims in test_common=2Eh=2E Detecting a header only needs</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    # the include path - =
do NOT add cmocka to CMAKE_REQUIRED_LIBRARIES, as that</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    # makes check_include_files link the=
 shared library, which can fail in the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    # probe for unrelated reasons and wrongly mis-detect=
 cmocka 2=2Ex as &lt; 2=2E0=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    set(CMAKE_REQUIRED_INCLUDES ${CMOCKA_INCLUDE_DIRS})</span><b=
r><span>     check_include_files(cmocka_version=2Eh HAVE_CMOCKA_VERSION_H)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unset(CMAKE_REQU=
IRED_INCLUDES)</span><br><span> endif ()</span><br><span> </span><br><span>=
 configure_file(config=2Eh=2Ecmake=2Ein config=2Eh)</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1739?usp=3Demail">change 1739</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1739?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1739 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></htm=
l>
--NS7I+XRJqjI=--


--===============5547928740966773513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5547928740966773513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5547928740966773513==--

