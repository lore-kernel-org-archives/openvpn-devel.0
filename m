Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7CBCC5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XFcGNsj61TtFpq1NAhOcG8lcjUDoYM7b+1PYBx1fAns=; b=P4ZCnHqkIk1nvP+OhePc/ySnyb
	wEOQxj6/DNOiq4H5wbEvbL3aoSi4aQeWfc0WLTbvMr9br37qU+KVbIlYjzOZxU534746oOhUImg5r
	rmwM9rhaFemmHAcLvetOeHC2clHKTZjuWFpDeRk84ZK3rpPtgIy410DFU6hSY/nszASY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWfF-0001c4-L9;
	Mon, 24 Aug 2026 15:32:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWfE-0001by-Fy
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:32:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=84XeREp2ObKnRyyVhSIuQf7FNh9Jt4t41hhh3SsmzS8=; b=GUX4qaJmemPQyJ/jhPtk1UtFI6
 T4imnDUFZhcjM9hWDL9sO4tKBk1YQx51Tdy541PavH/7erNuew0gQVnprqYNblW2P8Z+xxTcNlrVY
 UdRqg/eHnkJqpzLMv8oZfDXYW0L+Cx/RAwHrWvq0AZFJMXSKVXAxLp5VmZO7OSgTcZ34=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=84XeREp2ObKnRyyVhSIuQf7FNh9Jt4t41hhh3SsmzS8=; b=j
 /JdN3gPQzsVqWuL6ouNUswUvGpVeF6oKRqVQkWEbTfeaRXaKJNArdz5JbvfAQpmzrH1rC1RxnS757
 EtxyMqcaXN+lrL+3GjU3XLcwy9NfyYT6kgxxLs9RFSOj+phLjv0iSHp963blf4ePCQAdylkVM6FST
 CYkniW4dnPlf4buk=;
Received: from mail-ej1-f54.google.com ([209.85.218.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWfA-0008LV-EO for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:32:41 +0000
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so412023566b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787585554; x=1788190354; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=84XeREp2ObKnRyyVhSIuQf7FNh9Jt4t41hhh3SsmzS8=;
 b=gsrqr+q0AcCd8lfOY1zdy8CFLy6Qi49E6l6DIMtZ90pBexFwT/B9TPmklWpNu0A0Ev
 3WjlOoWGCY9lZn6ERkkiMLn3olDywsaydire9PZwh5Ei+qcCCLhZa0n9Ign+URzg38X3
 2DKV1BK5kGL3TuCtE1N2uLzPEgfVhC08frDXP2MOgfraqW8zQkw1iCp1qA9qgq+XcQnj
 wNopiZ8f52j4/39jbp+ZruJWGt/2yaUEr/R8gJVjapgTv1pu/iZoMb9R67vOM1ntYxad
 DVFwSqsD1onaheefV8MpUKnpuKYYQdI1LU6nxjYSZl0ChmWgZn+JjYKZwKMLv7cpL2Kx
 Nh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585554; x=1788190354;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=84XeREp2ObKnRyyVhSIuQf7FNh9Jt4t41hhh3SsmzS8=;
 b=HAOrIdncoXr92u+fiohqIzljqc2MPe53v45jzh5XyfGE3bxh23+YSXvq26Urk2Z/Z3
 dEHqWEVsr0L5AQ6iiaYtZPhVtmvaCLbzvQgkyfQyeHAUPNmToriaC9sK/H1dvlwNkoLm
 zvMa3ewRq8f21QrygLQbRRhe9G275XFIZxThThAFp8BlZ49/add10JdT1anRKK4D1JTs
 QftgX1yrw4ZgEdB0pzH3ljHCL1OrryGbrBFaR7Da1+lTJl6o0tcRkjOP7jPklfCe7UGE
 DeLSmAswxIhI5okXJ6p7KJ1Z0UXBvSBrCsTDOJKq/bhx7CS6zyzWeRqufzxqItljTdFo
 S9AQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrmSIALFbwMul6/FuWFAiLxmtqtVzYUiO/x/lNa1hz+PnBIzocQYTNWMNeOCbKeL6HIsBPkoJ4wNI0X3G+z@lists.sourceforge.net
X-Gm-Message-State: AFuF++kfD67Ywuqyk24nw62vZoZ/JdEEyAQxgfL3i1QxEB02GXU+OnuJ
 ajOKSq7soGv1y0nx0biW3WAVwJqrXeOw7myM8zlcFV3smx/bLYRlyarWRdzfMvIIT4mOB/4EvpK
 bEWRcQd5UvRwnHn3cHCL6nTsx2YSRx0b88RNZ9y8oCv14wodm7L/nW83KhbkT9RvrvQGX
X-Gm-Gg: AR+sD11EwvBAyTLKcNONCz00xMrZvSept7B5vXaImbz7YCZunhz7jWUk9pOBVN/47pg
 6eQ4nkJI1FGRjbCVMHfgHXPVoAuYvG+IPz6492Ipqh5PWoQEypDiB8v/Ih01V9Lb4scL5i6ivMT
 rSYvQmMe+YFvLzhkJH4ypxYp/X40Nx/zyEcgPTwtzV7qp4wujqLeWFxAbQn8NJiXkQPBINhblG0
 aoTcyfRo4+AqtJ2Q09Qodo+9mqVXVT34BPytIYgSGRrw4tsX/TlYShwD0CHn619AAIbY7gr4AZh
 vJFVaUPaUjuDslkILUfQS3dGpVNllvn98sEafAc3nl2TCjV5BkRouPyaDKmj4mhlrQNXBvfr+rL
 cuG0nkm5O0HGleWUubLX2YeNMwXQ5ULRLwFQ9Sz2MAXhBs7G8YUDVr5zPoQgF1niQRyZsujGGDH
 +loFKw6T2zyjXJspuFtrBN+G8u4k0hLIa5aFwgfI69mcfQnzX2b80fq9wIOWGlGUSMavF0EK0jE
 bSID5lcCjLFhwy/LsAcWUQc9sxW58sdo/TAWPIQNLih+azLeFOc84kduX+sjpqVbtLOI+dTAxEv
 RMm3MbCVLizkwptBb6ATX5TcYivN9XRAhwjbb/uH4jkswmev5sk=
X-Received: by 2002:a17:907:e90:b0:c20:33db:41d3 with SMTP id
 a640c23a62f3a-c246a5f45aamr3389622466b.11.1787585553573; 
 Mon, 24 Aug 2026 08:32:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496295627sm1267400666b.15.2026.08.24.08.32.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:32:33 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:32:31 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
X-Gerrit-Change-Number: 1585
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1585?usp=email>
X-Gerrit-Commit: 191008d2ddc2c92f584bb9484bceb4193eaaf661
In-Reply-To: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
References: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc0MjY4NDg2MDAwLkk1Mjc3Mzc2NGUwZjQwNTZmZTUzNjc5MThhOWIyZTY3MjBiMTY1YzIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <be2f0a3485dea1956e17574089880b8d0bc09586-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWfA-0008LV-EO
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3333024991796111110=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3333024991796111110==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="G++zOq7qVa8="; charset=UTF-8

--G++zOq7qVa8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail

to look at the new patch=
 set (#2)=2E


Change subject: dev-tools: Add new script to convert mails t=
o Gerrit patches
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

dev-tools: Add new script to convert mails to Gerrit patches

Also che=
cks for some common issues=2E

Change-Id: I52773764e0f4056fe5367918a9b2e672=
0b165c21
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
A d=
ev-tools/gerrit-submit-from-mail=2Esh
1 file changed, 42 insertions(+), 0 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/85/1585/2

diff --git a/dev-tools/gerrit-submit-from-mail=2Esh b/dev-=
tools/gerrit-submit-from-mail=2Esh
new file mode 100755
index 0000000=2E=2E=
ad5775f
--- /dev/null
+++ b/dev-tools/gerrit-submit-from-mail=2Esh
@@ -0,0 =
+1,42 @@
+#!/bin/bash
+
+# Assertions:
+#  - there is a remote called "gerr=
it" that can be used to
+#    pushed to gerrit=2E Create it with
+#    git =
remote add gerrit ssh://<yourgerritusername>@gerrit=2Eopenvpn=2Enet:29418/o=
penvpn=2Egit
+# - the master branch does not contain pending commits, move =
them to branches
+#
+# Usage:
+# - Pipe mail to this script on stdin
+# - Y=
ou can specify the target branch as the first argument to the script
+#   i=
f it is not master=2E
+
+set -eu
+
+TARGET_BRANCH=3D${1:-master}
+SOURCE_DI=
R=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+TIMESTAMP=3D$(date +%Y%m=
%dT%H%M%S)
+
+git -C $SOURCE_DIR checkout $TARGET_BRANCH
+git -C $SOURCE_DI=
R checkout -B mail-submit-${TIMESTAMP}
+git -C $SOURCE_DIR am
+
+warnings=
=3D0
+if git -C $SOURCE_DIR log -n1 --format=3D%an | grep -q "via Openvpn-d=
evel"; then
+    echo WARNING: Author contains \"via Openvpn-devel\"
+    e=
cho Try to get an actual email-adress from the submitter!
+    warnings=3D$=
((warnings + 1))
+fi
+
+if ! git -C $SOURCE_DIR log -n1 --format=3D%b | gre=
p -qi "signed-off-by:"; then
+    echo WARNING: Signed-off-by: line missing=

+    echo Consider adding it=2E
+    warnings=3D$((warnings + 1))
+fi
+
+i=
f [ "$warnings" -gt 0 ]; then
+    echo Please fix the $warnings warnings a=
bove before pushing=2E
+    echo Push the changes with git -C $SOURCE_DIR p=
ush gerrit HEAD:refs/for/$TARGET_BRANCH
+else
+    echo git -C $SOURCE_DIR =
push gerrit HEAD:refs/for/$TARGET_BRANCH
+fi

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
Gerri=
t-Change-Number: 1585
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-C=
C: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--G++zOq7qVa8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1585?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">dev-tools: Add new script to convert mails to Gerrit patches<br=
><br>Also checks for some common issues=2E<br><br>Change-Id: I52773764e0f40=
56fe5367918a9b2e6720b165c21<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>---<br>A dev-tools/gerrit-submit-from-mail=2Esh<br>=
1 file changed, 42 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/85/1585/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/dev-tools/gerrit-submit-from-mail=2Esh b/dev-tools/ge=
rrit-submit-from-mail=2Esh</span><br><span>new file mode 100755</span><br><=
span>index 0000000=2E=2Ead5775f</span><br><span>--- /dev/null</span><br><sp=
an>+++ b/dev-tools/gerrit-submit-from-mail=2Esh</span><br><span>@@ -0,0 +1,=
42 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/bash</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# Assertions:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#  - there is a remote called &quot;gerrit&quot=
; that can be used to</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#    pushed to gerrit=2E Create it with</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#    git remote add gerrit ssh://&lt;yourgerrituserna=
me&gt;@gerrit=2Eopenvpn=2Enet:29418/openvpn=2Egit</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# - the master branch does not contain pendin=
g commits, move them to branches</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Usa=
ge:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - Pipe mail to=
 this script on stdin</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# - You can specify the target branch as the first argument to the script=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   if it is not ma=
ster=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+set -eu</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+TARGET_BRANCH=3D${1:-master}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+SOURCE_DIR=3D$(dirname $(readlink -e &quot;${BASH_S=
OURCE[0]}&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TI=
MESTAMP=3D$(date +%Y%m%dT%H%M%S)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+git -C=
 $SOURCE_DIR checkout $TARGET_BRANCH</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+git -C $SOURCE_DIR checkout -B mail-submit-${TIMESTAMP}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+git -C $SOURCE_DIR am<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+warnings=3D0</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+if git -C $SOURCE_DIR log -n1 --format=3D%an |=
 grep -q &quot;via Openvpn-devel&quot;; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    echo WARNING: Author contains \&quot;via Openv=
pn-devel\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
echo Try to get an actual email-adress from the submitter!</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    warnings=3D$((warnings + 1))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+if ! git -C $SOURCE_DIR log -n1 --format=3D%b | grep -qi &q=
uot;signed-off-by:&quot;; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    echo WARNING: Signed-off-by: line missing</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    echo Consider adding it=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    warnings=3D$((warnings =
+ 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+if [ &quot;$warnings&quot; -gt 0 ]; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    echo Please fix the $warn=
ings warnings above before pushing=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    echo Push the changes with git -C $SOURCE_DIR push ge=
rrit HEAD:refs/for/$TARGET_BRANCH</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   echo git -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1585?usp=3Demail">change 1585</a>=2E To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eor=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1585?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1585 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--G++zOq7qVa8=--


--===============3333024991796111110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3333024991796111110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3333024991796111110==--

