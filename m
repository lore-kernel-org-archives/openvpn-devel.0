Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE26CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVGkPAalSs+Ay4oryeFng59yDmXsV0w8KzUOscUZVHc=; b=QocPknKOj9j7pnRbIDLT7uCz7w
	awC1/UzA61tcj+GJvKNZv+BiJPzKlHIqgjMlsWfvb0GkOiv34uWTNVjjrezPQZMUrlsPIT1yPfkRY
	pX/c36H0/UkoYlz7CX6lZPuypXwVbX7sMSCKmU2eWjxbn1itIDRuS3nyC3UHm2jI+xvw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIT02-00044u-RX;
	Sun, 18 Oct 2026 15:40:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIT01-00044c-Af
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=f5io8PMDo6ctRBMvsqbFSD9v6UD1k7Cot2tjoR14LAE=; b=PRFV46GOkSDBgOMujQGq/pTlH9
 lZYJHZPQUM1qSteHxt9IbPh0TBywK1oFFrPBrE6eou6AnpDgtIKKMl8LM/a0xsk48NM1sRaULVLd/
 Su8vUiUC/xYR/LpLNhoTMe1JukWJ4gWBPaRIuVKZ8e++odBOWbGq+rQIFhQya6U2UYgM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=f5io8PMDo6ctRBMvsqbFSD9v6UD1k7Cot2tjoR14LAE=; b=M
 PTeWnMedHajnFHyDp1kzcRd8mmajR2v7AZ6PBs2Ow3Zy+gL133OMWvlaXm4kFEFDjXGkOEMbdbwOA
 fIRUiCfxu5KMaVqAoPq3W33gfN0rDVlaOj0aKDdIoNkQuRmvShgaF2tbdEDbN40hepehsd1llsnU9
 REsRtIADE4n5VBI0=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIT00-0001ez-Ia for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:40:37 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a1d293b293so7338385e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792338030; x=1792942830; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f5io8PMDo6ctRBMvsqbFSD9v6UD1k7Cot2tjoR14LAE=;
 b=bj1Rzi/bxmXfdhmRZgQeH+y+HcstJQpHqkBUIfuGuYohEnjady4FXGbZ/82UCs3Qsi
 XRz49cd0MKF6i9/MAUqO6w9IR3weFDZkeMFhyvB+tU8Ljz63m97gZmoDXgmTR7hFH5jg
 d8lPdlIgY2gw95Bpf+/pssA+6pWatBPOejUhn+P5BQaat6qCUT9XMBPpLRsLzdOOndIE
 oxv6E5I3QgX1c3pSEAxaHr/Q3qZHtHpWoqAuyjfj88HRliVrf7c+BZ1YfvSs1cFs8dEt
 Lb/8dd7UbypZzLIFDjTfZQZ8wgYjsXlC4t73QHW/as1doNeATW7cjvqM2NjRD41quyTT
 27UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792338030; x=1792942830;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f5io8PMDo6ctRBMvsqbFSD9v6UD1k7Cot2tjoR14LAE=;
 b=IA0ZgDADHWx9mt+6g/Pibt1dzw9ChoD4Htf23CTiUdxaeXxgra7WGiBTzEEuu2zc7g
 HSJU3dWDTojky7uWyZYvLeIwwdKVzqGMMJXOZiLvmwRsu8TfuOZgWetFySWcLpQEw6+4
 tX8XPZZHxQfW7d/RnFI4XOtclRMVY6Xi1f9Q3Soz8JR8ZbdK4Nb5Oj2/eASHCUBgMJqZ
 ThPzKo+2SuqgBjP9A2vlCSLSg1lN2p/6JQlixImb05G7a9g5mSJfkMMg0Y3ioO4KDE2K
 d5B1yoB6jqGX25Fr7JG7z2WoynurKJtytATG4B0sUypHMzIQwmB8fYQwtPbPDV8/zexR
 0isA==
X-Gm-Message-State: AFq9FYLwTc940LBMqa4siIl42gqSW+fkw7g36N4F+C9VHeioJ25AMs9i
 E7bbC+jv31Lhnp3j2nyqjLO/juAj8fm5aNzvfwqnR5TqvchLyTtrXGWythN+Z3sUWlhkxkn7A1L
 QpZLIQxyWbcUupDMAYSN6F00kq1Dc1Y2NKEdEw0oxGESKSWM3pZgKO9COV16mBDEnqBY9
X-Gm-Gg: AYBFou3C916t+mQAYs41NMJAa09dZXsDChnjHlq9yXaweJN55X/bR3w01Gkn6/srdss
 iJOmh4hsjTRc1bqaagHNQrG2VZbhU6VS33aeLyIknKc/JnxeRVQQ8V/+BKnmyO2wgs9fB9nmdWh
 dHaHWuNdoi2rzi4YPf7hILpqdoWMW6dOYC/DCPTIXYJMhy68ad8e7FssdOMJ0jp7Q2fsily9eJ8
 RL1b7c1357j3nI7JpACChOvptIM+NZNC3/PUmAmTBI1y511wXlFOPNlqOYggXYt+V/MXXWHGWyI
 h9CYU+HBawXhPwqOiOEbkqJp1caO7yKc2XQAfH3HnoFwBdnOzMh6xl7EeN8X15f9i6tgtQhRmoA
 2h1YcmXwCzmLLtlAw8LlYJ1Mw+vSKQnMVcdK/+mYQdHzzec3LawoBPO9577LpVJZMkAaagTZFds
 SQtNHV/erwrxUNshWbKXqWmhWJhZ2Fc4//Gxk5QFQOtU07NhO0e2Xk9uLFsgN/FwX5i1pwidU4Y
 Id2P5Tc7Kuc7vXKlAW2XMHR9gXDF34P+MAa8kzCW4SA0IV02npOv8AuNN2E+4cthe53Z5xBDLNP
 lMDPs/M+nOlqw4Liui2Imki2VQ88zT1ygBYhvcDwN6AxH4l6JgWpNz7wxUCD
X-Received: by 2002:a05:600c:3554:b0:4a0:2488:71cc with SMTP id
 5b1f17b1804b1-4a1d76234a3mr113040725e9.32.1792338029822; 
 Sun, 18 Oct 2026 08:40:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1e701f272sm6166195e9.1.2026.10.18.08.40.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:40:29 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 15:40:28 +0000
To: Marco Baffo <marco@mandelbit.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae
X-Gerrit-Change-Number: 1992
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1992?usp=email>
X-Gerrit-Commit: 103d80345b1cebc8311ad0f8379359221a4a4642
In-Reply-To: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
References: <gerrit.1791892996000.Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxODkyOTk2MDAwLkllNGE3ZTA3MDJhMzBkMmE2MzdjM2RmZTAzZjZjNjJkOGE5OTAxYWFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aeca5f64f519950fefa069864858d2e8d61d37bd-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIT00-0001ez-Ia
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: PUSH_UPDATE server:
 free temporary options after sending message
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6671266993542538239=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6671266993542538239==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AgTEdpJqcZw="; charset=UTF-8

--AgTEdpJqcZw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Marco Baffo=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?us=
p=3Demail )

The following approvals got outdated and were removed:
Code-Re=
view+2 by R=C4=83zvan Cojocaru


Change subject: PUSH_UPDATE server: free t=
emporary options after sending message
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

PUSH_UPDATE server: free temporary options after =
sending message

Clean up options on success and send failure to avoid leak=
ing
memory allocated while parsing outgoing updates=2E

Change-Id: Ie4a7e07=
02a30d2a637c3dfe03f6c62d8a9901aae
Signed-off-by: Marco Baffo <marco@mandelb=
it=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992
Message-Id: <20261013121338=2E=
27882-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg39864=2Ehtml
Signed-off-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/push_util=2Ec
M tests/unit=
_tests/openvpn/mock_push_dependencies=2Ec
2 files changed, 9 insertions(+),=
 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/92/1992/3

diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/p=
ush_util=2Ec
index 7fa5987=2E=2E34cb26c 100644
--- a/src/openvpn/push_util=
=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -163,6 +163,7 @@
     {
         if=
 (!send_control_channel_string(c, BSTR(&e->buf), D_PUSH))
         {
+     =
       uninit_options(&o);
             return false;
         }
 
@@ -217,=
6 +218,7 @@
         update_vhash(m, mi, o=2Eifconfig_local, o=2Eifconfig_i=
pv6_local);
     }
 
+    uninit_options(&o);
     return true;
 }
 
diff -=
-git a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec b/tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec
index 112bcfd=2E=2Ebf2ccf3 100644
---=
 a/tests/unit_tests/openvpn/mock_push_dependencies=2Ec
+++ b/tests/unit_tes=
ts/openvpn/mock_push_dependencies=2Ec
@@ -62,6 +62,13 @@
 {
 }
 
+void
+uni=
nit_options(struct options *options)
+{
+    gc_free(&options->gc);
+    gc=
_free(&options->dns_options=2Egc);
+}
+
 bool
 options_postprocess_pull(str=
uct options *options, struct env_set *es)
 {

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Ie4a7e0702a30d2a637c3dfe03f6c62d8a9901aae
Ge=
rrit-Change-Number: 1992
Gerrit-PatchSet: 3
Gerrit-Owner: Marco Baffo <marc=
o@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--AgTEdpJqcZw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Marc=
o Baffo=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">PUSH=
_UPDATE server: free temporary options after sending message<br><br>Clean u=
p options on success and send failure to avoid leaking<br>memory allocated =
while parsing outgoing updates=2E<br><br>Change-Id: Ie4a7e0702a30d2a637c3df=
e03f6c62d8a9901aae<br>Signed-off-by: Marco Baffo &lt;marco@mandelbit=2Ecom&=
gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992<br>Message-Id: &lt;20261=
013121338=2E27882-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39864=2Ehtml<br>Si=
gned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/o=
penvpn/push_util=2Ec<br>M tests/unit_tests/openvpn/mock_push_dependencies=
=2Ec<br>2 files changed, 9 insertions(+), 0 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/9=
2/1992/3</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_=
util=2Ec</span><br><span>index 7fa5987=2E=2E34cb26c 100644</span><br><span>=
--- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=
=2Ec</span><br><span>@@ -163,6 +163,7 @@</span><br><span>     {</span><br><=
span>         if (!send_control_channel_string(c, BSTR(&amp;e-&gt;buf), D_P=
USH))</span><br><span>         {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            uninit_options(&amp;o);</span><br><span>          =
   return false;</span><br><span>         }</span><br><span> </span><br><sp=
an>@@ -217,6 +218,7 @@</span><br><span>         update_vhash(m, mi, o=2Eifc=
onfig_local, o=2Eifconfig_ipv6_local);</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uninit_opti=
ons(&amp;o);</span><br><span>     return true;</span><br><span> }</span><br=
><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/mock_push_de=
pendencies=2Ec b/tests/unit_tests/openvpn/mock_push_dependencies=2Ec</span>=
<br><span>index 112bcfd=2E=2Ebf2ccf3 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>+++ b/tests/unit=
_tests/openvpn/mock_push_dependencies=2Ec</span><br><span>@@ -62,6 +62,13 @=
@</span><br><span> {</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+uninit_options(struct options *options)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;options-&gt;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;options-&gt;dns_opt=
ions=2Egc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</sp=
an><br><span> options_postprocess_pull(struct options *options, struct env_=
set *es)</span><br><span> {</span><br></pre><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail">change 1992</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1992?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie=
4a7e0702a30d2a637c3dfe03f6c62d8a9901aae </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1992 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;m=
arco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--AgTEdpJqcZw=--


--===============6671266993542538239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6671266993542538239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6671266993542538239==--

