Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56676C55179
	for <openvpn-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=oR/c7iWDpzYBO11RFEOVnWDRm5PYZifN2kXZ1e6XiJE=; b=jEEFmoi0zjEJH8
	jH65mbbvxU0uh38Z9R5kXPI5kezSE60UBIkYUN4QFVWc0fjpZ0/6y34//XeYiUI1MD1RL6uEtGvns
	1NNrPxXtf2JlzvVJB4wAEeNSV0qhJEj6hioboQ9O9JGSoJpdTV7wPYc301jkOw871DFSdhchLk6tz
	34I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wqtNy-00063r-79;
	Mon, 03 Aug 2026 14:11:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wqtNw-00063k-HF
 for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 14:11:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hGUR5juyvZ9/hjCZXdOZOBaS5JQNQB2GO/mGkY/rzuM=; b=ZZj2klQFFSMBTSksP7dRlBXgVv
 6oChFdXU7wk86rnSPCRjI1HblBPIUggzV4C3JUIXzIIliV5SwM7GWa6Lqc1KBItK5XRuLtXv+0LUC
 5OlA6rhlBgjU7/TO7b2mudB0/Lv2ykCfFskUwGqzCzxFWgEaS5wiAUlqLyHi0vJZsD10=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hGUR5juyvZ9/hjCZXdOZOBaS5JQNQB2GO/mGkY/rzuM=; b=m
 tyTITf73KV6lUQPWGWi68IB/NPt/oc2A8iQAPBZ2x05hZdH1Wmo3YVGY++MgWmSYcYwW+wFjITZK+
 ODEmOl7PUhY15dg4VUQoUNhb3PhAA9tscbrlhQvcehmhRNHWz6I56dfXNghTec6sXpSVnYroAmkdr
 HtlSnvthqzcS6lSY=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqtNt-0004wM-An for openvpn-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 14:11:17 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so22078315e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 07:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785766271; x=1786371071; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hGUR5juyvZ9/hjCZXdOZOBaS5JQNQB2GO/mGkY/rzuM=;
 b=b8q/IYiMBef/YakUua2mmxHIc9fxpXCtAyy+KhMV8ppFVWAC1T4JL0mmIaK70t+tKs
 QHdYxJ/aS1u3HehrswfPQpryq4lDVus9bBd7fkWSVwYNtt6DxF19wSb1RNNaAWD+MuOJ
 nZqSOeA7cwD1w/NE6AFAGFhButt17sSxfZY+W4HElpPA9ZROm5Sj0gIIuCNkJHkHDUam
 OYg5wdzhy81MIJNhuE8fC0aI9zEp6AgiJvP0tNSvsmyq9xjb7zoFpB5kG65wVi2GXjKT
 EvEqSvURejqIkROo8yrYfAN6E+Z+aYBa59qFSM2HS8cvC+BdX9neq8g9WpTf11ZiDlYb
 DnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785766271; x=1786371071;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hGUR5juyvZ9/hjCZXdOZOBaS5JQNQB2GO/mGkY/rzuM=;
 b=ehkvRyxqulrNWpU4WHhVM6bGmomrmTNqfeTdQsFXaEf5FFVybB4UDL8RWWC7J6RG+F
 /8jOuZZvCXIQNOl293Qz+elSKz8EoiMYw9Klyqh+C0rvYLmQsliBWe6XzWqRRnpTcJoS
 jXn9WHdVEp6cjYoayOFgSFRlI49X8Bshg0dMBvn20NUrkKzKXjIxwelI10ok+CPbDQFa
 YeK66Nx4F/cOwr5dfq78slyVri0BrZsfhOpjVPQLaqK760gVqMCYh6Yhzg4YIG2wHI/v
 5vzXKiE8gOUZMNfdqyVqraMKbb8C8qImQeXruYxyVnFTZVWg0bsrGMQGYa/exPF8oNMd
 hEVw==
X-Gm-Message-State: AOJu0Yz8ge6HXSTiuT6KYEJp1/3UYojXdWKH3QbCEw1UlH+a+Tb+TAss
 oLtjzDcqoMauasp9xNKCCohCzJsh2o3QP39NqverC6Z29zAcMEYBTfhzoO/LqBpgE84NF1OTwLT
 9H59sN28Gnu6x0Np1lOTgThV+5AWpIKI8w+reCnZee0wMjVTNBNG0SdfPGcsLCAlhWG1OLaVuo7
 lX8nUtsA==
X-Gm-Gg: AR+sD13rhSXsZglAXULtikNSAFkGu7/eYtCj7Q129xAsyIp59u7kfSdqcCo97hP1Vxz
 tKrtKXnO4DtsOUrbHzrfIzD5lj9fD+K+fbCe3LXeFWBXkyc1+vZTfgNbQC8ptAGkIX47xJKqtr2
 hnzGGnq0t6M76PWys5cdnR6Gm6jLjKrYDCRUFJfwp1c3pr+wWJoySlMr4oH5s4qEEqPVnXGPdH/
 U0BQRuWawT4EpfaUyJ51QruPwAeOcbv7VuFxtofJtTyJ3BsTjLlL0kg0jaRNB1qzh4YPNi7knmp
 VeeCu9j52eNOHs15ly9vTcpfL6qHTS4IoiqbjsEScGVPDJQURhaqBIJpudfNSoZWzDZsb1a6wfJ
 hWgB7i5FV9aySxnwwFILvHXUtBdooKnObuQNlH+7c/XZNsg0XsCShJMHPj6rr1YALC0eYA05RFi
 w9eI8COTrOUXzsyMtXnVCZXV/I0jrACD1U2kTyqQrzisz/tEnOskFqMYkukve02oE9gAvJzk4c6
 ishLDKAG6mk2Mxnuy7I6zBDCDZr71I2XiJJxQYguq/IHBrwKf/m2YsvVW1dLmCHV4ND8hudnzgo
 CfQ5Fd378ickP5TNFQjlzdW3rB5vg4eYQC7oQItDGM/dEPqtmkRY32CJxSOA4A==
X-Received: by 2002:a05:600c:4ec9:b0:495:62bc:a022 with SMTP id
 5b1f17b1804b1-4980c67474amr187754045e9.13.1785766270556; 
 Mon, 03 Aug 2026 07:11:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4980878dbaesm399016765e9.12.2026.08.03.07.11.10
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 07:11:10 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 3 Aug 2026 14:11:09 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
X-Gerrit-Change-Number: 1834
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1834?usp=email>
X-Gerrit-Commit: 33b81344a5ff26c81db9e93bc98c6ce2fa974d97
References: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1NzY2MjYwMDAwLkkzZGI3MDAwMWJlN2YzOWNmODRkNTYyNTE3NjQ3ZjFhMzA1OTYyYjQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cbe03ba3cead17f4dfed2b3a9f201672695c5b5d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wqtNt-0004wM-An
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6539555916348876115=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6539555916348876115==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LyLTOgWmEkY="; charset=UTF-8

--LyLTOgWmEkY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1834?usp=3Demail )


Change subject: Remove local get_ra=
ndom in test_misc=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Remove local get_random in test_misc=2Ec

The get_random in test=
_misc=2Ec conflicts
with the get_random function that OpenVPN defines in cr=
ypto=2Eh
Also adjust the implementation in mock_get_random=2Ec to match the=

prototype in crypto=2Eh

Change-Id: I3db70001be7f39cf84d562517647f1a305962=
b42
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M tests/unit_tests=
/openvpn/mock_get_random=2Ec
M tests/unit_tests/openvpn/test_misc=2Ec
2 fil=
es changed, 3 insertions(+), 9 deletions(-)



  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/34/1834/1

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
index 501286c=2E=2E8da7ab=
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
@@ -141,13 +142,6 @@
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
@ -263,7 +257,7 @@
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
-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
Gerrit-Change-Number=
: 1834
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--LyLTOgWmEkY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Remove local get_random in test_misc=2Ec<br><br>The get_random in =
test_misc=2Ec conflicts<br>with the get_random function that OpenVPN define=
s in crypto=2Eh<br>Also adjust the implementation in mock_get_random=2Ec to=
 match the<br>prototype in crypto=2Eh<br><br>Change-Id: I3db70001be7f39cf84=
d562517647f1a305962b42<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eor=
g&gt;<br>---<br>M tests/unit_tests/openvpn/mock_get_random=2Ec<br>M tests/u=
nit_tests/openvpn/test_misc=2Ec<br>2 files changed, 3 insertions(+), 9 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/34/1834/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/o=
penvpn/mock_get_random=2Ec b/tests/unit_tests/openvpn/mock_get_random=2Ec</=
span><br><span>index 0840e31=2E=2E5cb768b 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>+++ b/tests/unit_t=
ests/openvpn/mock_get_random=2Ec</span><br><span>@@ -28,7 +28,7 @@</span><b=
r><span> #include &lt;stdint=2Eh&gt;</span><br><span> #include &lt;cmocka=
=2Eh&gt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-unsigned long</span><br><span style=3D"color: hsl(120, 100%, 40%);">+i=
nt64_t</span><br><span> get_random(void)</span><br><span> {</span><br><span=
>     /* rand() is not very random, but it&#39;s C99 and this is just for t=
esting */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc=
=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>index 501286c=
=2E=2E8da7abe 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_mi=
sc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=2Ec</span><=
br><span>@@ -38,6 +38,7 @@</span><br><span> #include &quot;test_common=2Eh&=
quot;</span><br><span> #include &quot;list=2Eh&quot;</span><br><span> #incl=
ude &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;crypto=2Eh&quot;</span><br><span> #ifdef _WIN32</sp=
an><br><span> #include &quot;win32-util=2Eh&quot;</span><br><span> #endif</=
span><br><span>@@ -141,13 +142,6 @@</span><br><span>     return strcmp((con=
st char *)key1, (const char *)key2) =3D=3D 0;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static uint32_=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_random(void)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* rand() is not very random, but it&#3=
9;s C99 and this is just for testing */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return (uint32_t)rand();</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> static struct hash_element *</span><br><span> hash_l=
ookup_by_value(struct hash *hash, void *value)</span><br><span> {</span><br=
><span>@@ -263,7 +257,7 @@</span><br><span>         {</span><br><span>     =
        struct hash_iterator hi;</span><br><span>             struct hash_e=
lement *he;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  inc =3D (get_random() % 3) + 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            inc =3D ((uint32_t)get_random() % 3) + 1;</span><=
br><span>             hash_iterator_init_range(hash, &amp;hi, base, base + =
inc);</span><br><span> </span><br><span>             while ((he =3D hash_it=
erator_next(&amp;hi)))</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=3Demail">chang=
e 1834</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1834?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I3db70001be7f39cf84d562517647f1a305962b42 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1834 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--LyLTOgWmEkY=--


--===============6539555916348876115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6539555916348876115==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6539555916348876115==--

