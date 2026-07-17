Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C75AC4451C
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 16:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=LkSwlK7GEdarl1toXEFcANOHAIdb7+b+yJvllim4Mlc=; b=bz9RGUseUlY5WN
	chxC67/Qqq8zXy+/vRjyhFRR8bj9dbLHi7Uzpi8D+ZEM9KSpbmWTe+oG2L5JCXabRV8ddKEVYbO9R
	nOYR3DrM6bZGHiCa8QbpqILuHUFYWCgMfSiua2/yTmsI47HsY+PiVm0KZotTnNUVHdfWc81j/gZN+
	+78=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wklK9-0007dF-Px;
	Fri, 17 Jul 2026 16:22:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wklK8-0007d6-66
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 16:22:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pjavMZIVaOGo7SIadE3PTminFzj4i4qfFwNWif6LQUk=; b=FmJ48aWhA/z9Wbyb6y1rtu01Rj
 YIhB6A7UXTBnCpMs1zzlAUzg2tToFpSXroA9MomnGbKeajTwv/xyr+X0ZNa96hP+0QX4Jqvkhbh/R
 o7cGij+b7LkKhY3qQWe/2Lix7eNslclLzv1TaEo+FT938jyJnAvmAIl8wwNyB+BUji34=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pjavMZIVaOGo7SIadE3PTminFzj4i4qfFwNWif6LQUk=; b=k
 rdunYzFGt6FVmyhBPJmD9Q/p9z4jpoL9MJBnKz4mnmR7iCPlv7mpPz/DovWfgFFRyrh1c6g2mpzz4
 sSx71rhtOznHOOtPBuUPlwF249YHfRAyiRDPVwjSjeVuOniGZVKLfd08RTF4TbCXf5qzjx8yy7gPS
 OB+t6x6Qr0tJHWFw=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wklK7-0002MR-CG for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 16:22:04 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so5756440f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 09:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784305312; x=1784910112; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pjavMZIVaOGo7SIadE3PTminFzj4i4qfFwNWif6LQUk=;
 b=gggjddu2W9f1uk2ydqplOJ4zaB4Iop7fnl24Nbw0vjcjcRHyhWHUPJoAmFzNEMwz/h
 xRDCaB9bvdEYEX3RRTWV0MwwPIH9Gc4J7sfPm3FdvrpliUYqQ0+T0h/wXlaQohIOXLhw
 8smzst0FELShW5CKgRsp6JHtSbSp2VFPCqOFwvcV6WF/2eFNBKlHZW8euPjVw24YH4EW
 lZxYI1XDRAWM5BICCKg0+7nLYSNNZSex4+MHN6adaHtKT6WuNbiX/30KNrRjesDNgeGY
 5LgaAD1Y+oUL+lxkeaK2CyAUYCEdHiqyjqCIcuGBGC1iLlO9e3J64c5zf/6qBHn8BReI
 XjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784305312; x=1784910112;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pjavMZIVaOGo7SIadE3PTminFzj4i4qfFwNWif6LQUk=;
 b=B5Hkm7AhumS3SoDSHBkyosBBJR6bGDAuWHF7yq3MCV46PWp11O8sXSNnPeurKeWAEC
 vR/Eu2yhWgFfAuzTZsW2T4t105wl54ch2glWEgtdEO1bzuB82e1WjPJ1r54L1wsTz7+M
 P1BCToE3y08rKVav7SslxEkT6ZBGGXpkmM9ujlyZQOXTGnODModpPa88SzKRFjtLGYP8
 KHTEtIfJlYe+nVpoADTPAERbTP0wvxvUAaXsa4vOlYXe8XzKxgqfw8xGO9tK//AhN4Wy
 wOCLA9wIIRoQAi9MhtADQBnmclgPtzCe7371RG88tzjdoWRqoDmjt2ojCXZ5x8o3Iofp
 2GYg==
X-Gm-Message-State: AOJu0YyOxhZo+p7Rsyle7/C+eGv36Va8EIRP75LiD+uBIAWL8d4xuolo
 IOWfzH5nxZxgcrL+jsB4iNt7OmINCqC94J2scHXRb1NBWXkUcq9xZA8Yn+cFKDr7b3JcFxx8Nej
 oyFO/BFsjsGkzKRaCgawK97c+icSbXxlWPO5yOiL0TXP8KFUjG131LBh1jSy1Yghrlv0LSwovuP
 dnCcG6Yg==
X-Gm-Gg: AfdE7clwNWlryEq1tlMvz4xc0HiWAqlg/jjOFioIOw9C+fh0PGN00zOrnhUhZNCoD9l
 ijAHaXuuwDrgJLiP56dMAlbGsJFGArB7kNxX2i0DVyPnBkMyCGS8ctADDezwGx2jOP7/AYYBvha
 e0kKEChvdGzmx61jbqQ2XsZo/KNxPYzO93VGWOVm/JrD9cc0kNT7jHV4m6ff9+4hrIy3uVhDL6A
 0kfaGCgLSxfI6CEy92uGSpGyY0UJ63ycblaplaS5ulVeFyQ6LEKjj9RcZncGNeFrnFlr3MPpmUk
 w/KAVgI2oj6IQDbY69JCbWHm2MCKzo1hN4xA/YqTSaiO9pdUnOKIBdQWOdA9xWj2MDalGBW5yXj
 Hm4IxSGwwd6T3VVtUh4GpMjOsIgWb9ewArNwcgT2x8I3YMdw+dnburby/rncwtRvQ1nirWM5t8v
 QDcBjQvxw0WS/jqNAPDd+zmbuftZfa8nKVkitCsd/iJxe98rn8yXQvou/yGpUfz/0S4dCQ+CWyu
 rAlJH87sFlgpj3zw+C5TyjUc40wwH5sSwoW/ul56H+MwPpxQd+2r8wgG7HRjNwZPKwP
X-Received: by 2002:a05:6000:40c5:b0:47d:ebab:7bb2 with SMTP id
 ffacd0b85a97d-47f6232580emr4495114f8f.31.1784305311576; 
 Fri, 17 Jul 2026 09:21:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63ec7c69sm4659249f8f.17.2026.07.17.09.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 09:21:51 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 16:21:50 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
X-Gerrit-Change-Number: 1794
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1794?usp=email>
X-Gerrit-Commit: 0aea7fe2b17ebf759a5f5ed80324cc728eb50efe
References: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLklkNGQwNGJlYmRiOGIyY2I1NmU4ZGQxNmEzODZjNDFmZGI5NWMwNDEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <62c34b5bce04deac97c2082ff8321b41602561f4-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wklK7-0002MR-CG
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
Content-Type: multipart/mixed; boundary="===============3887782286606288841=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3887782286606288841==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UUYaOlPdpk8="; charset=UTF-8

--UUYaOlPdpk8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1794?usp=3Demail

to review the following change=2E


Chang=
e subject: reformat-shell=2Esh: Add --simplify argument
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

reformat-shell=2Esh: Add --simp=
lify argument

And apply the changes=2E

Change-Id: Id4d04bebdb8b2cb56e8dd1=
6a386c41fdb95c0413
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
---
M dev-tools/reformat-shell=2Esh
M tests/t_client=2Esh=2Ein
M tests/t=
_lpback=2Esh
M tests/t_net=2Esh
M tests/t_server_null_client=2Esh
5 files c=
hanged, 7 insertions(+), 7 deletions(-)



  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/94/1794/1

diff --git a/dev-tools/reform=
at-shell=2Esh b/dev-tools/reformat-shell=2Esh
index a6b8a9a=2E=2E0502f41 10=
0755
--- a/dev-tools/reformat-shell=2Esh
+++ b/dev-tools/reformat-shell=2Es=
h
@@ -5,7 +5,7 @@
 
 set -u
 
-FORMAT_ARGS=3D"--indent=3D4"
+FORMAT_ARGS=3D=
"--simplify --indent=3D4"
 FORMAT_CMD=3D"shfmt --list --write"
 
 # hardcod=
ed to --posix due to =2Ein filename and invalid shebang
diff --git a/tests/=
t_client=2Esh=2Ein b/tests/t_client=2Esh=2Ein
index 4b6c51d=2E=2E93762ad 10=
0755
--- a/tests/t_client=2Esh=2Ein
+++ b/tests/t_client=2Esh=2Ein
@@ -152,=
7 +152,7 @@
 # print failure message, increase FAIL counter
 fail() {
     =
output "FAIL: $@\n"
-    fail_count=3D$(($fail_count + 1))
+    fail_count=
=3D$((fail_count + 1))
 }
 
 # print "all interface IP addresses" + "all ro=
utes"
@@ -380,7 +380,7 @@
             ovpn_init_check=3D0
             ovp=
n_init_success=3D1
         fi
-        ovpn_init_check=3D$(($ovpn_init_che=
ck - 1))
+        ovpn_init_check=3D$((ovpn_init_check - 1))
     done
 
  =
   opid=3D$(cat $pidfile)
diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=
=2Esh
index 8379f8f=2E=2E0617a30 100755
--- a/tests/t_lpback=2Esh
+++ b/tes=
ts/t_lpback=2Esh
@@ -57,13 +57,13 @@
             ;;
         esac
        =
 e=3D1
-        tests_failed=3D$(($tests_failed + 1))
+        tests_failed=
=3D$((tests_failed + 1))
     else
         case $V in
         0 | 1) ;;  =
     # no per-test output for 'OK'
         *) echo "OK" ;; # print all
   =
      esac
-        tests_passed=3D$(($tests_passed + 1))
+        tests_pa=
ssed=3D$((tests_passed + 1))
     fi
 }
 
diff --git a/tests/t_net=2Esh b/t=
ests/t_net=2Esh
index fbedb54=2E=2E60da693 100755
--- a/tests/t_net=2Esh
++=
+ b/tests/t_net=2Esh
@@ -160,7 +160,7 @@
 # remove interface for good
 $RUN=
_SUDO ip link del $IFACE
 
-for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_=
TEST}); do
+for i in $(seq $((LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
     $=
RUN_SUDO $UNIT_TEST $i
     if [ $? -ne 0 ]; then
         echo "unit-test =
$i errored out"
diff --git a/tests/t_server_null_client=2Esh b/tests/t_serv=
er_null_client=2Esh
index 2741d5d=2E=2E81eb138 100755
--- a/tests/t_server_=
null_client=2Esh
+++ b/tests/t_server_null_client=2Esh
@@ -158,7 +158,7 @@
=
             continue
         fi
         if $RUN_SUDO kill -0 $server_pid=
 >/dev/null 2>&1; then
-            servers_up=3D$(($servers_up + 1))
+    =
        servers_up=3D$((servers_up + 1))
         fi
     done
 

-- 
To vi=
ew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a38=
6c41fdb95c0413
Gerrit-Change-Number: 1794
Gerrit-PatchSet: 1
Gerrit-Owner: =
flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--UUYaOlPdpk8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">reformat-shell=2Esh: Add --simplify argument<br><br>And apply the chan=
ges=2E<br><br>Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413<br>Signe=
d-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev=
-tools/reformat-shell=2Esh<br>M tests/t_client=2Esh=2Ein<br>M tests/t_lpbac=
k=2Esh<br>M tests/t_net=2Esh<br>M tests/t_server_null_client=2Esh<br>5 file=
s changed, 7 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/94/1794/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/dev-tools/reformat-shell=2Esh b/dev-tools/reformat-shell=2E=
sh</span><br><span>index a6b8a9a=2E=2E0502f41 100755</span><br><span>--- a/=
dev-tools/reformat-shell=2Esh</span><br><span>+++ b/dev-tools/reformat-shel=
l=2Esh</span><br><span>@@ -5,7 +5,7 @@</span><br><span> </span><br><span> s=
et -u</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-FORMAT_ARGS=3D&quot;--indent=3D4&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+FORMAT_ARGS=3D&quot;--simplify --indent=3D4&quot;</spa=
n><br><span> FORMAT_CMD=3D&quot;shfmt --list --write&quot;</span><br><span>=
 </span><br><span> # hardcoded to --posix due to =2Ein filename and invalid=
 shebang</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/tests/t_cl=
ient=2Esh=2Ein</span><br><span>index 4b6c51d=2E=2E93762ad 100755</span><br>=
<span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t_client=
=2Esh=2Ein</span><br><span>@@ -152,7 +152,7 @@</span><br><span> # print fai=
lure message, increase FAIL counter</span><br><span> fail() {</span><br><sp=
an>     output &quot;FAIL: $@\n&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    fail_count=3D$(($fail_count + 1))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    fail_count=3D$((fail_count + 1))</spa=
n><br><span> }</span><br><span> </span><br><span> # print &quot;all interfa=
ce IP addresses&quot; + &quot;all routes&quot;</span><br><span>@@ -380,7 +3=
80,7 @@</span><br><span>             ovpn_init_check=3D0</span><br><span>  =
           ovpn_init_success=3D1</span><br><span>         fi</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        ovpn_init_check=3D$(($ovpn_i=
nit_check - 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ovpn_init_check=3D$((ovpn_init_check - 1))</span><br><span>     done</s=
pan><br><span> </span><br><span>     opid=3D$(cat $pidfile)</span><br><span=
>diff --git a/tests/t_lpback=2Esh b/tests/t_lpback=2Esh</span><br><span>ind=
ex 8379f8f=2E=2E0617a30 100755</span><br><span>--- a/tests/t_lpback=2Esh</s=
pan><br><span>+++ b/tests/t_lpback=2Esh</span><br><span>@@ -57,13 +57,13 @@=
</span><br><span>             ;;</span><br><span>         esac</span><br><s=
pan>         e=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     tests_failed=3D$(($tests_failed + 1))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        tests_failed=3D$((tests_failed + 1))</span><=
br><span>     else</span><br><span>         case $V in</span><br><span>    =
     0 | 1) ;;       # no per-test output for &#39;OK&#39;</span><br><span>=
         *) echo &quot;OK&quot; ;; # print all</span><br><span>         esa=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tests_passed=
=3D$(($tests_passed + 1))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        tests_passed=3D$((tests_passed + 1))</span><br><span>     fi<=
/span><br><span> }</span><br><span> </span><br><span>diff --git a/tests/t_n=
et=2Esh b/tests/t_net=2Esh</span><br><span>index fbedb54=2E=2E60da693 10075=
5</span><br><span>--- a/tests/t_net=2Esh</span><br><span>+++ b/tests/t_net=
=2Esh</span><br><span>@@ -160,7 +160,7 @@</span><br><span> # remove interfa=
ce for good</span><br><span> $RUN_SUDO ip link del $IFACE</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-for i in $(seq $(($LA=
ST_AUTO_TEST + 1)) ${LAST_TEST}); do</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+for i in $(seq $((LAST_AUTO_TEST + 1)) ${LAST_TEST}); do</=
span><br><span>     $RUN_SUDO $UNIT_TEST $i</span><br><span>     if [ $? -n=
e 0 ]; then</span><br><span>         echo &quot;unit-test $i errored out&qu=
ot;</span><br><span>diff --git a/tests/t_server_null_client=2Esh b/tests/t_=
server_null_client=2Esh</span><br><span>index 2741d5d=2E=2E81eb138 100755</=
span><br><span>--- a/tests/t_server_null_client=2Esh</span><br><span>+++ b/=
tests/t_server_null_client=2Esh</span><br><span>@@ -158,7 +158,7 @@</span><=
br><span>             continue</span><br><span>         fi</span><br><span>=
         if $RUN_SUDO kill -0 $server_pid &gt;/dev/null 2&gt;&amp;1; then</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            servers_up=
=3D$(($servers_up + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            servers_up=3D$((servers_up + 1))</span><br><span>         f=
i</span><br><span>     done</span><br><span> </span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1794?usp=3Demail">change 1794</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1794?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newcha=
nge </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 1794 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</b=
ody></html>
--UUYaOlPdpk8=--


--===============3887782286606288841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3887782286606288841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3887782286606288841==--

