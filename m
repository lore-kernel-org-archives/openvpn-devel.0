Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CF5C5DF6D
	for <openvpn-devel@archiver.kernel.org>; Wed, 19 Aug 2026 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c09/Q7wCwlyeqYbHcidhUiCX1wd8DtpD6KMYxuwi/xA=; b=Ft3uMEHHQKRLLIVyjBdrJfUitT
	J1adMkcLbI9+X1zqyTXoPbFRTGl3L6p06PkRj/xe85LxZIoMfP1YHKqtRBJvgAbistecv2eyk7Rrh
	IiqCi0W8wGpTT6/m7Sz7DgKe7FmWzrAck6wJwSwBTUyLyEalRbNj/zxLvqUu+IvDKQ0k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wweh5-0005wA-Sp;
	Wed, 19 Aug 2026 11:42:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wweh5-0005w0-44
 for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:42:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FY/obYP0nRwy0w2WSV44x25RpJYEypsMaQVzhcB5lbc=; b=it86PXWfp2NnfIoFkoQfZc0UBt
 v9NEiMCFUOXZBYZhD78UWFzJPmza6K9flJbRzu1oq18qzUSYaWieHA+XKp7YynZntKMAAysxQ5EQO
 7/xjVslD0Ns0iRsGkA96HP2xe9RFd3VTc7OGY0fw1I1dhdpBNc05GR4tGP6SNCaOMEXI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FY/obYP0nRwy0w2WSV44x25RpJYEypsMaQVzhcB5lbc=; b=W
 hW5NxjdgsT59nXmFaGQDyvINaTu2OdaNrOdT/5qvyJPunpVu4Cnx8psdYUOKruxyA6IdPTrekvYCT
 urcYVQH6CG60wCV3ix8Ub3UbV8zR5S9QvK+YRQ5jrf7La22XO2MK9K8jEj3U/qhnb52xYNBoxRvpx
 kGO80jp/fd1EnAm4=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wweh4-00040J-To for openvpn-devel@lists.sourceforge.net;
 Wed, 19 Aug 2026 11:42:55 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4998e0916faso7296185e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 19 Aug 2026 04:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787139768; x=1787744568; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FY/obYP0nRwy0w2WSV44x25RpJYEypsMaQVzhcB5lbc=;
 b=ekRATDoU/9UNsfxUerRZ7JHFLo+DJej40PggRuJ+7FgORvl58W9k3he0w2xJ9Vw9si
 hgbRgQVmAOaiel3AGNceTzsAg0K7DHToyl+kM9SN3u5hhVwO1vGTOTATp8E9Umvk2Ogv
 odity8wKVlnn2BagzB9tOmQ66ublVBNi0FndybfXs68kksrSC6i3uvJlFZkx9FBFKUqU
 MDH+rw7N4i6lAcb92lwt5vVqSYO/m+SlfLMsYaw+Q2/qahkpJarPbjs7quz6+QVQ0DXU
 isQISyzWCcP7dqdds9jRzxu9KBB9N+u8vFVSX3k4oiYZhvPmRc0cnMGtTIcsgj+kNUP+
 9mbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787139768; x=1787744568;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FY/obYP0nRwy0w2WSV44x25RpJYEypsMaQVzhcB5lbc=;
 b=rCT9nuIi7UyXXG+OMBFot95ewKMWMEZC1Z4JmVfpqb2CaUMF2qyzvmmv4p+NG9gv9A
 yQDQ6gDRqyHCHhxHlKb/Q1oHyC7xzX+V7TduoZ2b/LrGcBIFG5ShkgLKGwGTEDhw+erS
 c4GhJCcfgx7aFGqNgpFC1FrdMMEZKLC2I6gJ4t85BcH4303pmPeVXqIbHYUvyM/ksfU1
 G7+twi6ymJkh8NTAT6suat/5DQoeEbEpPDkym50sW85iRt3Zvq2gUbrvoEKQP1cBbG19
 1see6D2xy8qT+lPTziyXwyygZSRfdfmksXF6arWwFM2yM+gkT91XjpNwyodTgXd6p3eE
 N2lw==
X-Gm-Message-State: AOJu0YwebYv5guuCxrX4RTh2iie0ymp8YP1mg12f3a6PARQCqEczLBdc
 hXDpCkP5373eRMBobb2xYFUgRFtj5s0xMt17RTDb6E9FIrvxlyqzyTkIHMy9LATHdkmHkgB5qpY
 eNKyB0O09UfMXyBa3jluUcFETJ/4GJcqa4AZYkmS8LNELdapvFSidQ/byeuJR4UeqPF61
X-Gm-Gg: AR+sD1178qy+a5RSgZjbe+TSpPkBj2PWFqQXgrWKtkiIf3YrG7leHoCpt+dtP/Klv8g
 hT0XvzWHv2zjtWL8HnAxOg6kb55OhItW0v/DFcIRz/ftEWg8eussjvmEEMz+3gnYDnpyw6vhfow
 39z0iWCUMmaC1iAnVzgKtaG6PzpdsHB22BsgoyJBip72hGm0mXvLZiqbw43hUe7iXRJA9cfPbeS
 vbX79/Wk8PxyG3HA4JJ4MCp1uVTis+Ey4fLZYw0gw0iDAbiAd3rZ9FKriAqtV+3+FXuVVe1Lzdn
 yfY1ogjzf6BMa2L2I3OkzkcJh0EC9gw+E8XGbm28kJyDj6jRHGPwY3k5FhtTRDODJ99iLyQ2xU4
 dVxpqzIKXXPTuzYd0AdBkwiScvvD4ml8aGsBKCNfoENO5mSuSqEQ2BDOdUvF2Ho2/LBL8G7lEsi
 lGluQGVowZyT3u2GATAJ0tFqJTmyixB3Hr3FjpSmOTJMJ5SoKN5h90FSgpkul5Lb7O5QuaNchD/
 uqZFQLIdA1+YOlmGSjauwxHzvSxxxoDjr49fcsl5GWL0j4DjhJmHobhD03QzE6g09MjVS+/pJAm
 zbtUQDAVhl1mCZPqCjcsiYk9HcUPIJFm9IlVmHtxr0Uy9GPY8yo=
X-Received: by 2002:a05:600c:524f:b0:499:795a:c5fc with SMTP id
 5b1f17b1804b1-499aa17baafmr64970255e9.7.1787139768235; 
 Wed, 19 Aug 2026 04:42:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e805a4sm60480765e9.4.2026.08.19.04.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 04:42:47 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 19 Aug 2026 11:42:39 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
X-Gerrit-Change-Number: 1794
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1794?usp=email>
X-Gerrit-Commit: b42913ddd189da668b5aa8c7bb5ba7d3a80c845a
In-Reply-To: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
References: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MzA1MzAzMDAwLklkNGQwNGJlYmRiOGIyY2I1NmU4ZGQxNmEzODZjNDFmZGI5NWMwNDEzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d00051b5657fa480a60a2e491b85b11597557c75-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wweh4-00040J-To
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3159559459578953520=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3159559459578953520==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P/5tnPiWr1o="; charset=UTF-8

--P/5tnPiWr1o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello pla=
isthos, razvanc, 

I'd like you to reexamine a change=2E Please visit

    =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail

to look at the =
new patch set (#3)=2E

The change is no longer submittable: checks~ChecksSu=
bmitRule is unsatisfied now=2E


Change subject: reformat-shell=2Esh: Add -=
-simplify argument
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

reformat-shell=2Esh: Add --simplify argument

And apply the changes=
=2E

Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
Signed-off-by: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
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
/1794/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@l=
ichtenheld=2Ecom>

--P/5tnPiWr1o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>flichtenheld <stro=
ng>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail">View Change</a></p><p=
>The change is no longer submittable: checks~ChecksSubmitRule is unsatisfie=
d now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">reformat-shell=2Esh: Add --simplify argument<br><=
br>And apply the changes=2E<br><br>Change-Id: Id4d04bebdb8b2cb56e8dd16a386c=
41fdb95c0413<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt;<br>---<br>M dev-tools/reformat-shell=2Esh<br>M tests/t_client=2Esh=2E=
in<br>M tests/t_lpback=2Esh<br>M tests/t_net=2Esh<br>M tests/t_server_null_=
client=2Esh<br>5 files changed, 7 insertions(+), 7 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/94/1794/3</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/dev-tools/reformat-shell=2Esh b/dev-to=
ols/reformat-shell=2Esh</span><br><span>index dbbdaa9=2E=2Ed76eae7 100755</=
span><br><span>--- a/dev-tools/reformat-shell=2Esh</span><br><span>+++ b/de=
v-tools/reformat-shell=2Esh</span><br><span>@@ -5,7 +5,7 @@</span><br><span=
> </span><br><span> set -u</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-FORMAT_ARGS=3D&quot;--indent=3D4 --func-next-line --=
case-indent&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+FO=
RMAT_ARGS=3D&quot;--simplify --indent=3D4 --func-next-line --case-indent&qu=
ot;</span><br><span> FORMAT_CMD=3D&quot;shfmt --list --write&quot;</span><b=
r><span> </span><br><span> # hardcoded to --posix due to =2Ein filename and=
 invalid shebang</span><br><span>diff --git a/tests/t_client=2Esh=2Ein b/te=
sts/t_client=2Esh=2Ein</span><br><span>index 305441be=2E=2E230a273 100755</=
span><br><span>--- a/tests/t_client=2Esh=2Ein</span><br><span>+++ b/tests/t=
_client=2Esh=2Ein</span><br><span>@@ -155,7 +155,7 @@</span><br><span> fail=
()</span><br><span> {</span><br><span>     output &quot;FAIL: $@\n&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    fail_count=3D$(($fai=
l_count + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fa=
il_count=3D$((fail_count + 1))</span><br><span> }</span><br><span> </span><=
br><span> # print &quot;all interface IP addresses&quot; + &quot;all routes=
&quot;</span><br><span>@@ -386,7 +386,7 @@</span><br><span>             ovp=
n_init_check=3D0</span><br><span>             ovpn_init_success=3D1</span><=
br><span>         fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       ovpn_init_check=3D$(($ovpn_init_check - 1))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        ovpn_init_check=3D$((ovpn_init_check=
 - 1))</span><br><span>     done</span><br><span> </span><br><span>     opi=
d=3D$(cat $pidfile)</span><br><span>diff --git a/tests/t_lpback=2Esh b/test=
s/t_lpback=2Esh</span><br><span>index 058206f=2E=2Eec0a220 100755</span><br=
><span>--- a/tests/t_lpback=2Esh</span><br><span>+++ b/tests/t_lpback=2Esh<=
/span><br><span>@@ -59,13 +59,13 @@</span><br><span>                 ;;</sp=
an><br><span>         esac</span><br><span>         e=3D1</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        tests_failed=3D$(($tests_failed=
 + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests=
_failed=3D$((tests_failed + 1))</span><br><span>     else</span><br><span> =
        case $V in</span><br><span>             0 | 1) ;;       # no per-te=
st output for &#39;OK&#39;</span><br><span>             *) echo &quot;OK&qu=
ot; ;; # print all</span><br><span>         esac</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        tests_passed=3D$(($tests_passed + 1))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests_passed=
=3D$((tests_passed + 1))</span><br><span>     fi</span><br><span> }</span><=
br><span> </span><br><span>diff --git a/tests/t_net=2Esh b/tests/t_net=2Esh=
</span><br><span>index 17e028e=2E=2Ed63f648 100755</span><br><span>--- a/te=
sts/t_net=2Esh</span><br><span>+++ b/tests/t_net=2Esh</span><br><span>@@ -1=
62,7 +162,7 @@</span><br><span> # remove interface for good</span><br><span=
> $RUN_SUDO ip link del $IFACE</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_T=
EST}); do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+for i in $=
(seq $((LAST_AUTO_TEST + 1)) ${LAST_TEST}); do</span><br><span>     $RUN_SU=
DO $UNIT_TEST $i</span><br><span>     if [ $? -ne 0 ]; then</span><br><span=
>         echo &quot;unit-test $i errored out&quot;</span><br><span>diff --=
git a/tests/t_server_null_client=2Esh b/tests/t_server_null_client=2Esh</sp=
an><br><span>index 3203cc2=2E=2E9f4168b 100755</span><br><span>--- a/tests/=
t_server_null_client=2Esh</span><br><span>+++ b/tests/t_server_null_client=
=2Esh</span><br><span>@@ -164,7 +164,7 @@</span><br><span>             cont=
inue</span><br><span>         fi</span><br><span>         if $RUN_SUDO kill=
 -0 $server_pid &gt;/dev/null 2&gt;&amp;1; then</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            servers_up=3D$(($servers_up + 1))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            servers_up=
=3D$((servers_up + 1))</span><br><span>         fi</span><br><span>     don=
e</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3Demail">change 1=
794</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1794?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1794 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--P/5tnPiWr1o=--


--===============3159559459578953520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3159559459578953520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3159559459578953520==--

