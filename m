Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82B58CA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=I00HejX9DKI+KMtPvo5ytlf7TV2oEiHJVw6NvpKTzls=; b=XRFo88v4W3Biw2
	NM79shS1Cqx8rYAKd1t0PzSkD8alX8TgK4ICIH5q4P2qP7TGXrDnHlrcrHl9qEc11NomD8BdFchnW
	E1CjUMFO02PWRGzVvqsOdhigmViBhhgfD2lizllh+cEZ+HTPauyqrRZiK71KspOj/UCKkuc+FXlL3
	QVs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBC2a-000733-LH;
	Mon, 28 Sep 2026 14:09:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBC2Z-00072w-Gt
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lYhf9sMIL4KufBPf6v56KMBK65+9q9ZRUHvjse+sagU=; b=cplC8gRAM6lUPkqcSkFARnSydZ
 Aw2Hk8yLZKyo8cYK4ZabtIs/BP/W/9FMI27QabH/nzkTeGLkUH3dkGiIgFVXzjVSa+HqBKZqJZKht
 awl9QFkLp+cCg8CsYnwnv38ftNdb1yNHlPTeRLvc0YqtbTCM+cb/o+1y4NgjPumjZLn4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lYhf9sMIL4KufBPf6v56KMBK65+9q9ZRUHvjse+sagU=; b=f
 l4bzxli0tyMqHoYxZrDCCizJdbMeyroWsT/tk+FDKWOorM+EboCNl9SAXzg+1EvsukWOIFocx79tE
 GiPut8BXucuC6gHRUZH+DPiAqJR9s/sEYgZ7HQeJrjlhO9zLunFa3yXpuCkhPJbsAlV8abKJ4Dp/b
 H/YFGTSk3LCeLs0M=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBC2W-0003kD-9Y for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:09:08 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso23020475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 07:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790604542; x=1791209342; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lYhf9sMIL4KufBPf6v56KMBK65+9q9ZRUHvjse+sagU=;
 b=EHvLqowUIlqrYopPg73cT9TJdCgusICPIzytzbR5DGVq6PV9S6cXkXS9aPWJhebz2u
 dstam/C0e+dB0HrJOAMhZHhVJHoc9N88F9bQzz750PXN3lA8ay3GNM2Q0QP2UtkKxhuI
 0Jj3yxKzHywbJMxAOjIvfy6ufWxsDiVtGnFgc8Xo6/4I+tWN2FOpfwxwHoOQswlUXNAc
 J1tie6ETIWezgLYAZYCq++u2P+CmeM2j28B02UVC72tLUoI29mzdUz98lJppQGyEUwfV
 q/bP2VLBQi3shC20kI2TdU+mgmV27UpD5NjTt7HCfsJAxYdk32Md8Pe4JWkZvaT4J7WK
 0f0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790604542; x=1791209342;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lYhf9sMIL4KufBPf6v56KMBK65+9q9ZRUHvjse+sagU=;
 b=V43Zc77YFQfOhQc4hLIkMuPXswYwmb4kHOrK5XCfPrEGGxjz/oCnYUejHerunc+oz1
 3M/O6JoCFUdN2dQhMMas+C6VVgUHXOhQIrvO56/S4RGUqswoYabSsL8XUEjBcB1Nj6rM
 14YDjrpw9kIrRQW4oTjvpWCBT2vxcCK35epjjSMRlcGhtzfHK3gIrEAWzl/7O/7bqDs9
 FssnKceG/liy8GLVrYWyhZpr+5X2ul/hUBzNoNH/Q3sHR+ySyXkyutJZ909x1RdFsbXV
 1p4mkSGpjgCYKPP52Q/BA0Mww/KtHHQWP2GIEWF7Qg7If+dgVnUo0w48W5XtgD9M+YFH
 x7kw==
X-Gm-Message-State: AFuF++mNMkqHGKOOR6mI1Jmnk9uWIxF8Xi12MU5Zt2831T6vqJawlR7i
 ZhzgghztMWK+XxiWnQjMsu9Q9Q2CDdluUGD8a3k9SyzimJo1Fh67QSeTmTQPjRWtEgeOYIHmsWp
 Zf3oF8juC5pAkAVMbpasn5n4oG4XFIim01OGGQQ7KQ/2vZAgtjgUxPZaRHvxHhbpusd6ZodHT0G
 qb5uvPpw==
X-Gm-Gg: AYBFou0XCr58lxbExY9X0o9kutoCfnG3rWabKhsejjb/5WXB/bjHGeTpruU1eOPtonv
 UjYoLoHcSZ5cBFdwUt4J56qVTKKm0x+D4074cwLIIR9AiBDP4BAQYEEoBonJ6withrUHHU6jaCm
 BaUWkUiKp/JCF1tTvciblE4QOggem7+cbY+6HuPWDCVWYHicbZqzCZhUmplbV7hwWi72B8uWBkB
 5EdlqPqvq763Ss+tagVE5b8dsR8vaau7Mp6aJ4PgAPsTtEz4FqbpkWLgM02uSb38b0r2vkLuUMd
 p5zd7jhI7S61VPl6NgMFKb51h3CkiGCXH/p/bhekWUgPSvcVdeK5CUpP6mUnocuwnnNCOwPZ8JG
 cT+gMqOHuGmIlzYtqCMOVWt9TD+jnt6949e0kY26KRc0B3iEVGY3+Df/Jix5Wk/AU91JTrm0Zzw
 E01TdwlJHou/2YooJJdUZEEztISl4ech1IFqGbXWsCVpPLrl3t8HyRLun43jOIGRPlcRN7ArbN6
 f5NF5zvJGzDcB06kxTBbwqjP/FvGX9EqUFQQhR/uBccwIagnzbpNy+dDb/bUeanYT2/1tk5OEfk
 JB/Ok1kTqY0rEwEzY/1+tJerRo5lTf1sGkzI6Trx2VIGY7EAPVGuhppwPatCIpyAFfHNar1Y
X-Received: by 2002:a05:600c:c173:b0:49c:fa20:cbfd with SMTP id
 5b1f17b1804b1-49fe66eb262mr230491675e9.20.1790604541464; 
 Mon, 28 Sep 2026 07:09:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0062de83dsm44688045e9.4.2026.09.28.07.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 07:09:01 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 14:09:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3b835558451414d8a4e8058114643555be69d391
X-Gerrit-Change-Number: 1957
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1957?usp=email>
X-Gerrit-Commit: 94fb95498d8c52fa3b219f91edad2f81240def9c
References: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjA0NTM1MDAwLkkzYjgzNTU1ODQ1MTQxNGQ4YTRlODA1ODExNDY0MzU1NWJlNjlkMzkxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d5f3584c559aefea1a93588eba32191b9af82e7d-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBC2W-0003kD-9Y
Subject: [Openvpn-devel] [S] Change in openvpn[master]: cppcheck: Fix
 handling of likely() on Windows
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
Content-Type: multipart/mixed; boundary="===============2133458674264957757=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2133458674264957757==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x2G6w60pBK8="; charset=UTF-8

--x2G6w60pBK8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1957?usp=3Demail

to review the following change=2E


Chang=
e subject: cppcheck: Fix handling of likely() on Windows
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

cppcheck: Fix handling of likel=
y() on Windows

Since we do not force __GNUC__ to undefined on Windows
(sin=
ce we want to support MinGW) cppcheck might stumble
upon __builtin_expect()=
=2E When running with gnu=2Ecfg (which
we do not want to do for Windows cod=
e) then that has an
existing override=2E But for our Windows checks we need=
 to
add our own override=2E

This caused false-positives in buffer code=2E
=

Change-Id: I3b835558451414d8a4e8058114643555be69d391
Signed-off-by: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
---
A dev-tools/openvpn-cppcheck-wind=
ows=2Ecfg
M dev-tools/run-cppcheck=2Esh
2 files changed, 11 insertions(+), =
1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/57/1957/1

diff --git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b=
/dev-tools/openvpn-cppcheck-windows=2Ecfg
new file mode 100644
index 000000=
0=2E=2E9ac7282
--- /dev/null
+++ b/dev-tools/openvpn-cppcheck-windows=2Ecfg=

@@ -0,0 +1,10 @@
+<?xml version =3D"1=2E0"?>
+<!-- Only used for the Windo=
ws run=2E Can't be in openvpn-cppcheck-library=2Ecfg
+     because it confl=
icts with gnu=2Ecfg=2E -->
+<def>
+  <!-- MinGW uses GCC, so we need to han=
dle GCC builtins=2E gnu=2Ecfg has these,
+       but we do not load it for =
Windows=2E Without this cppcheck does not
+       understand our likely()/u=
nlikely() macros=2E -->
+  <define name=3D"__builtin_expect(X,Y)" value=3D"=
(X)" />
+  <define name=3D"__builtin_expect_with_probability(exp,c,probabil=
ity)" value=3D"(exp)" />
+</def>
diff --git a/dev-tools/run-cppcheck=2Esh b=
/dev-tools/run-cppcheck=2Esh
index 6b2c2be=2E=2E3c71c83 100755
--- a/dev-to=
ols/run-cppcheck=2Esh
+++ b/dev-tools/run-cppcheck=2Esh
@@ -49,7 +49,7 @@
 =
    tests/unit_tests/plugins/ || ret=3D$?
 cppcheck $COMMON_ARGS \
     --p=
latform=3Dwin64 \
-    --library=3Dwindows=2Ecfg \
+    --library=3Dwindows=
=2Ecfg --library=3D${SCRIPT_DIR}/openvpn-cppcheck-windows=2Ecfg \
     -D_W=
IN32 \
     -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBS=
D \
     -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONF=
LY \

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b83555845141=
4d8a4e8058114643555be69d391
Gerrit-Change-Number: 1957
Gerrit-PatchSet: 1
G=
errit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>

--x2G6w60pBK8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">cppcheck: Fix handling of likely() on Windows<br><br>Since we do not f=
orce __GNUC__ to undefined on Windows<br>(since we want to support MinGW) c=
ppcheck might stumble<br>upon __builtin_expect()=2E When running with gnu=
=2Ecfg (which<br>we do not want to do for Windows code) then that has an<br=
>existing override=2E But for our Windows checks we need to<br>add our own =
override=2E<br><br>This caused false-positives in buffer code=2E<br><br>Cha=
nge-Id: I3b835558451414d8a4e8058114643555be69d391<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>A dev-tools/openvpn-cp=
pcheck-windows=2Ecfg<br>M dev-tools/run-cppcheck=2Esh<br>2 files changed, 1=
1 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/57/1957/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/dev-tools/openvpn-cppcheck-windows=2Ecfg b/dev-tools/openvpn-cppcheck=
-windows=2Ecfg</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E9ac7282</span><br><span>--- /dev/null</span><br><span>+++ b/dev=
-tools/openvpn-cppcheck-windows=2Ecfg</span><br><span>@@ -0,0 +1,10 @@</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;?xml version =3D&quo=
t;1=2E0&quot;?&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&=
lt;!-- Only used for the Windows run=2E Can&#39;t be in openvpn-cppcheck-li=
brary=2Ecfg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     bec=
ause it conflicts with gnu=2Ecfg=2E --&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+&lt;def&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &lt;!-- MinGW uses GCC, so we need to handle GCC builtins=
=2E gnu=2Ecfg has these,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+       but we do not load it for Windows=2E Without this cppcheck does=
 not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       understa=
nd our likely()/unlikely() macros=2E --&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;define name=3D&quot;__builtin_expect(X,Y)&quo=
t; value=3D&quot;(X)&quot; /&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;define name=3D&quot;__builtin_expect_with_probability(ex=
p,c,probability)&quot; value=3D&quot;(exp)&quot; /&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+&lt;/def&gt;</span><br><span>diff --git =
a/dev-tools/run-cppcheck=2Esh b/dev-tools/run-cppcheck=2Esh</span><br><span=
>index 6b2c2be=2E=2E3c71c83 100755</span><br><span>--- a/dev-tools/run-cppc=
heck=2Esh</span><br><span>+++ b/dev-tools/run-cppcheck=2Esh</span><br><span=
>@@ -49,7 +49,7 @@</span><br><span>     tests/unit_tests/plugins/ || ret=3D=
$?</span><br><span> cppcheck $COMMON_ARGS \</span><br><span>     --platform=
=3Dwin64 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    --libra=
ry=3Dwindows=2Ecfg \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    --library=3Dwindows=2Ecfg --library=3D${SCRIPT_DIR}/openvpn-cppcheck-w=
indows=2Ecfg \</span><br><span>     -D_WIN32 \</span><br><span>     -UTARGE=
T_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \</span><br><span=
>     -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY =
\</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1957?usp=3Demail">change 1957</a>=2E To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1957?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: ope=
nvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div =
style=3D"display:none"> Gerrit-Change-Id: I3b835558451414d8a4e8058114643555=
be69d391 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1957 </d=
iv>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"di=
splay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>

</body></html>
--x2G6w60pBK8=--


--===============2133458674264957757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2133458674264957757==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2133458674264957757==--

