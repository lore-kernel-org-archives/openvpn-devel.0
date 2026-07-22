Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5ED0C44539
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rb0pHr5QE5eZu0z9cpEN5vEMFM1tV2ZE4wPfQqsDgVc=; b=BjJlna9SJ8Y85yoc8MLKFoC4Np
	DbAkRo8jWcc4tunVYKq0FOIoCRHZ6Cm78mNXnVrXwCa+o0D+jlXq9CNWYdikOXCrProBIehWp9ACZ
	AmSIkk9z3wCu1682xEdT99Mgaj+iv8Ry390TFy/6BkVvBdFiGmHFYJkpuMsRWenFKWBc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmWji-00080m-DV;
	Wed, 22 Jul 2026 13:11:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmWjf-00080R-Bl
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:11:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Q83WAgGdJiHra3N4/YzqluwHdep79Okq5dIpHoWeJCQ=; b=DjLWkzMrC5DzFpvcDxSt1iFaIm
 pUWqa8A7AARUPUe8obbMAZnjpFRTh/FqR2LT0li8rKq4XXd8bD3b0zAYgqOePRnyXGWdJoJkZx3e1
 FrA39HaSt99L6uQTTHtFVaQ986UgK61gxfFNybIlZPpgrOSbeocuJybI2J3JSr6tojCc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q83WAgGdJiHra3N4/YzqluwHdep79Okq5dIpHoWeJCQ=; b=Q
 /sWQ4hmfm6rB2IUIsZgMKxDEoWlWC+Knac4HTWrvTLB5Hka8euq5VsKQCFSApcwcpglS2rYUQPDn7
 ZXI3yw5rqOclr0yfi29KSJsk+luA9W7lR17oYnlMizAqypDYb1PZE8zsBFyTEYOUHddBQagzJvGK1
 5nkyjKhOJpgQnn9k=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmWje-0006dt-Gj for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 13:11:43 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso1920399f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 06:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784725891; x=1785330691; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Q83WAgGdJiHra3N4/YzqluwHdep79Okq5dIpHoWeJCQ=;
 b=GTpRUQaewAV53IyTDzUJv8xpsvfy0C9WgF2uXejcjiB+GDDvE4GKRfNRhIFZ3WvML0
 xsyNIuDvRh/ppbxBsZUL5DXlBEDaVpPVq7fDwc46TrORVa3Nnm+8d3iT+WEH6AaoiyMO
 MyMNDNoIKGTZzjaVIR0oWkGDlo9UpiDz6io0nYyYuZoGiygRPLu1oYcamj802ETzTOH8
 +cIB13geE09nQwmdjl2fjSgapAU/ZAys3hTaloU3AjAz/S5K2Y6g3jYrAXFTojGc/803
 sChb6WgTrxi9Y/G9iYvMc/98R0SeM5D+1TjFsoIAIU+ieipQ7gtivlS5T106QQk7JGVo
 LIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784725891; x=1785330691;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Q83WAgGdJiHra3N4/YzqluwHdep79Okq5dIpHoWeJCQ=;
 b=k81Gmda9npzggXwzOHxeQAs+8j+N3tlr416o6J6oLUB7fzqBpB/R6omrRZG1PMrMnD
 Q55nGXnW+Jfvv8Zzu5DKVFCq4DxL0TB6n+Au/bNGQyJc0a4KHv8/M5/ODwWk90HLujP7
 5MjkiX5R3tWiZh9eOgSp2pLXth/UYOJ3pZvVZgfL4z6Ad+25Lsk/23bMTFB+7OrQ8PpZ
 uHWQNMdpxmc+TCDII9dK2TKVmzvPk7+3MHCzqLK/a4GcYAdzGHgm7y45mpXLpbmXoXwA
 CJS5OEuKkCbSDHCbmxQHl+JuxYXowUGNtqSw+1CgZ3IuN8nZR4FivNtrmYGAmEiQhBJd
 IWQQ==
X-Gm-Message-State: AOJu0Ywc12QN8EXxwoBzK0qtOYl/a4L3khYd/YU43HqStHQeJ92oFqnb
 SY5aWzSIdwvbPxP0ktk4ocYjCHkHOMwMnWw75yOw+uBREopAJ0+OsGmOkZ9clRJAiCebwDcHF6G
 W+f8C1COiraIEA9mjKrnrbFYiWNDEeUztwSbNfOvTteaXMZcQf1YC2jz3JZqY5cJZMtsDFnBE6t
 C2ciyczw==
X-Gm-Gg: AR+sD12ynhQ5t/9O8H9zNRJE336qZLXTwRtdnBycztPv41BwM98btXo+qYHBM2HAPg2
 PDcHiZ/HqYQwldHRGqNrB2XUolp4LftSIpwtz9gJIXWRHhRL0IICGSv6Ia+DYldrU0Rl+ADzVo6
 pCeI3nfRwBJpUtQiaotHurKcX4AoPIkbnDqYTeIQ49z4V+vQ7P47mIT0u3bSQRepSkFt7HySK1l
 +OnFWxnSUFdEnhZnTCdgN/ugKHWmEziUXHqUXkPXPcfl0v9EDTdUJRR/13j5ZAZg7y5pGf3k/nk
 bIAoHfq1YcBCakuz54HSIPcg3p7UJytjKiI5SLTij4eyaOWnQGTiRB1ZshdrHmRVJ2zkoVFR+Tt
 1cSXitWgafCTJ9qItzlQ6qGdxkn2OuRvphssL1i2W7nGvv6MXJjlxpiNhUIyCc5pdwnhW47Y8o3
 1aII2BGMY8ohhhsnGBC5iS0uYB1IJw3fY2AhWp1EyvZkISMJErryLQZ2LPggSFwb2FkudBmEmVj
 ytcSmCTRwELsFGO0TVCdCUZEncFu76bfB5/WHI/tc7byXz/TyIMGEHy+/Oazr3wo2JaUy73jrpz
 OPg=
X-Received: by 2002:a05:6000:2905:b0:47f:59ef:bbb2 with SMTP id
 ffacd0b85a97d-47f62305f1amr30190368f8f.17.1784725890592; 
 Wed, 22 Jul 2026 06:11:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb5a46sm6171758f8f.9.2026.07.22.06.11.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 06:11:30 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 13:11:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
X-Gerrit-Change-Number: 1794
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1794?usp=email>
X-Gerrit-Commit: 982d6ec554322b50eac271df9cc6efa0b38be90e
In-Reply-To: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
References: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLklkNGQwNGJlYmRiOGIyY2I1NmU4ZGQxNmEzODZjNDFmZGI5NWMwNDEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ab27ef8859d45d82861b6b87e8327ec198e5fe6c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmWje-0006dt-Gj
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4843318959844310876=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4843318959844310876==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h4y81f6/fkE="; charset=UTF-8

--h4y81f6/fkE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1794?usp=3Demail

to look at the new patch set (#2)=2E

=

Change subject: reformat-shell=2Esh: Add --simplify argument
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reformat-shell=2Esh: Add =
--simplify argument

And apply the changes=2E

Change-Id: Id4d04bebdb8b2cb5=
6e8dd16a386c41fdb95c0413
Signed-off-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
---
M dev-tools/reformat-shell=2Esh
M tests/t_client=2Esh=2Ein
M t=
ests/t_lpback=2Esh
M tests/t_net=2Esh
M tests/t_server_null_client=2Esh
5 f=
iles changed, 7 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/94/1794/2

diff --git a/dev-tools/r=
eformat-shell=2Esh b/dev-tools/reformat-shell=2Esh
index dbbdaa9=2E=2Ed76ea=
e7 100755
--- a/dev-tools/reformat-shell=2Esh
+++ b/dev-tools/reformat-shel=
l=2Esh
@@ -5,7 +5,7 @@
 
 set -u
 
-FORMAT_ARGS=3D"--indent=3D4 --func-next=
-line --case-indent"
+FORMAT_ARGS=3D"--simplify --indent=3D4 --func-next-li=
ne --case-indent"
 FORMAT_CMD=3D"shfmt --list --write"
 
 # hardcoded to --=
posix due to =2Ein filename and invalid shebang
diff --git a/tests/t_client=
=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 98cabde=2E=2Efee4e5f 100755
---=
 a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -155,7 +155,7=
 @@
 fail()
 {
     output "FAIL: $@\n"
-    fail_count=3D$(($fail_count + =
1))
+    fail_count=3D$((fail_count + 1))
 }
 
 # print "all interface IP a=
ddresses" + "all routes"
@@ -386,7 +386,7 @@
             ovpn_init_check=
=3D0
             ovpn_init_success=3D1
         fi
-        ovpn_init_chec=
k=3D$(($ovpn_init_check - 1))
+        ovpn_init_check=3D$((ovpn_init_check=
 - 1))
     done
 
     opid=3D$(cat $pidfile)
diff --git a/tests/t_lpback=
=2Esh b/tests/t_lpback=2Esh
index 058206f=2E=2Eec0a220 100755
--- a/tests/t=
_lpback=2Esh
+++ b/tests/t_lpback=2Esh
@@ -59,13 +59,13 @@
                =
 ;;
         esac
         e=3D1
-        tests_failed=3D$(($tests_failed +=
 1))
+        tests_failed=3D$((tests_failed + 1))
     else
         case =
$V in
             0 | 1) ;;       # no per-test output for 'OK'
          =
   *) echo "OK" ;; # print all
         esac
-        tests_passed=3D$(($te=
sts_passed + 1))
+        tests_passed=3D$((tests_passed + 1))
     fi
 }
 =

diff --git a/tests/t_net=2Esh b/tests/t_net=2Esh
index 17e028e=2E=2Ed63f64=
8 100755
--- a/tests/t_net=2Esh
+++ b/tests/t_net=2Esh
@@ -162,7 +162,7 @@
=
 # remove interface for good
 $RUN_SUDO ip link del $IFACE
 
-for i in $(se=
q $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
+for i in $(seq $((LAST_AUTO_T=
EST + 1)) ${LAST_TEST}); do
     $RUN_SUDO $UNIT_TEST $i
     if [ $? -ne 0=
 ]; then
         echo "unit-test $i errored out"
diff --git a/tests/t_serv=
er_null_client=2Esh b/tests/t_server_null_client=2Esh
index 3203cc2=2E=2E9f=
4168b 100755
--- a/tests/t_server_null_client=2Esh
+++ b/tests/t_server_nul=
l_client=2Esh
@@ -164,7 +164,7 @@
             continue
         fi
       =
  if $RUN_SUDO kill -0 $server_pid >/dev/null 2>&1; then
-            serve=
rs_up=3D$(($servers_up + 1))
+            servers_up=3D$((servers_up + 1))
=
         fi
     done
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1794?usp=3Demail
To unsubscribe, or for help writing mail filter=
s, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
Gerrit-Change-Number: 1794=

Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--h4y81f6/fkE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #2</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1794?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">re=
format-shell=2Esh: Add --simplify argument<br><br>And apply the changes=2E<=
br><br>Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/=
reformat-shell=2Esh<br>M tests/t_client=2Esh=2Ein<br>M tests/t_lpback=2Esh<=
br>M tests/t_net=2Esh<br>M tests/t_server_null_client=2Esh<br>5 files chang=
ed, 7 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/1794/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/dev-tools/reformat-shell=2Esh b/dev-tools/reformat-shell=2Esh</spa=
n><br><span>index dbbdaa9=2E=2Ed76eae7 100755</span><br><span>--- a/dev-too=
ls/reformat-shell=2Esh</span><br><span>+++ b/dev-tools/reformat-shell=2Esh<=
/span><br><span>@@ -5,7 +5,7 @@</span><br><span> </span><br><span> set -u</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-FORMA=
T_ARGS=3D&quot;--indent=3D4 --func-next-line --case-indent&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+FORMAT_ARGS=3D&quot;--simplify=
 --indent=3D4 --func-next-line --case-indent&quot;</span><br><span> FORMAT_=
CMD=3D&quot;shfmt --list --write&quot;</span><br><span> </span><br><span> #=
 hardcoded to --posix due to =2Ein filename and invalid shebang</span><br><=
span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein</span=
><br><span>index 98cabde=2E=2Efee4e5f 100755</span><br><span>--- a/tests/t_=
client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=2Esh=2Ein</span><br><=
span>@@ -155,7 +155,7 @@</span><br><span> fail()</span><br><span> {</span><=
br><span>     output &quot;FAIL: $@\n&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    fail_count=3D$(($fail_count + 1))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    fail_count=3D$((fail_count + 1)=
)</span><br><span> }</span><br><span> </span><br><span> # print &quot;all i=
nterface IP addresses&quot; + &quot;all routes&quot;</span><br><span>@@ -38=
6,7 +386,7 @@</span><br><span>             ovpn_init_check=3D0</span><br><s=
pan>             ovpn_init_success=3D1</span><br><span>         fi</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        ovpn_init_check=3D$(($=
ovpn_init_check - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ovpn_init_check=3D$((ovpn_init_check - 1))</span><br><span>     d=
one</span><br><span> </span><br><span>     opid=3D$(cat $pidfile)</span><br=
><span>diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=2Esh</span><br><sp=
an>index 058206f=2E=2Eec0a220 100755</span><br><span>--- a/tests/t_lpback=
=2Esh</span><br><span>+++ b/tests/t_lpback=2Esh</span><br><span>@@ -59,13 +=
59,13 @@</span><br><span>                 ;;</span><br><span>         esac<=
/span><br><span>         e=3D1</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        tests_failed=3D$(($tests_failed + 1))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        tests_failed=3D$((tests_failed +=
 1))</span><br><span>     else</span><br><span>         case $V in</span><b=
r><span>             0 | 1) ;;       # no per-test output for &#39;OK&#39;<=
/span><br><span>             *) echo &quot;OK&quot; ;; # print all</span><b=
r><span>         esac</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        tests_passed=3D$(($tests_passed + 1))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tests_passed=3D$((tests_passed + 1))</spa=
n><br><span>     fi</span><br><span> }</span><br><span> </span><br><span>di=
ff --git a/tests/t_net=2Esh b/tests/t_net=2Esh</span><br><span>index 17e028=
e=2E=2Ed63f648 100755</span><br><span>--- a/tests/t_net=2Esh</span><br><spa=
n>+++ b/tests/t_net=2Esh</span><br><span>@@ -162,7 +162,7 @@</span><br><spa=
n> # remove interface for good</span><br><span> $RUN_SUDO ip link del $IFAC=
E</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-fo=
r i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+for i in $(seq $((LAST_AUTO_TEST + 1)) =
${LAST_TEST}); do</span><br><span>     $RUN_SUDO $UNIT_TEST $i</span><br><s=
pan>     if [ $? -ne 0 ]; then</span><br><span>         echo &quot;unit-tes=
t $i errored out&quot;</span><br><span>diff --git a/tests/t_server_null_cli=
ent=2Esh b/tests/t_server_null_client=2Esh</span><br><span>index 3203cc2=2E=
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
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a3=
86c41fdb95c0413 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
794 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>

</body></html>
--h4y81f6/fkE=--


--===============4843318959844310876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4843318959844310876==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4843318959844310876==--

