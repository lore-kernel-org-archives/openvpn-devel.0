Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3735C5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7CmP2oP+0Bjeyl5EN5l0UvVfvsox+WcNOfl6+sf0lg=; b=N7qNncPVjRikW4o06c80VlNOpM
	G+HCQ8khRJolRJWR1wodolielz+kp/StNMmD3wmgFUNDYwMFNoA4jYJ8Rx71RR2OlvHy9wkdAVgbs
	SneMcAL4vyZ5978KnNjaHB08Ud2rSY85iULBGigGoaOTxppeozaHx7j+2hTB6ygD6LYE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwzp7-0000Yt-4T;
	Thu, 20 Aug 2026 10:16:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wwzp5-0000Yn-GS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1js/NR8xQhwYbpqzDjfWb7+maiOfMIfrvH5BMYmmZm4=; b=dmD1LM4SLrMoDkzCiJCiHRA96l
 AaX8URE3GGNiu2vJTh0nFfVUqZdC5v7tMNS1c0oJooWaLSXcTyulU63aaK3hUD9fyNIzZ9UQAF+IC
 TBySEA0TXLQYL5eiJELjCftxJ0OxNnJPqKJXUuvLL080OT+ZQxG9lQD6VWxLNWVctCfA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1js/NR8xQhwYbpqzDjfWb7+maiOfMIfrvH5BMYmmZm4=; b=m
 ZDxiIi6D4VKN9S96qtxADmZ8tL2tZ9SvD2D3O2kb4F9BEex+VMmMwTscuMwsAQ7iBU1YEAhkL9ice
 TbsFicuYlE7OI5tZFuBX2mJNYPIxVqVvQKLQor1vLr+KjTaXWPqGHUKYDWORf07/C/4rWppZHxnVg
 YPglNgD5VG2kGnJM=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwzp3-0003GS-RZ for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:16:35 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-499b57cf2f3so792525e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787220987; x=1787825787; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1js/NR8xQhwYbpqzDjfWb7+maiOfMIfrvH5BMYmmZm4=;
 b=W7W6qBz4F/4wSkWQTfayL3RGjRvCupwqLflmwRPElrY2Xo4uKGaXK5+9LjiVIRCCuD
 fMQwGlpOhgzdsHAobaNEM/olI03R9oEiFunHfnQydICgjCzhq/Prq2AdbUV79Xo+qkfD
 9V9tMO5ZdS5bF67JV3cnz6rHlc/A4aee/nxyPVjeci26JScUOqR1WxOaOI0/srJOQJLG
 vyN7B7BOzAjOe94zW1lh0hORdVezpDURDIXp4FNp3WGYoCXzFLcGnxlVejbQmvsqJrpJ
 rThEByb6E0W9VBZN5RfFkfa83rtY2Bb/Qtq9aOM1cSdqx77LXGelQE/vHdxWWAN+2aEf
 HJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787220987; x=1787825787;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1js/NR8xQhwYbpqzDjfWb7+maiOfMIfrvH5BMYmmZm4=;
 b=bLAfS6umLucfCfiMx82I6NSMohemYHBdS254LKvmF8CKEbjfml9GWoBiNgdyOoxPan
 quJ0jc9QTHOAe9KFdx5qkHeBmvYfy0LOFBTr6Q0vX4y70wME9FS4bdx6uC0vQleGwhtu
 sCMYIrzWCUTKJNU8BCa5X+KSxYGh0HbzQtTY0P4s8v3dKzSZbktr1Q8McZniejxjw37T
 R4X/aepJ8YqILpqBSmY8VWEbBEeUrlS9Bd0e37djV3gbevCL8G28d0k4dXfiH1Im+4Co
 Hmqo5K5GZYLhKR8MWEPik/eSGnK7E0VjkCmT3nE0t8TerjVbLWKMHB1DcVMAA8Knaa4i
 7SdQ==
X-Gm-Message-State: AOJu0YyzfAU3OoifLDycgKx42CcuLikyVhWO62NlZVv5sfCG9Pje9Srj
 /YN2NgN8ttaHlv+sECoxmeECYMkEoDIQ3ARYDuolKMIOu7btDatpKLXWIbo0f4RPbgvfkGmYV0i
 9btJp2F0aweuFMAKT4du+oup9ow0K6iYtHNF7l232aSfhqpT4VdsEbb4MiGn43BmvIvcY
X-Gm-Gg: AR+sD130sQDujh3lEeK2CTUQqRaqlrJhIonERtvvRpME/icebnucT3vbUAu0DQJ7Bzz
 r0SlIDSsJVLw9KqgjsNG0udJPYTNTziSuKDkflbKN6yTuOwLKEH6SLzC48MKrZiB1lDKTeh4tPM
 6vOyv5twrFVGn92n1TORaA0qsyd/EXz9Gjup25/dSDdhYj3SGOrLMUFcYB47cbnY1rSiy8O/8gw
 FLC/HPsuZYoK9pQj3l3mBgNX/2BSXTZW/dnY7qHqVgEPHo1aRiFks7mhlrgCATtf+kcX/iOOhhL
 zAgWIUldvmu0RjgobvZ1XgSkKs5lwTylnWzmVkUa79OaTguteOrDpWXZvejbAVv3JHBtpyDBUaZ
 LE3+8Jw8V2DhJCXPjNumFdfIMKxQaHWC9R4ywlewumcHS5vYMwU3JAgGITwuIQUIpKdvZcTAcN1
 tA/RZeuotndFTlu5W7wB4rX25PwnIZUYvbb2phdZoMtZ4sSySMT9KvZp/pqfRfWF07Y2piXgvpB
 7blFlYGyYdSVeXfym5tTEo6yOQaCq1OrNybd/M7NBiTmsNyXX82zXN+2mpbr7mNjo8wEBCQ/dzN
 Xg3Iv9te4n65ww/rQvKdUPU0Gn/DbG4bRR5p1fU1eOKXiCj4J0c=
X-Received: by 2002:a05:600c:1f85:b0:499:90d0:4906 with SMTP id
 5b1f17b1804b1-499b06bf1a1mr70937165e9.5.1787220987178; 
 Thu, 20 Aug 2026 03:16:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b20a14c6sm39993635e9.0.2026.08.20.03.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:16:26 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 10:16:24 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
X-Gerrit-Change-Number: 1792
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1792?usp=email>
X-Gerrit-Commit: 5663fd71f4358e404031d57f9ec1acbb0b78358a
In-Reply-To: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
References: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk4MGE5NGRkZTI2NjMxZTVhNjY1MDI5ZjQ5NWIyMTA0Y2ZlY2IxOTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f9f6af3130a988a446c7118807f3325c936c42dc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wwzp3-0003GS-RZ
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 dev-tools/reformat-shell.sh: Make our shell code more consistent
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4065656477912982407=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4065656477912982407==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KEhiVnwydn8="; charset=UTF-8

--KEhiVnwydn8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: dev-tools/reformat-shell=2Esh: Make our shell =
code more consistent
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

dev-tools/reformat-shell=2Esh: Make our shell code more consistent
=

Our shell code is currently not very consistent about
formatting=2E So pro=
vide a tool to achieve that consistency=2E
Especially in our test code we h=
ave several important shell
scripts that we actively develop=2E

Change-Id:=
 I80a94dde26631e5a665029f495b2104cfecb1915
Signed-off-by: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792
Message-Id: <=
20260820091512=2E4550-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-ar=
chive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38546=2Ehtml
Signed-=
off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
A dev-tools/reformat-she=
ll=2Esh
1 file changed, 14 insertions(+), 0 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/92/1792/5

diff --git a/=
dev-tools/reformat-shell=2Esh b/dev-tools/reformat-shell=2Esh
new file mode=
 100755
index 0000000=2E=2Edbbdaa9
--- /dev/null
+++ b/dev-tools/reformat-s=
hell=2Esh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Apply consistent formatting to =
our shell code=2E
+# Uses shfmt: https://github=2Ecom/mvdan/sh
+
+set -u
+
=
+FORMAT_ARGS=3D"--indent=3D4 --func-next-line --case-indent"
+FORMAT_CMD=3D=
"shfmt --list --write"
+
+# hardcoded to --posix due to =2Ein filename and =
invalid shebang
+$FORMAT_CMD --posix $FORMAT_ARGS =2E/tests/t_client=2Esh=
=2Ein
+# handle *=2Esh files recursively
+$FORMAT_CMD $FORMAT_ARGS =2E/test=
s =2E/dev-tools

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1792?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
80a94dde26631e5a665029f495b2104cfecb1915
Gerrit-Change-Number: 1792
Gerrit-=
PatchSet: 5
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <raz=
vanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbit=2Ecom>

--KEhiVnwydn8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">dev-tools/reformat-shell=
=2Esh: Make our shell code more consistent<br><br>Our shell code is current=
ly not very consistent about<br>formatting=2E So provide a tool to achieve =
that consistency=2E<br>Especially in our test code we have several importan=
t shell<br>scripts that we actively develop=2E<br><br>Change-Id: I80a94dde2=
6631e5a665029f495b2104cfecb1915<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792<b=
r>Message-Id: &lt;20260820091512=2E4550-1-gert@greenie=2Emuc=2Ede&gt;<br>UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg38546=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>A dev-tools/reformat-shell=2Esh<br>1 file changed, 14 insert=
ions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/92/1792/5</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev=
-tools/reformat-shell=2Esh b/dev-tools/reformat-shell=2Esh</span><br><span>=
new file mode 100755</span><br><span>index 0000000=2E=2Edbbdaa9</span><br><=
span>--- /dev/null</span><br><span>+++ b/dev-tools/reformat-shell=2Esh</spa=
n><br><span>@@ -0,0 +1,14 @@</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#!/bin/sh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Apply consistent =
formatting to our shell code=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# Uses shfmt: https://github=2Ecom/mvdan/sh</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+set -u</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+FORMAT_ARGS=3D&=
quot;--indent=3D4 --func-next-line --case-indent&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+FORMAT_CMD=3D&quot;shfmt --list --write&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# hardcoded to --posix due to =2E=
in filename and invalid shebang</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+$FORMAT_CMD --posix $FORMAT_ARGS =2E/tests/t_client=2Esh=2Ein</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# handle *=2Esh files=
 recursively</span><br><span style=3D"color: hsl(120, 100%, 40%);">+$FORMAT=
_CMD $FORMAT_ARGS =2E/tests =2E/dev-tools</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1792=
?usp=3Demail">change 1792</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1792?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchse=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 1792 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerri=
t-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</bo=
dy></html>
--KEhiVnwydn8=--


--===============4065656477912982407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4065656477912982407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4065656477912982407==--

