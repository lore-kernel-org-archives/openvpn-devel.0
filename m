Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F52C55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 10:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0FmepODx9sMC7z+M3/23183Y5RhRrkkN/T9VCBu7GNI=; b=Fl72CPNdM+3i9FFbPIneMh+m8u
	ay8LU4+B0nuQPptVdecZtLu8SKdBjS/4gPBianbBaEplqqeVMwCvYOHjEpj5xqgWp2x+YGbH/4rHW
	ZBk9bJvMSOQhYiVAWwFHQDHGNfsMLfLDFA2zTEs9FwYbaXCchKsuZlHS0rJlGCXzPfzo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrv5S-0000iP-4I;
	Thu, 06 Aug 2026 10:12:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrv5Q-0000iI-9o
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 10:12:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=q9RSZMX6Rd/WywN6+h4YKO3qTi9imoTNiSeK0h8Ip9E=; b=OCH4S+sD/t/qChMSc0fTgN+4k5
 q0HU2TuWcKrPDd+M2Mlobe3v3PMG0Domze+/LhZ/563akgdbEqbqZ4KMrClp3h/ot/VK9mF/L35sN
 K8YVLkRxVVGPrrK5aLNGlmYwwMQvETxxN5U5Ty8Nv3KO2ajtmZqsfqP32AUTWdqYI6RQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q9RSZMX6Rd/WywN6+h4YKO3qTi9imoTNiSeK0h8Ip9E=; b=W
 VzAWcGdTFJBuzOqYGJmPvsYPBVbqKx+Iai2dWkRZ918Fny07FQiE7xHnC0R3uXbquCLJZu5ljPWs0
 zYhyk1KFQnLL00i70xIYvKVqygurAn2naZHbfIMOugeTx+SwiO6RjRVTUL31WCKSEB0V4dbe4bLpx
 UgRSD6RBv0sxEqt8=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrv5Q-0003m5-5e for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 10:12:28 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so1336654f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 03:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786011141; x=1786615941; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q9RSZMX6Rd/WywN6+h4YKO3qTi9imoTNiSeK0h8Ip9E=;
 b=eqcX1zoXPRGVb2pflMeIwxFnNwLSm2mUr72ZGC9mLjcohOeTDw6ODM/3FWaz1/zr8N
 8O3UGHwttBYxuALcFUdAt72XlKCS7aiASilG/ORsQiKvFq9DKmo3RrqQ2MvKyz0LaAP1
 Yi4u4RxcUaI2Rk78v3bclNq+b8Xst726uHTCsMyD+NDw9BYVAeJUCOFKk8kazEiAi8UK
 J/E5peY1TbkwHdSeeWCzXrdeGlRNrLX3mH0udfgTx4Q1udMWLCJ2HUD7cHJ+CyLpDknC
 aXOIQzIeZ/3Nk9h/yiZGCCJdmJcgrhtz4bUwcxtIVpKCoL8vOiO2F3//yaPxHq9Axlsa
 uzig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786011141; x=1786615941;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=q9RSZMX6Rd/WywN6+h4YKO3qTi9imoTNiSeK0h8Ip9E=;
 b=pLOljpMQ9F27IQL7EFAsC+ZtBCOamEyYkYvrSmxH+p84j4S7YkED1UNBIh3M541fQP
 Q7UVja6vq9Dh/sH1lYMtDfRjUpTtwE5+kgrFV1mjdsw2/2DOeFrMmUoFsmBsN5jbs1i0
 r6GjkaY4Yk7izq89K2z/yPg5gHgFzhswzmar02bAgsX32941AHD6p9L4alzgz2vNSDzL
 JW7WufPVike2bTjsp/4W4YLGFw9CwhWa27gCry31OG3bHK072dHGkvg8e9wYONh3KTob
 s1yI2EEyZPmigzc38bcmJzFJY29GsFtaYrZO9/b2ArgvFcbsOy3JSuMvTLq8Ff6LV6Tu
 MeiQ==
X-Gm-Message-State: AOJu0Yxc/Ai9BwKX4jpP6yEilJuyQbfYwdybJ535brm26bnxR0kdBhTY
 BZST66sCjqdTWxV/4zChH4dJ7L5UCS2BO14a2VBlEdoLJ9gtRmnnhSk6wJmOqt6g92VMxXOJhwl
 ef2t3Wk+uYADBBfidpr++JWpRIy/GnfYod7kqGPdUc/zAEeb3i18jwFxKFLIgrICJ60/c
X-Gm-Gg: AR+sD10WoVZFCa/r4cGEbTtyqo4OxmkvU79FXw0POK/vEYQa+RkMhMmqPUXQy8r24rX
 IrbLQT7dvddwsZ0h/bV+17nayGeb6KQnP24+Ap6pvHZ14At1xcJOztzXth+ucpT1fMPAWMDxhmN
 Uy+R9GmW9d0Xn6wGyfo3FrpsqG36+pK32AsLGBTbDvaM86bqaWBxn5MpgekmUt2HxMLxAR54bJY
 l8pvQTbacOxrpijtiT3QB9K8G0y2jMuvIoNGOTSLwgn8mdF4H7XSdu5H7m+8q99y4E7jh4gPDjR
 wmzRG++uBUGtET6kNmPn0xn/Qh9qFUp9FVqQM4vpeIkXj5xe9z2qYw46U6YYIUFR0ptw7m53zf+
 sHg/DKCrUf8ks7HS4z1a71Fm7p/6epmnW8gy3dY9Ce2sYDhr5vQCHJBp+6GNKC9rilnCDABKNVS
 +7NV28FgFd09c09zMbk7s0dXCvf/vr2axXKDIlMxXH46XdkJ2WSoxH/tveJsLuiXa6FRtPN+aaJ
 tMH6IaEsmsbCKPGl2x77Lx1VoQc7VAl4Lf9F3/XhwaMFcASLVtyb/u+CiS17Q/hmaZHkU8rmrHr
 7V6pb9vxBNIO12XalNkfQOzvCLlGX4z42F8GKkzLOJ1a5DLF1Vs=
X-Received: by 2002:adf:ed89:0:b0:47f:9aef:5515 with SMTP id
 ffacd0b85a97d-47fec5141f9mr17199914f8f.13.1786011141479; 
 Thu, 06 Aug 2026 03:12:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ff79a71a2sm4924218f8f.6.2026.08.06.03.12.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:12:21 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 10:12:19 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
X-Gerrit-Change-Number: 1834
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1834?usp=email>
X-Gerrit-Commit: 5978a46e3db1013f327bb315d283d5816c3a4526
In-Reply-To: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
References: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzY2MjYwMDAwLkkzZGI3MDAwMWJlN2YzOWNmODRkNTYyNTE3NjQ3ZjFhMzA1OTYyYjQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6643407eb71b86989610e65be427b0b7fa19df79-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrv5Q-0003m5-5e
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove local
 get_random in test_misc.c
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
 antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7215480703875908567=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7215480703875908567==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nkRwbc4ohNM="; charset=UTF-8

--nkRwbc4ohNM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
flichtenheld, Code-Review+2 by ordex


Change subject: Remove local get_ran=
dom in test_misc=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Remove local get_random in test_misc=2Ec

The get_random in test_mi=
sc=2Ec conflicts
with the get_random function that OpenVPN defines in crypt=
o=2Eh
Also adjust the implementation in mock_get_random=2Ec to match the
pr=
ototype in crypto=2Eh

Change-Id: I3db70001be7f39cf84d562517647f1a305962b42=

Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Acked-by: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834
Message=
-Id: <20260806090951=2E20900-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38155=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/unit_test=
s/openvpn/mock_get_random=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
2 fi=
les changed, 3 insertions(+), 9 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/34/1834/3

diff --git a/tests/unit_t=
ests/openvpn/mock_get_random=2Ec b/tests/unit_tests/openvpn/mock_get_random=
=2Ec
index 0840e31=2E=2E5cb768b 100644
--- a/tests/unit_tests/openvpn/mock_=
get_random=2Ec
+++ b/tests/unit_tests/openvpn/mock_get_random=2Ec
@@ -28,7 =
+28,7 @@
 #include <stdint=2Eh>
 #include <cmocka=2Eh>
 
-unsigned long
+in=
t64_t
 get_random(void)
 {
     /* rand() is not very random, but it's C99 =
and this is just for testing */
diff --git a/tests/unit_tests/openvpn/test_=
misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index cd86fd2=2E=2E4d046c=
e 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_test=
s/openvpn/test_misc=2Ec
@@ -38,6 +38,7 @@
 #include "test_common=2Eh"
 #inc=
lude "list=2Eh"
 #include "mock_msg=2Eh"
+#include "crypto=2Eh"
 #ifdef _WI=
N32
 #include "win32-util=2Eh"
 #endif
@@ -143,13 +144,6 @@
     return str=
cmp((const char *)key1, (const char *)key2) =3D=3D 0;
 }
 
-static uint32_t=

-get_random(void)
-{
-    /* rand() is not very random, but it's C99 and t=
his is just for testing */
-    return (uint32_t)rand();
-}
-
 static struc=
t hash_element *
 hash_lookup_by_value(struct hash *hash, void *value)
 {
@=
@ -266,7 +260,7 @@
         {
             struct hash_iterator hi;
       =
      struct hash_element *he;
-            inc =3D (get_random() % 3) + 1;=

+            inc =3D ((uint32_t)get_random() % 3) + 1;
             hash_i=
terator_init_range(hash, &hi, base, base + inc);
 
             while ((he =
=3D hash_iterator_next(&hi)))

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1834?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
Gerrit-Change-Numb=
er: 1834
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--nkRwbc4ohNM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by flichtenheld, Code-Review+2 by ordex</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Remove local get_random in test_misc=2Ec<br><br>The get_random in test_=
misc=2Ec conflicts<br>with the get_random function that OpenVPN defines in =
crypto=2Eh<br>Also adjust the implementation in mock_get_random=2Ec to matc=
h the<br>prototype in crypto=2Eh<br><br>Change-Id: I3db70001be7f39cf84d5625=
17647f1a305962b42<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;=
<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by=
: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834<br>Message-Id: &lt;20260806090951=
=2E20900-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38155=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/unit_t=
ests/openvpn/mock_get_random=2Ec<br>M tests/unit_tests/openvpn/test_misc=2E=
c<br>2 files changed, 3 insertions(+), 9 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/34/1=
834/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/tests/unit_tests/openvpn/mock_get_random=2Ec b/t=
ests/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>index 0840e31=
=2E=2E5cb768b 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_ge=
t_random=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/mock_get_random=
=2Ec</span><br><span>@@ -28,7 +28,7 @@</span><br><span> #include &lt;stdint=
=2Eh&gt;</span><br><span> #include &lt;cmocka=2Eh&gt;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-unsigned long</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+int64_t</span><br><span> get_ra=
ndom(void)</span><br><span> {</span><br><span>     /* rand() is not very ra=
ndom, but it&#39;s C99 and this is just for testing */</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/=
test_misc=2Ec</span><br><span>index cd86fd2=2E=2E4d046ce 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_misc=2Ec</span><br><span>@@ -38,6 +38,7 @@</span=
><br><span> #include &quot;test_common=2Eh&quot;</span><br><span> #include =
&quot;list=2Eh&quot;</span><br><span> #include &quot;mock_msg=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto=
=2Eh&quot;</span><br><span> #ifdef _WIN32</span><br><span> #include &quot;w=
in32-util=2Eh&quot;</span><br><span> #endif</span><br><span>@@ -143,13 +144=
,6 @@</span><br><span>     return strcmp((const char *)key1, (const char *)=
key2) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-static uint32_t</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-get_random(void)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* rand() is not very random, but it&#39;s C99 and this is just for te=
sting */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (u=
int32_t)rand();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static s=
truct hash_element *</span><br><span> hash_lookup_by_value(struct hash *has=
h, void *value)</span><br><span> {</span><br><span>@@ -266,7 +260,7 @@</spa=
n><br><span>         {</span><br><span>             struct hash_iterator hi=
;</span><br><span>             struct hash_element *he;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            inc =3D (get_random() % 3) + =
1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            inc =
=3D ((uint32_t)get_random() % 3) + 1;</span><br><span>             hash_ite=
rator_init_range(hash, &amp;hi, base, base + inc);</span><br><span> </span>=
<br><span>             while ((he =3D hash_iterator_next(&amp;hi)))</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1834?usp=3Demail">change 1834</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I3db70001be7f39cf84d5625=
17647f1a305962b42 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1834 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--nkRwbc4ohNM=--


--===============7215480703875908567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7215480703875908567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7215480703875908567==--

