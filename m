Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3456FC5DF87
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AQye7xlnzzN229QtUmHp7WJ+2VAL+kWFxJoX6v8e/3k=; b=ISgokYIL4SY0jp02I6notQLD8d
	KNThG+1LUA/uW+/yoSBzg/lIdxr/PduEXhQtyxcgR0+/VKdrK9Bp9q37mSp4nWmt+ZC4tXiFxOwf4
	t6SG9k6RkjG7IorZVX2/QacENqtV4WQ9g/QNpEP1V5TNpEup6p3RbEdtqiJf8Wc5znow=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wx0So-0003T7-1u;
	Thu, 20 Aug 2026 10:57:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wx0Sk-0003Sn-6Q
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:57:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3+gUtUvyYHV5fz4ljziJ7irj+G/eC5D9NbubLsAJ1eA=; b=jruHM/1zzlayRLb8huqW3Vgk/I
 eMAHBIQ5FUUlVaZmDafpnWnGTRAcda1bvFxk2K/lDJ4sgm9UphrE1NDGQJ8+91oFRUsU7DnXRWl87
 Nsq1Uf73SuuFM2sd/7KCm/bAw4QdXG0tqrVsZlQM4TltLhlUAYEyVo6vJVT61Z5OcZBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3+gUtUvyYHV5fz4ljziJ7irj+G/eC5D9NbubLsAJ1eA=; b=F
 yGaazXYNvXeIuavGaSLoZ3D2gneuEOpR4GhhdsCpUnkzFFYlyMpzCxpracvNQno+NuXVrGY3yricC
 wHz4mXWJIedZfQlTC3Y5cvdRqliWwMpoNRhRM/yuYSAEnIc/ss4TYi8OAViShoE/dhayN1UDMlJHy
 o4UnkJKWsStKxofQ=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wx0SP-0006Oi-0E for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:57:13 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso16467775e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 20 Aug 2026 03:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787223426; x=1787828226; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3+gUtUvyYHV5fz4ljziJ7irj+G/eC5D9NbubLsAJ1eA=;
 b=IUqtqjXc7z8gQSbv3dN6e/MKZSGY8eSP0aWF9ebR7rpf7HXTkeipfOQYZf9le2Yv6k
 vKuHj9e+Q/Z9iGn1CtrG9ivWa1yBbmlp9sI1zROIpgLJYkLyAyT2TEz03OdIkcIkFm0T
 8t2p4OhFL9E4V1Cx3ZPQHXzcnVu5zQOoFZFgrBiAVX64i9wntQojOsOCrBWgDBdj06bv
 7KyL5jd3fggQcXFrcnyxrEGQ7qv56URst3BmIlQ8mRzZbWXmA83gyhoeoPH9MuWD4osr
 afWPDlESTTokVxDjwUoLp05IPCPrWbschsN8BngHc7SOZ+bSCi2VEr1QZ+ZLRJRiEW5y
 m/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787223426; x=1787828226;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3+gUtUvyYHV5fz4ljziJ7irj+G/eC5D9NbubLsAJ1eA=;
 b=HicDFraYeScMjVv5KRolF7pi1UJxkeGk6ij64+Nzq4GyRe5g/PBUS+b8HRFmMkQFv1
 sWKk/8uCnV/VMNrpDUTyc4x3hdXfwhPXzyh6mes2a3FVKHWYqqxh2awRFHeMaAf2fKmL
 0L6JosUb0pLw8+CnrbK0RhaiNemXF27+xZ24XlUwldvSBIlRHNdX2QstvUKrqfEbCMOX
 S3kFhLpyqN7Mxhy5w/zhR2eq6KQas9x32t1tssu9kM1TfXZhJQ8+9qmxBT2exXh0iNrM
 qm+GmtvPIXxSqpIl7G6WVn0kIje9Cv7cS3TAdBzu1R+lxxXp//M+AdaEn4q149azR6a1
 t5Ig==
X-Gm-Message-State: AOJu0YzHbC8ABGafAuS3NzN1xFISJZxj+mkJnkxxOC4m2BjVosim5cr6
 wvTDymYBEc2Xqv5lIK6B1apNm3D8tFCC1Cnavfd0ADFbxddXlwLMsgozCYgAfnWBbC4VXRlscWY
 MSj6Yxjb+OddfPcLC5dgltugMp9DiheFsEeSptU1teAAqGx0nz/FIJK3GfpP6ce97Pd+Sa+XYbm
 KK2ynYsw==
X-Gm-Gg: AR+sD13t4aj7i5a6Ofy+Ccsf+S2lrnlF/4IwRikfnody6CxUWzqU+agzaHcnGg9TBHZ
 NomKPvw/x2GXVGQfYQiACp/t4F6ZDeVq34aPPB5WepsuV5GR6y/L76NxKEv4QlA6GflSwh4O6xh
 ceSbHy6HpP8ncWlmwmSdy2Sx3yM8SCDLN+P2jfVNeNF3WTmesGorukSnyZKCfJKRXV6CNNWL66W
 rokzjI5IZDui4P6T+M+uWCTzTEinSy0CLrGVUwVwLnxAtoJraqAuDxDca8f8AyEQRvhIvKp4/wI
 /LvhHMzv2gJd3oFMiltjrNvBSqeSgnpF5rRJ7PiCAvKeM5xnM3OM3Ed/LoDIuc11oA46dXUFFfI
 6chJzvrDwLbld3R0oqDKK1Z5PwQhJZCujoWUGUn96WlaFZ91KOSmyGkYoIEg3R59nPDFgz8gfo4
 m6CSn5ioUK4xX8f/1UpjuIfHKJ97pcJjLD64Qjr/VZ7EjN0IGAY9oNCenUjkjg4b3WSeqDpcBk2
 12QYXbXYlY28fzfXSu6WgrFCB3J8tE3rBPMflhBAxcDrUfWrsPwKHnRD00PJBdtmzZdEhqkQLZx
 Bw5x8tvfOhETFcRi/G8N7LB/s4S+fEQs5gAKEC5Ne5jvRg7RyRs=
X-Received: by 2002:a05:600c:4754:b0:499:7f38:d77 with SMTP id
 5b1f17b1804b1-499aa1659edmr157734935e9.6.1787223426334; 
 Thu, 20 Aug 2026 03:57:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aaef1665sm139821815e9.5.2026.08.20.03.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 03:57:05 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 20 Aug 2026 10:56:56 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
X-Gerrit-Change-Number: 1794
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1794?usp=email>
X-Gerrit-Commit: ed427eab1683af3adf21553dd1c6b6e4b8b2f10d
In-Reply-To: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
References: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLklkNGQwNGJlYmRiOGIyY2I1NmU4ZGQxNmEzODZjNDFmZGI5NWMwNDEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c70e55474581215fd9ce92aebe37445ce2f1328-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wx0SP-0006Oi-0E
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5856085953377205549=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5856085953377205549==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6rkaXdPEe2k="; charset=UTF-8

--6rkaXdPEe2k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by razvanc


Change subject: reformat-shell=2Esh: Add --simplify argument
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reformat-shel=
l=2Esh: Add --simplify argument

And apply the changes=2E

Change-Id: Id4d0=
4bebdb8b2cb56e8dd16a386c41fdb95c0413
Signed-off-by: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794
Message-Id: <202608=
20091615=2E4656-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg38548=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/reformat-shell=2E=
sh
M tests/t_client=2Esh=2Ein
M tests/t_lpback=2Esh
M tests/t_net=2Esh
M te=
sts/t_server_null_client=2Esh
5 files changed, 7 insertions(+), 7 deletions=
(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94=
/1794/5

diff --git a/dev-tools/reformat-shell=2Esh b/dev-tools/reformat-sh=
ell=2Esh
index dbbdaa9=2E=2Ed76eae7 100755
--- a/dev-tools/reformat-shell=
=2Esh
+++ b/dev-tools/reformat-shell=2Esh
@@ -5,7 +5,7 @@
 
 set -u
 
-FORM=
AT_ARGS=3D"--indent=3D4 --func-next-line --case-indent"
+FORMAT_ARGS=3D"--s=
implify --indent=3D4 --func-next-line --case-indent"
 FORMAT_CMD=3D"shfmt -=
-list --write"
 
 # hardcoded to --posix due to =2Ein filename and invalid =
shebang
diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
in=
dex 305441be=2E=2E230a273 100755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests=
/t_client=2Esh=2Ein
@@ -155,7 +155,7 @@
 fail()
 {
     output "FAIL: $@\n"=

-    fail_count=3D$(($fail_count + 1))
+    fail_count=3D$((fail_count + 1=
))
 }
 
 # print "all interface IP addresses" + "all routes"
@@ -386,7 +386=
,7 @@
             ovpn_init_check=3D0
             ovpn_init_success=3D1
 =
        fi
-        ovpn_init_check=3D$(($ovpn_init_check - 1))
+        ov=
pn_init_check=3D$((ovpn_init_check - 1))
     done
 
     opid=3D$(cat $pid=
file)
diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=2Esh
index 058206f=
=2E=2Eec0a220 100755
--- a/tests/t_lpback=2Esh
+++ b/tests/t_lpback=2Esh
@@=
 -59,13 +59,13 @@
                 ;;
         esac
         e=3D1
-       =
 tests_failed=3D$(($tests_failed + 1))
+        tests_failed=3D$((tests_fai=
led + 1))
     else
         case $V in
             0 | 1) ;;       # no p=
er-test output for 'OK'
             *) echo "OK" ;; # print all
         e=
sac
-        tests_passed=3D$(($tests_passed + 1))
+        tests_passed=3D=
$((tests_passed + 1))
     fi
 }
 
diff --git a/tests/t_net=2Esh b/tests/t_=
net=2Esh
index 17e028e=2E=2Ed63f648 100755
--- a/tests/t_net=2Esh
+++ b/tes=
ts/t_net=2Esh
@@ -162,7 +162,7 @@
 # remove interface for good
 $RUN_SUDO i=
p link del $IFACE
 
-for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_TEST});=
 do
+for i in $(seq $((LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
     $RUN_SUD=
O $UNIT_TEST $i
     if [ $? -ne 0 ]; then
         echo "unit-test $i erro=
red out"
diff --git a/tests/t_server_null_client=2Esh b/tests/t_server_null=
_client=2Esh
index 3203cc2=2E=2E9f4168b 100755
--- a/tests/t_server_null_cl=
ient=2Esh
+++ b/tests/t_server_null_client=2Esh
@@ -164,7 +164,7 @@
       =
      continue
         fi
         if $RUN_SUDO kill -0 $server_pid >/dev/=
null 2>&1; then
-            servers_up=3D$(($servers_up + 1))
+           =
 servers_up=3D$((servers_up + 1))
         fi
     done
 

-- 
To view, vis=
it http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn=

Gerrit-Branch: master
Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb=
95c0413
Gerrit-Change-Number: 1794
Gerrit-PatchSet: 5
Gerrit-Owner: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--6rkaXdPEe2k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">reformat-shell=2Esh: Add=
 --simplify argument<br><br>And apply the changes=2E<br><br>Change-Id: Id4d=
04bebdb8b2cb56e8dd16a386c41fdb95c0413<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
94<br>Message-Id: &lt;20260820091615=2E4656-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38548=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M dev-tools/reformat-shell=2Esh<br>M tests/t_client=2E=
sh=2Ein<br>M tests/t_lpback=2Esh<br>M tests/t_net=2Esh<br>M tests/t_server_=
null_client=2Esh<br>5 files changed, 7 insertions(+), 7 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/94/1794/5</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/dev-tools/reformat-shell=2Esh b/d=
ev-tools/reformat-shell=2Esh</span><br><span>index dbbdaa9=2E=2Ed76eae7 100=
755</span><br><span>--- a/dev-tools/reformat-shell=2Esh</span><br><span>+++=
 b/dev-tools/reformat-shell=2Esh</span><br><span>@@ -5,7 +5,7 @@</span><br>=
<span> </span><br><span> set -u</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-FORMAT_ARGS=3D&quot;--indent=3D4 --func-next-li=
ne --case-indent&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+FORMAT_ARGS=3D&quot;--simplify --indent=3D4 --func-next-line --case-inde=
nt&quot;</span><br><span> FORMAT_CMD=3D&quot;shfmt --list --write&quot;</sp=
an><br><span> </span><br><span> # hardcoded to --posix due to =2Ein filenam=
e and invalid shebang</span><br><span>diff --git a/tests/t_client=2Esh=2Ein=
 b/tests/t_client=2Esh=2Ein</span><br><span>index 305441be=2E=2E230a273 100=
755</span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/te=
sts/t_client=2Esh=2Ein</span><br><span>@@ -155,7 +155,7 @@</span><br><span>=
 fail()</span><br><span> {</span><br><span>     output &quot;FAIL: $@\n&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fail_count=3D$(=
($fail_count + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   fail_count=3D$((fail_count + 1))</span><br><span> }</span><br><span> </s=
pan><br><span> # print &quot;all interface IP addresses&quot; + &quot;all r=
outes&quot;</span><br><span>@@ -386,7 +386,7 @@</span><br><span>           =
  ovpn_init_check=3D0</span><br><span>             ovpn_init_success=3D1</s=
pan><br><span>         fi</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        ovpn_init_check=3D$(($ovpn_init_check - 1))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ovpn_init_check=3D$((ovpn_init_=
check - 1))</span><br><span>     done</span><br><span> </span><br><span>   =
  opid=3D$(cat $pidfile)</span><br><span>diff --git a/tests/t_lpback=2Esh b=
/tests/t_lpback=2Esh</span><br><span>index 058206f=2E=2Eec0a220 100755</spa=
n><br><span>--- a/tests/t_lpback=2Esh</span><br><span>+++ b/tests/t_lpback=
=2Esh</span><br><span>@@ -59,13 +59,13 @@</span><br><span>                 =
;;</span><br><span>         esac</span><br><span>         e=3D1</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        tests_failed=3D$(($tests_=
failed + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 tests_failed=3D$((tests_failed + 1))</span><br><span>     else</span><br><=
span>         case $V in</span><br><span>             0 | 1) ;;       # no =
per-test output for &#39;OK&#39;</span><br><span>             *) echo &quot=
;OK&quot; ;; # print all</span><br><span>         esac</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        tests_passed=3D$(($tests_passed + =
1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests_pa=
ssed=3D$((tests_passed + 1))</span><br><span>     fi</span><br><span> }</sp=
an><br><span> </span><br><span>diff --git a/tests/t_net=2Esh b/tests/t_net=
=2Esh</span><br><span>index 17e028e=2E=2Ed63f648 100755</span><br><span>---=
 a/tests/t_net=2Esh</span><br><span>+++ b/tests/t_net=2Esh</span><br><span>=
@@ -162,7 +162,7 @@</span><br><span> # remove interface for good</span><br>=
<span> $RUN_SUDO ip link del $IFACE</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-for i in $(seq $(($LAST_AUTO_TEST + 1)) ${L=
AST_TEST}); do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for i=
 in $(seq $((LAST_AUTO_TEST + 1)) ${LAST_TEST}); do</span><br><span>     $R=
UN_SUDO $UNIT_TEST $i</span><br><span>     if [ $? -ne 0 ]; then</span><br>=
<span>         echo &quot;unit-test $i errored out&quot;</span><br><span>di=
ff --git a/tests/t_server_null_client=2Esh b/tests/t_server_null_client=2Es=
h</span><br><span>index 3203cc2=2E=2E9f4168b 100755</span><br><span>--- a/t=
ests/t_server_null_client=2Esh</span><br><span>+++ b/tests/t_server_null_cl=
ient=2Esh</span><br><span>@@ -164,7 +164,7 @@</span><br><span>             =
continue</span><br><span>         fi</span><br><span>         if $RUN_SUDO =
kill -0 $server_pid &gt;/dev/null 2&gt;&amp;1; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            servers_up=3D$(($servers_up + 1=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            serve=
rs_up=3D$((servers_up + 1))</span><br><span>         fi</span><br><span>   =
  done</span><br><span> </span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail">cha=
nge 1794</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1794 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--6rkaXdPEe2k=--


--===============5856085953377205549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5856085953377205549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5856085953377205549==--

