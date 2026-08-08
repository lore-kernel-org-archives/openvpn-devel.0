Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BA95C55174
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 09:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gCKn4yI0jmKJFRJGW+3mb/cBbuhFrAGPqFwxEyj6A9w=; b=bE+7iYOvs9Lm6FGDbPdFwHZJvg
	ZiAXfgm4vCAs2YIXIlLN5toc9Pg7rqBeWBHQNMS01LkdUQPPE6OmqvUdOrkgQShujpmxyLlPs6VmI
	1mQaU8sx3/OH05NzyiIX4jczhcNfJSQClbyLqgShGNICzGISPLx+ooRblUGWrlZeA3Cc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsdiS-0001pS-3A;
	Sat, 08 Aug 2026 09:51:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsdiQ-0001pB-3G
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 09:51:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DrpO+OMiGItOs9wnyk1TWwuEbUf2CAQWVmIplatuh4Y=; b=WkbDrMZ9PGZObsOlPrk3MbB7Dq
 SPHbb3jlEM+I6C/kakmSst6yL8fKoTZK7SmVJT69G4nVqqguyrGQ6L58flTU7lsaBcwsnhZx1Ni3c
 eeWgcf6MF1LwJFcljXePCnOYlsRUwVx5JqDNfFXKutAJjj6FUKmJ3AJTPFa7EEjWJ/Hk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DrpO+OMiGItOs9wnyk1TWwuEbUf2CAQWVmIplatuh4Y=; b=m
 nKyOXUpoSLO6xdycf29BLfOrZXQAcFo1ZEX3qBGnNuAczAu7Er7pUyVv+80E/xmERRlN6iO4SMmpY
 YujtEuAKT1ilkqPSnS0bcwHDI1UR84+dG5UrD4sgYpKnLDD/sDR7+LedNjz9Z85dNLlDtyL8o+2lg
 I3tzk7H9StTUrXFg=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsdiS-0007HH-W3 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 09:51:42 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4954dff6536so2761215e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786182695; x=1786787495; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DrpO+OMiGItOs9wnyk1TWwuEbUf2CAQWVmIplatuh4Y=;
 b=RC6ibZ/dTFbQcOpWdqsg0/VlIGmTd6xXjkYDshVUn/CoKKyHatKoNZhLOhYxAky8cx
 1EYaI/PSvxynaeHedjI3rBGL1GybSYmdmvr2EW6WetGczqCwwZBi43+bBrYCWqjtMy2c
 mEGYzUGw06lNBX0w3ejAEUJKe6a0IeYCZYBkQiCk9eK45WknykvuHq0ActygCE+WYbG9
 YjOgBI7jK4myw61dBg3w7KYTL23JFu/vlGoXJjtAGlaTYRfgvOb4O53GS1CowcwrNNzA
 C70YXBbAvPeGcvDCjhpEiG+AINlbBB74HvvEMSRZqREh1T7JvWzaes0VFen7+w/p0/CK
 6osg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786182695; x=1786787495;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DrpO+OMiGItOs9wnyk1TWwuEbUf2CAQWVmIplatuh4Y=;
 b=cXryP+Lowuem5OCs6bR3vuHvp5foCMJ2hpG1LQ4Nugs7DTHOA7bi4VqYkfGhkJOo/h
 z0w3ExaZmKDq6kHRA6Lp2APyRihsyOGn3h5d30qvKzjIBpbBE5Heq+mx3C+pkH6VoL5f
 69pf3ZWgoVl4OrZDf5vKmIaFf21xTEI/Pju+i0le6fYHeCL1YajBugHmzRs65XhLLQfg
 VnTIqrBZgNh8LWoDyVeoQhnxk282Uwyi5TLWk3A781ZBs2ap5YoD7e3T41uImFhG9UCT
 VmgQNySKl+nGfdIfvJU4dORdkeDsqtXyMFXlUmblqG8Ya8wXIAMLnjSWZCfv9R52VdIv
 pCnw==
X-Gm-Message-State: AOJu0YyPdqubw1d5tlLuReFC0MBsZrcAf4lRwpaXm3ol520QgGeY/LE3
 VI9S7TWtUBKVurBibd7SeXCDGannynMkMIkUCgMtavancV/FqTn3DzLO/bh2Y+T/INr8AC0uYLK
 w/KTIr7oC9FrMUC0QyanrcZAe/3RkQ2ZlrkjpqihyW97dTrfWZm0dSfRhIOUGXnSnM4VY
X-Gm-Gg: AR+sD13lS3g0Bv/FfgAw763CJe7zOdEWPX2Pb2Atzq/32JXs8I82yIcFrLV79HtnlnF
 JSw0jg86YXmSwS1pKhWasxca2PX9ojwpzGLsbYIotx5nVe2ytFqp4WwEl4YgJfteijDy24D7G6C
 gbu+G81/XbR2kWllxeWAqVDDC0KDcFdfAvmfUORTs+AODBCoPUXIt841XoN60catNikVFQ0byOY
 kKYZDyplNowNT7T2E7xw056A6Fkf/qJw+cm+pbAedMi/2Xwe55MFENBPTDF0WJRzIMEt6uIo4SX
 elDyZVBA/YbKvcWtOmWaw1ZyPc78jaFS8t/Ms/+HXCPV4YD63UlK+NRfl1HsHyQdinc8a+yf6Jb
 Kqe7d1N+2yCab5C672YPuttohJgOnQBNSbpvRTSEdfNp/7L2UQ7MP797gWyCHXXU80jrflEVczA
 L4fHz1nOfKedynB+8vTEPzi4kpwWBZSEdPr+XVQOjnwAlMHio3TIb56yxg7rwIss8+XrHmVxzGs
 EiBFrA4Ldi6SE4spWr9FCxuVj5IjAqjRuycevA9CI61d2b43o/Lcz5fJXTFmvsI6JZdznlmp+Dk
 6X3PNXyxk70w+wPwOdoMTPw7mWjpklbFN5yBTBY4f4pXQlVaToY=
X-Received: by 2002:a05:600c:3ba6:b0:495:779a:ed33 with SMTP id
 5b1f17b1804b1-49959e0c481mr182212855e9.7.1786182694777; 
 Sat, 08 Aug 2026 02:51:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021fd392sm13174369f8f.31.2026.08.08.02.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 02:51:34 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 09:51:32 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f
X-Gerrit-Change-Number: 1791
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1791?usp=email>
X-Gerrit-Commit: 944166798f7696d8db2412be59a29f3e3f19270c
In-Reply-To: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
References: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MjkwNTczMDAwLkliNjk1NmMzYThiMzMyODY2YTU5YjQxYzE4NmNjZTRlMGJjNWYwNzhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9a14a5d6225c03f9ec2961d2ff68fd389ab4d65a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsdiS-0007HH-W3
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: t_client.rc-sample:
 Add missing documentation for FPING_ARGS_x
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3966164501870535287=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3966164501870535287==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HXBANzJNVl8="; charset=UTF-8

--HXBANzJNVl8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by plaisthos


Change subject: t_client=2Erc-sample: Add missing documentat=
ion for FPING_ARGS_x
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

t_client=2Erc-sample: Add missing documentation for FPING_ARGS_x

A=
lso include some smaller misc documentation fixes=2E

Change-Id: Ib6956c3a8=
b332866a59b41c186cce4e0bc5f078f
Signed-off-by: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791
Message-Id: <202608071=
31327=2E52748-1-frank@lichtenheld=2Ecom>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg38207=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Erc-sample
1 f=
ile changed, 7 insertions(+), 2 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/91/1791/3

diff --git a/tests/t_clie=
nt=2Erc-sample b/tests/t_client=2Erc-sample
index d61ecc4=2E=2Ea35d185 1006=
44
--- a/tests/t_client=2Erc-sample
+++ b/tests/t_client=2Erc-sample
@@ -8,=
9 +8,13 @@
 # define these - if empty, no tests will run
 #
 top_srcdir=3D"=
${top_srcdir:-=2E=2E}"
+
+# PKI args
 CA_CERT=3D"${top_srcdir}/sample/sampl=
e-keys/ca=2Ecrt"
 CLIENT_KEY=3D"${top_srcdir}/sample/sample-keys/client=2Ek=
ey"
 CLIENT_CERT=3D"${top_srcdir}/sample/sample-keys/client=2Ecrt"
+
+# Cus=
tomize ping tests
 #FPING_EXTRA_ARGS=3D"-t 1000"
 
 # Load EXPECT_IFCONFIG*=
 parameters from cache
@@ -48,8 +52,8 @@
 
 #
 #
-# now define the individu=
al tests - all variables suffixed with _1, _2 etc
-# will be used in test r=
un "1", "2", etc=2E
+# now define the individual tests - all variables suff=
ixed with _1, _2, _2n etc
+# will be used in test run "1", "2", "2n" etc=2E=

 #
 # if something is not defined here, the corresponding test is not run
=
 #
@@ -64,6 +68,7 @@
 #
 # hook test options:
 #
+# FPING_ARGS_x      =3D "=
arguments to append to the fping command line"
 # CHECK_SKIP_x      =3D "co=
mmands to execute before openvpn, skip test on failure"
 # PREPARE_x       =
  =3D "commands to execute before openvpn"
 # POSTINIT_CMD_x    =3D "comman=
ds to execute after openvpn but before ping"

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f
Gerri=
t-Change-Number: 1791
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@=
lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--HXBANzJNVl8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">t_client=2Erc-sample: =
Add missing documentation for FPING_ARGS_x<br><br>Also include some smaller=
 misc documentation fixes=2E<br><br>Change-Id: Ib6956c3a8b332866a59b41c186c=
ce4e0bc5f078f<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791<br>Message-Id: &lt;=
20260807131327=2E52748-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38207=2Ehtml<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
tests/t_client=2Erc-sample<br>1 file changed, 7 insertions(+), 2 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/91/1791/3</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Erc-samp=
le b/tests/t_client=2Erc-sample</span><br><span>index d61ecc4=2E=2Ea35d185 =
100644</span><br><span>--- a/tests/t_client=2Erc-sample</span><br><span>+++=
 b/tests/t_client=2Erc-sample</span><br><span>@@ -8,9 +8,13 @@</span><br><s=
pan> # define these - if empty, no tests will run</span><br><span> #</span>=
<br><span> top_srcdir=3D&quot;${top_srcdir:-=2E=2E}&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# PKI args</span><br><span> CA_CERT=3D&quot;${top_srcdir=
}/sample/sample-keys/ca=2Ecrt&quot;</span><br><span> CLIENT_KEY=3D&quot;${t=
op_srcdir}/sample/sample-keys/client=2Ekey&quot;</span><br><span> CLIENT_CE=
RT=3D&quot;${top_srcdir}/sample/sample-keys/client=2Ecrt&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# Customize ping tests</span><br><span> #FPING_EXTR=
A_ARGS=3D&quot;-t 1000&quot;</span><br><span> </span><br><span> # Load EXPE=
CT_IFCONFIG* parameters from cache</span><br><span>@@ -48,8 +52,8 @@</span>=
<br><span> </span><br><span> #</span><br><span> #</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# now define the individual tests - all variabl=
es suffixed with _1, _2 etc</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# will be used in test run &quot;1&quot;, &quot;2&quot;, etc=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# now define the individu=
al tests - all variables suffixed with _1, _2, _2n etc</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+# will be used in test run &quot;1&quot;=
, &quot;2&quot;, &quot;2n&quot; etc=2E</span><br><span> #</span><br><span> =
# if something is not defined here, the corresponding test is not run</span=
><br><span> #</span><br><span>@@ -64,6 +68,7 @@</span><br><span> #</span><b=
r><span> # hook test options:</span><br><span> #</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# FPING_ARGS_x      =3D &quot;arguments to app=
end to the fping command line&quot;</span><br><span> # CHECK_SKIP_x      =
=3D &quot;commands to execute before openvpn, skip test on failure&quot;</s=
pan><br><span> # PREPARE_x         =3D &quot;commands to execute before ope=
nvpn&quot;</span><br><span> # POSTINIT_CMD_x    =3D &quot;commands to execu=
te after openvpn but before ping&quot;</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1791?us=
p=3Demail">change 1791</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1791?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1791 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-O=
wner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--HXBANzJNVl8=--


--===============3966164501870535287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3966164501870535287==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3966164501870535287==--

