Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4AA8C43458
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=cLshQC+RfjlTIomUBWnwxgYSBBQP07kBQ/6OVOev3J8=; b=WhJQ0ofFtrMlca
	MYcmJPLONKayU26clJ2aZOdepbheETWgiD5bgioRIjdZeDsb+DiQy1bOJeHWqxbAf9SsP8VCy3kI7
	Omqim64AYnoyB/6NBBae+fbqEduhow4hjYn/N+xT+ISUuKbXZxrJWiBSWP8u7smdi8gn4V8E8nmQS
	KqU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weCTl-00055c-Ey;
	Mon, 29 Jun 2026 13:56:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weCTR-00054u-Tp
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:56:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mFu7fUw5gfeit2dfNmwfLFuPr4XAvt0aEy8FpZzQejg=; b=PT6TP2IazDaNim//l8NNPcX8Qx
 r28P353yqpdllv+4b97VtTyFKwD14iKmFEEDDFaK8mw47/Tg+xeSZ2DEmCp6hXnugEbhpyaDP9Qk9
 nLGrog+XK8lhNdY8STfPqEndsMW6eR396rt2cvPjFLD8UaMor+6wcs/qfSTBeh+gf+BY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mFu7fUw5gfeit2dfNmwfLFuPr4XAvt0aEy8FpZzQejg=; b=K
 ur1KQrR851M+vcYqz8NNiwDfT/Ij4+AHHvtXxTJinQfDmJYLdDEPCYz5LxZP5uNfMPiJpxAaamU5P
 5GzxRpvD/ccUEBcXx+SQTyuRnJMDL5/DLr1R/pKLoE5lai+FFUIuSsRFCUjyQ8yLD6GpdFXAVtviT
 aGT3wxigk94gywF8=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weCTL-00011a-F0 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:56:28 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49241dbf9c1so29645885e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782741381; x=1783346181; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mFu7fUw5gfeit2dfNmwfLFuPr4XAvt0aEy8FpZzQejg=;
 b=Oq/8K9OHd6Itc6VRZhgzM/meQZeqCvfRIgtCkO2Wqb2+AF8/mHy7ygiWbdcAJAFozI
 tho96mfT4AeX8y06rBG1DmtmyjvCiNmqZpWcWLTx8tKNma5oIrKJDQf1FNulO46adURB
 +fSSk0infKK+sdz1dVcZuIWQOgCNe8QbrfsuJLXKzzkA+rFEaniA2dUdB4HOa4BzsYXM
 T6PM2hqbjG7ptJBtt5oz/5K6aj6Qo5JbIN9gvd6Gz6t1PqSMBcR+M0+ktoz6xpCO6njL
 iBInKhvySYV5SKVubkV8elP25lelj49rcmzX87W3Gc195onLBjKVjSSUYNCUAH76RnQp
 GRig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782741381; x=1783346181;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mFu7fUw5gfeit2dfNmwfLFuPr4XAvt0aEy8FpZzQejg=;
 b=b8xtjatKqdfplg1yTGLki96POPTMwwu16iVRR2DhG6pvwDd9IPATTDDu1ZyVN7dggZ
 qKtX7He2ix58yHqrJU2dvvSfMV0KUnmipVDI1IGn8S7bO6KpZDe4laD3hDkOMDbB3iiU
 /vOHW+7hXz+3cQm1yp/zqi6+pdCV0oOxp4E1e/RnXeb1mD+fRvGpUT1kJ54JDK43lQ6Z
 Do1CX4nNb2naUKHZ+a2elMQNtIJ3+PIWM0p5YiI0zp5VLnIKVaKuKb8ZV/HwFgvIY847
 YmvuXvo6Loynokf3pSG1+LZpNfUEGYHCLPvQ5Fy/P0rlYDpjOrWvLGTtEO79FQ8ZO4b7
 Q5Bg==
X-Gm-Message-State: AOJu0YyaeDC7azaQGZLj7Glam38jbzCG6WVpCwMJ4Y/j0Q/QknRztogd
 5+w6rLyir+6X8f4J0y0Wb8y0D5o1oLPD0sRRS3/XM+TkCtTqUghfbTMwYELIN12Jj2ib6E4lwwh
 Ezg+4DhRAePWA21+UVcOJuEVtFI7tn3gec/HAGSlX53OqqEDgNPgn34mFGo++BMVur8NB
X-Gm-Gg: AfdE7ck+FELpU54LmyT4YFvzFNmnPuFrPG5X7VPyDF7N7O08bL3Szyazx6vn8+81/lU
 xXzEAAb6Hpo3DMafMAgycTmZHteLRKw5g9LkGO8+pXtA/7tU6dzsYDS+7pMySCPelUtA7k5Guer
 plq9WBgr8nvgkDQjxfIkKLCSoFgc4zpkCY3DFUsIejdMd/KtMM/nquF6+/vI3qg5+N2owTKWOj/
 NfHuU9IuLaXhXRLtOEBeJ2t0yESjYztvEB/N2eoJdNVipqeXqUdg/3HZiaRTuUxe0DugsBahYQq
 W6IL+9HAovy5oRs4R/G9/Il+zQoixNmnfjgZcQR3117Gv+eTsSoZ6NKDgHdEqEfx1C8qpk0I2j8
 gDNLgDrCkQNEd58RjfUVEpuoTGhG8seaAEKWQbYNQDHOyt9hEpvMwvzuKUzckpVD4efZYPVNfqL
 ULUV6JFHb/IG43BTxERFsutwyrP4MvUwLTI7bwjvUVpNpvMaEuQCvJ7UJce/drxjsRiCMikvqNI
 QhylE6Z78tBtkO9hmC/jrZw2PDrQ/qSmiiMFdqoJwdBdOKZocHWGLqDPmu2XMNdF6nsHHof3JaY
 SZFTvCu/ecMaUQ==
X-Received: by 2002:a05:600c:4fc1:b0:492:4d7e:135f with SMTP id
 5b1f17b1804b1-4926686a8c0mr274057755e9.15.1782741381252; 
 Mon, 29 Jun 2026 06:56:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268ffe204sm323883935e9.7.2026.06.29.06.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:56:20 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 13:56:20 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
X-Gerrit-Change-Number: 1756
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1756?usp=email>
X-Gerrit-Commit: 07426a9e7f59b1e980964b39cae2ed4b02e2d53d
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLklhNGE5YTZiYWZiNmJjYjNmZTMzMWE5MmNmYmI2NGJlNzhmNmFhMzNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c916bf07263ab62e7e46f792fd4a2bee3f001dea-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weCTL-00011a-F0
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.sh.in:
 Allow to override the location of t_client_ips.rc
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
Content-Type: multipart/mixed; boundary="===============6873526347008679833=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6873526347008679833==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mlr4tu0rjXU="; charset=UTF-8

--mlr4tu0rjXU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1756?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Esh=2Ein: Allow to override the location of t_client_i=
ps=2Erc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_cl=
ient=2Esh=2Ein: Allow to override the location of t_client_ips=2Erc

Makes =
it easier to use t_client=2Esh in other contexts=2E

This is based on work =
by Gert Doering for the t_server
test infrastructure=2E

Change-Id: Ia4a9a6=
bafb6bcb3fe331a92cfbb64be78f6aa33a
Signed-off-by: Frank Lichtenheld <frank@=
lichtenheld=2Ecom>
---
M tests/t_client=2Esh=2Ein
M tests/update_t_client_i=
ps=2Esh
2 files changed, 4 insertions(+), 4 deletions(-)



  git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1756/1

diff --git a=
/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 46646c4=2E=2E5b4=
07ff 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@=
@ -19,6 +19,9 @@
 srcdir=3D"${srcdir:-=2E}"
 top_builddir=3D"${top_builddir=
:-=2E=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
+t_=
client_ips_rc=3D"${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}"
+up=
date_t_client_ips=3D"${update_t_client_ips:-${srcdir}/update_t_client_ips=
=2Esh}"
+
 if [ -r "${top_builddir}"/t_client=2Erc ] ; then
     =2E "${top=
_builddir}"/t_client=2Erc
 elif [ -r "${srcdir}"/t_client=2Erc ] ; then
@@ =
-339,7 +342,7 @@
     # If EXCEPT_IFCONFIG* variables for this test are mis=
sing, run an --up
     # script to generate them dynamically=2E
     if [ -=
z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; then
-        up=3D"=
--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --script-securi=
ty 2 --up ${srcdir}/update_t_client_ips=2Esh"
+        up=3D"--setenv TESTN=
UM $SUF --setenv RC ${t_client_ips_rc} --script-security 2 --up ${update_t_=
client_ips}"
     else
         up=3D""
     fi
diff --git a/tests/update_t=
_client_ips=2Esh b/tests/update_t_client_ips=2Esh
index 96e3826=2E=2E013504=
f 100755
--- a/tests/update_t_client_ips=2Esh
+++ b/tests/update_t_client_i=
ps=2Esh
@@ -2,9 +2,6 @@
 #
 # This --up script caches the IPs handed out by=
 the test VPN server to a file
 # for later use=2E
-
-RC=3D"$TOP_BUILDDIR/t=
_client_ips=2Erc"
-
 grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC > /dev/null 2>&1=

 if [ $? -ne 0 ]; then
     echo "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_lo=
cal" >> $RC

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
756?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newcha=
nge
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia4a9a6=
bafb6bcb3fe331a92cfbb64be78f6aa33a
Gerrit-Change-Number: 1756
Gerrit-PatchS=
et: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@r=
fc2549=2Eorg>

--mlr4tu0rjXU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Esh=2Ein: Allow to override the location of t_client_ips=2Er=
c<br><br>Makes it easier to use t_client=2Esh in other contexts=2E<br><br>T=
his is based on work by Gert Doering for the t_server<br>test infrastructur=
e=2E<br><br>Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests=
/t_client=2Esh=2Ein<br>M tests/update_t_client_ips=2Esh<br>2 files changed,=
 4 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1756/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span=
>index 46646c4=2E=2E5b407ff 100755</span><br><span>--- a/tests/t_client=2Es=
h=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -1=
9,6 +19,9 @@</span><br><span> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br=
><span> top_builddir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br><span>=
 openvpn=3D&quot;${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+t_client_ips_rc=3D&quot;=
${t_client_ips_rc:-${top_builddir}/t_client_ips=2Erc}&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+update_t_client_ips=3D&quot;${updat=
e_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if [ -r &quot;${top=
_builddir}&quot;/t_client=2Erc ] ; then</span><br><span>     =2E &quot;${to=
p_builddir}&quot;/t_client=2Erc</span><br><span> elif [ -r &quot;${srcdir}&=
quot;/t_client=2Erc ] ; then</span><br><span>@@ -339,7 +342,7 @@</span><br>=
<span>     # If EXCEPT_IFCONFIG* variables for this test are missing, run a=
n --up</span><br><span>     # script to generate them dynamically=2E</span>=
<br><span>     if [ -z &quot;$expect_ifconfig4&quot; ] || [ -z &quot;$expec=
t_ifconfig6&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        up=3D&quot;--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_bu=
ilddir} --script-security 2 --up ${srcdir}/update_t_client_ips=2Esh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        up=3D&quot;--=
setenv TESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-security 2 --up=
 ${update_t_client_ips}&quot;</span><br><span>     else</span><br><span>   =
      up=3D&quot;&quot;</span><br><span>     fi</span><br><span>diff --git =
a/tests/update_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh</span><br=
><span>index 96e3826=2E=2E013504f 100755</span><br><span>--- a/tests/update=
_t_client_ips=2Esh</span><br><span>+++ b/tests/update_t_client_ips=2Esh</sp=
an><br><span>@@ -2,9 +2,6 @@</span><br><span> #</span><br><span> # This --u=
p script caches the IPs handed out by the test VPN server to a file</span><=
br><span> # for later use=2E</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-RC=3D&quot;$TO=
P_BUILDDIR/t_client_ips=2Erc&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt; /=
dev/null 2&gt;&amp;1</span><br><span> if [ $? -ne 0 ]; then</span><br><span=
>     echo &quot;EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt;=
 $RC</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail">change 1756</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia4a9a6bafb6bcb=
3fe331a92cfbb64be78f6aa33a </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1756 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>

</body></html>
--mlr4tu0rjXU=--


--===============6873526347008679833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6873526347008679833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6873526347008679833==--

