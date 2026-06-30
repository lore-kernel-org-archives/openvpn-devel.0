Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8126C43327
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 12:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+432jJ8QV++tm9WwT0fb7yTFgvQG6J6CIEKNrNjcWck=; b=UufidkqBJAM3JmDs+k51gnn/no
	oUG0pmbn1lKPLwCP9dS2P3Mb6fr4i+O8rUF5lyg7tS51rWfuttxI5Xf5v+9+qslLh0Hdt5E0g9LJE
	3H0nMu6CkSyXuZxUWB8snWu5MKCQQTA/i0ojQWSiWF+btTH5T5VP+SFgnwTDVGN8/3Jw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weXxC-0002Hm-G7;
	Tue, 30 Jun 2026 12:52:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1weXxA-0002Hf-6j
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 12:52:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ph8+RtIpCUbEYdrScnj8bWwMYlTv4FBsMtRPkZLXqbU=; b=iTl/KHLPXchBUYZ+fu07Uv+hw6
 bOYH9yXViFtaTwlLEorFkOe7VLEvvgLb+w/ATrg6Nk6nyZ8j1e9L5skM6lV7gLpoXfYdnD9Ud8CF+
 oey2R8u59LG7H8mCSSmileqohdKaIYM2siDWtg+HHLGUY0vI37Ig2wDnkMr69783aYRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ph8+RtIpCUbEYdrScnj8bWwMYlTv4FBsMtRPkZLXqbU=; b=S
 pjgTUl+Oe+MBHhQp9sLaPvAFT279XKshH6yRXZRI0SxXjE8sAffmgxSWnx3dye5bk642Qgpx4fKOe
 rpsBnhwijaI+YPenxG3qkBMVScEuZcc3W86Ln1o6Wp1lRfJHoTiTU89MOz2gB4RvyY34h6XP1kDpX
 /1+sG/fSOzn3wusM=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1weXx7-0007Wa-Uu for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 12:52:39 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so3886569f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 05:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782823947; x=1783428747; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ph8+RtIpCUbEYdrScnj8bWwMYlTv4FBsMtRPkZLXqbU=;
 b=FLNvjHWyXrMZx+2a3ScnqCKF4O9+8KrOYVOyzougGVIo4Lg8Hanf8zv/3a/E6rXkVk
 M6OLcu0dTxiM0bgUVhDdLN76jScNwRMkyeHRLNUEZCldwBcM/gZreVhpIdtv/u8J8g+i
 NavYMfNIrI4lV8vPLyMNdpHf3w6kHSLYnZMMz/aiIEQB8IfcM/v1UHZH71iFeJATZYLs
 Kng7ycq15b7E0xuLGv937/qaY6k58Dn55Moy7cF6edXTm12T2Xiv8BPENkk5Fg4ZiOkW
 4dkZG2r+AJGc5gvsc5tgpo69BHDSb7O9GIGm0XbqpOfby+bAYhlPTwnFO/adQbpzSMMr
 0tlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782823947; x=1783428747;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ph8+RtIpCUbEYdrScnj8bWwMYlTv4FBsMtRPkZLXqbU=;
 b=IJ97vfoA3QNaVHjs2oRpSmjiHfDkccuJb7WlKvNyuRhWLsAii/Nbv0eQieWwLUc+9n
 yxPBoB6h6IUdoWh6wbV5vwaRKA81pgeYQwDyvervKjN4djeAgPkLnF1oz7NsTk9k1TJv
 ZJ5XrFPGnH+DFT0Mg/KULerl+ukElPFgQS/e1rqjB3a2vMlTTVRCgGlysBUUpKMr65Db
 midg4FOG4ohku+JNMIMtAjy5a44YEGE+GBDUqzBbYrgRdN8UkdOt81zWYPd0xSLsDgtd
 z7Bu8bZr4rMWW1Npux0sMP+hBAjEldCDT04EYf5LYzXu+Lq/gHJvMGD7I6/Y0Z8h5LmU
 EQsg==
X-Gm-Message-State: AOJu0YzPUx8WVxHhNaDVRxjwiLAhOhfZDJdOELM2c1rU4pcnfEggGoSB
 HLvQm1yUjzo20+iyb4LpedmFcm6mYFgcvg8eJ9BTK1sm3IwyIjJakoglxzNQN1l0MEtIG8wNhhs
 2v+teJxhJWDyjW/y5ALnVW0F5ynrpDXpyKDINset6nlyDNc7ll+mT2+H2ThVajPR8b5H3
X-Gm-Gg: AfdE7cmrYI1ZPL5u10ovPRszOvHZcTBIqDfaUF31krg+1SzRC92k9wL4eoxiwxFhz6y
 j4I1A64xIKUmDyu9P2+q+7OsOPE0ryEgNEOhNsBc2AOyqUVPqkruwENLtptesQ3fUcW6tsMdks1
 YKCdBmYzAG+J9kpb00DbHKB/JMJJ+SYxkZcvSaL8iqaspGCKrZhwsmh7Sqp2YL67JHZ8IxhRt4K
 /2OlDIV948o6yrXftSBvmL40eDW9jk0G19Y9GRNsrHV5qfbmlNIxFK25qxRtmb1WSUxUiH8eUsh
 2qhM57tfY/Ea2t2pAwNRbza4B+c+I+4Lv0RVOhOM3d7dZD6NGveh2kOi9CwXXdkKZ1w2F9oCzq5
 tMEHuuGbwpD8XQCu5XCzI1rklF5VtDcTsfNOt7BwKHG1zjWCMKYLJa+/k8xHpijU+rjuGe8Qffp
 eNegtPBl6BUqKJqOiVKsqaejycSg5RDtkxxpFU+WM9RuPwU7P31tmZZ64SUa15fXijPs+/o++/8
 J6NZZM3o2nUb9dXg9B3pa1dt3hOBFOcmiLu9y4ap8Y76fcSQ9J2XrUwfw29SFp1QwadAHlhRUO1
 SFY=
X-Received: by 2002:a5d:5d0f:0:b0:475:613c:c9f2 with SMTP id
 ffacd0b85a97d-475613cca4bmr4957204f8f.5.1782823946583; 
 Tue, 30 Jun 2026 05:52:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4756636cdccsm6930847f8f.24.2026.06.30.05.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 05:52:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 30 Jun 2026 12:52:22 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: b0868a4bcb1c01e5fd8e870af51cedb4491283a0
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9eeab67e51fe0bf64365c6956a8d5eb2e8aaa2ee-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1weXx7-0007Wa-Uu
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
Content-Type: multipart/mixed; boundary="===============4435928950998500425=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4435928950998500425==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="89SIWoiHTPA="; charset=UTF-8

--89SIWoiHTPA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1755?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: t_client=2Esh=2Ein: Add support for expected test failures=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

t_client=
=2Esh=2Ein: Add support for expected test failures

Allow to mark tests tha=
t must fail=2E The EXPECT_FAIL
message must contain a message that can be f=
ound in
the log output=2E OpenVPN must not start up successfully,
so this d=
oes not allow to test for failures that only
affect the traffic over the li=
nk=2E

This is based on work by Gert Doering for the t_server
test infrastr=
ucture=2E

Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
Signed-off-=
by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M tests/t_client=2Esh=
=2Ein
1 file changed, 48 insertions(+), 10 deletions(-)


  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1755/2

diff --git a/t=
ests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index c3e98a8=2E=2E7b7f5=
de 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ =
-320,6 +320,7 @@
     eval expect_ifconfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
 =
    eval ping4_hosts=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$P=
ING6_HOSTS_$SUF\"
+    eval expect_fail=3D\"\$EXPECT_FAIL_$SUF\"
     eval =
fping_args=3D\"\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IF=
CONFIG* variables for this test are missing, run an --up
@@ -331,6 +332,9 @=
@
     fi
 
     output_start "### test run $SUF: '$test_run_title' ###"
+ =
   if [ -n "$expect_fail" ] ; then
+        output "### expect failure: '$e=
xpect_fail'";
+    fi
     fail_count=3D0
 
     if [ -n "$test_check_skip"=
 ]; then
@@ -377,23 +381,57 @@
     ovpn_init_success=3D0
     while [ $ovp=
n_init_check -gt 0 ];
     do
-       sleep 1  # Wait for OpenVPN to initia=
lize and have had time to write the pid file
-       grep "Initialization S=
equence Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
-       if [ $? -e=
q 0 ]; then
-           ovpn_init_check=3D0
-           ovpn_init_success=
=3D1
-       fi
-       ovpn_init_check=3D$(( $ovpn_init_check - 1 ))
+    =
    sleep 1  # Wait for OpenVPN to initialize and have had time to write th=
e pid file
+        if [ -n "$expect_fail" ]
+        then
+            gre=
p "$expect_fail" $LOGDIR/$SUF:openvpn=2Elog # >/dev/null
+            if [ =
$? -eq 0 ]; then
+                ovpn_init_check=3D0
+                ovpn=
_init_success=3D1
+                sleep 5         # give openvpn time to q=
uit
+            fi
+        else
+            grep "Initialization Sequenc=
e Completed" $LOGDIR/$SUF:openvpn=2Elog >/dev/null
+            if [ $? -eq=
 0 ]; then
+                ovpn_init_check=3D0
+                ovpn_init_=
success=3D1
+            fi
+        fi
+        ovpn_init_check=3D$(( $ovp=
n_init_check - 1 ))
     done
 
-    opid=3D`cat $pidfile`
+    opid=3D`[ -=
e $pidfile ] && cat $pidfile`
     if [ -n "$opid" ]; then
         output =
"  OpenVPN running with PID $opid"
     else
-        output "  Could not r=
ead OpenVPN PID file"
+        if [ -z "$expect_fail" ]        # print this=
 only if unexpected
+        then
+            output "  Could not read Ope=
nVPN PID file"
+        fi
     fi
 
-    # If OpenVPN did not start
+    #=
 did we expect a failure?
+    if [ -n "$expect_fail" ]
+    then
+        =
if [ -n "$opid" ]               # OpenVPN did start!
+        then
+       =
     output "$0: OpenVPN did start up, expected failure"
+            $RUN_=
SUDO $KILL_EXEC $opid $sudopid
+            output "tail -5 $SUF:openvpn=2E=
log"
+            output "`tail -5 $LOGDIR/$SUF:openvpn=2Elog`"
+          =
  fail "skip rest of sub-tests for test run $SUF=2E"
+            trap - 0 =
1 2 3 15
+            SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit=
_code=3D32
+            printf "$outbuf" ; continue
+        else
+        =
    output "test run $SUF: all tests OK (saw expected failure)=2E"
+       =
     SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+            continue
+        fi
+   =
 fi
+
+    # If OpenVPN did not start but should have
     if [ $ovpn_init_=
success -ne 1 -o -z "$opid" ]; then
         output "$0:  OpenVPN did not i=
nitialize in a reasonable time"
         if [ -n "$opid" ]; then

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c51bcdda5666e0dab2adcda=
ff28408c9bfcb844
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 2
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--89SIWoiHTPA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">t_=
client=2Esh=2Ein: Add support for expected test failures<br><br>Allow to ma=
rk tests that must fail=2E The EXPECT_FAIL<br>message must contain a messag=
e that can be found in<br>the log output=2E OpenVPN must not start up succe=
ssfully,<br>so this does not allow to test for failures that only<br>affect=
 the traffic over the link=2E<br><br>This is based on work by Gert Doering =
for the t_server<br>test infrastructure=2E<br><br>Change-Id: I6c51bcdda5666=
e0dab2adcdaff28408c9bfcb844<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Esh=2Ein<br>1 file changed=
, 48 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/55/1755/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><br><spa=
n>index c3e98a8=2E=2E7b7f5de 100755</span><br><span>--- a/tests/t_client=2E=
sh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><span>@@ -=
320,6 +320,7 @@</span><br><span>     eval expect_ifconfig6=3D\&quot;\$EXPEC=
T_IFCONFIG6_$SUF\&quot;</span><br><span>     eval ping4_hosts=3D\&quot;\$PI=
NG4_HOSTS_$SUF\&quot;</span><br><span>     eval ping6_hosts=3D\&quot;\$PING=
6_HOSTS_$SUF\&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    eval expect_fail=3D\&quot;\$EXPECT_FAIL_$SUF\&quot;</span><br><span>   =
  eval fping_args=3D\&quot;\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\&quot;</spa=
n><br><span> </span><br><span>     # If EXCEPT_IFCONFIG* variables for this=
 test are missing, run an --up</span><br><span>@@ -331,6 +332,9 @@</span><b=
r><span>     fi</span><br><span> </span><br><span>     output_start &quot;#=
## test run $SUF: &#39;$test_run_title&#39; ###&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;$expect_fail&quot; ] ; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        output =
&quot;### expect failure: &#39;$expect_fail&#39;&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span>     fail_count=
=3D0</span><br><span> </span><br><span>     if [ -n &quot;$test_check_skip&=
quot; ]; then</span><br><span>@@ -377,23 +381,57 @@</span><br><span>     ov=
pn_init_success=3D0</span><br><span>     while [ $ovpn_init_check -gt 0 ];<=
/span><br><span>     do</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-       sleep 1  # Wait for OpenVPN to initialize and have had time to wri=
te the pid file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
 grep &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2E=
log &gt;/dev/null</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
   if [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-           ovpn_init_check=3D0</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-           ovpn_init_success=3D1</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-       fi</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-       ovpn_init_check=3D$(( $ovpn_init_check - 1 ))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        sleep 1  # Wait for Ope=
nVPN to initialize and have had time to write the pid file</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if [ -n &quot;$expect_fail&q=
uot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        then<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            grep &qu=
ot;$expect_fail&quot; $LOGDIR/$SUF:openvpn=2Elog # &gt;/dev/null</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if [ $? -eq 0 ]; t=
hen</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
ovpn_init_check=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                ovpn_init_success=3D1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                sleep 5         # give openvpn time to qu=
it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            fi</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            grep &quot;Initia=
lization Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if [ $? =
-eq 0 ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          ovpn_init_check=3D0</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                ovpn_init_success=3D1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            fi</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        ovpn_init_check=3D$(( $ovpn_init_check - 1 ))</span><=
br><span>     done</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    opid=3D`cat $pidfile`</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    opid=3D`[ -e $pidfile ] &amp;&amp; cat $pidfile`</=
span><br><span>     if [ -n &quot;$opid&quot; ]; then</span><br><span>     =
    output &quot;  OpenVPN running with PID $opid&quot;</span><br><span>   =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        output =
&quot;  Could not read OpenVPN PID file&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if [ -z &quot;$expect_fail&quot; ]       =
 # print this only if unexpected</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        then</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            output &quot;  Could not read OpenVPN PID file&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><sp=
an>     fi</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    # If OpenVPN did not start</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    # did we expect a failure?</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if [ -n &quot;$expect_fail&quot; ]</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if [ -n &quot;$opid&quot; ]   =
            # OpenVPN did start!</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        then</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            output &quot;$0: OpenVPN did start up, expected failure&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            $RU=
N_SUDO $KILL_EXEC $opid $sudopid</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            output &quot;tail -5 $SUF:openvpn=2Elog&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            output &quot=
;`tail -5 $LOGDIR/$SUF:openvpn=2Elog`&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            fail &quot;skip rest of sub-tests for t=
est run $SUF=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            trap - 0 1 2 3 15</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            exit_code=3D3=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            printf=
 &quot;$outbuf&quot; ; continue</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            output &quot;test run $SUF: all tests OK (saw expected fai=
lure)=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            continue</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # If Op=
enVPN did not start but should have</span><br><span>     if [ $ovpn_init_su=
ccess -ne 1 -o -z &quot;$opid&quot; ]; then</span><br><span>         output=
 &quot;$0:  OpenVPN did not initialize in a reasonable time&quot;</span><br=
><span>         if [ -n &quot;$opid&quot; ]; then</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1755?usp=3Demail">change 1755</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1755?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1755 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>

</body></html>
--89SIWoiHTPA=--


--===============4435928950998500425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4435928950998500425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4435928950998500425==--

