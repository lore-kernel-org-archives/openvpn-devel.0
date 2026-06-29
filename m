Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001A5C43327
	for <openvpn-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=rP0oP0oGPNCZwgfWoMNvg5oUlbP4eN67ri/otW4OX9A=; b=MxkeeQnxcrMEm6
	ubH8N8cKz//4OkT5goCvef9dDWkTiQa9hZCIHhtBzx6i6M0YnMoI1ao8QOudStbcmZsfYdlC/jgUI
	DziUd8RM/HtPfwlx13923zyOfJwDvPN4fH4oHSZGLqWSgntp21p4hfHnAIuXcVvE7kx2YTb23VwbZ
	o/o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weCTl-0004zr-Gf;
	Mon, 29 Jun 2026 13:56:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weCTR-0004zX-VB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:56:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TBe3HqoS7AnwR9MWZH+dX/V325oqYbmTZ+h7DVvI0Fk=; b=iLGTcf6Dj/q8XgmQEHGokWy243
 ZuB0d6KQaZaKSyt5kA4cBYzzi4U6u8htDAeQIrVgz7txy4gWBYreQsy8/a/Ey9DiiML4VNKzT2gNV
 Tn8Bg9XIutBf6L+H6qmFvUzF26ZeDw+yrY61K90VLPNaD8G+BIYdNYRJbV/sHJO5FMrk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TBe3HqoS7AnwR9MWZH+dX/V325oqYbmTZ+h7DVvI0Fk=; b=h
 Thwh0X2Ef9k2oGc440KeDA2UGM2mzNlwP2fC+H9t/2x5uJhOY4rA1ZXgVxOGiVyzlMG+HC41z1rQ6
 A1WUugihS4O9nulx7xvYtupSf9kOx+hKQc4pUmfYt+iKnDApqU0YRzgt2Sh/Pp4sS5DxJIEpgMWTn
 911c3Q02Lpl1D8PE=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weCTM-00011d-D4 for openvpn-devel@lists.sourceforge.net;
 Mon, 29 Jun 2026 13:56:30 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-46cbe01d4b6so1961737f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 29 Jun 2026 06:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782741382; x=1783346182; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TBe3HqoS7AnwR9MWZH+dX/V325oqYbmTZ+h7DVvI0Fk=;
 b=M/AHKQaOWIcpLHD9/bMQp4WjHMgckdhSPN9CQEmMZ+216ekoEo8wH42ov3xmfTw4d7
 maCWjbMQHQLJEjHLZvUYFoqwNoR2EgYNOlOhB9XAwOa5IzSGUU7qZlA+SA/NybFHRMpu
 Gv1fuHgg2vKekyGhN23/2g3O2/Upli1rgTPL6yUOa7DpEXqs0uNIYWHbuJpXpA5KL7X7
 p2SSxALqvxbIljNwY9NdDNYF+/TiePkovos2fFuP9OAp182XDUwyMvn1Vzg5IExaN+XY
 0Sz470VVFoeRdkdIc1+AGG+6cGP/o+c0VK3tQ6R9HsM3CyFbsXZJ/q6Ujw2qgiIxYQw5
 qQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782741382; x=1783346182;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TBe3HqoS7AnwR9MWZH+dX/V325oqYbmTZ+h7DVvI0Fk=;
 b=Qks/oBsk4FKXGl/GuFSCu4+4EQhadfDRJsUUNaijY4gWMtSXwdi/nZCE0TiT8CEpGp
 N1RS9V5cKJMdCwcQe2uKdA4qUUJAEO2Kb89D0w4+qvRzCnY08fLJ1biKN2FhXazudwQJ
 jz7Bvj9lRqRpxmZjsw716XUdiBkK3kM7sGcXyvxif44JV1CES7d+vgbU7NjZkmxoLANn
 eQTe3Vf2DbDspg/Ory2GA0vCGD64/l+746O/DfO047615jkVzoV2GpadFHiZqWPl4V2c
 WsXrjbytX0OHko0ymq5ExsNjRsLN/LKTqdmqi6Adss1EFfZmA2+/SHSoobo/1gsSbcDD
 VlKw==
X-Gm-Message-State: AOJu0YwEVFfhzsUyUBubMdr7uHnX+f3RaqqdgAfs1cOAcwpFwuqv0to2
 V1IF1Fnp52adLOSyOFWTcMExwtFSSk7KiJ+dx49QY8vDcQY0SGkwHBmRaT1ImcMHno9z63EYxuA
 qG594SzALhherxp9qddCarWa04zZvbsoHkyUboxSojuNgdwPRsLmnpl8+l0PG+wYqwsjW8+/Fer
 iu9L+ZXA==
X-Gm-Gg: AfdE7ckHvcCedNb40Yjqzl+PhvBndM/krZ4pWynyt765YVC3Ky1a6LiMkSL5a91Tlr3
 KupXWTReSWwiSD1sTjV+byGY1NBqRIK0gPyFZUJOysJf2SH6kZ/7tk6IePs3zQTMEzO/sBv6m6U
 AG6IaEnElMK+0HaygbMzPBQgABjL6nl0v0BlcOQzutja8J0B4J4hB3oeH70SG90GfJR7J+L6c34
 S4p8VZHdBo2J36uPOCc9zvWChMoqFL9WqVdgu5qDnb0hytDv7aCSJkztRIPc170B/Xlhhg/guQT
 V3GzUlEuZuBBktcnIoLVJIOW3WKONgSyXnoMu+aQuwJv+KXV+taTqKJAuiu6UqDIMS18yr5JhcO
 ilHHH5/A5MfvulQnuvym1C+/FnjNhYnyrtHjoqNLH0IehreTNX/uBH36/1gCdnWVPi3+CTy7JUw
 QWLiO+Y1jhX530Z1S4tuTZF/mtDiBPPPah97tW7JqM1yxiUxyUNK8IgU+Yb6Fs5Z+f2Vp+eTX4R
 ZvYD3yEiNXW4L70Yn22qOQzAXNPWtLjZug4TpAR12Or+pl2Be1hhCp4CUnJsJfwVncZK7YN723O
 fxY=
X-Received: by 2002:a05:6000:46db:b0:461:a169:f757 with SMTP id
 ffacd0b85a97d-474ff473c34mr721582f8f.16.1782741382185; 
 Mon, 29 Jun 2026 06:56:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072188fsm16499559f8f.29.2026.06.29.06.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:56:21 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 29 Jun 2026 13:56:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: 32774667ddf102e519077ed6c1de01341260c4c3
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <42d85a4e904fb76da8670aa9bce145ba362bf8c8-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weCTM-00011d-D4
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh.in: Add
 support for expected test failures
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
Content-Type: multipart/mixed; boundary="===============5282438744411475471=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5282438744411475471==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EFgldJMTAPM="; charset=UTF-8

--EFgldJMTAPM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1755?usp=3Demail

to review the following change=2E


Chang=
e subject: t_client=2Esh=2Ein: Add support for expected test failures
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=2Esh=2E=
in: Add support for expected test failures

Allow to mark tests that must f=
ail=2E The EXPECT_FAIL
message must contain a message that can be found in
=
the log output=2E OpenVPN must not start up successfully,
so this does not =
allow to test for failures that only
affect the traffic over the link=2E

T=
his is based on work by Gert Doering for the t_server
test infrastructure=
=2E

Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/t_client=2Esh=2Ein
1 =
file changed, 48 insertions(+), 10 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1755/1

diff --git a/tests/t=
_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index c92fb4a=2E=2E46646c4 100=
755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -333,6=
 +333,7 @@
     eval expect_ifconfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
     ev=
al ping4_hosts=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$PING6_H=
OSTS_$SUF\"
+    eval expect_fail=3D\"\$EXPECT_FAIL_$SUF\"
     eval fping_=
args=3D\"\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG=
* variables for this test are missing, run an --up
@@ -344,6 +345,9 @@
    =
 fi
 
     output_start "### test run $SUF: '$test_run_title' ###"
+    if =
[ -n "$expect_fail" ] ; then
+        output "### expect failure: '$expect_=
fail'";
+    fi
     fail_count=3D0
 
     if [ -n "$test_check_skip" ]; th=
en
@@ -390,23 +394,57 @@
     ovpn_init_success=3D0
     while [ $ovpn_init=
_check -gt 0 ];
     do
-       sleep 1  # Wait for OpenVPN to initialize a=
nd have had time to write the pid file
-       grep "Initialization Sequenc=
e Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
-       if [ $? -eq 0 ];=
 then
-           ovpn_init_check=3D0
-           ovpn_init_success=3D1
-  =
     fi
-       ovpn_init_check=3D$(( $ovpn_init_check - 1 ))
+        slee=
p 1  # Wait for OpenVPN to initialize and have had time to write the pid fi=
le
+        if [ -n "$expect_fail" ]
+        then
+            grep "$expe=
ct_fail" $LOGDIR/$SUF:openvpn=2Elog # >/dev/null
+            if [ $? -eq 0=
 ]; then
+                ovpn_init_check=3D0
+                ovpn_init_su=
ccess=3D1
+                sleep 5         # give openvpn time to quit
+   =
         fi
+        else
+            grep "Initialization Sequence Comple=
ted" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
+            if [ $? -eq 0 ]; th=
en
+                ovpn_init_check=3D0
+                ovpn_init_success=
=3D1
+            fi
+        fi
+        ovpn_init_check=3D$(( $ovpn_init_=
check - 1 ))
     done
 
-    opid=3D`cat $pidfile`
+    opid=3D`[ -e $pidf=
ile ] && cat $pidfile`
     if [ -n "$opid" ]; then
         output "  Open=
VPN running with PID $opid"
     else
-        output "  Could not read Ope=
nVPN PID file"
+        if [ -z "$expect_fail" ]        # print this only i=
f unexpected
+        then
+            output "  Could not read OpenVPN PI=
D file"
+        fi
     fi
 
-    # If OpenVPN did not start
+    # did we=
 expect a failure?
+    if [ -n "$expect_fail" ]
+    then
+        if [ -n=
 "$opid" ]               # OpenVPN did start!
+        then
+            ou=
tput "$0: OpenVPN did start up, expected failure"
+            $RUN_SUDO $K=
ILL_EXEC $opid $sudopid
+            output "tail -5 $SUF:openvpn=2Elog"
+ =
           output "`tail -5 $LOGDIR/$SUF:openvpn=2Elog`"
+            fail =
"skip rest of sub-tests for test run $SUF=2E"
+            trap - 0 1 2 3 1=
5
+            SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=
=3D32
+            echo $ECHO_E "$outbuf" ; continue
+        else
+       =
     output "test run $SUF: all tests OK (saw expected failure)=2E"
+      =
      SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+            continue
+        fi
+  =
  fi
+
+    # If OpenVPN did not start but should have
     if [ $ovpn_init=
_success -ne 1 -o -z "$opid" ]; then
         output "$0:  OpenVPN did not =
initialize in a reasonable time"
         if [ -n "$opid" ]; then

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff=
28408c9bfcb844
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 1
Gerrit-Owner: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--EFgldJMTAPM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">t_client=2Esh=2Ein: Add support for expected test failures<br><br>Allo=
w to mark tests that must fail=2E The EXPECT_FAIL<br>message must contain a=
 message that can be found in<br>the log output=2E OpenVPN must not start u=
p successfully,<br>so this does not allow to test for failures that only<br=
>affect the traffic over the link=2E<br><br>This is based on work by Gert D=
oering for the t_server<br>test infrastructure=2E<br><br>Change-Id: I6c51bc=
dda5666e0dab2adcdaff28408c9bfcb844<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>1 file =
changed, 48 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1755/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><=
br><span>index c92fb4a=2E=2E46646c4 100755</span><br><span>--- a/tests/t_cl=
ient=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><sp=
an>@@ -333,6 +333,7 @@</span><br><span>     eval expect_ifconfig6=3D\&quot;=
\$EXPECT_IFCONFIG6_$SUF\&quot;</span><br><span>     eval ping4_hosts=3D\&qu=
ot;\$PING4_HOSTS_$SUF\&quot;</span><br><span>     eval ping6_hosts=3D\&quot=
;\$PING6_HOSTS_$SUF\&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    eval expect_fail=3D\&quot;\$EXPECT_FAIL_$SUF\&quot;</span><br><s=
pan>     eval fping_args=3D\&quot;\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\&quo=
t;</span><br><span> </span><br><span>     # If EXCEPT_IFCONFIG* variables f=
or this test are missing, run an --up</span><br><span>@@ -344,6 +345,9 @@</=
span><br><span>     fi</span><br><span> </span><br><span>     output_start =
&quot;### test run $SUF: &#39;$test_run_title&#39; ###&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;$expect_fail&quo=
t; ] ; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
output &quot;### expect failure: &#39;$expect_fail&#39;&quot;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span>     fail=
_count=3D0</span><br><span> </span><br><span>     if [ -n &quot;$test_check=
_skip&quot; ]; then</span><br><span>@@ -390,23 +394,57 @@</span><br><span> =
    ovpn_init_success=3D0</span><br><span>     while [ $ovpn_init_check -gt=
 0 ];</span><br><span>     do</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-       sleep 1  # Wait for OpenVPN to initialize and have had time =
to write the pid file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
       grep &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:open=
vpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-       if [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-           ovpn_init_check=3D0</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-           ovpn_init_success=3D1</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-       fi</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-       ovpn_init_check=3D$(( $ovpn_init_check - 1 ))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sleep 1  # Wait f=
or OpenVPN to initialize and have had time to write the pid file</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if [ -n &quot;$expect_=
fail&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gr=
ep &quot;$expect_fail&quot; $LOGDIR/$SUF:openvpn=2Elog # &gt;/dev/null</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [ $? -eq =
0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      ovpn_init_check=3D0</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                ovpn_init_success=3D1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                sleep 5         # give openvpn time=
 to quit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            grep &quot;=
Initialization Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev=
/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                ovpn_init_check=3D0</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                ovpn_init_success=3D1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ovpn_init_check=3D$(( $ovpn_init_check - 1 ))</=
span><br><span>     done</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    opid=3D`cat $pidfile`</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    opid=3D`[ -e $pidfile ] &amp;&amp; cat $pidf=
ile`</span><br><span>     if [ -n &quot;$opid&quot; ]; then</span><br><span=
>         output &quot;  OpenVPN running with PID $opid&quot;</span><br><sp=
an>     else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
utput &quot;  Could not read OpenVPN PID file&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if [ -z &quot;$expect_fail&quot; =
]        # print this only if unexpected</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            output &quot;  Could not read OpenVPN PID file&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span=
><br><span>     fi</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    # If OpenVPN did not start</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    # did we expect a failure?</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;$expect_fail&quot; ]=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    then</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if [ -n &quot;$opid&qu=
ot; ]               # OpenVPN did start!</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            output &quot;$0: OpenVPN did start up, expected f=
ailure&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     $RUN_SUDO $KILL_EXEC $opid $sudopid</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            output &quot;tail -5 $SUF:openvpn=2Elog&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            outp=
ut &quot;`tail -5 $LOGDIR/$SUF:openvpn=2Elog`&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            fail &quot;skip rest of sub-t=
ests for test run $SUF=2E&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            trap - 0 1 2 3 15</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            exi=
t_code=3D32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    echo $ECHO_E &quot;$outbuf&quot; ; continue</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            output &quot;test run $SUF: all tests OK (=
saw expected failure)=2E&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            continue</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    # If OpenVPN did not start but should have</span><br><span>     if=
 [ $ovpn_init_success -ne 1 -o -z &quot;$opid&quot; ]; then</span><br><span=
>         output &quot;$0:  OpenVPN did not initialize in a reasonable time=
&quot;</span><br><span>         if [ -n &quot;$opid&quot; ]; then</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1755?usp=3Demail">change 1755</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff2=
8408c9bfcb844 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 175=
5 </div>
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
--EFgldJMTAPM=--


--===============5282438744411475471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5282438744411475471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5282438744411475471==--

