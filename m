Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7477CA5FF0
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 16:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5QMTjmAt9KMXsuY0lvZio+LoofIdJ2AsjhVkkMe+Jc=; b=XF5pUtm+sCLWPfdhkYws473OZA
	zj4gxamy5lY7WHM58VtGXjWIE8i6iWdhCHSzT9hwCr2DkYNNe/RPoA8Kp1hsw0HhHWWhuE8BXwb6m
	3UoA+J7mm2ZqM9k0gVZ+tIejMj68ht21OnUDAqnllsZXCj4C7AS5Eivcm3IQCq4E5Qdo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDld9-00056j-47;
	Mon, 05 Oct 2026 16:33:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDlcs-00056S-7T
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 16:33:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=z8tkyq1rXWqP4U/hj50/WNurrutcqVXK2VSRFHYCkRs=; b=D61zAMaKemh+nALXRQVyqTPSMJ
 Vxd5Oqb1vhT3K0w8A98e3BNbv2eOfQ/5ZUC3or+0iLOUNBibKp9uUZyHpyl03P5MyljaFfJdmW5Zx
 XvY+pt9LyeTDBTSLVNf+jGhR6nYvRfSKMykBficCFQIWqF4EmqNJjsY/6BBJRvgNQ0y8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=z8tkyq1rXWqP4U/hj50/WNurrutcqVXK2VSRFHYCkRs=; b=f
 JO5zJKs+P2jsODZhsc1vRlcVDZSm3xSzg5bpIZ54v3fiQiXEOm0h1DXBAZCLxZlogiNttnu9k+iXJ
 +Ytn87FsIR+YRfAM09KMXbf6gL9BXzVmgpQpi2KSi55pX124SZ8S5HNoIpfhGcsNuQjNWYOR0t3JA
 85pwmI6n3BkbyBvs=;
Received: from mail-wr2-f18.google.com ([74.125.225.82])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDlcn-000486-Jy for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 16:33:15 +0000
Received: by mail-wr2-f18.google.com with SMTP id
 ffacd0b85a97d-48b0fc598f8so1250562f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 09:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791217987; x=1791822787; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=z8tkyq1rXWqP4U/hj50/WNurrutcqVXK2VSRFHYCkRs=;
 b=MKw1sdu7SEKN4rIqjqbLfUKYTPv88p3UI4CdlIOXpM2xVj1FFHByptjW7exd+riDYb
 LXX1Df6cLk3kLtZ9W/ylo/1JEXOX6pwB/MtYeyrjva+k5WSp6nzpDp4oEDcD5xjn3ABo
 GdLNo1afiEpH2nQojx7PfFninye/bXLchA+63lZFV+t62znd99WRXCSTp1ON6hE0frbf
 F1Aivlq7HOTQO8UaTeHJpsKALHtsPGk3dKkinXqSNPh8snXcE0MwbSQoPEBk40nN2rL+
 5l4ugGbAuT712x4Hzd7Top57fEkM7tBHb2Mqd8GLPs3zvfAJZedMBlmCSOHPzsaU4i39
 nuTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791217987; x=1791822787;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=z8tkyq1rXWqP4U/hj50/WNurrutcqVXK2VSRFHYCkRs=;
 b=qvBgZmnr3m9jZbgmVgEfvlJH4dpUBpFYF42yTxFdB8lMC//983vKd26KNXp1oPZvB0
 KQytoJpNxfwjJOGReBwayoAu3IYswxtELFV+Q+D1by7EQwvJjc9WhOJCpG/VyKi+7yFO
 UyJTQPyrXPjhrfTQ0sszqICTqIqQlqREJDiQ5WnZU5Xo9F3i4z+Q9XZqwXbNqvPWq78z
 +0V+WeobALqRFkhHfIse/23sz7gvzwzlUx4BSfW/kUBSqz7/lDDJ7P75/rIFH/sy3Plx
 //bKFWVcMmewfgoTW5kSw/VNfmE2bsy0l2Gxab8oIc7A1wLGStBMUPKeIA+r2XgT8HLj
 6GGg==
X-Gm-Message-State: AFq9FYLGErXuI5cpv2X0uI1x29kJAxXnB0TeWhhwlpQqR6Ol2D1TEURZ
 fvFWwg56dBA1BMN9JtcTokiaCLLa1cEHdurNCL15lLd7L7ULxyw5Hcx1bSYsmTzfGIyAiDkf+ZP
 5nDGrFnzUQwbJTvuTA8i5zi8rT10pZ6idIytTEzl6ErBeq9UYt463XUeG+KAq6ufILJxR
X-Gm-Gg: AYBFou1QTqhdgbsDpX7+ZXOxGapnaRJ4FEcazhpAdNlmLhk8Nmrz+4Td2z14EBl2g0j
 YZQ+r7W40D/JCoCVTk0X8wI0mjZ7lF3fM3X4eW7sQ7M2yd6GPwhdRAvLzKxzmvN3cM5+tlfH45d
 Joe4YtvtPwZzefolv3wAG7oa/zGhYXFgcP/4GVOSQZSYYRBTUJZ5GKOoN87KHqp1ty9tGDtLEgq
 0KItyUfwA0YzMxRA+vgTMA0OthfaKwHQh2pdaeiDoPGzMyHi5ni7CmazfmoYfv56lKNilWoR8V9
 W1Ra38KJwK9MtxyewhqxHZ8EaE0wu2lv4AvHyMjM+lpouAJtjTs+xrq3rIrA6eGxRHAm+kftBbw
 fRgCRkIOfx5EeTCSeiqvrnBuvq540hdm9tFDfwKJiq32UbYq2fDUHgEtJnplFJhXa/nESWL5n61
 jK1/0udffZ22nNMd2UOIoQWOq7PTDjiDZHIqDeFI0mSrDWaNioqzqvr2qv4myJn6UILqkvcm9kI
 HuhFgYz1p8sgyYo/xM2eWbRBN0wz0RSjyrK5oIo5Emxkim498D7aF6hpljVyJk4T8OswSLDlkrp
 LqIYdVYTVZB+J113p93njgbg5FDUj6TvdRESEsZv5H6U/VXUMG8lqTeBBDOf
X-Received: by 2002:a05:6000:18a8:b0:487:57d:18e4 with SMTP id
 ffacd0b85a97d-48b1276ad48mr19788119f8f.41.1791217986736; 
 Mon, 05 Oct 2026 09:33:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6229e025sm4526567f8f.31.2026.10.05.09.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 09:33:06 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 16:33:01 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4
X-Gerrit-Change-Number: 1966
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1966?usp=email>
X-Gerrit-Commit: abedf686ff07f8b314a0caf63867014a5b24533b
In-Reply-To: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
References: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzc0NTIzMDAwLkk3NmMzMTBmOWU2OTI3NmQ0ZjIxYTRhZDMxYTI0NDkwNTUzZDZkNWM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <adc79dc59220ad1e406add115f5f1c8e50e953f4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDlcn-000486-Jy
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6269867499266712455=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6269867499266712455==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2F2zi7/j9Bo="; charset=UTF-8

--2F2zi7/j9Bo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Gert Doering, 

I'd like you to reexamine a change=2E Pl=
ease visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail=


to look at the new patch set (#3)=2E

The change is no longer submittable=
: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject: cppcheck:=
 Review suppressions for constParameter and constParameterCallback
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: Review su=
ppressions for constParameter and constParameterCallback

I reviewed all th=
e occurrences of the two cppcheck
errors constParameter and constParameterC=
allback=2E

All of constParameterCallback occurences were bogus and
I think=
 in most cases they will be=2E So continue to ignore
it completely but docu=
ment that we considered it and it
is not useful=2E

All existing cases of c=
onstParameter were bogus, but
there might be useful hits in the future so I=
 only
suppress the existing occurrences=2E

Change-Id: I76c310f9e69276d4f21=
a4ad31a24490553d6d5c4
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
---
M dev-tools/cppcheck-suppressions=2Exml
1 file changed, 20 inse=
rtions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/66/1966/3

diff --git a/dev-tools/cppcheck-suppression=
s=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index bd24c3b=2E=2E33337cf =
100644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/cppcheck=
-suppressions=2Exml
@@ -3,23 +3,20 @@
   <!-- We start with enable=3Dall, b=
ut then suppress some issues that have too many
        occurences right no=
w=2E They still should be fixed at some point -->
   <suppress>
-    <id>co=
nstParameter</id>
-  </suppress>
-  <suppress>
-    <id>constParameterCallb=
ack</id>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   </sup=
press>
   <suppress>
     <id>usleepCalled</id>
   </suppress>
-  <!-- We h=
ave a lot of library includes, not all of them are really required,
+  <!--=
 These are specific false-positives (FP) or ignored (IGN) issues
+       We=
 might want to move some of them to inline-suppression to avoid
+       the=
 static line-numbers -->
+  <!-- IGN: We have a lot of library includes, no=
t all of them are really required,
        so ignore them -->
   <suppress>=

     <id>missingIncludeSystem</id>
   </suppress>
-  <!-- cppcheck doesn't=
 understand about check_malloc_return, so these are
+  <!-- FP: cppcheck do=
esn't understand about check_malloc_return, so these are
        usually mi=
sleading -->
   <suppress>
     <id>nullPointerOutOfMemory</id>
@@ -27,9 +2=
4,6 @@
   <suppress>
     <id>nullPointerArithmeticOutOfMemory</id>
   </su=
ppress>
-  <!-- These are specific false-positives (FP) or ignored (IGN) is=
sues
-       We might want to move some of them to inline-suppression to av=
oid
-       the static line-numbers -->
   <!-- IGN: posix=2Ecfg: We are no=
t threadsafe -->
   <suppress>
     <id>getgrnamCalled</id>
@@ -62,6 +56,11=
 @@
     <id>badBitmaskCheck</id>
     <fileName>tests/unit_tests/openvpn/t=
est_pkt=2Ec</fileName>
   </suppress>
+  <!-- FP: All occurrences are eithe=
r external types or types that
+       explicitly need to be non-const in s=
ome variants of the callback -->
+  <suppress>
+    <id>constParameterCallb=
ack</id>
+  </suppress>
   <!-- IGN: we use casts to remove const -->
   <s=
uppress>
     <id>constParameterPointer</id>
@@ -74,6 +73,12 @@
     <fileN=
ame>src/openvpn/buffer=2Ec</fileName>
     <symbolName>buf</symbolName>
   =
</suppress>
+  <!-- FP: can't change the signature of wmain -->
+  <suppres=
s>
+    <id>constParameter</id>
+    <fileName>src/openvpn/openvpn=2Ec</fil=
eName>
+    <symbolName>wargv</symbolName>
+  </suppress>
   <!-- IGN: exte=
rnal -->
   <suppress>
     <id>constParameterPointer</id>
@@ -81,6 +86,10 =
@@
   </suppress>
   <!-- IGN: too many false-positives due to stubs -->
  =
 <suppress>
+    <id>constParameter</id>
+    <fileName>tests/unit_tests/op=
envpn*/test_*</fileName>
+  </suppress>
+  <suppress>
     <id>constParamet=
erPointer</id>
     <fileName>tests/unit_tests/openvpn*/test_*</fileName>
 =
  </suppress>

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1966?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: ne=
wpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
76c310f9e69276d4f21a4ad31a24490553d6d5c4
Gerrit-Change-Number: 1966
Gerrit-=
PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--2F2zi7/j9Bo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Frank Lich=
tenheld <strong>uploaded patch set #3</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail">View Ch=
ange</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule=
 is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">cppcheck: Review suppressions for c=
onstParameter and constParameterCallback<br><br>I reviewed all the occurren=
ces of the two cppcheck<br>errors constParameter and constParameterCallback=
=2E<br><br>All of constParameterCallback occurences were bogus and<br>I thi=
nk in most cases they will be=2E So continue to ignore<br>it completely but=
 document that we considered it and it<br>is not useful=2E<br><br>All exist=
ing cases of constParameter were bogus, but<br>there might be useful hits i=
n the future so I only<br>suppress the existing occurrences=2E<br><br>Chang=
e-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-sup=
pressions=2Exml<br>1 file changed, 20 insertions(+), 11 deletions(-)<br><br=
></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/66/1966/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppressions=
=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>index bd24c3=
b=2E=2E33337cf 100644</span><br><span>--- a/dev-tools/cppcheck-suppressions=
=2Exml</span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</span><b=
r><span>@@ -3,23 +3,20 @@</span><br><span>   &lt;!-- We start with enable=
=3Dall, but then suppress some issues that have too many</span><br><span>  =
      occurences right now=2E They still should be fixed at some point --&g=
t;</span><br><span>   &lt;suppress&gt;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    &lt;id&gt;constParameter&lt;/id&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;constParameterCallback&lt;/id=
&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&g=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&gt;<=
/span><br><span>     &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><span>  =
 &lt;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>    =
 &lt;id&gt;usleepCalled&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- We have a lot o=
f library includes, not all of them are really required,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- These are specific false-pos=
itives (FP) or ignored (IGN) issues</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+       We might want to move some of them to inline-suppres=
sion to avoid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
 the static line-numbers --&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;!-- IGN: We have a lot of library includes, not all of th=
em are really required,</span><br><span>        so ignore them --&gt;</span=
><br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;missingInclud=
eSystem&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- cppcheck doesn&#39;t understand=
 about check_malloc_return, so these are</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;!-- FP: cppcheck doesn&#39;t understand about ch=
eck_malloc_return, so these are</span><br><span>        usually misleading =
--&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;n=
ullPointerOutOfMemory&lt;/id&gt;</span><br><span>@@ -27,9 +24,6 @@</span><b=
r><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;nullPointerArith=
meticOutOfMemory&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- These are specific fal=
se-positives (FP) or ignored (IGN) issues</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-       We might want to move some of them to inline-sup=
pression to avoid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
   the static line-numbers --&gt;</span><br><span>   &lt;!-- IGN: posix=2Ec=
fg: We are not threadsafe --&gt;</span><br><span>   &lt;suppress&gt;</span>=
<br><span>     &lt;id&gt;getgrnamCalled&lt;/id&gt;</span><br><span>@@ -62,6=
 +56,11 @@</span><br><span>     &lt;id&gt;badBitmaskCheck&lt;/id&gt;</span>=
<br><span>     &lt;fileName&gt;tests/unit_tests/openvpn/test_pkt=2Ec&lt;/fi=
leName&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;!-- FP: All occurrences are either extern=
al types or types that</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+       explicitly need to be non-const in some variants of the callback =
--&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppres=
s&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;=
constParameterCallback&lt;/id&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;/suppress&gt;</span><br><span>   &lt;!-- IGN: we use ca=
sts to remove const --&gt;</span><br><span>   &lt;suppress&gt;</span><br><s=
pan>     &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span>@@ -74,=
6 +73,12 @@</span><br><span>     &lt;fileName&gt;src/openvpn/buffer=2Ec&lt;=
/fileName&gt;</span><br><span>     &lt;symbolName&gt;buf&lt;/symbolName&gt;=
</span><br><span>   &lt;/suppress&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  &lt;!-- FP: can&#39;t change the signature of wmain --&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;con=
stParameter&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;fileName&gt;src/openvpn/openvpn=2Ec&lt;/fileName&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;wargv&lt;=
/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &l=
t;/suppress&gt;</span><br><span>   &lt;!-- IGN: external --&gt;</span><br><=
span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;constParameterPoint=
er&lt;/id&gt;</span><br><span>@@ -81,6 +86,10 @@</span><br><span>   &lt;/su=
ppress&gt;</span><br><span>   &lt;!-- IGN: too many false-positives due to =
stubs --&gt;</span><br><span>   &lt;suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameter&lt;/id&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;tests/=
unit_tests/openvpn*/test_*&lt;/fileName&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span>     &lt;id&gt;c=
onstParameterPointer&lt;/id&gt;</span><br><span>     &lt;fileName&gt;tests/=
unit_tests/openvpn*/test_*&lt;/fileName&gt;</span><br><span>   &lt;/suppres=
s&gt;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1966?usp=3Demail">change 1966</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I76c310f9e69276d4f21a4ad3=
1a24490553d6d5c4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
1966 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ar=
ne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>

</body></html>
--2F2zi7/j9Bo=--


--===============6269867499266712455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6269867499266712455==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6269867499266712455==--

