Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E5BC61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zpBjuYY+HCwEUzSqB5kpmP/P/Ed06jDTAYI0suoxqMo=; b=EE4lat7Sp01vbAUAInevuUZTDL
	iONBPMlzMslx5oX259CDKCAgiLPxxjpfClC4SQt6XUfnsubNZ3QtQBeVWgoxb2DAfd5mb2h0X1M42
	bUVB0gEM29P0VYC/s65e9HyyXci68dyiHDv0D342l9YH8HdAHyO031/l8hzrQcPEgMg8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzukq-0007Nh-1Y;
	Fri, 28 Aug 2026 11:28:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzukp-0007Nb-IP
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:28:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=NJAQS6QBejQEV1E6Rf9hzTbToJFR61IF0mQriQxldgI=; b=nO1Ftbmazw2ArmzSqUgFblpLTt
 jHuujbM/CdHRyQgNSkyk4NyoI27Uosydt+yfCE4ZuaZP9m33UDF26xcWYYe6awM5pB1u4JvLpFnem
 vMyf6Y2j11mFRtwlpdejS0fHbSqF2IBG0DfziR87qieidxVsyj/bBW/TWRqnX2RnpfbA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NJAQS6QBejQEV1E6Rf9hzTbToJFR61IF0mQriQxldgI=; b=W
 eF5GlKwkd6WLawzSr1U+oP364YHMtaJgbdqZb98HvwXQIhAeZPTCjG+WaneV2pJZepWYrsW1b3tkT
 H7eIq87KVSU6EitrcZsupXUdDxdke7p1eZ6Jo4v0bQmLx1FjDiz2ltDUftMPNXSwBTj0UD98o+9Vs
 7iRFFLr6e5miG9wI=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzukn-0002yW-TC for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:28:15 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-480001972b8so457193f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787916487; x=1788521287; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NJAQS6QBejQEV1E6Rf9hzTbToJFR61IF0mQriQxldgI=;
 b=hRaUlSzCGasB1v2SCRg0DkWicWCcYyu/sveW2amBUm+e39gSoXKHG2frIB8bgc7/8G
 yknRMkom/pMYDr65koL0DZipVwYx7uOy8FnCE3lIWnvLuDPfiaOViz86RJ4tXcirwD39
 Bpf2LXnqfBewqRLrZMt+iLfWYrr9cY1x9JLsR+VsLV2O0Nob7Qbup292GHy5ttDJPp+A
 eB+KoiEPgAOOyC4aBhPSpAF5aExA06BSs4gCekxu10dSd5Vw/OMx2mD83ThTddrCK7Jg
 VWqtmo58PxLtLik07z0PIkSMxdZKtQ3aqWdQI+4gx2g0A0oRz0NG7AQAQ5S/a/qKNJJX
 vqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916487; x=1788521287;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NJAQS6QBejQEV1E6Rf9hzTbToJFR61IF0mQriQxldgI=;
 b=lgambuTZPpAwW9LyAq/iwM+7sMj6wwIn2sZnV985yeRZSeHTYQLmJTs7BueRsyopm4
 f4/4gkXm713xLunOyhLmd7zmEjnimqa8fNqVxgD9FHXjiL3J+3oqMgcXU4eIb7n50xVQ
 qjQN56S5zyK2ln3Yh59z3YFBpW0NGGPnW1/O0I4uquWoUklWNK3oOCzhcb2/uKwBXokz
 9l25TBMJG6hFqQ1v1+yj4fcB1oRl7X2QXl5tE/wV4wTXT0wT6D8551qb8EAjKudkY30P
 dx9s6o+YFdVjH/V/6of+cmb8rGpKyni07gyZ+LrGO7mMqF+PMcuHlNpPw27MtSPnT0hw
 UVyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrux/IW6RfzDytLlYv7uWfwDcKiU3Hz+mxPdhxpQy0aFiC8HzCqbeT1hPDmMxok3qrS/tQ7ZPzEKTiupMtQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++l/tU0u9Nyh+ljChTdUKXQ8IGXejj17cDOXHzaAkXE2eriJlyBY
 KMxEyHOkfF+atu9S9ku+F44DU0R2OSxLMOQqMzayTjNjPuKF4m/YgShDvpGZZHxkxQ/qlGkiOOZ
 qURUfML/uUthYioOp6KvT7lSMx1ZmHsfHwGN3itxl2yW/1ANJaVDb2F2qhzr+BF/eFUzQWzAjSC
 SNHKDnSg==
X-Gm-Gg: AR+sD13FI1M3hmOlAw2kxwOoXbx1RWhADn4KCsiUpmrQqxLzKLJG6eMniMnrzpcifML
 fZBbJWSH30Tni3+rRKejs6omrtpvbIJkcmXmG2ujjNPcBUWy9xG1LTqJDLgD4n3bPSkZOx/AeIf
 AH173sg1Rg1np1t5GVuCoErqaleDJQYn6tjPTwYC4pr2HqNtgSCZdfWAgAOD1mRnl1gyvXX29V5
 rsU1q25ATrKS+KQMAYIznNhoNMvlDxM5LeghyPodgPilALS5mTKhFXQCpclxQqLQ5bIMbwRZZjC
 XueckmL60B2bRMQSnF5+pAnIBYmZlL6N1MKbmVajzXipd/hLCP+4f82bBKG8dGW/81doy5aYYvz
 HNOyLYXvlLuzEscdporriP+HA/ajmqn3uLK2vAHlsJ7fCYv1EwP3iDcF67GriawiKzMtOind8Z5
 4svpn9JzMBby1dHHzd4bZAdJFdlrXDBihZM7QlBce5LNgMxiXnMwjL2MJPCsfPjr5R5kgiB0omv
 mUsdooU6mik+xXNf8UNFX9lauwIR8NXyQfvEQ9hENG2E8G6WRrYd0rj5o3o7+RaYogh7/aCdUlS
 N0GjA7o1GjVu/oD5Unu4I1so5rJz3iV7GAuR7qFBIAfQm7AzTp8=
X-Received: by 2002:a05:600c:4445:b0:493:e451:a9e1 with SMTP id
 5b1f17b1804b1-49b91c2e150mr93690755e9.2.1787916487190; 
 Fri, 28 Aug 2026 04:28:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b955e7906sm36715715e9.1.2026.08.28.04.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:28:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 11:28:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: 37ea1c7683ccb464f80d6e7e8fbcd4b8baf2ac60
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ec78fce907a69caf2ff2f13c55df813b5297496-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzukn-0002yW-TC
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0122875540297224976=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0122875540297224976==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yEwcw4hctc0="; charset=UTF-8

--yEwcw4hctc0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1755?usp=3Demail )

Change subject: t_client=2Esh=2Ein: Add support for=
 expected test failures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

t_client=2Esh=2Ein: Add support for expected test failures

Allo=
w to mark tests that must fail=2E The EXPECT_FAIL
message must contain a me=
ssage that can be found in
the log output=2E OpenVPN must not start up succ=
essfully,
so this does not allow to test for failures that only
affect the =
traffic over the link=2E

This is based on work by Gert Doering for the t_s=
erver
test infrastructure=2E

Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9=
bfcb844
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755
Message-Id: <2026082515=
5325=2E4960-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg38690=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M tests/t_client=2Erc-sample
M tes=
ts/t_client=2Esh=2Ein
2 files changed, 52 insertions(+), 8 deletions(-)



=

diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample
index=
 a35d185=2E=2E04714ef 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t=
_client=2Erc-sample
@@ -65,6 +65,7 @@
 # EXPECT_IFCONFIG6_x =3D "this IPv6 =
address needs to show up in ifconfig"
 # PING4_HOSTS_x      =3D "these host=
s musts ping when openvpn is up (IPv4 fping)"
 # PING6_HOSTS_x      =3D "th=
ese hosts musts ping when openvpn is up (IPv6 fping6)"
+# EXPECT_FAIL_x    =
  =3D "instead of waiting for connection wait for this error message"
 #
 #=
 hook test options:
 #
diff --git a/tests/t_client=2Esh=2Ein b/tests/t_clie=
nt=2Esh=2Ein
index 230a273=2E=2Edd7f743 100755
--- a/tests/t_client=2Esh=2E=
in
+++ b/tests/t_client=2Esh=2Ein
@@ -321,6 +321,7 @@
     eval expect_ifco=
nfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_hosts=3D\"\$PING4_HOSTS=
_$SUF\"
     eval ping6_hosts=3D\"\$PING6_HOSTS_$SUF\"
+    eval expect_fai=
l=3D\"\$EXPECT_FAIL_$SUF\"
     eval fping_args=3D\"\$FPING_EXTRA_ARGS \$FP=
ING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG* variables for this test are mi=
ssing, run an --up
@@ -332,6 +333,9 @@
     fi
 
     output_start "### tes=
t run $SUF: '$test_run_title' ###"
+    if [ -n "$expect_fail" ]; then
+   =
     output "### expect failure: '$expect_fail'"
+    fi
     fail_count=3D=
0
 
     if [ -n "$test_check_skip" ]; then
@@ -380,23 +384,62 @@
     ovpn=
_init_check=3D30
     ovpn_init_success=3D0
     while [ $ovpn_init_check -=
gt 0 ]; do
-        sleep 1 # Wait for OpenVPN to initialize and have had t=
ime to write the pid file
-        grep "Initialization Sequence Completed"=
 $LOGDIR/$SUF:openvpn=2Elog >/dev/null
-        if [ $? -eq 0 ]; then
-    =
        ovpn_init_check=3D0
-            ovpn_init_success=3D1
+        sle=
ep 1 # Wait for OpenVPN to initialize and to write the pid file
+        if=
 [ -n "$expect_fail" ]; then
+            grep "$expect_fail" $LOGDIR/$SUF:=
openvpn=2Elog >/dev/null
+            if [ $? -eq 0 ]; then
+              =
  ovpn_init_check=3D0
+                ovpn_init_success=3D1
+             =
   sleep 5 # give openvpn time to quit
+            fi
+        else
+     =
       grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn=2Elog =
>/dev/null
+            if [ $? -eq 0 ]; then
+                ovpn_init_ch=
eck=3D0
+                ovpn_init_success=3D1
+            fi
         fi
=
         ovpn_init_check=3D$((ovpn_init_check - 1))
     done
 
-    opid=
=3D$(cat $pidfile)
+    opid=3D$([ -e $pidfile ] && cat $pidfile)
     if [=
 -n "$opid" ]; then
         output "  OpenVPN running with PID $opid"
    =
 else
-        output "  Could not read OpenVPN PID file"
+        if [ -z =
"$expect_fail" ]; then # print this only if unexpected
+            output =
"  Could not read OpenVPN PID file"
+        fi
     fi
 
-    # If OpenVPN=
 did not start
+    # did we expect a failure?
+    if [ -n "$expect_fail" =
]; then
+        if [ -n "$opid" ]; then # OpenVPN did start!
+            =
output "$0: OpenVPN did start up, expected failure"
+            $RUN_SUDO =
$KILL_EXEC $opid $sudopid
+            output "tail -5 $SUF:openvpn=2Elog"
=
+            output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+            fa=
il "skip rest of sub-tests for test run $SUF=2E"
+            trap - 0 1 2 =
3 15
+            SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_cod=
e=3D32
+            printf "$outbuf"
+            continue
+        elif [ =
$ovpn_init_success -eq 0 ]; then
+            output "$0: OpenVPN failure d=
id not match expected failure"
+            output "tail -5 $SUF:openvpn=2E=
log"
+            output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+         =
   SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D33
+       =
     printf "$outbuf"
+            continue
+        else
+            outp=
ut "test run $SUF: all tests OK (saw expected failure)=2E"
+            SUM=
MARY_OK=3D"$SUMMARY_OK $SUF"
+            continue
+        fi
+    fi
+
+ =
   # If OpenVPN did not start but should have
     if [ $ovpn_init_success =
-ne 1 -o -z "$opid" ]; then
         output "$0:  OpenVPN did not initializ=
e in a reasonable time"
         if [ -n "$opid" ]; then

-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb84=
4
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn=
-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--yEwcw4hctc0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1755?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Add support for expect=
ed test failures<br><br>Allow to mark tests that must fail=2E The EXPECT_FA=
IL<br>message must contain a message that can be found in<br>the log output=
=2E OpenVPN must not start up successfully,<br>so this does not allow to te=
st for failures that only<br>affect the traffic over the link=2E<br><br>Thi=
s is based on work by Gert Doering for the t_server<br>test infrastructure=
=2E<br><br>Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755<br>Message-Id: &lt;20260825155=
325=2E4960-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38690=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/t_clie=
nt=2Erc-sample<br>M tests/t_client=2Esh=2Ein<br>2 files changed, 52 inserti=
ons(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Erc-sa=
mple b/tests/t_client=2Erc-sample</span><br><span>index a35d185=2E=2E04714e=
f 100644</span><br><span>--- a/tests/t_client=2Erc-sample</span><br><span>+=
++ b/tests/t_client=2Erc-sample</span><br><span>@@ -65,6 +65,7 @@</span><br=
><span> # EXPECT_IFCONFIG6_x =3D &quot;this IPv6 address needs to show up i=
n ifconfig&quot;</span><br><span> # PING4_HOSTS_x      =3D &quot;these host=
s musts ping when openvpn is up (IPv4 fping)&quot;</span><br><span> # PING6=
_HOSTS_x      =3D &quot;these hosts musts ping when openvpn is up (IPv6 fpi=
ng6)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# EXPECT_=
FAIL_x      =3D &quot;instead of waiting for connection wait for this error=
 message&quot;</span><br><span> #</span><br><span> # hook test options:</sp=
an><br><span> #</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/tes=
ts/t_client=2Esh=2Ein</span><br><span>index 230a273=2E=2Edd7f743 100755</sp=
an><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_c=
lient=2Esh=2Ein</span><br><span>@@ -321,6 +321,7 @@</span><br><span>     ev=
al expect_ifconfig6=3D\&quot;\$EXPECT_IFCONFIG6_$SUF\&quot;</span><br><span=
>     eval ping4_hosts=3D\&quot;\$PING4_HOSTS_$SUF\&quot;</span><br><span> =
    eval ping6_hosts=3D\&quot;\$PING6_HOSTS_$SUF\&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    eval expect_fail=3D\&quot;\$EXPECT_=
FAIL_$SUF\&quot;</span><br><span>     eval fping_args=3D\&quot;\$FPING_EXTR=
A_ARGS \$FPING_ARGS_$SUF\&quot;</span><br><span> </span><br><span>     # If=
 EXCEPT_IFCONFIG* variables for this test are missing, run an --up</span><b=
r><span>@@ -332,6 +333,9 @@</span><br><span>     fi</span><br><span> </span=
><br><span>     output_start &quot;### test run $SUF: &#39;$test_run_title&=
#39; ###&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f [ -n &quot;$expect_fail&quot; ]; then</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        output &quot;### expect failure: &#39;$expect_f=
ail&#39;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
i</span><br><span>     fail_count=3D0</span><br><span> </span><br><span>   =
  if [ -n &quot;$test_check_skip&quot; ]; then</span><br><span>@@ -380,23 +=
384,62 @@</span><br><span>     ovpn_init_check=3D30</span><br><span>     ov=
pn_init_success=3D0</span><br><span>     while [ $ovpn_init_check -gt 0 ]; =
do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sleep 1 # W=
ait for OpenVPN to initialize and have had time to write the pid file</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        grep &quot;Initiali=
zation Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if [ $? -eq 0 ];=
 then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ovpn=
_init_check=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      ovpn_init_success=3D1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        sleep 1 # Wait for OpenVPN to initialize and to write the p=
id file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [=
 -n &quot;$expect_fail&quot; ]; then</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            grep &quot;$expect_fail&quot; $LOGDIR/$SUF:ope=
nvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                ovpn_init_check=3D0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_success=3D1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                sleep =
5 # give openvpn time to quit</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          grep &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:o=
penvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if [ $? -eq 0 ]; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                ovpn_init_check=3D0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_success=3D1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fi</span=
><br><span>         fi</span><br><span>         ovpn_init_check=3D$((ovpn_i=
nit_check - 1))</span><br><span>     done</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    opid=3D$(cat $pidfile)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    opid=3D$([ -e $pidfile ] &=
amp;&amp; cat $pidfile)</span><br><span>     if [ -n &quot;$opid&quot; ]; t=
hen</span><br><span>         output &quot;  OpenVPN running with PID $opid&=
quot;</span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        output &quot;  Could not read OpenVPN PID file&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ -z &quot;$e=
xpect_fail&quot; ]; then # print this only if unexpected</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            output &quot;  Could not r=
ead OpenVPN PID file&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        fi</span><br><span>     fi</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    # If OpenVPN did not start</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    # did we expect a fail=
ure?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &qu=
ot;$expect_fail&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if [ -n &quot;$opid&quot; ]; then # OpenVPN did start!</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            output &qu=
ot;$0: OpenVPN did start up, expected failure&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            $RUN_SUDO $KILL_EXEC $opid $s=
udopid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o=
utput &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            output &quot;$(tail -5 $LOGDIR/$SUF:op=
envpn=2Elog)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           fail &quot;skip rest of sub-tests for test run $SUF=2E&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            trap - 0 1 =
2 3 15</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            S=
UMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            exit_code=3D32</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            printf &quot;$outbuf&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        elif [ $ovpn_=
init_success -eq 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            output &quot;$0: OpenVPN failure did not match expected =
failure&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            output &quot;$(tail -5 $LOGDI=
R/$SUF:openvpn=2Elog)&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            exit_code=3D33</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            printf &qu=
ot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   output &quot;test run $SUF: all tests OK (saw expected failure)=2E&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            SUMMARY=
_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            continue</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    # If OpenVPN did not =
start but should have</span><br><span>     if [ $ovpn_init_success -ne 1 -o=
 -z &quot;$opid&quot; ]; then</span><br><span>         output &quot;$0:  Op=
enVPN did not initialize in a reasonable time&quot;</span><br><span>       =
  if [ -n &quot;$opid&quot; ]; then</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=
=3Demail">change 1755</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1755?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1755 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--yEwcw4hctc0=--


--===============0122875540297224976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0122875540297224976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0122875540297224976==--

