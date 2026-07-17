Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5374BC4451B
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=d2w8BHSEU8LFzHtHULK59BNdH5mBSyQkzHyAunLc9c4=; b=D8+4JlOIruY0sQ
	0R2oAhgnkF/Hbip8wkwX29gEBPn+7wzIeVuR73gdeLyYWGnANIAc1sojutIdkpDJ37dA9zEA9GnFP
	KjVhWtNzAM/vzJL6bEfgY5nH//CfrVBru54BjxzG1bUAdjm7ZRTXJTjhfdL9ASdavr+8K2WGSzgRn
	sww=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wklK7-0003iQ-HA;
	Fri, 17 Jul 2026 16:22:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wklK4-0003i3-UI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 16:22:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5nzxBtPHep6TF0UKXeujTvJxwpuNESeauoiOTDyctmM=; b=KT71uAvk2De/u6ytwFofH4b3hm
 k4zIrhf/XnOkinC1UGTvCgnqujpMEhfwAbBjbjsveWPziqDcHqhY1FLyUCUNNNQ7eDg9zDzkNCJdn
 fJSGXFIfWmlBWVbKtebxO+y2pVHYetDu4/jRDF/jiY3zwGLLyJvshyrIz2x0V+LrMgKc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5nzxBtPHep6TF0UKXeujTvJxwpuNESeauoiOTDyctmM=; b=i
 FWoipCr+YuZfxngY9EUDeVLx6qtNsV+59I5XBPDoOpSPAy3P9h0MGpXP0iVbuymY83hN8rQWryjne
 m7NmugpSiX/3T4DRSiBPNNdXCZTWWG28ZsWX+mJax+EYfHhPxmnt9jYmFrBAm/Pno+V87DayH+gWc
 FdLTkJ66Qmozd1ZQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wklK4-0002MO-RW for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 16:22:01 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4953ddae026so22379975e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 09:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784305309; x=1784910109; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5nzxBtPHep6TF0UKXeujTvJxwpuNESeauoiOTDyctmM=;
 b=hVH13D5nFcMfFEMyDz2t/ixsWcJKFLHyGikHkBYm1xBkcPJqHqhnCynB41zmOGHg5s
 3rsSo8SiPm22LWIehexmDGvts+vgVLBfLFQKve9z29uUWqKyutDfzZbkiYlBCmjbFqgN
 rPgPN1+osaY9bXy4nsWn+1IWsAd6DOWlJe+7sm/fp4atd35ZJZNBkC5jbrfD7iivkop0
 zvf4nMs2UEmFIF2P9SZQglgb/Wv+6CNLyM7LTZY/T/BmUWelwgCAf691F4qDhfh+Wvf5
 0+WunqgaomMdhi+bSn4iygSK9uPLQGSJg001DPToiaKjZGnk+5gchWLFXMytSFO//Q1J
 NWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784305309; x=1784910109;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5nzxBtPHep6TF0UKXeujTvJxwpuNESeauoiOTDyctmM=;
 b=c2zkdIhnJqva4utM3aP8Aik9JolZR/6pNDf0QdAXU8HOv6H+BlIiBhhKaWU6WBvs+a
 QvtSO81X7k6RTHc/zJGTV6nICHENsXtexRwsPtz4klNgC4k30hPsZuTPGqyZCMDiy5MG
 Uu47c2lgOUcyrdubStPy00074JSK82KNCWafbIGRc1hzNKWq993OmpAHYWeSo/F8rZTQ
 wWb42K0XDkdVzwf7v7f5H1I41oeBn+TeafXR83NGznlAdGh69oBpMQaovNToBGU/Mwvq
 tbGHdV7Xf6lA3dFmNf3D1B6prx9ITZgAYgsXWO6BvpFN9qcB1YGQjgMFGNUvkKw/Y4g+
 N2iQ==
X-Gm-Message-State: AOJu0Yzq+/vWGROz7woTIEDV+WpW6PuCPQmVBE3lLvoDKPcj7Jx0SQIk
 8HRnr5MVXJWMOR1F7CHLOKyYDyc9M0L4cJ0tA3UQe5oDrtUE9EQX/Ck5YBDBKKZzYWoGWgtgdXR
 oyKc3oRsS4kp0dC+cVTG5yn+pcm51rMpcG7xsrdK5ZeSViz2yjePb0QVvK7xHABNG7HO/
X-Gm-Gg: AfdE7cm68MiTQDkEgrxZBOUMZdkOFVqVRXaCLUXEJ96h8VqnbgDP+mN12PIDr7VKofP
 xv0YYRZmcOKP7QpI7AxpTyJuW3N6QytBTaqPw5a4/pKcLXYA4RICzgaCY+cAlIiYgou1kVh2iu0
 0RVXUOgWD/rzCoNYs3JwYRKb08rG+ZyJKcXxjOj4aAkni/dtrRuvjnH2/UOzYSrXLu7MNOvFm2V
 XFLGhSeZx/iryjuzaEJ+fQ2EGkMR632yEz9o9wequLB1rQBQpLsRXCtuRftZKkmlXS0j5PUGGgI
 teB4ac7dmh+Gr4QSIk3dq9AvYXKYXMXrvAIXli42LxDMV5koawb8KJhXoRKNmF2cpuW4/7/aZJc
 0Gs/ce3HPFeVV2T6uCyHT6y+TenLKpfCx2Xxf720bIic99LS8Q3f6rFWirf1O+tC0zmG9GPPS0a
 DmyjSmLsm5+R4L+3UtuuuCkFyD5UeTRXYR6pg9PQFoNDpdidFWk+oKdsEEI+A+DIbH9Ae41fB1m
 sZf+93wOdadzQnMAdh7QUrV3TrNIcifhR+1F/VyA1unVkttqKdNWtEQ0VA0EUWFW0VQ
X-Received: by 2002:a05:600c:5888:b0:493:f826:89a6 with SMTP id
 5b1f17b1804b1-4954a38c5f7mr29600965e9.0.1784305309026; 
 Fri, 17 Jul 2026 09:21:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49548e0fcdbsm62715755e9.2.2026.07.17.09.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 09:21:48 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 16:21:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915
X-Gerrit-Change-Number: 1792
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1792?usp=email>
X-Gerrit-Commit: 2e958937a03f010ebf61bad358e44e8b7f72ca34
References: <gerrit.1784305303000.I80a94dde26631e5a665029f495b2104cfecb1915@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLkk4MGE5NGRkZTI2NjMxZTVhNjY1MDI5ZjQ5NWIyMTA0Y2ZlY2IxOTE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4c4b56e809ee0140e46264544950859a7a564bf-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wklK4-0002MO-RW
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6068774699809535283=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6068774699809535283==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YtaGL4GYrGI="; charset=UTF-8

--YtaGL4GYrGI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1792?usp=3Demail

to review the following change=2E


Chang=
e subject: dev-tools/reformat-shell=2Esh: Make our shell code more consiste=
nt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dev-tools/=
reformat-shell=2Esh: Make our shell code more consistent

Our shell code is=
 currently not very consistent about
formatting=2E So provide a tool to ach=
ieve that consistency=2E
Especially in our test code we have several import=
ant shell
scripts that we actively develop=2E

Change-Id: I80a94dde26631e5a=
665029f495b2104cfecb1915
Signed-off-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
---
A dev-tools/reformat-shell=2Esh
1 file changed, 14 insertions(=
+), 0 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn=
 refs/changes/92/1792/1

diff --git a/dev-tools/reformat-shell=2Esh b/dev-t=
ools/reformat-shell=2Esh
new file mode 100755
index 0000000=2E=2Ea6b8a9a
--=
- /dev/null
+++ b/dev-tools/reformat-shell=2Esh
@@ -0,0 +1,14 @@
+#!/bin/sh=

+#
+# Apply consistent formatting to our shell code=2E
+# Uses shfmt: http=
s://github=2Ecom/mvdan/sh
+
+set -u
+
+FORMAT_ARGS=3D"--indent=3D4"
+FORMAT=
_CMD=3D"shfmt --list --write"
+
+# hardcoded to --posix due to =2Ein filena=
me and invalid shebang
+$FORMAT_CMD --posix $FORMAT_ARGS =2E/tests/t_client=
=2Esh=2Ein
+# handle *=2Esh files recursively
+$FORMAT_CMD $FORMAT_ARGS =2E=
/tests =2E/dev-tools

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1792?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I80a94dde26631e5a665029f495b2104cfecb1915
Gerrit-Change-Number: 1792
Gerr=
it-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-=
openvpn@rfc2549=2Eorg>

--YtaGL4GYrGI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">dev-tools/reformat-shell=2Esh: Make our shell code more consistent<br>=
<br>Our shell code is currently not very consistent about<br>formatting=2E =
So provide a tool to achieve that consistency=2E<br>Especially in our test =
code we have several important shell<br>scripts that we actively develop=2E=
<br><br>Change-Id: I80a94dde26631e5a665029f495b2104cfecb1915<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>A dev-tools=
/reformat-shell=2Esh<br>1 file changed, 14 insertions(+), 0 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/92/1792/1</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/dev-tools/reformat-shell=2Esh=
 b/dev-tools/reformat-shell=2Esh</span><br><span>new file mode 100755</span=
><br><span>index 0000000=2E=2Ea6b8a9a</span><br><span>--- /dev/null</span><=
br><span>+++ b/dev-tools/reformat-shell=2Esh</span><br><span>@@ -0,0 +1,14 =
@@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# Apply consistent formatting to our shell co=
de=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Uses shfmt: =
https://github=2Ecom/mvdan/sh</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set -u</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+FORMAT_ARGS=3D&quot;--indent=3D4&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+FORMAT_CMD=3D&quot;shf=
mt --list --write&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# hardcoded to =
--posix due to =2Ein filename and invalid shebang</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+$FORMAT_CMD --posix $FORMAT_ARGS =2E/tests/t_=
client=2Esh=2Ein</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# h=
andle *=2Esh files recursively</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+$FORMAT_CMD $FORMAT_ARGS =2E/tests =2E/dev-tools</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1792?usp=3Demail">change 1792</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1792?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I80a94dde26631e5a665029f495b2104c=
fecb1915 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1792 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--YtaGL4GYrGI=--


--===============6068774699809535283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6068774699809535283==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6068774699809535283==--

