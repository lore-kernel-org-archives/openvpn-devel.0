Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDCE3C5DF81
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GCwcUHKMOcfrJbF1CBJZp8kOqyet/p1Rxo5J8bLvdsg=; b=JwOD2GCBCdWtGWL9wuH8GH+jk3
	x6L29OeBdp+JDO04PZpaxolX+xIP1/TwDAZou1/AhXwQ8zYkTlpQpnHmVsSj/k6yRMch0Jy1Bf8fU
	1/JHjjKXjXPt/ZX24C8GQaXPxa9WcJXZOoJEtMzac8aJ15MBbwA4Gg+hjEdg+Dr2xjhs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwiVT-0006JQ-G3;
	Wed, 19 Aug 2026 15:47:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwiVS-0006JJ-5R
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:47:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k+/Lgj5pX16MmME8ziIVoKsRmWbZ4UYV/K4n2LK8hnQ=; b=PwbPmv05soYuYoooWjRl0/YTcD
 9paSN8LeYvtX9AkADguRPE38kH+t3cqyG6t+ucp953SIVQocN5sX5d9FAN/JKPAXqu3Yt+SNQkkTf
 jufZ56S3jitQ0kFTGcuFhuh4gJgzuClg6II63rVlyXD0CUyfdtwQYiYxlddj/+uSsxV0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k+/Lgj5pX16MmME8ziIVoKsRmWbZ4UYV/K4n2LK8hnQ=; b=I
 SW1C7LzP7L3RTAHgVMv5Uh0f4oLLpJgEX1srbkyJOLsjIyEtw69rha9KRutB6UHSLrPLBK+Dl8gBX
 ENGH1d+ifIyWTEXCO7x0bkIgoZUPDSVxl2X1fd8xYFqFRvyo7NaTeZgXwZ+ysDqkm4v2jwpPtJVm1
 jyVg6TR1aG1Z4PUo=;
Received: from mail-ed1-f49.google.com ([209.85.208.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwiVL-0008B3-FS for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 15:47:10 +0000
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6a173ad7cf4so1945990a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787154417; x=1787759217; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k+/Lgj5pX16MmME8ziIVoKsRmWbZ4UYV/K4n2LK8hnQ=;
 b=LL/VKwFZvB01ocPRzQm6XRcEGK/+sMGDrEoQa2L8E2zlIyowAxj4s8w/+ZR8NV86y3
 MOGxXBtVgAEnjIpWe2aufpPxFcD2EuEa3oMB/CVfAnlpimvXZJIcQmkOlUD9BRbKQq+K
 Pvrh0wh0SujJqjQn6/mNN6VJB0IdnhPaxfROXTlyfvbS9okJ5JFDZbVzFa8+DU54svAZ
 QRoCixj+LgGCAlM+GqWG486hrrRFujUVdTVHR+6kKxkUC3JTRDkl0uoI57ILFDJNECs2
 5V/dxOrGmD+1/8tsI4nfEngVTKmTOhqh7+I8itazJ7DniIUzJ/NE5XaKIXhAcdzm5hiC
 XFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787154417; x=1787759217;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k+/Lgj5pX16MmME8ziIVoKsRmWbZ4UYV/K4n2LK8hnQ=;
 b=WZ9JG4jvUip5yygFq6W+EQjY+SygeAkkU3mrJOYirV43MgYIMkBG2LkjJa64tD0w2b
 SCYi4z2BR7A9dqG02drJ3AOnp1k47HZvO9/mb5eVgIgnoWObMP6HwCZmfLTLwfZFvwam
 be0DkXI6CLCIxRPWyma+UC25qI14sBp1OCcjH3Kt/b4lPmKq9erD/5oNBDTuXhY70XNw
 8T7jk2rNQpcrNsTTWB0de2/B3gjJyrSudPMVQxHC8kioKmhsE+45E4Rsq6C4Bo+3rut4
 WBT0afo/wSxdZ1q3+qlyIwX/j6IaTN0FsuxPmSe7q0oj7NFuPvtMzG1Cc1AkQ7slzq5x
 iRMw==
X-Gm-Message-State: AOJu0YyXlj5iFclsFwDHMvxufKtN7w3kgpnOlenT2Y8qu3g1DqIWXp9Y
 PBRw++qe9Sqdvpby95XwpQX2Ddx5AzohQKKo7qrlcF8VqGCGtyUlSHlWS1G4xa4M9X9v3+IhEjj
 tHWlhGoano0A9v6rfM7x/DoSPERqgf+CX70oxhJrzpVUKpMRkA9gWIcUVrgswfeUo33xL0LkMwY
 qjrZ3Qag==
X-Gm-Gg: AR+sD1111vLyI+b3iy0Nii5uRTMua9grhSrpf8QbDOd8qUU9yBqO+DCHz6pZ/W2PsP3
 saUZDzakus1J9O7LnTByg5h4W5bGYJA1HQfPBpSiXqxYD6cZl/hT/Dsw+znV2aUmd3P5as6Oh0g
 DAENH8Tx937Hk+W9a1hwlE3b8tu0P8tGT6p+3dOiCqpDuhZp6kAkMT1hAhoVNlzgIT+bw6VmIgY
 TNo2Z6dss8f3wiGEndz+46q1teHB5/IYbugIHIkElNlOYjEtmSFZPhghElIn8o9xEEG2iFKvVIh
 rJ1o3WYqhSAisY1Co3oVr4ir4BYJ6+b461luRzzGX56/JkrDodIZ5llsoaqQYtl/ozEHo0IEPl9
 GblIFDg/wg4IBrmXnpIPeJx6sxK7NoPTrhsv3rO4LipUVny5HHm2ZL/hF2hhRnFwtKJYGPu3D49
 tNVKa0KPtHn2WDRr7F4Srmmr6xOJ6KoA/73bKicYLYzYlnZ27yqd1YBsiDiN6PDcClffprWwNa4
 gr0lBhtrV6veDyW/9h2UR3FmGmYHmlQs0U4f4sYzK3AfJ56Q4QO7A74Cyh/r9YNGl44PmsSqX3I
 o0RaeOf+7ifrbfkMOuR5uV357My1YiwWSlSC5pELcndpo2hDb1U=
X-Received: by 2002:a05:600c:1908:b0:499:5210:c537 with SMTP id
 5b1f17b1804b1-499aa17d6d8mr97369395e9.1.1787153960151; 
 Wed, 19 Aug 2026 08:39:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1441748sm6593766f8f.8.2026.08.19.08.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 08:39:19 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 15:39:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f
X-Gerrit-Change-Number: 1846
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1846?usp=email>
X-Gerrit-Commit: 82c8562de76089838ee7b4ad609aa6ab92f3bddc
In-Reply-To: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
References: <gerrit.1786968495000.I12bef330e2c8a5e5b21c2fa807584319b2b7101f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTY4NDk1MDAwLkkxMmJlZjMzMGUyYzhhNWU1YjIxYzJmYTgwNzU4NDMxOWIyYjcxMDFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <202e086855b09734137abe8cc676f2903f69b459-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwiVL-0008B3-FS
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Factor out address
 resolve code to a new file resolve.c
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7774126376111778513=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7774126376111778513==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+xqq2lYVX5w="; charset=UTF-8

--+xqq2lYVX5w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail

to loo=
k at the new patch set (#3)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc


Change subject: Factor out address r=
esolve code to a new file resolve=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Factor out address resolve code to a new file res=
olve=2Ec

The code was weirdly split between socket=2Ec, socket_util=2Ec,
a=
nd options=2Ec=2E The new structure makes more sense=2E

While here move so=
me related string helper code to buffer=2Eh=2E

Change-Id: I12bef330e2c8a5e=
5b21c2fa807584319b2b7101f
Signed-off-by: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/=
buffer=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/clinat=2Ec
M src/openvpn/=
dns=2Ec
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/optio=
ns=2Ec
M src/openvpn/options=2Eh
M src/openvpn/pool=2Ec
M src/openvpn/ps=2E=
c
M src/openvpn/push=2Ec
A src/openvpn/resolve=2Ec
A src/openvpn/resolve=2E=
h
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh=

M src/openvpn/socket_util=2Ec
M src/openvpn/socket_util=2Eh
M src/openvpn/=
tun=2Ec
21 files changed, 816 insertions(+), 709 deletions(-)


  git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/46/1846/3

diff --g=
it a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 2c3324d=2E=2E7f2b142 100644
=
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -567,6 +567,8 @@
     src/=
openvpn/reflect_filter=2Eh
     src/openvpn/reliable=2Ec
     src/openvpn/r=
eliable=2Eh
+    src/openvpn/resolve=2Ec
+    src/openvpn/resolve=2Eh
     =
src/openvpn/route=2Ec
     src/openvpn/route=2Eh
     src/openvpn/run_comma=
nd=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
i=
ndex 7fd12b4=2E=2E57bd3bd 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/=
openvpn/Makefile=2Eam
@@ -125,6 +125,7 @@
 	pushlist=2Eh \
 	reflect_filter=
=2Ec reflect_filter=2Eh \
 	reliable=2Ec reliable=2Eh \
+	resolve=2Ec resol=
ve=2Eh \
 	route=2Ec route=2Eh \
 	run_command=2Ec run_command=2Eh \
 	sche=
dule=2Ec schedule=2Eh \
diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/b=
uffer=2Ec
index 8c19902=2E=2E32bdb2d 100644
--- a/src/openvpn/buffer=2Ec
++=
+ b/src/openvpn/buffer=2Ec
@@ -1098,6 +1098,23 @@
     }
 }
 
+bool
+streqn=
ull(const char *a, const char *b)
+{
+    if (a =3D=3D NULL && b =3D=3D NUL=
L)
+    {
+        return true;
+    }
+    else if (a =3D=3D NULL || b =3D=
=3D NULL)
+    {
+        return false;
+    }
+    else
+    {
+        re=
turn streq(a, b);
+    }
+}
+
 char *
 string_substitute(const char *src, c=
har from, char to, struct gc_arena *gc)
 {
diff --git a/src/openvpn/buffer=
=2Eh b/src/openvpn/buffer=2Eh
index 651aaed=2E=2Eea6d8e4 100644
--- a/src/o=
penvpn/buffer=2Eh
+++ b/src/openvpn/buffer=2Eh
@@ -1766,6 +1766,18 @@
     =
return 0 =3D=3D strncmp(str, prefix, strlen(prefix));
 }
 
+/** helper to w=
ork around the semantics of the strcmp() return value
+ * @return true if t=
he strings are equal according to strcmp()
+ */
+#define streq(x, y) (!strc=
mp((x), (y)))
+
+/** compare two strings which might be NULL
+ * @return tr=
ue if both strings are NULL, or if they are equal according to strcmp()
+ *=
/
+bool streqnull(const char *a, const char *b);
+/** compare two strings w=
hich might be NULL, but NULL is never equal
+ * @return true if neither str=
ing is NULL and they are equal according to strcmp()
+ */
 bool string_defi=
ned_equal(const char *s1, const char *s2);
 char *string_substitute(const c=
har *src, char from, char to, struct gc_arena *gc);
 
diff --git a/src/open=
vpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index 32c1325=2E=2E3f42254 100644
-=
-- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -30,6 +30,7 @@
=
 #include "proto=2Eh"
 #include "socket_util=2Eh"
 #include "memdbg=2Eh"
+#=
include "resolve=2Eh"
 
 static bool
 add_entry(struct client_nat_option_li=
st *dest, const struct client_nat_entry *e)
diff --git a/src/openvpn/dns=2E=
c b/src/openvpn/dns=2Ec
index 1465cdf=2E=2E4535c99 100644
--- a/src/openvpn=
/dns=2Ec
+++ b/src/openvpn/dns=2Ec
@@ -27,7 +27,7 @@
 #include "syshead=2Eh=
"
 
 #include "dns=2Eh"
-#include "socket_util=2Eh"
+#include "resolve=2Eh"=

 #include "options=2Eh"
 #include "run_command=2Eh"
 #include "domain_help=
er=2Eh"
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index fa62=
cdd=2E=2E89a2c38 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -55,6 +55,7 @@
 #include "tun_afunix=2Eh"
 #include "schedule=2Eh"
=
 #include "options_string=2Eh"
+#include "resolve=2Eh"
 
 #include "memdbg=
=2Eh"
 
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index =
2a3023c=2E=2E2cea9df 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/=
manage=2Ec
@@ -44,6 +44,7 @@
 #include "dco=2Eh"
 #include "push=2Eh"
 #inc=
lude "multi=2Eh"
+#include "resolve=2Eh"
 
 #include "memdbg=2Eh"
 
diff --=
git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 418329e=2E=2E=
c7075be 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
=
@@ -64,6 +64,7 @@
 #include "domain_helper=2Eh"
 #include "mbuf=2Eh"
 #incl=
ude "check_file_access=2Eh"
+#include "resolve=2Eh"
 
 #include <ctype=2Eh>=

 
@@ -1038,26 +1039,6 @@
 
 #endif /* ifndef _WIN32 */
 
-static in_addr_t=

-get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error)
-{
-  =
  unsigned int flags =3D GETADDR_HOST_ORDER;
-    bool succeeded =3D false;=

-    in_addr_t ret;
-
-    if (msglevel & M_FATAL)
-    {
-        flags |=
=3D GETADDR_FATAL;
-    }
-
-    ret =3D getaddr(flags, ip_string, 0, &succ=
eeded, NULL);
-    if (!succeeded && error)
-    {
-        *error =3D true=
;
-    }
-    return ret;
-}
-
 /**
  * Returns newly allocated string cont=
aining address part without "/nn"=2E
  *
@@ -1080,13 +1061,6 @@
     }
    =
 return ret;
 }
-
-static bool
-ipv6_addr_safe_hexplusbits(const char *ipv6=
_prefix_spec)
-{
-    return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_=
WARN);
-}
-
 /**
  * Parses a hexstring and checks if the string has the co=
rrect length=2E Return
  * a verify_hash_list containing the parsed hash st=
ring=2E
@@ -3321,7 +3295,7 @@
     options_postprocess_verify(options);
 #i=
fndef ENABLE_SMALL
     options_postprocess_filechecks(options);
-#endif /*=
 !ENABLE_SMALL */
+#endif
 }
 
 /*
diff --git a/src/openvpn/options=2Eh b/s=
rc/openvpn/options=2Eh
index c23d0b3=2E=2E2b68a0e 100644
--- a/src/openvpn/=
options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -723,8 +723,6 @@
     unsigned=
 int imported_protocol_flags;
 };
 
-#define streq(x, y) (!strcmp((x), (y))=
)
-
 /*
  * Option classes=2E
  */
diff --git a/src/openvpn/pool=2Ec b/src/=
openvpn/pool=2Ec
index ff74e7c=2E=2E7e74649 100644
--- a/src/openvpn/pool=
=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -31,6 +31,7 @@
 #include "error=2Eh"
 #i=
nclude "socket_util=2Eh"
 #include "otime=2Eh"
+#include "resolve=2Eh"
 
 #=
include "memdbg=2Eh"
 
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec=

index c3f54ed=2E=2E2f596da 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openv=
pn/ps=2Ec
@@ -32,6 +32,7 @@
 #include "socket=2Eh"
 #include "fdmisc=2Eh"
 =
#include "crypto=2Eh"
+#include "resolve=2Eh"
 #include "ps=2Eh"
 
 #includ=
e "memdbg=2Eh"
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
ind=
ex 5b15f71=2E=2E467ebc9 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn=
/push=2Ec
@@ -37,6 +37,7 @@
 #include "memdbg=2Eh"
 #include "ssl_util=2Eh"=

 #include "options_util=2Eh"
+#include "resolve=2Eh"
 
 /*
  * Auth userna=
me/password
diff --git a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec
=
new file mode 100644
index 0000000=2E=2Eb8d9899
--- /dev/null
+++ b/src/ope=
nvpn/resolve=2Ec
@@ -0,0 +1,665 @@
+/*
+ *  OpenVPN -- An application to se=
curely tunnel IP networks
+ *             over a single TCP/UDP port, with =
support for SSL/TLS-based
+ *             session authentication and key ex=
change,
+ *             packet encryption, packet authentication, and
+ *  =
           packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN I=
nc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can re=
distribute it and/or modify
+ *  it under the terms of the GNU General Publ=
ic License version 2
+ *  as published by the Free Software Foundation=2E
+=
 *
+ *  This program is distributed in the hope that it will be useful,
+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General=
 Public License for more details=2E
+ *
+ *  You should have received a cop=
y of the GNU General Public License along
+ *  with this program; if not, s=
ee <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#in=
clude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "buffer=2E=
h"
+#include "crypto=2Eh"
+#include "manage=2Eh"
+#include "openvpn=2Eh"
+#=
include "socket=2Eh"
+#include "socket_util=2Eh"
+
+#include "resolve=2Eh"
=
+
+/*
+ * Convert sockflags/getaddr_flags into getaddr_flags
+ */
+unsigned=
 int
+sf2gaf(const unsigned int getaddr_flags, const unsigned int sockflags=
)
+{
+    if (sockflags & SF_HOST_RANDOMIZE)
+    {
+        return getaddr=
_flags | GETADDR_RANDOMIZE;
+    }
+    else
+    {
+        return getaddr=
_flags;
+    }
+}
+
+/*
+ * Functions related to the translation of DNS nam=
es to IP addresses=2E
+ */
+
+/**
+ * Small helper function for openvpn_get=
addrinfo to print the address
+ * family when resolving fails
+ */
+static =
const char *
+getaddrinfo_addr_family_name(int af)
+{
+    switch (af)
+   =
 {
+        case AF_INET:
+            return "[AF_INET]";
+
+        case =
AF_INET6:
+            return "[AF_INET6]";
+    }
+    return "";
+}
+
+/*=

+ * Prepend a random string to hostname to prevent DNS caching=2E
+ * For =
example, foo=2Ebar=2Egov would be modified to <random-chars>=2Efoo=2Ebar=2E=
gov=2E
+ * Of course, this requires explicit support in the DNS server (wil=
dcard)=2E
+ */
+static const char *
+hostname_randomize(const char *hostnam=
e, struct gc_arena *gc)
+{
+#define n_rnd_bytes 6
+
+    uint8_t rnd_bytes[=
n_rnd_bytes];
+    const char *rnd_str;
+    struct buffer hname =3D alloc_=
buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);
+
+    prng_bytes=
(rnd_bytes, sizeof(rnd_bytes));
+    rnd_str =3D format_hex_ex(rnd_bytes, s=
izeof(rnd_bytes), 40, 0, NULL, gc);
+    buf_printf(&hname, "%s=2E%s", rnd_=
str, hostname);
+    return BSTR(&hname);
+#undef n_rnd_bytes
+}
+
+/*
+ * =
Translate IPv4/IPv6 addr or hostname into struct addrinfo
+ * If resolve er=
ror, try again for resolve_retry_seconds seconds=2E
+ */
+int
+openvpn_geta=
ddrinfo(unsigned int flags, const char *hostname, const char *servname,
+  =
                  int resolve_retry_seconds, struct signal_info *sig_info, =
int ai_family,
+                    struct addrinfo **res)
+{
+    struct a=
ddrinfo hints;
+    int status;
+    struct signal_info sigrec =3D { 0 };
+=
    msglvl_t msglevel =3D (flags & GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERR=
ORS;
+    struct gc_arena gc =3D gc_new();
+    const char *print_hostname;=

+    const char *print_servname;
+
+    ASSERT(res);
+
+    ASSERT(hostnam=
e || servname);
+    ASSERT(!(flags & GETADDR_HOST_ORDER));
+
+    if (serv=
name)
+    {
+        print_servname =3D servname;
+    }
+    else
+    {
=
+        print_servname =3D "";
+    }
+
+    if (flags & GETADDR_MSG_VIRT_=
OUT)
+    {
+        msglevel |=3D M_MSG_VIRT_OUT;
+    }
+
+    if ((flags=
 & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) && !sig_info)
+    {=

+        sig_info =3D &sigrec;
+    }
+
+    /* try numeric ip addr first =
*/
+    CLEAR(hints);
+    hints=2Eai_flags =3D AI_NUMERICHOST;
+
+    if (=
flags & GETADDR_PASSIVE)
+    {
+        hints=2Eai_flags |=3D AI_PASSIVE;
=
+    }
+
+    if (flags & GETADDR_DATAGRAM)
+    {
+        hints=2Eai_sock=
type =3D SOCK_DGRAM;
+    }
+    else
+    {
+        hints=2Eai_socktype =
=3D SOCK_STREAM;
+    }
+
+    /* if hostname is not set, we want to bind t=
o 'ANY', with
+     * the correct address family - v4-only or v6/v6-dual-st=
ack */
+    if (!hostname)
+    {
+        hints=2Eai_family =3D ai_family;=

+    }
+
+    status =3D getaddrinfo(hostname, servname, &hints, res);
+
+=
    if (status !=3D 0)                      /* parse as numeric address fai=
led? */
+    {
+        const int fail_wait_interval =3D 5; /* seconds */
+=
        /* Add +4 to cause integer division rounding up (1 + 4) =3D 5, (0+4=
)/5=3D0 */
+        int resolve_retries =3D
+            (flags & GETADDR_T=
RY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval);
+       =
 const char *fmt;
+        msglvl_t level =3D 0;
+
+        /* this is not =
a numeric IP, therefore force resolution using the
+         * provided ai_=
family */
+        hints=2Eai_family =3D ai_family;
+
+        if (hostname=
 && (flags & GETADDR_RANDOMIZE))
+        {
+            hostname =3D hostn=
ame_randomize(hostname, &gc);
+        }
+
+        if (hostname)
+        =
{
+            print_hostname =3D hostname;
+        }
+        else
+     =
   {
+            print_hostname =3D "undefined";
+        }
+
+        fmt=
 =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)";
+        if ((fl=
ags & GETADDR_MENTION_RESOLVE_RETRY) && !resolve_retry_seconds)
+        {
=
+            fmt =3D "RESOLVE: Cannot resolve host address: %s:%s%s (%s)"
+=
                  "(I would have retried this name query if you had "
+    =
              "specified the --resolv-retry option=2E)";
+        }
+
+    =
    if (!(flags & GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)
+        {
+ =
           msg(msglevel, "RESOLVE: Cannot parse IP address: %s:%s (%s)", pr=
int_hostname,
+                print_servname, gai_strerror(status));
+    =
        goto done;
+        }
+
+#ifdef ENABLE_MANAGEMENT
+        if (flag=
s & GETADDR_UPDATE_MANAGEMENT_STATE)
+        {
+            if (management=
)
+            {
+                management_set_state(management, OPENVPN_=
STATE_RESOLVE, NULL, NULL, NULL, NULL,
+                                   =
  NULL);
+            }
+        }
+#endif
+
+        /*
+         * Resolv=
e hostname
+         */
+        while (true)
+        {
+#ifndef _WIN32
+ =
           /* force resolv=2Econf reload */
+            res_init();
+#endi=
f
+            /* try hostname lookup */
+            hints=2Eai_flags &=3D=
 ~AI_NUMERICHOST;
+            dmsg(D_SOCKET_DEBUG, "GETADDRINFO flags=3D0x=
%04x ai_family=3D%d ai_socktype=3D%d", flags,
+                 hints=2Eai_=
family, hints=2Eai_socktype);
+            status =3D getaddrinfo(hostname,=
 servname, &hints, res);
+
+            if (sig_info)
+            {
+     =
           get_signal(&sig_info->signal_received);
+                if (sig=
_info->signal_received) /* were we interrupted by a signal? */
+           =
     {
+                    /* why are we overwriting SIGUSR1 ? */
+       =
             if (signal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /* ignore =
SIGUSR1 */
+                    {
+                        msg(level, "RESO=
LVE: Ignored SIGUSR1 signal received during "
+                            =
       "DNS resolution attempt");
+                    }
+                 =
   else
+                    {
+                        /* turn success int=
o failure (interrupted syscall) */
+                        if (0 =3D=3D st=
atus)
+                        {
+                            ASSERT(res);
=
+                            freeaddrinfo(*res);
+                         =
   *res =3D NULL;
+                            status =3D EAI_AGAIN; /* =3D=
 temporary failure */
+                            errno =3D EINTR;
+      =
                  }
+                        goto done;
+                  =
  }
+                }
+            }
+
+            /* success? */
+      =
      if (0 =3D=3D status)
+            {
+                break;
+        =
    }
+
+            /* resolve lookup failed, should we
+             * co=
ntinue or fail? */
+            level =3D msglevel;
+            if (resolv=
e_retries > 0)
+            {
+                level =3D D_RESOLVE_ERRORS;
=
+            }
+
+            msg(level, fmt, print_hostname, print_servnam=
e, getaddrinfo_addr_family_name(ai_family),
+                gai_strerror(s=
tatus));
+
+            if (--resolve_retries <=3D 0)
+            {
+     =
           goto done;
+            }
+
+            management_sleep(fail_w=
ait_interval);
+        }
+
+        ASSERT(res);
+
+        /* hostname re=
solve succeeded */
+
+        /*
+         * Do not choose an IP Addresse b=
y random or change the order *
+         * of IP addresses, doing so will b=
reak RFC 3484 address selection *
+         */
+    }
+    else
+    {
+   =
     /* IP address parse succeeded */
+        if (flags & GETADDR_RANDOMIZ=
E)
+        {
+            msg(M_WARN, "WARNING: ignoring --remote-random-h=
ostname because the "
+                        "hostname is an IP address")=
;
+        }
+    }
+
+done:
+    if (sig_info && sig_info->signal_received=
)
+    {
+        msglvl_t level =3D 0;
+        if (flags & GETADDR_FATAL_=
ON_SIGNAL)
+        {
+            level =3D M_FATAL;
+        }
+        e=
lse if (flags & GETADDR_WARN_ON_SIGNAL)
+        {
+            level =3D M=
_WARN;
+        }
+        msg(level, "RESOLVE: signal received during DNS =
resolution attempt");
+    }
+
+    gc_free(&gc);
+    return status;
+}
+
=
+static int
+get_addr_generic(sa_family_t af, unsigned int flags, const cha=
r *hostname, void *network,
+                 unsigned int *netbits, int re=
solve_retry_seconds, struct signal_info *sig_info,
+                 msglvl=
_t msglevel)
+{
+    char *endp, *sep, *var_host =3D NULL;
+    struct addr=
info *ai =3D NULL;
+    unsigned long bits;
+    uint8_t max_bits;
+    int=
 ret =3D -1;
+
+    if (!hostname)
+    {
+        msg(M_NONFATAL, "Can't r=
esolve null hostname!");
+        goto out;
+    }
+
+    /* assign family =
specific default values */
+    switch (af)
+    {
+        case AF_INET:
+=
            bits =3D 0;
+            max_bits =3D sizeof(in_addr_t) * 8;
+ =
           break;
+
+        case AF_INET6:
+            bits =3D 64;
+    =
        max_bits =3D sizeof(struct in6_addr) * 8;
+            break;
+
+  =
      default:
+            msg(M_WARN, "Unsupported AF family passed to ge=
taddrinfo for %s (%d)", hostname, af);
+            goto out;
+    }
+
+   =
 /* we need to modify the hostname received as input, but we don't want to
=
+     * touch it directly as it might be a constant string=2E
+     *
+    =
 * Therefore, we clone the string here and free it at the end of the
+     =
* function */
+    var_host =3D strdup(hostname);
+    if (!var_host)
+    =
{
+        msg(M_NONFATAL | M_ERRNO, "Can't allocate hostname buffer for ge=
taddrinfo");
+        goto out;
+    }
+
+    /* check if this hostname has=
 a /bits suffix */
+    sep =3D strchr(var_host, '/');
+    if (sep)
+    {=

+        bits =3D strtoul(sep + 1, &endp, 10);
+        if ((*endp !=3D '\=
0') || (bits > max_bits))
+        {
+            msg(msglevel, "IP prefix =
'%s': invalid '/bits' spec (%s)", hostname, sep + 1);
+            goto out=
;
+        }
+        *sep =3D '\0';
+    }
+
+    ret =3D openvpn_getaddri=
nfo(flags & ~GETADDR_HOST_ORDER, var_host, NULL, resolve_retry_seconds,
+  =
                            sig_info, af, &ai);
+    if ((ret =3D=3D 0) && =
network)
+    {
+        struct in6_addr *ip6;
+        in_addr_t *ip4;
+
+=
        if (af !=3D ai->ai_family)
+        {
+            msg(msglevel, "C=
an't parse %s as IPv%d address", var_host, (af =3D=3D AF_INET) ? 4 : 6);
+ =
           ret =3D -1;
+            goto out;
+        }
+
+        switch =
(af)
+        {
+            case AF_INET:
+                ip4 =3D network=
;
+                *ip4 =3D ((struct sockaddr_in *)ai->ai_addr)->sin_addr=
=2Es_addr;
+
+                if (flags & GETADDR_HOST_ORDER)
+            =
    {
+                    *ip4 =3D ntohl(*ip4);
+                }
+      =
          break;
+
+            case AF_INET6:
+                ip6 =3D net=
work;
+                *ip6 =3D ((struct sockaddr_in6 *)ai->ai_addr)->sin6_=
addr;
+                break;
+
+            default:
+                /* c=
an't get here because 'af' was previously checked */
+                msg(M=
_WARN, "Unsupported AF family for %s (%d)", var_host, af);
+               =
 goto out;
+        }
+    }
+
+    if (netbits)
+    {
+        *netbits =
=3D (unsigned int)bits;
+    }
+
+    /* restore '/' separator, if any */
+=
    if (sep)
+    {
+        *sep =3D '/';
+    }
+out:
+    if (ai)
+    {=

+        freeaddrinfo(ai);
+    }
+    free(var_host);
+
+    return ret;
=
+}
+
+in_addr_t
+getaddr(unsigned int flags, const char *hostname, int reso=
lve_retry_seconds, bool *succeeded,
+        struct signal_info *sig_info)
=
+{
+    in_addr_t addr =3D { 0 };
+    int status;
+
+    status =3D get_ad=
dr_generic(AF_INET, flags, hostname, &addr, NULL, resolve_retry_seconds,
+ =
                             sig_info, M_WARN);
+    if (status =3D=3D 0)
+=
    {
+        if (succeeded)
+        {
+            *succeeded =3D true;
=
+        }
+        return addr;
+    }
+    else
+    {
+        if (succe=
eded)
+        {
+            *succeeded =3D false;
+        }
+        ret=
urn 0;
+    }
+}
+
+in_addr_t
+get_ip_addr(const char *ip_string, msglvl_t =
msglevel, bool *error)
+{
+    unsigned int flags =3D GETADDR_HOST_ORDER;
+=
    bool succeeded =3D false;
+    in_addr_t ret;
+
+    if (msglevel & M_F=
ATAL)
+    {
+        flags |=3D GETADDR_FATAL;
+    }
+
+    ret =3D getad=
dr(flags, ip_string, 0, &succeeded, NULL);
+    if (!succeeded && error)
+ =
   {
+        *error =3D true;
+    }
+    return ret;
+}
+
+bool
+get_ipv6=
_addr(const char *hostname, struct in6_addr *network, unsigned int *netbits=
,
+              msglvl_t msglevel)
+{
+    if (get_addr_generic(AF_INET6, =
GETADDR_RESOLVE, hostname, network, netbits, 0, NULL, msglevel)
+        < =
0)
+    {
+        return false;
+    }
+
+    return true; /* parsing OK, =
values set */
+}
+
+/*
+ * get_cached_dns_entry return 0 on success and -1
=
+ * otherwise=2E (like getaddrinfo)
+ */
+int
+get_cached_dns_entry(struct =
cached_dns_entry *dns_cache, const char *hostname, const char *servname,
+ =
                    int ai_family, unsigned int resolve_flags, struct addri=
nfo **ai)
+{
+    struct cached_dns_entry *ph;
+    unsigned int flags;
+
+=
    /* Only use flags that are relevant for the structure */
+    flags =3D=
 resolve_flags & GETADDR_CACHE_MASK;
+
+    for (ph =3D dns_cache; ph; ph =
=3D ph->next)
+    {
+        if (streqnull(ph->hostname, hostname) && stre=
qnull(ph->servname, servname)
+            && ph->ai_family =3D=3D ai_famil=
y && ph->flags =3D=3D flags)
+        {
+            *ai =3D ph->ai;
+     =
       return 0;
+        }
+    }
+    return -1;
+}
+
+
+static int
+do_p=
reresolve_host(struct context *c, const char *hostname, const char *servnam=
e, const int af,
+                   const unsigned int flags)
+{
+    stru=
ct addrinfo *ai;
+    int status;
+
+    if (get_cached_dns_entry(c->c1=2Ed=
ns_cache, hostname, servname, af, flags, &ai) =3D=3D 0)
+    {
+        /* =
entry already cached, return success */
+        return 0;
+    }
+
+    st=
atus =3D openvpn_getaddrinfo(flags, hostname, servname, c->options=2Eresolv=
e_retry_seconds, NULL,
+                                 af, &ai);
+    if =
(status =3D=3D 0)
+    {
+        struct cached_dns_entry *ph;
+
+        A=
LLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &c->gc);
+        ph->ai =3D=
 ai;
+        ph->hostname =3D hostname;
+        ph->servname =3D servname=
;
+        ph->flags =3D flags & GETADDR_CACHE_MASK;
+
+        if (!c->c1=
=2Edns_cache)
+        {
+            c->c1=2Edns_cache =3D ph;
+        }
=
+        else
+        {
+            struct cached_dns_entry *prev =3D c->=
c1=2Edns_cache;
+            while (prev->next)
+            {
+           =
     prev =3D prev->next;
+            }
+            prev->next =3D ph;
+ =
       }
+
+        gc_addspecial(ai, &gc_freeaddrinfo_callback, &c->gc);
+=
    }
+    return status;
+}
+
+void
+do_preresolve(struct context *c)
+{
+=
    struct connection_list *l =3D c->options=2Econnection_list;
+    const =
unsigned int preresolve_flags =3D GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEME=
NT_STATE
+                                          | GETADDR_MENTION_RESOL=
VE_RETRY | GETADDR_FATAL;
+
+
+    for (int i =3D 0; i < l->len; ++i)
+    =
{
+        int status;
+        const char *remote;
+        unsigned int f=
lags =3D preresolve_flags;
+
+        struct connection_entry *ce =3D l->ar=
ray[i];
+
+        if (proto_is_dgram(ce->proto))
+        {
+            f=
lags |=3D GETADDR_DATAGRAM;
+        }
+
+        if (c->options=2Esockflag=
s & SF_HOST_RANDOMIZE)
+        {
+            flags |=3D GETADDR_RANDOMIZE=
;
+        }
+
+        if (c->options=2Eip_remote_hint)
+        {
+      =
      remote =3D c->options=2Eip_remote_hint;
+        }
+        else
+   =
     {
+            remote =3D ce->remote;
+        }
+
+        /* HTTP re=
mote hostname does not need to be resolved */
+        if (!ce->http_proxy_=
options)
+        {
+            status =3D do_preresolve_host(c, remote, c=
e->remote_port, ce->af, flags);
+            if (status !=3D 0)
+          =
  {
+                goto err;
+            }
+        }
+
+        /* Prer=
esolve proxy */
+        if (ce->http_proxy_options)
+        {
+          =
  status =3D do_preresolve_host(c, ce->http_proxy_options->server,
+       =
                                 ce->http_proxy_options->port, ce->af, prer=
esolve_flags);
+
+            if (status !=3D 0)
+            {
+          =
      goto err;
+            }
+        }
+
+        if (ce->socks_proxy_se=
rver)
+        {
+            status =3D
+                do_preresolve_hos=
t(c, ce->socks_proxy_server, ce->socks_proxy_port, ce->af, flags);
+       =
     if (status !=3D 0)
+            {
+                goto err;
+        =
    }
+        }
+
+        if (ce->bind_local)
+        {
+            fla=
gs |=3D GETADDR_PASSIVE;
+            flags &=3D ~GETADDR_RANDOMIZE;
+
+   =
         for (int j =3D 0; j < ce->local_list->len; j++)
+            {
+  =
              const struct local_entry *le =3D ce->local_list->array[j];
+
=
+                if (!le->local)
+                {
+                    co=
ntinue;
+                }
+
+                status =3D do_preresolve_host=
(c, le->local, le->port, ce->af, flags);
+                if (status !=3D 0=
)
+                {
+                    goto err;
+                }
+   =
         }
+        }
+    }
+    return;
+
+err:
+    throw_signal_soft(SI=
GHUP, "Preresolving failed");
+}
diff --git a/src/openvpn/resolve=2Eh b/src=
/openvpn/resolve=2Eh
new file mode 100644
index 0000000=2E=2E9069af7
--- /d=
ev/null
+++ b/src/openvpn/resolve=2Eh
@@ -0,0 +1,106 @@
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
) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
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
is program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
=
+ * @file
+ * DNS resolution
+ */
+#ifndef RESOLVE_H
+#define RESOLVE_H
+
+=
#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2E=
h"
+
+#include "sig=2Eh"
+
+#define GETADDR_RESOLVE                 (1u << =
0)
+#define GETADDR_FATAL                   (1u << 1)
+#define GETADDR_HOST=
_ORDER              (1u << 2)
+#define GETADDR_MENTION_RESOLVE_RETRY   (1u =
<< 3)
+#define GETADDR_FATAL_ON_SIGNAL         (1u << 4)
+#define GETADDR_W=
ARN_ON_SIGNAL          (1u << 5)
+#define GETADDR_MSG_VIRT_OUT            (=
1u << 6)
+#define GETADDR_TRY_ONCE                (1u << 7)
+#define GETADD=
R_UPDATE_MANAGEMENT_STATE (1u << 8)
+#define GETADDR_RANDOMIZE             =
  (1u << 9)
+#define GETADDR_PASSIVE                 (1u << 10)
+#define GE=
TADDR_DATAGRAM                (1u << 11)
+
+#define GETADDR_CACHE_MASK (GET=
ADDR_DATAGRAM | GETADDR_PASSIVE)
+
+/**
+ * Convert sockflags/getaddr_flags=
 into getaddr_flags
+ */
+unsigned int sf2gaf(const unsigned int getaddr_fl=
ags, const unsigned int sockflags);
+
+/**
+ * Translate an IPv4 addr or ho=
stname from string form to in_addr_t
+ *
+ * In case of resolve error, it w=
ill try again for
+ * resolve_retry_seconds seconds=2E
+ */
+in_addr_t geta=
ddr(unsigned int flags, const char *hostname, int resolve_retry_seconds,
+ =
                 bool *succeeded, struct signal_info *sig_info);
+
+in_addr=
_t get_ip_addr(const char *ip_string, msglvl_t msglevel, bool *error);
+
+/=
**
+ * Translate an IPv6 addr or hostname from string form to in6_addr
+ */=

+bool get_ipv6_addr(const char *hostname, struct in6_addr *network, unsign=
ed int *netbits,
+                   msglvl_t msglevel);
+
+static inline b=
ool
+ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)
+{
+    retur=
n get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);
+}
+
+int openvpn_ge=
taddrinfo(unsigned int flags, const char *hostname, const char *servname,
+=
                        int resolve_retry_seconds, struct signal_info *sig_=
info, int ai_family,
+                        struct addrinfo **res);
+
+vo=
id do_preresolve(struct context *c);
+
+/* struct to hold preresolved host =
names */
+struct cached_dns_entry
+{
+    const char *hostname;
+    const =
char *servname;
+    int ai_family;
+    unsigned int flags;
+    struct ad=
drinfo *ai;
+    struct cached_dns_entry *next;
+};
+
+/**
+ * get_cached_d=
ns_entry return 0 on success and -1
+ * otherwise=2E (like getaddrinfo())
+=
 */
+int get_cached_dns_entry(struct cached_dns_entry *dns_cache, const cha=
r *hostname,
+                         const char *servname, int ai_family,=

+                         unsigned int resolve_flags, struct addrinfo **ai=
);
+
+#endif /* RESOLVE_H */
diff --git a/src/openvpn/route=2Ec b/src/openv=
pn/route=2Ec
index 8ea745d=2E=2E8e828ae 100644
--- a/src/openvpn/route=2Ec
=
+++ b/src/openvpn/route=2Ec
@@ -42,6 +42,7 @@
 #include "options=2Eh"
 #inc=
lude "networking=2Eh"
 #include "integer=2Eh"
+#include "resolve=2Eh"
 
 #i=
nclude "memdbg=2Eh"
 
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/soc=
ket=2Ec
index 0f66ad51=2E=2Edec4229 100644
--- a/src/openvpn/socket=2Ec
+++=
 b/src/openvpn/socket=2Ec
@@ -38,6 +38,7 @@
 #include "manage=2Eh"
 #includ=
e "openvpn=2Eh"
 #include "forward=2Eh"
+#include "resolve=2Eh"
 
 #include=
 "memdbg=2Eh"
 
@@ -54,366 +55,6 @@
     return false;
 }
 
-/*
- * Convert=
 sockflags/getaddr_flags into getaddr_flags
- */
-static unsigned int
-sf2g=
af(const unsigned int getaddr_flags, const unsigned int sockflags)
-{
-    =
if (sockflags & SF_HOST_RANDOMIZE)
-    {
-        return getaddr_flags | G=
ETADDR_RANDOMIZE;
-    }
-    else
-    {
-        return getaddr_flags;
- =
   }
-}
-
-/*
- * Functions related to the translation of DNS names to IP a=
ddresses=2E
- */
-static int
-get_addr_generic(sa_family_t af, unsigned int=
 flags, const char *hostname, void *network,
-                 unsigned int=
 *netbits, int resolve_retry_seconds, struct signal_info *sig_info,
-      =
           msglvl_t msglevel)
-{
-    char *endp, *sep, *var_host =3D NULL;=

-    struct addrinfo *ai =3D NULL;
-    unsigned long bits;
-    uint8_t m=
ax_bits;
-    int ret =3D -1;
-
-    if (!hostname)
-    {
-        msg(M_N=
ONFATAL, "Can't resolve null hostname!");
-        goto out;
-    }
-
-    =
/* assign family specific default values */
-    switch (af)
-    {
-      =
  case AF_INET:
-            bits =3D 0;
-            max_bits =3D sizeof(i=
n_addr_t) * 8;
-            break;
-
-        case AF_INET6:
-            b=
its =3D 64;
-            max_bits =3D sizeof(struct in6_addr) * 8;
-       =
     break;
-
-        default:
-            msg(M_WARN, "Unsupported AF fa=
mily passed to getaddrinfo for %s (%d)", hostname, af);
-            goto o=
ut;
-    }
-
-    /* we need to modify the hostname received as input, but =
we don't want to
-     * touch it directly as it might be a constant string=
=2E
-     *
-     * Therefore, we clone the string here and free it at the =
end of the
-     * function */
-    var_host =3D strdup(hostname);
-    if =
(!var_host)
-    {
-        msg(M_NONFATAL | M_ERRNO, "Can't allocate hostn=
ame buffer for getaddrinfo");
-        goto out;
-    }
-
-    /* check if =
this hostname has a /bits suffix */
-    sep =3D strchr(var_host, '/');
-  =
  if (sep)
-    {
-        bits =3D strtoul(sep + 1, &endp, 10);
-        i=
f ((*endp !=3D '\0') || (bits > max_bits))
-        {
-            msg(msgl=
evel, "IP prefix '%s': invalid '/bits' spec (%s)", hostname, sep + 1);
-   =
         goto out;
-        }
-        *sep =3D '\0';
-    }
-
-    ret =3D=
 openvpn_getaddrinfo(flags & ~GETADDR_HOST_ORDER, var_host, NULL, resolve_r=
etry_seconds,
-                              sig_info, af, &ai);
-    if ((=
ret =3D=3D 0) && network)
-    {
-        struct in6_addr *ip6;
-        in=
_addr_t *ip4;
-
-        if (af !=3D ai->ai_family)
-        {
-           =
 msg(msglevel, "Can't parse %s as IPv%d address", var_host, (af =3D=3D AF_I=
NET) ? 4 : 6);
-            ret =3D -1;
-            goto out;
-        }
-=

-        switch (af)
-        {
-            case AF_INET:
-              =
  ip4 =3D network;
-                *ip4 =3D ((struct sockaddr_in *)ai->ai_=
addr)->sin_addr=2Es_addr;
-
-                if (flags & GETADDR_HOST_ORDER=
)
-                {
-                    *ip4 =3D ntohl(*ip4);
-          =
      }
-                break;
-
-            case AF_INET6:
-            =
    ip6 =3D network;
-                *ip6 =3D ((struct sockaddr_in6 *)ai->=
ai_addr)->sin6_addr;
-                break;
-
-            default:
-     =
           /* can't get here because 'af' was previously checked */
-      =
          msg(M_WARN, "Unsupported AF family for %s (%d)", var_host, af);
-=
                goto out;
-        }
-    }
-
-    if (netbits)
-    {
-   =
     *netbits =3D (unsigned int)bits;
-    }
-
-    /* restore '/' separato=
r, if any */
-    if (sep)
-    {
-        *sep =3D '/';
-    }
-out:
-    =
if (ai)
-    {
-        freeaddrinfo(ai);
-    }
-    free(var_host);
-
-  =
  return ret;
-}
-
-in_addr_t
-getaddr(unsigned int flags, const char *host=
name, int resolve_retry_seconds, bool *succeeded,
-        struct signal_in=
fo *sig_info)
-{
-    in_addr_t addr =3D { 0 };
-    int status;
-
-    sta=
tus =3D get_addr_generic(AF_INET, flags, hostname, &addr, NULL, resolve_ret=
ry_seconds,
-                              sig_info, M_WARN);
-    if (stat=
us =3D=3D 0)
-    {
-        if (succeeded)
-        {
-            *succee=
ded =3D true;
-        }
-        return addr;
-    }
-    else
-    {
-   =
     if (succeeded)
-        {
-            *succeeded =3D false;
-        =
}
-        return 0;
-    }
-}
-
-bool
-get_ipv6_addr(const char *hostname,=
 struct in6_addr *network, unsigned int *netbits,
-              msglvl_t m=
sglevel)
-{
-    if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, =
network, netbits, 0, NULL, msglevel)
-        < 0)
-    {
-        return f=
alse;
-    }
-
-    return true; /* parsing OK, values set */
-}
-
-static =
inline bool
-streqnull(const char *a, const char *b)
-{
-    if (a =3D=3D N=
ULL && b =3D=3D NULL)
-    {
-        return true;
-    }
-    else if (a =
=3D=3D NULL || b =3D=3D NULL)
-    {
-        return false;
-    }
-    els=
e
-    {
-        return streq(a, b);
-    }
-}
-
-/*
- * get_cached_dns_en=
try return 0 on success and -1
- * otherwise=2E (like getaddrinfo)
- */
-st=
atic int
-get_cached_dns_entry(struct cached_dns_entry *dns_cache, const ch=
ar *hostname, const char *servname,
-                     int ai_family, un=
signed int resolve_flags, struct addrinfo **ai)
-{
-    struct cached_dns_e=
ntry *ph;
-    unsigned int flags;
-
-    /* Only use flags that are releva=
nt for the structure */
-    flags =3D resolve_flags & GETADDR_CACHE_MASK;
=
-
-    for (ph =3D dns_cache; ph; ph =3D ph->next)
-    {
-        if (stre=
qnull(ph->hostname, hostname) && streqnull(ph->servname, servname)
-       =
     && ph->ai_family =3D=3D ai_family && ph->flags =3D=3D flags)
-        =
{
-            *ai =3D ph->ai;
-            return 0;
-        }
-    }
-  =
  return -1;
-}
-
-
-static int
-do_preresolve_host(struct context *c, cons=
t char *hostname, const char *servname, const int af,
-                   c=
onst unsigned int flags)
-{
-    struct addrinfo *ai;
-    int status;
-
- =
   if (get_cached_dns_entry(c->c1=2Edns_cache, hostname, servname, af, flag=
s, &ai) =3D=3D 0)
-    {
-        /* entry already cached, return success *=
/
-        return 0;
-    }
-
-    status =3D openvpn_getaddrinfo(flags, ho=
stname, servname, c->options=2Eresolve_retry_seconds, NULL,
-              =
                   af, &ai);
-    if (status =3D=3D 0)
-    {
-        stru=
ct cached_dns_entry *ph;
-
-        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dn=
s_entry, &c->gc);
-        ph->ai =3D ai;
-        ph->hostname =3D hostnam=
e;
-        ph->servname =3D servname;
-        ph->flags =3D flags & GETAD=
DR_CACHE_MASK;
-
-        if (!c->c1=2Edns_cache)
-        {
-            c=
->c1=2Edns_cache =3D ph;
-        }
-        else
-        {
-            s=
truct cached_dns_entry *prev =3D c->c1=2Edns_cache;
-            while (pre=
v->next)
-            {
-                prev =3D prev->next;
-            =
}
-            prev->next =3D ph;
-        }
-
-        gc_addspecial(ai, &=
gc_freeaddrinfo_callback, &c->gc);
-    }
-    return status;
-}
-
-void
-d=
o_preresolve(struct context *c)
-{
-    struct connection_list *l =3D c->op=
tions=2Econnection_list;
-    const unsigned int preresolve_flags =3D GETAD=
DR_RESOLVE | GETADDR_UPDATE_MANAGEMENT_STATE
-                             =
             | GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATAL;
-
-
-    for =
(int i =3D 0; i < l->len; ++i)
-    {
-        int status;
-        const c=
har *remote;
-        unsigned int flags =3D preresolve_flags;
-
-        s=
truct connection_entry *ce =3D l->array[i];
-
-        if (proto_is_dgram(c=
e->proto))
-        {
-            flags |=3D GETADDR_DATAGRAM;
-        }
=
-
-        if (c->options=2Esockflags & SF_HOST_RANDOMIZE)
-        {
-    =
        flags |=3D GETADDR_RANDOMIZE;
-        }
-
-        if (c->options=
=2Eip_remote_hint)
-        {
-            remote =3D c->options=2Eip_remot=
e_hint;
-        }
-        else
-        {
-            remote =3D ce->rem=
ote;
-        }
-
-        /* HTTP remote hostname does not need to be reso=
lved */
-        if (!ce->http_proxy_options)
-        {
-            statu=
s =3D do_preresolve_host(c, remote, ce->remote_port, ce->af, flags);
-     =
       if (status !=3D 0)
-            {
-                goto err;
-      =
      }
-        }
-
-        /* Preresolve proxy */
-        if (ce->http_=
proxy_options)
-        {
-            status =3D do_preresolve_host(c, ce-=
>http_proxy_options->server,
-                                        ce->h=
ttp_proxy_options->port, ce->af, preresolve_flags);
-
-            if (stat=
us !=3D 0)
-            {
-                goto err;
-            }
-      =
  }
-
-        if (ce->socks_proxy_server)
-        {
-            status =
=3D
-                do_preresolve_host(c, ce->socks_proxy_server, ce->sock=
s_proxy_port, ce->af, flags);
-            if (status !=3D 0)
-            =
{
-                goto err;
-            }
-        }
-
-        if (ce->b=
ind_local)
-        {
-            flags |=3D GETADDR_PASSIVE;
-           =
 flags &=3D ~GETADDR_RANDOMIZE;
-
-            for (int j =3D 0; j < ce->lo=
cal_list->len; j++)
-            {
-                struct local_entry *le =
=3D ce->local_list->array[j];
-
-                if (!le->local)
-         =
       {
-                    continue;
-                }
-
-             =
   status =3D do_preresolve_host(c, le->local, le->port, ce->af, flags);
- =
               if (status !=3D 0)
-                {
-                    g=
oto err;
-                }
-            }
-        }
-    }
-    return;
-=

-err:
-    throw_signal_soft(SIGHUP, "Preresolving failed");
-}
-
 static =
int
 socket_get_sndbuf(socket_descriptor_t sd)
 {
diff --git a/src/openvpn/=
socket=2Eh b/src/openvpn/socket=2Eh
index 1a532e1=2E=2E15934f9 100644
--- a=
/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -62,17 +62,6 @@
 /*=
 convert a packet_size_type from network to host order */
 #define ntohps(x=
) ntohs(x)
 
-/* struct to hold preresolved host names */
-struct cached_dn=
s_entry
-{
-    const char *hostname;
-    const char *servname;
-    int a=
i_family;
-    unsigned int flags;
-    struct addrinfo *ai;
-    struct ca=
ched_dns_entry *next;
-};
-
 /* IP addresses which are persistent across SI=
GUSR1s */
 struct link_socket_addr
 {
@@ -362,8 +351,6 @@
 
 void link_sock=
et_init_phase2(struct context *c, struct link_socket *sock);
 
-void do_pre=
resolve(struct context *c);
-
 void link_socket_close(struct link_socket *s=
ock);
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/src/openvpn/socket_util=2Ec =
b/src/openvpn/socket_util=2Ec
index 0194f38=2E=2E5d405ac 100644
--- a/src/o=
penvpn/socket_util=2Ec
+++ b/src/openvpn/socket_util=2Ec
@@ -490,271 +490,6=
 @@
     return ""; /* Make the compiler happy */
 }
 
-/**
- * Small helpe=
r function for openvpn_getaddrinfo to print the address
- * family when res=
olving fails
- */
-static const char *
-getaddrinfo_addr_family_name(int af=
)
-{
-    switch (af)
-    {
-        case AF_INET:
-            return "[A=
F_INET]";
-
-        case AF_INET6:
-            return "[AF_INET6]";
-    =
}
-    return "";
-}
-
-/*
- * Prepend a random string to hostname to preve=
nt DNS caching=2E
- * For example, foo=2Ebar=2Egov would be modified to <ra=
ndom-chars>=2Efoo=2Ebar=2Egov=2E
- * Of course, this requires explicit supp=
ort in the DNS server (wildcard)=2E
- */
-static const char *
-hostname_ran=
domize(const char *hostname, struct gc_arena *gc)
-{
-#define n_rnd_bytes 6=

-
-    uint8_t rnd_bytes[n_rnd_bytes];
-    const char *rnd_str;
-    stru=
ct buffer hname =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 +=
 4, gc);
-
-    prng_bytes(rnd_bytes, sizeof(rnd_bytes));
-    rnd_str =3D =
format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);
-    buf_prin=
tf(&hname, "%s=2E%s", rnd_str, hostname);
-    return BSTR(&hname);
-#undef=
 n_rnd_bytes
-}
-
-/*
- * Translate IPv4/IPv6 addr or hostname into struct =
addrinfo
- * If resolve error, try again for resolve_retry_seconds seconds=
=2E
- */
-int
-openvpn_getaddrinfo(unsigned int flags, const char *hostname=
, const char *servname,
-                    int resolve_retry_seconds, str=
uct signal_info *sig_info, int ai_family,
-                    struct addri=
nfo **res)
-{
-    struct addrinfo hints;
-    int status;
-    struct sign=
al_info sigrec =3D { 0 };
-    msglvl_t msglevel =3D (flags & GETADDR_FATAL=
) ? M_FATAL : D_RESOLVE_ERRORS;
-    struct gc_arena gc =3D gc_new();
-    =
const char *print_hostname;
-    const char *print_servname;
-
-    ASSERT(=
res);
-
-    ASSERT(hostname || servname);
-    ASSERT(!(flags & GETADDR_HO=
ST_ORDER));
-
-    if (servname)
-    {
-        print_servname =3D servnam=
e;
-    }
-    else
-    {
-        print_servname =3D "";
-    }
-
-    if=
 (flags & GETADDR_MSG_VIRT_OUT)
-    {
-        msglevel |=3D M_MSG_VIRT_OU=
T;
-    }
-
-    if ((flags & (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SI=
GNAL)) && !sig_info)
-    {
-        sig_info =3D &sigrec;
-    }
-
-    /*=
 try numeric ip addr first */
-    CLEAR(hints);
-    hints=2Eai_flags =3D =
AI_NUMERICHOST;
-
-    if (flags & GETADDR_PASSIVE)
-    {
-        hints=
=2Eai_flags |=3D AI_PASSIVE;
-    }
-
-    if (flags & GETADDR_DATAGRAM)
- =
   {
-        hints=2Eai_socktype =3D SOCK_DGRAM;
-    }
-    else
-    {
-=
        hints=2Eai_socktype =3D SOCK_STREAM;
-    }
-
-    /* if hostname i=
s not set, we want to bind to 'ANY', with
-     * the correct address famil=
y - v4-only or v6/v6-dual-stack */
-    if (!hostname)
-    {
-        hint=
s=2Eai_family =3D ai_family;
-    }
-
-    status =3D getaddrinfo(hostname,=
 servname, &hints, res);
-
-    if (status !=3D 0)                      /* =
parse as numeric address failed? */
-    {
-        const int fail_wait_int=
erval =3D 5; /* seconds */
-        /* Add +4 to cause integer division rou=
nding up (1 + 4) =3D 5, (0+4)/5=3D0 */
-        int resolve_retries =3D
-  =
          (flags & GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / f=
ail_wait_interval);
-        const char *fmt;
-        msglvl_t level =3D 0=
;
-
-        /* this is not a numeric IP, therefore force resolution using =
the
-         * provided ai_family */
-        hints=2Eai_family =3D ai_fam=
ily;
-
-        if (hostname && (flags & GETADDR_RANDOMIZE))
-        {
-  =
          hostname =3D hostname_randomize(hostname, &gc);
-        }
-
-   =
     if (hostname)
-        {
-            print_hostname =3D hostname;
-  =
      }
-        else
-        {
-            print_hostname =3D "undefined=
";
-        }
-
-        fmt =3D "RESOLVE: Cannot resolve host address: %s:=
%s%s (%s)";
-        if ((flags & GETADDR_MENTION_RESOLVE_RETRY) && !resolv=
e_retry_seconds)
-        {
-            fmt =3D "RESOLVE: Cannot resolve h=
ost address: %s:%s%s (%s)"
-                  "(I would have retried this n=
ame query if you had "
-                  "specified the --resolv-retry opt=
ion=2E)";
-        }
-
-        if (!(flags & GETADDR_RESOLVE) || status =
=3D=3D EAI_FAIL)
-        {
-            msg(msglevel, "RESOLVE: Cannot par=
se IP address: %s:%s (%s)", print_hostname,
-                print_servname=
, gai_strerror(status));
-            goto done;
-        }
-
-#ifdef ENABL=
E_MANAGEMENT
-        if (flags & GETADDR_UPDATE_MANAGEMENT_STATE)
-       =
 {
-            if (management)
-            {
-                management_=
set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NULL, NULL,
-     =
                                NULL);
-            }
-        }
-#endif
-
=
-        /*
-         * Resolve hostname
-         */
-        while (true)=

-        {
-#ifndef _WIN32
-            /* force resolv=2Econf reload */
-=
            res_init();
-#endif
-            /* try hostname lookup */
-   =
         hints=2Eai_flags &=3D ~AI_NUMERICHOST;
-            dmsg(D_SOCKET_=
DEBUG, "GETADDRINFO flags=3D0x%04x ai_family=3D%d ai_socktype=3D%d", flags,=

-                 hints=2Eai_family, hints=2Eai_socktype);
-            st=
atus =3D getaddrinfo(hostname, servname, &hints, res);
-
-            if (s=
ig_info)
-            {
-                get_signal(&sig_info->signal_recei=
ved);
-                if (sig_info->signal_received) /* were we interrupte=
d by a signal? */
-                {
-                    /* why are we ove=
rwriting SIGUSR1 ? */
-                    if (signal_reset(sig_info, SIGUS=
R1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */
-                    {
-          =
              msg(level, "RESOLVE: Ignored SIGUSR1 signal received during "=

-                                   "DNS resolution attempt");
-          =
          }
-                    else
-                    {
-             =
           /* turn success into failure (interrupted syscall) */
-         =
               if (0 =3D=3D status)
-                        {
-           =
                 ASSERT(res);
-                            freeaddrinfo(*re=
s);
-                            *res =3D NULL;
-                          =
  status =3D EAI_AGAIN; /* =3D temporary failure */
-                      =
      errno =3D EINTR;
-                        }
-                        =
goto done;
-                    }
-                }
-            }
-
-    =
        /* success? */
-            if (0 =3D=3D status)
-            {
-  =
              break;
-            }
-
-            /* resolve lookup failed=
, should we
-             * continue or fail? */
-            level =3D msg=
level;
-            if (resolve_retries > 0)
-            {
-              =
  level =3D D_RESOLVE_ERRORS;
-            }
-
-            msg(level, fmt,=
 print_hostname, print_servname, getaddrinfo_addr_family_name(ai_family),
-=
                gai_strerror(status));
-
-            if (--resolve_retries=
 <=3D 0)
-            {
-                goto done;
-            }
-
-     =
       management_sleep(fail_wait_interval);
-        }
-
-        ASSERT(r=
es);
-
-        /* hostname resolve succeeded */
-
-        /*
-         * =
Do not choose an IP Addresse by random or change the order *
-         * of=
 IP addresses, doing so will break RFC 3484 address selection *
-         *=
/
-    }
-    else
-    {
-        /* IP address parse succeeded */
-      =
  if (flags & GETADDR_RANDOMIZE)
-        {
-            msg(M_WARN, "WARNI=
NG: ignoring --remote-random-hostname because the "
-                      =
  "hostname is an IP address");
-        }
-    }
-
-done:
-    if (sig_inf=
o && sig_info->signal_received)
-    {
-        msglvl_t level =3D 0;
-    =
    if (flags & GETADDR_FATAL_ON_SIGNAL)
-        {
-            level =3D =
M_FATAL;
-        }
-        else if (flags & GETADDR_WARN_ON_SIGNAL)
-    =
    {
-            level =3D M_WARN;
-        }
-        msg(level, "RESOLV=
E: signal received during DNS resolution attempt");
-    }
-
-    gc_free(&=
gc);
-    return status;
-}
-
 /*
  * We do our own inet_aton because the g=
libc function
  * isn't very good about error checking=2E
diff --git a/src/=
openvpn/socket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13f5962=2E=2E03=
8ec36 100644
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_uti=
l=2Eh
@@ -110,44 +110,6 @@
 void setenv_link_socket_actual(struct env_set *=
es, const char *name_prefix,
                                const struct l=
ink_socket_actual *act, const unsigned int flags);
 
-/*
- * DNS resolution=

- */
-
-#define GETADDR_RESOLVE                 (1u << 0)
-#define GETADDR=
_FATAL                   (1u << 1)
-#define GETADDR_HOST_ORDER             =
 (1u << 2)
-#define GETADDR_MENTION_RESOLVE_RETRY   (1u << 3)
-#define GETA=
DDR_FATAL_ON_SIGNAL         (1u << 4)
-#define GETADDR_WARN_ON_SIGNAL      =
    (1u << 5)
-#define GETADDR_MSG_VIRT_OUT            (1u << 6)
-#define G=
ETADDR_TRY_ONCE                (1u << 7)
-#define GETADDR_UPDATE_MANAGEMENT=
_STATE (1u << 8)
-#define GETADDR_RANDOMIZE               (1u << 9)
-#defin=
e GETADDR_PASSIVE                 (1u << 10)
-#define GETADDR_DATAGRAM     =
           (1u << 11)
-
-#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GET=
ADDR_PASSIVE)
-
-/**
- * Translate an IPv4 addr or hostname from string for=
m to in_addr_t
- *
- * In case of resolve error, it will try again for
- * =
resolve_retry_seconds seconds=2E
- */
-in_addr_t getaddr(unsigned int flags=
, const char *hostname, int resolve_retry_seconds,
-                  bool =
*succeeded, struct signal_info *sig_info);
-
-/**
- * Translate an IPv6 add=
r or hostname from string form to in6_addr
- */
-bool get_ipv6_addr(const c=
har *hostname, struct in6_addr *network, unsigned int *netbits,
-          =
         msglvl_t msglevel);
-
-int openvpn_getaddrinfo(unsigned int flags,=
 const char *hostname, const char *servname,
-                        int r=
esolve_retry_seconds, struct signal_info *sig_info, int ai_family,
-       =
                 struct addrinfo **res);
-
 /* return values of openvpn_ine=
t_aton */
 #define OIA_HOSTNAME 0
 #define OIA_IP       1
@@ -301,7 +263,7 =
@@
 }
 #endif
 
-/*
+/**
  * Overhead added to packets by various protocols=
=2E
  */
 static inline int
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/=
tun=2Ec
index f2a4394=2E=2Ed8cedda 100644
--- a/src/openvpn/tun=2Ec
+++ b/s=
rc/openvpn/tun=2Ec
@@ -39,7 +39,7 @@
 #include "fdmisc=2Eh"
 #include "comm=
on=2Eh"
 #include "run_command=2Eh"
-#include "socket_util=2Eh"
+#include "=
resolve=2Eh"
 #include "manage=2Eh"
 #include "route=2Eh"
 #include "win32=
=2Eh"

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?us=
p=3Demail
To unsubscribe, or for help writing mail filters, visit http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I12bef330e2=
c8a5e5b21c2fa807584319b2b7101f
Gerrit-Change-Number: 1846
Gerrit-PatchSet: =
3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: razvanc <razvanc=
@mailbox=2Eorg>

--+xqq2lYVX5w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by razvanc</p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Factor out address resolve code to a new f=
ile resolve=2Ec<br><br>The code was weirdly split between socket=2Ec, socke=
t_util=2Ec,<br>and options=2Ec=2E The new structure makes more sense=2E<br>=
<br>While here move some related string helper code to buffer=2Eh=2E<br><br=
>Change-Id: I12bef330e2c8a5e5b21c2fa807584319b2b7101f<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt=
<br>M src/openvpn/Makefile=2Eam<br>M src/openvpn/buffer=2Ec<br>M src/openvp=
n/buffer=2Eh<br>M src/openvpn/clinat=2Ec<br>M src/openvpn/dns=2Ec<br>M src/=
openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/options=2Ec<b=
r>M src/openvpn/options=2Eh<br>M src/openvpn/pool=2Ec<br>M src/openvpn/ps=
=2Ec<br>M src/openvpn/push=2Ec<br>A src/openvpn/resolve=2Ec<br>A src/openvp=
n/resolve=2Eh<br>M src/openvpn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M s=
rc/openvpn/socket=2Eh<br>M src/openvpn/socket_util=2Ec<br>M src/openvpn/soc=
ket_util=2Eh<br>M src/openvpn/tun=2Ec<br>21 files changed, 816 insertions(+=
), 709 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/46/1846/3</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLi=
sts=2Etxt b/CMakeLists=2Etxt</span><br><span>index 2c3324d=2E=2E7f2b142 100=
644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -567,6 +567,8 @@</span><br><span>     src/openvpn=
/reflect_filter=2Eh</span><br><span>     src/openvpn/reliable=2Ec</span><br=
><span>     src/openvpn/reliable=2Eh</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    src/openvpn/resolve=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    src/openvpn/resolve=2Eh</span><br><span>     s=
rc/openvpn/route=2Ec</span><br><span>     src/openvpn/route=2Eh</span><br><=
span>     src/openvpn/run_command=2Ec</span><br><span>diff --git a/src/open=
vpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>index 7fd12b4=
=2E=2E57bd3bd 100644</span><br><span>--- a/src/openvpn/Makefile=2Eam</span>=
<br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -125,6 +125,7 =
@@</span><br><span> 	pushlist=2Eh \</span><br><span> 	reflect_filter=2Ec re=
flect_filter=2Eh \</span><br><span> 	reliable=2Ec reliable=2Eh \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	resolve=2Ec resolve=2Eh \</sp=
an><br><span> 	route=2Ec route=2Eh \</span><br><span> 	run_command=2Ec run_=
command=2Eh \</span><br><span> 	schedule=2Ec schedule=2Eh \</span><br><span=
>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec</span><br><sp=
an>index 8c19902=2E=2E32bdb2d 100644</span><br><span>--- a/src/openvpn/buff=
er=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br><span>@@ -109=
8,6 +1098,23 @@</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+streqnull(const char *a, const cha=
r *b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (a =3D=3D NULL &amp;&amp;=
 b =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else if (a =3D=3D NULL || b=
 =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return streq(a, b);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> char *</span><br><span> string_substitute(const char *src, ch=
ar from, char to, struct gc_arena *gc)</span><br><span> {</span><br><span>d=
iff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span><br><span=
>index 651aaed=2E=2Eea6d8e4 100644</span><br><span>--- a/src/openvpn/buffer=
=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span>@@ -1766,=
6 +1766,18 @@</span><br><span>     return 0 =3D=3D strncmp(str, prefix, str=
len(prefix));</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/** helper to work around the semantics of t=
he strcmp() return value</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return true if the strings are equal according to strcmp()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define streq(x, y) (!strcmp((x), (y)))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/** compare two strings which might be N=
ULL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true =
if both strings are NULL, or if they are equal according to strcmp()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool streqnull(const char *a, const char =
*b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** compare two=
 strings which might be NULL, but NULL is never equal</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true if neither string is NULL=
 and they are equal according to strcmp()</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span> bool string_defined_equal(const =
char *s1, const char *s2);</span><br><span> char *string_substitute(const c=
har *src, char from, char to, struct gc_arena *gc);</span><br><span> </span=
><br><span>diff --git a/src/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec</sp=
an><br><span>index 32c1325=2E=2E3f42254 100644</span><br><span>--- a/src/op=
envpn/clinat=2Ec</span><br><span>+++ b/src/openvpn/clinat=2Ec</span><br><sp=
an>@@ -30,6 +30,7 @@</span><br><span> #include &quot;proto=2Eh&quot;</span>=
<br><span> #include &quot;socket_util=2Eh&quot;</span><br><span> #include &=
quot;memdbg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;resolve=2Eh&quot;</span><br><span> </span><br><span> stati=
c bool</span><br><span> add_entry(struct client_nat_option_list *dest, cons=
t struct client_nat_entry *e)</span><br><span>diff --git a/src/openvpn/dns=
=2Ec b/src/openvpn/dns=2Ec</span><br><span>index 1465cdf=2E=2E4535c99 10064=
4</span><br><span>--- a/src/openvpn/dns=2Ec</span><br><span>+++ b/src/openv=
pn/dns=2Ec</span><br><span>@@ -27,7 +27,7 @@</span><br><span> #include &quo=
t;syshead=2Eh&quot;</span><br><span> </span><br><span> #include &quot;dns=
=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &q=
uot;socket_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;resolve=2Eh&quot;</span><br><span> #include &quot;opti=
ons=2Eh&quot;</span><br><span> #include &quot;run_command=2Eh&quot;</span><=
br><span> #include &quot;domain_helper=2Eh&quot;</span><br><span>diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index fa62cd=
d=2E=2E89a2c38 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br>=
<span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -55,6 +55,7 @@</span><b=
r><span> #include &quot;tun_afunix=2Eh&quot;</span><br><span> #include &quo=
t;schedule=2Eh&quot;</span><br><span> #include &quot;options_string=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;re=
solve=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memdbg=2E=
h&quot;</span><br><span> </span><br><span>diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 2a3023c=2E=2E2cea9df 10=
0644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src=
/openvpn/manage=2Ec</span><br><span>@@ -44,6 +44,7 @@</span><br><span> #inc=
lude &quot;dco=2Eh&quot;</span><br><span> #include &quot;push=2Eh&quot;</sp=
an><br><span> #include &quot;multi=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span> =
</span><br><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><=
br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</sp=
an><br><span>index 418329e=2E=2Ec7075be 100644</span><br><span>--- a/src/op=
envpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><=
span>@@ -64,6 +64,7 @@</span><br><span> #include &quot;domain_helper=2Eh&qu=
ot;</span><br><span> #include &quot;mbuf=2Eh&quot;</span><br><span> #includ=
e &quot;check_file_access=2Eh&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span> </span><b=
r><span> #include &lt;ctype=2Eh&gt;</span><br><span> </span><br><span>@@ -1=
038,26 +1039,6 @@</span><br><span> </span><br><span> #endif /* ifndef _WIN3=
2 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static in_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_=
ip_addr(const char *ip_string, msglvl_t msglevel, bool *error)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    unsigned int flags =3D GETADDR_HOST_ORDER;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    bool succeeded =3D false;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in_addr_t ret;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (msglevel &amp; M_FATAL)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        flags |=3D GETADDR_FATAL;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ret =3D getaddr(flags, ip_string, 0, &amp;succeeded, NULL);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!succeeded &amp;&amp; er=
ror)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        *error =3D true;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return ret;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> /**</span><br><span>  * Returns newly allocated string=
 containing address part without &quot;/nn&quot;=2E</span><br><span>  *</sp=
an><br><span>@@ -1080,13 +1061,6 @@</span><br><span>     }</span><br><span>=
     return ret;</span><br><span> }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static =
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ipv6_addr_safe_he=
xplusbits(const char *ipv6_prefix_spec)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return get_ipv6_addr(ipv6_prefix_spec, NULL, NULL, M_WARN);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> /**</span><br><span>  * Parses a hexs=
tring and checks if the string has the correct length=2E Return</span><br><=
span>  * a verify_hash_list containing the parsed hash string=2E</span><br>=
<span>@@ -3321,7 +3295,7 @@</span><br><span>     options_postprocess_verify=
(options);</span><br><span> #ifndef ENABLE_SMALL</span><br><span>     optio=
ns_postprocess_filechecks(options);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif /* !ENABLE_SMALL */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br>=
<span> /*</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvp=
n/options=2Eh</span><br><span>index c23d0b3=2E=2E2b68a0e 100644</span><br><=
span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/option=
s=2Eh</span><br><span>@@ -723,8 +723,6 @@</span><br><span>     unsigned int=
 imported_protocol_flags;</span><br><span> };</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#define streq(x, y) (!strcmp((x),=
 (y)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> /*</span><br><span>  * Option classes=2E</span><br><span>  */</span><br>=
<span>diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><s=
pan>index ff74e7c=2E=2E7e74649 100644</span><br><span>--- a/src/openvpn/poo=
l=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -31,6 +=
31,7 @@</span><br><span> #include &quot;error=2Eh&quot;</span><br><span> #i=
nclude &quot;socket_util=2Eh&quot;</span><br><span> #include &quot;otime=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;resolve=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memd=
bg=2Eh&quot;</span><br><span> </span><br><span>diff --git a/src/openvpn/ps=
=2Ec b/src/openvpn/ps=2Ec</span><br><span>index c3f54ed=2E=2E2f596da 100644=
</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn=
/ps=2Ec</span><br><span>@@ -32,6 +32,7 @@</span><br><span> #include &quot;s=
ocket=2Eh&quot;</span><br><span> #include &quot;fdmisc=2Eh&quot;</span><br>=
<span> #include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span> #inclu=
de &quot;ps=2Eh&quot;</span><br><span> </span><br><span> #include &quot;mem=
dbg=2Eh&quot;</span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openv=
pn/push=2Ec</span><br><span>index 5b15f71=2E=2E467ebc9 100644</span><br><sp=
an>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</s=
pan><br><span>@@ -37,6 +37,7 @@</span><br><span> #include &quot;memdbg=2Eh&=
quot;</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> #=
include &quot;options_util=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span> </span><=
br><span> /*</span><br><span>  * Auth username/password</span><br><span>dif=
f --git a/src/openvpn/resolve=2Ec b/src/openvpn/resolve=2Ec</span><br><span=
>new file mode 100644</span><br><span>index 0000000=2E=2Eb8d9899</span><br>=
<span>--- /dev/null</span><br><span>+++ b/src/openvpn/resolve=2Ec</span><br=
><span>@@ -0,0 +1,665 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN =
-- An application to securely tunnel IP networks</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             session authentication and key exchange,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryptio=
n, packet authentication, and</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet compression=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software;=
 you can redistribute it and/or modify</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  it under the terms of the GNU General Public License=
 version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pu=
blished by the Free Software Foundation=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  This program is distributed in the hope that it will be useful,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY W=
ARRANTY; without even the implied warranty of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  GNU General Public License for more details=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  You should have received a copy of the GNU General Public =
License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;crypto=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;manage=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;s=
ocket_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;res=
olve=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Convert sockflags/getaddr_flags into g=
etaddr_flags</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+sf2gaf(const unsigned int geta=
ddr_flags, const unsigned int sockflags)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (sockflags &amp; SF_HOST_RANDOMIZE)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return getaddr_flags | GETADDR_RANDOMIZE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return getaddr_flags;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Functions related to the translation of DNS names to=
 IP addresses=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Small helper function for openvpn_getaddrinfo to pr=
int the address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * f=
amily when resolving fails</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static co=
nst char *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getaddrin=
fo_addr_family_name(int af)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch=
 (af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;[=
AF_INET]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET6:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return &=
quot;[AF_INET6]&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
&quot;&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Prepend a random string to hostname to prevent DNS cach=
ing=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * For exampl=
e, foo=2Ebar=2Egov would be modified to &lt;random-chars&gt;=2Efoo=2Ebar=2E=
gov=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Of course,=
 this requires explicit support in the DNS server (wildcard)=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static const char *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+hostname_randomize(const char *hostname, struct=
 gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define n_rnd_bytes 6</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint8_t rnd_bytes[n_rnd_bytes];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *rnd_str;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer h=
name =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    prng_bytes(rnd_bytes, sizeof(rnd_byte=
s));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rnd_str =3D=
 format_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf_printf(&amp;hname, &quot=
;%s=2E%s&quot;, rnd_str, hostname);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return BSTR(&amp;hname);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#undef n_rnd_bytes</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Translate IPv4/IPv6 addr or=
 hostname into struct addrinfo</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * If resolve error, try again for resolve_retry_seconds seconds=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+openvpn_getaddrinfo(unsigned int flags, const ch=
ar *hostname, const char *servname,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    int resolve_retry_seconds, struct signa=
l_info *sig_info, int ai_family,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    struct addrinfo **res)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct addrinfo hints;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int status;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct signal_info sigrec =3D { 0 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msglvl_t msglevel =3D (flags =
&amp; GETADDR_FATAL) ? M_FATAL : D_RESOLVE_ERRORS;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *print_hostn=
ame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*print_servname;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(res);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(hostname || servname);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(!(flags &amp; GETAD=
DR_HOST_ORDER));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (servname)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        print_servname =3D servname;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        print_servname =3D &quot;&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (flags &amp; GETADDR_MSG_VIRT_OUT)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        msglevel |=3D M_MSG_VIRT_OUT;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if ((flags &amp; (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) &amp;&=
amp; !sig_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sig_info =
=3D &amp;sigrec;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* try numeric ip addr first */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(hints);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    hints=2Eai_flags =
=3D AI_NUMERICHOST;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp;=
 GETADDR_PASSIVE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hints=2E=
ai_flags |=3D AI_PASSIVE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; GETADDR=
_DATAGRAM)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        hints=2Eai_sock=
type =3D SOCK_DGRAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        hints=2Eai_socktype =3D SOCK_S=
TREAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* if hostname is not set, we want to bind=
 to &#39;ANY&#39;, with</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * the correct address family - v4-only or v6/v6-dual-stack */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!hostname)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        hints=2Eai_family =3D ai_family=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    status =3D getaddrinfo(hostname, servname, &amp=
;hints, res);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (status !=3D 0)   =
                   /* parse as numeric address failed? */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const int fail_wait_interval =3D 5; /* seco=
nds */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Ad=
d +4 to cause integer division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        int resolve_re=
tries =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  (flags &amp; GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_=
wait_interval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    const char *fmt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        msglvl_t level =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* this is not a numeric IP, therefore force resolution using the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+         * provided ai_family=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hints=2E=
ai_family =3D ai_family;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ho=
stname &amp;&amp; (flags &amp; GETADDR_RANDOMIZE))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            hostname =3D hostname_randomize(hostname, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (hostname)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            print_hostname =3D hostname;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            print_hostname =3D &quot;undefined&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        fmt =3D &quot;RESOLVE: Cannot resolve =
host address: %s:%s%s (%s)&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if ((flags &amp; GETADDR_MENTION_RESOLVE_RETRY) &amp;=
&amp; !resolve_retry_seconds)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            fmt =3D &quot;RESOLVE: Cannot resolve host address: %s:%s%s (%s=
)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
      &quot;(I would have retried this name query if you had &quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                  &quot;spe=
cified the --resolv-retry option=2E)&quot;;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!(flags &amp; GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;RESOLVE:=
 Cannot parse IP address: %s:%s (%s)&quot;, print_hostname,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                print_servname, gai=
_strerror(status));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &am=
p; GETADDR_UPDATE_MANAGEMENT_STATE)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (management)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                management_set_state(management, OPENVPN_STATE_RESO=
LVE, NULL, NULL, NULL, NULL,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                     NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * Resolve host=
name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        while (true)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef _WIN32</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* force resolv=2Econf re=
load */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
res_init();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* try ho=
stname lookup */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         hints=2Eai_flags &amp;=3D ~AI_NUMERICHOST;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            dmsg(D_SOCKET_DEBUG, &quot;GE=
TADDRINFO flags=3D0x%04x ai_family=3D%d ai_socktype=3D%d&quot;, flags,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 hints=
=2Eai_family, hints=2Eai_socktype);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            status =3D getaddrinfo(hostname, servname, &amp=
;hints, res);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (sig_info)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                get_signa=
l(&amp;sig_info-&gt;signal_received);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                if (sig_info-&gt;signal_received) /* were=
 we interrupted by a signal? */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    /* why are we overwriting SIGUSR1 ? */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (si=
gnal_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        ms=
g(level, &quot;RESOLVE: Ignored SIGUSR1 signal received during &quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
          &quot;DNS resolution attempt&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        /* turn success=
 into failure (interrupted syscall) */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        if (0 =3D=3D status)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
   ASSERT(res);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        freeaddrinfo(*res);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                            *res =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
status =3D EAI_AGAIN; /* =3D temporary failure */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            errno =3D EINTR;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* success? =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (0=
 =3D=3D status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            /* resolve lookup fa=
iled, should we</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * continue or fail? */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            level =3D msglevel;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (resolve_retries &gt; 0)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                level =3D D_RESOLVE_E=
RRORS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            msg(level, fmt, print_host=
name, print_servname, getaddrinfo_addr_family_name(ai_family),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                gai_strerror(sta=
tus));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (--resolve_retrie=
s &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            management_sleep(fa=
il_wait_interval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(res);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* hostname resolve succeeded */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * Do not choose an IP Addresse by random or ch=
ange the order *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
      * of IP addresses, doing so will break RFC 3484 address selection *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* IP address parse succeeded */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (flags &amp; GETADDR_RANDOMIZE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;WA=
RNING: ignoring --remote-random-hostname because the &quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        &quot;hostn=
ame is an IP address&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (sig_info &amp;&amp; sig_info-&gt;signal_=
received)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        msglvl_t level =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (f=
lags &amp; GETADDR_FATAL_ON_SIGNAL)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            level =3D M_FATAL;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else if (flags &amp; GETADDR_WARN_ON_SIGNAL)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            level =3D M_WARN;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(level, &quot;RESOLVE: signal rece=
ived during DNS resolution attempt&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+get_addr_generic(sa_family_t af, unsigned int flags, co=
nst char *hostname, void *network,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                 unsigned int *netbits, int resolve_retry_se=
conds, struct signal_info *sig_info,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 msglvl_t msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char *endp, *sep, *var_host =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct addrinfo *ai =3D NULL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned long bits;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t max_bit=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D -=
1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!hostname)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;Can&#39;t resolve nul=
l hostname!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* assign family specific defau=
lt values */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swi=
tch (af)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case AF_INET:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            bits =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            max_bit=
s =3D sizeof(in_addr_t) * 8;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e AF_INET6:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    bits =3D 64;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         max_bits =3D sizeof(struct in6_addr) * 8;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_WARN, &quot;Unsupported AF family passed to getad=
drinfo for %s (%d)&quot;, hostname, af);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            goto out;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* we =
need to modify the hostname received as input, but we don&#39;t want to</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * touch it directl=
y as it might be a constant string=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * Therefore, we clone the string here and free it at the end of t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * function *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    var_host =3D s=
trdup(hostname);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!var_host)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONF=
ATAL | M_ERRNO, &quot;Can&#39;t allocate hostname buffer for getaddrinfo&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto o=
ut;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* check if this hostname has a /bits suffix =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sep =3D strch=
r(var_host, &#39;/&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (sep)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bits =
=3D strtoul(sep + 1, &amp;endp, 10);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if ((*endp !=3D &#39;\0&#39;) || (bits &gt; max_bi=
ts))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel,=
 &quot;IP prefix &#39;%s&#39;: invalid &#39;/bits&#39; spec (%s)&quot;, hos=
tname, sep + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *se=
p =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret =3D openvpn_getaddrinfo(f=
lags &amp; ~GETADDR_HOST_ORDER, var_host, NULL, resolve_retry_seconds,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
      sig_info, af, &amp;ai);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if ((ret =3D=3D 0) &amp;&amp; network)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct in6_addr *ip6;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        in_addr_t *ip4;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (af !=3D ai-&gt;ai_family)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(msglevel, &quot;Can&#39;t parse %s =
as IPv%d address&quot;, var_host, (af =3D=3D AF_INET) ? 4 : 6);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            ret =3D -1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            goto out;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        switch (af)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            case AF_INET:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                ip4 =3D network;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                *ip4 =3D ((struct sockaddr_in=
 *)ai-&gt;ai_addr)-&gt;sin_addr=2Es_addr;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                if (flags &amp; GETADDR_HOST_ORDER)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    *ip4 =3D ntohl(*ip4);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            case AF_INET6:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                ip6 =3D networ=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                *=
ip6 =3D ((struct sockaddr_in6 *)ai-&gt;ai_addr)-&gt;sin6_addr;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                break;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            default:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                /* can&#39;t get here because &=
#39;af&#39; was previously checked */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                msg(M_WARN, &quot;Unsupported AF family f=
or %s (%d)&quot;, var_host, af);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                goto out;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (netbits)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *netbits =3D (unsigned int)bits;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* restore &#39;/&#39; separator, if any */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sep)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        *sep =3D &#39;/&#39;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (ai)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free=
addrinfo(ai);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(var_host);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+in_=
addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+getaddr(unsig=
ned int flags, const char *hostname, int resolve_retry_seconds, bool *succe=
eded,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 signal_info *sig_info)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t =
addr =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D get_addr_gen=
eric(AF_INET, flags, hostname, &amp;addr, NULL, resolve_retry_seconds,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
      sig_info, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (status =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (succeeded)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 *succeeded =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (succeeded)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            *succeeded =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+in_addr_t</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+get_ip_addr(const char *ip_string, =
msglvl_t msglevel, bool *error)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
signed int flags =3D GETADDR_HOST_ORDER;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool succeeded =3D false;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    in_addr_t ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (msglevel &amp; M_FATAL)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        flags |=3D GETADDR_FATAL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret =
=3D getaddr(flags, ip_string, 0, &amp;succeeded, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!succeeded &amp;&amp; error)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        *error =3D true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+get_ipv6_addr(const char *=
hostname, struct in6_addr *network, unsigned int *netbits,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+              msglvl_t msglevel)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (get_addr_generic(AF_INET6, GETADD=
R_RESOLVE, hostname, network, netbits, 0, NULL, msglevel)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
true; /* parsing OK, values set */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * get_cached_dns_entry return 0 on suc=
cess and -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * other=
wise=2E (like getaddrinfo)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+get_cached_dns_entry(stru=
ct cached_dns_entry *dns_cache, const char *hostname, const char *servname,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  int ai_family, unsigned int resolve_flags, struct addrinfo **ai)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct cached_dns_entry *ph;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Only use flags that are relevant for the =
structure */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fla=
gs =3D resolve_flags &amp; GETADDR_CACHE_MASK;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    for (ph =3D dns_cache; ph; ph =3D ph-&gt;next)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (streqnull(ph-&gt;hostname, hostname) &=
amp;&amp; streqnull(ph-&gt;servname, servname)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &amp;&amp; ph-&gt;ai_family =3D=3D a=
i_family &amp;&amp; ph-&gt;flags =3D=3D flags)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            *ai =3D ph-&gt;ai;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+do_preresolve_host(struct context *c, const char *hostname, cons=
t char *servname, const int af,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                   const unsigned int flags)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct addrinfo *ai;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    int status;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (get_cached_dns_entry(c-&gt;c1=2Edns_cache, hostname, servname, af,=
 flags, &amp;ai) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* entry already cached, return success */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =
=3D openvpn_getaddrinfo(flags, hostname, servname, c-&gt;options=2Eresolve_=
retry_seconds, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                 af, &amp;ai);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (status =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        struct cached_dns_entry *ph;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &=
amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   ph-&gt;ai =3D ai;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ph-&gt;hostname =3D hostname;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ph-&gt;servname =3D servname;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ph-&gt;flags =3D flags &amp; G=
ETADDR_CACHE_MASK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!c-&gt;c=
1=2Edns_cache)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&=
gt;c1=2Edns_cache =3D ph;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct ca=
ched_dns_entry *prev =3D c-&gt;c1=2Edns_cache;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            while (prev-&gt;next)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                prev =3D prev-&gt;next;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            prev-&gt;next =
=3D ph;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_addspecial(ai, &amp;gc_freeadd=
rinfo_callback, &amp;c-&gt;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+do_preresolve(struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct connection_list *l =3D c-&gt;options=2Econnectio=
n_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const un=
signed int preresolve_flags =3D GETADDR_RESOLVE | GETADDR_UPDATE_MANAGEMENT=
_STATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                             | GETADDR_MENTION_RESOLVE_RETRY | GETADDR_FATA=
L;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (int i =3D 0; i &lt; l-&gt;len; ++i)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        int status;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        const char *remote;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        unsigned int flags =3D prere=
solve_flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct connection_=
entry *ce =3D l-&gt;array[i];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (proto_is_dgram(ce-&gt;proto))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            flags |=3D GETADDR_DATAGRAM;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (c-&gt;options=2Esockflags &amp; SF_HOST_RANDOMIZE)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            flags |=3D GETADDR_RANDOMIZE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (c-&gt;options=2Eip_remote_hint)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            remote =3D c-&gt;options=2Ei=
p_remote_hint;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            remote =3D ce-&gt;re=
mote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* HTTP remote hostname does not =
need to be resolved */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!ce-&gt;http_proxy_options)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            status =3D do_preresolve_host(c, remote, ce-&gt;re=
mote_port, ce-&gt;af, flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (status !=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                goto err;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Pre=
resolve proxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (ce-&gt;http_proxy_options)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            status =3D do_preresolve_host(c, ce-&gt;http_proxy_option=
s-&gt;server,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                  ce-&gt;http_proxy_options-&gt;port, ce-&g=
t;af, preresolve_flags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (status !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (ce-&gt;socks_proxy_server)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            status =3D</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                do_prereso=
lve_host(c, ce-&gt;socks_proxy_server, ce-&gt;socks_proxy_port, ce-&gt;af, =
flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (status !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (ce-&gt;bind_local)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            flags |=3D GETADDR_PASS=
IVE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fla=
gs &amp;=3D ~GETADDR_RANDOMIZE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     for (int j =3D 0; j &lt; ce-&gt;local_list-&gt;len; j++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                const struct local_entr=
y *le =3D ce-&gt;local_list-&gt;array[j];</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                if (!le-&gt;local)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    continue;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                status =3D do_preresolve_host(c, le-&gt;local, le-&gt;=
port, ce-&gt;af, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                if (status !=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    throw_signal_soft(SIGHUP, &quot;Preresolvi=
ng failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span>diff --git a/src/openvpn/resolve=2Eh b/src/openvpn/resolve=
=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E9069af7</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
resolve=2Eh</span><br><span>@@ -0,0 +1,106 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sin=
gle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet encryption, packet authentication, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is free software; you can redistribute it and/or modify</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU G=
eneral Public License version 2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that=
 it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * DNS resolution</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef RESOLVE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 RESOLVE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;sig=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define GETADDR_RESOLVE                 (1u &lt;&lt; 0)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_FATAL      =
             (1u &lt;&lt; 1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#define GETADDR_HOST_ORDER              (1u &lt;&lt; 2)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_MENTION_RESOLV=
E_RETRY   (1u &lt;&lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define GETADDR_FATAL_ON_SIGNAL         (1u &lt;&lt; 4)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_WARN_ON_SIGNAL   =
       (1u &lt;&lt; 5)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define GETADDR_MSG_VIRT_OUT            (1u &lt;&lt; 6)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_TRY_ONCE            =
    (1u &lt;&lt; 7)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define GETADDR_UPDATE_MANAGEMENT_STATE (1u &lt;&lt; 8)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_RANDOMIZE              =
 (1u &lt;&lt; 9)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine GETADDR_PASSIVE                 (1u &lt;&lt; 10)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_DATAGRAM                (=
1u &lt;&lt; 11)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define GETADDR_CACHE_M=
ASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Convert soc=
kflags/getaddr_flags into getaddr_flags</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+unsigned int sf2gaf(const unsigned int getaddr_flags, const unsigned in=
t sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Translate an IPv4 addr or hostname fro=
m string form to in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * In case=
 of resolve error, it will try again for</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * resolve_retry_seconds seconds=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+in_addr_t getaddr(unsigned int flags, const char *host=
name, int resolve_retry_seconds,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                  bool *succeeded, struct signal_info *sig_inf=
o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+in_addr_t get_ip_addr(const char *i=
p_string, msglvl_t msglevel, bool *error);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Translate=
 an IPv6 addr or hostname from string form to in6_addr</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bool get_ipv6_addr(const char *hostname, struct in6_addr=
 *network, unsigned int *netbits,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                   msglvl_t msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ipv6_addr_safe_hexplusbits(const char *ipv6_prefix_spec)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return get_ipv6_addr(ipv6_prefix_spec=
, NULL, NULL, M_WARN);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+int openvpn_getaddrinfo(unsigned i=
nt flags, const char *hostname, const char *servname,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        int resolve_retry=
_seconds, struct signal_info *sig_info, int ai_family,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        struct addrinfo =
**res);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void do_preresolve(struct conte=
xt *c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* struct to hold preresolved h=
ost names */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct =
cached_dns_entry</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *hostn=
ame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*servname;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int a=
i_family;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsign=
ed int flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct addrinfo *ai;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct cached_dns_entry *next;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * get_cached_dns_entry return 0 on su=
ccess and -1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * othe=
rwise=2E (like getaddrinfo())</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int ge=
t_cached_dns_entry(struct cached_dns_entry *dns_cache, const char *hostname=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
       const char *servname, int ai_family,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                         unsigned int resolve_flags=
, struct addrinfo **ai);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* RESO=
LVE_H */</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/r=
oute=2Ec</span><br><span>index 8ea745d=2E=2E8e828ae 100644</span><br><span>=
--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</sp=
an><br><span>@@ -42,6 +42,7 @@</span><br><span> #include &quot;options=2Eh&=
quot;</span><br><span> #include &quot;networking=2Eh&quot;</span><br><span>=
 #include &quot;integer=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;resolve=2Eh&quot;</span><br><span> </span><br>=
<span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>=
index 0f66ad51=2E=2Edec4229 100644</span><br><span>--- a/src/openvpn/socket=
=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -38,6 =
+38,7 @@</span><br><span> #include &quot;manage=2Eh&quot;</span><br><span> =
#include &quot;openvpn=2Eh&quot;</span><br><span> #include &quot;forward=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;resolve=2Eh&quot;</span><br><span> </span><br><span> #include &quot;memd=
bg=2Eh&quot;</span><br><span> </span><br><span>@@ -54,366 +55,6 @@</span><b=
r><span>     return false;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * Convert sockflags/getaddr_flags into getaddr_flag=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static unsigned int</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-sf2gaf(const unsigned int getaddr_flags,=
 const unsigned int sockflags)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (soc=
kflags &amp; SF_HOST_RANDOMIZE)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return getaddr_flags | GETADDR_RANDOMIZE;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return getaddr_=
flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Functions rel=
ated to the translation of DNS names to IP addresses=2E</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-get_addr_generic(sa_family_t af, unsigned int flags, const char *hostn=
ame, void *network,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               unsigned int *netbits, int resolve_retry_seconds, struct sig=
nal_info *sig_info,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
               msglvl_t msglevel)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char=
 *endp, *sep, *var_host =3D NULL;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct addrinfo *ai =3D NULL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    unsigned long bits;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    uint8_t max_bits;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int ret =3D -1;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!hostname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_NO=
NFATAL, &quot;Can&#39;t resolve null hostname!&quot;);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* a=
ssign family specific default values */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    switch (af)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        bits =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          max_bits =3D sizeof(in_addr_t) * 8;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            bits =3D 64;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            max_bits =3D sizeof(struct in6_addr) * 8;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            break;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        default:</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_WARN, &quot;Unsupported AF family passed to getadd=
rinfo for %s (%d)&quot;, hostname, af);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            goto out;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* we need to m=
odify the hostname received as input, but we don&#39;t want to</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * touch it directly as it mig=
ht be a constant string=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * The=
refore, we clone the string here and free it at the end of the</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * function */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    var_host =3D strdup(hostname);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!var_host)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(M_NONFATAL | M_ERRNO, &quot;Can=
&#39;t allocate hostname buffer for getaddrinfo&quot;);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        goto out;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* check if this hostname has a /bits suffix */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    sep =3D strchr(var_host, &#39;/&#39;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sep)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        bits =3D strtoul(sep + 1, &amp;endp, 10);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((*endp !=3D &#=
39;\0&#39;) || (bits &gt; max_bits))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            msg(msglevel, &quot;IP prefix &#39;%s&#39;: invalid &#39;/bi=
ts&#39; spec (%s)&quot;, hostname, sep + 1);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            goto out;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        *sep =3D &#39;\0&#39;;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D openv=
pn_getaddrinfo(flags &amp; ~GETADDR_HOST_ORDER, var_host, NULL, resolve_ret=
ry_seconds,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                    sig_info, af, &amp;ai);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if ((ret =3D=3D 0) &amp;&amp; network)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        struct in6_addr *ip6;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        in_addr_t *ip4;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (af !=3D ai-&gt;ai_family)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(msglevel, &quot;Can&#39;t parse %s as I=
Pv%d address&quot;, var_host, (af =3D=3D AF_INET) ? 4 : 6);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            ret =3D -1;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            goto out;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        switch (af)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     case AF_INET:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             ip4 =3D network;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                *ip4 =3D ((struct sockaddr_in *)ai-&gt;ai_addr)-&gt=
;sin_addr=2Es_addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (fla=
gs &amp; GETADDR_HOST_ORDER)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    *ip4 =3D ntohl(*ip4);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                break;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           case AF_INET6:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                ip6 =3D network;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                *ip6 =3D ((struct sockaddr_in6 *)ai-&gt;ai_a=
ddr)-&gt;sin6_addr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            default:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* can&=
#39;t get here because &#39;af&#39; was previously checked */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                msg(M_WARN, &quot;U=
nsupported AF family for %s (%d)&quot;, var_host, af);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                goto out;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (netb=
its)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        *netbits =3D (unsigned in=
t)bits;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* restore &#39;/&#39; separator, if any */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sep)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        *sep =3D &#39;/&#39;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-out:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (ai)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        freeaddrinfo(ai);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    free(var_host);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return ret;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-in_addr_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-getaddr(unsigned int flags, const char *hos=
tname, int resolve_retry_seconds, bool *succeeded,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        struct signal_info *sig_info)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    in_addr_t addr =3D { 0 };</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    status =3D get_addr_generic(AF_INET, flags, hostname, &amp;addr, =
NULL, resolve_retry_seconds,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                              sig_info, M_WARN);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (status =3D=3D 0)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (succeeded)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            *succeeded =3D true;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return addr;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (succeeded)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            *succeeded =3D false;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-get_ipv6_addr(const char *hostname, struct in6_addr=
 *network, unsigned int *netbits,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-              msglvl_t msglevel)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (get_addr_generic(AF_INET6, GETADDR_RESOLVE, hostname, network, n=
etbits, 0, NULL, msglevel)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return fa=
lse;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return true; /* parsing OK, values set */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-streqnull(const char *a, const char *b)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (a =3D=3D NULL &amp;&amp; b =3D=3D NULL)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return true;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else=
 if (a =3D=3D NULL || b =3D=3D NULL)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return streq(a, b);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * get_cached_dns_entry return 0 on succe=
ss and -1</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * otherwise=
=2E (like getaddrinfo)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-get_cached_dns_entry(struct =
cached_dns_entry *dns_cache, const char *hostname, const char *servname,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                     int=
 ai_family, unsigned int resolve_flags, struct addrinfo **ai)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct cached_dns_entry *ph;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int flags;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* Only use flags that are relevant for the structure */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    flags =3D resolve_f=
lags &amp; GETADDR_CACHE_MASK;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (ph =
=3D dns_cache; ph; ph =3D ph-&gt;next)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (streqnull(ph-&gt;hostname, hostname) &amp;&amp; streqnull(ph-&=
gt;servname, servname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            &amp;&amp; ph-&gt;ai_family =3D=3D ai_family &amp;&amp; ph-&gt=
;flags =3D=3D flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *=
ai =3D ph-&gt;ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return -1;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-do_preresolve_host(struct context *c,=
 const char *hostname, const char *servname, const int af,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                   const unsigned int =
flags)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *ai;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int status;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (get_cached_dns_entry(c-&gt;c1=2Edns_cache, hostname=
, servname, af, flags, &amp;ai) =3D=3D 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        /* entry already cached, return success */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        return 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stat=
us =3D openvpn_getaddrinfo(flags, hostname, servname, c-&gt;options=2Eresol=
ve_retry_seconds, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                 af, &amp;ai);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (status =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        struct cached_dns_entry *ph;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ALLOC_OBJ_CLEAR_GC(ph, struct cached_dns_entry, &amp;c-&=
gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ph-&gt=
;ai =3D ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ph=
-&gt;hostname =3D hostname;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ph-&gt;servname =3D servname;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ph-&gt;flags =3D flags &amp; GETADDR_CACHE_MA=
SK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (!c-&gt;c1=2Edns_cache)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c1=2Edns_cache =3D p=
h;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            struct cached_dns_entry *prev =3D c-&gt;=
c1=2Edns_cache;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      while (prev-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              prev =3D prev-&gt;next;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            prev-&gt;next =3D ph;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_ad=
dspecial(ai, &amp;gc_freeaddrinfo_callback, &amp;c-&gt;gc);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    return status;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-do_preresolve(struct context *c)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct connection_list *l =3D c-&gt;options=
=2Econnection_list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const unsigned int preresolve_flags =3D GETADDR_RESOLVE | GETADDR_UPDATE_=
MANAGEMENT_STATE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                     | GETADDR_MENTION_RESOLVE_RETRY | GETA=
DDR_FATAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; l-&gt;len; ++i)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        int status;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        const char *remote;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        unsigned int flags =3D preresolve_=
flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct connection_entry *ce =
=3D l-&gt;array[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (proto_is_dg=
ram(ce-&gt;proto))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            fla=
gs |=3D GETADDR_DATAGRAM;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&gt;options=2Es=
ockflags &amp; SF_HOST_RANDOMIZE)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            flags |=3D GETADDR_RANDOMIZE;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c=
-&gt;options=2Eip_remote_hint)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         remote =3D c-&gt;options=2Eip_remote_hint;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           remote =3D ce-&gt;remote;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* HTTP re=
mote hostname does not need to be resolved */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (!ce-&gt;http_proxy_options)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            status =3D do_preresolve_host(c=
, remote, ce-&gt;remote_port, ce-&gt;af, flags);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (status !=3D 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                goto err;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* Preresolve proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (ce-&gt;http_proxy_options)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            status =3D do_preresolve_host(c, ce-&gt;http_proxy_options=
-&gt;server,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                               ce-&gt;http_proxy_options-&gt;port, ce-&gt;a=
f, preresolve_flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (statu=
s !=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto=
 err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (ce-&gt;socks_proxy_server)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            status =3D</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                do_preresolve_host(c, ce-&gt;socks_=
proxy_server, ce-&gt;socks_proxy_port, ce-&gt;af, flags);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (status !=3D 0)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (ce-&gt;bind_local)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         flags |=3D GETADDR_PASSIVE;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            flags &amp;=3D ~GETADDR_RANDOMIZE;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            for (int j =3D 0; j &lt; ce-&gt;local_list-&=
gt;len; j++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                s=
truct local_entry *le =3D ce-&gt;local_list-&gt;array[j];</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                if (!le-&gt;local)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    continue;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                status =3D do_preresolve_host(c, le-&gt;local, le-&g=
t;port, ce-&gt;af, flags);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                if (status !=3D 0)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    goto err;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-err:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    throw_signal_soft(SIGHUP, &quot;Preresolving failed&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</span><br><spa=
n> socket_get_sndbuf(socket_descriptor_t sd)</span><br><span> {</span><br><=
span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socket=2Eh</span><br=
><span>index 1a532e1=2E=2E15934f9 100644</span><br><span>--- a/src/openvpn/=
socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</span><br><span>@@ =
-62,17 +62,6 @@</span><br><span> /* convert a packet_size_type from network=
 to host order */</span><br><span> #define ntohps(x) ntohs(x)</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* struct to hold=
 preresolved host names */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-struct cached_dns_entry</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *hostname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const=
 char *servname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt ai_family;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsi=
gned int flags;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct addrinfo *ai;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct cached_dns_entry *next;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> /* IP addresses which are persistent across SIGUSR1s */</span><br>=
<span> struct link_socket_addr</span><br><span> {</span><br><span>@@ -362,8=
 +351,6 @@</span><br><span> </span><br><span> void link_socket_init_phase2(=
struct context *c, struct link_socket *sock);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-void do_preresolve(struct context=
 *c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> void link_socket_close(struct link_socket *sock);</span><br><span> </span=
><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>diff --git a/src/openv=
pn/socket_util=2Ec b/src/openvpn/socket_util=2Ec</span><br><span>index 0194=
f38=2E=2E5d405ac 100644</span><br><span>--- a/src/openvpn/socket_util=2Ec</=
span><br><span>+++ b/src/openvpn/socket_util=2Ec</span><br><span>@@ -490,27=
1 +490,6 @@</span><br><span>     return &quot;&quot;; /* Make the compiler =
happy */</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Small helper function for openvpn_getaddrinfo to print the address=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * family when resolv=
ing fails</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-getaddrinfo_addr_family_name(int=
 af)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    switch (af)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case AF_INET:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return &quot;[AF_INET]&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        case AF_INET6:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            return &quot;[AF_INET6]&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return &quot;&quot;;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * Prepend a random string to hostna=
me to prevent DNS caching=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * For example, foo=2Ebar=2Egov would be modified to &lt;random-char=
s&gt;=2Efoo=2Ebar=2Egov=2E</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * Of course, this requires explicit support in the DNS server (wildca=
rd)=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static const char *</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-hostname_randomize(const char *host=
name, struct gc_arena *gc)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define n_rnd_b=
ytes 6</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    uint8_t rnd_bytes[n_rnd_bytes];<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char *rnd_st=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer h=
name =3D alloc_buf_gc(strlen(hostname) + sizeof(rnd_bytes) * 2 + 4, gc);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    prng_bytes(rnd_bytes, sizeof(rnd_bytes)=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rnd_str =3D for=
mat_hex_ex(rnd_bytes, sizeof(rnd_bytes), 40, 0, NULL, gc);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    buf_printf(&amp;hname, &quot;%s=2E=
%s&quot;, rnd_str, hostname);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return BSTR(&amp;hname);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#undef n_rnd_bytes</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Translate IPv4/IPv6 addr or hostname into str=
uct addrinfo</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If res=
olve error, try again for resolve_retry_seconds seconds=2E</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-int</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-openvpn_getaddrinfo(unsigned int flags, const char *hostname, const char *=
servname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        int resolve_retry_seconds, struct signal_info *sig_info, int ai_fam=
ily,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   struct addrinfo **res)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct addri=
nfo hints;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int sta=
tus;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct signal=
_info sigrec =3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    msglvl_t msglevel =3D (flags &amp; GETADDR_FATAL) ? M_FATAL : D_RESOL=
VE_ERRORS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    const char *print_hostname;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    const char *print_servname;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ASSERT(res);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(hostname || =
servname);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
!(flags &amp; GETADDR_HOST_ORDER));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(servname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        print_servname =3D =
servname;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        print_servname =3D &quot;&quot;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (flags &amp; GETADDR_MSG_VIRT_OUT)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        msglevel |=3D M_MSG_VIRT_OUT;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ((flags &a=
mp; (GETADDR_FATAL_ON_SIGNAL | GETADDR_WARN_ON_SIGNAL)) &amp;&amp; !sig_inf=
o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        sig_info =3D &amp;sigrec;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* try numeric ip addr first */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    CLEAR(hints);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    hints=2Eai_flags =3D AI_NUMERICHOST;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (flags &amp; GETADDR_PASSIVE)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        hints=2Eai_flags |=3D AI_PASSIVE;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (flags &amp; GETADDR_DATAGRAM)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        hints=2Eai_socktype =3D SOCK_DGRAM;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        hints=2Eai=
_socktype =3D SOCK_STREAM;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* if hostname is not set, w=
e want to bind to &#39;ANY&#39;, with</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * the correct address family - v4-only or v6/v6-dual-s=
tack */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!hostn=
ame)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        hints=2Eai_family =3D ai_=
family;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    status =3D getaddrinfo(hostname, servname, &amp=
;hints, res);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (status !=3D 0)       =
               /* parse as numeric address failed? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const int fail_wait_interval =3D 5; /* seconds */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Add +4 to ca=
use integer division rounding up (1 + 4) =3D 5, (0+4)/5=3D0 */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        int resolve_retries =3D</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            (flags &amp;=
 GETADDR_TRY_ONCE) ? 1 : ((resolve_retry_seconds + 4) / fail_wait_interval)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *=
fmt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msglvl_t =
level =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* this is not a numer=
ic IP, therefore force resolution using the</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         * provided ai_family */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        hints=2Eai_family =3D ai_family;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (hostname &amp;&amp; (flags &amp=
; GETADDR_RANDOMIZE))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
hostname =3D hostname_randomize(hostname, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (hostname)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            p=
rint_hostname =3D hostname;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_hostname =
=3D &quot;undefined&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        fmt =3D &quot;RESOLV=
E: Cannot resolve host address: %s:%s%s (%s)&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if ((flags &amp; GETADDR_MENTION_RE=
SOLVE_RETRY) &amp;&amp; !resolve_retry_seconds)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            fmt =3D &quot;RESOLVE: Cannot resolve host addres=
s: %s:%s%s (%s)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                  &quot;(I would have retried this name query if you had &q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
 &quot;specified the --resolv-retry option=2E)&quot;;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (!(flags &amp; GETADDR_RESOLVE) || status =3D=3D EAI_FAIL)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;RESOLVE:=
 Cannot parse IP address: %s:%s (%s)&quot;, print_hostname,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                print_servname, gai_s=
trerror(status));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        goto done;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (flags &amp; GETADDR_U=
PDATE_MANAGEMENT_STATE)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (management)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    management_set_state(management, OPENVPN_STATE_RESOLVE, NULL, NULL, NUL=
L, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                        NULL);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-         * Resolve hostname</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        while (true)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifndef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     /* force resolv=2Econf reload */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            res_init();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /* try hostname lookup */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            hints=2Eai_flags &amp;=3D ~AI_NUMERICHOST;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_SOCK=
ET_DEBUG, &quot;GETADDRINFO flags=3D0x%04x ai_family=3D%d ai_socktype=3D%d&=
quot;, flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
         hints=2Eai_family, hints=2Eai_socktype);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            status =3D getaddrinfo(hostname, se=
rvname, &amp;hints, res);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (s=
ig_info)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                get_s=
ignal(&amp;sig_info-&gt;signal_received);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                if (sig_info-&gt;signal_received) /* we=
re we interrupted by a signal? */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    /* why are we overwriting SIGUSR1 ? */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    if (signal=
_reset(sig_info, SIGUSR1) =3D=3D SIGUSR1) /* ignore SIGUSR1 */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                        msg(level,=
 &quot;RESOLVE: Ignored SIGUSR1 signal received during &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
&quot;DNS resolution attempt&quot;);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        /* turn success into failure (int=
errupted syscall) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       if (0 =3D=3D status)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                        {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                            ASSERT(res);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                            fr=
eeaddrinfo(*res);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                        *res =3D NULL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                            status =3D EAI_AGAIN; /* =3D t=
emporary failure */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                          errno =3D EINTR;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        goto done;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            /* success? */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            if (0 =3D=3D status)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                break;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* =
resolve lookup failed, should we</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-             * continue or fail? */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            level =3D msglevel;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (resolve_retries &gt; 0)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                level =3D D_RE=
SOLVE_ERRORS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(level, fmt, print_hos=
tname, print_servname, getaddrinfo_addr_family_name(ai_family),</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                gai_strerror(stat=
us));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (--resolve_retries &lt=
;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto d=
one;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            management_sleep(fail_wait_interva=
l);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ASSERT(res);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        /* hostname resolve succeeded */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * =
Do not choose an IP Addresse by random or change the order *</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-         * of IP addresses, doing so=
 will break RFC 3484 address selection *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* IP address parse succeede=
d */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (flags=
 &amp; GETADDR_RANDOMIZE)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(M_WARN, &quot;WARNING: ignoring --remote-random-hostname because th=
e &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           &quot;hostname is an IP address&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-done:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (sig_info &amp;&amp; sig_info=
-&gt;signal_received)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msglvl_t=
 level =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (flags &amp; GETADDR_FATAL_ON_SIGNAL)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            level =3D M_FATAL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        else if (flags &amp; GETADDR_WARN_ON_SIGNAL)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            level =3D M_WARN;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        msg(level, &quot;RESOLVE: signal received durin=
g DNS resolution attempt&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return status;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * We do ou=
r own inet_aton because the glibc function</span><br><span>  * isn&#39;t ve=
ry good about error checking=2E</span><br><span>diff --git a/src/openvpn/so=
cket_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>index 13f5962=
=2E=2E038ec36 100644</span><br><span>--- a/src/openvpn/socket_util=2Eh</spa=
n><br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@ -110,44 +1=
10,6 @@</span><br><span> void setenv_link_socket_actual(struct env_set *es,=
 const char *name_prefix,</span><br><span>                                c=
onst struct link_socket_actual *act, const unsigned int flags);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * DNS resolution</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine GETADDR_RESOLVE                 (1u &lt;&lt; 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_FATAL                   (1u=
 &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define G=
ETADDR_HOST_ORDER              (1u &lt;&lt; 2)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define GETADDR_MENTION_RESOLVE_RETRY   (1u &lt;&l=
t; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_=
FATAL_ON_SIGNAL         (1u &lt;&lt; 4)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define GETADDR_WARN_ON_SIGNAL          (1u &lt;&lt; 5)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_MSG_VIR=
T_OUT            (1u &lt;&lt; 6)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define GETADDR_TRY_ONCE                (1u &lt;&lt; 7)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_UPDATE_MANAGEM=
ENT_STATE (1u &lt;&lt; 8)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define GETADDR_RANDOMIZE               (1u &lt;&lt; 9)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#define GETADDR_PASSIVE              =
   (1u &lt;&lt; 10)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine GETADDR_DATAGRAM                (1u &lt;&lt; 11)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define GETADDR_CACHE_MASK (GETADDR_DATAGRAM | GETADDR_PASSIVE)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Translate an IPv4 addr or hostname from string form to in=
_addr_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * In case of resolve error, it w=
ill try again for</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * r=
esolve_retry_seconds seconds=2E</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-in_addr_=
t getaddr(unsigned int flags, const char *hostname, int resolve_retry_secon=
ds,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
bool *succeeded, struct signal_info *sig_info);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Translate =
an IPv6 addr or hostname from string form to in6_addr</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-bool get_ipv6_addr(const char *hostname, struct in6_addr *net=
work, unsigned int *netbits,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                   msglvl_t msglevel);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-int openvpn_getaddrinfo(unsigned int flags, const char *hostname, const =
char *servname,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  int resolve_retry_seconds, struct signal_info *sig_info, =
int ai_family,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 struct addrinfo **res);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /* return values of openvpn_inet_aton =
*/</span><br><span> #define OIA_HOSTNAME 0</span><br><span> #define OIA_IP =
      1</span><br><span>@@ -301,7 +263,7 @@</span><br><span> }</span><br><s=
pan> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span>  * Overhead added to packets by various protocols=2E</span><br>=
<span>  */</span><br><span> static inline int</span><br><span>diff --git a/=
src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index f2a4394=2E=
=2Ed8cedda 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span=
>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -39,7 +39,7 @@</span><br><spa=
n> #include &quot;fdmisc=2Eh&quot;</span><br><span> #include &quot;common=
=2Eh&quot;</span><br><span> #include &quot;run_command=2Eh&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;socket_util=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
resolve=2Eh&quot;</span><br><span> #include &quot;manage=2Eh&quot;</span><b=
r><span> #include &quot;route=2Eh&quot;</span><br><span> #include &quot;win=
32=2Eh&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail">change 1846</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1846?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I12be=
f330e2c8a5e5b21c2fa807584319b2b7101f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1846 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>

</body></html>
--+xqq2lYVX5w=--


--===============7774126376111778513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7774126376111778513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7774126376111778513==--

