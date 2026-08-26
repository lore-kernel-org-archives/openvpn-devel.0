Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557F0C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjqDA4x6yI/aTWo4UgGTUuzEzV2Z/NscrOYKr1enpq8=; b=R+OyDpTAPHbAJmEVTb4r07o/6G
	cz7PfU5nTkKnaRfFl/hOizQkP3+4+tZlTxyN9TVDyIQdkgc6/dr1UCp7JlO5B2G1iSn9jgRHvJftu
	MKSZxyl9tA+SFD3nSnAB8Ou2UXNfBFyOB99QqdaUlnZ2kuXm80zUEcNqOhQcl7UpeYI4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wz7Gw-0002Mz-Ue;
	Wed, 26 Aug 2026 06:38:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wz7Gv-0002Mt-Jt
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:38:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=weMD8h9Wnr2zD5W8q8UqEcerSC749dEyuyT/6CtFPMw=; b=CkvW7gNIWKoNigocNtXNI8E9Lq
 d8/6ibGl+rU7NYDEdSnymIl5iHefU/RuaBbO6To4Hsa3jDdbUuC363o/7s9zwnyD8ltKYWMtwiiqn
 Y6EohCKkJQIZD5I2BEsoSRO7gSwtyejxzzohjQf2nqDM+M2KZsE/snQc6qEtdKiNX3K8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=weMD8h9Wnr2zD5W8q8UqEcerSC749dEyuyT/6CtFPMw=; b=A
 jpym70iLYKGvIKsWbIGohUKgqfBYmmuA4aVk5vjAh1ukY0czmoYoxdguR7UP5fHmxAyR80k9zPNs7
 dUOjCLWk7WxtPQQDHcvDqB0ey2nMeEOAzcJIuMz12wq2df/DwuE2qMFESyRkTf1pAbnOLpnvH0fqD
 5tTRTOi0xJjyK5zY=;
Received: from mail-ed1-f47.google.com ([209.85.208.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz7Gs-0007N0-7i for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 06:38:03 +0000
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a156627e22so3150745a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 23:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787726276; x=1788331076; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=weMD8h9Wnr2zD5W8q8UqEcerSC749dEyuyT/6CtFPMw=;
 b=aridqjHDQc+BJ0cWn3bW1R/99l33T55VfUtbZVJHQjvRNx2yX6OUqkotpgC74ytOP1
 V5DwK6komZYYbBUbiimoA+KWztXFHSOD4c9c6MJCS/084GC5Om9E07IDlVszizHyvToe
 MWnPnE/TwIY7iwfudSbALcZ62kuKk1FJ9Up4xcfX5pWGq9vBkmrFK76uouUwQS+ue1Gq
 5VnRPqNl7gvRqhJo2BuwtfWaVf+zQ7lVh5lKy/8BdE2aGCJ8DEJUGDc4fMlwflCuJTKX
 VEiNTN2M33mYJTq1FMGG5BYb/1j52eluDyBXmIchzu5o8m41GQRvI4Qqg/fOZCJ1bDe3
 cgdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787726276; x=1788331076;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=weMD8h9Wnr2zD5W8q8UqEcerSC749dEyuyT/6CtFPMw=;
 b=fiSB6fNKFMSBLdZM7jdz0SnXlYRvURmehHSd2twd4vHV/8qiAccFvp5xrklfxvVMFg
 8kD5bSVa/Ff3fMDsNlZ/Ok5mQRIFMAobFobUkVnjExkG47aq69ZsK1lEznvXvDSP9VYM
 fyNr9xlH9OD+4BOR2YSuzz7KMPE0rxHqtIB1dBqJpqofhMST4946yVQb0dbsjKmQyqY7
 MJv5OIBu+ox4YFUJYgrCN6FD6/arB2fIUhyuVcYD+kT3XPbGoNVEOOlAQiZvnIvelc8W
 qGElp/c/NJre9AQyccTylhJHLQ9V0Ug0nl5iw2ZN5671DTnWTbeZmS+273H+2uf/SKFD
 gufw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roi4VkE3zNhM94OaL0pEu6IuFFxn0ErqGbAch/ty9Tt+N+UcYZAPnnqvUsZjqkuN6rhzxUb4N25fTGbSgSB@lists.sourceforge.net
X-Gm-Message-State: AFuF++keSAH8mTmivRLjibjYm9XpeCM9z6DN+7ZP8KaocBc1G7tpRWWL
 HC6+jN18Ipj8JQpaieK5RG7lWSiTQZ8hJBnkr0z3iuamUwcTWtTTwfJ8iyowAHi9F1D0FPVurbj
 Ii5Gbtmce+9qS/6tftMaLaqfDhyw7MPp9vLNju74foXG/oGkApH1aYlvU9k5aXhbwpDs8
X-Gm-Gg: AR+sD11k2UC1Kt4W8MsmreMkpwItiUh4M/9vl5RPER6v2WMYqGI11wDDcpWIRkx25U2
 xqiQrTmEegzfmFncqfPXplqWc3kgsZ5zSuAX38T6poZx4dkG+FQWh0GQK9gt3QSVogT1PIrBwsu
 G1LtfyKkN+OcVO3NuOeaGBxWJrDLTWtaEzgfnHrLrAj8k7YsyEiLsbts2AR+Fcg86cp1p9pQE7v
 /lhlr3WnimJ3HXLxHiQTH+SCst95mfkVbRUzy6dU7VDn+Qf/0tNdxe4y6hwvhRerUOC801hEQCO
 z6T08ngrJSUOS13cv3T1qfiMZA4uKlb14afNsRk3v0duTpfZQHmV3IBkpbHm05o0B+FALjq2+Sg
 gHPJkwp9Izu/mYjW4pQN91YUJHlbUDln7E7Rbeehwb9Pt0dzNW8904ejgkaiLdvxQzECXlb++J8
 pIjwklYeWAnoF/bXpoWSsqSV5iaufBQm5gKh0YXxqcou3SRwrcoqzHc3xwU3+APUnoBVCgKcDTH
 BXduRaV/BYoVeOyDEdJP3nFIBFHDT5QBnDZpYPs+XuJ5pS7RxZmbvNqjTu4eIrXauLPgxCRODWt
 sQOt6xFvaabi3R3lI4ISBPOWrBncpaOXm9tVP7CGVRUuo3Mnc0o=
X-Received: by 2002:a17:906:9fd0:b0:c20:7166:cc16 with SMTP id
 a640c23a62f3a-c24e2f96398mr1432653566b.15.1787726275533; 
 Tue, 25 Aug 2026 23:37:55 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ab82sm354502166b.31.2026.08.25.23.37.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 23:37:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 06:37:54 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
X-Gerrit-Change-Number: 1585
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1585?usp=email>
X-Gerrit-Commit: 13a780311f385950c03f228188d874bee1c09511
In-Reply-To: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
References: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0MjY4NDg2MDAwLkk1Mjc3Mzc2NGUwZjQwNTZmZTUzNjc5MThhOWIyZTY3MjBiMTY1YzIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e3f6b8e8f3e5a6aaaa527acccb2138b3fbed21bf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wz7Gs-0007N0-7i
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0731782402740266789=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0731782402740266789==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9LNWhhHV32I="; charset=UTF-8

--9LNWhhHV32I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1585?usp=3Demail )

Change subject: dev-tools: Add new script to conver=
t mails to Gerrit patches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

dev-tools: Add new script to convert mails to Gerrit patches
=

Also checks for some common issues=2E

Change-Id: I52773764e0f4056fe536791=
8a9b2e6720b165c21
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1585
Message-Id: <20260825071139=2E21756-1-=
gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg38653=2Ehtml
Signed-off-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
---
A dev-tools/gerrit-submit-from-mail=2Esh
1 file =
changed, 42 insertions(+), 0 deletions(-)




diff --git a/dev-tools/gerrit=
-submit-from-mail=2Esh b/dev-tools/gerrit-submit-from-mail=2Esh
new file mo=
de 100755
index 0000000=2E=2Ead5775f
--- /dev/null
+++ b/dev-tools/gerrit-s=
ubmit-from-mail=2Esh
@@ -0,0 +1,42 @@
+#!/bin/bash
+
+# Assertions:
+#  - t=
here is a remote called "gerrit" that can be used to
+#    pushed to gerrit=
=2E Create it with
+#    git remote add gerrit ssh://<yourgerritusername>@g=
errit=2Eopenvpn=2Enet:29418/openvpn=2Egit
+# - the master branch does not c=
ontain pending commits, move them to branches
+#
+# Usage:
+# - Pipe mail t=
o this script on stdin
+# - You can specify the target branch as the first =
argument to the script
+#   if it is not master=2E
+
+set -eu
+
+TARGET_BRA=
NCH=3D${1:-master}
+SOURCE_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}=
"))
+TIMESTAMP=3D$(date +%Y%m%dT%H%M%S)
+
+git -C $SOURCE_DIR checkout $TAR=
GET_BRANCH
+git -C $SOURCE_DIR checkout -B mail-submit-${TIMESTAMP}
+git -C=
 $SOURCE_DIR am
+
+warnings=3D0
+if git -C $SOURCE_DIR log -n1 --format=3D%=
an | grep -q "via Openvpn-devel"; then
+    echo WARNING: Author contains \=
"via Openvpn-devel\"
+    echo Try to get an actual email-adress from the s=
ubmitter!
+    warnings=3D$((warnings + 1))
+fi
+
+if ! git -C $SOURCE_DIR =
log -n1 --format=3D%b | grep -qi "signed-off-by:"; then
+    echo WARNING: =
Signed-off-by: line missing
+    echo Consider adding it=2E
+    warnings=
=3D$((warnings + 1))
+fi
+
+if [ "$warnings" -gt 0 ]; then
+    echo Please=
 fix the $warnings warnings above before pushing=2E
+    echo Push the chan=
ges with git -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH
+else
=
+    echo git -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH
+fi

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I52773764e0f4056fe53679=
18a9b2e6720b165c21
Gerrit-Change-Number: 1585
Gerrit-PatchSet: 3
Gerrit-Own=
er: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--9LNWhhHV32I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1585?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dev-tools: Add new script to convert mails=
 to Gerrit patches<br><br>Also checks for some common issues=2E<br><br>Chan=
ge-Id: I52773764e0f4056fe5367918a9b2e6720b165c21<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;=
razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1585<br>Message-Id: &lt;20260825071139=2E21756-1-gert@greenie=2Emu=
c=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg38653=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>---<br>A dev-tools/gerrit-submit-from-mail=2Esh<br>=
1 file changed, 42 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/dev-tools/gerrit-submit-from-mail=2Esh b/dev-tools/gerrit-submit-from=
-mail=2Esh</span><br><span>new file mode 100755</span><br><span>index 00000=
00=2E=2Ead5775f</span><br><span>--- /dev/null</span><br><span>+++ b/dev-too=
ls/gerrit-submit-from-mail=2Esh</span><br><span>@@ -0,0 +1,42 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/bash</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# Assertions:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#  - there is a remote called &quot;gerrit&quot; that can be us=
ed to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    pushed to=
 gerrit=2E Create it with</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#    git remote add gerrit ssh://&lt;yourgerritusername&gt;@gerrit=2E=
openvpn=2Enet:29418/openvpn=2Egit</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# - the master branch does not contain pending commits, move =
them to branches</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Usage:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# - Pipe mail to this script on =
stdin</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - You can sp=
ecify the target branch as the first argument to the script</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#   if it is not master=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+set -eu</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TAR=
GET_BRANCH=3D${1:-master}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+SOURCE_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURCE[0]}&quot;))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+TIMESTAMP=3D$(date +=
%Y%m%dT%H%M%S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+git -C $SOURCE_DIR check=
out $TARGET_BRANCH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+g=
it -C $SOURCE_DIR checkout -B mail-submit-${TIMESTAMP}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+git -C $SOURCE_DIR am</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+warnings=3D0</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if git -C $SOURCE_DIR log -n1 --format=3D%an | grep -q &quot;via=
 Openvpn-devel&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    echo WARNING: Author contains \&quot;via Openvpn-devel\&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo Try to get an=
 actual email-adress from the submitter!</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    warnings=3D$((warnings + 1))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if=
 ! git -C $SOURCE_DIR log -n1 --format=3D%b | grep -qi &quot;signed-off-by:=
&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ech=
o WARNING: Signed-off-by: line missing</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    echo Consider adding it=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    warnings=3D$((warnings + 1))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+if [ &quot;$warnings&quot; -gt 0 ]; then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    echo Please fix the $warnings warnings abov=
e before pushing=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    echo Push the changes with git -C $SOURCE_DIR push gerrit HEAD:refs/for=
/$TARGET_BRANCH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo git -C $SO=
URCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+fi</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Dem=
ail">change 1585</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1585?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I52773764e0f4056fe5367918a9b2e6720b165c21 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1585 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--9LNWhhHV32I=--


--===============0731782402740266789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0731782402740266789==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0731782402740266789==--

