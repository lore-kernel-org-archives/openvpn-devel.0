Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EACC5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LJYSodd3SMGj9LwYIjVYHHVO26Nz9rqElyn32FYvNTU=; b=ZvHJfsI507eNrstW0tP2Jw7Lb0
	UQeKlqjP/GifGj4Y+LaMLshmqNadiTwnwy1zjKR9iBvE+BXNG963+RhQS+HjdhTqpthQpUsKnEFT2
	pVWtYlqfM7Qjl8zZYegK7wGnH3REluTL6VlayA2MDPp5k0rTQmnALnzASMlUWtzmmtP8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWGg-0001YO-9L;
	Mon, 24 Aug 2026 15:07:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWGN-0001Xp-E1
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=yoAJf/Lx2yi/y0ErNWcrmdOJ1l1yPHbMts3q+jFXQdw=; b=QL5UHB1u0GBHqHIQgufQe9emR+
 cznmsn63LmTiL8URiru8SCLTztPHCpGqFgfOFHUqo4+Odsnecg/gGxG3Ie8eB0ICfDnvEpHKFXZoX
 CeLfVVNGKz/7Nrm4b9pXSN4tot0FxidL07/BZJ0IxpXZPacjHJbECzC2MnXfvFR7d6IY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yoAJf/Lx2yi/y0ErNWcrmdOJ1l1yPHbMts3q+jFXQdw=; b=P
 1Hvy+wpr08oO7KYJ8/clYrzNBQMgUm0a8c9MScCwc7u1h7EdQk7cx7z8WytgcBqMYO5uMaVDTBHqX
 l3B4UZ16OreEspresVwVujoulZNSMziZdjqzaH/TpAxc7JJwxEGP+TglDSbpSDBlG2JpnUHbczRGi
 E5IIMOVP1YLxkJZ8=;
Received: from mail-ej1-f44.google.com ([209.85.218.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWGD-0004DN-3O for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:06:56 +0000
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so538487866b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787584006; x=1788188806; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yoAJf/Lx2yi/y0ErNWcrmdOJ1l1yPHbMts3q+jFXQdw=;
 b=FC6y+PFCRwK4N+5abIMGCMV1wpj7QE1QIW8MOu4SVHfuIUUel5/ZIUDSrI5KVoqJb3
 rPJlnHfnVO3euPARnu0KwrCrMNfgVSt5qIY47MIj0flGe+NQbN1sb2bPCfdz29txfRsE
 NDusn4uubMOBeCL0BsVTsNhWYt9mjLDErmQ3RaBjll51WirQrvqxLi6q/VYdBYEgaIyd
 sswq11tHo+XbcXc6aum90b6X16QI7HnucPaN6P4+gemt5I16QbqLdKImUgTRpeft5xnB
 WlUgVxXpUMcdALvTjZMCc/3ewmOFPgS5Hhuf6yEl/JQZ36n9kh72U7uygiunOKp7akvX
 wkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787584006; x=1788188806;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yoAJf/Lx2yi/y0ErNWcrmdOJ1l1yPHbMts3q+jFXQdw=;
 b=O1Dsw146s4wbByFQQuJb2cY2G4709no/L4Hh5sLz0wqiwiKlRw4pNYeFyhF7Qq43zh
 ruGd8bTXtof1H3LeVUJFBhUnwSSF2QwHxUfPR197+psYAoCDfCkHeImjjnLYqil7Wzu7
 J/TpALurYbz3BK51SEoiERQ1/bYAzbSCx5qcp61TWrxDAxgkjvWBrVV5UWPVSipPJYJc
 /2yK9Fbj2xeVTBzf314SSpJzO8B+jZQqcuaF4JLlAQXwpbdfa7opPdOSsgE0+c2sEqF5
 S6wlfiXy0HkUOOEJoC1jDsxubb/mt4DHsguKMubA2ON+e5fR3m1Nh/KBX3PhHeYsxcOM
 IzpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrL3dB61ZoIdKB8n2S9nvMS/gmJzhpGj4anxSbFtVeEPgtCRtBfhbTZ6Hg9bPb3NjEmd36ZHO4SLl+koC5g@lists.sourceforge.net
X-Gm-Message-State: AFuF++nG/ynWXD4Ai2Ss2fRu03FphV5HjVJJKFEwO9ZEMMzeO+8nYNpA
 a5JMgyTwB568V5oP+hrMDUwYyvtkBdH9YzFXUaKft4VI68ujT6qLpEY1m/eDYSv/VvJybiUh8/4
 cBrt/0o2/G7qCcgVeJKi1nr07sU8IBxUJF7HlVYOWodPNdRFChMLKxm73GgnMb2xbbHzy
X-Gm-Gg: AR+sD11RuipSttcubOvNFC4+xSBuOuJDIwHykMhk1Dd+Z7c8/K6QoiivZPVggYPvbyh
 hBDv80BaLijbWO2j6KwDWDrEZQSt9KIFbadihQ+ey5RP/zUlUxIMyB7polQuFBLMtXqKi2HzcWU
 n4QqrVZVR8eLsR3DmyCNCc6gAU3yaDcs1a79ejams5tjwwC/6yz1/ERr4MAp0QWRSi0KdX7AQH3
 rm3mIXXAgzNvQAmVwcoNP+SZjtKKRL93AgIREAGOJPVtrRGa3rVuKRyZW4obTli0spQmGka2ywr
 tILt0oJPe1ampDkFOP0UY9/yPLzZEIRe5EMouryA70fIfTiQdfX7PcPIV+/YfjxgLuDkrqpogYl
 /zdKOhDYlm/f/u6tgVDeM4rSvUjOndOZzz2TYmLmmcSjiXD4nZjeGQhxKd2STNeTPtagz7rP9wO
 mj4R9bYVC8pA/e0ZLTE3BWzIEAXcH1pynoRWtSq1dTi9P09ASlf6xH+NzwX63tJSrZ4HMomtGen
 IAC4sjXU6c3FcvmzQQ9r3X6fLtUebL2GQsGlouldWsxvPWksTaNW8LHKlzhOvkqDyUXtfhb8PL5
 WXL8X0DVIGQwJkE4dduwzszH8yHjWT5ViAnSbzwh6PurANwgtaY=
X-Received: by 2002:a17:907:a892:b0:c16:5cf0:3aff with SMTP id
 a640c23a62f3a-c246a62afb5mr2802685666b.18.1787584005872; 
 Mon, 24 Aug 2026 08:06:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa97sm1151308366b.57.2026.08.24.08.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:06:45 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:06:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
X-Gerrit-Change-Number: 1755
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1755?usp=email>
X-Gerrit-Commit: dd802941cbc6510419980a46e8a8b7df8ade9a66
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzQxMzc3MDAwLkk2YzUxYmNkZGE1NjY2ZTBkYWIyYWRjZGFmZjI4NDA4YzliZmNiODQ0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2c93a62da95e7981e81b69537334d9265260aff-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWGD-0004DN-3O
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
Content-Type: multipart/mixed; boundary="===============9068929915356915489=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9068929915356915489==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ejBGuwd7dek="; charset=UTF-8

--ejBGuwd7dek=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, 

I'd like you to reexamine a change=2E Please visit

    http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail

to look at the new patch=
 set (#4)=2E


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
2 files changed, 43 insertions(+=
), 7 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn r=
efs/changes/55/1755/4

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
index 230a273=2E=2Ecaba242 100755
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
@@ -381,2=
2 +385,53 @@
     ovpn_init_success=3D0
     while [ $ovpn_init_check -gt 0=
 ]; do
         sleep 1 # Wait for OpenVPN to initialize and have had time =
to write the pid file
-        grep "Initialization Sequence Completed" $LO=
GDIR/$SUF:openvpn=2Elog >/dev/null
-        if [ $? -eq 0 ]; then
-        =
    ovpn_init_check=3D0
-            ovpn_init_success=3D1
+        if [ -n=
 "$expect_fail" ]; then
+            grep "$expect_fail" $LOGDIR/$SUF:openv=
pn=2Elog # >/dev/null
+            if [ $? -eq 0 ]; then
+                o=
vpn_init_check=3D0
+                ovpn_init_success=3D1
+                =
sleep 5 # give openvpn time to quit
+            fi
+        else
+        =
    grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn=2Elog >/d=
ev/null
+            if [ $? -eq 0 ]; then
+                ovpn_init_check=
=3D0
+                ovpn_init_success=3D1
+            fi
         fi
   =
      ovpn_init_check=3D$((ovpn_init_check - 1))
     done
 
-    opid=3D$(=
cat $pidfile)
+    opid=3D$([ -e $pidfile ] && cat $pidfile)
     if [ -n "=
$opid" ]; then
         output "  OpenVPN running with PID $opid"
     else=

-        output "  Could not read OpenVPN PID file"
+        if [ -z "$exp=
ect_fail" ]; then # print this only if unexpected
+            output "  Co=
uld not read OpenVPN PID file"
+        fi
     fi
 
-    # If OpenVPN did =
not start
+    # did we expect a failure?
+    if [ -n "$expect_fail" ]; th=
en
+        if [ -n "$opid" ]; then # OpenVPN did start!
+            outpu=
t "$0: OpenVPN did start up, expected failure"
+            $RUN_SUDO $KILL=
_EXEC $opid $sudopid
+            output "tail -5 $SUF:openvpn=2Elog"
+    =
        output "$(tail -5 $LOGDIR/$SUF:openvpn=2Elog)"
+            fail "s=
kip rest of sub-tests for test run $SUF=2E"
+            trap - 0 1 2 3 15
=
+            SUMMARY_FAIL=3D"$SUMMARY_FAIL $SUF"
+            exit_code=3D3=
2
+            printf "$outbuf"
+            continue
+        else
+      =
      output "test run $SUF: all tests OK (saw expected failure)=2E"
+     =
       SUMMARY_OK=3D"$SUMMARY_OK $SUF"
+            continue
+        fi
+ =
   fi
+
+    # If OpenVPN did not start but should have
     if [ $ovpn_ini=
t_success -ne 1 -o -z "$opid" ]; then
         output "$0:  OpenVPN did not=
 initialize in a reasonable time"
         if [ -n "$opid" ]; then

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1755?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c51bcdda5666e0dab2adcda=
ff28408c9bfcb844
Gerrit-Change-Number: 1755
Gerrit-PatchSet: 4
Gerrit-Owner=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fran=
k@lichtenheld=2Ecom>

--ejBGuwd7dek=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http:/=
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
r>M tests/t_client=2Esh=2Ein<br>2 files changed, 43 insertions(+), 7 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/55/1755/4</pre><pre style=3D"font-family: monospace=
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
ests/t_client=2Esh=2Ein</span><br><span>index 230a273=2E=2Ecaba242 100755</=
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
    if [ -n &quot;$test_check_skip&quot; ]; then</span><br><span>@@ -381,22=
 +385,53 @@</span><br><span>     ovpn_init_success=3D0</span><br><span>    =
 while [ $ovpn_init_check -gt 0 ]; do</span><br><span>         sleep 1 # Wa=
it for OpenVPN to initialize and have had time to write the pid file</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        grep &quot;Initializ=
ation Sequence Completed&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if [ $? -eq 0 ]; =
then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ovpn_=
init_check=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     ovpn_init_success=3D1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if [ -n &quot;$expect_fail&quot; ]; then</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            grep &quot;$expect_fail&quo=
t; $LOGDIR/$SUF:openvpn=2Elog # &gt;/dev/null</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if [ $? -eq 0 ]; then</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_check=3D0=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ovp=
n_init_success=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               sleep 5 # give openvpn time to quit</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            fi</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            grep &quot;Initialization Sequence Completed=
&quot; $LOGDIR/$SUF:openvpn=2Elog &gt;/dev/null</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if [ $? -eq 0 ]; then</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                ovpn_init_check=
=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 ovpn_init_success=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            fi</span><br><span>         fi</span><br><span>         ovpn=
_init_check=3D$((ovpn_init_check - 1))</span><br><span>     done</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    opid=3D$(c=
at $pidfile)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    opi=
d=3D$([ -e $pidfile ] &amp;&amp; cat $pidfile)</span><br><span>     if [ -n=
 &quot;$opid&quot; ]; then</span><br><span>         output &quot;  OpenVPN =
running with PID $opid&quot;</span><br><span>     else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        output &quot;  Could not read Open=
VPN PID file&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if [ -z &quot;$expect_fail&quot; ]; then # print this only if unexpe=
cted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            out=
put &quot;  Could not read OpenVPN PID file&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        fi</span><br><span>     fi</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # If OpenV=
PN did not start</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 # did we expect a failure?</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if [ -n &quot;$expect_fail&quot; ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if [ -n &quot;$opid&quot; ]; then=
 # OpenVPN did start!</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            output &quot;$0: OpenVPN did start up, expected failure&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            $RUN_SU=
DO $KILL_EXEC $opid $sudopid</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            output &quot;tail -5 $SUF:openvpn=2Elog&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            output &quot;$(t=
ail -5 $LOGDIR/$SUF:openvpn=2Elog)&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            fail &quot;skip rest of sub-tests for test=
 run $SUF=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           trap - 0 1 2 3 15</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            SUMMARY_FAIL=3D&quot;$SUMMARY_FAIL $SUF&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            exit_code=3D32</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            printf &q=
uot;$outbuf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          continue</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    output &quot;test run $SUF: all tests OK (saw expected failure)=2E&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            SUMMAR=
Y_OK=3D&quot;$SUMMARY_OK $SUF&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            continue</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        fi</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    # If OpenVPN did not=
 start but should have</span><br><span>     if [ $ovpn_init_success -ne 1 -=
o -z &quot;$opid&quot; ]; then</span><br><span>         output &quot;$0:  O=
penVPN did not initialize in a reasonable time&quot;</span><br><span>      =
   if [ -n &quot;$opid&quot; ]; then</span><br><span></span><br></pre><p>To=
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
lay:none"> Gerrit-PatchSet: 4 </div>
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
--ejBGuwd7dek=--


--===============9068929915356915489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9068929915356915489==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9068929915356915489==--

