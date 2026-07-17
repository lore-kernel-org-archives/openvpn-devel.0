Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E915C44520
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UDIhwJ5bB+7k+3CTaHUvHiZNvqaJU+mUdh1JUFAkAWM=; b=MI6ZJCUXWBj3dFT9uW7ynKRLLp
	uupc+bwSGwn3erj7GsWHvmDBjvMtkhO6Bt2MHYzIQtlRT87Zw7g9TCKiZzR0yeSZs1bwTJV5BJ/Yy
	q8fZ0yb1pTVU8HsGXT5wSV/iR9v6zjJ1SnzX4okKFkh6jgV1CD9NSnKudYPH0x/4jDAU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkhUc-0007Rz-9z;
	Fri, 17 Jul 2026 12:16:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkhUb-0007Rs-9T
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:16:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6LUhQo4iR0M48T52pg55/rGO9KVnUNTISAlrbqzHOFg=; b=OPSkD5zogqTB/FoRFL49YU7lBI
 5/RbMkMALDgKvAUiR48jixBacQ0LdCWNWQdIVsGj9DQqdJH4jvNY+Dq5XAYEvG6JjUQ7RxGrqwXoE
 npYRGl5l7Bk0yqlnevZ7/CCY0hYRFUTy2icV93I/pHCxXNOtR40Kx2r6IfSO3257MHQs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6LUhQo4iR0M48T52pg55/rGO9KVnUNTISAlrbqzHOFg=; b=M
 +jF3uiDKYq0E9rwlSr5hcenmeofEyVzzGsau98diH0xYGVO7OvUDmqdTmLdwk+sxHwoqKh76vNQT5
 UyNm8Dp2l8LGCOpUjaFHig+qFDSh4J2GHFd2ARMqDlp+f285Ji4RegEWMNNonkg4i4URPJJp/w6ZU
 pa0YByA5QVmphgU8=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkhUX-0007NC-Nc for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:16:34 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4954d383e64so1000855e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 05:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784290582; x=1784895382; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6LUhQo4iR0M48T52pg55/rGO9KVnUNTISAlrbqzHOFg=;
 b=cBpUM+ohGStgFZptl06AK4leB6u2cn9EVTdnSWyKTMjqfmF4zeRZEVHZZiyOltOuMI
 n9iQlHNjVazk1YPQymYSdEEm68W/6JBARdmDCnOgn0WDaozL58Na31J0iSQTNHIvFyKv
 ehWo1HrUGkeeGF9iZ9+M3d/2J2JQ2veQ+REBuwkbMKV7/QtGY61Le5iJTlaVx6u4Swzl
 gYYzCYlKdvFFGPWrrfoVIJXm4cdnaz7m6Efn/psam0RxSykI+jL3ZxdoX4hEmf8vr6pH
 QU6uWIuFgfAcFT2fP9maMX5Lf+gKQ1UqSk4RMYp6c/QFq9wXDpVDSbE5uRG+MoIawHUS
 0Pdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290582; x=1784895382;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6LUhQo4iR0M48T52pg55/rGO9KVnUNTISAlrbqzHOFg=;
 b=EH3h4g0w7rDE4AYGr5OFUDjwDa+dX7AUd0eHOpiM1QDXdyk0XEgNF7FI6/uXY3i9Ih
 7GtRdFcIscLtdzfIQUxIukdC+qzTyaoAlHLJT1W92fkwo+a1v4Vj4BqnnbULJLGFjrzb
 UpCnfDZSIMWmj9nSjkbyUYFCTFPrtp9UtbyQaNyviClQ+EMtfA70BRxkLkkQq+VkOHRC
 CTvH+tmx1dYZ+a7L5XuBg1z40TdNFT2wYdgCmq0CjZ/445TohTbb01qJ7uZ8FB27Iylo
 3RP2snTgbYpekTOG6Yq/D6Ouzl9x6/xxRTtsNPN+UvaaXqt4DFMkpfn0/PmjrwTaRfc8
 R+1w==
X-Gm-Message-State: AOJu0Yz+B1mNhm/SDYnxp/peOWp1R2pWGuYPdc1FnR0IpFmDo6flj7zt
 ZXlzWAUUktdt+5iZpR5xbtxJTPGb6pAaTxMp20Yg/s7wJOx2M+0bI1CDNPdoaorM3dVaDO+7+G2
 2cZ8+JPRmvAA6wvTnlgVQGg40N2PrBLa87pbVHlli3bxKMidksv48KINMVKaq52oUTSEk
X-Gm-Gg: AfdE7ck22jHAKGilsFrtrqArXAKod1cbuAm5+wbbWUInBRJ9DpPIvShJ03pJaUn5PkB
 sXzpNPx/XADOBH/Zn1F83hHMZxmYyysNY/jgvQG5555I+A6/PHXJiMWWeIrPJ3iC1OefjCPOyr7
 A5mBMNoTfcKCE5D620iZV6NBgspanBlzBl7JcYrh3ByutXjIRbqZY6oyb+4QvTFmYeQDKhCV89r
 NV1zqREa3b8qD8X3d/uWTxva2X7VsKMSSVLbtFCCkQBT8KTYCEwKzaDhSK3F4+ZVL1HlOO3xSup
 sARALLDCGq8aW8fF16ErfwCcGRaG8fLI2YMWV3djnoVrEOdwlTpf4SgfbXI3wHCAz3T+AUNojDJ
 YYjEVozlfR7fD7RHYIZwXwxmGkWgscvxsZX50nhyAnLfoGUv8h/q33qGOK1d/CDb8AAUFov3Yz7
 6JloP/TrAQQRVZVCIoQu6fBznqDIZmPPduqiWcggBRvelLXAtVEndN+xgMCOkMyfKhOnEg0gxnD
 sKODnXMSnDjioHwPdosxFMSvaC1gLIZMZHhlKbqV/qY8NfwmAkzS4u55c0ajTtP4AqsHG2OqWfz
 C+A=
X-Received: by 2002:a05:600c:1c0b:b0:495:46dd:e238 with SMTP id
 5b1f17b1804b1-4954a50ea30mr30501465e9.30.1784290581715; 
 Fri, 17 Jul 2026 05:16:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2e850dsm48230945e9.9.2026.07.17.05.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:16:20 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 12:16:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
X-Gerrit-Change-Number: 1756
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1756?usp=email>
X-Gerrit-Commit: f3ee55c8ce8c348bc1dbf6cc89d941ba8a29a30e
In-Reply-To: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLklhNGE5YTZiYWZiNmJjYjNmZTMzMWE5MmNmYmI2NGJlNzhmNmFhMzNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <688855f544245076d820d6fc0182dc9ecfab44b5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkhUX-0007NC-Nc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in:
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
Content-Type: multipart/mixed; boundary="===============1011103235843905327=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1011103235843905327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k2D5wfnhZC4="; charset=UTF-8

--k2D5wfnhZC4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1756?usp=3Demail

to look at the new patch set (#3)=2E

=

Change subject: t_client=2Esh=2Ein: Allow to override the location of t_cl=
ient_ips=2Erc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


t_client=2Esh=2Ein: Allow to override the location of t_client_ips=2Erc

=
Makes it easier to use t_client=2Esh in other contexts=2E

This is based on=
 work by Gert Doering for the t_server
test infrastructure=2E

Change-Id: I=
a4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
Signed-off-by: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
---
M tests/t_client=2Erc-sample
M tests/t_client=
=2Esh=2Ein
M tests/update_t_client_ips=2Esh
3 files changed, 12 insertions(=
+), 6 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/56/1756/3

diff --git a/tests/t_client=2Erc-sample b/tests/t_c=
lient=2Erc-sample
index 2a4bdb4=2E=2E003dec4 100644
--- a/tests/t_client=2E=
rc-sample
+++ b/tests/t_client=2Erc-sample
@@ -14,8 +14,8 @@
 #FPING_EXTRA_=
ARGS=3D"-t 1000"
 
 # Load EXPECT_IFCONFIG* parameters from cache
-if [ -r =
"${top_builddir}/t_client_ips=2Erc" ]; then
-    =2E "${top_builddir}/t_cli=
ent_ips=2Erc"
+if [ -r "${t_client_ips_rc}" ]; then
+    =2E "${t_client_ip=
s_rc}"
 else
     echo "NOTICE: missing t_client_ips=2Erc will be auto-gene=
rated"
 fi
@@ -63,6 +63,12 @@
 # PING6_HOSTS_x      =3D "these hosts musts =
ping when openvpn is up (IPv6 fping6)"
 # EXPECT_FAIL_x      =3D "instead o=
f waiting for connection wait for this error message"
 #
+# Note that the E=
XPECT_IFCONFIG{4,6} options are not generally required, the
+# tests will r=
emember the ip address they got on the first run in t_client_ips=2Erc
+# an=
d will expect to get the same address again=2E But it can be useful to hard=
-code
+# the IP when the server is expected to send a very specific address=
, e=2Eg=2E when
+# using ccd on the server-side or in a P2P scenario=2E
+#
=
 # hook test options:
 #
 # CHECK_SKIP_x      =3D "commands to execute befo=
re openvpn, skip test on failure"
diff --git a/tests/t_client=2Esh=2Ein b/t=
ests/t_client=2Esh=2Ein
index 0ef2ec5=2E=2E9f32a5a 100755
--- a/tests/t_cli=
ent=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -19,6 +19,9 @@
 srcdir=3D"$=
{srcdir:-=2E}"
 top_builddir=3D"${top_builddir:-=2E=2E}"
 openvpn=3D"${open=
vpn:-${top_builddir}/src/openvpn/openvpn}"
+t_client_ips_rc=3D"${t_client_i=
ps_rc:-${top_builddir}/t_client_ips=2Erc}"
+update_t_client_ips=3D"${update=
_t_client_ips:-${srcdir}/update_t_client_ips=2Esh}"
+
 if [ -r "${top_build=
dir}"/t_client=2Erc ] ; then
     =2E "${top_builddir}"/t_client=2Erc
 elif=
 [ -r "${srcdir}"/t_client=2Erc ] ; then
@@ -326,7 +329,7 @@
     # If EXCE=
PT_IFCONFIG* variables for this test are missing, run an --up
     # script=
 to generate them dynamically=2E
     if [ -z "$expect_ifconfig4" ] || [ -z=
 "$expect_ifconfig6" ]; then
-        up=3D"--setenv TESTNUM $SUF --setenv =
TOP_BUILDDIR ${top_builddir} --script-security 2 --up ${srcdir}/update_t_cl=
ient_ips=2Esh"
+        up=3D"--setenv TESTNUM $SUF --setenv RC ${t_client_=
ips_rc} --script-security 2 --up ${update_t_client_ips}"
     else
        =
 up=3D""
     fi
diff --git a/tests/update_t_client_ips=2Esh b/tests/update=
_t_client_ips=2Esh
index 96e3826=2E=2E013504f 100755
--- a/tests/update_t_c=
lient_ips=2Esh
+++ b/tests/update_t_client_ips=2Esh
@@ -2,9 +2,6 @@
 #
 # T=
his --up script caches the IPs handed out by the test VPN server to a file
=
 # for later use=2E
-
-RC=3D"$TOP_BUILDDIR/t_client_ips=2Erc"
-
 grep EXPEC=
T_IFCONFIG4_$TESTNUM=3D $RC > /dev/null 2>&1
 if [ $? -ne 0 ]; then
     ec=
ho "EXPECT_IFCONFIG4_$TESTNUM=3D$ifconfig_local" >> $RC

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6=
aa33a
Gerrit-Change-Number: 1756
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--k2D5wfnhZC4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1756?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">t_=
client=2Esh=2Ein: Allow to override the location of t_client_ips=2Erc<br><b=
r>Makes it easier to use t_client=2Esh in other contexts=2E<br><br>This is =
based on work by Gert Doering for the t_server<br>test infrastructure=2E<br=
><br>Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_clie=
nt=2Erc-sample<br>M tests/t_client=2Esh=2Ein<br>M tests/update_t_client_ips=
=2Esh<br>3 files changed, 12 insertions(+), 6 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes=
/56/1756/3</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/tests/t_client=2Erc-sample b/tests/t_client=
=2Erc-sample</span><br><span>index 2a4bdb4=2E=2E003dec4 100644</span><br><s=
pan>--- a/tests/t_client=2Erc-sample</span><br><span>+++ b/tests/t_client=
=2Erc-sample</span><br><span>@@ -14,8 +14,8 @@</span><br><span> #FPING_EXTR=
A_ARGS=3D&quot;-t 1000&quot;</span><br><span> </span><br><span> # Load EXPE=
CT_IFCONFIG* parameters from cache</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-if [ -r &quot;${top_builddir}/t_client_ips=2Erc&quot; ]; then<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top_bu=
ilddir}/t_client_ips=2Erc&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+if [ -r &quot;${t_client_ips_rc}&quot; ]; then</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    =2E &quot;${t_client_ips_rc}&quo=
t;</span><br><span> else</span><br><span>     echo &quot;NOTICE: missing t_=
client_ips=2Erc will be auto-generated&quot;</span><br><span> fi</span><br>=
<span>@@ -63,6 +63,12 @@</span><br><span> # PING6_HOSTS_x      =3D &quot;th=
ese hosts musts ping when openvpn is up (IPv6 fping6)&quot;</span><br><span=
> # EXPECT_FAIL_x      =3D &quot;instead of waiting for connection wait for=
 this error message&quot;</span><br><span> #</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# Note that the EXPECT_IFCONFIG{4,6} options are n=
ot generally required, the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# tests will remember the ip address they got on the first run in t_=
client_ips=2Erc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# an=
d will expect to get the same address again=2E But it can be useful to hard=
-code</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# the IP when =
the server is expected to send a very specific address, e=2Eg=2E when</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# using ccd on the server=
-side or in a P2P scenario=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span> # hook test options:</span><br><span> #</span>=
<br><span> # CHECK_SKIP_x      =3D &quot;commands to execute before openvpn=
, skip test on failure&quot;</span><br><span>diff --git a/tests/t_client=2E=
sh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index 0ef2ec5=2E=2E9f32a=
5a 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>++=
+ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -19,6 +19,9 @@</span><br><s=
pan> srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br><span> top_builddir=3D&q=
uot;${top_builddir:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;${openvp=
n:-${top_builddir}/src/openvpn/openvpn}&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+t_client_ips_rc=3D&quot;${t_client_ips_rc:-${top_=
builddir}/t_client_ips=2Erc}&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+update_t_client_ips=3D&quot;${update_t_client_ips:-${srcdir}=
/update_t_client_ips=2Esh}&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> if [ -r &quot;${top_builddir}&quot;/t_client=
=2Erc ] ; then</span><br><span>     =2E &quot;${top_builddir}&quot;/t_clien=
t=2Erc</span><br><span> elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ] ; t=
hen</span><br><span>@@ -326,7 +329,7 @@</span><br><span>     # If EXCEPT_IF=
CONFIG* variables for this test are missing, run an --up</span><br><span>  =
   # script to generate them dynamically=2E</span><br><span>     if [ -z &q=
uot;$expect_ifconfig4&quot; ] || [ -z &quot;$expect_ifconfig6&quot; ]; then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        up=3D&quot;--=
setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --script-security=
 2 --up ${srcdir}/update_t_client_ips=2Esh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        up=3D&quot;--setenv TESTNUM $SUF --set=
env RC ${t_client_ips_rc} --script-security 2 --up ${update_t_client_ips}&q=
uot;</span><br><span>     else</span><br><span>         up=3D&quot;&quot;</=
span><br><span>     fi</span><br><span>diff --git a/tests/update_t_client_i=
ps=2Esh b/tests/update_t_client_ips=2Esh</span><br><span>index 96e3826=2E=
=2E013504f 100755</span><br><span>--- a/tests/update_t_client_ips=2Esh</spa=
n><br><span>+++ b/tests/update_t_client_ips=2Esh</span><br><span>@@ -2,9 +2=
,6 @@</span><br><span> #</span><br><span> # This --up script caches the IPs=
 handed out by the test VPN server to a file</span><br><span> # for later u=
se=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-RC=3D&quot;$TOP_BUILDDIR/t_client_ips=
=2Erc&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt; /dev/null 2&gt;&amp;1</s=
pan><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;EXPECT=
_IFCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt; $RC</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1756?usp=3Demail">change 1756</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1756?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f=
6aa33a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1756 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--k2D5wfnhZC4=--


--===============1011103235843905327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1011103235843905327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1011103235843905327==--

