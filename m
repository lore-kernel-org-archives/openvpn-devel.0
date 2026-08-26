Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A305C61DC6
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=V/8Q1LA0ROpPTsNS2H2ECg78ZD4lnDh4DuygnZHDlZk=; b=YO6dz6wZZN2KbHHQFpqGgIvhru
	pjpCmR+XmeeXkrT4dkXjRNkZll9XBa1nDyJyMkJ7aNiTHUffrga5E5nyu4ecCB8tALdX9mkJsdAGh
	ataObN0w1t1Cn2Q2P1dUHYnJmwXvaSm45ggN6H+PzIPtfoqDYi2V05v/J1IJhnHQD2iM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7Gt-0007Fh-DY;
	Wed, 26 Aug 2026 06:38:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz7Gs-0007FZ-Cy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:38:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=k+RYTE8TqjciQvH1GY1nTVqRtNC4wqN8drWKZNEoVAU=; b=FZ1fKfW/Q4xXzju/SJ8f7uQ0/8
 RGsxezUKflrMlaER5iTf8Uz8BbdbB8ZVSb3xya/hWY/3kSJcR3e0Zu393OLnDeIqj8cSkwgJfdyXy
 RAfwPp+7nnHzoE7KJEwJgcwIJuwQj9PcE2ZZ3g7eRIqBzquVjuVRNJOkwjAp8juRV+BA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=k+RYTE8TqjciQvH1GY1nTVqRtNC4wqN8drWKZNEoVAU=; b=n
 NXgU0W/l6AYn36v5ifAh/GNnk59+dPxMEO3UKCd+5+HCyhXWjuemKEBnar//o+V9+0u8FLugJvG83
 zu4H/VBjSD1h7dSKRbpjd7tyS2CkfYZihAElKfF3zdv7CrT8bye9V5E0GdIxy792LQH9Yk+ilQRv8
 Nb3CqklOHxZ9r7+Y=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz7Gr-0007FI-EA for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:38:02 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c16794450aeso51339266b.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787726275; x=1788331075; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=k+RYTE8TqjciQvH1GY1nTVqRtNC4wqN8drWKZNEoVAU=;
 b=XVGjvFpYMyXG6t5xgc0rm0Q9PDV0qTmhwjvd9iJmWNUmwiHPPq1scQk6GDAaPmKSF7
 pfejeD67mwfrwxkz/d9nmTZYfiJaTeerwy6ie9cysdIGQKhzEEJjauC26vKN/euodJe0
 dBgIPWU7BFYifiMJ4Fu2u4FabcEf2hlvG+ZVkKvA+DR/RvUwXR4FTHkmJ26N01fElpIp
 tb3nVDgRVelAXUdDQhhq+/S/Avdkgxv7oFca8JfBFhBTUY0YmppuG4YvQ9G9Bq6WWhm6
 UR4et2eDkc7TxVE/0z5tzi7tuui4OL3AEI2YCPXtrelZo63G+RyDKTeBdEJHvk988Jte
 ApuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787726275; x=1788331075;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=k+RYTE8TqjciQvH1GY1nTVqRtNC4wqN8drWKZNEoVAU=;
 b=mZgPx5QAChoId1rTY6LwqpbY+54xPFlqgszDRmn/OBrPzCKF1poQC24p6kUIg7OkZl
 5z8TI8e7NNMzOGtGGBlepGZskYfwR5ZL8zjJtMYMHg8RKKZXtPNsEVDmkJ+enUd09GKI
 Fa8RHaJ+lqpXHOsdFrC116IKsBpm7KJN8tkr2Fqe+OA40xEIM9RS32IDE+e6VyHjDPoN
 CUnLVxNHQR1a7K2QrIv7S8K3ynVYIxtZeYmEo0BPWD0KmU12NiMKiiReQKxxoR5SZXmT
 Mv6Pf26XULpk1hGCk+XLMM63m8dAYEFvlj+2mhZ4kXxXW7LwJjAJlssVGvi1QKH4Sy/G
 aVBQ==
X-Gm-Message-State: AFuF++kADiuU8fH/twLkra2/7M02GEzkNaXYjDZnTAfQqhSFSWFCtDAc
 kCuLsqxT0a1czXHo4bCzCnK/fi+qV7Q2m54/MXkHjjl1MrBk+6fVCsqrriOWT3g0041ry9Qyzub
 wrKVTNMcMs9u/vWZg/UUYXEjSr8QwUXhYJ4aMudyx9QT9F2jCRl9j1vfRAsHW6zxJXo8Z
X-Gm-Gg: AR+sD10we/NnvfkEUm66WggGQzPS9jehVIflff4gpgSRIcQJa4/5TXoQFnGJSBz2FO1
 7qd3W4LfotWayIHhTkKZlq8lM1Oie398HrB8c60BFDXSSj7FsGitEnxaHObIiy5Ae9tJ9maIBZB
 XBndLEzYqXxzF0kjEDB7zkZhAXjA7C/lYINhSCFYUGBZd854c72+aXu8ONtH8lP5BT1koH3g15Y
 c2oXdkc+Nr8sephWcJWTtzcuy0prO0idhrp6oCu+2nmkJdRQ6FZEOjfdVBfWc4eVwxz5JXtbp9L
 kOapi6SW5aD2QVzxN4/jGx/ACTBPC/sFWzDTdneVFc5bWDY17ZJ7l3qWLKrZNezOo/uGPomirOg
 ZVwz4jUXbc/Ok+SEqGZm+vQ77EMGxd6mTRz52rRQq3N3vCnR9RtZ9hGGC+qU+lvqr9DpgL/twC+
 tfxVaqYFabXNwP6H2RA0RoLSGeNl8moFTqr3jeE6x03P8+rLnuf3HN896qdSJJXttQp75elSa1m
 YwVaMtlfWsoaU9Os8z7WVMBiuxH/qz2dPGvbaZVW8l9jRPsv3BNnbQlw10KlilxU3FU2DKU00Vk
 ZCSOiktkYd3wywsdZZuNf2C2X8hvNg9vqZQdyZo55fWMS1004r8=
X-Received: by 2002:a17:906:c149:b0:c12:b2db:873d with SMTP id
 a640c23a62f3a-c250bac808emr479640066b.5.1787726274609; 
 Tue, 25 Aug 2026 23:37:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac5csm334862566b.40.2026.08.25.23.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:37:54 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:37:52 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
X-Gerrit-Change-Number: 1585
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1585?usp=email>
X-Gerrit-Commit: 13a780311f385950c03f228188d874bee1c09511
In-Reply-To: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
References: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0MjY4NDg2MDAwLkk1Mjc3Mzc2NGUwZjQwNTZmZTUzNjc5MThhOWIyZTY3MjBiMTY1YzIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3f6b8e8f3e5a6aaaa527acccb2138b3fbed21bf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz7Gr-0007FI-EA
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dev-tools: Add new
 script to convert mails to Gerrit patches
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3874123251171800836=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3874123251171800836==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E9oQNIfZxxE="; charset=UTF-8

--E9oQNIfZxxE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: dev-tools: Add new script to convert mails to =
Gerrit patches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


dev-tools: Add new script to convert mails to Gerrit patches

Also checks=
 for some common issues=2E

Change-Id: I52773764e0f4056fe5367918a9b2e6720b1=
65c21
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1585
Message-Id: <20260825071139=2E21756-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38653=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
A dev-tools/gerrit-submit-from-mail=2Esh
1 file changed, 4=
2 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/85/1585/3

diff --git a/dev-tools/gerrit-submit-f=
rom-mail=2Esh b/dev-tools/gerrit-submit-from-mail=2Esh
new file mode 100755=

index 0000000=2E=2Ead5775f
--- /dev/null
+++ b/dev-tools/gerrit-submit-fro=
m-mail=2Esh
@@ -0,0 +1,42 @@
+#!/bin/bash
+
+# Assertions:
+#  - there is a=
 remote called "gerrit" that can be used to
+#    pushed to gerrit=2E Creat=
e it with
+#    git remote add gerrit ssh://<yourgerritusername>@gerrit=2Eo=
penvpn=2Enet:29418/openvpn=2Egit
+# - the master branch does not contain pe=
nding commits, move them to branches
+#
+# Usage:
+# - Pipe mail to this sc=
ript on stdin
+# - You can specify the target branch as the first argument =
to the script
+#   if it is not master=2E
+
+set -eu
+
+TARGET_BRANCH=3D${1=
:-master}
+SOURCE_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+TIME=
STAMP=3D$(date +%Y%m%dT%H%M%S)
+
+git -C $SOURCE_DIR checkout $TARGET_BRANC=
H
+git -C $SOURCE_DIR checkout -B mail-submit-${TIMESTAMP}
+git -C $SOURCE_=
DIR am
+
+warnings=3D0
+if git -C $SOURCE_DIR log -n1 --format=3D%an | grep=
 -q "via Openvpn-devel"; then
+    echo WARNING: Author contains \"via Open=
vpn-devel\"
+    echo Try to get an actual email-adress from the submitter!=

+    warnings=3D$((warnings + 1))
+fi
+
+if ! git -C $SOURCE_DIR log -n1 -=
-format=3D%b | grep -qi "signed-off-by:"; then
+    echo WARNING: Signed-of=
f-by: line missing
+    echo Consider adding it=2E
+    warnings=3D$((warni=
ngs + 1))
+fi
+
+if [ "$warnings" -gt 0 ]; then
+    echo Please fix the $w=
arnings warnings above before pushing=2E
+    echo Push the changes with gi=
t -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH
+else
+    echo g=
it -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH
+fi

-- 
To view=
, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2=
e6720b165c21
Gerrit-Change-Number: 1585
Gerrit-PatchSet: 3
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--E9oQNIfZxxE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">dev-tools: Add new scrip=
t to convert mails to Gerrit patches<br><br>Also checks for some common iss=
ues=2E<br><br>Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Ra=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1585<br>Message-Id: &lt;20260825071139=2E21756=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg38653=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>A dev-tools/gerrit-submi=
t-from-mail=2Esh<br>1 file changed, 42 insertions(+), 0 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/85/1585/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/dev-tools/gerrit-submit-from-mail=
=2Esh b/dev-tools/gerrit-submit-from-mail=2Esh</span><br><span>new file mod=
e 100755</span><br><span>index 0000000=2E=2Ead5775f</span><br><span>--- /de=
v/null</span><br><span>+++ b/dev-tools/gerrit-submit-from-mail=2Esh</span><=
br><span>@@ -0,0 +1,42 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#!/bin/bash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Assertions:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#  - there is a remote call=
ed &quot;gerrit&quot; that can be used to</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#    pushed to gerrit=2E Create it with</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#    git remote add gerrit ssh://=
&lt;yourgerritusername&gt;@gerrit=2Eopenvpn=2Enet:29418/openvpn=2Egit</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# - the master branch doe=
s not contain pending commits, move them to branches</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Usage:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# - Pipe mail to this script on stdin</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# - You can specify the target branch as the first a=
rgument to the script</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#   if it is not master=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set -eu</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+TARGET_BRANCH=3D${1:-master}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+SOURCE_DIR=3D$(dirname $(readlin=
k -e &quot;${BASH_SOURCE[0]}&quot;))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+TIMESTAMP=3D$(date +%Y%m%dT%H%M%S)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+git -C $SOURCE_DIR checkout $TARGET_BRANCH</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+git -C $SOURCE_DIR checkout -B mail-s=
ubmit-${TIMESTAMP}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+g=
it -C $SOURCE_DIR am</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+warnings=3D0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if git -C $SOURCE_DIR log=
 -n1 --format=3D%an | grep -q &quot;via Openvpn-devel&quot;; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    echo WARNING: Author cont=
ains \&quot;via Openvpn-devel\&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    echo Try to get an actual email-adress from the submit=
ter!</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    warnings=3D=
$((warnings + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+if ! git -C $SOURCE_DIR log -n1 --form=
at=3D%b | grep -qi &quot;signed-off-by:&quot;; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    echo WARNING: Signed-off-by: line mis=
sing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo Consid=
er adding it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
warnings=3D$((warnings + 1))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$warnings&quot; =
-gt 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ec=
ho Please fix the $warnings warnings above before pushing=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    echo Push the changes with git=
 -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    echo git -C $SOURCE_DIR push gerrit HEAD:refs/for=
/$TARGET_BRANCH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail">change 1585</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I52773764e0f4056fe=
5367918a9b2e6720b165c21 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1585 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--E9oQNIfZxxE=--


--===============3874123251171800836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3874123251171800836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3874123251171800836==--

