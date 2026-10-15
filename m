Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF30CCA463
	for <openvpn-devel@archiver.kernel.org>; Thu, 15 Oct 2026 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cphik19+gd2+VSc+eqg9CYmsX/CIjoOas6QVbe4cKnM=; b=PjpHA5QCn4klanXHpfFkr3QytJ
	zRF61I25S3DNkFnUs8e/WGPM0QQ3y8U2AmaO/nUQA576yUfLZiKSwvxkAFYabGIYhFLImokH53Cv3
	51EyG7BDU1Px7RUq0jsKWE8d4BwX7LPHOUP5C9ia2r3vkXUFPqvs5im4C4d++FTWt21s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHNR7-00015v-OR;
	Thu, 15 Oct 2026 15:32:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHNR6-00015b-7A
 for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:32:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=eqjA8CRCOamJQx4ecvnIO4ixASOoVEgt1BJa/JA6V5Y=; b=E5EX212M6Re6IsRPecDqMgYe74
 Y1p20FH4dPKYt6agfoCb4uYPu9LC0zoMSkKYP2dwef/EmEJwQ3AAIenJox9RzN7WJUrYreH8FP/Qq
 1NRzV0bJ7h1Bq1mPUg5oAHC1n2YNoP6xHupPl43OExKgzD+T9yQXy3xxHXBm3cxpE3gM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=eqjA8CRCOamJQx4ecvnIO4ixASOoVEgt1BJa/JA6V5Y=; b=N
 vfuVQCCRiD0hSlDh54vHFa9svPJ3pSR5Zwunk1sWhKThhJe2Azwv48mXgpwGk2jPKuUsOIOEJ2Gyy
 dbolPVGIOIHFSUOYtj3mkgVes7DUn4BNbdeuDyHJRJYYnvgO0s4mjZXh+wBwKJifgIrrwQUdx32P/
 uNkOD5FV0AG1IMrk=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHNQw-0003x1-CE for openvpn-devel@lists.sourceforge.net;
 Thu, 15 Oct 2026 15:31:58 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso572844f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 08:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792078308; x=1792683108; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eqjA8CRCOamJQx4ecvnIO4ixASOoVEgt1BJa/JA6V5Y=;
 b=dC5gMN7DScsfnonGCFU8B31RFHFjmePIvG3dMalXClsJC0LhJEt1ltpVPdCn2f89vH
 OJtjKNTtncAH39o36UBfxHGifHOg5jT9ZZi/5eGephflo/8zqiaCWhr08nkOVaa/LoYT
 w8lq42yzQqiBHTalzuM8O36lNuO+fNDb0HxtfReUWIpylQoJ2uIBSXelVaqX5NmB51GY
 LFCQMa0Ez9XCVFmYEhP+XLo1IoDgQa9Zz59VlEhUJFkOkcfNWeisDMhnL795AGvdgWxc
 48EKk7O3Fktja2qIDR7tjj5g/7a7KfQO4Lz6siF7+MOr0ONqQt34yQvfAbtEZ43YZD46
 rsiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792078308; x=1792683108;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eqjA8CRCOamJQx4ecvnIO4ixASOoVEgt1BJa/JA6V5Y=;
 b=h62nthEOP+5Jy8WODNmYf0KNIAynEaivID7DkZ8kP/196UKxbfs33v7Qthu7wAj5tM
 tEqU13zntMME9KJb8+NTjfC9vEbKe+cJuMF+oN6dUwy4O6XdZlTbc5CKbxtWE7/yDO1W
 8cr2gSseGeNpA2GMnm153iIg2QK7IdfS3zOl48Sy+YMzc+yeULW2Df1eaNkTVmq4EXWQ
 nRu7pA9ndxX0or0DcPJAvRUSHq/ezepAuXLxtJZkYWgrG5uXWpZrblGmtdiXBrbLpcrp
 GbOX7h7SIo0XYu+rLMJztmjQVJMdg1biI9P6uEISC1rvf5xNZDsNHxLTHcYFst3gTd9h
 KLyg==
X-Gm-Message-State: AFq9FYJnW8KJ+kUMUOv+UlGiKSTcXNWENxAJxhgh64oz0WvFKgipisw8
 q/IIxCyWj+d1bSTn5j4Now0Ew0lxbOxhQpaCKaNz9kLtYDmsLAP0/GKN1lEm4WZyjCGIU/X195A
 5viZBjt6As7BnG9sDoc6bsWwS3w+7Q8QCkPWbCa5V4HCfUj4uYpsWhabMMCj4HmGM8ajG
X-Gm-Gg: AYBFou3J7SUmv87cTFSnT2/9lHvGl3KWa1bymsUO8vyU2qfuJGCJoE2d0CjsW6RaFIl
 tUR0X2b+FiHCrYvKPqCNgOkbNNIyUrjNlCWor1CgpqORmMhEhqasr56VQh8nRfhz08Gg+xYHZhd
 3Fm1YgsHQ9ZM1F/aqXrsphMFJ6nS8eXO+w+txy8Din6l+oAW/JR2Bv9MzWIKi4hOiWFS4cFCVr7
 olsU6GD1e65eg6PqQqOPpCqTYPpd5Wn1s/Y5Sm63ue3guhIcsjiiTPBxtKk4eUNoscJfzNOElQN
 KBJjUjBPvMvc+0qEoNTu1XkeWBm4YzunvV5CY5EgugqluF6Dc5lUhrP/z/D7uPsSVXclNtx62ST
 +FCexobn4gtGfpmiJ1YGfXOdataMaZrObBGSrYQ8fAfo2detmKeSEOi9/uS26l/AHnBuHuvNhSo
 eFJmAyDMCkNSgAq6oQrnjC7TaHLAMCRx6rZTZ950/9uNxycEAMaB/kxoXwctqfr3BS14aw3JjGU
 ucCyKRLb5QDwPE4OwcgQC0mHQDHOtDyCTUe0Ebl9dMSrSCSMLcnXP4tgrv88sjFAicAH3FaFvwo
 azGO8ZFtzdFYUCBkCc0KdWouFdOATOxmagS3jA2CGyZIKJ5QkUUZ5+0xksW5
X-Received: by 2002:a05:600c:3e8f:b0:4a0:263c:704f with SMTP id
 5b1f17b1804b1-4a18e4a3fbdmr397633685e9.16.1792078306578; 
 Thu, 15 Oct 2026 08:31:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bdbb4a30sm75987595e9.15.2026.10.15.08.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 08:31:45 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 15 Oct 2026 15:31:44 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4
X-Gerrit-Change-Number: 1966
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1966?usp=email>
X-Gerrit-Commit: 6d382d5e6932787f963d98293385cd691d8909b9
In-Reply-To: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
References: <gerrit.1790774523000.I76c310f9e69276d4f21a4ad31a24490553d6d5c4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzc0NTIzMDAwLkk3NmMzMTBmOWU2OTI3NmQ0ZjIxYTRhZDMxYTI0NDkwNTUzZDZkNWM0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <70f15ee41a5eee45bbdeb17ce7dfd1d12314dfdf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHNQw-0003x1-CE
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6046748794844512939=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6046748794844512939==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ojP+HACFTII="; charset=UTF-8

--ojP+HACFTII=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#7) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
966?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Gert Doering


Change subject: cppcheck: Review suppression=
s for constParameter and constParameterCallback
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: Review suppressions for constP=
arameter and constParameterCallback

I reviewed all the occurrences of the =
two cppcheck
errors constParameter and constParameterCallback=2E

All of co=
nstParameterCallback occurences were bogus and
I think in most cases they w=
ill be=2E So continue to ignore
it completely but document that we consider=
ed it and it
is not useful=2E

All existing cases of constParameter were bo=
gus, but
there might be useful hits in the future so I only
suppress the ex=
isting occurrences=2E

Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c4=

Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1966
Message-Id: <20261007172125=2E23573-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg39761=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M dev-tools/cppcheck-suppressions=2Exml
1 file changed, 20 inser=
tions(+), 11 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/66/1966/7

diff --git a/dev-tools/cppcheck-suppressions=
=2Exml b/dev-tools/cppcheck-suppressions=2Exml
index bd24c3b=2E=2E33337cf 1=
00644
--- a/dev-tools/cppcheck-suppressions=2Exml
+++ b/dev-tools/cppcheck-=
suppressions=2Exml
@@ -3,23 +3,20 @@
   <!-- We start with enable=3Dall, bu=
t then suppress some issues that have too many
        occurences right now=
=2E They still should be fixed at some point -->
   <suppress>
-    <id>con=
stParameter</id>
-  </suppress>
-  <suppress>
-    <id>constParameterCallba=
ck</id>
-  </suppress>
-  <suppress>
     <id>unusedFunction</id>
   </supp=
ress>
   <suppress>
     <id>usleepCalled</id>
   </suppress>
-  <!-- We ha=
ve a lot of library includes, not all of them are really required,
+  <!-- =
These are specific false-positives (FP) or ignored (IGN) issues
+       We =
might want to move some of them to inline-suppression to avoid
+       the =
static line-numbers -->
+  <!-- IGN: We have a lot of library includes, not=
 all of them are really required,
        so ignore them -->
   <suppress>
=
     <id>missingIncludeSystem</id>
   </suppress>
-  <!-- cppcheck doesn't =
understand about check_malloc_return, so these are
+  <!-- FP: cppcheck doe=
sn't understand about check_malloc_return, so these are
        usually mis=
leading -->
   <suppress>
     <id>nullPointerOutOfMemory</id>
@@ -27,9 +24=
,6 @@
   <suppress>
     <id>nullPointerArithmeticOutOfMemory</id>
   </sup=
press>
-  <!-- These are specific false-positives (FP) or ignored (IGN) iss=
ues
-       We might want to move some of them to inline-suppression to avo=
id
-       the static line-numbers -->
   <!-- IGN: posix=2Ecfg: We are not=
 threadsafe -->
   <suppress>
     <id>getgrnamCalled</id>
@@ -62,6 +56,11 =
@@
     <id>badBitmaskCheck</id>
     <fileName>tests/unit_tests/openvpn/te=
st_pkt=2Ec</fileName>
   </suppress>
+  <!-- FP: All occurrences are either=
 external types or types that
+       explicitly need to be non-const in so=
me variants of the callback -->
+  <suppress>
+    <id>constParameterCallba=
ck</id>
+  </suppress>
   <!-- IGN: we use casts to remove const -->
   <su=
ppress>
     <id>constParameterPointer</id>
@@ -74,6 +73,12 @@
     <fileNa=
me>src/openvpn/buffer=2Ec</fileName>
     <symbolName>buf</symbolName>
   <=
/suppress>
+  <!-- FP: can't change the signature of wmain -->
+  <suppress=
>
+    <id>constParameter</id>
+    <fileName>src/openvpn/openvpn=2Ec</file=
Name>
+    <symbolName>wargv</symbolName>
+  </suppress>
   <!-- IGN: exter=
nal -->
   <suppress>
     <id>constParameterPointer</id>
@@ -81,6 +86,10 @=
@
   </suppress>
   <!-- IGN: too many false-positives due to stubs -->
   =
<suppress>
+    <id>constParameter</id>
+    <fileName>tests/unit_tests/ope=
nvpn*/test_*</fileName>
+  </suppress>
+  <suppress>
     <id>constParamete=
rPointer</id>
     <fileName>tests/unit_tests/openvpn*/test_*</fileName>
  =
 </suppress>

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1966?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: new=
patchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7=
6c310f9e69276d4f21a4ad31a24490553d6d5c4
Gerrit-Change-Number: 1966
Gerrit-P=
atchSet: 7
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--ojP+HACFTII=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #7</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1966?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">cppche=
ck: Review suppressions for constParameter and constParameterCallback<br><b=
r>I reviewed all the occurrences of the two cppcheck<br>errors constParamet=
er and constParameterCallback=2E<br><br>All of constParameterCallback occur=
ences were bogus and<br>I think in most cases they will be=2E So continue t=
o ignore<br>it completely but document that we considered it and it<br>is n=
ot useful=2E<br><br>All existing cases of constParameter were bogus, but<br=
>there might be useful hits in the future so I only<br>suppress the existin=
g occurrences=2E<br><br>Change-Id: I76c310f9e69276d4f21a4ad31a24490553d6d5c=
4<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Ac=
ked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966<br>Message-Id: &lt;20261007172125=
=2E23573-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39761=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cp=
pcheck-suppressions=2Exml<br>1 file changed, 20 insertions(+), 11 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/66/1966/7</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-supp=
ressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>inde=
x bd24c3b=2E=2E33337cf 100644</span><br><span>--- a/dev-tools/cppcheck-supp=
ressions=2Exml</span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml<=
/span><br><span>@@ -3,23 +3,20 @@</span><br><span>   &lt;!-- We start with =
enable=3Dall, but then suppress some issues that have too many</span><br><s=
pan>        occurences right now=2E They still should be fixed at some poin=
t --&gt;</span><br><span>   &lt;suppress&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    &lt;id&gt;constParameter&lt;/id&gt;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&gt;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;constParameterCallback&lt=
;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppre=
ss&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&=
gt;</span><br><span>     &lt;id&gt;unusedFunction&lt;/id&gt;</span><br><spa=
n>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>=
     &lt;id&gt;usleepCalled&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- We have a l=
ot of library includes, not all of them are really required,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- These are specific false=
-positives (FP) or ignored (IGN) issues</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+       We might want to move some of them to inline-sup=
pression to avoid</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
     the static line-numbers --&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  &lt;!-- IGN: We have a lot of library includes, not all o=
f them are really required,</span><br><span>        so ignore them --&gt;</=
span><br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;missingIn=
cludeSystem&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- cppcheck doesn&#39;t unders=
tand about check_malloc_return, so these are</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  &lt;!-- FP: cppcheck doesn&#39;t understand abou=
t check_malloc_return, so these are</span><br><span>        usually mislead=
ing --&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&=
gt;nullPointerOutOfMemory&lt;/id&gt;</span><br><span>@@ -27,9 +24,6 @@</spa=
n><br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;nullPointerA=
rithmeticOutOfMemory&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;!-- These are specific=
 false-positives (FP) or ignored (IGN) issues</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-       We might want to move some of them to inline=
-suppression to avoid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
       the static line-numbers --&gt;</span><br><span>   &lt;!-- IGN: posix=
=2Ecfg: We are not threadsafe --&gt;</span><br><span>   &lt;suppress&gt;</s=
pan><br><span>     &lt;id&gt;getgrnamCalled&lt;/id&gt;</span><br><span>@@ -=
62,6 +56,11 @@</span><br><span>     &lt;id&gt;badBitmaskCheck&lt;/id&gt;</s=
pan><br><span>     &lt;fileName&gt;tests/unit_tests/openvpn/test_pkt=2Ec&lt=
;/fileName&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- FP: All occurrences are either =
external types or types that</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+       explicitly need to be non-const in some variants of the cal=
lback --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;s=
uppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;=
id&gt;constParameterCallback&lt;/id&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span>   &lt;!-- IGN: we =
use casts to remove const --&gt;</span><br><span>   &lt;suppress&gt;</span>=
<br><span>     &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span>@=
@ -74,6 +73,12 @@</span><br><span>     &lt;fileName&gt;src/openvpn/buffer=
=2Ec&lt;/fileName&gt;</span><br><span>     &lt;symbolName&gt;buf&lt;/symbol=
Name&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  &lt;!-- FP: can&#39;t change the signature of w=
main --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;su=
ppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;i=
d&gt;constParameter&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &lt;fileName&gt;src/openvpn/openvpn=2Ec&lt;/fileName&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;w=
argv&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  &lt;/suppress&gt;</span><br><span>   &lt;!-- IGN: external --&gt;</sp=
an><br><span>   &lt;suppress&gt;</span><br><span>     &lt;id&gt;constParame=
terPointer&lt;/id&gt;</span><br><span>@@ -81,6 +86,10 @@</span><br><span>  =
 &lt;/suppress&gt;</span><br><span>   &lt;!-- IGN: too many false-positives=
 due to stubs --&gt;</span><br><span>   &lt;suppress&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameter&lt;/id&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&g=
t;tests/unit_tests/openvpn*/test_*&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span>     &=
lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span>     &lt;fileName=
&gt;tests/unit_tests/openvpn*/test_*&lt;/fileName&gt;</span><br><span>   &l=
t;/suppress&gt;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail">change 1966</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1966?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I76c310f9e69276d=
4f21a4ad31a24490553d6d5c4 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1966 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>=

<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--ojP+HACFTII=--


--===============6046748794844512939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6046748794844512939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6046748794844512939==--

