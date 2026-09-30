Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BDACA5FBE
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3wzoKg07lfqf5uDGKzqLoZaPoiSH81S7gbsJFR8PFHw=; b=asuysjqS7j+1Cj
	4JMrAJtjNHAwLEK7gaOAt9QetJIzY4uj/pMpwT9fIrn5cizRBcU6PXEU60id9RJqxWvQczAcMuNZP
	qm7NLlCIP2vmX0+1pfdLzHligaunzZmOFKuej6XrhukyK+SnNem4EqE/4PBJ4hSCBpVQnvtOUqDna
	JWE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBuGS-0003mw-PN;
	Wed, 30 Sep 2026 13:22:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBuGR-0003mo-K7
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:22:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rYrKnoMBtq1LBeNfNGaG/8nciVM9yPiBKERT+4VDrWo=; b=YobzU0WAGyq0TO5EqUzUz0UxvK
 xxwj+qB2GG2/YAXZIIBqENW1ERpALczsxQ4/B0AfopY/3mvR8QhyYW7Gq8zSUQICVHHhn6V9j/Apl
 Nc4NaWpxirDihHaLWwZmBk75V4vHg3w3YS2Y25wM6HtwcZHDGfHouRmxG6t4hLVdMdnE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rYrKnoMBtq1LBeNfNGaG/8nciVM9yPiBKERT+4VDrWo=; b=d
 2K+HSsUhZUrSpHrzqM8UnQv6B609GbzxUttLyN50BlG1KrZ2lDTcC3ITuc7U+lAXs7zGjjfNn50Pi
 H132zeJS9r+zQRbFSxdMkcMCyVv0kU7/5B/INCBYPU4UhG6iRifzHbDJu8TFvHaRrjdna+Zlz2SkT
 hAlo35sAS0qsxaVs=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBuGO-0005dN-5i for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:22:25 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48afd5b1678so514993f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 06:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790774537; x=1791379337; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rYrKnoMBtq1LBeNfNGaG/8nciVM9yPiBKERT+4VDrWo=;
 b=OA3eW5tIvVsiOUTYr29XnF+pmciZvGASor8gfvDCiB2m4s/2MIq+lCJhKoyoj8bN+d
 tiSHA4BRaq2GIOAdJi/97pMUQCDhwmwqf2xLt0ZiAH459IYDkEBbFrHNKx21iPlpWUTb
 Sg4NCNlj7hAAXGkQbVLXljw/yMSe2Us1bN26vAA4Uyfj7g7PXnvxVqS+3vjUprxGzeAb
 ic2MCzbe2JGP2bEJ72YghINAMnbRfmxkNH9NhL4VA69+rVDl8vXGqGNrsJJYA+5vU9Uu
 6qCmfe6bZ854rV0zGpXcqzLfGBAw012pU0mDuvI2QETYiCa8/nUzOXNN0iOim8VmXvn1
 R5hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790774537; x=1791379337;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rYrKnoMBtq1LBeNfNGaG/8nciVM9yPiBKERT+4VDrWo=;
 b=iM1aZnIGKyfCbKlgH5aoX1gPY4PKIBqepKSRQG7FcT+vTjV7MNznfmywJk0ZVVLA4o
 y6dRSF89N/ZFG+MyhjaXi3WcBJL39Sju3AyKVH2u8LBjbd1kLe60x3eytBZ1fS1OHUVt
 FNEq8SeWVzIt4AtQe7N+jkxrx7Z8k1TBm/oMyYWZZqsH8q9VlykhA8EXk8pWooZfpoKZ
 nfUlTdDo6vCh7nyZgOvSJV/62EYdXd+WYKZJugHPtLrExtten+ygjDIM0AkOrpR9LB+L
 Lfs4TtF4Fe0zHaRrE1pvIRTZbboOLNOc1d6ZrNIyXEW3JGpcWKv2cC8YCo1rWzHGt11U
 eYxA==
X-Gm-Message-State: AFq9FYL+w7jJPLBv1ppGkMa8KHp/hM0qsEoWKNAmIS78rh3+n+I1nHP9
 RQM0RSGEwfscg/IoUr6rXqRxf3JuOlboFWg+o/9NTne4uvwX4czB3a/nKfiqIoQ0tcapcPG0DHf
 b6oSdkpeEBfLqtpKN9fDDgz2wwNQlePrvNiocBRGJy/p/y+wfq6mGRgMFwjLdrDzcVYA99dvDUk
 Jh5ZYs7A==
X-Gm-Gg: AYBFou1lQVSVmQor0r7ITANGnoxS6ViCPJlpc2Mj630Xwikab0u1DzQIRENX2LLBXWn
 w7DtRjN0wy3kHrmqj0Q82quo8HahDMFbrHOqii1o7QPlAaZ5tHkR61kOhJ232vwMu875PuBns0n
 eu2Rk/Yej5hCZiwOvgFR6HOqZRHca38xgWKd6oZ0fMKuVv5cjW17E71/Hyt72fxs5S2C/TAaREx
 EIynsOJWM8jn618EMMMDqAdpwUuMK4lUuAOitHhawR6a64n6OwqBViWo2hj6ODAeRzonLa3j7AH
 GBplu/sjLRlMHkMRgMoGYpX3I3XL3IiK9CB2MsOFuazRODRjLLeG7XpTlIx9BkrtNbBbNzRj7bs
 uCQl8QaEYrsukPZUufPyS/NeqEQcx6pIPUTW5gnmOmPOQi2uXzp6GVw+Bt89lJJXoxlnxHWux2R
 1U8KZnUTGUB2FLEi6tmWMY4LY91E8TIqU5iXOk0ODyJSIPWKS3MaKty0L1d8NFDMVcjRb56o3sB
 BkCGELd9G8MSvMfOl+rc9UJBwTus+p0mkReQSkwSD9GAva+xj1Sa+PUP6yniUGLNq8q9+/yuR1j
 m9EtN4fOUi+T5+LR6pPb5OVVtcd2ypChKvGmZ+JblCNSJFpFuZfrKN5ANTpJ
X-Received: by 2002:a05:6000:22c4:b0:48a:fcfc:480c with SMTP id
 ffacd0b85a97d-48b024cb055mr3162552f8f.11.1790774537201; 
 Wed, 30 Sep 2026 06:22:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029d99bbsm3452225f8f.16.2026.09.30.06.22.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:22:16 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 13:22:16 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4
X-Gerrit-Change-Number: 1966
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1966?usp=email>
X-Gerrit-Commit: 7b017fd67a29249571bdddc41589f4993a97d004
References: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzc0NTIzMDAwLkk3NmMzMTBmOWU2OTI3NmQ0ZjIxYTRhZDMxYTI0NDkwNTUzZDZkNWM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6a6b9d37435ecefa7c981e0c989b9e78cd0c1258-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBuGO-0005dN-5i
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Review
 suppressions for constParameter and constParameterCa...
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
Content-Type: multipart/mixed; boundary="===============4634159465178937554=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4634159465178937554==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yyV3oRCcxNg="; charset=UTF-8

--yyV3oRCcxNg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1966?usp=3Demail

to review the following change=2E


Chang=
e subject: cppcheck: Review suppressions for constParameter and constParame=
terCallback
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

c=
ppcheck: Review suppressions for constParameter and constParameterCallback
=

I reviewed all the occurrences of the two cppcheck
errors constParameter a=
nd constParameterCallback=2E

All of constParameterCallback occurences were=
 bogus and
I think in most cases they will be=2E So continue to ignore
it c=
ompletely but document that we considered it and it
is not useful=2E

All e=
xisting cases of constParameter were bogus, but
there might be useful hits =
in the future so I only
suppress the existing occurrences=2E

Change-Id: I7=
6c310f9e69276d4f21a4ad31a24490553d6d5c4
Signed-off-by: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
---
M dev-tools/cppcheck-suppressions=2Exml
1 file =
changed, 20 insertions(+), 11 deletions(-)



  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/66/1966/1

diff --git a/dev-tools/cpp=
check-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index bd24=
c3b=2E=2E33337cf 100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/d=
ev-tools/cppcheck-suppressions=2Exml
@@ -3,23 +3,20 @@
   <!-- We start wit=
h enable=3Dall, but then suppress some issues that have too many
        oc=
curences right now=2E They still should be fixed at some point -->
   <supp=
ress>
-    <id>constParameter</id>
-  </suppress>
-  <suppress>
-    <id>co=
nstParameterCallback</id>
-  </suppress>
-  <suppress>
     <id>unusedFunct=
ion</id>
   </suppress>
   <suppress>
     <id>usleepCalled</id>
   </suppr=
ess>
-  <!-- We have a lot of library includes, not all of them are really =
required,
+  <!-- These are specific false-positives (FP) or ignored (IGN) =
issues
+       We might want to move some of them to inline-suppression to =
avoid
+       the static line-numbers -->
+  <!-- IGN: We have a lot of lib=
rary includes, not all of them are really required,
        so ignore them =
-->
   <suppress>
     <id>missingIncludeSystem</id>
   </suppress>
-  <!--=
 cppcheck doesn't understand about check_malloc_return, so these are
+  <!-=
- FP: cppcheck doesn't understand about check_malloc_return, so these are
 =
       usually misleading -->
   <suppress>
     <id>nullPointerOutOfMemory=
</id>
@@ -27,9 +24,6 @@
   <suppress>
     <id>nullPointerArithmeticOutOfMe=
mory</id>
   </suppress>
-  <!-- These are specific false-positives (FP) or=
 ignored (IGN) issues
-       We might want to move some of them to inline-=
suppression to avoid
-       the static line-numbers -->
   <!-- IGN: posix=
=2Ecfg: We are not threadsafe -->
   <suppress>
     <id>getgrnamCalled</id=
>
@@ -62,6 +56,11 @@
     <id>badBitmaskCheck</id>
     <fileName>tests/uni=
t_tests/openvpn/test_pkt=2Ec</fileName>
   </suppress>
+  <!-- FP: All occu=
rrences are either external types or types that
+       explicitly need to =
be non-const in some variants of the callback -->
+  <suppress>
+    <id>co=
nstParameterCallback</id>
+  </suppress>
   <!-- IGN: we use casts to remov=
e const -->
   <suppress>
     <id>constParameterPointer</id>
@@ -74,6 +73,=
12 @@
     <fileName>src/openvpn/buffer=2Ec</fileName>
     <symbolName>buf=
</symbolName>
   </suppress>
+  <!-- FP: can't change the signature of wmai=
n -->
+  <suppress>
+    <id>constParameter</id>
+    <fileName>src/openvpn=
/openvpn=2Ec</fileName>
+    <symbolName>wargv</symbolName>
+  </suppress>
=
   <!-- IGN: external -->
   <suppress>
     <id>constParameterPointer</id>=

@@ -81,6 +86,10 @@
   </suppress>
   <!-- IGN: too many false-positives du=
e to stubs -->
   <suppress>
+    <id>constParameter</id>
+    <fileName>te=
sts/unit_tests/openvpn*/test_*</fileName>
+  </suppress>
+  <suppress>
    =
 <id>constParameterPointer</id>
     <fileName>tests/unit_tests/openvpn*/te=
st_*</fileName>
   </suppress>

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1966?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerri=
t-Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4
Gerrit-Change-Number=
: 1966
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: open=
vpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plais=
thos <arne-openvpn@rfc2549=2Eorg>

--yyV3oRCcxNg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">cppcheck: Review suppressions for constParameter and constParameterCal=
lback<br><br>I reviewed all the occurrences of the two cppcheck<br>errors c=
onstParameter and constParameterCallback=2E<br><br>All of constParameterCal=
lback occurences were bogus and<br>I think in most cases they will be=2E So=
 continue to ignore<br>it completely but document that we considered it and=
 it<br>is not useful=2E<br><br>All existing cases of constParameter were bo=
gus, but<br>there might be useful hits in the future so I only<br>suppress =
the existing occurrences=2E<br><br>Change-Id: I76c310f9e69276d4f21a4ad31a24=
490553d6d5c4<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt;<br>---<br>M dev-tools/cppcheck-suppressions=2Exml<br>1 file changed, =
20 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/66/1966/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppress=
ions=2Exml</span><br><span>index bd24c3b=2E=2E33337cf 100644</span><br><spa=
n>--- a/dev-tools/cppcheck-suppressions=2Exml</span><br><span>+++ b/dev-too=
ls/cppcheck-suppressions=2Exml</span><br><span>@@ -3,23 +3,20 @@</span><br>=
<span>   &lt;!-- We start with enable=3Dall, but then suppress some issues =
that have too many</span><br><span>        occurences right now=2E They sti=
ll should be fixed at some point --&gt;</span><br><span>   &lt;suppress&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;constPa=
rameter&lt;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &=
lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt=
;suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;=
id&gt;constParameterCallback&lt;/id&gt;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  &lt;suppress&gt;</span><br><span>     &lt;id&gt;unusedFun=
ction&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span>   &l=
t;suppress&gt;</span><br><span>     &lt;id&gt;usleepCalled&lt;/id&gt;</span=
><br><span>   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  &lt;!-- We have a lot of library includes, not all of them are =
really required,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &=
lt;!-- These are specific false-positives (FP) or ignored (IGN) issues</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+       We might want to =
move some of them to inline-suppression to avoid</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+       the static line-numbers --&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: We have a lot=
 of library includes, not all of them are really required,</span><br><span>=
        so ignore them --&gt;</span><br><span>   &lt;suppress&gt;</span><br=
><span>     &lt;id&gt;missingIncludeSystem&lt;/id&gt;</span><br><span>   &l=
t;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;=
!-- cppcheck doesn&#39;t understand about check_malloc_return, so these are=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppch=
eck doesn&#39;t understand about check_malloc_return, so these are</span><b=
r><span>        usually misleading --&gt;</span><br><span>   &lt;suppress&g=
t;</span><br><span>     &lt;id&gt;nullPointerOutOfMemory&lt;/id&gt;</span><=
br><span>@@ -27,9 +24,6 @@</span><br><span>   &lt;suppress&gt;</span><br><s=
pan>     &lt;id&gt;nullPointerArithmeticOutOfMemory&lt;/id&gt;</span><br><s=
pan>   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  &lt;!-- These are specific false-positives (FP) or ignored (IGN) issue=
s</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       We might want=
 to move some of them to inline-suppression to avoid</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-       the static line-numbers --&gt;</span=
><br><span>   &lt;!-- IGN: posix=2Ecfg: We are not threadsafe --&gt;</span>=
<br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;getgrnamCalled=
&lt;/id&gt;</span><br><span>@@ -62,6 +56,11 @@</span><br><span>     &lt;id&=
gt;badBitmaskCheck&lt;/id&gt;</span><br><span>     &lt;fileName&gt;tests/un=
it_tests/openvpn/test_pkt=2Ec&lt;/fileName&gt;</span><br><span>   &lt;/supp=
ress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- F=
P: All occurrences are either external types or types that</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+       explicitly need to be non-con=
st in some variants of the callback --&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    &lt;id&gt;constParameterCallback&lt;/id&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span=
><br><span>   &lt;!-- IGN: we use casts to remove const --&gt;</span><br><s=
pan>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;constParameterPointe=
r&lt;/id&gt;</span><br><span>@@ -74,6 +73,12 @@</span><br><span>     &lt;fi=
leName&gt;src/openvpn/buffer=2Ec&lt;/fileName&gt;</span><br><span>     &lt;=
symbolName&gt;buf&lt;/symbolName&gt;</span><br><span>   &lt;/suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: can&#39=
;t change the signature of wmain --&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &lt;id&gt;constParameter&lt;/id&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/open=
vpn=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;symbolName&gt;wargv&lt;/symbolName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span>   &l=
t;!-- IGN: external --&gt;</span><br><span>   &lt;suppress&gt;</span><br><s=
pan>     &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span>@@ -81,=
6 +86,10 @@</span><br><span>   &lt;/suppress&gt;</span><br><span>   &lt;!--=
 IGN: too many false-positives due to stubs --&gt;</span><br><span>   &lt;s=
uppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;=
id&gt;constParameter&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    &lt;fileName&gt;tests/unit_tests/openvpn*/test_*&lt;/fileNa=
me&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppre=
ss&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppres=
s&gt;</span><br><span>     &lt;id&gt;constParameterPointer&lt;/id&gt;</span=
><br><span>     &lt;fileName&gt;tests/unit_tests/openvpn*/test_*&lt;/fileNa=
me&gt;</span><br><span>   &lt;/suppress&gt;</span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail">c=
hange 1966</a>=2E To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Cha=
nge-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4 </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Number: 1966 </div>
<div style=3D"display:none"> G=
errit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--yyV3oRCcxNg=--


--===============4634159465178937554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4634159465178937554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4634159465178937554==--

