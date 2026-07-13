Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15113C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=coiXrTnJMPh9B/BxNGPZB2SxmCRlILJtJF7g/6qmlhs=; b=cZg7uS2cpadHlB
	nxKERFUh3/OGzejz8xwa/o1C2qdEtauUxWWyNn1uVLzUx26QrCgixts2hJ9WBiL9PJIj9NXbwLD7T
	y8A3zgCp1I2j7QS8MV+F92ijqdWsS57QlHDsrMcfw8+bakbwo02yc0il+XTljUcRNqtL35Qw6im8M
	t/c=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjFgs-0006jP-Mv;
	Mon, 13 Jul 2026 12:23:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjFgr-0006jJ-GM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 12:23:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qjy/1NJqxu7bExFb3m/RCOxzDxFGVVDdcerGyoQJUKo=; b=TJ7dI/NnY6WI33YGtioQnDk2SR
 blaTxDcxDXrIdVC+H8mfr9YqJgYnNziyNK4Qo0o2xI8VqxYm8lAvqcvmXlvotw8pSU9M+ZU7rd6Ii
 5P7WtLNxuQJJ4myZCqwMMFGYuEISbgPKdmyLx0ldqombydGmlLe9icj/ILWhNzGznusY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qjy/1NJqxu7bExFb3m/RCOxzDxFGVVDdcerGyoQJUKo=; b=Q
 Qjko8XLN9rA4M3wW3Q1bmW1UUDOhigF9/LCXcCaW0/RdkgNWuCbQ4TKg/W6nlvWCfcRcJ7Z1QR7fb
 zcRcPkknORTsgiiOglwGcIDvvWU8+vV6NvJYbi/e7aOopxJLKrqkDgI4xqTRr5KVUXaqDUYkVVePr
 tHGPuRwQbnTbfWSo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjFgp-0001ne-0K for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 12:23:17 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so19188295e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783945383; x=1784550183; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=qjy/1NJqxu7bExFb3m/RCOxzDxFGVVDdcerGyoQJUKo=;
 b=bN8yy5ujD7WlcWAK2vuYAiu24roudPvAYkc0dBF6vLXF5ZHphcL7SX+MNsLKE/GVtr
 liRPaMrlw3GcHG8ZZ8ivfZMBZdFZmZDaAssG3eulA+ZkXWF36PY2KlZbRA1l2rLwfRSn
 YvV4GIvhI54EBJg106l3L+0E02rAToJZotf6pkUlFD4LePT4zfmANQuyB8b9NsHeAaAn
 AWRauqpF89uXvWXkRCmuywACl3XYVsR2ILmyZQ7PijtSzgMCMFsCnbbZu6toBE63XxEV
 06fGM4Kkh+hYEs1dwlH6dqO/aTJHz9L4H+SXnwfgdIcxCPRqRL0K/A63yG17WMb1VOB8
 KuPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783945383; x=1784550183;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qjy/1NJqxu7bExFb3m/RCOxzDxFGVVDdcerGyoQJUKo=;
 b=MYoGEZmQJnAQCFzOVGKakyijLPfelfKUvbSqf2c6iq+esnaz6WnboAYS+Vm4zZzKok
 m5sWfoiNBF7d1Ti5gGRGL4yisUzQrKhEj1eLrCs2Cli9ay9rpR58ILoGNgw/fVrpous7
 OhgLaEcthcEB7+uGNVQJCHgJhfjCD9jlMcyMBMdkvW6VyC81P++Q6qol3Pac29dM84xM
 EpsVb5SoQNpme2srNf3rNEdL9Q6M8/s/LlL1YlYtYkPPkI7eFzgNPs2fVfJJq2j8pBj8
 aFR1AhgIaOQ6WrerjZmnwcQntX0qEPxr7rH/auHpE5905jFoqyINljzJxt7HyuSusdMV
 cmwA==
X-Gm-Message-State: AOJu0Yx3xAwCqHc+vV7EGVnNVjLdFyHdrkGGvogs/Z3/+KtQE9tTm3Pa
 pJ8KsW8zyawbGriaD+X8zBshsmSVckquECgEg88RTlZuwCa7SypYhIspKDHDVNIUYTcOYlaXCYu
 1bh+AVe5GQMCymvldEBANlWdQ6DjkEdaTnG40AGCw1lFyKKCD0PHvLnlg6BRqKl4OcNQERdjy5p
 NxiLZJAg==
X-Gm-Gg: AfdE7cnVsRxgitoWbfZkVB/UDWWzJphrjpYDgtvLBaiRLO02KqcfNPAHqy88EEgk/5m
 NqWM3LzN8swI/2L0VTAWQPJNZbTPIA0B822tBJdWbzlOgZhCeMCNAz75E2zzCCKACaUw5meDMkn
 fJAF+gx+ARQtZlX5O4VPS945TsuE4/89D0WyV4Tm2PRYQOZrvkZmRvofevcZbT8MNwarNS5Y6je
 vMjaJAnFY6Sl9UbbCq+melJ19N1XoiuBzNvRtqDC/zuYIWwwC4RkKDTPKyT/FiA1EmdjKywNWPM
 qMEfeV8sZM2HdmbFdt9vJk65+clKb5D4BZPUjhGA87rEZg4LcEcqDD9PtDg8SLiRw0eXBojs2U4
 5S2cfxiyVDUDel8hr+vWZOXGqhTYUKwT8k8g2bxkDZFlsG+gGGA5KiBvv+esz6VCj8G9SgF/kAk
 /0HnXz/i0l6F/uysu1ksblGa9m9bpQOVThiVpjD/TannqoaOZbcOAu0k/mqM7d0biv/KUZwL38o
 7ZfMUJgtlYz7geujX4M8oomwWikydXK4+1wlvX2LmCGHuMB5c/Wd2i1TSvHWgCcaszpZHfLh3kV
 TLc=
X-Received: by 2002:a05:600c:5487:b0:493:f534:3e73 with SMTP id
 5b1f17b1804b1-493f87e6c80mr93391245e9.9.1783945383232; 
 Mon, 13 Jul 2026 05:23:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm245389125e9.6.2026.07.13.05.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:23:02 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 12:23:02 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259
X-Gerrit-Change-Number: 1778
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1778?usp=email>
X-Gerrit-Commit: b20071030db5041bb3ae2e8f0f7a9c96b18ee946
References: <gerrit.1783945377000.I677d3206c24aad997889ed76fb8eca2e6f4b1259@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk2NzdkMzIwNmMyNGFhZDk5Nzg4OWVkNzZmYjhlY2EyZTZmNGIxMjU5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d366e38eec9b126bc3fefe371a6a655ee71fbc5d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjFgp-0001ne-0K
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh.in: Do
 not run resolvectl if systemd is not running
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
Content-Type: multipart/mixed; boundary="===============0099646728047315499=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0099646728047315499==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="duRKq4zXLgU="; charset=UTF-8

--duRKq4zXLgU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1778?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Esh=2Ein: Do not run resolvectl if systemd is not runn=
ing
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_clien=
t=2Esh=2Ein: Do not run resolvectl if systemd is not running

In some cases=
 we will have resolvectl installed but no
running systemd=2E E=2Eg=2E on ol=
d Ubuntu distros resolvectl
is part of the main systemd package which we ha=
ve installed
as a build-dependency=2E

Supress the warnings from resolvectl=
 in this case=2E

Change-Id: I677d3206c24aad997889ed76fb8eca2e6f4b1259
Sign=
ed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/t_client=
=2Esh=2Ein
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/1778/1

diff --git a=
/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 5bf9dbb=2E=2E52f=
2a0d 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@=
@ -243,7 +243,7 @@
     # except Linux and MacOS
     case $UNAME in
 	Linu=
x)
-            if [ -x /usr/bin/resolvectl ] ; then
+            if [ -x /=
usr/bin/resolvectl -a -d /run/systemd/system ] ; then
                 echo=
 "-- linux resolvectl --"
                 resolvectl status
             e=
lse

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I677d3206c24aa=
d997889ed76fb8eca2e6f4b1259
Gerrit-Change-Number: 1778
Gerrit-PatchSet: 1
G=
errit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--duRKq4zXLgU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Esh=2Ein: Do not run resolvectl if systemd is not running<br=
><br>In some cases we will have resolvectl installed but no<br>running syst=
emd=2E E=2Eg=2E on old Ubuntu distros resolvectl<br>is part of the main sys=
temd package which we have installed<br>as a build-dependency=2E<br><br>Sup=
ress the warnings from resolvectl in this case=2E<br><br>Change-Id: I677d32=
06c24aad997889ed76fb8eca2e6f4b1259<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>1 file =
changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/78/1778/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><=
span>index 5bf9dbb=2E=2E52f2a0d 100755</span><br><span>--- a/tests/t_client=
=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@=
@ -243,7 +243,7 @@</span><br><span>     # except Linux and MacOS</span><br>=
<span>     case $UNAME in</span><br><span> 	Linux)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            if [ -x /usr/bin/resolvectl ] ; th=
en</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [ =
-x /usr/bin/resolvectl -a -d /run/systemd/system ] ; then</span><br><span> =
                echo &quot;-- linux resolvectl --&quot;</span><br><span>   =
              resolvectl status</span><br><span>             else</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1778?usp=3Demail">change 1778</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1778?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I677d3206c24aad997889ed76fb8=
eca2e6f4b1259 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 177=
8 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--duRKq4zXLgU=--


--===============0099646728047315499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0099646728047315499==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0099646728047315499==--

