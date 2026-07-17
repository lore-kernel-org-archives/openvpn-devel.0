Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 618A0C44521
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6JHYQS4hUmfg66DBlR2rddUHwtrYthcGivHqxmxmm84=; b=JcfgRzoIFU+Mp3m67kzw2FM+CG
	XciVD1TzCaLQfo2QwduBKTsoTMiznzE5LFHoqgk4fnSdhvSvCx6D8QnmB7T49RU5DZem8NhuBN+MG
	ZlM+37BwEhTW063A0B23AIy5JhoK9sruWitGp9GgbwHHGDM+7e+ZK3bjHP1lZ3z9J194=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkhUZ-00005l-8a;
	Fri, 17 Jul 2026 12:16:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkhUX-00005e-Kg
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:16:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AmCZjrh8ShixvPnYtiBsmLtvFgcSSPQgU/GtjJJUoOs=; b=Imj2SAdrL6oH4q44uDaUXTy32j
 S7IObxjGqeEA797SJXP5LiFTFQq14/PSVRb1a+Z01q8OBSXVXpH4iWdDraW5KHZVktJKUPJGECiDN
 47sqnKthT+vGXoMvnWiLquxXN6RDPdSVn6v9JMkBWx5SMvoVNBNrcjEd0YZHa63uOOz4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AmCZjrh8ShixvPnYtiBsmLtvFgcSSPQgU/GtjJJUoOs=; b=C
 T8ZnzntQenDMvRLwJFv2aQl4HFGmMfgyJn13P/YbEtqhPWLdP9BY9o02WP4laHBUFCVlTAQ9iVIrJ
 +1CLePHJC+7o3rqPAV1STjebca7M1qv10s2VPFpU8QSQTEJWST2wlxq6YLFeJeffGqEJueALZDPZp
 kn5jzlo+lITQvf1g=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkhUW-0007N6-3m for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 12:16:33 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47d70879764so5576194f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 05:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784290580; x=1784895380; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AmCZjrh8ShixvPnYtiBsmLtvFgcSSPQgU/GtjJJUoOs=;
 b=DNkAellERM/RprKdG3QT6ArHl3MIFjS64VdoJkmfX2uDzn095GYagsAqB0cJKqHKNy
 U+rdu+zxHIKUpV+F1kbqflhUxyvJJsHTMjK7w115M11/0JhyVFMWWA/17oy9+VzQPKcP
 6fjbTRPGAmOeYSczNJ35e5v/gfCPK4Fw6W1AiXx3SYLrIx9gGH2GYi5DETsdOYj0OiWG
 nkqTfLKr6c8Uk82tOmaa8AZmesmfh80mHRQeSztr5SXekjA5CfDsxTZEpMXt3KF/9TA7
 HHvOtyClJk+3rGOWErOTY7+z+OEkEHAIbrKS7Yn+63rHTUWtfhpbjW/cbY4Jjw+14kEY
 7QVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784290580; x=1784895380;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AmCZjrh8ShixvPnYtiBsmLtvFgcSSPQgU/GtjJJUoOs=;
 b=k0zYmwWOsmeR0vKQWm7D9e+PCred4ysONIrMrfGIKtiwagJh99bXOCy3CVDIlHzQbp
 /nVFrzOGgYVDXG7xEw9n/AEFasvkHRe8+DEGgoFz/qNuEImQ1rSB/em9toQxa7suxBj2
 eEobsQ1HqlxrEmXYZjZZQkhlbYyAAztQ5HTRJ3SoCL5/jBunjGF8GNKb8WN6X9SnNiBL
 mAlYi0TmOquGIkRFfylgnikDRuET82kzBmH56X9FbYOm8OkaiX2gVodnlC5BBjqmAw6M
 //FgpoD8yPFX845HuVNGV9rQRpROzwAe5ZIm+6XSLdKJnx7U+lvIX7a1FVxHpVP7tk3G
 myug==
X-Gm-Message-State: AOJu0YzbblP1G1jWljdQNt78W1GrMdodQppxpcZG2n313UCL3zWq1kTD
 dAw6PSSNqqhtcMr9LJWW1NDZaR2/D7gsNeJpmS7cAQ9cCcESQHkKYJD96c3/FD3Rr0ocDVNdhht
 iSCMaRawZwJUd0sIR/a3SQck13WfD8NCnLWJK0zeeK9Uza/Ha+HA470z3brzQnwU43kg2
X-Gm-Gg: AfdE7cnKpYq2mVXm1pnPYjxMpw6mrnnUESEvIQpu14+DJZelZXFsgl87D9V/86TAkbp
 gNxZDl412WpbaNQGlGRYJAb4bwm5sghGsT/FRDmqWCP/twpqEg0gt+rdzqunWkI/22jAeTLZNuX
 wmNcW05iJ5yJWGRpKC44WhjAOQDsGqtaJtQ7aP3yLwAGDZg7Fbm0rhd7cbBDEjTHyOUr8v601FP
 NaU3VUov9MBJEy7FXAHuTOIAsHBJ8NJK2IFhV1GLPygMUzYoi/pS/Afh+Sr7X7DPHrv1NNjywfq
 Ffjg6jki/G8Ihqg/whHFpabbLJi7ji8QNfqwJzpvJOrYyKCDVjnmaf57cIu/MPmFgFd+ukf4D3L
 lSAaTEMwuwoXZb4bc1JTdAc7l3iqSFQr1cv/ig6QHOZRXHmrzq+1od1AEOEHSAZB4HCxlbY2DWq
 1nMRBT/XaD10MuhgokDyev6ehDB0DQ+RvwCmxAU31Xkl+F8hpvaPCom+xgkMMFAB9Awyb3S25MB
 Z+FpvGXkzu6MAw3Qr3KPeQVy0JCTJE5pWXxR4CqOky5Hu7rxmJvgfxia7dVYRCUkt4Z
X-Received: by 2002:a05:600c:3b03:b0:493:e52f:6ee1 with SMTP id
 5b1f17b1804b1-4954a38d27bmr25713145e9.0.1784290580115; 
 Fri, 17 Jul 2026 05:16:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b074csm45153765e9.6.2026.07.17.05.16.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 05:16:19 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 12:16:13 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: 0e63d0f06ae3b11cc8dd99eaa74ccc3a426f6dfe
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <99b4a69b85078e3b13c6f32c39861e08b4103e84-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkhUW-0007N6-3m
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
Content-Type: multipart/mixed; boundary="===============0874652637172640520=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0874652637172640520==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3U5oNzqAeZA="; charset=UTF-8

--3U5oNzqAeZA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1755?usp=3Demail

to look at the new patch set (#3)=2E

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
M tests/t_client=2Erc-s=
ample
M tests/t_client=2Esh=2Ein
2 files changed, 49 insertions(+), 10 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/55/1755/3

diff --git a/tests/t_client=2Erc-sample b/tests/t_client=2Erc=
-sample
index d61ecc4=2E=2E2a4bdb4 100644
--- a/tests/t_client=2Erc-sample
=
+++ b/tests/t_client=2Erc-sample
@@ -61,6 +61,7 @@
 # EXPECT_IFCONFIG6_x =
=3D "this IPv6 address needs to show up in ifconfig"
 # PING4_HOSTS_x      =
=3D "these hosts musts ping when openvpn is up (IPv4 fping)"
 # PING6_HOSTS=
_x      =3D "these hosts musts ping when openvpn is up (IPv6 fping6)"
+# EX=
PECT_FAIL_x      =3D "instead of waiting for connection wait for this error=
 message"
 #
 # hook test options:
 #
diff --git a/tests/t_client=2Esh=2Ein=
 b/tests/t_client=2Esh=2Ein
index 0254c0c3=2E=2E0ef2ec5 100755
--- a/tests/=
t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -320,6 +320,7 @@
     =
eval expect_ifconfig6=3D\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_hosts=
=3D\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=3D\"\$PING6_HOSTS_$SUF\"
+ =
   eval expect_fail=3D\"\$EXPECT_FAIL_$SUF\"
     eval fping_args=3D\"\$FPI=
NG_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG* variables fo=
r this test are missing, run an --up
@@ -331,6 +332,9 @@
     fi
 
     out=
put_start "### test run $SUF: '$test_run_title' ###"
+    if [ -n "$expect_=
fail" ] ; then
+        output "### expect failure: '$expect_fail'";
+    f=
i
     fail_count=3D0
 
     if [ -n "$test_check_skip" ]; then
@@ -377,23 =
+381,57 @@
     ovpn_init_success=3D0
     while [ $ovpn_init_check -gt 0 ]=
;
     do
-       sleep 1  # Wait for OpenVPN to initialize and have had ti=
me to write the pid file
-       grep "Initialization Sequence Completed" $=
LOGDIR/$SUF:openvpn=2Elog >/dev/null
-       if [ $? -eq 0 ]; then
-       =
    ovpn_init_check=3D0
-           ovpn_init_success=3D1
-       fi
-     =
  ovpn_init_check=3D$(( $ovpn_init_check - 1 ))
+        sleep 1  # Wait fo=
r OpenVPN to initialize and have had time to write the pid file
+        if=
 [ -n "$expect_fail" ]
+        then
+            grep "$expect_fail" $LOGD=
IR/$SUF:openvpn=2Elog # >/dev/null
+            if [ $? -eq 0 ]; then
+    =
            ovpn_init_check=3D0
+                ovpn_init_success=3D1
+   =
             sleep 5         # give openvpn time to quit
+            fi
+ =
       else
+            grep "Initialization Sequence Completed" $LOGDIR/$=
SUF:openvpn=2Elog >/dev/null
+            if [ $? -eq 0 ]; then
+          =
      ovpn_init_check=3D0
+                ovpn_init_success=3D1
+         =
   fi
+        fi
+        ovpn_init_check=3D$(( $ovpn_init_check - 1 ))
  =
   done
 
-    opid=3D`cat $pidfile`
+    opid=3D`[ -e $pidfile ] && cat $p=
idfile`
     if [ -n "$opid" ]; then
         output "  OpenVPN running wit=
h PID $opid"
     else
-        output "  Could not read OpenVPN PID file"
=
+        if [ -z "$expect_fail" ]        # print this only if unexpected
+ =
       then
+            output "  Could not read OpenVPN PID file"
+      =
  fi
     fi
 
-    # If OpenVPN did not start
+    # did we expect a failu=
re?
+    if [ -n "$expect_fail" ]
+    then
+        if [ -n "$opid" ]     =
          # OpenVPN did start!
+        then
+            output "$0: OpenV=
PN did start up, expected failure"
+            $RUN_SUDO $KILL_EXEC $opid =
$sudopid
+            output "tail -5 $SUF:openvpn=2Elog"
+            outp=
ut "`tail -5 $LOGDIR/$SUF:openvpn=2Elog`"
+            fail "skip rest of s=
ub-tests for test run $SUF=2E"
+            trap - 0 1 2 3 15
+            =
SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D32
+          =
  printf "$outbuf" ; continue
+        else
+            output "test run $=
SUF: all tests OK (saw expected failure)=2E"
+            SUMMARY_OK=3D"$SU=
MMARY_OK $SUF"
+            continue
+        fi
+    fi
+
+    # If OpenVP=
N did not start but should have
     if [ $ovpn_init_success -ne 1 -o -z "$=
opid" ]; then
         output "$0:  OpenVPN did not initialize in a reasona=
ble time"
         if [ -n "$opid" ]; then

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
Gerrit-=
Change-Number: 1755
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--3U5oNzqAeZA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #3</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1755?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">t_=
client=2Esh=2Ein: Add support for expected test failures<br><br>Allow to ma=
rk tests that must fail=2E The EXPECT_FAIL<br>message must contain a messag=
e that can be found in<br>the log output=2E OpenVPN must not start up succe=
ssfully,<br>so this does not allow to test for failures that only<br>affect=
 the traffic over the link=2E<br><br>This is based on work by Gert Doering =
for the t_server<br>test infrastructure=2E<br><br>Change-Id: I6c51bcdda5666=
e0dab2adcdaff28408c9bfcb844<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>---<br>M tests/t_client=2Erc-sample<br>M tests/t_cl=
ient=2Esh=2Ein<br>2 files changed, 49 insertions(+), 10 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/55/1755/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/tests/t_client=2Erc-sample b/test=
s/t_client=2Erc-sample</span><br><span>index d61ecc4=2E=2E2a4bdb4 100644</s=
pan><br><span>--- a/tests/t_client=2Erc-sample</span><br><span>+++ b/tests/=
t_client=2Erc-sample</span><br><span>@@ -61,6 +61,7 @@</span><br><span> # E=
XPECT_IFCONFIG6_x =3D &quot;this IPv6 address needs to show up in ifconfig&=
quot;</span><br><span> # PING4_HOSTS_x      =3D &quot;these hosts musts pin=
g when openvpn is up (IPv4 fping)&quot;</span><br><span> # PING6_HOSTS_x   =
   =3D &quot;these hosts musts ping when openvpn is up (IPv6 fping6)&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# EXPECT_FAIL_x     =
 =3D &quot;instead of waiting for connection wait for this error message&qu=
ot;</span><br><span> #</span><br><span> # hook test options:</span><br><spa=
n> #</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=
=2Esh=2Ein</span><br><span>index 0254c0c3=2E=2E0ef2ec5 100755</span><br><sp=
an>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=
=2Ein</span><br><span>@@ -320,6 +320,7 @@</span><br><span>     eval expect_=
ifconfig6=3D\&quot;\$EXPECT_IFCONFIG6_$SUF\&quot;</span><br><span>     eval=
 ping4_hosts=3D\&quot;\$PING4_HOSTS_$SUF\&quot;</span><br><span>     eval p=
ing6_hosts=3D\&quot;\$PING6_HOSTS_$SUF\&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    eval expect_fail=3D\&quot;\$EXPECT_FAIL_$SUF\=
&quot;</span><br><span>     eval fping_args=3D\&quot;\$FPING_EXTRA_ARGS \$F=
PING_ARGS_$SUF\&quot;</span><br><span> </span><br><span>     # If EXCEPT_IF=
CONFIG* variables for this test are missing, run an --up</span><br><span>@@=
 -331,6 +332,9 @@</span><br><span>     fi</span><br><span> </span><br><span=
>     output_start &quot;### test run $SUF: &#39;$test_run_title&#39; ###&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &qu=
ot;$expect_fail&quot; ] ; then</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        output &quot;### expect failure: &#39;$expect_fail&#39;&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span>=
<br><span>     fail_count=3D0</span><br><span> </span><br><span>     if [ -=
n &quot;$test_check_skip&quot; ]; then</span><br><span>@@ -377,23 +381,57 @=
@</span><br><span>     ovpn_init_success=3D0</span><br><span>     while [ $=
ovpn_init_check -gt 0 ];</span><br><span>     do</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-       sleep 1  # Wait for OpenVPN to initialize=
 and have had time to write the pid file</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-       grep &quot;Initialization Sequence Completed&quot=
; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-       if [ $? -eq 0 ]; then</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-           ovpn_init_check=3D0</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-           ovpn_init_success=3D1</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-       fi</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-       ovpn_init_check=3D$(( $ovpn_init=
_check - 1 ))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  sleep 1  # Wait for OpenVPN to initialize and have had time to write the =
pid file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
[ -n &quot;$expect_fail&quot; ]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        then</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            grep &quot;$expect_fail&quot; $LOGDIR/$SUF:openvpn=2Elog #=
 &gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                ovpn_init_check=3D0</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ovpn_init_success=3D1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                sleep 5         =
# give openvpn time to quit</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            fi</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        grep &quot;Initialization Sequence Completed&quot; $LOGDIR/$SUF:ope=
nvpn=2Elog &gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if [ $? -eq 0 ]; then</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                ovpn_init_check=3D0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_success=3D1</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            fi</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        ovpn_init_check=3D$(( $ovpn_=
init_check - 1 ))</span><br><span>     done</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    opid=3D`cat $pidfile`</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    opid=3D`[ -e $pidfile ] &=
amp;&amp; cat $pidfile`</span><br><span>     if [ -n &quot;$opid&quot; ]; t=
hen</span><br><span>         output &quot;  OpenVPN running with PID $opid&=
quot;</span><br><span>     else</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        output &quot;  Could not read OpenVPN PID file&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ -z &quot;$e=
xpect_fail&quot; ]        # print this only if unexpected</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            output &quot;  Could not read Op=
enVPN PID file&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        fi</span><br><span>     fi</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    # If OpenVPN did not start</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    # did we expect a failure?</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;$ex=
pect_fail&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if [ =
-n &quot;$opid&quot; ]               # OpenVPN did start!</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            output &quot;$0: OpenVPN did sta=
rt up, expected failure&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            $RUN_SUDO $KILL_EXEC $opid $sudopid</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            output &quot;tail -5 $SUF=
:openvpn=2Elog&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            output &quot;`tail -5 $LOGDIR/$SUF:openvpn=2Elog`&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            fail &quot;ski=
p rest of sub-tests for test run $SUF=2E&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            trap - 0 1 2 3 15</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            SUMMARY_FAIL=3D&quot;$SUMM=
ARY_FAIL $SUF&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            exit_code=3D32</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            printf &quot;$outbuf&quot; ; continue</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            output &quot;test run $SUF: all t=
ests OK (saw expected failure)=2E&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            SUMMARY_OK=3D&quot;$SUMMARY_OK $SUF&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            continue<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fi</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    # If OpenVPN did not start but should have</span><br><sp=
an>     if [ $ovpn_init_success -ne 1 -o -z &quot;$opid&quot; ]; then</span=
><br><span>         output &quot;$0:  OpenVPN did not initialize in a reaso=
nable time&quot;</span><br><span>         if [ -n &quot;$opid&quot; ]; then=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail">change 1755</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c51bcdda5666e0d=
ab2adcdaff28408c9bfcb844 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1755 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
=
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>

</body></html>
--3U5oNzqAeZA=--


--===============0874652637172640520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0874652637172640520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0874652637172640520==--

