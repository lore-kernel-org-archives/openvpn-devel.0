Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054AAC5DF9B
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GxDKHFGir7ZVhQoqfuquVAf/NvMApkAEhwJ5vVLHswc=; b=gnTWtUEa6zj92hQHMWSqfxcaR0
	60Y311X9EeBYibC59DHFZSpyXiJGtBS4Ep/rPsXuxrKm0YcFLdDbk7jEj0Potv8bOfKD58ydvnY3Y
	/m5HSWr3lNzq2Yj6rFUIIPoOA5mIkWM7uGUltv+DqC4NVVdKf76vCqJtLKiH7g2Oabig=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWWl-0002aA-GB;
	Mon, 24 Aug 2026 15:24:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWWj-0002a2-9d
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:23:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jHRGrXje61tyvQA2wlZ/gtUSH1jJIOAHqUlSZnSsL54=; b=QHiEMVwFFZc3sQfI1peSDdoHBm
 AjTXGJ35UVVUvTR2avRj5z+07jt/uwG7H9CCZ0wZXkoqU77KO7dY3t0z419PIegnxT1IpQp6CcMJP
 FHB6BRrwtHTIWn03HfvJKTUNVH4/J+Ple3UVRtUG/3HH/icK79xDQc4MD8rJsAI4RxcQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jHRGrXje61tyvQA2wlZ/gtUSH1jJIOAHqUlSZnSsL54=; b=J
 lYIxUt+a7GsgSFrK69JnTcVWFqkaLJ8FaooP/S75JbqvlbYrW2uy6qa92MVfGNjV14j1X5HyAAIe4
 c5wihPT/lqazOERGpZTDQSz0brKvAVzufuTX0HW/DkXcdK/wI+cV7GLS0C8i40GdiEFzJWKTv9TLi
 p1R4mkG0Em5lV9hQ=;
Received: from mail-ed1-f41.google.com ([209.85.208.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWWi-00084r-Cs for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:23:58 +0000
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6a17cb94b26so6856245a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787585030; x=1788189830; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jHRGrXje61tyvQA2wlZ/gtUSH1jJIOAHqUlSZnSsL54=;
 b=L491FhP+PbvWkkXHU1vbInbuZ42s664yXe5zThIaxMQxasD78NeUmLTgB1Hg6bHscx
 YZ3aJfwfSBJ9cGjcTF2/hQxsVpRDbSWU0U4dsoSP/+WxZvUaZlgB+YPTKicujbkWgzDy
 Cmlvt4YjeOkM+THyZ1h1d7B6niHa8x6NSbd7wWDaxYXiaUD3QvyVZZgK2yENUQKUB27m
 bylZsiq3XMB6x2KCsDkbIu0bX5p9uM5i56VyG8/J3QHEP0jWPdt4HuvEEh5bhBT40HoX
 g5+w3NlquqT2CIk1ErTOdMYSmu3ef+9zJtulFNcKqUVhUrQZKf6dbYb63ns8PqSAUdF0
 my7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585030; x=1788189830;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jHRGrXje61tyvQA2wlZ/gtUSH1jJIOAHqUlSZnSsL54=;
 b=pDEy7hzktLJASiP0q71epJqX/RsMD+C43RdeXGgLhNS7Q+6Iq/Yje+2ym3AAToB2/n
 +Y7t0Iqc30KIPH+7KyjyCGXtnnX5LqLjMjVd66dI9SldSXAHbXwX+/iFn2lM7tIbIOYE
 ydc3eV87DbQgjmmRcIENPpxwd48hMzbIEsu8Pu1XxmAEUIc9JDWcCiTB8an9WzlKEbOe
 Enn6qCtllvTHr8pNElretbXE60tdJ0xK4oFtKsaVf0dm6rZqfclkuF3eSSTJ28In9M2A
 fD4MJj0WBjqZ7sBaeBYZeYQxFe/6E5WKyWDL69DerIbJuqryuXWJfd2M9IOkVwkCd0gJ
 4v4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+SdINLCNIlLQfJxAPiCgcDBNty8QcLz5DvavAj38BwuGPj9MzhdE+Y/eDlVFSGu0muVaz3yJeUgioaGj7@lists.sourceforge.net
X-Gm-Message-State: AFuF++nwFRoawwqOgDqgKOPwC49VS5BpIvjSteQpwEwET+24iNanlH3t
 DyG1fUI74s2bRdFvd7Jz7tukgvyuOadxeYP27aKUX6IaXUEcWTyDRKABTMu0JGdhDVu6/mQPme2
 xpUhiaEf8xn2GNIW8IrfCapzCbsVpjWlGJ3cp1g3X7LSSvUUmUQWIIKQqE2unwKphH6EZ
X-Gm-Gg: AR+sD12lcM/es/RlWa3pyHQV25Lq0Pd/TaDf1yM2oE1GF9pwq7gpv2FPGZTuABaw6QG
 MYjvj8nbH065wLgIkUE/4AabTDfr4DQD+qaqFOKWl0DReNviQDw3UB7284B9RKVpy7xDWgh8RK8
 yAvY1oyNJshMVq2EAQuz2CZEgqQRXpz+BrgWR11B4yARwEdu2bXRKvBuslVyE8I3feBnQ1TUreW
 re4LZu+s+wMsY5oxo/A0tNmitpEd2okKQ3tl/8EJhHsFbW8k9vYsyULAxoya7/hV/3JBQuvVqJk
 TrldTNperUvhV2yhNnTLgONuKfawqNTfqPzCos0CHvTsV8Eeg7t8LTyLBIlEk5ntUYx8BDTlzsK
 d9yCanHVKUsc9JdCZzbmtkXI5CW7KBdohyGrZo4QefcEewDf2hW4aGYqcmrDGRgHGUWqbf1DrDN
 GiAgcyJfoDXMoyuONIhAdnmG1Fyrd0fMvIEndMZxWv0OguO9qNacY/+o8k0I1fyOC9HmNrmGHqd
 TMY4kBU6IIHCwy7uoPFE8ruFmQJRZD9BMIHdfQMvvs+XFQvn1P1sMPqUaksEAEb59JZyWJN0gWs
 CaXL6MjNQMKYmCojeB3kCX0vrmHjHtSPbqQaGE8Hvb8/tE3HXTQHMGFB
X-Received: by 2002:a05:6402:4613:b0:698:9e5e:5df8 with SMTP id
 4fb4d7f45d1cf-6a42f1aca88mr27466933a12.7.1787585029657; 
 Mon, 24 Aug 2026 08:23:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e2ddad2sm8842373a12.30.2026.08.24.08.23.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:23:48 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:23:45 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: b60ab3c9f41d033dd44c5b0f70f23a0da11224a9
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e223cf8e867925edee826e1c6550302ac8fc23f2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWWi-00084r-Cs
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6667159529555082576=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6667159529555082576==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0XjNTjF+Bxo="; charset=UTF-8

--0XjNTjF+Bxo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail

to look at the new patch=
 set (#5)=2E


Change subject: t_client=2Esh=2Ein: Add support for expected=
 test failures
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


t_client=2Esh=2Ein: Add support for expected test failures

Allow to mark=
 tests that must fail=2E The EXPECT_FAIL
message must contain a message tha=
t can be found in
the log output=2E OpenVPN must not start up successfully,=

so this does not allow to test for failures that only
affect the traffic o=
ver the link=2E

This is based on work by Gert Doering for the t_server
tes=
t infrastructure=2E

Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
S=
igned-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/t_cli=
ent=2Erc-sample
M tests/t_client=2Esh=2Ein
2 files changed, 52 insertions(+=
), 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/55/1755/5

diff --git a/tests/t_client=2Erc-sample b/tests/t_cl=
ient=2Erc-sample
index a35d185=2E=2E04714ef 100644
--- a/tests/t_client=2Er=
c-sample
+++ b/tests/t_client=2Erc-sample
@@ -65,6 +65,7 @@
 # EXPECT_IFCON=
FIG6_x =3D "this IPv6 address needs to show up in ifconfig"
 # PING4_HOSTS_=
x      =3D "these hosts musts ping when openvpn is up (IPv4 fping)"
 # PING=
6_HOSTS_x      =3D "these hosts musts ping when openvpn is up (IPv6 fping6)=
"
+# EXPECT_FAIL_x      =3D "instead of waiting for connection wait for thi=
s error message"
 #
 # hook test options:
 #
diff --git a/tests/t_client=2E=
sh=2Ein b/tests/t_client=2Esh=2Ein
index 230a273=2E=2Edd7f743 100755
--- a/=
tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -321,6 +321,7 @@=

     eval expect_ifconfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_h=
osts=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$PING6_HOSTS_$SUF\=
"
+    eval expect_fail=3D\"\$EXPECT_FAIL_$SUF\"
     eval fping_args=3D\"\=
$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG* variable=
s for this test are missing, run an --up
@@ -332,6 +333,9 @@
     fi
 
    =
 output_start "### test run $SUF: '$test_run_title' ###"
+    if [ -n "$exp=
ect_fail" ]; then
+        output "### expect failure: '$expect_fail'"
+   =
 fi
     fail_count=3D0
 
     if [ -n "$test_check_skip" ]; then
@@ -380,2=
3 +384,62 @@
     ovpn_init_check=3D30
     ovpn_init_success=3D0
     whil=
e [ $ovpn_init_check -gt 0 ]; do
-        sleep 1 # Wait for OpenVPN to ini=
tialize and have had time to write the pid file
-        grep "Initializati=
on Sequence Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
-        if [ =
$? -eq 0 ]; then
-            ovpn_init_check=3D0
-            ovpn_init_su=
ccess=3D1
+        sleep 1 # Wait for OpenVPN to initialize and to write th=
e pid file
+        if [ -n "$expect_fail" ]; then
+            grep "$expe=
ct_fail" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
+            if [ $? -eq 0 ]=
; then
+                ovpn_init_check=3D0
+                ovpn_init_succ=
ess=3D1
+                sleep 5 # give openvpn time to quit
+            f=
i
+        else
+            grep "Initialization Sequence Completed" $LOGD=
IR/$SUF:openvpn=2Elog >/dev/null
+            if [ $? -eq 0 ]; then
+      =
          ovpn_init_check=3D0
+                ovpn_init_success=3D1
+     =
       fi
         fi
         ovpn_init_check=3D$((ovpn_init_check - 1))
 =
    done
 
-    opid=3D$(cat $pidfile)
+    opid=3D$([ -e $pidfile ] && cat=
 $pidfile)
     if [ -n "$opid" ]; then
         output "  OpenVPN running =
with PID $opid"
     else
-        output "  Could not read OpenVPN PID fil=
e"
+        if [ -z "$expect_fail" ]; then # print this only if unexpected
=
+            output "  Could not read OpenVPN PID file"
+        fi
     fi=

 
-    # If OpenVPN did not start
+    # did we expect a failure?
+    if =
[ -n "$expect_fail" ]; then
+        if [ -n "$opid" ]; then # OpenVPN did =
start!
+            output "$0: OpenVPN did start up, expected failure"
+  =
          $RUN_SUDO $KILL_EXEC $opid $sudopid
+            output "tail -5 =
$SUF:openvpn=2Elog"
+            output "$(tail -5 $LOGDIR/$SUF:openvpn=2El=
og)"
+            fail "skip rest of sub-tests for test run $SUF=2E"
+     =
       trap - 0 1 2 3 15
+            SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+=
            exit_code=3D32
+            printf "$outbuf"
+            conti=
nue
+        elif [ $ovpn_init_success -eq 0 ]; then
+            output "$=
0: OpenVPN failure did not match expected failure"
+            output "tai=
l -5 $SUF:openvpn=2Elog"
+            output "$(tail -5 $LOGDIR/$SUF:openvp=
n=2Elog)"
+            SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exi=
t_code=3D33
+            printf "$outbuf"
+            continue
+        el=
se
+            output "test run $SUF: all tests OK (saw expected failure)=
=2E"
+            SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+            continue
+  =
      fi
+    fi
+
+    # If OpenVPN did not start but should have
     if =
[ $ovpn_init_success -ne 1 -o -z "$opid" ]; then
         output "$0:  Open=
VPN did not initialize in a reasonable time"
         if [ -n "$opid" ]; th=
en

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c51bcdda56=
66e0dab2adcdaff28408c9bfcb844
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 5=

Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flich=
tenheld <frank@lichtenheld=2Ecom>

--0XjNTjF+Bxo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #5</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">t_client=2Esh=2Ein: Add support for expected test failures<br><=
br>Allow to mark tests that must fail=2E The EXPECT_FAIL<br>message must co=
ntain a message that can be found in<br>the log output=2E OpenVPN must not =
start up successfully,<br>so this does not allow to test for failures that =
only<br>affect the traffic over the link=2E<br><br>This is based on work by=
 Gert Doering for the t_server<br>test infrastructure=2E<br><br>Change-Id: =
I6c51bcdda5666e0dab2adcdaff28408c9bfcb844<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Erc-sample<b=
r>M tests/t_client=2Esh=2Ein<br>2 files changed, 52 insertions(+), 8 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/55/1755/5</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/tests/t_client=2Erc-=
sample b/tests/t_client=2Erc-sample</span><br><span>index a35d185=2E=2E0471=
4ef 100644</span><br><span>--- a/tests/t_client=2Erc-sample</span><br><span=
>+++ b/tests/t_client=2Erc-sample</span><br><span>@@ -65,6 +65,7 @@</span><=
br><span> # EXPECT_IFCONFIG6_x =3D &quot;this IPv6 address needs to show up=
 in ifconfig&quot;</span><br><span> # PING4_HOSTS_x      =3D &quot;these ho=
sts musts ping when openvpn is up (IPv4 fping)&quot;</span><br><span> # PIN=
G6_HOSTS_x      =3D &quot;these hosts musts ping when openvpn is up (IPv6 f=
ping6)&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# EXPEC=
T_FAIL_x      =3D &quot;instead of waiting for connection wait for this err=
or message&quot;</span><br><span> #</span><br><span> # hook test options:</=
span><br><span> #</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/t=
ests/t_client=2Esh=2Ein</span><br><span>index 230a273=2E=2Edd7f743 100755</=
span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t=
_client=2Esh=2Ein</span><br><span>@@ -321,6 +321,7 @@</span><br><span>     =
eval expect_ifconfig6=3D\&quot;\$EXPECT_IFCONFIG6_$SUF\&quot;</span><br><sp=
an>     eval ping4_hosts=3D\&quot;\$PING4_HOSTS_$SUF\&quot;</span><br><span=
>     eval ping6_hosts=3D\&quot;\$PING6_HOSTS_$SUF\&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    eval expect_fail=3D\&quot;\$EXPEC=
T_FAIL_$SUF\&quot;</span><br><span>     eval fping_args=3D\&quot;\$FPING_EX=
TRA_ARGS \$FPING_ARGS_$SUF\&quot;</span><br><span> </span><br><span>     # =
If EXCEPT_IFCONFIG* variables for this test are missing, run an --up</span>=
<br><span>@@ -332,6 +333,9 @@</span><br><span>     fi</span><br><span> </sp=
an><br><span>     output_start &quot;### test run $SUF: &#39;$test_run_titl=
e&#39; ###&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if [ -n &quot;$expect_fail&quot; ]; then</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        output &quot;### expect failure: &#39;$expect=
_fail&#39;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 fi</span><br><span>     fail_count=3D0</span><br><span> </span><br><span> =
    if [ -n &quot;$test_check_skip&quot; ]; then</span><br><span>@@ -380,23=
 +384,62 @@</span><br><span>     ovpn_init_check=3D30</span><br><span>     =
ovpn_init_success=3D0</span><br><span>     while [ $ovpn_init_check -gt 0 ]=
; do</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sleep 1 #=
 Wait for OpenVPN to initialize and have had time to write the pid file</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        grep &quot;Initia=
lization Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if [ $? -eq 0 =
]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ov=
pn_init_check=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        ovpn_init_success=3D1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        sleep 1 # Wait for OpenVPN to initialize and to write the=
 pid file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 [ -n &quot;$expect_fail&quot; ]; then</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            grep &quot;$expect_fail&quot; $LOGDIR/$SUF:o=
penvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if [ $? -eq 0 ]; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                ovpn_init_check=3D0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_success=3D1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                slee=
p 5 # give openvpn time to quit</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            fi</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            grep &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF=
:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if [ $? -eq 0 ]; then</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                ovpn_init_check=3D0</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_success=3D=
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fi</sp=
an><br><span>         fi</span><br><span>         ovpn_init_check=3D$((ovpn=
_init_check - 1))</span><br><span>     done</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    opid=3D$(cat $pidfile)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    opid=3D$([ -e $pidfile ]=
 &amp;&amp; cat $pidfile)</span><br><span>     if [ -n &quot;$opid&quot; ];=
 then</span><br><span>         output &quot;  OpenVPN running with PID $opi=
d&quot;</span><br><span>     else</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        output &quot;  Could not read OpenVPN PID file&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ -z &quot;=
$expect_fail&quot; ]; then # print this only if unexpected</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            output &quot;  Could not=
 read OpenVPN PID file&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        fi</span><br><span>     fi</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    # If OpenVPN did not start</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    # did we expect a fa=
ilure?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &=
quot;$expect_fail&quot; ]; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if [ -n &quot;$opid&quot; ]; then # OpenVPN did start!<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            output &=
quot;$0: OpenVPN did start up, expected failure&quot;</span><br><span style=
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1755 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>

</body></html>
--0XjNTjF+Bxo=--


--===============6667159529555082576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6667159529555082576==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6667159529555082576==--

