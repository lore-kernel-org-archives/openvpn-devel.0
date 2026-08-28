Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF6ACC61DCB
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UPP6CwJD9juxI+N1bU2kEMGHRpQv5BFsVTseCqgJLUQ=; b=NPu2HEdz/tiuwvf+BckU82NXlU
	xshwoS/xr9qA244bMFdbNfp/steJ49CSxPK/YjaW1kULonN/kbmERFi4kMx6gKtf/dzF2h1KJvgPB
	1ra3koqgXccxFQiACh7b1I4jdPqnZjArnvOklKNP7jFltKRrEzIFR3Boryvk9tgB6fmY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzukw-0005ux-Ei;
	Fri, 28 Aug 2026 11:28:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzukq-0005uO-Jc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:28:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vb21qXsog6Y5BMqlETdniqyeZxFqargqdzjHLPrp8oM=; b=R0Y1j/HlfLZ2bh10cOWUyessov
 0Wg3tWAvwshn7m+PilDUEcwpAJT4PgW+HNg25e+bXK8IE+sZqDkQe2v6l9/wz8tKkGH0Irg9+ruQ0
 vy8lftA9vs9MlLikwyXRhuIRAjjmsxl4dAG40sQsoEOBY2USrOvbocewJa3u/PsqSlg8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vb21qXsog6Y5BMqlETdniqyeZxFqargqdzjHLPrp8oM=; b=S
 IgmFA+rrLK8duHZ7vq3jol/cR/2LATXopFHSWU3hyH98RkEgtPi3t1bkftvVAqbW6WndreiavTchr
 A2DR9/C+zgSe6lh0GWrmD3eGg+fM48nfWwidcX7+hZ865TibfocteP3umaNOqbOA3dAg0kKTn8gol
 eN3B7r5Q6kfRR8rc=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzukn-00018R-6y for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 11:28:17 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-482fc2b44a7so382529f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 04:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787916486; x=1788521286; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vb21qXsog6Y5BMqlETdniqyeZxFqargqdzjHLPrp8oM=;
 b=ePM66tnWQIjJPM+2SasS0gpLsQj2d11OboCRuku6bBGEWpr40Q9SI8QnQal/oYuAoX
 cU9gIHXoY9Qvcw8K6rxw6OfsyVMJ9mZeNmA8laZ32gz6VQIxLoeBoGwrr9ZPG/mcX08r
 uDeCAiuSpd/BVN6E960o6dEKDVn5vGzinw0SGIcXv5nbq9WXcYKcIlZTOWTE2PVclNcb
 cNCbnbEo3lGcCG5B3T6eON4bSrvJSfQ2aj5+omWUb0We/OyuMOe/KL90bBQdiMbm+7uc
 G2uNCGeetQAM7fidgVE0zlWY0ZDrDJdSapTiStrhtbbD1J7TXp/r+UuJiqGXktAl65Cg
 H1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787916486; x=1788521286;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vb21qXsog6Y5BMqlETdniqyeZxFqargqdzjHLPrp8oM=;
 b=Wen454FF5bhMY3qWGqENw1Mkt6xuCVWYLKM6E7I2WeoKFbJr9FBXoO/4KSxNkInLJU
 YgwfyqMZLmwz279nLERW//SiYqkITLFZruIS1O3byWkJLU+3Oh1iqP6Iez4uG3Hypkc+
 H7gjZSIBBFjM2Pzu9aqg5LYY/TeTsIqekkwbypzhXUswpQlDgQnYJmrDKvTnJCZ5GAlw
 cTKj9hIk9bdl2Atx+D7PP5MtO2ywdl4bDeUjQgdJfRuJWmZh456RhCrGFdb2FADFy+ux
 JfmeV7VJPCxKKKlw3CaskEp5+0/pYbP7C+1rapb1gheQgcCSmq9RZ/3VoExvl/hm+h/V
 8luQ==
X-Gm-Message-State: AFuF++mR+pTERG+/AMgpB4s9zLoAgTQdaoKjCahyiqwXRGyFrUAM79yp
 XhF3GHdLnvI2w7hjoZPYsqsijC13TiUzipT6rJctmK66RkERfoDLUx1o8rnqYyPJC5Ei8SzLiM0
 BwyXSn5RPZl9yKXq9/KWUoaJ6h0vFkzH2CMQWHRTAG4C0jmuJNUsHbtlgYCskW9ebrkyy
X-Gm-Gg: AR+sD10yrpVwwx/mJyG5cg8b7cH0igDKPyFgfHaqG36VFNxD6Oz7KfibKErAJ/MkSx3
 AYdZF7DR1uJWWyQREdT4wEMaOhkgCJa8Gak6RJZ8pe0mNxu5iFgSDrpHc0FoPK6G5hNYlgMpmYG
 4hD7D8VCki/Bn4SbFBmdHo8FfgblY7DBN6GDGppr8qGqD9D8xVmupiZMiLSiANEyB8Y0gGTFcEm
 SWP/n7OS0sb6uF6LoJ5RYZzHSPei+XpidU5wn67QPvLJ9OhsbyqkeHe4J3c6iMFOi4D/9fGNoVu
 TiZyZHqhdublldx09osrU7w3vt+TaYNRrLzTGJ+EC2yib8DuVnvpFh/DoP6KuwMs0twM5IVfJDO
 UfVIAa07Ygeky3G1CqFmppl3nJMsIJ9WYVE6HtwyV8ADYhUNdoD2f6wyyxtSTb015pOU3+Sa2UM
 YoQR9xXOUSQYqRyloSUgK6VEHK6PT8gbP0uYg5kBJ+Odtr2YjAAdP36DWiSQLw4pv8PPxL9nrqv
 +kczvpegg4mZ8QE0v+8jZtaJxB3zYNH5F4/NYa7W0HWlXalFwQ+nGdZAfm8XwJu/G4tnsmsmSDP
 Gma2i+MAPZCKqQyQHfgU4sRvHPF5VVMv603diZV+H/nOg2DsIXo=
X-Received: by 2002:a05:6000:656:b0:482:f0dc:e571 with SMTP id
 ffacd0b85a97d-482f79b1ec7mr9179573f8f.14.1787916486337; 
 Fri, 28 Aug 2026 04:28:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482fbac4d0asm3497027f8f.10.2026.08.28.04.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:28:05 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 28 Aug 2026 11:28:04 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: 37ea1c7683ccb464f80d6e7e8fbcd4b8baf2ac60
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ec78fce907a69caf2ff2f13c55df813b5297496-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzukn-00018R-6y
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6481145677279423786=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6481145677279423786==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xb7SCeb3L18="; charset=UTF-8

--Xb7SCeb3L18=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Dema=
il )


Change subject: t_client=2Esh=2Ein: Add support for expected test fa=
ilures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_cl=
ient=2Esh=2Ein: Add support for expected test failures

Allow to mark tests=
 that must fail=2E The EXPECT_FAIL
message must contain a message that can =
be found in
the log output=2E OpenVPN must not start up successfully,
so th=
is does not allow to test for failures that only
affect the traffic over th=
e link=2E

This is based on work by Gert Doering for the t_server
test infr=
astructure=2E

Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
Signed-=
off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1755
Message-Id: <20260825155325=2E4960-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg38690=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M tests/t_client=2Erc-sample
M tests/t_client=2Es=
h=2Ein
2 files changed, 52 insertions(+), 8 deletions(-)


  git pull ssh:/=
/gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1755/7

diff --git a/=
tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample
index a35d185=2E=2E=
04714ef 100644
--- a/tests/t_client=2Erc-sample
+++ b/tests/t_client=2Erc-s=
ample
@@ -65,6 +65,7 @@
 # EXPECT_IFCONFIG6_x =3D "this IPv6 address needs =
to show up in ifconfig"
 # PING4_HOSTS_x      =3D "these hosts musts ping w=
hen openvpn is up (IPv4 fping)"
 # PING6_HOSTS_x      =3D "these hosts must=
s ping when openvpn is up (IPv6 fping6)"
+# EXPECT_FAIL_x      =3D "instead=
 of waiting for connection wait for this error message"
 #
 # hook test opt=
ions:
 #
diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
i=
ndex 230a273=2E=2Edd7f743 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests=
/t_client=2Esh=2Ein
@@ -321,6 +321,7 @@
     eval expect_ifconfig6=3D\"\$EX=
PECT_IFCONFIG6_$SUF\"
     eval ping4_hosts=3D\"\$PING4_HOSTS_$SUF\"
     e=
val ping6_hosts=3D\"\$PING6_HOSTS_$SUF\"
+    eval expect_fail=3D\"\$EXPECT=
_FAIL_$SUF\"
     eval fping_args=3D\"\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\=
"
 
     # If EXCEPT_IFCONFIG* variables for this test are missing, run an =
--up
@@ -332,6 +333,9 @@
     fi
 
     output_start "### test run $SUF: '$=
test_run_title' ###"
+    if [ -n "$expect_fail" ]; then
+        output "#=
## expect failure: '$expect_fail'"
+    fi
     fail_count=3D0
 
     if [ =
-n "$test_check_skip" ]; then
@@ -380,23 +384,62 @@
     ovpn_init_check=3D=
30
     ovpn_init_success=3D0
     while [ $ovpn_init_check -gt 0 ]; do
-  =
      sleep 1 # Wait for OpenVPN to initialize and have had time to write t=
he pid file
-        grep "Initialization Sequence Completed" $LOGDIR/$SUF:=
openvpn=2Elog >/dev/null
-        if [ $? -eq 0 ]; then
-            ovpn_i=
nit_check=3D0
-            ovpn_init_success=3D1
+        sleep 1 # Wait fo=
r OpenVPN to initialize and to write the pid file
+        if [ -n "$expect=
_fail" ]; then
+            grep "$expect_fail" $LOGDIR/$SUF:openvpn=2Elog =
>/dev/null
+            if [ $? -eq 0 ]; then
+                ovpn_init_ch=
eck=3D0
+                ovpn_init_success=3D1
+                sleep 5 # g=
ive openvpn time to quit
+            fi
+        else
+            grep "I=
nitialization Sequence Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
+  =
          if [ $? -eq 0 ]; then
+                ovpn_init_check=3D0
+     =
           ovpn_init_success=3D1
+            fi
         fi
         ovpn_=
init_check=3D$((ovpn_init_check - 1))
     done
 
-    opid=3D$(cat $pidfil=
e)
+    opid=3D$([ -e $pidfile ] && cat $pidfile)
     if [ -n "$opid" ]; t=
hen
         output "  OpenVPN running with PID $opid"
     else
-        o=
utput "  Could not read OpenVPN PID file"
+        if [ -z "$expect_fail" ]=
; then # print this only if unexpected
+            output "  Could not rea=
d OpenVPN PID file"
+        fi
     fi
 
-    # If OpenVPN did not start
+=
    # did we expect a failure?
+    if [ -n "$expect_fail" ]; then
+       =
 if [ -n "$opid" ]; then # OpenVPN did start!
+            output "$0: Open=
VPN did start up, expected failure"
+            $RUN_SUDO $KILL_EXEC $opid=
 $sudopid
+            output "tail -5 $SUF:openvpn=2Elog"
+            out=
put "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+            fail "skip rest of=
 sub-tests for test run $SUF=2E"
+            trap - 0 1 2 3 15
+          =
  SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D32
+        =
    printf "$outbuf"
+            continue
+        elif [ $ovpn_init_succe=
ss -eq 0 ]; then
+            output "$0: OpenVPN failure did not match exp=
ected failure"
+            output "tail -5 $SUF:openvpn=2Elog"
+          =
  output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+            SUMMARY_FAIL=
=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D33
+            printf "$o=
utbuf"
+            continue
+        else
+            output "test run $S=
UF: all tests OK (saw expected failure)=2E"
+            SUMMARY_OK=3D"$SUM=
MARY_OK $SUF"
+            continue
+        fi
+    fi
+
+    # If OpenVPN=
 did not start but should have
     if [ $ovpn_init_success -ne 1 -o -z "$o=
pid" ]; then
         output "$0:  OpenVPN did not initialize in a reasonab=
le time"
         if [ -n "$opid" ]; then

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
Gerrit-C=
hange-Number: 1755
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--Xb7SCeb3L18=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3D=
email">View Change</a></p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">t_client=2Esh=2Ein: Add support for=
 expected test failures<br><br>Allow to mark tests that must fail=2E The EX=
PECT_FAIL<br>message must contain a message that can be found in<br>the log=
 output=2E OpenVPN must not start up successfully,<br>so this does not allo=
w to test for failures that only<br>affect the traffic over the link=2E<br>=
<br>This is based on work by Gert Doering for the t_server<br>test infrastr=
ucture=2E<br><br>Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755<br>Message-Id: &lt;20260=
825155325=2E4960-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38690=2Ehtml<br>Sig=
ned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M tests/=
t_client=2Erc-sample<br>M tests/t_client=2Esh=2Ein<br>2 files changed, 52 i=
nsertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1755/7</pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git =
a/tests/t_client=2Erc-sample b/tests/t_client=2Erc-sample</span><br><span>i=
ndex a35d185=2E=2E04714ef 100644</span><br><span>--- a/tests/t_client=2Erc-=
sample</span><br><span>+++ b/tests/t_client=2Erc-sample</span><br><span>@@ =
-65,6 +65,7 @@</span><br><span> # EXPECT_IFCONFIG6_x =3D &quot;this IPv6 ad=
dress needs to show up in ifconfig&quot;</span><br><span> # PING4_HOSTS_x  =
    =3D &quot;these hosts musts ping when openvpn is up (IPv4 fping)&quot;<=
/span><br><span> # PING6_HOSTS_x      =3D &quot;these hosts musts ping when=
 openvpn is up (IPv6 fping6)&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# EXPECT_FAIL_x      =3D &quot;instead of waiting for connec=
tion wait for this error message&quot;</span><br><span> #</span><br><span> =
# hook test options:</span><br><span> #</span><br><span>diff --git a/tests/=
t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><span>index 230a273=
=2E=2Edd7f743 100755</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><=
br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -321,6 +321,7 @@=
</span><br><span>     eval expect_ifconfig6=3D\&quot;\$EXPECT_IFCONFIG6_$SU=
F\&quot;</span><br><span>     eval ping4_hosts=3D\&quot;\$PING4_HOSTS_$SUF\=
&quot;</span><br><span>     eval ping6_hosts=3D\&quot;\$PING6_HOSTS_$SUF\&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    eval expect=
_fail=3D\&quot;\$EXPECT_FAIL_$SUF\&quot;</span><br><span>     eval fping_ar=
gs=3D\&quot;\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\&quot;</span><br><span> </=
span><br><span>     # If EXCEPT_IFCONFIG* variables for this test are missi=
ng, run an --up</span><br><span>@@ -332,6 +333,9 @@</span><br><span>     fi=
</span><br><span> </span><br><span>     output_start &quot;### test run $SU=
F: &#39;$test_run_title&#39; ###&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if [ -n &quot;$expect_fail&quot; ]; then</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;### expect=
 failure: &#39;$expect_fail&#39;&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    fi</span><br><span>     fail_count=3D0</span><br><sp=
an> </span><br><span>     if [ -n &quot;$test_check_skip&quot; ]; then</spa=
n><br><span>@@ -380,23 +384,62 @@</span><br><span>     ovpn_init_check=3D30=
</span><br><span>     ovpn_init_success=3D0</span><br><span>     while [ $o=
vpn_init_check -gt 0 ]; do</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        sleep 1 # Wait for OpenVPN to initialize and have had time to =
write the pid file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     grep &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:openvp=
n=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            ovpn_init_check=3D0</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            ovpn_init_success=3D1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sleep 1 # Wait for OpenVPN to ini=
tialize and to write the pid file</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if [ -n &quot;$expect_fail&quot; ]; then</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            grep &quot;$expect_f=
ail&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if [ $? -eq 0 ]; then</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_chec=
k=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  ovpn_init_success=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                sleep 5 # give openvpn time to quit</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            fi</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            grep &quot;Initialization Sequence Comp=
leted&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if [ $? -eq 0 ]; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_c=
heck=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     ovpn_init_success=3D1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            fi</span><br><span>         fi</span><br><span>         =
ovpn_init_check=3D$((ovpn_init_check - 1))</span><br><span>     done</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opid=
=3D$(cat $pidfile)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   opid=3D$([ -e $pidfile ] &amp;&amp; cat $pidfile)</span><br><span>     i=
f [ -n &quot;$opid&quot; ]; then</span><br><span>         output &quot;  Op=
enVPN running with PID $opid&quot;</span><br><span>     else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        output &quot;  Could not rea=
d OpenVPN PID file&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if [ -z &quot;$expect_fail&quot; ]; then # print this only if =
unexpected</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   output &quot;  Could not read OpenVPN PID file&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span>     fi</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # If=
 OpenVPN did not start</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    # did we expect a failure?</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if [ -n &quot;$expect_fail&quot; ]; then</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if [ -n &quot;$opid&quot; ];=
 then # OpenVPN did start!</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            output &quot;$0: OpenVPN did start up, expected failure&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            $R=
UN_SUDO $KILL_EXEC $opid $sudopid</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            output &quot;tail -5 $SUF:openvpn=2Elog&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            output &quo=
t;$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            fail &quot;skip rest of sub-tests for=
 test run $SUF=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            trap - 0 1 2 3 15</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            exit_code=
=3D32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pr=
intf &quot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            continue</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        elif [ $ovpn_init_success -eq 0 ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            output &quot;$0: OpenVPN fail=
ure did not match expected failure&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            output &quot;tail -5 $SUF:openvpn=2Elog&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            outp=
ut &quot;$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            SUMMARY_FAIL=3D&quot;$SUMMARY=
_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         exit_code=3D33</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            printf &quot;$outbuf&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            continue</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            output &quot;test run $SUF: all tests OK (saw =
expected failure)=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            continue</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    # If OpenVPN did not start but should have</span><br><span>     if [ =
$ovpn_init_success -ne 1 -o -z &quot;$opid&quot; ]; then</span><br><span>  =
       output &quot;$0:  OpenVPN did not initialize in a reasonable time&qu=
ot;</span><br><span>         if [ -n &quot;$opid&quot; ]; then</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1755?usp=3Demail">change 1755</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaf=
f28408c9bfcb844 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
755 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--Xb7SCeb3L18=--


--===============6481145677279423786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6481145677279423786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6481145677279423786==--

