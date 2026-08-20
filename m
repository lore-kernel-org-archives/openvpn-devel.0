Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC7A2C5DF87
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3vunUQDJ6MGj7mPjm7t7w5GN23rcq9rGyutJ1mEgUo=; b=asyoaWNeo7gCdwtp1hbA3NVOU+
	zoYnAVdz1idvHmT2peJORENEAn1AFE0OaO/FW8OS53yzD9/wORPjj+5dpdtNAcJnZILmbWIwMt5Ed
	UCkVg4H/XkOO3LCEF+UAT0mCF4Sui7uvDikt0SCQ90lXhkJ3HLif2nsCLmnRLgOtn8F4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx0Sn-0005Nk-Dt;
	Thu, 20 Aug 2026 10:57:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx0SV-0005Mt-H4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:57:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AuwXZe9vuMuZtSmjTbaqjJv8nOq5gkoqulPlEjCTem4=; b=O02XsnxLxkozah8SUndXi6yZAA
 zx7/APAzdyYohG/vlwEAv2uSZPhzdci9F2GUx78iAKk3cPAWNWSlK1Q9SGv83a+XGrSOGRWp//Bk9
 IzD9Y3T7aaDofv3SMduS7hc+56ClquDR2fXWjP/KnmtTk56EhvhSLu3JWtTnbCxEBh34=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AuwXZe9vuMuZtSmjTbaqjJv8nOq5gkoqulPlEjCTem4=; b=K
 0/1mSnoR2kFFMPQenCq5iX148BvprHwBB+gDPET9lMs/QEXC5dB12BkXKrsHW56RAosBQq23SaOzt
 rakvdyIp82roZlarY2mSewOUsh5J9z0jXJoK0qjPaV+BwagklyKD+vO8M5RwLCguUjCTCxQhK8JFP
 aaF0jn2Ip/QT56eg=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx0SS-0006On-4e for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:57:16 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4798bea72f9so1203662f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787223429; x=1787828229; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AuwXZe9vuMuZtSmjTbaqjJv8nOq5gkoqulPlEjCTem4=;
 b=Of/8sw4/Q35s8e8/k+kRqultu15fYQEuuxQG+Oa4AI+9YrhqCpK9DPc8rNdrTQYki/
 uhxXzj51830AnpcdZyWR4bA9u+jVUyWfz6QQ51IEOhhYzPARDO1KP5g/EF1+yIIkfzKQ
 m9evWBj4nmOk1QGnJqFkn2Kh9BmtiPZpd6cnc+pv6GrkJ8rdhSloGmIRCQXPgL8PQOjJ
 VR9VG25RiNXcwkvD0t2Aj/N2cYg40Wvfc7MJD69RiyTjLst09jL4x5H2CX4oDA0rDNuV
 t7M+kerfyBlmSPnZZVOGTz8Ahi89S4Hd5MyDtlzED06JcZfswvUEPqABJiqjmVM2vE7H
 rjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223429; x=1787828229;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AuwXZe9vuMuZtSmjTbaqjJv8nOq5gkoqulPlEjCTem4=;
 b=jTO44QPZHeejt6RWwwKrNcmK30QbhL25yswB5vYQZk7l2Xef6JIepWELFt9/+WuD5x
 cwLrRNkV5C+ZqjmVTVhg+YniSlxzLUXI7lUg4vxDM80ZoqvlZHAB34KzDLYhUARSTUwi
 IGpEhUsj46i+72MwYTEwN+WysSKStA39zN31boOcSC5fi+v7Rw7mCMKqVAtDcgd9tN/2
 msSkMdp/h1q2NlIsha+aa8m2EtBDHeTRtt0ZksqBJNaA4arFBdcWAqo1RdPXh2g/dr2E
 iOrbgF+mx9VXw8rCR8fFg62Gj4AHO0edBoAwJNaqnbyJ43toqjlqg4Eocid2u0FHG59Q
 bHwQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrVEPldiFdUS1329SxZLD+GXnRv77ofTXRLTXVVDIy93HUD52lOTBnH/5QcJYBFnfvA/3knZfzh7xsSKlax@lists.sourceforge.net
X-Gm-Message-State: AFuF++mTJciTZgvebXBWjL/echtNku9sMUMRfAUhuVphiUz6EIIoZnTG
 VFwfnpJTQLuDjEQw4Z5+AX8G2DjWx2Q3kXjmQApCa4fuX5xeELKy1b6O+Dp6yjyEywN1+SqjY5z
 rMrmT+zDqhNi4b4HTM/FCiPkDakGJTa622n+YOdxScUbCk5CWHMLRR6mlCx3hO4y+7Kv/
X-Gm-Gg: AR+sD137/UB7jo62iaU1Yg7GPsJqV9cDoEVZJN2XqjrDY9QOWL0vmNr49bJT7itBycX
 CxsJchS5Fo+NxRbp4yvX68eUaim1Yrh7vWrzKidClR2hUXUrupMBq/4+edY+XVNCvjIjwiamA55
 YjzV46heP5twYMefC9K6HBYwO1nTlY99R7cqiwV9wwHh1fxGPVdVFKaLo7OINqAJJtr3+ilKwge
 wg76+zfiQz8zH43YaV/iG0Urt6aosT0TEfqVrdpipC5HqtSfG1JlQUgVcBxgizt4zylKFljf3mP
 lFCe8RKZBMgyKvLz44P1HmCYZDrYCmgPyuL5XwgeougG1MmMiIyaaz0YQxqcZFnxwku06QvzIaU
 dBL2AROYySJj6v9GhmaGuNy69wDm5M0NBBeKdK6L6U3rn/kaF6wFUa3G37K08omqWNvLkvdECSF
 UxsoKysNHOnfuGqsxDfVOI41S3oX5sSrPfSp+NnhYlrZjc36W+wL2TQN+2UafAbA7GE23y/G3XD
 sXAIWIIOh3H6OE5j66ytJ7Es2Wchqh2c43psj9yIT1F5lgcTWpQ5xuVMD//dEt3f9u+kMXqkG7n
 KleoTaNmrVm/tsrgWrTPsxo2YPZDPLdU+3JeE9TtR2YdNI0rroQ=
X-Received: by 2002:a05:6000:4201:b0:481:4697:a6b0 with SMTP id
 ffacd0b85a97d-482b20032c6mr19027159f8f.20.1787223429387; 
 Thu, 20 Aug 2026 03:57:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b1450e61sm12600008f8f.13.2026.08.20.03.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:57:08 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 10:57:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
X-Gerrit-Change-Number: 1794
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1794?usp=email>
X-Gerrit-Commit: ed427eab1683af3adf21553dd1c6b6e4b8b2f10d
In-Reply-To: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
References: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLklkNGQwNGJlYmRiOGIyY2I1NmU4ZGQxNmEzODZjNDFmZGI5NWMwNDEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c70e55474581215fd9ce92aebe37445ce2f1328-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx0SS-0006On-4e
Subject: [Openvpn-devel] [S] Change in openvpn[master]: reformat-shell.sh:
 Add --simplify argument
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
Content-Type: multipart/mixed; boundary="===============1459640701640083426=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1459640701640083426==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cUQK6WFmy+Q="; charset=UTF-8

--cUQK6WFmy+Q=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1794?usp=3Demail )

Change subject: reformat-shell=2Esh: Add --simplify=
 argument
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

r=
eformat-shell=2Esh: Add --simplify argument

And apply the changes=2E

Chan=
ge-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
Signed-off-by: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794
Message=
-Id: <20260820091615=2E4656-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38548=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/reform=
at-shell=2Esh
M tests/t_client=2Esh=2Ein
M tests/t_lpback=2Esh
M tests/t_ne=
t=2Esh
M tests/t_server_null_client=2Esh
5 files changed, 7 insertions(+), =
7 deletions(-)




diff --git a/dev-tools/reformat-shell=2Esh b/dev-tools/r=
eformat-shell=2Esh
index dbbdaa9=2E=2Ed76eae7 100755
--- a/dev-tools/reform=
at-shell=2Esh
+++ b/dev-tools/reformat-shell=2Esh
@@ -5,7 +5,7 @@
 
 set -u=

 
-FORMAT_ARGS=3D"--indent=3D4 --func-next-line --case-indent"
+FORMAT_ARG=
S=3D"--simplify --indent=3D4 --func-next-line --case-indent"
 FORMAT_CMD=3D=
"shfmt --list --write"
 
 # hardcoded to --posix due to =2Ein filename and =
invalid shebang
diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=
=2Ein
index 305441be=2E=2E230a273 100755
--- a/tests/t_client=2Esh=2Ein
+++=
 b/tests/t_client=2Esh=2Ein
@@ -155,7 +155,7 @@
 fail()
 {
     output "FAI=
L: $@\n"
-    fail_count=3D$(($fail_count + 1))
+    fail_count=3D$((fail_c=
ount + 1))
 }
 
 # print "all interface IP addresses" + "all routes"
@@ -38=
6,7 +386,7 @@
             ovpn_init_check=3D0
             ovpn_init_succe=
ss=3D1
         fi
-        ovpn_init_check=3D$(($ovpn_init_check - 1))
+  =
      ovpn_init_check=3D$((ovpn_init_check - 1))
     done
 
     opid=3D$(=
cat $pidfile)
diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=2Esh
index =
058206f=2E=2Eec0a220 100755
--- a/tests/t_lpback=2Esh
+++ b/tests/t_lpback=
=2Esh
@@ -59,13 +59,13 @@
                 ;;
         esac
         e=3D1
=
-        tests_failed=3D$(($tests_failed + 1))
+        tests_failed=3D$((t=
ests_failed + 1))
     else
         case $V in
             0 | 1) ;;     =
  # no per-test output for 'OK'
             *) echo "OK" ;; # print all
  =
       esac
-        tests_passed=3D$(($tests_passed + 1))
+        tests_p=
assed=3D$((tests_passed + 1))
     fi
 }
 
diff --git a/tests/t_net=2Esh b/=
tests/t_net=2Esh
index 17e028e=2E=2Ed63f648 100755
--- a/tests/t_net=2Esh
+=
++ b/tests/t_net=2Esh
@@ -162,7 +162,7 @@
 # remove interface for good
 $RU=
N_SUDO ip link del $IFACE
 
-for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST=
_TEST}); do
+for i in $(seq $((LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
     =
$RUN_SUDO $UNIT_TEST $i
     if [ $? -ne 0 ]; then
         echo "unit-test=
 $i errored out"
diff --git a/tests/t_server_null_client=2Esh b/tests/t_ser=
ver_null_client=2Esh
index 3203cc2=2E=2E9f4168b 100755
--- a/tests/t_server=
_null_client=2Esh
+++ b/tests/t_server_null_client=2Esh
@@ -164,7 +164,7 @@=

             continue
         fi
         if $RUN_SUDO kill -0 $server_pi=
d >/dev/null 2>&1; then
-            servers_up=3D$(($servers_up + 1))
+   =
         servers_up=3D$((servers_up + 1))
         fi
     done
 

-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: ope=
nvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c4=
1fdb95c0413
Gerrit-Change-Number: 1794
Gerrit-PatchSet: 5
Gerrit-Owner: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--cUQK6WFmy+Q=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1794?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">reformat-shell=2Esh: Add --simplify argume=
nt<br><br>And apply the changes=2E<br><br>Change-Id: Id4d04bebdb8b2cb56e8dd=
16a386c41fdb95c0413<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794<br>Message-Id: =
&lt;20260820091615=2E4656-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38548=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M dev-tools/reformat-shell=2Esh<br>M tests/t_client=2Esh=2Ein<br>M tests/t=
_lpback=2Esh<br>M tests/t_net=2Esh<br>M tests/t_server_null_client=2Esh<br>=
5 files changed, 7 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/dev-tools/reformat-shell=2Esh b/dev-tools/reformat-shell=2Esh</span><=
br><span>index dbbdaa9=2E=2Ed76eae7 100755</span><br><span>--- a/dev-tools/=
reformat-shell=2Esh</span><br><span>+++ b/dev-tools/reformat-shell=2Esh</sp=
an><br><span>@@ -5,7 +5,7 @@</span><br><span> </span><br><span> set -u</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-FORMAT_A=
RGS=3D&quot;--indent=3D4 --func-next-line --case-indent&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+FORMAT_ARGS=3D&quot;--simplify --=
indent=3D4 --func-next-line --case-indent&quot;</span><br><span> FORMAT_CMD=
=3D&quot;shfmt --list --write&quot;</span><br><span> </span><br><span> # ha=
rdcoded to --posix due to =2Ein filename and invalid shebang</span><br><spa=
n>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span><b=
r><span>index 305441be=2E=2E230a273 100755</span><br><span>--- a/tests/t_cl=
ient=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><sp=
an>@@ -155,7 +155,7 @@</span><br><span> fail()</span><br><span> {</span><br=
><span>     output &quot;FAIL: $@\n&quot;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    fail_count=3D$(($fail_count + 1))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    fail_count=3D$((fail_count + 1))<=
/span><br><span> }</span><br><span> </span><br><span> # print &quot;all int=
erface IP addresses&quot; + &quot;all routes&quot;</span><br><span>@@ -386,=
7 +386,7 @@</span><br><span>             ovpn_init_check=3D0</span><br><spa=
n>             ovpn_init_success=3D1</span><br><span>         fi</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ovpn_init_check=3D$(($ov=
pn_init_check - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        ovpn_init_check=3D$((ovpn_init_check - 1))</span><br><span>     don=
e</span><br><span> </span><br><span>     opid=3D$(cat $pidfile)</span><br><=
span>diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=2Esh</span><br><span=
>index 058206f=2E=2Eec0a220 100755</span><br><span>--- a/tests/t_lpback=2Es=
h</span><br><span>+++ b/tests/t_lpback=2Esh</span><br><span>@@ -59,13 +59,1=
3 @@</span><br><span>                 ;;</span><br><span>         esac</spa=
n><br><span>         e=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        tests_failed=3D$(($tests_failed + 1))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        tests_failed=3D$((tests_failed + 1))=
</span><br><span>     else</span><br><span>         case $V in</span><br><s=
pan>             0 | 1) ;;       # no per-test output for &#39;OK&#39;</spa=
n><br><span>             *) echo &quot;OK&quot; ;; # print all</span><br><s=
pan>         esac</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    tests_passed=3D$(($tests_passed + 1))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        tests_passed=3D$((tests_passed + 1))</span><b=
r><span>     fi</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/tests/t_net=2Esh b/tests/t_net=2Esh</span><br><span>index 17e028e=2E=
=2Ed63f648 100755</span><br><span>--- a/tests/t_net=2Esh</span><br><span>++=
+ b/tests/t_net=2Esh</span><br><span>@@ -162,7 +162,7 @@</span><br><span> #=
 remove interface for good</span><br><span> $RUN_SUDO ip link del $IFACE</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-for i =
in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+for i in $(seq $((LAST_AUTO_TEST + 1)) ${=
LAST_TEST}); do</span><br><span>     $RUN_SUDO $UNIT_TEST $i</span><br><spa=
n>     if [ $? -ne 0 ]; then</span><br><span>         echo &quot;unit-test =
$i errored out&quot;</span><br><span>diff --git a/tests/t_server_null_clien=
t=2Esh b/tests/t_server_null_client=2Esh</span><br><span>index 3203cc2=2E=
=2E9f4168b 100755</span><br><span>--- a/tests/t_server_null_client=2Esh</sp=
an><br><span>+++ b/tests/t_server_null_client=2Esh</span><br><span>@@ -164,=
7 +164,7 @@</span><br><span>             continue</span><br><span>         =
fi</span><br><span>         if $RUN_SUDO kill -0 $server_pid &gt;/dev/null =
2&gt;&amp;1; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        servers_up=3D$(($servers_up + 1))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            servers_up=3D$((servers_up + 1))</span><b=
r><span>         fi</span><br><span>     done</span><br><span> </span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1794?usp=3Demail">change 1794</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41=
fdb95c0413 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1794 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"=
display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>

</body></html>
--cUQK6WFmy+Q=--


--===============1459640701640083426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1459640701640083426==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1459640701640083426==--

