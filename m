Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E51F8C61DB4
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ldDteqx/MK9PpIROV2TlrXU9HGNxmGt4eA5aDoeGiro=; b=ceR/pwG5kduYClavRVE9k93pNb
	KdAJs/ZmB1z9HX7CrKUs8swP596mU+g2RYOtNYF5/19PAttakvjR2YET0XXfd6B7hTcbypZPZdN7m
	yQ2jwJdb+cA9h6QFbEfZqlNl0W1TGawp1uhrwxC0Ei/+38cJGwbfDGTuoDwT5h49D62I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWGg-0002Bw-7s;
	Mon, 24 Aug 2026 15:07:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWGN-0002BI-BN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=30nkLYJd7E8Q3ALd438Zg2a+2vXinepIUw2Vd0HPBQo=; b=TzQLmVCQNP0WR67lP0VetTf3yN
 YlSnidrh8H0Ll+QDKf4ku57L8hGGp+X/nUNXLmX8Xk+nEuk01im7zsjDP3G7bSTzzUyRbERv6ccDB
 fdXeqXyWM79K5ep7WQ9llFvZ0/lExz0V8X7UQeJlXr51rIJL6nNUzpsQbL1ZBDiNdkaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=30nkLYJd7E8Q3ALd438Zg2a+2vXinepIUw2Vd0HPBQo=; b=Y
 t/SBrt5TBTH5XDfimhyRgCApm0ye5uUQsApCtV4N5E3D51/owRfUkna1fTaJO66N0jSae7kNCC8O9
 3dvah/Cu4WsuPAilW1aoa8JGiVEPrasb1Q7w7QVr1/2fXlLD+9Heq2AYlqDy5yyt9ggAjisRaR9vG
 tNhht0tCT4erydb0=;
Received: from mail-ed1-f48.google.com ([209.85.208.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWGE-0004DU-97 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:06:56 +0000
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-6a422090b14so4870736a12.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787584008; x=1788188808; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=30nkLYJd7E8Q3ALd438Zg2a+2vXinepIUw2Vd0HPBQo=;
 b=QcmS21BUWfNwyOtJSTCKH3SbPJfyJXP9fcMLpJ+g54DxJ3UyxNS0BKkz/jGsPhb0YC
 CnAANEbrLEF4iPsOuMLrKq2ilE8DDK1aRsMJb3YTkEWsojRe/n+nQ/vzTdNmaQ8qZY+V
 AExhqBuRXs98ZcADN6XwVSLJQ9xNOoeCLIdQwNPnuHCl3GPFxkpN9PgEn+cQnSQpPmpq
 2hR4BJoijVUyTpy/MJJpArFAvk31jeBB08EOV6XqV7UQR5dixQU0u3kKi8D/5FTfzVF0
 vdKVT/67BaurByzf0MwztRFIsnoEgNkZJZiOYeVLTjcCm5wsrgi/9Mw99n3HLMzJXleM
 xi+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584008; x=1788188808;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=30nkLYJd7E8Q3ALd438Zg2a+2vXinepIUw2Vd0HPBQo=;
 b=IBBjO2OB0OzPTvZvfzhHGfA0PF/mtOoxZegT23rnbCT6WHUL/EAhMD1jGRRzdvdwBT
 8rR3QGqBIJFEX14jHTWZdQj5GdWT2LX+q+xMokeJrjQdsRRvYOUAHwgnBcVTol5iREet
 XA7TpYNJ+LF2Qq7KkI1ZDB+rWh95Ya/SReg9v0TwrkUEXp6Zg57B/n8mdgWKCwG1F1Zi
 zlAZU/2SP81AuyI6UBmy6OUmdv3ptTsgHaIGEp6sIgWX0C5Y1G3fO17JFAZ5OWWii2g6
 oobPOfQPJGu8GEOtJiV5xis7EUghIPShqSHjDmeedk+S+esUdCvWTVhygHGF/RETQYKQ
 ktsA==
X-Gm-Message-State: AFuF++ks2z43lGJxTQm/pWXo7sA7zC7cBBlS1p9YlKzLheT4CggSi5QZ
 5/MuCEpv1m/Ds7cpEekBseIU2JXtbNb26tO+0PfmNxIcjlfb/h7tw6lh7hzyjiAoFX65jQct1K1
 pZ9n8CnUDg9oIEhBEYF3sXv2VbBf0yaUw3wyGlpE/bsUcyCZ3/Fauj8SPlSf433Zxvw1UwY+qur
 QcVrglew==
X-Gm-Gg: AR+sD118zXaU428eBmnA908gW0UGPvohnv/G2dkCJw0zmd6QGe9qj4GSEXtJm1ugLgX
 YLHAA1r1Vf2DUQ2+CYgWJMFuJSI1q9KuaX1J/pT96+wi5AzU3A2RiELvNeEap31ajV8aUcGVRLM
 MMghm6BvSE7xv7eAMP9IBFxid0y61aTgJ7OtPtvqUIwX8Le4SqgowVYyvOsI3jcnBEeWi29O4bw
 QNTlGpMO7Jv9mKMYTl7egpqaCc8XooN7jzOQsMQCwC6gkw5xKmZBmgCXxAs1+PXpmll5a3nWOkX
 MDAPs3QGBKlFDnzBcr9RHjx+/KhLt1Y1gUAIih0yvMBgsPs7PsQzo7UMqWbXZhpa94W1DEhbNsi
 3sLE+uJlHcHpwjDyxwseKSlNGUzBMSy2zptYCIgn02Ar1heoJ7NN+eVc8zBEza5cZAu/zxGqoi0
 PBBB6MnmkXEb6SpEN5XG7Rcqceo2ytYoD/B0/1pkv7F3S/ulu8/5WR8iUlIvszaAPYnAk/bj9Ya
 KUt7hvzjFUMwvGwGj68TbVosLEEnK/ThnpaUeiw+VZquvzIen4VXIwaCFGUxuIfIpryLb+ig7L6
 lqeFzFXmMZEgOJSWBH+fqJzbqJJivDoVXqcAg3tErULil/btVsj9p7wAHZrt8hM=
X-Received: by 2002:a05:6402:548b:b0:697:f6b2:a94e with SMTP id
 4fb4d7f45d1cf-6a582b9b9d0mr21209464a12.13.1787584007419; 
 Mon, 24 Aug 2026 08:06:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2e2826sm9086890a12.31.2026.08.24.08.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:06:46 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:06:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
X-Gerrit-Change-Number: 1756
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1756?usp=email>
X-Gerrit-Commit: d11705d04e99bdfd2027108761d6cb0c4974f081
In-Reply-To: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLklhNGE5YTZiYWZiNmJjYjNmZTMzMWE5MmNmYmI2NGJlNzhmNmFhMzNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a0b7a764457bd269e7cb9f59e93c9ade262f2066-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWGE-0004DU-97
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4516863956896835611=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4516863956896835611==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Bgyxqkdyens="; charset=UTF-8

--Bgyxqkdyens=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, razvanc=2E

=
Hello plaisthos, razvanc, 

I'd like you to reexamine a change=2E Please vi=
sit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail

to loo=
k at the new patch set (#4)=2E

The following approvals got outdated and we=
re removed:
Code-Review+2 by razvanc

The change is no longer submittable: =
Code-Review and checks~ChecksSubmitRule are unsatisfied now=2E


Change sub=
ject: t_client=2Esh=2Ein: Allow to override the location of t_client_ips=2E=
rc
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=
=2Esh=2Ein: Allow to override the location of t_client_ips=2Erc

Makes it e=
asier to use t_client=2Esh in other contexts=2E

This is based on work by G=
ert Doering for the t_server
test infrastructure=2E

Change-Id: Ia4a9a6bafb=
6bcb3fe331a92cfbb64be78f6aa33a
Signed-off-by: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
---
M tests/t_client=2Erc-sample
M tests/t_client=2Esh=2Ein
=
M tests/update_t_client_ips=2Esh
3 files changed, 12 insertions(+), 5 delet=
ions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/56/1756/4

diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-=
sample
index 04714ef=2E=2E4c87436 100644
--- a/tests/t_client=2Erc-sample
+=
++ b/tests/t_client=2Erc-sample
@@ -18,8 +18,8 @@
 #FPING_EXTRA_ARGS=3D"-t =
1000"
 
 # Load EXPECT_IFCONFIG* parameters from cache
-if [ -r "${top_buil=
ddir}/t_client_ips=2Erc" ]; then
-    =2E "${top_builddir}/t_client_ips=2Er=
c"
+if [ -r "${t_client_ips_rc}" ]; then
+    =2E "${t_client_ips_rc}"
 els=
e
     echo "NOTICE: missing t_client_ips=2Erc will be auto-generated"
 fi
=
@@ -67,6 +67,12 @@
 # PING6_HOSTS_x      =3D "these hosts musts ping when o=
penvpn is up (IPv6 fping6)"
 # EXPECT_FAIL_x      =3D "instead of waiting f=
or connection wait for this error message"
 #
+# Note that the EXPECT_IFCON=
FIG{4,6} options are not generally required, the
+# tests will remember the=
 ip address they got on the first run in t_client_ips=2Erc
+# and will expe=
ct to get the same address again=2E But it can be useful to hard-code
+# th=
e IP when the server is expected to send a very specific address, e=2Eg=2E =
when
+# using ccd on the server-side or in a P2P scenario=2E
+#
 # hook tes=
t options:
 #
 # FPING_ARGS_x      =3D "arguments to append to the fping co=
mmand line"
diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ei=
n
index caba242=2E=2E0ce8e02 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/te=
sts/t_client=2Esh=2Ein
@@ -19,6 +19,9 @@
 srcdir=3D"${srcdir:-=2E}"
 top_bu=
ilddir=3D"${top_builddir:-=2E=2E}"
 openvpn=3D"${openvpn:-${top_builddir}/s=
rc/openvpn/openvpn}"
+t_client_ips_rc=3D"${t_client_ips_rc:-${top_builddir}=
/t_client_ips=2Erc}"
+update_t_client_ips=3D"${update_t_client_ips:-${srcdi=
r}/update_t_client_ips=2Esh}"
+
 if [ -r "${top_builddir}"/t_client=2Erc ];=
 then
     =2E "${top_builddir}"/t_client=2Erc
 elif [ -r "${srcdir}"/t_cli=
ent=2Erc ]; then
@@ -327,7 +330,7 @@
     # If EXCEPT_IFCONFIG* variables f=
or this test are missing, run an --up
     # script to generate them dynami=
cally=2E
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; =
then
-        up=3D"--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_build=
dir} --script-security 2 --up ${srcdir}/update_t_client_ips=2Esh"
+        =
up=3D"--setenv TESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-securit=
y 2 --up ${update_t_client_ips}"
     else
         up=3D""
     fi
diff --=
git a/tests/update_t_client_ips=2Esh b/tests/update_t_client_ips=2Esh
index=
 777a286=2E=2Ef02dc7f 100755
--- a/tests/update_t_client_ips=2Esh
+++ b/tes=
ts/update_t_client_ips=2Esh
@@ -3,8 +3,6 @@
 # This --up script caches the =
IPs handed out by the test VPN server to a file
 # for later use=2E
 
-RC=
=3D"$TOP_BUILDDIR/t_client_ips=2Erc"
-
 grep EXPECT_IFCONFIG4_$TESTNUM=3D $=
RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then
     echo "EXPECT_IFCONFIG4_$TEST=
NUM=3D$ifconfig_local" >>$RC

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1756?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
Gerrit-Change-Number:=
 1756
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Att=
ention: razvanc <razvanc@mailbox=2Eorg>

--Bgyxqkdyens=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, razvanc=2E </p>
<p>flichtenh=
eld <strong>uploaded patch set #4</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1756?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by razvanc</p><p>The change is no longer submittable: Code-Review and =
checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">t_client=2E=
sh=2Ein: Allow to override the location of t_client_ips=2Erc<br><br>Makes i=
t easier to use t_client=2Esh in other contexts=2E<br><br>This is based on =
work by Gert Doering for the t_server<br>test infrastructure=2E<br><br>Chan=
ge-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Erc-s=
ample<br>M tests/t_client=2Esh=2Ein<br>M tests/update_t_client_ips=2Esh<br>=
3 files changed, 12 insertions(+), 5 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/175=
6/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-s=
ample</span><br><span>index 04714ef=2E=2E4c87436 100644</span><br><span>---=
 a/tests/t_client=2Erc-sample</span><br><span>+++ b/tests/t_client=2Erc-sam=
ple</span><br><span>@@ -18,8 +18,8 @@</span><br><span> #FPING_EXTRA_ARGS=3D=
&quot;-t 1000&quot;</span><br><span> </span><br><span> # Load EXPECT_IFCONF=
IG* parameters from cache</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-if [ -r &quot;${top_builddir}/t_client_ips=2Erc&quot; ]; then</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    =2E &quot;${top_builddir}/t=
_client_ips=2Erc&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+if [ -r &quot;${t_client_ips_rc}&quot; ]; then</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    =2E &quot;${t_client_ips_rc}&quot;</span>=
<br><span> else</span><br><span>     echo &quot;NOTICE: missing t_client_ip=
s=2Erc will be auto-generated&quot;</span><br><span> fi</span><br><span>@@ =
-67,6 +67,12 @@</span><br><span> # PING6_HOSTS_x      =3D &quot;these hosts=
 musts ping when openvpn is up (IPv6 fping6)&quot;</span><br><span> # EXPEC=
T_FAIL_x      =3D &quot;instead of waiting for connection wait for this err=
or message&quot;</span><br><span> #</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Note that the EXPECT_IFCONFIG{4,6} options are not genera=
lly required, the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
tests will remember the ip address they got on the first run in t_client_ip=
s=2Erc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# and will ex=
pect to get the same address again=2E But it can be useful to hard-code</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# the IP when the serve=
r is expected to send a very specific address, e=2Eg=2E when</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# using ccd on the server-side or =
in a P2P scenario=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#</span><br><span> # hook test options:</span><br><span> #</span><br><span=
> # FPING_ARGS_x      =3D &quot;arguments to append to the fping command li=
ne&quot;</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_cl=
ient=2Esh=2Ein</span><br><span>index caba242=2E=2E0ce8e02 100755</span><br>=
<span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=
=2Esh=2Ein</span><br><span>@@ -19,6 +19,9 @@</span><br><span> srcdir=3D&quo=
t;${srcdir:-=2E}&quot;</span><br><span> top_builddir=3D&quot;${top_builddir=
:-=2E=2E}&quot;</span><br><span> openvpn=3D&quot;${openvpn:-${top_builddir}=
/src/openvpn/openvpn}&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+t_client_ips_rc=3D&quot;${t_client_ips_rc:-${top_builddir}/t_client=
_ips=2Erc}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+upd=
ate_t_client_ips=3D&quot;${update_t_client_ips:-${srcdir}/update_t_client_i=
ps=2Esh}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> if [ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</spa=
n><br><span>     =2E &quot;${top_builddir}&quot;/t_client=2Erc</span><br><s=
pan> elif [ -r &quot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><span>=
@@ -327,7 +330,7 @@</span><br><span>     # If EXCEPT_IFCONFIG* variables fo=
r this test are missing, run an --up</span><br><span>     # script to gener=
ate them dynamically=2E</span><br><span>     if [ -z &quot;$expect_ifconfig=
4&quot; ] || [ -z &quot;$expect_ifconfig6&quot; ]; then</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        up=3D&quot;--setenv TESTNUM $SUF =
--setenv TOP_BUILDDIR ${top_builddir} --script-security 2 --up ${srcdir}/up=
date_t_client_ips=2Esh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        up=3D&quot;--setenv TESTNUM $SUF --setenv RC ${t_client_ip=
s_rc} --script-security 2 --up ${update_t_client_ips}&quot;</span><br><span=
>     else</span><br><span>         up=3D&quot;&quot;</span><br><span>     =
fi</span><br><span>diff --git a/tests/update_t_client_ips=2Esh b/tests/upda=
te_t_client_ips=2Esh</span><br><span>index 777a286=2E=2Ef02dc7f 100755</spa=
n><br><span>--- a/tests/update_t_client_ips=2Esh</span><br><span>+++ b/test=
s/update_t_client_ips=2Esh</span><br><span>@@ -3,8 +3,6 @@</span><br><span>=
 # This --up script caches the IPs handed out by the test VPN server to a f=
ile</span><br><span> # for later use=2E</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-RC=3D&quot;$TOP_BUILDDIR/t_client_ips=
=2Erc&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> grep EXPECT_IFCONFIG4_$TESTNUM=3D $RC &gt;/dev/null 2&gt;&amp;1</sp=
an><br><span> if [ $? -ne 0 ]; then</span><br><span>     echo &quot;EXPECT_=
IFCONFIG4_$TESTNUM=3D$ifconfig_local&quot; &gt;&gt;$RC</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1756?usp=3Demail">change 1756</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1756?usp=3Demail"/><meta itemprop=3D"name" content=
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
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></=
html>
--Bgyxqkdyens=--


--===============4516863956896835611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4516863956896835611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4516863956896835611==--

