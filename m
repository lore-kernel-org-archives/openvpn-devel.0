Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57549CA6002
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+vhsQr2yynL0I0fLWieWlhl/oVN45nDYLi/KsnCMGgg=; b=TTuDKLaPQR0J+vWOZOai4TOxtj
	LWzl9VN8PyTwVIrkOoB0eregECs9S5yBpCZQsJ9tRKh8uVmnhPC2kAgX6bzWq/Vw1bItFI1mSfV6l
	LXvAWunFdFdvC9AZimPgU8zDC2NHmscNgzk+n9vbxvpOmpsX9hq1Y8u3J3NHAQaEKzqk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xETb8-0002VR-6k;
	Wed, 07 Oct 2026 15:30:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xETb6-0002Us-7Z
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 15:30:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rBMV45mqHhtWPTtmmGhgLWsHnk40yHftmEyvlHaNOzg=; b=LgB868sd3dqnIys1UIrDCnafXY
 Dp2KsnRdRoQslVH5pt6pCjvpkElfwTOW9gRq3zJ6a4PXLMtwSq16BsGPBcbEEJi/cmXckkHudXbns
 s0S1jb4pbbj/ZonhVelTZtXjp11RoMhAnuxy+yuyJfncaAdJ5yjp9u7ea144hJvIzTe0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rBMV45mqHhtWPTtmmGhgLWsHnk40yHftmEyvlHaNOzg=; b=U
 tJEykmk0TM+DM8PBZ4Xgffsiv2krQSKSzH9f+rwwQ2i+QV9Vmfs9lT0DP4wKD8XWWZV3f4exWH55U
 gv/19uOrryrP6s35K2paahPY0K/toIE/Bk/ULdx6pPAEuydMvN6RVBSCcN42JcnG+YAvWTlfjnf5f
 tnQUl1W6nhACQS3Y=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xETb0-0006Wy-2G for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 15:30:24 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so18128665e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 08:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791387011; x=1791991811; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rBMV45mqHhtWPTtmmGhgLWsHnk40yHftmEyvlHaNOzg=;
 b=b45ZmQk1WCkUjDQ+dICgaOn4VyL9r/y/1S7iokYbIMegoVaFaNmCcfIJdlOpvqCCja
 AsLeuqRfIxVibthapHToN2YQFP/o2c4oxLSbWzZruJPnurYyM9/Yg3tjRIAoqw+CTIfZ
 QA0Fbc9ebLhMLwm0VEOYEFnekMEzHDu4+45PCNzxpazb9Fvd06WwBGr+a9HIvPuZRChb
 G+nZ+mL/y0+vs8bBWi6IIfnbHLtTnJntp99uYPQojI3+4ygrLvzy3cwSjl23DDgV/tdf
 hlodorUGgrcBYiZGV/+hHeIPqpPyjCHSqegdteoTCxHsNy7JpDXuWF9pz3ucWXtMU5jt
 pSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791387011; x=1791991811;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rBMV45mqHhtWPTtmmGhgLWsHnk40yHftmEyvlHaNOzg=;
 b=Yag0k+Q6QuvHnfieOp95Rmcd91XimYeasuawoZBVSl+xH1bdMxMDU+or/w8nSDslu+
 MN6G7V9B2INomjKEzY+OZIiYbOjynUn7803Xq0LJq73vIxt3n1C5FhQ4QC4G0DRNukAM
 fgrUlgtELojsXnGouZ5bI6/ZsrHJdZnvyLBLfzJpL4RvbuUxSRZ8TV0JmDMIP2mvINjx
 MaC/MGdSbtVtHbGiZ3F3DfbyThazY65IyVTt+19xEFN2doY0nHkFzDOHVXiKxJI1i0Zg
 SQlAj42n9h332Wi24jWcal11l+iIlGbWgEYkv1uBRkXFsMlAYe8BeGOqTsxWXkqt1UE1
 qPfg==
X-Gm-Message-State: AFuF++kwCBEFdd540W3dazVIA0J+60ndao9OMsZhTkU6B2U7VJTcwUSp
 Y9PL+q+mL3Jng6lSGEHnFrcZoX1sNSeOdljhFKguTYi6YuQAasYqOsYrbgm/GyQeAK8/vw6cSqn
 1jolxgzYb4HU7HEp+g19XLS5CICn8Gb4q2P76rOOl3pg1nVLM43a+IjOfd450GLlz+EtarV5CqI
 VbA4n4Xg==
X-Gm-Gg: AYBFou34qZEEh9DHNf1w+zD8Vn7MTZkiJmlsGVoJNxNMFOXJVYNlUD96L647UvS6dIJ
 nalBq7+YCpdNzLN9sZIhbu6UCTS4tZRgPmwrKGbJF/D4aivYhpGh3omOqLfO20Ifn7TmfPvpRpy
 aNv9++TT70QMlMi6EXb5xl7v04KDLHYSkvbcmka28/OR1VpHrh1ArUJOG6/MVqj8YrcW4Wh0WnC
 31HtUctDuoz4Lo9GMBwppREXs9e5IEb6dhskmO4Wph0tBmyl8daBVyKzVNYhRDk5Zz5f58Hian0
 qtR/B3vztLZbqP6ayL1LWIk2d/a6Fuk9G7kuNtMCBn9TZLdZfQXq4JYPe7zO96q1ssX9IBCZezR
 YTWZisQj+JcT7FcZkAyVbVVROuZdCypnIGYXSp6igj74k0HXpl7jLbVTA2CZckE76q5SfaORSYv
 9z5RBn6ODpuQHFASDQdL0p3YloQDO1TvRswZrygMQg91vDBbflkMRlFamZZ7em23miUJCRPbiU/
 hdJwCBk/bomtvBWr62TfDVueXLFEJU1ezPfwfZNWTEzkyhTXkOp2k0n4DjeVs1zMxDu9LVCiAp4
 jjxPqcT0zKMCV8prHuRC4UKDv+4UL83udJxbJEoEGfn2kvYtTYs6F/JfwxOa
X-Received: by 2002:a05:600c:64c9:b0:4a1:6992:f861 with SMTP id
 5b1f17b1804b1-4a1800d417dmr42317225e9.1.1791387010154; 
 Wed, 07 Oct 2026 08:30:10 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17fc4a588sm60132715e9.1.2026.10.07.08.30.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 08:30:08 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 15:30:00 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: d26fb6d4a2ad7f59269b568c80419bc18bbca028
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dfd37e55b72041baf9b3c77d26025ab36aa3963f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xETb0-0006Wy-2G
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3134488263388296521=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3134488263388296521==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rpnYIPKniVw="; charset=UTF-8

--rpnYIPKniVw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like y=
ou to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1663?usp=3Demail

to look at the new patch set (#31)=2E

The =
following approvals got outdated and were removed:
Code-Review+1 by R=C4=83=
zvan Cojocaru


Change subject: Remove instances of constParameterPointer c=
ppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Remove instances of constParameterPointer cppcheck warnings

This requ=
ires a few suppressions since cppcheck
doesn't quite understand the differe=
nt code-paths
implemented by preprocessor defines=2E

Change-Id: I56248cf6d=
199c2da770774b8fd1e5daf2b116f58
Signed-off-by: Frank Lichtenheld <frank@lic=
htenheld=2Ecom>
---
M dev-tools/cppcheck-suppressions=2Exml
M sample/sample=
-plugins/client-connect/sample-client-connect=2Ec
M sample/sample-plugins/d=
efer/multi-auth=2Ec
M sample/sample-plugins/keying-material-exporter-demo/k=
eyingmaterialexporter=2Ec
M src/openvpn/buffer=2Eh
M src/openvpn/clinat=2Ec=

M src/openvpn/comp=2Ec
M src/openvpn/comp=2Eh
M src/openvpn/crypto=2Ec
M s=
rc/openvpn/crypto=2Eh
M src/openvpn/dco=2Ec
M src/openvpn/dco=2Eh
M src/ope=
nvpn/dco_freebsd=2Ec
M src/openvpn/dco_internal=2Eh
M src/openvpn/dco_linux=
=2Ec
M src/openvpn/dco_win=2Ec
M src/openvpn/error=2Ec
M src/openvpn/error=
=2Eh
M src/openvpn/event=2Ec
M src/openvpn/event=2Eh
M src/openvpn/forward=
=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/init=2Ec
M src/openvpn/init=2E=
h
M src/openvpn/interval=2Eh
M src/openvpn/list=2Ec
M src/openvpn/list=2Eh
=
M src/openvpn/manage=2Ec
M src/openvpn/manage=2Eh
M src/openvpn/mbuf=2Ec
M =
src/openvpn/mbuf=2Eh
M src/openvpn/mss=2Ec
M src/openvpn/mss=2Eh
M src/open=
vpn/mtcp=2Ec
M src/openvpn/mtcp=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/mu=
lti=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/multi_io=2Ec
M src/openvpn/ne=
tworking=2Eh
M src/openvpn/networking_iproute2=2Ec
M src/openvpn/networking=
_sitnl=2Ec
M src/openvpn/occ=2Eh
M src/openvpn/openssl_compat=2Eh
M src/ope=
nvpn/options=2Ec
M src/openvpn/options_parse=2Ec
M src/openvpn/otime=2Ec
M =
src/openvpn/otime=2Eh
M src/openvpn/proto=2Eh
M src/openvpn/proxy=2Ec
M src=
/openvpn/proxy=2Eh
M src/openvpn/ps=2Ec
M src/openvpn/ps=2Eh
M src/openvpn/=
push=2Ec
M src/openvpn/push=2Eh
M src/openvpn/push_util=2Ec
M src/openvpn/r=
eliable=2Ec
M src/openvpn/reliable=2Eh
M src/openvpn/route=2Ec
M src/openvp=
n/schedule=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/socket=2Eh
M src/open=
vpn/socket_util=2Eh
M src/openvpn/socks=2Ec
M src/openvpn/socks=2Eh
M src/o=
penvpn/ssl=2Ec
M src/openvpn/ssl=2Eh
M src/openvpn/ssl_backend=2Eh
M src/op=
envpn/ssl_mbedtls=2Ec
M src/openvpn/ssl_openssl=2Ec
M src/openvpn/ssl_pkt=
=2Ec
M src/openvpn/ssl_pkt=2Eh
M src/openvpn/ssl_verify=2Ec
M src/openvpn/s=
sl_verify=2Eh
M src/openvpn/status=2Ec
M src/openvpn/status=2Eh
M src/openv=
pn/tun=2Ec
M src/openvpn/tun=2Eh
M src/openvpn/tun_afunix=2Ec
M src/openvpn=
/tun_afunix=2Eh
M src/openvpn/vlan=2Ec
M src/openvpn/vlan=2Eh
M src/openvpn=
/win32=2Eh
M src/openvpnmsica/openvpnmsica=2Ec
M src/openvpnserv/interactiv=
e=2Ec
M tests/unit_tests/openvpn/mock_management=2Ec
M tests/unit_tests/ope=
nvpn/siphash_openssl=2Ec
M tests/unit_tests/openvpn/siphash_openssl=2Eh
M t=
ests/unit_tests/openvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_user_=
pass=2Ec
90 files changed, 402 insertions(+), 288 deletions(-)


  git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/1663/31

diff -=
-git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressi=
ons=2Exml
index 9d8c202=2E=2Ebd24c3b 100644
--- a/dev-tools/cppcheck-suppre=
ssions=2Exml
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ -9,9 +9,6 @@
  =
   <id>constParameterCallback</id>
   </suppress>
   <suppress>
-    <id>co=
nstParameterPointer</id>
-  </suppress>
-  <suppress>
     <id>unusedFuncti=
on</id>
   </suppress>
   <suppress>
@@ -65,6 +62,97 @@
     <id>badBitmask=
Check</id>
     <fileName>tests/unit_tests/openvpn/test_pkt=2Ec</fileName>
=
   </suppress>
+  <!-- IGN: we use casts to remove const -->
+  <suppress>
=
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/buffer=2Eh</=
fileName>
+    <symbolName>buf</symbolName>
+  </suppress>
+  <!-- FP: cons=
t silently removed due to pointer arithmetic -->
+  <suppress>
+    <id>con=
stParameterPointer</id>
+    <fileName>src/openvpn/buffer=2Ec</fileName>
+ =
   <symbolName>buf</symbolName>
+  </suppress>
+  <!-- IGN: external -->
+ =
 <suppress>
+    <id>constParameterPointer</id>
+    <fileName>/usr/include=
/*</fileName>
+  </suppress>
+  <!-- IGN: too many false-positives due to s=
tubs -->
+  <suppress>
+    <id>constParameterPointer</id>
+    <fileName>t=
ests/unit_tests/openvpn*/test_*</fileName>
+  </suppress>
+  <suppress>
+  =
  <id>constParameterPointer</id>
+    <fileName>tests/unit_tests/openvpn/mo=
ck_*</fileName>
+  </suppress>
+  <!-- IGN: too many false-positives due to=
 library/platform-specific code -->
+  <suppress>
+    <id>constParameterPo=
inter</id>
+    <fileName>src/openvpn/crypto*</fileName>
+  </suppress>
+  =
<suppress>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/s=
sl_*</fileName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer=
</id>
+    <fileName>src/openvpn/dco*</fileName>
+  </suppress>
+  <suppres=
s>
+    <id>constParameterPointer</id>
+    <fileName>src/openvpn/socket=2E=
*</fileName>
+  </suppress>
+  <!-- FP: const is only possible on some plat=
forms
+       These might easily hide valid issues but we need to compromis=
e
+       for developer sanity=2E
+       Inline suppressions are often too=
 ugly since they need to go in
+       between our return type line and the=
 function name=2E=2E=2E
+  -->
+  <suppress>
+    <id>constParameterPointer=
</id>
+    <fileName>src/openvpn/dns=2Ec</fileName>
+    <symbolName>duri</=
symbolName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id=
>
+    <fileName>src/openvpn/error=2Ec</fileName>
+    <symbolName>gc</symb=
olName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+ =
   <fileName>src/openvpn/forward=2Ec</fileName>
+    <symbolName>dco</symbo=
lName>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+  =
  <fileName>src/openvpn/manage=2Ec</fileName>
+    <symbolName>man</symbolN=
ame>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    =
<fileName>src/openvpn/misc=2Ec</fileName>
+    <symbolName>up</symbolName>
=
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <file=
Name>src/openvpn/options=2Ec</fileName>
+    <symbolName>options</symbolNam=
e>
+  </suppress>
+  <suppress>
+    <id>constParameterPointer</id>
+    <f=
ileName>src/openvpn/tun=2Ec</fileName>
+    <symbolName>gc</symbolName>
+  =
</suppress>
+  <!-- IGN: weird issue with MinGW debug build throwing -Werro=
r=3Dmaybe-uninitialized
+       for no good reason -->
+  <suppress>
+    <=
id>constParameterPointer</id>
+    <fileName>src/openvpn/buffer=2Eh</fileNa=
me>
+    <symbolName>p</symbolName>
+  </suppress>
   <!-- FP: cppcheck see=
ms to have wrong signature of DeviceIoControl() -->
   <suppress>
     <id>=
constVariablePointer</id>
diff --git a/sample/sample-plugins/client-connect=
/sample-client-connect=2Ec b/sample/sample-plugins/client-connect/sample-cl=
ient-connect=2Ec
index 420de61=2E=2Ecbd98e8 100644
--- a/sample/sample-plug=
ins/client-connect/sample-client-connect=2Ec
+++ b/sample/sample-plugins/cl=
ient-connect/sample-client-connect=2Ec
@@ -344,7 +344,7 @@
 }
 
 int
-openv=
pn_plugin_client_connect(struct plugin_context *context, const char **argv,=
 const char **envp)
+openvpn_plugin_client_connect(const struct plugin_cont=
ext *context, const char **argv, const char **envp)
 {
     /* log environm=
ent variables handed to us by OpenVPN, but
      * only if "setenv verb" is=
 3 or higher (arbitrary number)
@@ -465,7 +465,7 @@
 
 int
 openvpn_plugin_=
client_connect_defer_v2(struct plugin_context *context,
-                  =
                     struct plugin_per_client_context *pcc,
+              =
                         const struct plugin_per_client_context *pcc,
     =
                                   struct openvpn_plugin_string_list **retu=
rn_list)
 {
     time_t time_left =3D pcc->sleep_until - time(NULL);
diff -=
-git a/sample/sample-plugins/defer/multi-auth=2Ec b/sample/sample-plugins/d=
efer/multi-auth=2Ec
index bacf557=2E=2Ecdd616f 100644
--- a/sample/sample-p=
lugins/defer/multi-auth=2Ec
+++ b/sample/sample-plugins/defer/multi-auth=2E=
c
@@ -255,7 +255,7 @@
 }
 
 static bool
-do_auth_user_pass(struct plugin_co=
ntext *context, const char *username, const char *password)
+do_auth_user_p=
ass(const struct plugin_context *context, const char *username, const char =
*password)
 {
     plog(context, PLOG_NOTE, "expect_user=3D%s, received_use=
r=3D%s, expect_passw=3D%s, received_passw=3D%s",
          np(context->test=
_valid_user), np(username), np(context->test_valid_pass), np(password));
@@=
 -279,7 +279,7 @@
 
 
 static int
-auth_user_pass_verify(struct plugin_cont=
ext *context, struct plugin_per_client_context *pcc,
+auth_user_pass_verify=
(const struct plugin_context *context, struct plugin_per_client_context *pc=
c,
                       const char *argv[], const char *envp[])
 {
     /=
* get username/password from envp string array */
diff --git a/sample/sampl=
e-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec b/sample=
/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec
in=
dex 204374b=2E=2E41c5c4f 100644
--- a/sample/sample-plugins/keying-material=
-exporter-demo/keyingmaterialexporter=2Ec
+++ b/sample/sample-plugins/keyin=
g-material-exporter-demo/keyingmaterialexporter=2Ec
@@ -187,7 +187,7 @@
 }
=
 
 static void
-file_store(char *file, char *content)
+file_store(const cha=
r *file, const char *content)
 {
     FILE *f;
     if (!(f =3D fopen(file,=
 "w+")))
@@ -203,7 +203,7 @@
 server_store(struct openvpn_plugin_args_func_=
in const *args)
 {
     struct plugin *plugin =3D (struct plugin *)args->ha=
ndle;
-    struct session *sess =3D (struct session *)args->per_client_cont=
ext;
+    const struct session *sess =3D args->per_client_context;
 
     c=
har file[MAXPATH];
     snprintf(file, sizeof(file) - 1, "/tmp/openvpn_sso_=
%s", sess->key);
@@ -215,7 +215,7 @@
 client_store(struct openvpn_plugin_ar=
gs_func_in const *args)
 {
     struct plugin *plugin =3D (struct plugin *)=
args->handle;
-    struct session *sess =3D (struct session *)args->per_cli=
ent_context;
+    const struct session *sess =3D args->per_client_context;
=
 
     char *file =3D "/tmp/openvpn_sso_user";
     ovpn_note("app session =
file: %s", file);
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=
=2Eh
index 58e10f0=2E=2E063a2d4 100644
--- a/src/openvpn/buffer=2Eh
+++ b/s=
rc/openvpn/buffer=2Eh
@@ -1920,7 +1920,7 @@
  * @param a  The arena to test=
=2E
  */
 static inline bool
-gc_defined(struct gc_arena *a)
+gc_defined(co=
nst struct gc_arena *a)
 {
     return a->list !=3D NULL;
 }
diff --git a/s=
rc/openvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index dcef924=2E=2Ed72d42a 1=
00644
--- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -158,7 +=
158,7 @@
 #endif
 
 static void
-print_pkt(struct openvpn_iphdr *iph, const=
 char *prefix, const int direction, const msglvl_t msglevel)
+print_pkt(con=
st struct openvpn_iphdr *iph, const char *prefix, const int direction, cons=
t msglvl_t msglevel)
 {
     struct gc_arena gc =3D gc_new();
 
diff --git =
a/src/openvpn/comp=2Ec b/src/openvpn/comp=2Ec
index b88b79f=2E=2E387a7c4 10=
0644
--- a/src/openvpn/comp=2Ec
+++ b/src/openvpn/comp=2Ec
@@ -159,7 +159,7=
 @@
 #endif /* USE_COMP */
 
 bool
-check_compression_settings_valid(struct=
 compress_options *info, msglvl_t msglevel)
+check_compression_settings_val=
id(const struct compress_options *info, msglvl_t msglevel)
 {
     /*
     =
 * We also allow comp-stub-v2 here as it technically allows escaping of
dif=
f --git a/src/openvpn/comp=2Eh b/src/openvpn/comp=2Eh
index 29a90a2=2E=2Ead=
80243 100644
--- a/src/openvpn/comp=2Eh
+++ b/src/openvpn/comp=2Eh
@@ -91,7=
 +91,7 @@
  * flags of allow-compression and also the whether algorithms ar=
e compiled
  * in
  */
-bool check_compression_settings_valid(struct compre=
ss_options *info, msglvl_t msglevel);
+bool check_compression_settings_vali=
d(const struct compress_options *info, msglvl_t msglevel);
 
 #ifdef USE_CO=
MP
 #include "buffer=2Eh"
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn=
/crypto=2Ec
index 1703d4d=2E=2E3d3ab0c 100644
--- a/src/openvpn/crypto=2Ec
=
+++ b/src/openvpn/crypto=2Ec
@@ -1105,7 +1105,7 @@
 }
 
 static bool
-key_i=
s_zero(struct key *key, const struct key_type *kt)
+key_is_zero(const struc=
t key *key, const struct key_type *kt)
 {
     size_t cipher_length =3D cip=
her_kt_key_size(kt->cipher);
     for (size_t i =3D 0; i < cipher_length; +=
+i)
@@ -1123,7 +1123,7 @@
  * Make sure that cipher key is a valid key for =
current key_type=2E
  */
 bool
-check_key(struct key *key, const struct key=
_type *kt)
+check_key(const struct key *key, const struct key_type *kt)
 {
=
     if (cipher_defined(kt->cipher))
     {
@@ -1196,7 +1196,7 @@
 }
 
 voi=
d
-test_crypto(struct crypto_options *co, struct frame *frame)
+test_crypto=
(struct crypto_options *co, const struct frame *frame)
 {
     int i, j;
  =
   struct gc_arena gc =3D gc_new();
diff --git a/src/openvpn/crypto=2Eh b/s=
rc/openvpn/crypto=2Eh
index ee5b50f=2E=2Ee3c1c6a 100644
--- a/src/openvpn/c=
rypto=2Eh
+++ b/src/openvpn/crypto=2Eh
@@ -414,7 +414,7 @@
  */
 int write_=
key_file(const int nkeys, const char *filename);
 
-bool check_key(struct k=
ey *key, const struct key_type *kt);
+bool check_key(const struct key *key,=
 const struct key_type *kt);
 
 /**
  * Initialize a key_type structure wit=
h=2E
@@ -614,7 +614,7 @@
 /** Print a cipher list entry */
 void print_ciph=
er(const char *cipher);
 
-void test_crypto(struct crypto_options *co, stru=
ct frame *f);
+void test_crypto(struct crypto_options *co, const struct fra=
me *f);
 
 
 /* key direction functions */
diff --git a/src/openvpn/dco=2Ec=
 b/src/openvpn/dco=2Ec
index 9fc0e3b=2E=2Ef3b5d44 100644
--- a/src/openvpn/=
dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -573,7 +573,7 @@
 }
 
 static bool
-dc=
o_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
+=
dco_multi_get_localaddr(const struct multi_context *m, const struct multi_i=
nstance *mi,
                         struct sockaddr_storage *local)
 {
 #=
if ENABLE_IP_PKTINFO
@@ -585,7 +585,7 @@
         return false;
     }
 
- =
   struct link_socket_actual *actual =3D &c->c2=2Elink_socket_infos[0]->lsa=
->actual;
+    const struct link_socket_actual *actual =3D &c->c2=2Elink_so=
cket_infos[0]->lsa->actual;
 
     switch (actual->dest=2Eaddr=2Esa=2Esa_fa=
mily)
     {
@@ -623,7 +623,7 @@
 }
 
 int
-dco_multi_add_new_peer(struct m=
ulti_context *m, struct multi_instance *mi)
+dco_multi_add_new_peer(const s=
truct multi_context *m, struct multi_instance *mi)
 {
     const struct con=
text *c =3D &mi->context;
 
@@ -677,7 +677,7 @@
 }
 
 void
-dco_install_iro=
ute(struct multi_context *m, struct multi_instance *mi, struct mroute_addr =
*addr)
+dco_install_iroute(struct multi_context *m, struct multi_instance *=
mi, const struct mroute_addr *addr)
 {
 #if defined(TARGET_LINUX) || define=
d(TARGET_FREEBSD) || defined(_WIN32)
     if (!dco_enabled(&m->top=2Eoption=
s))
diff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 7ef75fee=
=2E=2Ec435f8c 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@=
 -204,7 +204,7 @@
  * @param mi        the client instance
  * @return     =
     0 on success or a negative error code otherwise
  */
-int dco_multi_ad=
d_new_peer(struct multi_context *m, struct multi_instance *mi);
+int dco_mu=
lti_add_new_peer(const struct multi_context *m, struct multi_instance *mi);=

 
 /**
  * Install an iroute in DCO, which means adding a route to the sys=
tem routing
@@ -215,7 +215,7 @@
  * @param addr      the route to add
  */
=
 void dco_install_iroute(struct multi_context *m, struct multi_instance *mi=
,
-                        struct mroute_addr *addr);
+                    =
    const struct mroute_addr *addr);
 
 /**
  * Remove all routes added thr=
ough the specified client
@@ -253,7 +253,7 @@
  * a 64 bit packet counter a=
nd AEAD tag at the end=2E
  */
 bool
-dco_supports_epoch_data(struct contex=
t *c);
+dco_supports_epoch_data(const struct context *c);
 #else  /* if def=
ined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
@@ -350,7 +350,7 @@
 }
=
 
 static inline int
-dco_multi_add_new_peer(struct multi_context *m, struc=
t multi_instance *mi)
+dco_multi_add_new_peer(const struct multi_context *m=
, struct multi_instance *mi)
 {
     return 0;
 }
@@ -384,7 +384,7 @@
 }
 
=
 static inline bool
-dco_supports_epoch_data(struct context *c)
+dco_suppor=
ts_epoch_data(const struct context *c)
 {
     return false;
 }
diff --git =
a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec
index 87eea55=
=2E=2E3148f10 100644
--- a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dc=
o_freebsd=2Ec
@@ -929,7 +929,7 @@
 }
 
 bool
-dco_supports_epoch_data(struc=
t context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     ret=
urn false;
 }
diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_i=
nternal=2Eh
index fcf8aca=2E=2E1022e66 100644
--- a/src/openvpn/dco_interna=
l=2Eh
+++ b/src/openvpn/dco_internal=2Eh
@@ -59,8 +59,9 @@
  * They are imp=
lemented by dco_linux=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,
-     =
            struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, co=
nst struct in6_addr *vpn_ipv6);
+int dco_new_peer(dco_context_t *dco, unsig=
ned int peerid, socket_descriptor_t sd,
+                 struct sockaddr *=
localaddr, struct sockaddr *remoteaddr,
+                 const struct in_a=
ddr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
 
 int dco_del_peer(dco_co=
ntext_t *dco, unsigned int peerid);
 
diff --git a/src/openvpn/dco_linux=2E=
c b/src/openvpn/dco_linux=2Ec
index a397fb8=2E=2E4412ad0 100644
--- a/src/o=
penvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -104,7 +104,7 @@
 }=

 
 static struct nl_msg *
-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8=
_t cmd)
+ovpn_dco_nlmsg_create(const dco_context_t *dco, uint8_t cmd)
 {
  =
   struct nl_msg *nl_msg =3D nlmsg_alloc();
     if (!nl_msg)
@@ -842,7 +84=
2,7 @@
 
 /* libnl < 3=2E11=2E0 does not implement nla_get_uint() */
 stati=
c uint64_t
-ovpn_nla_get_uint(struct nlattr *attr)
+ovpn_nla_get_uint(const=
 struct nlattr *attr)
 {
     if (nla_len(attr) =3D=3D sizeof(uint32_t))
  =
   {
@@ -954,7 +954,7 @@
 }
 
 static bool
-ovpn_iface_check(dco_context_t =
*dco, struct nlattr *attrs[])
+ovpn_iface_check(const dco_context_t *dco, s=
truct nlattr *attrs[])
 {
     /* we must know which interface this message=
 is referring to in order to
      * avoid mixing messages for other instan=
ces
@@ -1381,7 +1381,7 @@
 }
 
 bool
-dco_supports_epoch_data(struct contex=
t *c)
+dco_supports_epoch_data(const struct context *c)
 {
     return fals=
e;
 }
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index =
6e5e295=2E=2E12b0666 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn=
/dco_win=2Ec
@@ -1092,7 +1092,7 @@
 }
 
 bool
-dco_supports_epoch_data(stru=
ct context *c)
+dco_supports_epoch_data(const struct context *c)
 {
     OV=
PN_VERSION ver =3D { 0 };
     return dco_get_version(&ver) && ((ver=2EMajo=
r =3D=3D 2 && ver=2EMinor >=3D 8) || (ver=2EMajor > 2));
diff --git a/src/o=
penvpn/error=2Ec b/src/openvpn/error=2Ec
index 26d4c7c=2E=2E32d819d 100644
=
--- a/src/openvpn/error=2Ec
+++ b/src/openvpn/error=2Ec
@@ -623,7 +623,7 @@=

  * from the OS=2E
  */
 void
-x_check_status(ssize_t status, const char *=
description, struct link_socket *sock, struct tuntap *tt)
+x_check_status(s=
size_t status, const char *description, struct link_socket *sock, const str=
uct tuntap *tt)
 {
     const char *extended_msg =3D NULL;
 
diff --git a/s=
rc/openvpn/error=2Eh b/src/openvpn/error=2Eh
index 9f39572=2E=2E373cbc1 100=
644
--- a/src/openvpn/error=2Eh
+++ b/src/openvpn/error=2Eh
@@ -304,10 +304=
,10 @@
 void set_check_status(unsigned int info_level, unsigned int verbose=
_level);
 
 void x_check_status(ssize_t status, const char *description, st=
ruct link_socket *sock,
-                    struct tuntap *tt);
+         =
           const struct tuntap *tt);
 
 static inline void
-check_status(ss=
ize_t status, const char *description, struct link_socket *sock, struct tun=
tap *tt)
+check_status(ssize_t status, const char *description, struct link=
_socket *sock, const struct tuntap *tt)
 {
     if (status < 0 || check_deb=
ug_level(x_cs_verbose_level))
     {
diff --git a/src/openvpn/event=2Ec b/s=
rc/openvpn/event=2Ec
index 4089401=2E=2E5e17ea1 100644
--- a/src/openvpn/ev=
ent=2Ec
+++ b/src/openvpn/event=2Ec
@@ -1012,7 +1012,7 @@
 }
 
 static int
=
-se_wait_return(struct se_set *ses, fd_set *read, fd_set *write, struct eve=
nt_set_return *out,
+se_wait_return(struct se_set *ses, const fd_set *read,=
 const fd_set *write, struct event_set_return *out,
                int out=
len)
 {
     int i, j =3D 0;
diff --git a/src/openvpn/event=2Eh b/src/openv=
pn/event=2Eh
index b784dfe=2E=2E0940a1d 100644
--- a/src/openvpn/event=2Eh
=
+++ b/src/openvpn/event=2Eh
@@ -204,7 +204,7 @@
 #else /* ifdef _WIN32 */
 =

 static inline void
-wait_signal(struct event_set *es, void *arg)
+wait_si=
gnal(const struct event_set *es, const void *arg)
 {
 }
 
diff --git a/src/=
openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index b97fb7a=2E=2E681210d 10=
0644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -237,7 =
+237,7 @@
 }
 
 static void
-parse_incoming_control_channel_command(struct =
context *c, struct buffer *buf)
+parse_incoming_control_channel_command(str=
uct context *c, const struct buffer *buf)
 {
     if (buf_string_match_head=
_str(buf, "AUTH_FAILED"))
     {
@@ -507,7 +507,7 @@
 }
 
 int
-get_server_=
poll_remaining_time(struct event_timeout *server_poll_timeout)
+get_server_=
poll_remaining_time(const struct event_timeout *server_poll_timeout)
 {
   =
  update_time();
     int remaining =3D event_timeout_remaining(server_poll=
_timeout);
@@ -621,7 +621,7 @@
  * Buffer reallocation, for use with null e=
ncryption=2E
  */
 static inline void
-buffer_turnover(const uint8_t *orig_=
buf, struct buffer *dest_stub, struct buffer *src_stub,
+buffer_turnover(co=
nst uint8_t *orig_buf, struct buffer *dest_stub, const struct buffer *src_s=
tub,
                 struct buffer *storage)
 {
     if (orig_buf =3D=3D s=
rc_stub->data && src_stub->data !=3D storage->data)
@@ -908,7 +908,7 @@
  *=
/
 
 static inline void
-socks_postprocess_incoming_link(struct context *c,=
 struct link_socket *sock)
+socks_postprocess_incoming_link(struct context =
*c, const struct link_socket *sock)
 {
     if (sock->socks_proxy && sock->=
info=2Eproto =3D=3D PROTO_UDP)
     {
@@ -1005,7 +1005,7 @@
 }
 
 bool
-pro=
cess_incoming_link_part1(struct context *c, struct link_socket_info *lsi, b=
ool floated)
+process_incoming_link_part1(struct context *c, const struct l=
ink_socket_info *lsi, bool floated)
 {
     struct gc_arena gc =3D gc_new()=
;
     bool decrypt_status =3D false;
@@ -1555,7 +1555,7 @@
  * @param clie=
nt    Determines whether to the send packet back via tun or link
  */
 void=

-ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool cl=
ient)
+ipv6_send_icmp_unreachable(struct context *c, const struct buffer *b=
uf, bool client)
 {
 #define MAX_ICMPV6LEN 1280
     struct openvpn_icmp6hd=
r icmp6out;
diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
=
index 0309725=2E=2E375635b 100644
--- a/src/openvpn/forward=2Eh
+++ b/src/o=
penvpn/forward=2Eh
@@ -126,7 +126,7 @@
  */
 void encrypt_sign(struct conte=
xt *c, bool comp_frag);
 
-int get_server_poll_remaining_time(struct event_=
timeout *server_poll_timeout);
+int get_server_poll_remaining_time(const st=
ruct event_timeout *server_poll_timeout);
 
 /*****************************=
*****************************************/
 /**
@@ -177,7 +177,7 @@
  *
  *=
 @return true if packet is authenticated, false otherwise=2E
  */
-bool pro=
cess_incoming_link_part1(struct context *c, struct link_socket_info *lsi, b=
ool floated);
+bool process_incoming_link_part1(struct context *c, const st=
ruct link_socket_info *lsi, bool floated);
 
 /**
  * Continues processing =
a packet read from the external network interface=2E
diff --git a/src/openv=
pn/init=2Ec b/src/openvpn/init=2Ec
index 9306a96=2E=2E3c2ebf9 100644
--- a/=
src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -803,7 +803,7 @@
 }
 
 s=
tatic void
-init_port_share(struct context *c)
+init_port_share(const struc=
t context *c)
 {
     if (!port_share && (c->options=2Eport_share_host && c=
->options=2Eport_share_port))
     {
@@ -1245,7 +1245,7 @@
  * prepending t=
o msg() output=2E
  */
 const char *
-format_common_name(struct context *c,=
 struct gc_arena *gc)
+format_common_name(const struct context *c, struct g=
c_arena *gc)
 {
     struct buffer out =3D alloc_buf_gc(256, gc);
     if (=
c->c2=2Etls_multi)
@@ -1731,7 +1731,7 @@
 
 
 static bool
-can_preserve_tun=
(struct tuntap *tt)
+can_preserve_tun(const struct tuntap *tt)
 {
     if (=
tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {
@@ -1753,7 +1753,7 @@=

  * @param c pointer to the connection context
  */
 static void
-add_wfp_=
block(struct context *c)
+add_wfp_block(const struct context *c)
 {
 #if de=
fined(_WIN32)
     /* Fortify 'redirect-gateway block-local' with firewall =
rules? */
@@ -1779,7 +1779,7 @@
  * @param adapter_index the VPN adapter in=
dex
  */
 static void
-del_wfp_block(struct context *c, unsigned long adapt=
er_index)
+del_wfp_block(const struct context *c, unsigned long adapter_ind=
ex)
 {
 #if defined(_WIN32)
     if (c->options=2Eblock_outside_dns || bloc=
k_local_needed(c->c1=2Eroute_list))
diff --git a/src/openvpn/init=2Eh b/src=
/openvpn/init=2Eh
index ce8f74e=2E=2Ec486158 100644
--- a/src/openvpn/init=
=2Eh
+++ b/src/openvpn/init=2Eh
@@ -91,7 +91,7 @@
 
 uint64_t pull_permissi=
on_mask(const struct context *c);
 
-const char *format_common_name(struct =
context *c, struct gc_arena *gc);
+const char *format_common_name(const str=
uct context *c, struct gc_arena *gc);
 
 void reset_coarse_timers(struct co=
ntext *c);
 
diff --git a/src/openvpn/interval=2Eh b/src/openvpn/interval=
=2Eh
index 59051bd=2E=2E0cfe202 100644
--- a/src/openvpn/interval=2Eh
+++ b=
/src/openvpn/interval=2Eh
@@ -89,7 +89,7 @@
 }
 
 static inline void
-inter=
val_schedule_wakeup(struct interval *top, interval_t *wakeup)
+interval_sch=
edule_wakeup(const struct interval *top, interval_t *wakeup)
 {
     const =
time_t local_now =3D now;
     interval_earliest_wakeup(wakeup, top->last_t=
est_true + top->refresh, local_now);
@@ -214,7 +214,7 @@
  * This function =
does not check if the timeout is actually valid=2E
  */
 static inline inte=
rval_t
-event_timeout_remaining(struct event_timeout *et)
+event_timeout_re=
maining(const struct event_timeout *et)
 {
     return (interval_t)((et->la=
st + et->n) - now);
 }
diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=
=2Ec
index e51dcd0=2E=2Edcd59d7 100644
--- a/src/openvpn/list=2Ec
+++ b/src=
/openvpn/list=2Ec
@@ -164,7 +164,7 @@
 }
 
 void
-hash_remove_by_value(stru=
ct hash *hash, void *value)
+hash_remove_by_value(struct hash *hash, const =
void *value)
 {
     struct hash_iterator hi;
     const struct hash_elemen=
t *he;
diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=2Eh
index 55bc3=
c8=2E=2E23267d0 100644
--- a/src/openvpn/list=2Eh
+++ b/src/openvpn/list=2E=
h
@@ -78,7 +78,7 @@
 
 bool hash_remove_fast(struct hash *hash, struct hash=
_bucket *bucket, const void *key, uint64_t hv);
 
-void hash_remove_by_valu=
e(struct hash *hash, void *value);
+void hash_remove_by_value(struct hash *=
hash, const void *value);
 
 struct hash_iterator
 {
diff --git a/src/openv=
pn/manage=2Ec b/src/openvpn/manage=2Ec
index 0aef2d4=2E=2E1e74f09 100644
--=
- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -330,7 +330,7 @@=

 }
 
 static void
-man_delete_unix_socket(struct management *man)
+man_del=
ete_unix_socket(const struct management *man)
 {
 #if UNIX_SOCK_SUPPORT
   =
  if ((man->settings=2Eflags & (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=
=3D MF_UNIX_SOCK)
@@ -676,7 +676,7 @@
  * for the log and echo commands=2E
=
  */
 static void
-man_history(struct management *man, const char *parm, co=
nst char *type, struct log_history *log,
+man_history(struct management *ma=
n, const char *parm, const char *type, const struct log_history *log,
     =
        bool *realtime, const unsigned int lep_flags)
 {
     struct gc_are=
na gc =3D gc_new();
@@ -852,7 +852,7 @@
 }
 
 static void
-man_net(struct m=
anagement *man)
+man_net(const struct management *man)
 {
     if (man->per=
sist=2Ecallback=2Eshow_net)
     {
@@ -888,7 +888,7 @@
 #ifdef ENABLE_PKCS1=
1
 
 static void
-man_pkcs11_id_count(struct management *man)
+man_pkcs11_i=
d_count(const struct management *man)
 {
     msg(M_CLIENT, ">PKCS11ID-COUN=
T:%d", pkcs11_management_id_count());
 }
@@ -2366,7 +2366,7 @@
  * the rout=
e/ifconfig/open tun command=2E   See doc/android=2Etxt for details=2E
  */
=
 bool
-management_android_control(struct management *man, const char *comma=
nd, const char *msg)
+management_android_control(const struct management *m=
an, const char *command, const char *msg)
 {
     if (!man)
     {
@@ -3013=
,7 +3013,7 @@
 }
 
 void
-management_up_down(struct management *man, const =
char *updown, const struct env_set *es)
+management_up_down(const struct ma=
nagement *man, const char *updown, const struct env_set *es)
 {
     if (ma=
n->settings=2Eflags & MF_UP_DOWN)
     {
@@ -3208,7 +3208,7 @@
 }
 
 void
-=
management_auth_failure(struct management *man, const char *type, const cha=
r *reason)
+management_auth_failure(const struct management *man, const cha=
r *type, const char *reason)
 {
     if (reason)
     {
diff --git a/src/op=
envpn/manage=2Eh b/src/openvpn/manage=2Eh
index 1e7855d=2E=2Ef2c6916 100644=

--- a/src/openvpn/manage=2Eh
+++ b/src/openvpn/manage=2Eh
@@ -368,7 +368,7=
 @@
                                 const unsigned int flags, const char *=
static_challenge);
 
 #ifdef TARGET_ANDROID
-bool management_android_contro=
l(struct management *man, const char *command, const char *msg);
+bool mana=
gement_android_control(const struct management *man, const char *command, c=
onst char *msg);
 
 #define ANDROID_KEEP_OLD_TUN      1
 #define ANDROID_OP=
EN_BEFORE_CLOSE 2
@@ -382,7 +382,7 @@
 
 void management_event_loop_n_secon=
ds(struct management *man, int sec);
 
-void management_up_down(struct mana=
gement *man, const char *updown, const struct env_set *es);
+void managemen=
t_up_down(const struct management *man, const char *updown, const struct en=
v_set *es);
 
 void management_notify(const char *severity, const char *typ=
e,
                        const char *text);
@@ -482,7 +482,7 @@
  * OpenV=
PN calls here to indicate a password failure
  */
 
-void management_auth_f=
ailure(struct management *man, const char *type, const char *reason);
+void=
 management_auth_failure(const struct management *man, const char *type, co=
nst char *reason);
 
 /*
  * Echo an authentication token to management int=
erface
diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec
index 5bb39=
7f=2E=2E163251c 100644
--- a/src/openvpn/mbuf=2Ec
+++ b/src/openvpn/mbuf=2E=
c
@@ -165,7 +165,7 @@
 }
 
 void
-mbuf_dereference_instance(struct mbuf_set=
 *ms, struct multi_instance *mi)
+mbuf_dereference_instance(struct mbuf_set=
 *ms, const struct multi_instance *mi)
 {
     if (ms)
     {
diff --git a/=
src/openvpn/mbuf=2Eh b/src/openvpn/mbuf=2Eh
index cfe698c=2E=2Ee368054 1006=
44
--- a/src/openvpn/mbuf=2Eh
+++ b/src/openvpn/mbuf=2Eh
@@ -75,7 +75,7 @@
=
 
 bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item *item);
 
-=
void mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *=
mi);
+void mbuf_dereference_instance(struct mbuf_set *ms, const struct mult=
i_instance *mi);
 
 static inline bool
 mbuf_defined(const struct mbuf_set =
*ms)
diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec
index 36bbb43=
=2E=2E0cfa272d 100644
--- a/src/openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@=
@ -239,8 +239,8 @@
 }
 
 static void
-frame_calculate_fragment(struct frame=
 *frame, struct key_type *kt, const struct options *options,
-             =
            struct link_socket_info *lsi)
+frame_calculate_fragment(struct =
frame *frame, const struct key_type *kt, const struct options *options,
+  =
                       const struct link_socket_info *lsi)
 {
 #if defined(=
ENABLE_FRAGMENT)
     size_t overhead;
@@ -269,8 +269,8 @@
 }
 
 static voi=
d
-frame_calculate_mssfix(struct frame *frame, struct key_type *kt, const s=
truct options *options,
-                       struct link_socket_info *ls=
i)
+frame_calculate_mssfix(struct frame *frame, const struct key_type *kt, =
const struct options *options,
+                       const struct link_so=
cket_info *lsi)
 {
     if (options->ce=2Emssfix_fixed)
     {
@@ -314,8 +3=
14,8 @@
 }
 
 void
-frame_calculate_dynamic(struct frame *frame, struct key=
_type *kt, const struct options *options,
-                        struct l=
ink_socket_info *lsi)
+frame_calculate_dynamic(struct frame *frame, const s=
truct key_type *kt, const struct options *options,
+                       =
 const struct link_socket_info *lsi)
 {
     if (options->ce=2Efragment > 0=
)
     {
diff --git a/src/openvpn/mss=2Eh b/src/openvpn/mss=2Eh
index 1d092=
bb=2E=2E2eab55a 100644
--- a/src/openvpn/mss=2Eh
+++ b/src/openvpn/mss=2Eh
=
@@ -36,8 +36,8 @@
 void mss_fixup_dowork(struct buffer *buf, uint16_t maxms=
s);
 
 /** Set the --mssfix option=2E */
-void frame_calculate_dynamic(stru=
ct frame *frame, struct key_type *kt,
-                             const s=
truct options *options, struct link_socket_info *lsi);
+void frame_calculat=
e_dynamic(struct frame *frame, const struct key_type *kt,
+                =
             const struct options *options, const struct link_socket_info *=
lsi);
 
 /**
  * Checks and adjusts the fragment and mssfix value according=
 to the
diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index b012=
5f1=2E=2Eb9f0bda 100644
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=
=2Ec
@@ -91,7 +91,7 @@
 }
 
 bool
-multi_tcp_instance_specific_init(struct =
multi_context *m, struct multi_instance *mi)
+multi_tcp_instance_specific_i=
nit(const struct multi_context *m, struct multi_instance *mi)
 {
     /* bu=
ffer for queued TCP socket output packets */
     mi->tcp_link_out_deferred=
 =3D mbuf_init(m->top=2Eoptions=2En_bcast_buf);
diff --git a/src/openvpn/mt=
cp=2Eh b/src/openvpn/mtcp=2Eh
index 9b7d1d2=2E=2Ebb117fa 100644
--- a/src/o=
penvpn/mtcp=2Eh
+++ b/src/openvpn/mtcp=2Eh
@@ -35,7 +35,7 @@
 
 void multi_=
tcp_dereference_instance(struct multi_io *multi_io, struct multi_instance *=
mi);
 
-bool multi_tcp_instance_specific_init(struct multi_context *m, stru=
ct multi_instance *mi);
+bool multi_tcp_instance_specific_init(const struct=
 multi_context *m, struct multi_instance *mi);
 
 void multi_tcp_instance_s=
pecific_free(struct multi_instance *mi);
 
diff --git a/src/openvpn/mudp=2E=
c b/src/openvpn/mudp=2Ec
index 94e03d6=2E=2Ee6fae47 100644
--- a/src/openvp=
n/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -53,8 +53,9 @@
  * @param sock    =
the socket to send the reply on
  */
 static void
-send_standalone_reply(st=
ruct multi_context *m, struct buffer *buf, const char *prefix,
-           =
           const char *detail, struct link_socket *sock)
+send_standalone_r=
eply(struct multi_context *m, const struct buffer *buf,
+                  =
    const char *prefix, const char *detail,
+                      struct l=
ink_socket *sock)
 {
     struct context *c =3D &m->top;
 
@@ -74,7 +75,7 @=
@
 
 static void
 send_hmac_reset_packet(struct multi_context *m, struct tl=
s_pre_decrypt_state *state,
-                       struct tls_auth_standal=
one *tas, struct session_id *sid,
+                       const struct tls_=
auth_standalone *tas, const struct session_id *sid,
                       =
 bool request_resend_wkc, struct link_socket *sock)
 {
     reset_packet_id=
_send(&state->tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);
@@ -116,11 +117,11 @@=

 
     enum first_packet_verdict verdict;
 
-    struct tls_auth_standalon=
e *tas =3D m->top=2Ec2=2Etls_auth_standalone;
+    const struct tls_auth_st=
andalone *tas =3D m->top=2Ec2=2Etls_auth_standalone;
 
     verdict =3D tls=
_pre_decrypt_lite(tas, state, &m->top=2Ec2=2Efrom, &m->top=2Ec2=2Ebuf);
 
-=
    uint8_t *hmac_key =3D m->top=2Ec2=2Esession_id_key;
+    const uint8_t =
*hmac_key =3D m->top=2Ec2=2Esession_id_key;
     const struct openvpn_socka=
ddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     int handwindow =3D m->top=2E=
options=2Ehandshake_window;
 
@@ -239,7 +240,7 @@
 static struct multi_inst=
ance *
 handle_connection_attempt(struct multi_context *m,
                =
           struct link_socket *sock,
-                          struct mrou=
te_addr *real)
+                          const struct mroute_addr *real)
 =
{
     struct gc_arena gc =3D gc_new();
 
@@ -313,7 +314,7 @@
  * @return  =
    instance matching the address, NULL otherwise
  */
 static struct multi=
_instance *
-multi_get_instance_udp_real(struct multi_context *m, struct mr=
oute_addr *real)
+multi_get_instance_udp_real(struct multi_context *m, cons=
t struct mroute_addr *real)
 {
     struct hash *hash =3D m->hash;
     con=
st uint64_t hv =3D hash_value(hash, real);
@@ -346,7 +347,9 @@
  * maintain=
ing real address hash table atomicity=2E
  */
 struct multi_instance *
-mul=
ti_get_instance_udp_data(struct multi_context *m, bool *floated, struct mro=
ute_addr *real, struct link_socket *sock)
+multi_get_instance_udp_data(stru=
ct multi_context *m, bool *floated,
+                            const stru=
ct mroute_addr *real,
+                            const struct link_socket=
 *sock)
 {
     struct multi_instance *mi =3D NULL;
 
diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec
index 1cf2a21=2E=2E8fba67a 100644
---=
 a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -57,7 +57,7 @@
 
 #=
ifdef MULTI_DEBUG_EVENT_LOOP
 static const char *
-id(struct multi_instance=
 *mi)
+id(const struct multi_instance *mi)
 {
     if (mi)
     {
@@ -1319,=
7 +1319,7 @@
  * same common name=2E
  */
 static void
-multi_delete_dup(st=
ruct multi_context *m, struct multi_instance *new_mi)
+multi_delete_dup(str=
uct multi_context *m, const struct multi_instance *new_mi)
 {
     if (new_=
mi)
     {
@@ -2264,7 +2264,7 @@
 }
 
 static bool
-multi_client_setup_dco_=
initial(struct multi_context *m, struct multi_instance *mi,
+multi_client_s=
etup_dco_initial(const struct multi_context *m, struct multi_instance *mi,
=
                                struct gc_arena *gc)
 {
     if (!dco_enabl=
ed(&mi->context=2Eoptions))
@@ -3083,7 +3083,8 @@
  * positive=2E
  */
 sta=
tic bool
-multi_check_dest_addr_allowed(struct multi_context *m, struct mul=
ti_instance *mi, struct mroute_addr *real)
+multi_check_dest_addr_allowed(s=
truct multi_context *m, struct multi_instance *mi,
+                       =
       const struct mroute_addr *real)
 {
     struct hash *hash =3D m->has=
h;
     const uint64_t hv =3D hash_value(hash, real);
@@ -3242,7 +3243,7 @@=

 
 #if defined(ENABLE_DCO)
 static void
-process_incoming_del_peer(struct =
multi_context *m, struct multi_instance *mi, dco_context_t *dco)
+process_i=
ncoming_del_peer(struct multi_context *m, struct multi_instance *mi, const =
dco_context_t *dco)
 {
     const char *reason =3D "ovpn-dco: unknown reaso=
n";
     switch (dco->dco_del_peer_reason)
@@ -4295,7 +4296,7 @@
 
 /* Sear=
ches for the address and deletes it if it is owned by the multi_instance */=

 static void
-multi_unlearn_addr(struct multi_context *m, struct multi_ins=
tance *mi, const struct mroute_addr *addr)
+multi_unlearn_addr(struct multi=
_context *m, const struct multi_instance *mi, const struct mroute_addr *add=
r)
 {
     struct hash_element *he;
     const uint64_t hv =3D hash_value(m=
->vhash, addr);
@@ -4330,7 +4331,7 @@
  * @param a     The new IPv4 address=
 in network byte order
  */
 static void
-multi_unlearn_in_addr_t(struct mu=
lti_context *m, struct multi_instance *mi, in_addr_t a)
+multi_unlearn_in_a=
ddr_t(struct multi_context *m, const struct multi_instance *mi, in_addr_t a=
)
 {
     struct mroute_addr addr;
     CLEAR(addr);
@@ -4348,7 +4349,7 @@
=
  * @param a6    The new IPv6 address
  */
 static void
-multi_unlearn_in6_=
addr(struct multi_context *m, struct multi_instance *mi, struct in6_addr a6=
)
+multi_unlearn_in6_addr(struct multi_context *m, const struct multi_insta=
nce *mi, struct in6_addr a6)
 {
     struct mroute_addr addr;
     CLEAR(ad=
dr);
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh
index 7115b=
34=2E=2E1e01a581 100644
--- a/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=
=2Eh
@@ -515,7 +515,7 @@
  */
 
 static inline void
-set_prefix(struct mult=
i_instance *mi)
+set_prefix(const struct multi_instance *mi)
 {
 #ifdef MUL=
TI_DEBUG_EVENT_LOOP
     if (mi->msg_prefix[0])
diff --git a/src/openvpn/mu=
lti_io=2Ec b/src/openvpn/multi_io=2Ec
index 348e424=2E=2Ebb5dde58 100644
--=
- a/src/openvpn/multi_io=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -159,7 +159,=
7 @@
  * a point-to-multipoint tunnel=2E
  */
 static unsigned int
-p2mp_io=
w_flags(const struct multi_context *m, struct link_socket *sock)
+p2mp_iow_=
flags(const struct multi_context *m, const struct link_socket *sock)
 {
   =
  unsigned int flags =3D IOW_WAIT_SIGNAL;
 
diff --git a/src/openvpn/networ=
king=2Eh b/src/openvpn/networking=2Eh
index bce0c19=2E=2E25233c8 100644
---=
 a/src/openvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -44,7 +44=
,7 @@
  */
 #if !defined(ENABLE_IPROUTE)
 static inline int
-net_ctx_init(s=
truct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_init(const struct contex=
t *c, openvpn_net_ctx_t *ctx)
 {
     (void)c;
     (void)ctx;
@@ -75,7 +75=
,7 @@
  *
  * @return          0 on success, a negative error code otherwis=
e
  */
-int net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);
+int n=
et_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx);
 
 /**
  * Re=
lease resources allocated by the internal garbage collector
@@ -102,7 +102,=
7 @@
  * @return          0 on success, negative error code on error
  */
 =
int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *iface,=
 const char *type,
-                  void *arg);
+                  const =
void *arg);
 
 /**
  * Retrieve the interface type
diff --git a/src/openvpn=
/networking_iproute2=2Ec b/src/openvpn/networking_iproute2=2Ec
index a1f352=
5=2E=2Ef091fb3 100644
--- a/src/openvpn/networking_iproute2=2Ec
+++ b/src/o=
penvpn/networking_iproute2=2Ec
@@ -36,7 +36,7 @@
 #include <netinet/in=2Eh>=

 
 int
-net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
+net_ctx_i=
nit(const struct context *c, openvpn_net_ctx_t *ctx)
 {
     ctx->es =3D NU=
LL;
     if (c)
@@ -61,7 +61,7 @@
 }
 
 int
-net_iface_new(openvpn_net_ctx_=
t *ctx, const char *iface, const char *type, void *arg)
+net_iface_new(open=
vpn_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)
 =
{
     struct argv argv =3D argv_new();
 
diff --git a/src/openvpn/networki=
ng_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 83915db=2E=2E49de664 =
100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_=
sitnl=2Ec
@@ -1007,7 +1007,7 @@
 }
 
 static int
-sitnl_addr_del(sa_family_=
t af_family, const char *iface, inet_address_t *addr, int prefixlen)
+sitnl=
_addr_del(sa_family_t af_family, const char *iface, const inet_address_t *a=
ddr, int prefixlen)
 {
     int ifindex;
 
@@ -1250,8 +1250,8 @@
 }
 
 stat=
ic int
-sitnl_route_del(const char *iface, sa_family_t af_family, inet_addr=
ess_t *dst, int prefixlen,
-                inet_address_t *gw, uint32_t ta=
ble, int metric)
+sitnl_route_del(const char *iface, sa_family_t af_family,=
 const inet_address_t *dst, int prefixlen,
+                const inet_addr=
ess_t *gw, uint32_t table, int metric)
 {
     int ifindex =3D 0;
 
@@ -132=
8,7 +1328,7 @@
 
 
 int
-net_iface_new(openvpn_net_ctx_t *ctx, const char *=
iface, const char *type, void *arg)
+net_iface_new(openvpn_net_ctx_t *ctx, =
const char *iface, const char *type, const void *arg)
 {
     struct sitnl_=
link_req req =3D {};
     int ret =3D -1;
diff --git a/src/openvpn/occ=2Eh =
b/src/openvpn/occ=2Eh
index bda4f18=2E=2E49def4d 100644
--- a/src/openvpn/o=
cc=2Eh
+++ b/src/openvpn/occ=2Eh
@@ -156,7 +156,7 @@
  * via control channe=
l=2E
  * @return control channel exit message should be used */
 static inl=
ine bool
-cc_exit_notify_enabled(struct context *c)
+cc_exit_notify_enabled=
(const struct context *c)
 {
     /* Check if we have TLS active at all */
=
     if (!c->c2=2Etls_multi)
diff --git a/src/openvpn/openssl_compat=2Eh b/=
src/openvpn/openssl_compat=2Eh
index 098bdd5=2E=2E1a934db 100644
--- a/src/=
openvpn/openssl_compat=2Eh
+++ b/src/openvpn/openssl_compat=2Eh
@@ -127,7 +=
127,7 @@
 /* Mimics the functions but only when the default context without=

  * options is chosen */
 static inline const EVP_CIPHER *
-EVP_CIPHER_fet=
ch(void *ctx, const char *algorithm, const char *properties)
+EVP_CIPHER_fe=
tch(const void *ctx, const char *algorithm, const char *properties)
 {
    =
 ASSERT(!ctx);
     ASSERT(!properties);
@@ -135,7 +135,7 @@
 }
 
 static i=
nline const EVP_MD *
-EVP_MD_fetch(void *ctx, const char *algorithm, const =
char *properties)
+EVP_MD_fetch(const void *ctx, const char *algorithm, con=
st char *properties)
 {
     ASSERT(!ctx);
     ASSERT(!properties);
diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 5d10390=2E=
=2E9d32570 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -2429,7 +2429,7 @@
 }
 
 static void
-options_postprocess_mutate_le=
(struct connection_entry *ce, struct local_entry *le, int mode)
+options_po=
stprocess_mutate_le(const struct connection_entry *ce, struct local_entry *=
le, int mode)
 {
     /* use the global port if none is specified */
     i=
f (!le->port)
@@ -3585,7 +3585,7 @@
 static bool
 verify_permission(const c=
har *name, const char *file, int line, const uint64_t type,
               =
    const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,
-    =
              struct options *options, bool is_inline)
+                  c=
onst struct options *options, bool is_inline)
 {
     if (!(type & allowed)=
)
     {
@@ -3661,7 +3661,7 @@
 }
 
 static inline msglvl_t
-msglevel_forwa=
rd_compatible(struct options *options, const msglvl_t msglevel)
+msglevel_f=
orward_compatible(const struct options *options, const msglvl_t msglevel)
 =
{
     return options->forward_compatible ? M_WARN : msglevel;
 }
@@ -4150,=
7 +4150,7 @@
 }
 
 static void
-show_compression_warning(struct compress_op=
tions *info)
+show_compression_warning(const struct compress_options *info)=

 {
     if (comp_non_stub_enabled(info))
     {
diff --git a/src/openvpn/o=
ptions_parse=2Ec b/src/openvpn/options_parse=2Ec
index 12934ab=2E=2E79b8098=
 100644
--- a/src/openvpn/options_parse=2Ec
+++ b/src/openvpn/options_parse=
=2Ec
@@ -258,7 +258,7 @@
 }
 
 static char *
-read_inline_file(struct in_sr=
c *is, const char *close_tag, int *num_lines, struct gc_arena *gc)
+read_in=
line_file(const struct in_src *is, const char *close_tag, int *num_lines, s=
truct gc_arena *gc)
 {
     char line[OPTION_LINE_SIZE];
     struct buffer=
 buf =3D alloc_buf(8 * OPTION_LINE_SIZE);
@@ -302,7 +302,7 @@
 }
 
 static =
int
-check_inline_file(struct in_src *is, char *p[], struct gc_arena *gc)
+=
check_inline_file(const struct in_src *is, char *p[], struct gc_arena *gc)
=
 {
     int num_inline_lines =3D 0;
 
diff --git a/src/openvpn/otime=2Ec b/=
src/openvpn/otime=2Ec
index 1608458=2E=2E5d3633c 100644
--- a/src/openvpn/o=
time=2Ec
+++ b/src/openvpn/otime=2Ec
@@ -66,7 +66,7 @@
 }
 
 void
-update_n=
ow_usec(struct timeval *tv)
+update_now_usec(const struct timeval *tv)
 {
 =
    const time_t last =3D now;
     update_now(tv->tv_sec);
diff --git a/sr=
c/openvpn/otime=2Eh b/src/openvpn/otime=2Eh
index d14f01e=2E=2E74d21ff 1006=
44
--- a/src/openvpn/otime=2Eh
+++ b/src/openvpn/otime=2Eh
@@ -65,7 +65,7 @=
@
 void update_now(const time_t system_time);
 
 extern time_t now_usec;
-v=
oid update_now_usec(struct timeval *tv);
+void update_now_usec(const struct=
 timeval *tv);
 
 static inline int
 openvpn_gettimeofday(struct timeval *t=
v, void *tz)
diff --git a/src/openvpn/proto=2Eh b/src/openvpn/proto=2Eh
ind=
ex 9bb0866=2E=2E1665751 100644
--- a/src/openvpn/proto=2Eh
+++ b/src/openvp=
n/proto=2Eh
@@ -248,7 +248,7 @@
  * and offset of IP header (via parameter)=
=2E
  */
 static inline int
-get_tun_ip_ver(int tunnel_type, struct buffer =
*buf, int *ip_hdr_offset)
+get_tun_ip_ver(int tunnel_type, const struct buf=
fer *buf, int *ip_hdr_offset)
 {
     int ip_ver =3D -1;
 
diff --git a/src=
/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
index 74a6cf9=2E=2Ec3ad7de 10064=
4
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn/proxy=2Ec
@@ -527,8 +527,9 =
@@
 }
 
 static bool
-add_proxy_headers(struct http_proxy_info *p, socket_d=
escriptor_t sd, /* already open to proxy */
-                  const char *=
host                                   /* openvpn server remote */
+add_pro=
xy_headers(const struct http_proxy_info *p,
+                  socket_descr=
iptor_t sd, /* already open to proxy */
+                  const char *host=
        /* openvpn server remote */
 )
 {
     char buf[512];
@@ -597,8 +59=
8,8 @@
                               socket_descriptor_t sd, /* already op=
en to proxy */
                               const char *host,       /* op=
envpn server remote */
                               const char *port,    =
   /* openvpn server port */
-                              struct event_ti=
meout *server_poll_timeout, struct buffer *lookahead,
-                    =
          struct signal_info *sig_info)
+                              cons=
t struct event_timeout *server_poll_timeout,
+                             =
 struct buffer *lookahead, struct signal_info *sig_info)
 {
     struct gc_=
arena gc =3D gc_new();
     char buf[512];
diff --git a/src/openvpn/proxy=
=2Eh b/src/openvpn/proxy=2Eh
index e662e7d=2E=2Ea2f4e47 100644
--- a/src/op=
envpn/proxy=2Eh
+++ b/src/openvpn/proxy=2Eh
@@ -89,7 +89,7 @@
             =
                       socket_descriptor_t sd, /* already open to proxy */
=
                                    const char *host,       /* openvpn serv=
er remote */
                                    const char *port,       /*=
 openvpn server port */
-                                   struct event_ti=
meout *server_poll_timeout,
+                                   const struc=
t event_timeout *server_poll_timeout,
                                    s=
truct buffer *lookahead, struct signal_info *sig_info);
 
 uint8_t *make_ba=
se64_string2(const uint8_t *str, int str_len, struct gc_arena *gc);
diff --=
git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
index 08c2673=2E=2E2679c4d5 1=
00644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -334,7 +334,7 @@=

  * the proxy can determine true client origin=2E
  */
 static void
-journ=
al_add(const char *journal_dir, struct proxy_connection *pc, struct proxy_c=
onnection *cp)
+journal_add(const char *journal_dir, const struct proxy_con=
nection *pc, struct proxy_connection *cp)
 {
     struct openvpn_sockaddr f=
rom, to;
 
@@ -412,7 +412,7 @@
 static bool
 proxy_entry_new(struct proxy_c=
onnection **list, struct event_set *es,
                 const struct openv=
pn_sockaddr server_addr, const socket_descriptor_t sd_client,
-            =
    struct buffer *initial_data, const char *journal_dir)
+                =
const struct buffer *initial_data, const char *journal_dir)
 {
     socket_=
descriptor_t sd_server;
     int status;
@@ -1015,7 +1015,7 @@
  * call=2E
=
  */
 void
-port_share_redirect(struct port_share *ps, const struct buffer =
*head, socket_descriptor_t sd)
+port_share_redirect(const struct port_share=
 *ps, const struct buffer *head, socket_descriptor_t sd)
 {
     if (ps)
  =
   {
diff --git a/src/openvpn/ps=2Eh b/src/openvpn/ps=2Eh
index 557ecf5=2E=
=2E918ceb6 100644
--- a/src/openvpn/ps=2Eh
+++ b/src/openvpn/ps=2Eh
@@ -49,=
7 +49,7 @@
 
 bool is_openvpn_protocol(const struct buffer *buf);
 
-void p=
ort_share_redirect(struct port_share *ps, const struct buffer *head, socket=
_descriptor_t sd);
+void port_share_redirect(const struct port_share *ps, c=
onst struct buffer *head, socket_descriptor_t sd);
 
 #endif /* if PORT_SHA=
RE */
 #endif /* ifndef PS_H */
diff --git a/src/openvpn/push=2Ec b/src/ope=
nvpn/push=2Ec
index 0e281d2=2E=2E8dfe0d5 100644
--- a/src/openvpn/push=2Ec
=
+++ b/src/openvpn/push=2Ec
@@ -430,7 +430,7 @@
 }
 
 bool
-send_auth_pendin=
g_messages(struct tls_multi *tls_multi, struct tls_session *session,
+send_=
auth_pending_messages(const struct tls_multi *tls_multi, struct tls_session=
 *session,
                            const char *extra, unsigned int time=
out)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
diff --git=
 a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh
index dff945f=2E=2E39302f6 1=
00644
--- a/src/openvpn/push=2Eh
+++ b/src/openvpn/push=2Eh
@@ -117,7 +117,=
7 @@
  * doc/management-notes=2Etxt under client-pending-auth for
  * more =
details on message format
  */
-bool send_auth_pending_messages(struct tls_=
multi *tls_multi, struct tls_session *session,
+bool send_auth_pending_mess=
ages(const struct tls_multi *tls_multi, struct tls_session *session,
      =
                           const char *extra, unsigned int timeout);
 
 voi=
d send_restart(struct context *c, const char *kill_msg);
diff --git a/src/o=
penvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index 0213041=2E=2E7fa5987=
 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ =
-222,7 +222,7 @@
 
 /* Return true if the client supports push-update */
 s=
tatic bool
-support_push_update(struct multi_instance *mi)
+support_push_up=
date(const struct multi_instance *mi)
 {
     ASSERT(mi->context=2Ec2=2Etls=
_multi);
     const unsigned int iv_proto_peer =3D extract_iv_proto(mi->con=
text=2Ec2=2Etls_multi->peer_info);
diff --git a/src/openvpn/reliable=2Ec b/=
src/openvpn/reliable=2Ec
index b5315ff=2E=2E6f3d1c8 100644
--- a/src/openvp=
n/reliable=2Ec
+++ b/src/openvpn/reliable=2Ec
@@ -92,7 +92,7 @@
 
 /* check=
 if a particular packet_id is present in ack */
 static inline bool
-reliab=
le_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)
+rel=
iable_ack_packet_id_present(const struct reliable_ack *ack, packet_id_type =
pid)
 {
     for (int i =3D 0; i < ack->len; ++i)
     {
@@ -391,7 +391,7 @=
@
 }
 
 int
-validate_packet_id_window(struct reliable *rel, packet_id_type=
 pid)
+validate_packet_id_window(const struct reliable *rel, packet_id_type=
 pid)
 {
     return reliable_pid_min(pid, rel->packet_id)
            && r=
eliable_pid_min(subtract_pid(rel->packet_id, RELIABLE_CAPACITY), pid);
@@ -=
768,7 +768,7 @@
  */
 
 void
-reliable_mark_active_incoming(struct reliable=
 *rel, struct buffer *buf, packet_id_type pid,
+reliable_mark_active_incomi=
ng(struct reliable *rel, const struct buffer *buf, packet_id_type pid,
    =
                           int opcode)
 {
     for (int i =3D 0; i < rel->s=
ize; ++i)
@@ -828,7 +828,7 @@
 
 /* delete a buffer previously activated by=
 reliable_mark_active() */
 void
-reliable_mark_deleted(struct reliable *re=
l, struct buffer *buf)
+reliable_mark_deleted(struct reliable *rel, const s=
truct buffer *buf)
 {
     for (int i =3D 0; i < rel->size; ++i)
     {
dif=
f --git a/src/openvpn/reliable=2Eh b/src/openvpn/reliable=2Eh
index a85f2e9=
=2E=2E12d5367 100644
--- a/src/openvpn/reliable=2Eh
+++ b/src/openvpn/relia=
ble=2Eh
@@ -184,7 +184,7 @@
  * @li False, if there are packet IDs to be ac=
knowledged=2E
  */
 static inline bool
-reliable_ack_empty(struct reliable_=
ack *ack)
+reliable_ack_empty(const struct reliable_ack *ack)
 {
     retur=
n !ack->len;
 }
@@ -198,7 +198,7 @@
  * included in the valid range=2E
  */=

 int
-validate_packet_id_window(struct reliable *rel, packet_id_type pid);=

+validate_packet_id_window(const struct reliable *rel, packet_id_type pid)=
;
 
 /**
  * Returns the number of packets that need to be acked=2E
@@ -208=
,7 +208,7 @@
  * @returns the number of outstanding acks
  */
 static inlin=
e int
-reliable_ack_outstanding(struct reliable_ack *ack)
+reliable_ack_out=
standing(const struct reliable_ack *ack)
 {
     return ack->len;
 }
@@ -35=
8,7 +358,7 @@
  * @param pid The packet's packet ID=2E
  * @param opcode Th=
e packet's opcode=2E
  */
-void reliable_mark_active_incoming(struct reliab=
le *rel, struct buffer *buf, packet_id_type pid,
+void reliable_mark_active=
_incoming(struct reliable *rel, const struct buffer *buf, packet_id_type pi=
d,
                                    int opcode);
 
 /**
@@ -411,7 +411,7=
 @@
  * @param rel The reliable structure associated with the given buffer=
=2E
  * @param buf The buffer of the reliable entry which is to be removed=
=2E
  */
-void reliable_mark_deleted(struct reliable *rel, struct buffer *b=
uf);
+void reliable_mark_deleted(struct reliable *rel, const struct buffer =
*buf);
 
 /** @} name Functions for extracting incoming packets */
 
diff -=
-git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 33b2387=2E=2E483=
0a5b 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -898=
,8 +898,9 @@
 }
 
 static bool
-add_bypass_routes(struct route_bypass *rb, =
in_addr_t gateway, const struct tuntap *tt,
-                  unsigned int=
 flags, const struct route_gateway_info *rgi,
+add_bypass_routes(const stru=
ct route_bypass *rb, in_addr_t gateway,
+                  const struct tun=
tap *tt, unsigned int flags,
+                  const struct route_gateway_=
info *rgi,
                   const struct env_set *es, openvpn_net_ctx_t *=
ctx)
 {
     int ret =3D true;
@@ -916,8 +917,9 @@
 }
 
 static void
-del_b=
ypass_routes(struct route_bypass *rb, in_addr_t gateway, const struct tunta=
p *tt,
-                  unsigned int flags, const struct route_gateway_in=
fo *rgi,
+del_bypass_routes(const struct route_bypass *rb, in_addr_t gatewa=
y,
+                  const struct tuntap *tt, unsigned int flags,
+       =
           const struct route_gateway_info *rgi,
                   const s=
truct env_set *es, openvpn_net_ctx_t *ctx)
 {
     int i;
@@ -3939,7 +3941,=
8 @@
 #else  /* if defined(_WIN32) */
 
 static void
-get_bypass_addresses(=
struct route_bypass *rb, const unsigned int flags) /* PLATFORM-SPECIFIC */
=
+// cppcheck-suppress constParameterPointer ; stub
+get_bypass_addresses(st=
ruct route_bypass *rb, const unsigned int flags)
 {
 }
 
diff --git a/src/o=
penvpn/schedule=2Ec b/src/openvpn/schedule=2Ec
index 6c60dc2=2E=2Eff243dc 1=
00644
--- a/src/openvpn/schedule=2Ec
+++ b/src/openvpn/schedule=2Ec
@@ -389=
,4 +389,4 @@
 {
     s->earliest_wakeup =3D NULL; /* invalidate cache */
  =
   schedule_remove_node(s, e);
-}
\ No newline at end of file
+}
diff --git=
 a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 33def4e=2E=2Edf8e4=
00 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -620=
,7 +620,7 @@
 }
 
 static void
-bind_local(struct link_socket *sock)
+bind_=
local(const struct link_socket *sock)
 {
     /* bind to local address/port=
 */
     if (sock->bind_local)
@@ -916,8 +916,8 @@
 }
 
 void
-socket_bind(=
socket_descriptor_t sd, struct addrinfo *local, int ai_family, const char *=
prefix,
-            bool ipv6only)
+socket_bind(socket_descriptor_t sd, co=
nst struct addrinfo *local, int ai_family,
+            const char *prefix,=
 bool ipv6only)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -1125,8 +1125=
,8 @@
  * such as TCP=2E
  */
 
-static void stream_buf_init(struct stream_=
buf *sb, struct buffer *buf, const unsigned int sockflags,
-               =
             const int proto);
+static void stream_buf_init(struct stream_b=
uf *sb, const struct buffer *buf,
+                            const unsign=
ed int sockflags, const int proto);
 
 static void stream_buf_close(struct =
stream_buf *sb);
 
@@ -1479,7 +1479,7 @@
 }
 
 static void
-phase2_set_sock=
et_flags(struct link_socket *sock)
+phase2_set_socket_flags(const struct li=
nk_socket *sock)
 {
     /* TCP_NODELAY is enabled by default on every TCP =
socket; dco-win is
      * skipped as it manages its own socket */
@@ -2075=
,7 +2075,7 @@
 }
 
 static void
-stream_buf_init(struct stream_buf *sb, str=
uct buffer *buf, const unsigned int sockflags,
+stream_buf_init(struct stre=
am_buf *sb, const struct buffer *buf, const unsigned int sockflags,
       =
          const int proto)
 {
     sb->buf_init =3D *buf;
@@ -2341,7 +2341,=
7 @@
 #endif
 
 static ssize_t
-link_socket_read_udp_posix_recvmsg(struct l=
ink_socket *sock, struct buffer *buf,
+link_socket_read_udp_posix_recvmsg(c=
onst struct link_socket *sock, struct buffer *buf,
                        =
            struct link_socket_actual *from, socklen_t *fromlen)
 {
     st=
ruct iovec iov;
@@ -2413,7 +2413,7 @@
 #endif /* if ENABLE_IP_PKTINFO */
 
=
 ssize_t
-link_socket_read_udp_posix(struct link_socket *sock, struct buffe=
r *buf,
+link_socket_read_udp_posix(const struct link_socket *sock, struct =
buffer *buf,
                            struct link_socket_actual *from)
 =
{
     ssize_t recvlen;
@@ -2476,7 +2476,7 @@
 #if ENABLE_IP_PKTINFO
 
 ssi=
ze_t
-link_socket_write_udp_posix_sendmsg(struct link_socket *sock, struct =
buffer *buf,
+link_socket_write_udp_posix_sendmsg(const struct link_socket =
*sock, const struct buffer *buf,
                                     struc=
t link_socket_actual *to)
 {
     struct iovec iov;
@@ -2672,7 +2672,7 @@
 =
}
 
 int
-socket_send_queue(struct link_socket *sock, struct buffer *buf, c=
onst struct link_socket_actual *to)
+socket_send_queue(struct link_socket *=
sock, const struct buffer *buf, const struct link_socket_actual *to)
 {
   =
  if (sock->writes=2Eiostate =3D=3D IOSTATE_INITIAL)
     {
@@ -2772,8 +277=
2,8 @@
     return sock->writes=2Eiostate;
 }
 
-void
-read_sockaddr_from_o=
verlapped(struct overlapped_io *io, struct sockaddr *dst, int overlapped_re=
t)
+static void
+read_sockaddr_from_overlapped(const struct overlapped_io *=
io, struct sockaddr *dst, int overlapped_ret)
 {
     if (overlapped_ret >=
=3D 0 && io->addr_defined)
     {
diff --git a/src/openvpn/socket=2Eh b/src=
/openvpn/socket=2Eh
index 46fa29c=2E=2Ecbcdeef 100644
--- a/src/openvpn/soc=
ket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -268,7 +268,7 @@
 
 int socket_recv=
_queue(struct link_socket *sock, int maxsize);
 
-int socket_send_queue(str=
uct link_socket *sock, struct buffer *buf,
+int socket_send_queue(struct li=
nk_socket *sock, const struct buffer *buf,
                       const str=
uct link_socket_actual *to);
 
 typedef struct
@@ -348,8 +348,8 @@
 
 struc=
t link_socket *link_socket_new(void);
 
-void socket_bind(socket_descriptor=
_t sd, struct addrinfo *local, int af_family, const char *prefix,
-        =
         bool ipv6only);
+void socket_bind(socket_descriptor_t sd, const st=
ruct addrinfo *local, int af_family,
+                 const char *prefix, =
bool ipv6only);
 
 int openvpn_connect(socket_descriptor_t sd, const struct=
 sockaddr *remote, int connect_timeout,
                     volatile int *=
signal_received);
@@ -496,7 +496,7 @@
 }
 
 static inline bool
-link_socket=
_verify_incoming_addr(struct buffer *buf, const struct link_socket_info *in=
fo,
+link_socket_verify_incoming_addr(const struct buffer *buf, const struc=
t link_socket_info *info,
                                  const struct li=
nk_socket_actual *from_addr)
 {
     if (buf->len > 0)
@@ -620,7 +620,7 @@
=
 
 #else  /* ifdef _WIN32 */
 
-ssize_t link_socket_read_udp_posix(struct l=
ink_socket *sock, struct buffer *buf,
+ssize_t link_socket_read_udp_posix(c=
onst struct link_socket *sock, struct buffer *buf,
                        =
            struct link_socket_actual *from);
 
 #endif /* ifdef _WIN32 */
=
@@ -706,12 +706,12 @@
 
 #else /* ifdef _WIN32 */
 
-ssize_t link_socket_wr=
ite_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,
+ssize_=
t link_socket_write_udp_posix_sendmsg(const struct link_socket *sock, const=
 struct buffer *buf,
                                             struct li=
nk_socket_actual *to);
 
 
 static inline ssize_t
-link_socket_write_udp_po=
six(struct link_socket *sock, struct buffer *buf,
+link_socket_write_udp_po=
six(const struct link_socket *sock, const struct buffer *buf,
             =
                struct link_socket_actual *to)
 {
 #if ENABLE_IP_PKTINFO
@@=
 -727,7 +727,7 @@
 }
 
 static inline ssize_t
-link_socket_write_tcp_posix(=
struct link_socket *sock, struct buffer *buf)
+link_socket_write_tcp_posix(=
const struct link_socket *sock, const struct buffer *buf)
 {
     return se=
nd(sock->sd, CBPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }
@@ -785,7 +785,7 @@
=
  * from tunnel packet=2E
  */
 static inline void
-link_socket_set_tos(str=
uct link_socket *sock)
+link_socket_set_tos(const struct link_socket *sock)=

 {
     if (sock && sock->ptos_defined)
     {
diff --git a/src/openvpn/so=
cket_util=2Eh b/src/openvpn/socket_util=2Eh
index 13f5962=2E=2Eadd08ba 1006=
44
--- a/src/openvpn/socket_util=2Eh
+++ b/src/openvpn/socket_util=2Eh
@@ -=
439,7 +439,7 @@
 
 
 static inline bool
-addrlist_match_proto(const struct =
openvpn_sockaddr *a1, struct addrinfo *addr_list, const int proto)
+addrlis=
t_match_proto(const struct openvpn_sockaddr *a1, const struct addrinfo *add=
r_list, const int proto)
 {
     return link_socket_proto_connection_orient=
ed(proto) ? addrlist_match(a1, addr_list)
                                 =
                        : addrlist_port_match(a1, addr_list);
diff --git a/=
src/openvpn/socks=2Ec b/src/openvpn/socks=2Ec
index b84da24=2E=2E0296349 10=
0644
--- a/src/openvpn/socks=2Ec
+++ b/src/openvpn/socks=2Ec
@@ -83,7 +83,7=
 @@
 
 static bool
 socks_proxy_recv_char(uint8_t *c, const char *name, soc=
ket_descriptor_t sd,
-                      struct event_timeout *server_po=
ll_timeout,
+                      const struct event_timeout *server_poll_=
timeout,
                       volatile int *signal_received)
 {
     fd_s=
et reads;
@@ -98,8 +98,8 @@
 }
 
 static bool
-socks_username_password_auth=
(struct socks_proxy_info *p, socket_descriptor_t sd,
-                     =
        struct event_timeout *server_poll_timeout,
+socks_username_password=
_auth(const struct socks_proxy_info *p, socket_descriptor_t sd,
+          =
                   const struct event_timeout *server_poll_timeout,
       =
                       volatile int *signal_received)
 {
     char to_send[=
516];
@@ -157,8 +157,8 @@
 }
 
 static bool
-socks_handshake(struct socks_p=
roxy_info *p, socket_descriptor_t sd,
-                struct event_timeout=
 *server_poll_timeout, volatile int *signal_received)
+socks_handshake(cons=
t struct socks_proxy_info *p, socket_descriptor_t sd,
+                cons=
t struct event_timeout *server_poll_timeout, volatile int *signal_received)=

 {
     uint8_t buf[2];
     int len =3D 0;
@@ -232,7 +232,7 @@
 
 static =
bool
 recv_socks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *add=
r,
-                 struct event_timeout *server_poll_timeout, volatile in=
t *signal_received)
+                 const struct event_timeout *server_po=
ll_timeout, volatile int *signal_received)
 {
     uint8_t atyp =3D 0;
    =
 int alen =3D 0;
@@ -334,11 +334,11 @@
 }
 
 void
-establish_socks_proxy_pa=
ssthru(struct socks_proxy_info *p,
+establish_socks_proxy_passthru(const st=
ruct socks_proxy_info *p,
                                socket_descriptor=
_t sd, /* already open to proxy */
                                const ch=
ar *host,       /* openvpn server remote */
                               =
 const char *servname,   /* openvpn server port */
-                       =
        struct event_timeout *server_poll_timeout,
+                       =
        const struct event_timeout *server_poll_timeout,
                  =
              struct signal_info *sig_info)
 {
     char buf[270];
@@ -392,=
10 +392,10 @@
 }
 
 void
-establish_socks_proxy_udpassoc(struct socks_proxy=
_info *p,
+establish_socks_proxy_udpassoc(const struct socks_proxy_info *p,=

                                socket_descriptor_t ctrl_sd, /* already op=
en to proxy */
                                struct openvpn_sockaddr *rel=
ay_addr,
-                               struct event_timeout *server_poll_=
timeout,
+                               const struct event_timeout *server=
_poll_timeout,
                                struct signal_info *sig_info=
)
 {
     if (!socks_handshake(p, ctrl_sd, server_poll_timeout, &sig_info->=
signal_received))
diff --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=2E=
h
index caed18c=2E=2E7434bbf 100644
--- a/src/openvpn/socks=2Eh
+++ b/src/o=
penvpn/socks=2Eh
@@ -49,17 +49,17 @@
 
 void socks_proxy_close(struct socks=
_proxy_info *sp);
 
-void establish_socks_proxy_passthru(struct socks_proxy=
_info *p,
+void establish_socks_proxy_passthru(const struct socks_proxy_inf=
o *p,
                                     socket_descriptor_t sd, /* alrea=
dy open to proxy */
                                     const char *host, =
      /* openvpn server remote */
                                     cons=
t char *servname,   /* openvpn server port */
-                            =
        struct event_timeout *server_poll_timeout,
+                       =
             const struct event_timeout *server_poll_timeout,
             =
                        struct signal_info *sig_info);
 
-void establish_so=
cks_proxy_udpassoc(struct socks_proxy_info *p,
+void establish_socks_proxy_=
udpassoc(const struct socks_proxy_info *p,
                                =
     socket_descriptor_t ctrl_sd, /* already open to proxy */
             =
                        struct openvpn_sockaddr *relay_addr,
-             =
                       struct event_timeout *server_poll_timeout,
+        =
                            const struct event_timeout *server_poll_timeout=
,
                                     struct signal_info *sig_info);
 
 vo=
id socks_process_incoming_udp(struct buffer *buf, struct link_socket_actual=
 *from);
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index aeec0=
20=2E=2E3594871 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
=
@@ -1171,7 +1171,7 @@
 }
 
 struct tls_multi *
-tls_multi_init(struct tls_o=
ptions *tls_options)
+tls_multi_init(const struct tls_options *tls_options)=

 {
     struct tls_multi *ret;
 
@@ -1212,7 +1212,7 @@
  */
 
 struct tls_=
auth_standalone *
-tls_auth_standalone_init(struct tls_options *tls_options=
, struct gc_arena *gc)
+tls_auth_standalone_init(const struct tls_options *=
tls_options, struct gc_arena *gc)
 {
     struct tls_auth_standalone *tas;
=
 
@@ -1631,8 +1631,9 @@
 
 bool
 tls_session_update_crypto_params_do_work(s=
truct tls_multi *multi, struct tls_session *session,
-                     =
                    struct options *options, struct frame *frame,
-        =
                                 struct frame *frame_fragment, struct link_=
socket_info *lsi,
+                                         const struct op=
tions *options, struct frame *frame,
+                                     =
    struct frame *frame_fragment,
+                                        =
 const struct link_socket_info *lsi,
                                      =
    dco_context_t *dco)
 {
     if (session->key[KS_PRIMARY]=2Ecrypto_optio=
ns=2Ekey_ctx_bi=2Einitialized)
@@ -1704,7 +1705,7 @@
 bool
 tls_session_upd=
ate_crypto_params(struct tls_multi *multi, struct tls_session *session,
   =
                               struct options *options, struct frame *frame=
,
-                                 struct frame *frame_fragment, struct li=
nk_socket_info *lsi,
+                                 struct frame *frame_=
fragment, const struct link_socket_info *lsi,
                             =
     dco_context_t *dco)
 {
     if (!check_session_cipher(session, options=
))
@@ -1920,7 +1921,8 @@
 }
 
 static bool
-push_peer_info_peerid(struct bu=
ffer *out, struct tls_multi *multi, struct tls_session *session)
+push_peer=
_info_peerid(struct buffer *out, const struct tls_multi *multi,
+          =
            const struct tls_session *session)
 {
     if (multi->rx_peer_i=
d =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
     {
@@ -1955,7 +1957,=
7 @@
  * @return          true if no error was encountered
  */
 static boo=
l
-push_peer_info(struct buffer *buf, struct tls_multi *multi, struct tls_s=
ession *session)
+push_peer_info(struct buffer *buf, const struct tls_multi=
 *multi, struct tls_session *session)
 {
     struct gc_arena gc =3D gc_new=
();
     bool ret =3D false;
@@ -2599,8 +2601,8 @@
 }
 
 bool
-session_skip=
_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *st=
ate,
-                          struct link_socket_actual *from)
+session_s=
kip_to_pre_start(struct tls_session *session, const struct tls_pre_decrypt_=
state *state,
+                          const struct link_socket_actual *f=
rom)
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];
     ks->s=
ession_id_remote =3D state->peer_session_id;
@@ -2829,7 +2831,7 @@
 
 stati=
c bool
 check_outgoing_ciphertext(struct key_state *ks, struct tls_session =
*session,
-                          struct buffer *to_link, bool *continue=
_tls_process)
+                          const struct buffer *to_link, bool=
 *continue_tls_process)
 {
     if (to_link->len)
     {
@@ -4193,7 +4195,7=
 @@
 }
 
 void
-tls_post_encrypt(struct tls_multi *multi, struct buffer *bu=
f)
+tls_post_encrypt(struct tls_multi *multi, const struct buffer *buf)
 {
=
     struct key_state *ks =3D multi->save_ks;
     multi->save_ks =3D NULL;=

@@ -4324,7 +4326,7 @@
  * into a garbage collectable string which is retur=
ned=2E
  */
 const char *
-protocol_dump(struct buffer *buffer, unsigned in=
t flags, struct gc_arena *gc)
+protocol_dump(const struct buffer *buffer, u=
nsigned int flags, struct gc_arena *gc)
 {
     struct buffer out =3D alloc=
_buf_gc(256, gc);
     struct buffer buf =3D *buffer;
diff --git a/src/open=
vpn/ssl=2Eh b/src/openvpn/ssl=2Eh
index 5483fbb=2E=2E76c3610 100644
--- a/s=
rc/openvpn/ssl=2Eh
+++ b/src/openvpn/ssl=2Eh
@@ -166,7 +166,7 @@
  *
  * @r=
eturn A newly allocated and initialized \c tls_multi structure=2E
  */
-str=
uct tls_multi *tls_multi_init(struct tls_options *tls_options);
+struct tls=
_multi *tls_multi_init(const struct tls_options *tls_options);
 
 /**
  * F=
inalize initialization of a \c tls_multi structure=2E
@@ -187,7 +187,7 @@
 =
/*
  * Initialize a standalone tls-auth verification object=2E
  */
-struct=
 tls_auth_standalone *tls_auth_standalone_init(struct tls_options *tls_opti=
ons,
+struct tls_auth_standalone *tls_auth_standalone_init(const struct tls=
_options *tls_options,
                                                    =
  struct gc_arena *gc);
 
 /**
@@ -373,7 +373,7 @@
  * @param multi - The T=
LS state for this packet's destination VPN tunnel=2E
  * @param buf - The b=
uffer containing the outgoing packet=2E
  */
-void tls_post_encrypt(struct =
tls_multi *multi, struct buffer *buf);
+void tls_post_encrypt(struct tls_mu=
lti *multi, const struct buffer *buf);
 
 /** @} name Functions for managin=
g security parameter state for data channel packets */
 
@@ -463,7 +463,8 @=
@
  */
 bool tls_session_update_crypto_params(struct tls_multi *multi, stru=
ct tls_session *session,
                                       struct opti=
ons *options, struct frame *frame,
-                                      s=
truct frame *frame_fragment, struct link_socket_info *lsi,
+               =
                       struct frame *frame_fragment,
+                     =
                 const struct link_socket_info *lsi,
                      =
                 dco_context_t *dco);
 
 /*
@@ -527,7 +528,7 @@
 #define PD=
_VERBOSE                 (1 << 10)
 #define PD_TLS_CRYPT               (1 <=
< 11)
 
-const char *protocol_dump(struct buffer *buffer, unsigned int flag=
s, struct gc_arena *gc);
+const char *protocol_dump(const struct buffer *bu=
ffer, unsigned int flags, struct gc_arena *gc);
 
 /*
  * debugging code
@@=
 -566,7 +567,7 @@
 /* Special method to skip the three way handshake RESET =
stages=2E This is
  * used by the HMAC code when seeing a packet that match=
es the previous
  * HMAC based stateless server state */
-bool session_skip=
_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_state *st=
ate,
-                               struct link_socket_actual *from);
+boo=
l session_skip_to_pre_start(struct tls_session *session, const struct tls_p=
re_decrypt_state *state,
+                               const struct link_=
socket_actual *from);
 
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src=
/openvpn/ssl_backend=2Eh b/src/openvpn/ssl_backend=2Eh
index a6d57f2=2E=2E2=
150d81 100644
--- a/src/openvpn/ssl_backend=2Eh
+++ b/src/openvpn/ssl_backe=
nd=2Eh
@@ -137,7 +137,7 @@
  *
  * @return      true if the context is init=
ialised, false if not=2E
  */
-bool tls_ctx_initialised(struct tls_root_ctx=
 *ctx);
+bool tls_ctx_initialised(const struct tls_root_ctx *ctx);
 
 /**
 =
 * Set any library specific options=2E
diff --git a/src/openvpn/ssl_mbedtls=
=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 9983742=2E=2E965ecdb 100644
--- a/=
src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -146,7 +14=
6,7 @@
 }
 
 bool
-tls_ctx_initialised(struct tls_root_ctx *ctx)
+tls_ctx_i=
nitialised(const struct tls_root_ctx *ctx)
 {
     /* either this should be=
 NULL or should be non-null and then have a
      * valid TLS ctx inside as=
 well */
diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_openssl=
=2Ec
index b88e1d9=2E=2E73cda0c 100644
--- a/src/openvpn/ssl_openssl=2Ec
++=
+ b/src/openvpn/ssl_openssl=2Ec
@@ -129,7 +129,7 @@
 }
 
 bool
-tls_ctx_ini=
tialised(struct tls_root_ctx *ctx)
+tls_ctx_initialised(const struct tls_ro=
ot_ctx *ctx)
 {
     /* either this should be NULL or should be non-null an=
d then have a
      * valid TLS ctx inside as well */
@@ -2010,7 +2010,7 @@=

 }
 
 static void
-bio_debug_data(const char *mode, BIO *bio, const uint8_=
t *buf, int len, const char *desc)
+bio_debug_data(const char *mode, const =
BIO *bio, const uint8_t *buf, int len, const char *desc)
 {
     struct gc_=
arena gc =3D gc_new();
     if (len > 0)
@@ -2024,7 +2024,7 @@
 }
 
 static=
 void
-bio_debug_oc(const char *mode, BIO *bio)
+bio_debug_oc(const char *m=
ode, const BIO *bio)
 {
     open_biofp();
     fprintf(biofp, "BIO %s time=
=3D%" PRIi64 " bio=3D" ptr_format "\n", mode, (int64_t)time(NULL),
diff --g=
it a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index e9afda4=2E=2Ef=
78782f 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@=
@ -119,7 +119,7 @@
  */
 static void
 tls_wrap_control(struct tls_wrap_ctx =
*ctx, uint8_t header, struct buffer *buf,
-                 struct session_=
id *session_id)
+                 const struct session_id *session_id)
 {
 =
    if (ctx->mode =3D=3D TLS_WRAP_AUTH || ctx->mode =3D=3D TLS_WRAP_NONE)
 =
    {
@@ -403,9 +403,9 @@
 
 
 struct buffer
-tls_reset_standalone(struct t=
ls_wrap_ctx *ctx, struct tls_auth_standalone *tas,
-                     st=
ruct session_id *own_sid, struct session_id *remote_sid, uint8_t header,
- =
                    bool request_resend_wkc)
+tls_reset_standalone(struct t=
ls_wrap_ctx *ctx, const struct tls_auth_standalone *tas,
+                 =
    const struct session_id *own_sid, const struct session_id *remote_sid,
=
+                     uint8_t header, bool request_resend_wkc)
 {
     /* C=
opy buffer here to point at the same data but allow tls_wrap_control
      =
* to potentially change buf to point to another buffer without
@@ -490,7 +4=
90,7 @@
 bool
 check_session_hmac_and_pkt_id(struct tls_pre_decrypt_state *=
state,
                               const struct openvpn_sockaddr *from,
=
-                              uint8_t *key,
+                             =
 const uint8_t *key,
                               int handwindow,
       =
                        bool pkt_is_ack)
 {
diff --git a/src/openvpn/ssl_pk=
t=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8930=2E=2E8203e4a 100644
--- a/src=
/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -183,7 +183,7 @@
  * =
@return              the expected server session id
  */
 bool check_sessio=
n_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openvpn=
_sockaddr *from,
-                                   uint8_t *key, int hand=
window, bool pkt_is_ack);
+                                   const uint8_t=
 *key, int handwindow, bool pkt_is_ack);
 
 /*
  * Write a control channel =
authentication record=2E
@@ -210,8 +210,9 @@
  * from the tls pre decrypt s=
tate=2E
  *
  */
-struct buffer tls_reset_standalone(struct tls_wrap_ctx *c=
tx, struct tls_auth_standalone *tas,
-                                   st=
ruct session_id *own_sid, struct session_id *remote_sid,
+struct buffer tls=
_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalon=
e *tas,
+                                   const struct session_id *own_si=
d,
+                                   const struct session_id *remote_sid,=

                                    uint8_t header, bool request_resend_wk=
c);
 
 
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2E=
c
index 6631718=2E=2E0acba2b 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/=
src/openvpn/ssl_verify=2Ec
@@ -1140,7 +1140,7 @@
  * cache=2E
  */
 static =
bool
-tls_authentication_status_use_cache(struct tls_multi *multi)
+tls_aut=
hentication_status_use_cache(const struct tls_multi *multi)
 {
     unsigne=
d int idx =3D min_uint(multi->tas_cache_num_updates, SIZE(cache_intervals) =
- 1);
     time_t latency =3D cache_intervals[idx];
@@ -1284,7 +1284,7 @@
 =
 * Check if the script/plugin left a message in the auth failed message
  *=
 file and relay it to the user */
 static void
-check_for_client_reason(str=
uct tls_multi *multi, struct auth_deferred_status *status)
+check_for_clien=
t_reason(struct tls_multi *multi, const struct auth_deferred_status *status=
)
 {
     struct gc_arena gc =3D gc_new();
     const char *msg =3D key_sta=
te_check_auth_failed_message_file(status, &gc);
@@ -1553,7 +1553,7 @@
 #end=
if /* ifdef ENABLE_MANAGEMENT */
 
 static bool
-set_verify_user_pass_env(s=
truct user_pass *up, struct tls_multi *multi, struct tls_session *session)
=
+set_verify_user_pass_env(const struct user_pass *up, struct tls_multi *mul=
ti, struct tls_session *session)
 {
     /* Is username defined? */
     if=
 ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->us=
ername))
@@ -1581,7 +1581,7 @@
 }
 
 bool
-ssl_verify_username_length(struc=
t tls_session *session, const char *username)
+ssl_verify_username_length(c=
onst struct tls_session *session, const char *username)
 {
     if ((sessio=
n->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
         && strlen(userna=
me) > TLS_USERNAME_LEN)
diff --git a/src/openvpn/ssl_verify=2Eh b/src/openv=
pn/ssl_verify=2Eh
index 3176d76=2E=2Ee77bc4a 100644
--- a/src/openvpn/ssl_v=
erify=2Eh
+++ b/src/openvpn/ssl_verify=2Eh
@@ -202,7 +202,7 @@
  * @return =
             true if name is under limit or username-as-common-name
  *    =
                  is not active
  */
-bool ssl_verify_username_length(struc=
t tls_session *session, const char *username);
+bool ssl_verify_username_le=
ngth(const struct tls_session *session, const char *username);
 
 /**
  * R=
uns the --client-crresponse script if one is defined=2E
@@ -275,7 +275,7 @@=

 void auth_set_client_reason(struct tls_multi *multi, const char *client_r=
eason);
 
 static inline const char *
-tls_client_reason(struct tls_multi *=
multi)
+tls_client_reason(const struct tls_multi *multi)
 {
     return mul=
ti->client_reason;
 }
diff --git a/src/openvpn/status=2Ec b/src/openvpn/sta=
tus=2Ec
index c7d375b=2E=2Ecfbc38d 100644
--- a/src/openvpn/status=2Ec
+++ =
b/src/openvpn/status=2Ec
@@ -135,7 +135,7 @@
 }
 
 void
-status_reset(struc=
t status_output *so)
+status_reset(const struct status_output *so)
 {
     =
if (so && so->fd >=3D 0)
     {
diff --git a/src/openvpn/status=2Eh b/src/o=
penvpn/status=2Eh
index 7953a4e=2E=2E4c01d75 100644
--- a/src/openvpn/statu=
s=2Eh
+++ b/src/openvpn/status=2Eh
@@ -69,7 +69,7 @@
 
 bool status_trigger=
(struct status_output *so);
 
-void status_reset(struct status_output *so);=

+void status_reset(const struct status_output *so);
 
 void status_flush(s=
truct status_output *so);
 
diff --git a/src/openvpn/tun=2Ec b/src/openvpn/=
tun=2Ec
index 133f670=2E=2Ef191a6b 100644
--- a/src/openvpn/tun=2Ec
+++ b/s=
rc/openvpn/tun=2Ec
@@ -835,7 +835,7 @@
          const char *ifconfig_ipv6_=
local_parm,     /* --ifconfig parm 1 IPv6 */
          int ifconfig_ipv6_ne=
tbits_parm,
          const char *ifconfig_ipv6_remote_parm,    /* --ifconf=
ig parm 2 IPv6 */
-         struct addrinfo *local_public, struct addrinfo =
*remote_public, const bool strict_warn,
+         const struct addrinfo *lo=
cal_public, const struct addrinfo *remote_public, const bool strict_warn,
 =
         struct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)
 {
=
     if (!tt)
@@ -978,7 +978,7 @@
  * -> helper function to simplify code b=
elow
  */
 static void
-add_route_connected_v6_net(struct tuntap *tt, const=
 struct env_set *es)
+add_route_connected_v6_net(const struct tuntap *tt, c=
onst struct env_set *es)
 {
     struct route_ipv6 r6;
 
@@ -1020,7 +1020,7=
 @@
  */
 
 in_addr_t
-create_arbitrary_remote(struct tuntap *tt)
+create_a=
rbitrary_remote(const struct tuntap *tt)
 {
     in_addr_t remote;
 
@@ -15=
92,7 +1592,7 @@
 }
 
 static void
-undo_ifconfig_ipv4(struct tuntap *tt, op=
envpn_net_ctx_t *ctx)
+undo_ifconfig_ipv4(const struct tuntap *tt, openvpn_=
net_ctx_t *ctx)
 {
 #if defined(TARGET_LINUX)
     int netbits =3D netmask_=
to_netbits2(tt->remote_netmask);
@@ -1627,7 +1627,7 @@
 }
 
 static void
-u=
ndo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig=
_ipv6(const struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
 #if defined(TARG=
ET_LINUX)
     if (net_addr_v6_del(ctx, tt->actual_name, &tt->local_ipv6, t=
t->netbits_ipv6) < 0)
@@ -1652,7 +1652,7 @@
 }
 
 void
-undo_ifconfig(struc=
t tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig(const struct tuntap *t=
t, openvpn_net_ctx_t *ctx)
 {
     if (tt->backend_driver !=3D DRIVER_NULL =
&& tt->backend_driver !=3D DRIVER_AFUNIX)
     {
@@ -1720,13 +1720,13 @@
 }=

 
 static ssize_t
-write_tun_header(struct tuntap *tt, uint8_t *buf, int l=
en)
+write_tun_header(const struct tuntap *tt, const uint8_t *buf, int len)=

 {
     if (tt->type =3D=3D DEV_TYPE_TUN)
     {
         u_int32_t type;
=
         struct iovec iv[2];
-        const struct ip *iph =3D (struct ip *=
)buf;
+        const struct ip *iph =3D (const struct ip *)buf;
 
         =
if (iph->ip_v =3D=3D 6)
         {
@@ -1737,9 +1737,11 @@
             type=
 =3D htonl(AF_INET);
         }
 
+        /* argument to writev is a point=
er to const but we still need to drop
+         * the const from buf pointe=
r here */
         iv[0]=2Eiov_base =3D &type;
         iv[0]=2Eiov_len =3D=
 sizeof(type);
-        iv[1]=2Eiov_base =3D buf;
+        iv[1]=2Eiov_base=
 =3D (void *)buf;
         iv[1]=2Eiov_len =3D len;
 
         return heade=
r_modify_read_write_return(writev(tt->fd, iv, 2));
@@ -1751,7 +1753,7 @@
 }=

 
 static ssize_t
-read_tun_header(struct tuntap *tt, uint8_t *buf, int le=
n)
+read_tun_header(const struct tuntap *tt, uint8_t *buf, int len)
 {
    =
 if (tt->type =3D=3D DEV_TYPE_TUN)
     {
@@ -1777,13 +1779,13 @@
  */
 #if=
 !defined(TARGET_DARWIN)
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *bu=
f, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len=
)
 {
     return write_tun_header(tt, buf, len);
 }
 
 ssize_t
-read_tun(st=
ruct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, =
uint8_t *buf, int len)
 {
     return read_tun_header(tt, buf, len);
 }
@@ =
-1799,7 +1801,7 @@
 
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
=
 static bool
-tun_dco_enabled(struct tuntap *tt)
+tun_dco_enabled(const str=
uct tuntap *tt)
 {
     return tt->backend_driver =3D=3D DRIVER_DCO;
 }
@@ =
-2047,13 +2049,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *b=
uf, int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int le=
n)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct t=
untap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_=
t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
@@ -2252,13 +225=
4,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
=
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 {
     re=
turn write(tt->fd, buf, len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, ui=
nt8_t *buf, int len)
+read_tun(const struct tuntap *tt, uint8_t *buf, int l=
en)
 {
     return read(tt->fd, buf, len);
 }
@@ -2588,7 +2590,7 @@
 }
 
 s=
size_t
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(cons=
t struct tuntap *tt, const uint8_t *buf, int len)
 {
     struct strbuf sbu=
f;
     sbuf=2Elen =3D len;
@@ -2597,7 +2599,7 @@
 }
 
 ssize_t
-read_tun(s=
truct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap *tt,=
 uint8_t *buf, int len)
 {
     struct strbuf sbuf;
     int f =3D 0;
@@ -3=
095,7 +3097,7 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt, uint8_t *buf, =
int len)
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)
 =
{
     if (tt->backend_driver =3D=3D DRIVER_UTUN)
     {
@@ -3108,7 +3110,7=
 @@
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+read=
_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     if (tt->backen=
d_driver =3D=3D DRIVER_UTUN)
     {
@@ -3243,13 +3245,13 @@
 }
 
 ssize_t
-=
write_tun(struct tuntap *tt, uint8_t *buf, int len)
+write_tun(const struct=
 tuntap *tt, const uint8_t *buf, int len)
 {
     return write(tt->fd, buf,=
 len);
 }
 
 ssize_t
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
+r=
ead_tun(const struct tuntap *tt, uint8_t *buf, int len)
 {
     return read=
(tt->fd, buf, len);
 }
@@ -3311,7 +3313,7 @@
 }
 
 int
-tun_write_queue(str=
uct tuntap *tt, struct buffer *buf)
+tun_write_queue(struct tuntap *tt, con=
st struct buffer *buf)
 {
     if (tt->writes=2Eiostate =3D=3D IOSTATE_INIT=
IAL)
     {
@@ -3365,7 +3367,7 @@
 }
 
 int
-tun_write_win32(struct tuntap =
*tt, struct buffer *buf)
+tun_write_win32(struct tuntap *tt, const struct b=
uffer *buf)
 {
     int err =3D 0;
     int status =3D 0;
@@ -5370,7 +5372,=
7 @@
 }
 
 void
-fork_register_dns_action(struct tuntap *tt)
+fork_register=
_dns_action(const struct tuntap *tt)
 {
     if (tt && tt->options=2Eregist=
er_dns && tt->options=2Emsg_channel)
     {
@@ -5460,7 +5462,7 @@
 }
 
 sta=
tic void
-tuntap_get_mtu(struct tuntap *tt)
+tuntap_get_mtu(const struct tu=
ntap *tt)
 {
     ULONG mtu =3D 0;
     DWORD len;
@@ -6035,7 +6037,7 @@
 }=

 
 void
-tun_show_debug(struct tuntap *tt)
+tun_show_debug(const struct tu=
ntap *tt)
 {
     if (tt->backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6=
)
     {
@@ -6295,13 +6297,13 @@
 }
 
 ssize_t
-write_tun(struct tuntap *tt=
, uint8_t *buf, int len)
+write_tun(const struct tuntap *tt, const uint8_t =
*buf, int len)
 {
     return write(tt->fd, buf, len);
 }
 
 ssize_t
-read_=
tun(struct tuntap *tt, uint8_t *buf, int len)
+read_tun(const struct tuntap=
 *tt, uint8_t *buf, int len)
 {
     return read(tt->fd, buf, len);
 }
diff=
 --git a/src/openvpn/tun=2Eh b/src/openvpn/tun=2Eh
index 7340e7e=2E=2E61fe9=
43 100644
--- a/src/openvpn/tun=2Eh
+++ b/src/openvpn/tun=2Eh
@@ -272,9 +27=
2,9 @@
 
 void close_tun_handle(struct tuntap *tt);
 
-ssize_t write_tun(st=
ruct tuntap *tt, uint8_t *buf, int len);
+ssize_t write_tun(const struct tu=
ntap *tt, const uint8_t *buf, int len);
 
-ssize_t read_tun(struct tuntap *=
tt, uint8_t *buf, int len);
+ssize_t read_tun(const struct tuntap *tt, uint=
8_t *buf, int len);
 
 #ifdef ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const=
 char *dev, const char *dev_type, const char *dev_node, int persist_mode,
@=
@ -293,7 +293,7 @@
                         const char *ifconfig_ipv6_local=
_parm,     /* --ifconfig parm 1 / IPv6 */
                         int ifco=
nfig_ipv6_netbits_parm,           /* --ifconfig parm 1 / bits */
          =
               const char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm=
 2 / IPv6 */
-                        struct addrinfo *local_public, struct=
 addrinfo *remote_public,
+                        const struct addrinfo *l=
ocal_public, const struct addrinfo *remote_public,
                        =
 const bool strict_warn, struct env_set *es, openvpn_net_ctx_t *ctx,
      =
                   struct tuntap *tt);
 
@@ -320,7 +320,7 @@
  * @param tt =
   the tuntap interface context
  * @param ctx   the networking API opaque =
context
  */
-void undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)=
;
+void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 =
bool is_dev_type(const char *dev, const char *dev_type, const char *match_t=
ype);
 
@@ -351,7 +351,7 @@
 #define IFCONFIG_DEFAULT IFCONFIG_AFTER_TUN_OP=
EN
 
 static inline int
-ifconfig_order(struct tuntap *tt)
+ifconfig_order(=
const struct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNI=
X)
     {
@@ -381,7 +381,7 @@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
=
 
 static inline int
-route_order(struct tuntap *tt)
+route_order(const str=
uct tuntap *tt)
 {
     if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
     {=

@@ -454,13 +454,13 @@
 
 const char *tap_win_getinfo(const struct tuntap *=
tt, struct gc_arena *gc);
 
-void tun_show_debug(struct tuntap *tt);
+void =
tun_show_debug(const struct tuntap *tt);
 
 bool dhcp_release_by_adapter_in=
dex(const DWORD adapter_index);
 
 bool dhcp_renew_by_adapter_index(const D=
WORD adapter_index);
 
-void fork_register_dns_action(struct tuntap *tt);
+=
void fork_register_dns_action(const struct tuntap *tt);
 
 void ipconfig_re=
gister_dns(const struct env_set *es);
 
@@ -470,7 +470,7 @@
 
 int tun_read=
_queue(struct tuntap *tt, int maxsize);
 
-int tun_write_queue(struct tunta=
p *tt, struct buffer *buf);
+int tun_write_queue(struct tuntap *tt, const s=
truct buffer *buf);
 
 static inline bool
 tuntap_stop(int status)
@@ -499,=
7 +499,7 @@
     return false;
 }
 
-int tun_write_win32(struct tuntap *tt,=
 struct buffer *buf);
+int tun_write_win32(struct tuntap *tt, const struct =
buffer *buf);
 
 static inline bool
 is_ip_packet_valid(const struct buffer=
 *buf)
@@ -529,19 +529,21 @@
 }
 
 static inline bool
-tuntap_is_dco_win(st=
ruct tuntap *tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
     return=
 tt && tt->backend_driver =3D=3D DRIVER_DCO;
 }
 
 static inline bool
-tunt=
ap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
+tuntap_is_dco_win=
_timeout(const struct tuntap *tt, ssize_t status)
 {
     return tuntap_is_=
dco_win(tt) && (status < 0) && (openvpn_errno() =3D=3D ERROR_NETNAME_DELETE=
D);
 }
 
 #else  /* ifdef _WIN32 */
 
+// cppcheck-suppress-begin constPara=
meterPointer ; stubs
+
 static inline bool
 tuntap_stop(int status)
 {
@@ -=
565,19 +567,20 @@
     return true;
 }
 
-
 static inline bool
-tuntap_is_d=
co_win(struct tuntap *tt)
+tuntap_is_dco_win(const struct tuntap *tt)
 {
  =
   return false;
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct=
 tuntap *tt, ssize_t status)
+tuntap_is_dco_win_timeout(const struct tuntap=
 *tt, ssize_t status)
 {
     return false;
 }
 
+// cppcheck-suppress-end =
constParameterPointer
+
 #endif /* ifdef _WIN32 */
 
 /*
diff --git a/src/o=
penvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec
index f494d42=2E=2E79d70=
6a 100644
--- a/src/openvpn/tun_afunix=2Ec
+++ b/src/openvpn/tun_afunix=2Ec=

@@ -49,7 +49,7 @@
 
 
 static void
-tun_afunix_exec_child(const char *dev_=
node, struct tuntap *tt, struct env_set *env)
+tun_afunix_exec_child(const =
char *dev_node, struct tuntap *tt, const struct env_set *env)
 {
     const=
 char *msgprefix =3D "ERROR: failure executing process for tun:";
     stru=
ct argv argv =3D argv_new();
@@ -74,7 +74,7 @@
 }
 
 void
-open_tun_afunix(=
struct options *o, int mtu, struct tuntap *tt, struct env_set *orig_env)
+o=
pen_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, const s=
truct env_set *orig_env)
 {
     struct gc_arena gc =3D gc_new();
 
@@ -146=
,7 +146,7 @@
 }
 
 ssize_t
-write_tun_afunix(struct tuntap *tt, uint8_t *bu=
f, int len)
+write_tun_afunix(struct tuntap *tt, const uint8_t *buf, int le=
n)
 {
     const char *msg =3D "ERROR: failure during write to AF_UNIX sock=
et: ";
     if (!openvpn_waitpid_check(tt->afunix=2Echildprocess, msg, M_WA=
RN))
@@ -172,8 +172,11 @@
     return read(tt->fd, buf, len);
 }
 #else  /*=
 ifndef WIN32 */
+
+// cppcheck-suppress-begin constParameterPointer ; stub=
s
+
 void
-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, s=
truct env_set *orig_env)
+open_tun_afunix(const struct options *o, int mtu,=
 struct tuntap *tt, const struct env_set *orig_env)
 {
     msg(M_ERR, "AF_=
UNIX socket support not available on this platform");
 }
@@ -186,7 +189,7 @=
@
 }
 
 ssize_t
-write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)=

+write_tun_afunix(struct tuntap *tt, const uint8_t *buf, int len)
 {
     =
/* should never be called as open_tun_afunix always fails */
     ASSERT(0)=
;
@@ -199,4 +202,6 @@
     ASSERT(0);
 }
 
+// cppcheck-suppress-end constP=
arameterPointer
+
 #endif /* ifndef WIN32 */
diff --git a/src/openvpn/tun_a=
funix=2Eh b/src/openvpn/tun_afunix=2Eh
index 5b6a8e0=2E=2E5307e31 100644
--=
- a/src/openvpn/tun_afunix=2Eh
+++ b/src/openvpn/tun_afunix=2Eh
@@ -31,7 +3=
1,7 @@
  * the user provided taking care of implementing the actual tun
  *=
 device=2E
  */
-void open_tun_afunix(struct options *o, int mtu, struct tu=
ntap *tt, struct env_set *env);
+void open_tun_afunix(const struct options =
*o, int mtu, struct tuntap *tt, const struct env_set *env);
 
 
 /**
@@ -43=
,7 +43,7 @@
 /**
  * Writes a packet to a AF_UNIX based tun device=2E
  */
=
-ssize_t write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len);
+ssize=
_t write_tun_afunix(struct tuntap *tt, const uint8_t *buf, int len);
 
 /**=

  * Reads a packet from a AF_UNIX based tun device=2E
diff --git a/src/ope=
nvpn/vlan=2Ec b/src/openvpn/vlan=2Ec
index 69ac10d=2E=2E04e18d6 100644
--- =
a/src/openvpn/vlan=2Ec
+++ b/src/openvpn/vlan=2Ec
@@ -288,7 +288,7 @@
 }
 
=
 void
-vlan_process_outgoing_tun(struct multi_context *m, struct multi_inst=
ance *mi)
+vlan_process_outgoing_tun(const struct multi_context *m, struct =
multi_instance *mi)
 {
     if (!m->top=2Eoptions=2Evlan_tagging)
     {
di=
ff --git a/src/openvpn/vlan=2Eh b/src/openvpn/vlan=2Eh
index 9389f89=2E=2Ec=
d2f66f 100644
--- a/src/openvpn/vlan=2Eh
+++ b/src/openvpn/vlan=2Eh
@@ -35,=
6 +35,6 @@
 
 bool vlan_is_tagged(const struct buffer *buf);
 
-void vlan_p=
rocess_outgoing_tun(struct multi_context *m, struct multi_instance *mi);
+v=
oid vlan_process_outgoing_tun(const struct multi_context *m, struct multi_i=
nstance *mi);
 
 #endif /* VLAN_H */
diff --git a/src/openvpn/win32=2Eh b/s=
rc/openvpn/win32=2Eh
index 8be3d96=2E=2E39ff7d8 100644
--- a/src/openvpn/wi=
n32=2Eh
+++ b/src/openvpn/win32=2Eh
@@ -227,7 +227,7 @@
 void overlapped_io=
_close(struct overlapped_io *o);
 
 static inline bool
-overlapped_io_activ=
e(struct overlapped_io *o)
+overlapped_io_active(const struct overlapped_io=
 *o)
 {
     return o->iostate =3D=3D IOSTATE_QUEUED || o->iostate =3D=3D I=
OSTATE_IMMEDIATE_RETURN;
 }
diff --git a/src/openvpnmsica/openvpnmsica=2Ec =
b/src/openvpnmsica/openvpnmsica=2Ec
index 1a17d95=2E=2Ed2fd9af 100644
--- a=
/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openvpnmsica=2Ec
=
@@ -77,7 +77,7 @@
  * @return ERROR_SUCCESS on success; An error code other=
wise
  */
 static UINT
-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCW=
STR szProperty, _In_ struct msica_arg_seq *seq)
+setup_sequence(_In_ MSIHAN=
DLE hInstall, _In_z_ LPCWSTR szProperty, _In_ const struct msica_arg_seq *s=
eq)
 {
     UINT uiResult;
     LPWSTR szSequence =3D msica_arg_seq_join(se=
q);
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interact=
ive=2Ec
index 9a68bbb=2E=2Ed8cf6e1 100644
--- a/src/openvpnserv/interactive=
=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -522,7 +522,7 @@
 
 
 static =
SOCKADDR_INET
-sockaddr_inet(short family, inet_address_t *addr)
+sockaddr_=
inet(short family, const inet_address_t *addr)
 {
     SOCKADDR_INET sa_ine=
t;
     ZeroMemory(&sa_inet, sizeof(sa_inet));
diff --git a/tests/unit_test=
s/openvpn/mock_management=2Ec b/tests/unit_tests/openvpn/mock_management=2E=
c
index 77f6ce2=2E=2Efff4c2b 100644
--- a/tests/unit_tests/openvpn/mock_man=
agement=2Ec
+++ b/tests/unit_tests/openvpn/mock_management=2Ec
@@ -36,7 +36=
,7 @@
 struct management *management; /* GLOBAL */
 
 void
-management_auth=
_failure(struct management *man, const char *type, const char *reason)
+man=
agement_auth_failure(const struct management *man, const char *type, const =
char *reason)
 {
     ASSERT(false);
 }
diff --git a/tests/unit_tests/openv=
pn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openssl=2Ec
index=
 52f13b8=2E=2Ee7282b2 100644
--- a/tests/unit_tests/openvpn/siphash_openssl=
=2Ec
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Ec
@@ -100,7 +100,7 @@=

 }
 
 bool
-siphash_openssl_available(void *sip_context)
+siphash_openssl_=
available(const void *sip_context)
 {
     const struct siphash_context *si=
p =3D sip_context;
 
@@ -117,6 +117,8 @@
 }
 #else
 /* Do avoid a lot more =
ifdefs in the test we put dummy functions here */
+// cppcheck-suppress-beg=
in constParameterPointer ; stubs
+
 int
 siphash_openssl(void *sip_context,=
 const void *in, const size_t inlen,
                 const void *k, uint8_=
t *out, const size_t outlen)
@@ -125,7 +127,7 @@
 }
 
 bool
-siphash_openss=
l_available(void *sip_context)
+siphash_openssl_available(const void *sip_c=
ontext)
 {
     return false;
 }
@@ -141,5 +143,6 @@
 {
 }
 
+// cppcheck-s=
uppress-end constParameterPointer
 
 #endif /* if defined(ENABLE_CRYPTO_OPE=
NSSL) && OPENSSL_VERSION_NUMBER >=3D 0x30000000L */
diff --git a/tests/unit=
_tests/openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/siphash_opens=
sl=2Eh
index 0f1d329=2E=2Ea44457e 100644
--- a/tests/unit_tests/openvpn/sip=
hash_openssl=2Eh
+++ b/tests/unit_tests/openvpn/siphash_openssl=2Eh
@@ -60,=
5 +60,5 @@
  *
  */
 bool
-siphash_openssl_available(void *sip_context);
-#=
endif /* ifndef SIPHASH_OPENSSL_H */
\ No newline at end of file
+siphash_o=
penssl_available(const void *sip_context);
+#endif /* ifndef SIPHASH_OPENSS=
L_H */
diff --git a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tes=
ts/openvpn/test_misc=2Ec
index a41c27b=2E=2Ea8daee6 100644
--- a/tests/unit=
_tests/openvpn/test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@=
@ -146,7 +146,7 @@
 }
 
 static struct hash_element *
-hash_lookup_by_value=
(struct hash *hash, void *value)
+hash_lookup_by_value(struct hash *hash, c=
onst void *value)
 {
     struct hash_iterator hi;
     struct hash_element=
 *he;
diff --git a/tests/unit_tests/openvpn/test_user_pass=2Ec b/tests/unit=
_tests/openvpn/test_user_pass=2Ec
index c0a0866=2E=2E7636a33 100644
--- a/t=
ests/unit_tests/openvpn/test_user_pass=2Ec
+++ b/tests/unit_tests/openvpn/t=
est_user_pass=2Ec
@@ -59,7 +59,7 @@
     return mock();
 }
 void
-managemen=
t_auth_failure(struct management *man, const char *type, const char *reason=
)
+management_auth_failure(const struct management *man, const char *type, =
const char *reason)
 {
     assert_true(0);
 }

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
G=
errit-Change-Number: 1663
Gerrit-PatchSet: 31
Gerrit-Owner: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>

--rpnYIPKniVw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Frank Lichtenheld <strong>uploaded patch set #31</strong> to th=
is change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
63?usp=3Demail">View Change</a></p><p>The following approvals got outdated =
and were removed:
Code-Review+1 by R=C4=83zvan Cojocaru</p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Re=
move instances of constParameterPointer cppcheck warnings<br><br>This requi=
res a few suppressions since cppcheck<br>doesn&#39;t quite understand the d=
ifferent code-paths<br>implemented by preprocessor defines=2E<br><br>Change=
-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-supp=
ressions=2Exml<br>M sample/sample-plugins/client-connect/sample-client-conn=
ect=2Ec<br>M sample/sample-plugins/defer/multi-auth=2Ec<br>M sample/sample-=
plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec<br>M src/o=
penvpn/buffer=2Eh<br>M src/openvpn/clinat=2Ec<br>M src/openvpn/comp=2Ec<br>=
M src/openvpn/comp=2Eh<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=
=2Eh<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvpn/dco=
_freebsd=2Ec<br>M src/openvpn/dco_internal=2Eh<br>M src/openvpn/dco_linux=
=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/error=2Ec<br>M src/openv=
pn/error=2Eh<br>M src/openvpn/event=2Ec<br>M src/openvpn/event=2Eh<br>M src=
/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M src/openvpn/init=2Ec=
<br>M src/openvpn/init=2Eh<br>M src/openvpn/interval=2Eh<br>M src/openvpn/l=
ist=2Ec<br>M src/openvpn/list=2Eh<br>M src/openvpn/manage=2Ec<br>M src/open=
vpn/manage=2Eh<br>M src/openvpn/mbuf=2Ec<br>M src/openvpn/mbuf=2Eh<br>M src=
/openvpn/mss=2Ec<br>M src/openvpn/mss=2Eh<br>M src/openvpn/mtcp=2Ec<br>M sr=
c/openvpn/mtcp=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>=
M src/openvpn/multi=2Eh<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/netw=
orking=2Eh<br>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpn/networ=
king_sitnl=2Ec<br>M src/openvpn/occ=2Eh<br>M src/openvpn/openssl_compat=2Eh=
<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/o=
penvpn/otime=2Ec<br>M src/openvpn/otime=2Eh<br>M src/openvpn/proto=2Eh<br>M=
 src/openvpn/proxy=2Ec<br>M src/openvpn/proxy=2Eh<br>M src/openvpn/ps=2Ec<b=
r>M src/openvpn/ps=2Eh<br>M src/openvpn/push=2Ec<br>M src/openvpn/push=2Eh<=
br>M src/openvpn/push_util=2Ec<br>M src/openvpn/reliable=2Ec<br>M src/openv=
pn/reliable=2Eh<br>M src/openvpn/route=2Ec<br>M src/openvpn/schedule=2Ec<br=
>M src/openvpn/socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/sock=
et_util=2Eh<br>M src/openvpn/socks=2Ec<br>M src/openvpn/socks=2Eh<br>M src/=
openvpn/ssl=2Ec<br>M src/openvpn/ssl=2Eh<br>M src/openvpn/ssl_backend=2Eh<b=
r>M src/openvpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_openssl=2Ec<br>M src/o=
penvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M src/openvpn/ssl_verify=
=2Ec<br>M src/openvpn/ssl_verify=2Eh<br>M src/openvpn/status=2Ec<br>M src/o=
penvpn/status=2Eh<br>M src/openvpn/tun=2Ec<br>M src/openvpn/tun=2Eh<br>M sr=
c/openvpn/tun_afunix=2Ec<br>M src/openvpn/tun_afunix=2Eh<br>M src/openvpn/v=
lan=2Ec<br>M src/openvpn/vlan=2Eh<br>M src/openvpn/win32=2Eh<br>M src/openv=
pnmsica/openvpnmsica=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M tests/un=
it_tests/openvpn/mock_management=2Ec<br>M tests/unit_tests/openvpn/siphash_=
openssl=2Ec<br>M tests/unit_tests/openvpn/siphash_openssl=2Eh<br>M tests/un=
it_tests/openvpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_user_pass=
=2Ec<br>90 files changed, 402 insertions(+), 288 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/63/1663/31</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppressions=2Exml b=
/dev-tools/cppcheck-suppressions=2Exml</span><br><span>index 9d8c202=2E=2Eb=
d24c3b 100644</span><br><span>--- a/dev-tools/cppcheck-suppressions=2Exml</=
span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>=
@@ -9,9 +9,6 @@</span><br><span>     &lt;id&gt;constParameterCallback&lt;/i=
d&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&=
gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    &lt;id&gt;cons=
tParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  &lt;suppress&gt;</span><br><span>     &lt;id&gt;unusedFunction&lt;/i=
d&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span>   &lt;suppress&=
gt;</span><br><span>@@ -65,6 +62,97 @@</span><br><span>     &lt;id&gt;badBi=
tmaskCheck&lt;/id&gt;</span><br><span>     &lt;fileName&gt;tests/unit_tests=
/openvpn/test_pkt=2Ec&lt;/fileName&gt;</span><br><span>   &lt;/suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: we u=
se casts to remove const --&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/buffe=
r=2Eh&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &lt;symbolName&gt;buf&lt;/symbolName&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  &lt;!-- FP: const silently removed due to poi=
nter arithmetic --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/buffer=2Ec&lt;=
/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &l=
t;symbolName&gt;buf&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  &lt;!-- IGN: external --&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt=
;/usr/include/*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  &lt;!-- IGN: too many false-positives due to stubs --&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constPara=
meterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;fileName&gt;tests/unit_tests/openvpn*/test_*&lt;/fileName&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constPar=
ameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;fileName&gt;tests/unit_tests/openvpn/mock_*&lt;/fileName&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!-- IGN: too ma=
ny false-positives due to library/platform-specific code --&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPoin=
ter&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
lt;fileName&gt;src/openvpn/crypto*&lt;/fileName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNa=
me&gt;src/openvpn/ssl_*&lt;/fileName&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/open=
vpn/dco*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/socket=2E=
*&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 &lt;!-- FP: const is only possible on some platforms</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+       These might easily hide valid issu=
es but we need to compromise</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+       for developer sanity=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+       Inline suppressions are often too ugly since the=
y need to go in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
   between our return type line and the function name=2E=2E=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  --&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNa=
me&gt;src/openvpn/dns=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    &lt;symbolName&gt;duri&lt;/symbolName&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParamete=
rPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    &lt;fileName&gt;src/openvpn/error=2Ec&lt;/fileName&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;gc&lt;/symbolN=
ame&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppr=
ess&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppre=
ss&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt=
;constParameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    &lt;fileName&gt;src/openvpn/forward=2Ec&lt;/fileName&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&g=
t;dco&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/manage=2Ec&l=
t;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
&lt;symbolName&gt;man&lt;/symbolName&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/id&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/open=
vpn/misc=2Ec&lt;/fileName&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    &lt;symbolName&gt;up&lt;/symbolName&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constParameterPointer&lt;/i=
d&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;fileNa=
me&gt;src/openvpn/options=2Ec&lt;/fileName&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;options&lt;/symbolName&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/suppress&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;suppress&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;id&gt;constP=
arameterPointer&lt;/id&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    &lt;fileName&gt;src/openvpn/tun=2Ec&lt;/fileName&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &lt;symbolName&gt;gc&lt;/sy=
mbolName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;/=
suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &lt;!=
-- IGN: weird issue with MinGW debug build throwing -Werror=3Dmaybe-uniniti=
alized</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       for no=
 good reason --&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  &lt;suppress&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &lt;id&gt;constParameterPointer&lt;/id&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    &lt;fileName&gt;src/openvpn/buffer=2Eh&lt;/fi=
leName&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &lt;s=
ymbolName&gt;p&lt;/symbolName&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  &lt;/suppress&gt;</span><br><span>   &lt;!-- FP: cppcheck s=
eems to have wrong signature of DeviceIoControl() --&gt;</span><br><span>  =
 &lt;suppress&gt;</span><br><span>     &lt;id&gt;constVariablePointer&lt;/i=
d&gt;</span><br><span>diff --git a/sample/sample-plugins/client-connect/sam=
ple-client-connect=2Ec b/sample/sample-plugins/client-connect/sample-client=
-connect=2Ec</span><br><span>index 420de61=2E=2Ecbd98e8 100644</span><br><s=
pan>--- a/sample/sample-plugins/client-connect/sample-client-connect=2Ec</s=
pan><br><span>+++ b/sample/sample-plugins/client-connect/sample-client-conn=
ect=2Ec</span><br><span>@@ -344,7 +344,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-openvpn_plugin_client_connect(struct plugin_context *context, const ch=
ar **argv, const char **envp)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+openvpn_plugin_client_connect(const struct plugin_context *contex=
t, const char **argv, const char **envp)</span><br><span> {</span><br><span=
>     /* log environment variables handed to us by OpenVPN, but</span><br><=
span>      * only if &quot;setenv verb&quot; is 3 or higher (arbitrary numb=
er)</span><br><span>@@ -465,7 +465,7 @@</span><br><span> </span><br><span> =
int</span><br><span> openvpn_plugin_client_connect_defer_v2(struct plugin_c=
ontext *context,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                  struct plugin_per_client_context *pcc,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                 const struct plugin_per_client_context *pcc,</span><br><sp=
an>                                        struct openvpn_plugin_string_lis=
t **return_list)</span><br><span> {</span><br><span>     time_t time_left =
=3D pcc-&gt;sleep_until - time(NULL);</span><br><span>diff --git a/sample/s=
ample-plugins/defer/multi-auth=2Ec b/sample/sample-plugins/defer/multi-auth=
=2Ec</span><br><span>index bacf557=2E=2Ecdd616f 100644</span><br><span>--- =
a/sample/sample-plugins/defer/multi-auth=2Ec</span><br><span>+++ b/sample/s=
ample-plugins/defer/multi-auth=2Ec</span><br><span>@@ -255,7 +255,7 @@</spa=
n><br><span> }</span><br><span> </span><br><span> static bool</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-do_auth_user_pass(struct plugin_con=
text *context, const char *username, const char *password)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+do_auth_user_pass(const struct plugi=
n_context *context, const char *username, const char *password)</span><br><=
span> {</span><br><span>     plog(context, PLOG_NOTE, &quot;expect_user=3D%=
s, received_user=3D%s, expect_passw=3D%s, received_passw=3D%s&quot;,</span>=
<br><span>          np(context-&gt;test_valid_user), np(username), np(conte=
xt-&gt;test_valid_pass), np(password));</span><br><span>@@ -279,7 +279,7 @@=
</span><br><span> </span><br><span> </span><br><span> static int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-auth_user_pass_verify(struct plu=
gin_context *context, struct plugin_per_client_context *pcc,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+auth_user_pass_verify(const struct=
 plugin_context *context, struct plugin_per_client_context *pcc,</span><br>=
<span>                       const char *argv[], const char *envp[])</span>=
<br><span> {</span><br><span>     /* get username/password from envp string=
 array */</span><br><span>diff --git a/sample/sample-plugins/keying-materia=
l-exporter-demo/keyingmaterialexporter=2Ec b/sample/sample-plugins/keying-m=
aterial-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>index 2043=
74b=2E=2E41c5c4f 100644</span><br><span>--- a/sample/sample-plugins/keying-=
material-exporter-demo/keyingmaterialexporter=2Ec</span><br><span>+++ b/sam=
ple/sample-plugins/keying-material-exporter-demo/keyingmaterialexporter=2Ec=
</span><br><span>@@ -187,7 +187,7 @@</span><br><span> }</span><br><span> </=
span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-file_store(char *file, char *content)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+file_store(const char *file, const char *content)</=
span><br><span> {</span><br><span>     FILE *f;</span><br><span>     if (!(=
f =3D fopen(file, &quot;w+&quot;)))</span><br><span>@@ -203,7 +203,7 @@</sp=
an><br><span> server_store(struct openvpn_plugin_args_func_in const *args)<=
/span><br><span> {</span><br><span>     struct plugin *plugin =3D (struct p=
lugin *)args-&gt;handle;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct session *sess =3D (struct session *)args-&gt;per_client_conte=
xt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 session *sess =3D args-&gt;per_client_context;</span><br><span> </span><br=
><span>     char file[MAXPATH];</span><br><span>     snprintf(file, sizeof(=
file) - 1, &quot;/tmp/openvpn_sso_%s&quot;, sess-&gt;key);</span><br><span>=
@@ -215,7 +215,7 @@</span><br><span> client_store(struct openvpn_plugin_arg=
s_func_in const *args)</span><br><span> {</span><br><span>     struct plugi=
n *plugin =3D (struct plugin *)args-&gt;handle;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    struct session *sess =3D (struct session *)ar=
gs-&gt;per_client_context;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const struct session *sess =3D args-&gt;per_client_context;</spa=
n><br><span> </span><br><span>     char *file =3D &quot;/tmp/openvpn_sso_us=
er&quot;;</span><br><span>     ovpn_note(&quot;app session file: %s&quot;, =
file);</span><br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/bu=
ffer=2Eh</span><br><span>index 58e10f0=2E=2E063a2d4 100644</span><br><span>=
--- a/src/openvpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</=
span><br><span>@@ -1920,7 +1920,7 @@</span><br><span>  * @param a  The aren=
a to test=2E</span><br><span>  */</span><br><span> static inline bool</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-gc_defined(struct gc_arena =
*a)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+gc_defined(const=
 struct gc_arena *a)</span><br><span> {</span><br><span>     return a-&gt;l=
ist !=3D NULL;</span><br><span> }</span><br><span>diff --git a/src/openvpn/=
clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index dcef924=2E=2Ed72d=
42a 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+++=
 b/src/openvpn/clinat=2Ec</span><br><span>@@ -158,7 +158,7 @@</span><br><sp=
an> #endif</span><br><span> </span><br><span> static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-print_pkt(struct openvpn_iphdr *iph, co=
nst char *prefix, const int direction, const msglvl_t msglevel)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+print_pkt(const struct openvpn_=
iphdr *iph, const char *prefix, const int direction, const msglvl_t msgleve=
l)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();=
</span><br><span> </span><br><span>diff --git a/src/openvpn/comp=2Ec b/src/=
openvpn/comp=2Ec</span><br><span>index b88b79f=2E=2E387a7c4 100644</span><b=
r><span>--- a/src/openvpn/comp=2Ec</span><br><span>+++ b/src/openvpn/comp=
=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br><span> #endif /* USE_COM=
P */</span><br><span> </span><br><span> bool</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-check_compression_settings_valid(struct compress_opt=
ions *info, msglvl_t msglevel)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+check_compression_settings_valid(const struct compress_options *=
info, msglvl_t msglevel)</span><br><span> {</span><br><span>     /*</span><=
br><span>      * We also allow comp-stub-v2 here as it technically allows e=
scaping of</span><br><span>diff --git a/src/openvpn/comp=2Eh b/src/openvpn/=
comp=2Eh</span><br><span>index 29a90a2=2E=2Ead80243 100644</span><br><span>=
--- a/src/openvpn/comp=2Eh</span><br><span>+++ b/src/openvpn/comp=2Eh</span=
><br><span>@@ -91,7 +91,7 @@</span><br><span>  * flags of allow-compression=
 and also the whether algorithms are compiled</span><br><span>  * in</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool ch=
eck_compression_settings_valid(struct compress_options *info, msglvl_t msgl=
evel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool check_co=
mpression_settings_valid(const struct compress_options *info, msglvl_t msgl=
evel);</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span> =
#include &quot;buffer=2Eh&quot;</span><br><span>diff --git a/src/openvpn/cr=
ypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 1703d4d=2E=2E3d3ab0=
c 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ b=
/src/openvpn/crypto=2Ec</span><br><span>@@ -1105,7 +1105,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-key_is_zero(struct key *key, const struct k=
ey_type *kt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+key_is_=
zero(const struct key *key, const struct key_type *kt)</span><br><span> {</=
span><br><span>     size_t cipher_length =3D cipher_kt_key_size(kt-&gt;ciph=
er);</span><br><span>     for (size_t i =3D 0; i &lt; cipher_length; ++i)</=
span><br><span>@@ -1123,7 +1123,7 @@</span><br><span>  * Make sure that cip=
her key is a valid key for current key_type=2E</span><br><span>  */</span><=
br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_k=
ey(struct key *key, const struct key_type *kt)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+check_key(const struct key *key, const struct ke=
y_type *kt)</span><br><span> {</span><br><span>     if (cipher_defined(kt-&=
gt;cipher))</span><br><span>     {</span><br><span>@@ -1196,7 +1196,7 @@</s=
pan><br><span> }</span><br><span> </span><br><span> void</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-test_crypto(struct crypto_options *co, s=
truct frame *frame)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_crypto(struct crypto_options *co, const struct frame *frame)</span><br=
><span> {</span><br><span>     int i, j;</span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>diff --git a/src/openvpn/crypto=2Eh b/s=
rc/openvpn/crypto=2Eh</span><br><span>index ee5b50f=2E=2Ee3c1c6a 100644</sp=
an><br><span>--- a/src/openvpn/crypto=2Eh</span><br><span>+++ b/src/openvpn=
/crypto=2Eh</span><br><span>@@ -414,7 +414,7 @@</span><br><span>  */</span>=
<br><span> int write_key_file(const int nkeys, const char *filename);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool chec=
k_key(struct key *key, const struct key_type *kt);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool check_key(const struct key *key, const =
struct key_type *kt);</span><br><span> </span><br><span> /**</span><br><spa=
n>  * Initialize a key_type structure with=2E</span><br><span>@@ -614,7 +61=
4,7 @@</span><br><span> /** Print a cipher list entry */</span><br><span> v=
oid print_cipher(const char *cipher);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void test_crypto(struct crypto_options *c=
o, struct frame *f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void test_crypto(struct crypto_options *co, const struct frame *f);</span>=
<br><span> </span><br><span> </span><br><span> /* key direction functions *=
/</span><br><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</s=
pan><br><span>index 9fc0e3b=2E=2Ef3b5d44 100644</span><br><span>--- a/src/o=
penvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@=
 -573,7 +573,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_get=
_localaddr(struct multi_context *m, struct multi_instance *mi,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dco_multi_get_localaddr(const st=
ruct multi_context *m, const struct multi_instance *mi,</span><br><span>   =
                      struct sockaddr_storage *local)</span><br><span> {</s=
pan><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -585,7 +585,7 @@</s=
pan><br><span>         return false;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_soc=
ket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;lsa-&gt;act=
ual;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t link_socket_actual *actual =3D &amp;c-&gt;c2=2Elink_socket_infos[0]-&gt;l=
sa-&gt;actual;</span><br><span> </span><br><span>     switch (actual-&gt;de=
st=2Eaddr=2Esa=2Esa_family)</span><br><span>     {</span><br><span>@@ -623,=
7 +623,7 @@</span><br><span> }</span><br><span> </span><br><span> int</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_multi_add_new_peer(stru=
ct multi_context *m, struct multi_instance *mi)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const struct multi_conte=
xt *m, struct multi_instance *mi)</span><br><span> {</span><br><span>     c=
onst struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br=
><span>@@ -677,7 +677,7 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_install=
_iroute(struct multi_context *m, struct multi_instance *mi, struct mroute_a=
ddr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_insta=
ll_iroute(struct multi_context *m, struct multi_instance *mi, const struct =
mroute_addr *addr)</span><br><span> {</span><br><span> #if defined(TARGET_L=
INUX) || defined(TARGET_FREEBSD) || defined(_WIN32)</span><br><span>     if=
 (!dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span>diff --git a/src/=
openvpn/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index 7ef75fee=2E=2Ec=
435f8c 100644</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++=
 b/src/openvpn/dco=2Eh</span><br><span>@@ -204,7 +204,7 @@</span><br><span>=
  * @param mi        the client instance</span><br><span>  * @return       =
   0 on success or a negative error code otherwise</span><br><span>  */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int dco_multi_add_new_pee=
r(struct multi_context *m, struct multi_instance *mi);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int dco_multi_add_new_peer(const struct =
multi_context *m, struct multi_instance *mi);</span><br><span> </span><br><=
span> /**</span><br><span>  * Install an iroute in DCO, which means adding =
a route to the system routing</span><br><span>@@ -215,7 +215,7 @@</span><br=
><span>  * @param addr      the route to add</span><br><span>  */</span><br=
><span> void dco_install_iroute(struct multi_context *m, struct multi_insta=
nce *mi,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
           struct mroute_addr *addr);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                        const struct mroute_addr *addr);<=
/span><br><span> </span><br><span> /**</span><br><span>  * Remove all route=
s added through the specified client</span><br><span>@@ -253,7 +253,7 @@</s=
pan><br><span>  * a 64 bit packet counter and AEAD tag at the end=2E</span>=
<br><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-dco_supports_epoch_data(struct context *c);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct=
 context *c);</span><br><span> #else  /* if defined(ENABLE_DCO) */</span><b=
r><span> </span><br><span> typedef void *dco_context_t;</span><br><span>@@ =
-350,7 +350,7 @@</span><br><span> }</span><br><span> </span><br><span> stat=
ic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_mult=
i_add_new_peer(struct multi_context *m, struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+dco_multi_add_new_peer(const=
 struct multi_context *m, struct multi_instance *mi)</span><br><span> {</sp=
an><br><span>     return 0;</span><br><span> }</span><br><span>@@ -384,7 +3=
84,7 @@</span><br><span> }</span><br><span> </span><br><span> static inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_supports_epo=
ch_data(struct context *c)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+dco_supports_epoch_data(const struct context *c)</span><br><span> {<=
/span><br><span>     return false;</span><br><span> }</span><br><span>diff =
--git a/src/openvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br=
><span>index 87eea55=2E=2E3148f10 100644</span><br><span>--- a/src/openvpn/=
dco_freebsd=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br=
><span>@@ -929,7 +929,7 @@</span><br><span> }</span><br><span> </span><br><=
span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_support=
s_epoch_data(struct context *c)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+dco_supports_epoch_data(const struct context *c)</span><br><spa=
n> {</span><br><span>     return false;</span><br><span> }</span><br><span>=
diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh</s=
pan><br><span>index fcf8aca=2E=2E1022e66 100644</span><br><span>--- a/src/o=
penvpn/dco_internal=2Eh</span><br><span>+++ b/src/openvpn/dco_internal=2Eh<=
/span><br><span>@@ -59,8 +59,9 @@</span><br><span>  * They are implemented =
by dco_linux=2Ec</span><br><span>  */</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-int dco_new_peer(dco_context_t *dco, unsi=
gned int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                 struct sock=
addr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_addr *vp=
n_ipv6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int dco_new=
_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                 struct =
sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                 const struct in_addr *vpn_ip=
v4, const struct in6_addr *vpn_ipv6);</span><br><span> </span><br><span> in=
t dco_del_peer(dco_context_t *dco, unsigned int peerid);</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_li=
nux=2Ec</span><br><span>index a397fb8=2E=2E4412ad0 100644</span><br><span>-=
-- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dco_linux=
=2Ec</span><br><span>@@ -104,7 +104,7 @@</span><br><span> }</span><br><span=
> </span><br><span> static struct nl_msg *</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-ovpn_dco_nlmsg_create(dco_context_t *dco, uint8_t cmd)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_dco_nlmsg_crea=
te(const dco_context_t *dco, uint8_t cmd)</span><br><span> {</span><br><spa=
n>     struct nl_msg *nl_msg =3D nlmsg_alloc();</span><br><span>     if (!n=
l_msg)</span><br><span>@@ -842,7 +842,7 @@</span><br><span> </span><br><spa=
n> /* libnl &lt; 3=2E11=2E0 does not implement nla_get_uint() */</span><br>=
<span> static uint64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-ovpn_nla_get_uint(struct nlattr *attr)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ovpn_nla_get_uint(const struct nlattr *attr)</span><br>=
<span> {</span><br><span>     if (nla_len(attr) =3D=3D sizeof(uint32_t))</s=
pan><br><span>     {</span><br><span>@@ -954,7 +954,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-ovpn_iface_check(dco_context_t *dco, struct nlatt=
r *attrs[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ovpn_ifa=
ce_check(const dco_context_t *dco, struct nlattr *attrs[])</span><br><span>=
 {</span><br><span>     /* we must know which interface this message is ref=
erring to in order to</span><br><span>      * avoid mixing messages for oth=
er instances</span><br><span>@@ -1381,7 +1381,7 @@</span><br><span> }</span=
><br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-dco_supports_epoch_data(struct context *c)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct co=
ntext *c)</span><br><span> {</span><br><span>     return false;</span><br><=
span> }</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/=
dco_win=2Ec</span><br><span>index 6e5e295=2E=2E12b0666 100644</span><br><sp=
an>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=
=2Ec</span><br><span>@@ -1092,7 +1092,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dco_supports_epoch_data(struct context *c)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+dco_supports_epoch_data(const struct context *c=
)</span><br><span> {</span><br><span>     OVPN_VERSION ver =3D { 0 };</span=
><br><span>     return dco_get_version(&amp;ver) &amp;&amp; ((ver=2EMajor =
=3D=3D 2 &amp;&amp; ver=2EMinor &gt;=3D 8) || (ver=2EMajor &gt; 2));</span>=
<br><span>diff --git a/src/openvpn/error=2Ec b/src/openvpn/error=2Ec</span>=
<br><span>index 26d4c7c=2E=2E32d819d 100644</span><br><span>--- a/src/openv=
pn/error=2Ec</span><br><span>+++ b/src/openvpn/error=2Ec</span><br><span>@@=
 -623,7 +623,7 @@</span><br><span>  * from the OS=2E</span><br><span>  */</=
span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x=
_check_status(ssize_t status, const char *description, struct link_socket *=
sock, struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+x_check_status(ssize_t status, const char *description, struct link_so=
cket *sock, const struct tuntap *tt)</span><br><span> {</span><br><span>   =
  const char *extended_msg =3D NULL;</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/error=2Eh b/src/openvpn/error=2Eh</span><br><span>inde=
x 9f39572=2E=2E373cbc1 100644</span><br><span>--- a/src/openvpn/error=2Eh</=
span><br><span>+++ b/src/openvpn/error=2Eh</span><br><span>@@ -304,10 +304,=
10 @@</span><br><span> void set_check_status(unsigned int info_level, unsig=
ned int verbose_level);</span><br><span> </span><br><span> void x_check_sta=
tus(ssize_t status, const char *description, struct link_socket *sock,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    struct=
 tuntap *tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              const struct tuntap *tt);</span><br><span> </span><br><span> =
static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-che=
ck_status(ssize_t status, const char *description, struct link_socket *sock=
, struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+check_status(ssize_t status, const char *description, struct link_socket *=
sock, const struct tuntap *tt)</span><br><span> {</span><br><span>     if (=
status &lt; 0 || check_debug_level(x_cs_verbose_level))</span><br><span>   =
  {</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=
=2Ec</span><br><span>index 4089401=2E=2E5e17ea1 100644</span><br><span>--- =
a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><=
br><span>@@ -1012,7 +1012,7 @@</span><br><span> }</span><br><span> </span><=
br><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
e_wait_return(struct se_set *ses, fd_set *read, fd_set *write, struct event=
_set_return *out,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+se=
_wait_return(struct se_set *ses, const fd_set *read, const fd_set *write, s=
truct event_set_return *out,</span><br><span>                int outlen)</s=
pan><br><span> {</span><br><span>     int i, j =3D 0;</span><br><span>diff =
--git a/src/openvpn/event=2Eh b/src/openvpn/event=2Eh</span><br><span>index=
 b784dfe=2E=2E0940a1d 100644</span><br><span>--- a/src/openvpn/event=2Eh</s=
pan><br><span>+++ b/src/openvpn/event=2Eh</span><br><span>@@ -204,7 +204,7 =
@@</span><br><span> #else /* ifdef _WIN32 */</span><br><span> </span><br><s=
pan> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-wait_signal(struct event_set *es, void *arg)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+wait_signal(const struct event_set *es, const vo=
id *arg)</span><br><span> {</span><br><span> }</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span>=
<br><span>index b97fb7a=2E=2E681210d 100644</span><br><span>--- a/src/openv=
pn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><spa=
n>@@ -237,7 +237,7 @@</span><br><span> }</span><br><span> </span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-parse_inc=
oming_control_channel_command(struct context *c, struct buffer *buf)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+parse_incoming_control_cha=
nnel_command(struct context *c, const struct buffer *buf)</span><br><span> =
{</span><br><span>     if (buf_string_match_head_str(buf, &quot;AUTH_FAILED=
&quot;))</span><br><span>     {</span><br><span>@@ -507,7 +507,7 @@</span><=
br><span> }</span><br><span> </span><br><span> int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-get_server_poll_remaining_time(struct event_ti=
meout *server_poll_timeout)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+get_server_poll_remaining_time(const struct event_timeout *server_p=
oll_timeout)</span><br><span> {</span><br><span>     update_time();</span><=
br><span>     int remaining =3D event_timeout_remaining(server_poll_timeout=
);</span><br><span>@@ -621,7 +621,7 @@</span><br><span>  * Buffer reallocat=
ion, for use with null encryption=2E</span><br><span>  */</span><br><span> =
static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf=
fer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, struct buff=
er *src_stub,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buffer=
_turnover(const uint8_t *orig_buf, struct buffer *dest_stub, const struct b=
uffer *src_stub,</span><br><span>                 struct buffer *storage)</=
span><br><span> {</span><br><span>     if (orig_buf =3D=3D src_stub-&gt;dat=
a &amp;&amp; src_stub-&gt;data !=3D storage-&gt;data)</span><br><span>@@ -9=
08,7 +908,7 @@</span><br><span>  */</span><br><span> </span><br><span> stat=
ic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_p=
ostprocess_incoming_link(struct context *c, struct link_socket *sock)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+socks_postprocess_incomin=
g_link(struct context *c, const struct link_socket *sock)</span><br><span> =
{</span><br><span>     if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info=2E=
proto =3D=3D PROTO_UDP)</span><br><span>     {</span><br><span>@@ -1005,7 +=
1005,7 @@</span><br><span> }</span><br><span> </span><br><span> bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-process_incoming_link_part1(=
struct context *c, struct link_socket_info *lsi, bool floated)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+process_incoming_link_part1(stru=
ct context *c, const struct link_socket_info *lsi, bool floated)</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan>     bool decrypt_status =3D false;</span><br><span>@@ -1555,7 +1555,7 =
@@</span><br><span>  * @param client    Determines whether to the send pack=
et back via tun or link</span><br><span>  */</span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-ipv6_send_icmp_unreachable(str=
uct context *c, struct buffer *buf, bool client)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ipv6_send_icmp_unreachable(struct context *c, =
const struct buffer *buf, bool client)</span><br><span> {</span><br><span> =
#define MAX_ICMPV6LEN 1280</span><br><span>     struct openvpn_icmp6hdr icm=
p6out;</span><br><span>diff --git a/src/openvpn/forward=2Eh b/src/openvpn/f=
orward=2Eh</span><br><span>index 0309725=2E=2E375635b 100644</span><br><spa=
n>--- a/src/openvpn/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=
=2Eh</span><br><span>@@ -126,7 +126,7 @@</span><br><span>  */</span><br><sp=
an> void encrypt_sign(struct context *c, bool comp_frag);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int get_server_poll_r=
emaining_time(struct event_timeout *server_poll_timeout);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+int get_server_poll_remaining_time(co=
nst struct event_timeout *server_poll_timeout);</span><br><span> </span><br=
><span> /******************************************************************=
****/</span><br><span> /**</span><br><span>@@ -177,7 +177,7 @@</span><br><s=
pan>  *</span><br><span>  * @return true if packet is authenticated, false =
otherwise=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool process_incoming_link_part1(struct context *c, struct link=
_socket_info *lsi, bool floated);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool process_incoming_link_part1(struct context *c, const str=
uct link_socket_info *lsi, bool floated);</span><br><span> </span><br><span=
> /**</span><br><span>  * Continues processing a packet read from the exter=
nal network interface=2E</span><br><span>diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec</span><br><span>index 9306a96=2E=2E3c2ebf9 100644</s=
pan><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/=
init=2Ec</span><br><span>@@ -803,7 +803,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-init_port_share(struct context *c)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+init_port_share(const struct context *c)</span=
><br><span> {</span><br><span>     if (!port_share &amp;&amp; (c-&gt;option=
s=2Eport_share_host &amp;&amp; c-&gt;options=2Eport_share_port))</span><br>=
<span>     {</span><br><span>@@ -1245,7 +1245,7 @@</span><br><span>  * prep=
ending to msg() output=2E</span><br><span>  */</span><br><span> const char =
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-format_common_name(s=
truct context *c, struct gc_arena *gc)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+format_common_name(const struct context *c, struct gc_ar=
ena *gc)</span><br><span> {</span><br><span>     struct buffer out =3D allo=
c_buf_gc(256, gc);</span><br><span>     if (c-&gt;c2=2Etls_multi)</span><br=
><span>@@ -1731,7 +1731,7 @@</span><br><span> </span><br><span> </span><br>=
<span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-can=
_preserve_tun(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+can_preserve_tun(const struct tuntap *tt)</span><br><span> {</=
span><br><span>     if (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_A=
FUNIX)</span><br><span>     {</span><br><span>@@ -1753,7 +1753,7 @@</span><=
br><span>  * @param c pointer to the connection context</span><br><span>  *=
/</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-add_wfp_block(struct context *c)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+add_wfp_block(const struct context *c)</span><br><spa=
n> {</span><br><span> #if defined(_WIN32)</span><br><span>     /* Fortify &=
#39;redirect-gateway block-local&#39; with firewall rules? */</span><br><sp=
an>@@ -1779,7 +1779,7 @@</span><br><span>  * @param adapter_index the VPN a=
dapter index</span><br><span>  */</span><br><span> static void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-del_wfp_block(struct context *c, u=
nsigned long adapter_index)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+del_wfp_block(const struct context *c, unsigned long adapter_index)=
</span><br><span> {</span><br><span> #if defined(_WIN32)</span><br><span>  =
   if (c-&gt;options=2Eblock_outside_dns || block_local_needed(c-&gt;c1=2Er=
oute_list))</span><br><span>diff --git a/src/openvpn/init=2Eh b/src/openvpn=
/init=2Eh</span><br><span>index ce8f74e=2E=2Ec486158 100644</span><br><span=
>--- a/src/openvpn/init=2Eh</span><br><span>+++ b/src/openvpn/init=2Eh</spa=
n><br><span>@@ -91,7 +91,7 @@</span><br><span> </span><br><span> uint64_t p=
ull_permission_mask(const struct context *c);</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-const char *format_common_name(st=
ruct context *c, struct gc_arena *gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+const char *format_common_name(const struct context *c, =
struct gc_arena *gc);</span><br><span> </span><br><span> void reset_coarse_=
timers(struct context *c);</span><br><span> </span><br><span>diff --git a/s=
rc/openvpn/interval=2Eh b/src/openvpn/interval=2Eh</span><br><span>index 59=
051bd=2E=2E0cfe202 100644</span><br><span>--- a/src/openvpn/interval=2Eh</s=
pan><br><span>+++ b/src/openvpn/interval=2Eh</span><br><span>@@ -89,7 +89,7=
 @@</span><br><span> }</span><br><span> </span><br><span> static inline voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-interval_schedule_wa=
keup(struct interval *top, interval_t *wakeup)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+interval_schedule_wakeup(const struct interval *=
top, interval_t *wakeup)</span><br><span> {</span><br><span>     const time=
_t local_now =3D now;</span><br><span>     interval_earliest_wakeup(wakeup,=
 top-&gt;last_test_true + top-&gt;refresh, local_now);</span><br><span>@@ -=
214,7 +214,7 @@</span><br><span>  * This function does not check if the tim=
eout is actually valid=2E</span><br><span>  */</span><br><span> static inli=
ne interval_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-event_ti=
meout_remaining(struct event_timeout *et)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+event_timeout_remaining(const struct event_timeout *e=
t)</span><br><span> {</span><br><span>     return (interval_t)((et-&gt;last=
 + et-&gt;n) - now);</span><br><span> }</span><br><span>diff --git a/src/op=
envpn/list=2Ec b/src/openvpn/list=2Ec</span><br><span>index e51dcd0=2E=2Edc=
d59d7 100644</span><br><span>--- a/src/openvpn/list=2Ec</span><br><span>+++=
 b/src/openvpn/list=2Ec</span><br><span>@@ -164,7 +164,7 @@</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-hash_remove_by_value(struct hash *hash, void *value)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+hash_remove_by_value=
(struct hash *hash, const void *value)</span><br><span> {</span><br><span> =
    struct hash_iterator hi;</span><br><span>     const struct hash_element=
 *he;</span><br><span>diff --git a/src/openvpn/list=2Eh b/src/openvpn/list=
=2Eh</span><br><span>index 55bc3c8=2E=2E23267d0 100644</span><br><span>--- =
a/src/openvpn/list=2Eh</span><br><span>+++ b/src/openvpn/list=2Eh</span><br=
><span>@@ -78,7 +78,7 @@</span><br><span> </span><br><span> bool hash_remov=
e_fast(struct hash *hash, struct hash_bucket *bucket, const void *key, uint=
64_t hv);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void hash_remove_by_value(struct hash *hash, void *value);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void hash_remove_by_value(stru=
ct hash *hash, const void *value);</span><br><span> </span><br><span> struc=
t hash_iterator</span><br><span> {</span><br><span>diff --git a/src/openvpn=
/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 0aef2d4=2E=2E1e7=
4f09 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>++=
+ b/src/openvpn/manage=2Ec</span><br><span>@@ -330,7 +330,7 @@</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-man_delete_unix_socket(struct management *m=
an)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_delete_unix_=
socket(const struct management *man)</span><br><span> {</span><br><span> #i=
f UNIX_SOCK_SUPPORT</span><br><span>     if ((man-&gt;settings=2Eflags &amp=
; (MF_UNIX_SOCK | MF_CONNECT_AS_CLIENT)) =3D=3D MF_UNIX_SOCK)</span><br><sp=
an>@@ -676,7 +676,7 @@</span><br><span>  * for the log and echo commands=2E=
</span><br><span>  */</span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-man_history(struct management *man, const char=
 *parm, const char *type, struct log_history *log,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+man_history(struct management *man, const ch=
ar *parm, const char *type, const struct log_history *log,</span><br><span>=
             bool *realtime, const unsigned int lep_flags)</span><br><span>=
 {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@=
 -852,7 +852,7 @@</span><br><span> }</span><br><span> </span><br><span> sta=
tic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-man_net(struc=
t management *man)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
an_net(const struct management *man)</span><br><span> {</span><br><span>   =
  if (man-&gt;persist=2Ecallback=2Eshow_net)</span><br><span>     {</span><=
br><span>@@ -888,7 +888,7 @@</span><br><span> #ifdef ENABLE_PKCS11</span><b=
r><span> </span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-man_pkcs11_id_count(struct management *man)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+man_pkcs11_id_count(const struct m=
anagement *man)</span><br><span> {</span><br><span>     msg(M_CLIENT, &quot=
;&gt;PKCS11ID-COUNT:%d&quot;, pkcs11_management_id_count());</span><br><spa=
n> }</span><br><span>@@ -2366,7 +2366,7 @@</span><br><span>  * the route/if=
config/open tun command=2E   See doc/android=2Etxt for details=2E</span><br=
><span>  */</span><br><span> bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-management_android_control(struct management *man, const char *=
command, const char *msg)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+management_android_control(const struct management *man, const char *=
command, const char *msg)</span><br><span> {</span><br><span>     if (!man)=
</span><br><span>     {</span><br><span>@@ -3013,7 +3013,7 @@</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-management_up_down(struct management *man, const ch=
ar *updown, const struct env_set *es)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+management_up_down(const struct management *man, const ch=
ar *updown, const struct env_set *es)</span><br><span> {</span><br><span>  =
   if (man-&gt;settings=2Eflags &amp; MF_UP_DOWN)</span><br><span>     {</s=
pan><br><span>@@ -3208,7 +3208,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ma=
nagement_auth_failure(struct management *man, const char *type, const char =
*reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_=
auth_failure(const struct management *man, const char *type, const char *re=
ason)</span><br><span> {</span><br><span>     if (reason)</span><br><span> =
    {</span><br><span>diff --git a/src/openvpn/manage=2Eh b/src/openvpn/man=
age=2Eh</span><br><span>index 1e7855d=2E=2Ef2c6916 100644</span><br><span>-=
-- a/src/openvpn/manage=2Eh</span><br><span>+++ b/src/openvpn/manage=2Eh</s=
pan><br><span>@@ -368,7 +368,7 @@</span><br><span>                         =
        const unsigned int flags, const char *static_challenge);</span><br>=
<span> </span><br><span> #ifdef TARGET_ANDROID</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-bool management_android_control(struct management =
*man, const char *command, const char *msg);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool management_android_control(const struct manag=
ement *man, const char *command, const char *msg);</span><br><span> </span>=
<br><span> #define ANDROID_KEEP_OLD_TUN      1</span><br><span> #define AND=
ROID_OPEN_BEFORE_CLOSE 2</span><br><span>@@ -382,7 +382,7 @@</span><br><spa=
n> </span><br><span> void management_event_loop_n_seconds(struct management=
 *man, int sec);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void management_up_down(struct management *man, const char *up=
down, const struct env_set *es);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void management_up_down(const struct management *man, const ch=
ar *updown, const struct env_set *es);</span><br><span> </span><br><span> v=
oid management_notify(const char *severity, const char *type,</span><br><sp=
an>                        const char *text);</span><br><span>@@ -482,7 +48=
2,7 @@</span><br><span>  * OpenVPN calls here to indicate a password failur=
e</span><br><span>  */</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void management_auth_failure(struct management *man, con=
st char *type, const char *reason);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void management_auth_failure(const struct management *man, =
const char *type, const char *reason);</span><br><span> </span><br><span> /=
*</span><br><span>  * Echo an authentication token to management interface<=
/span><br><span>diff --git a/src/openvpn/mbuf=2Ec b/src/openvpn/mbuf=2Ec</s=
pan><br><span>index 5bb397f=2E=2E163251c 100644</span><br><span>--- a/src/o=
penvpn/mbuf=2Ec</span><br><span>+++ b/src/openvpn/mbuf=2Ec</span><br><span>=
@@ -165,7 +165,7 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mbuf_dereference_i=
nstance(struct mbuf_set *ms, struct multi_instance *mi)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+mbuf_dereference_instance(struct mbuf_s=
et *ms, const struct multi_instance *mi)</span><br><span> {</span><br><span=
>     if (ms)</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/mbuf=2Eh b/src/openvpn/mbuf=2Eh</span><br><span>index cfe698c=2E=2Ee3680=
54 100644</span><br><span>--- a/src/openvpn/mbuf=2Eh</span><br><span>+++ b/=
src/openvpn/mbuf=2Eh</span><br><span>@@ -75,7 +75,7 @@</span><br><span> </s=
pan><br><span> bool mbuf_extract_item(struct mbuf_set *ms, struct mbuf_item=
 *item);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void mbuf_dereference_instance(struct mbuf_set *ms, struct multi_insta=
nce *mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void mbuf_=
dereference_instance(struct mbuf_set *ms, const struct multi_instance *mi);=
</span><br><span> </span><br><span> static inline bool</span><br><span> mbu=
f_defined(const struct mbuf_set *ms)</span><br><span>diff --git a/src/openv=
pn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index 36bbb43=2E=2E0cfa272=
d 100644</span><br><span>--- a/src/openvpn/mss=2Ec</span><br><span>+++ b/sr=
c/openvpn/mss=2Ec</span><br><span>@@ -239,8 +239,8 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static void</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-frame_calculate_fragment(struct frame *frame, struct=
 key_type *kt, const struct options *options,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                         struct link_socket_info *l=
si)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_=
fragment(struct frame *frame, const struct key_type *kt, const struct optio=
ns *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                  const struct link_socket_info *lsi)</span><br><span> {</s=
pan><br><span> #if defined(ENABLE_FRAGMENT)</span><br><span>     size_t ove=
rhead;</span><br><span>@@ -269,8 +269,8 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-frame_calculate_mssfix(struct frame *frame, struct key_type *kt=
, const struct options *options,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                       struct link_socket_info *lsi)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+frame_calculate_mssfix(struct f=
rame *frame, const struct key_type *kt, const struct options *options,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                       c=
onst struct link_socket_info *lsi)</span><br><span> {</span><br><span>     =
if (options-&gt;ce=2Emssfix_fixed)</span><br><span>     {</span><br><span>@=
@ -314,8 +314,8 @@</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-frame_calculate_dyn=
amic(struct frame *frame, struct key_type *kt, const struct options *option=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
     struct link_socket_info *lsi)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+frame_calculate_dynamic(struct frame *frame, const struct ke=
y_type *kt, const struct options *options,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        const struct link_socket_inf=
o *lsi)</span><br><span> {</span><br><span>     if (options-&gt;ce=2Efragme=
nt &gt; 0)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
mss=2Eh b/src/openvpn/mss=2Eh</span><br><span>index 1d092bb=2E=2E2eab55a 10=
0644</span><br><span>--- a/src/openvpn/mss=2Eh</span><br><span>+++ b/src/op=
envpn/mss=2Eh</span><br><span>@@ -36,8 +36,8 @@</span><br><span> void mss_f=
ixup_dowork(struct buffer *buf, uint16_t maxmss);</span><br><span> </span><=
br><span> /** Set the --mssfix option=2E */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void frame_calculate_dynamic(struct frame *frame, str=
uct key_type *kt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                         const struct options *options, struct link_socket_=
info *lsi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void fra=
me_calculate_dynamic(struct frame *frame, const struct key_type *kt,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
   const struct options *options, const struct link_socket_info *lsi);</spa=
n><br><span> </span><br><span> /**</span><br><span>  * Checks and adjusts t=
he fragment and mssfix value according to the</span><br><span>diff --git a/=
src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span>index b0125f1=
=2E=2Eb9f0bda 100644</span><br><span>--- a/src/openvpn/mtcp=2Ec</span><br><=
span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -91,7 +91,7 @@</span><br=
><span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-multi_tcp_instance_specific_init(struct multi_c=
ontext *m, struct multi_instance *mi)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+multi_tcp_instance_specific_init(const struct multi_conte=
xt *m, struct multi_instance *mi)</span><br><span> {</span><br><span>     /=
* buffer for queued TCP socket output packets */</span><br><span>     mi-&g=
t;tcp_link_out_deferred =3D mbuf_init(m-&gt;top=2Eoptions=2En_bcast_buf);</=
span><br><span>diff --git a/src/openvpn/mtcp=2Eh b/src/openvpn/mtcp=2Eh</sp=
an><br><span>index 9b7d1d2=2E=2Ebb117fa 100644</span><br><span>--- a/src/op=
envpn/mtcp=2Eh</span><br><span>+++ b/src/openvpn/mtcp=2Eh</span><br><span>@=
@ -35,7 +35,7 @@</span><br><span> </span><br><span> void multi_tcp_derefere=
nce_instance(struct multi_io *multi_io, struct multi_instance *mi);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool multi_=
tcp_instance_specific_init(struct multi_context *m, struct multi_instance *=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool multi_tcp_=
instance_specific_init(const struct multi_context *m, struct multi_instance=
 *mi);</span><br><span> </span><br><span> void multi_tcp_instance_specific_=
free(struct multi_instance *mi);</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 94e0=
3d6=2E=2Ee6fae47 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span><b=
r><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -53,8 +53,9 @@</span>=
<br><span>  * @param sock    the socket to send the reply on</span><br><spa=
n>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-send_standalone_reply(struct multi_context *m, struct buffer =
*buf, const char *prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                      const char *detail, struct link_socket *sock)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+send_standalone_reply(s=
truct multi_context *m, const struct buffer *buf,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                      const char *prefix, con=
st char *detail,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                   struct link_socket *sock)</span><br><span> {</span><br><=
span>     struct context *c =3D &amp;m-&gt;top;</span><br><span> </span><br=
><span>@@ -74,7 +75,7 @@</span><br><span> </span><br><span> static void</sp=
an><br><span> send_hmac_reset_packet(struct multi_context *m, struct tls_pr=
e_decrypt_state *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                       struct tls_auth_standalone *tas, struct session_id=
 *sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
          const struct tls_auth_standalone *tas, const struct session_id *s=
id,</span><br><span>                        bool request_resend_wkc, struct=
 link_socket *sock)</span><br><span> {</span><br><span>     reset_packet_id=
_send(&amp;state-&gt;tls_wrap_tmp=2Eopt=2Epacket_id=2Esend);</span><br><spa=
n>@@ -116,11 +117,11 @@</span><br><span> </span><br><span>     enum first_p=
acket_verdict verdict;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=
=2Etls_auth_standalone;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct tls_auth_standalone *tas =3D m-&gt;top=2Ec2=2Etls_auth=
_standalone;</span><br><span> </span><br><span>     verdict =3D tls_pre_dec=
rypt_lite(tas, state, &amp;m-&gt;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   uint8_t *hmac_key =3D m-&gt;top=2Ec2=2Esession_id_key;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *hmac_key =3D m-&gt=
;top=2Ec2=2Esession_id_key;</span><br><span>     const struct openvpn_socka=
ddr *from =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span>     int h=
andwindow =3D m-&gt;top=2Eoptions=2Ehandshake_window;</span><br><span> </sp=
an><br><span>@@ -239,7 +240,7 @@</span><br><span> static struct multi_insta=
nce *</span><br><span> handle_connection_attempt(struct multi_context *m,</=
span><br><span>                           struct link_socket *sock,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                          str=
uct mroute_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                          const struct mroute_addr *real)</span><br><spa=
n> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>=
 </span><br><span>@@ -313,7 +314,7 @@</span><br><span>  * @return      inst=
ance matching the address, NULL otherwise</span><br><span>  */</span><br><s=
pan> static struct multi_instance *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-multi_get_instance_udp_real(struct multi_context *m, struct m=
route_addr *real)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mu=
lti_get_instance_udp_real(struct multi_context *m, const struct mroute_addr=
 *real)</span><br><span> {</span><br><span>     struct hash *hash =3D m-&gt=
;hash;</span><br><span>     const uint64_t hv =3D hash_value(hash, real);</=
span><br><span>@@ -346,7 +347,9 @@</span><br><span>  * maintaining real add=
ress hash table atomicity=2E</span><br><span>  */</span><br><span> struct m=
ulti_instance *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_=
get_instance_udp_data(struct multi_context *m, bool *floated, struct mroute=
_addr *real, struct link_socket *sock)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+multi_get_instance_udp_data(struct multi_context *m, boo=
l *floated,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                    const struct mroute_addr *real,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            const struct =
link_socket *sock)</span><br><span> {</span><br><span>     struct multi_ins=
tance *mi =3D NULL;</span><br><span> </span><br><span>diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 1cf2a21=2E=2E8f=
ba67a 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>++=
+ b/src/openvpn/multi=2Ec</span><br><span>@@ -57,7 +57,7 @@</span><br><span=
> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span> static c=
onst char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-id(struct =
multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
id(const struct multi_instance *mi)</span><br><span> {</span><br><span>    =
 if (mi)</span><br><span>     {</span><br><span>@@ -1319,7 +1319,7 @@</span=
><br><span>  * same common name=2E</span><br><span>  */</span><br><span> st=
atic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_delete=
_dup(struct multi_context *m, struct multi_instance *new_mi)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+multi_delete_dup(struct multi_cont=
ext *m, const struct multi_instance *new_mi)</span><br><span> {</span><br><=
span>     if (new_mi)</span><br><span>     {</span><br><span>@@ -2264,7 +22=
64,7 @@</span><br><span> }</span><br><span> </span><br><span> static bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_client_setup_dco_=
initial(struct multi_context *m, struct multi_instance *mi,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+multi_client_setup_dco_initial(cons=
t struct multi_context *m, struct multi_instance *mi,</span><br><span>     =
                           struct gc_arena *gc)</span><br><span> {</span><b=
r><span>     if (!dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><sp=
an>@@ -3083,7 +3083,8 @@</span><br><span>  * positive=2E</span><br><span>  =
*/</span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-multi_check_dest_addr_allowed(struct multi_context *m, struct mul=
ti_instance *mi, struct mroute_addr *real)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+multi_check_dest_addr_allowed(struct multi_context *=
m, struct multi_instance *mi,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                              const struct mroute_addr *real)</sp=
an><br><span> {</span><br><span>     struct hash *hash =3D m-&gt;hash;</spa=
n><br><span>     const uint64_t hv =3D hash_value(hash, real);</span><br><s=
pan>@@ -3242,7 +3243,7 @@</span><br><span> </span><br><span> #if defined(EN=
ABLE_DCO)</span><br><span> static void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-process_incoming_del_peer(struct multi_context *m, struct =
multi_instance *mi, dco_context_t *dco)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+process_incoming_del_peer(struct multi_context *m, stru=
ct multi_instance *mi, const dco_context_t *dco)</span><br><span> {</span><=
br><span>     const char *reason =3D &quot;ovpn-dco: unknown reason&quot;;<=
/span><br><span>     switch (dco-&gt;dco_del_peer_reason)</span><br><span>@=
@ -4295,7 +4296,7 @@</span><br><span> </span><br><span> /* Searches for the=
 address and deletes it if it is owned by the multi_instance */</span><br><=
span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mult=
i_unlearn_addr(struct multi_context *m, struct multi_instance *mi, const st=
ruct mroute_addr *addr)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+multi_unlearn_addr(struct multi_context *m, const struct multi_instance=
 *mi, const struct mroute_addr *addr)</span><br><span> {</span><br><span>  =
   struct hash_element *he;</span><br><span>     const uint64_t hv =3D hash=
_value(m-&gt;vhash, addr);</span><br><span>@@ -4330,7 +4331,7 @@</span><br>=
<span>  * @param a     The new IPv4 address in network byte order</span><br=
><span>  */</span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-multi_unlearn_in_addr_t(struct multi_context *m, struct =
multi_instance *mi, in_addr_t a)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+multi_unlearn_in_addr_t(struct multi_context *m, const struct =
multi_instance *mi, in_addr_t a)</span><br><span> {</span><br><span>     st=
ruct mroute_addr addr;</span><br><span>     CLEAR(addr);</span><br><span>@@=
 -4348,7 +4349,7 @@</span><br><span>  * @param a6    The new IPv6 address</=
span><br><span>  */</span><br><span> static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-multi_unlearn_in6_addr(struct multi_context *m, =
struct multi_instance *mi, struct in6_addr a6)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+multi_unlearn_in6_addr(struct multi_context *m, =
const struct multi_instance *mi, struct in6_addr a6)</span><br><span> {</sp=
an><br><span>     struct mroute_addr addr;</span><br><span>     CLEAR(addr)=
;</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2E=
h</span><br><span>index 7115b34=2E=2E1e01a581 100644</span><br><span>--- a/=
src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br=
><span>@@ -515,7 +515,7 @@</span><br><span>  */</span><br><span> </span><br=
><span> static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-set_prefix(struct multi_instance *mi)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+set_prefix(const struct multi_instance *mi)</span><b=
r><span> {</span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span> =
    if (mi-&gt;msg_prefix[0])</span><br><span>diff --git a/src/openvpn/mult=
i_io=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index 348e424=2E=2Ebb5d=
de58 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>=
+++ b/src/openvpn/multi_io=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><b=
r><span>  * a point-to-multipoint tunnel=2E</span><br><span>  */</span><br>=
<span> static unsigned int</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-p2mp_iow_flags(const struct multi_context *m, struct link_socket *sock=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_flags(con=
st struct multi_context *m, const struct link_socket *sock)</span><br><span=
> {</span><br><span>     unsigned int flags =3D IOW_WAIT_SIGNAL;</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/networking=2Eh b/src/openv=
pn/networking=2Eh</span><br><span>index bce0c19=2E=2E25233c8 100644</span><=
br><span>--- a/src/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn=
/networking=2Eh</span><br><span>@@ -44,7 +44,7 @@</span><br><span>  */</spa=
n><br><span> #if !defined(ENABLE_IPROUTE)</span><br><span> static inline in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(struct =
context *c, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ct=
x)</span><br><span> {</span><br><span>     (void)c;</span><br><span>     (v=
oid)ctx;</span><br><span>@@ -75,7 +75,7 @@</span><br><span>  *</span><br><s=
pan>  * @return          0 on success, a negative error code otherwise</spa=
n><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int n=
et_ctx_init(struct context *c, openvpn_net_ctx_t *ctx);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+int net_ctx_init(const struct context *=
c, openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span> /**</span><b=
r><span>  * Release resources allocated by the internal garbage collector</=
span><br><span>@@ -102,7 +102,7 @@</span><br><span>  * @return          0 o=
n success, negative error code on error</span><br><span>  */</span><br><spa=
n> int net_iface_new(openvpn_net_ctx_t *ctx, const openvpn_net_iface_t *ifa=
ce, const char *type,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                  void *arg);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                  const void *arg);</span><br><span> </span><br><=
span> /**</span><br><span>  * Retrieve the interface type</span><br><span>d=
iff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking_ip=
route2=2Ec</span><br><span>index a1f3525=2E=2Ef091fb3 100644</span><br><spa=
n>--- a/src/openvpn/networking_iproute2=2Ec</span><br><span>+++ b/src/openv=
pn/networking_iproute2=2Ec</span><br><span>@@ -36,7 +36,7 @@</span><br><spa=
n> #include &lt;netinet/in=2Eh&gt;</span><br><span> </span><br><span> int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_ctx_init(struct con=
text *c, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+net_ctx_init(const struct context *c, openvpn_net_ctx_t *ctx)<=
/span><br><span> {</span><br><span>     ctx-&gt;es =3D NULL;</span><br><spa=
n>     if (c)</span><br><span>@@ -61,7 +61,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const cha=
r *type, void *arg)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
net_iface_new(openvpn_net_ctx_t *ctx, const char *iface, const char *type, =
const void *arg)</span><br><span> {</span><br><span>     struct argv argv =
=3D argv_new();</span><br><span> </span><br><span>diff --git a/src/openvpn/=
networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>ind=
ex 83915db=2E=2E49de664 100644</span><br><span>--- a/src/openvpn/networking=
_sitnl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br=
><span>@@ -1007,7 +1007,7 @@</span><br><span> }</span><br><span> </span><br=
><span> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sit=
nl_addr_del(sa_family_t af_family, const char *iface, inet_address_t *addr,=
 int prefixlen)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitn=
l_addr_del(sa_family_t af_family, const char *iface, const inet_address_t *=
addr, int prefixlen)</span><br><span> {</span><br><span>     int ifindex;</=
span><br><span> </span><br><span>@@ -1250,8 +1250,8 @@</span><br><span> }</=
span><br><span> </span><br><span> static int</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-sitnl_route_del(const char *iface, sa_family_t af_fa=
mily, inet_address_t *dst, int prefixlen,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                inet_address_t *gw, uint32_t table, int=
 metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sitnl_route=
_del(const char *iface, sa_family_t af_family, const inet_address_t *dst, i=
nt prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          const inet_address_t *gw, uint32_t table, int metric)</span><br><=
span> {</span><br><span>     int ifindex =3D 0;</span><br><span> </span><br=
><span>@@ -1328,7 +1328,7 @@</span><br><span> </span><br><span> </span><br>=
<span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-net_iface_n=
ew(openvpn_net_ctx_t *ctx, const char *iface, const char *type, void *arg)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+net_iface_new(openvp=
n_net_ctx_t *ctx, const char *iface, const char *type, const void *arg)</sp=
an><br><span> {</span><br><span>     struct sitnl_link_req req =3D {};</spa=
n><br><span>     int ret =3D -1;</span><br><span>diff --git a/src/openvpn/o=
cc=2Eh b/src/openvpn/occ=2Eh</span><br><span>index bda4f18=2E=2E49def4d 100=
644</span><br><span>--- a/src/openvpn/occ=2Eh</span><br><span>+++ b/src/ope=
nvpn/occ=2Eh</span><br><span>@@ -156,7 +156,7 @@</span><br><span>  * via co=
ntrol channel=2E</span><br><span>  * @return control channel exit message s=
hould be used */</span><br><span> static inline bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cc_exit_notify_enabled(struct context *c)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+cc_exit_notify_enable=
d(const struct context *c)</span><br><span> {</span><br><span>     /* Check=
 if we have TLS active at all */</span><br><span>     if (!c-&gt;c2=2Etls_m=
ulti)</span><br><span>diff --git a/src/openvpn/openssl_compat=2Eh b/src/ope=
nvpn/openssl_compat=2Eh</span><br><span>index 098bdd5=2E=2E1a934db 100644</=
span><br><span>--- a/src/openvpn/openssl_compat=2Eh</span><br><span>+++ b/s=
rc/openvpn/openssl_compat=2Eh</span><br><span>@@ -127,7 +127,7 @@</span><br=
><span> /* Mimics the functions but only when the default context without</=
span><br><span>  * options is chosen */</span><br><span> static inline cons=
t EVP_CIPHER *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-EVP_CIP=
HER_fetch(void *ctx, const char *algorithm, const char *properties)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+EVP_CIPHER_fetch(const void=
 *ctx, const char *algorithm, const char *properties)</span><br><span> {</s=
pan><br><span>     ASSERT(!ctx);</span><br><span>     ASSERT(!properties);<=
/span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span> </s=
pan><br><span> static inline const EVP_MD *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-EVP_MD_fetch(void *ctx, const char *algorithm, const =
char *properties)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+EV=
P_MD_fetch(const void *ctx, const char *algorithm, const char *properties)<=
/span><br><span> {</span><br><span>     ASSERT(!ctx);</span><br><span>     =
ASSERT(!properties);</span><br><span>diff --git a/src/openvpn/options=2Ec b=
/src/openvpn/options=2Ec</span><br><span>index 5d10390=2E=2E9d32570 100644<=
/span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/ope=
nvpn/options=2Ec</span><br><span>@@ -2429,7 +2429,7 @@</span><br><span> }</=
span><br><span> </span><br><span> static void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-options_postprocess_mutate_le(struct connection_ent=
ry *ce, struct local_entry *le, int mode)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+options_postprocess_mutate_le(const struct connection=
_entry *ce, struct local_entry *le, int mode)</span><br><span> {</span><br>=
<span>     /* use the global port if none is specified */</span><br><span> =
    if (!le-&gt;port)</span><br><span>@@ -3585,7 +3585,7 @@</span><br><span=
> static bool</span><br><span> verify_permission(const char *name, const ch=
ar *file, int line, const uint64_t type,</span><br><span>                  =
 const uint64_t allowed, uint64_t *found, const msglvl_t msglevel,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                  struct optio=
ns *options, bool is_inline)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                  const struct options *options, bool is_inline)</=
span><br><span> {</span><br><span>     if (!(type &amp; allowed))</span><br=
><span>     {</span><br><span>@@ -3661,7 +3661,7 @@</span><br><span> }</spa=
n><br><span> </span><br><span> static inline msglvl_t</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-msglevel_forward_compatible(struct options =
*options, const msglvl_t msglevel)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+msglevel_forward_compatible(const struct options *options, c=
onst msglvl_t msglevel)</span><br><span> {</span><br><span>     return opti=
ons-&gt;forward_compatible ? M_WARN : msglevel;</span><br><span> }</span><b=
r><span>@@ -4150,7 +4150,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
how_compression_warning(struct compress_options *info)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+show_compression_warning(const struct co=
mpress_options *info)</span><br><span> {</span><br><span>     if (comp_non_=
stub_enabled(info))</span><br><span>     {</span><br><span>diff --git a/src=
/openvpn/options_parse=2Ec b/src/openvpn/options_parse=2Ec</span><br><span>=
index 12934ab=2E=2E79b8098 100644</span><br><span>--- a/src/openvpn/options=
_parse=2Ec</span><br><span>+++ b/src/openvpn/options_parse=2Ec</span><br><s=
pan>@@ -258,7 +258,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_=
inline_file(struct in_src *is, const char *close_tag, int *num_lines, struc=
t gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read=
_inline_file(const struct in_src *is, const char *close_tag, int *num_lines=
, struct gc_arena *gc)</span><br><span> {</span><br><span>     char line[OP=
TION_LINE_SIZE];</span><br><span>     struct buffer buf =3D alloc_buf(8 * O=
PTION_LINE_SIZE);</span><br><span>@@ -302,7 +302,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> static int</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-check_inline_file(struct in_src *is, char *p[], struc=
t gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+chec=
k_inline_file(const struct in_src *is, char *p[], struct gc_arena *gc)</spa=
n><br><span> {</span><br><span>     int num_inline_lines =3D 0;</span><br><=
span> </span><br><span>diff --git a/src/openvpn/otime=2Ec b/src/openvpn/oti=
me=2Ec</span><br><span>index 1608458=2E=2E5d3633c 100644</span><br><span>--=
- a/src/openvpn/otime=2Ec</span><br><span>+++ b/src/openvpn/otime=2Ec</span=
><br><span>@@ -66,7 +66,7 @@</span><br><span> }</span><br><span> </span><br=
><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-update_no=
w_usec(struct timeval *tv)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+update_now_usec(const struct timeval *tv)</span><br><span> {</span><=
br><span>     const time_t last =3D now;</span><br><span>     update_now(tv=
-&gt;tv_sec);</span><br><span>diff --git a/src/openvpn/otime=2Eh b/src/open=
vpn/otime=2Eh</span><br><span>index d14f01e=2E=2E74d21ff 100644</span><br><=
span>--- a/src/openvpn/otime=2Eh</span><br><span>+++ b/src/openvpn/otime=2E=
h</span><br><span>@@ -65,7 +65,7 @@</span><br><span> void update_now(const =
time_t system_time);</span><br><span> </span><br><span> extern time_t now_u=
sec;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void update_now_u=
sec(struct timeval *tv);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void update_now_usec(const struct timeval *tv);</span><br><span> </spa=
n><br><span> static inline int</span><br><span> openvpn_gettimeofday(struct=
 timeval *tv, void *tz)</span><br><span>diff --git a/src/openvpn/proto=2Eh =
b/src/openvpn/proto=2Eh</span><br><span>index 9bb0866=2E=2E1665751 100644</=
span><br><span>--- a/src/openvpn/proto=2Eh</span><br><span>+++ b/src/openvp=
n/proto=2Eh</span><br><span>@@ -248,7 +248,7 @@</span><br><span>  * and off=
set of IP header (via parameter)=2E</span><br><span>  */</span><br><span> s=
tatic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-get_t=
un_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+get_tun_ip_ver(int tunnel_ty=
pe, const struct buffer *buf, int *ip_hdr_offset)</span><br><span> {</span>=
<br><span>     int ip_ver =3D -1;</span><br><span> </span><br><span>diff --=
git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index 7=
4a6cf9=2E=2Ec3ad7de 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</spa=
n><br><span>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -527,8 +527,9 @@=
</span><br><span> }</span><br><span> </span><br><span> static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-add_proxy_headers(struct http_=
proxy_info *p, socket_descriptor_t sd, /* already open to proxy */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                  const char *=
host                                   /* openvpn server remote */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+add_proxy_headers(const stru=
ct http_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                  socket_descriptor_t sd, /* already open to proxy */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                  cons=
t char *host        /* openvpn server remote */</span><br><span> )</span><b=
r><span> {</span><br><span>     char buf[512];</span><br><span>@@ -597,8 +5=
98,8 @@</span><br><span>                               socket_descriptor_t =
sd, /* already open to proxy */</span><br><span>                           =
    const char *host,       /* openvpn server remote */</span><br><span>   =
                            const char *port,       /* openvpn server port =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
           struct event_timeout *server_poll_timeout, struct buffer *lookah=
ead,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
             struct signal_info *sig_info)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                              const struct event_tim=
eout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                              struct buffer *lookahead, struct signa=
l_info *sig_info)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span>     char buf[512];</span><br><span>diff --=
git a/src/openvpn/proxy=2Eh b/src/openvpn/proxy=2Eh</span><br><span>index e=
662e7d=2E=2Ea2f4e47 100644</span><br><span>--- a/src/openvpn/proxy=2Eh</spa=
n><br><span>+++ b/src/openvpn/proxy=2Eh</span><br><span>@@ -89,7 +89,7 @@</=
span><br><span>                                    socket_descriptor_t sd, =
/* already open to proxy */</span><br><span>                               =
     const char *host,       /* openvpn server remote */</span><br><span>  =
                                  const char *port,       /* openvpn server=
 port */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                      struct event_timeout *server_poll_timeout,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
     const struct event_timeout *server_poll_timeout,</span><br><span>     =
                               struct buffer *lookahead, struct signal_info=
 *sig_info);</span><br><span> </span><br><span> uint8_t *make_base64_string=
2(const uint8_t *str, int str_len, struct gc_arena *gc);</span><br><span>di=
ff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 08=
c2673=2E=2E2679c4d5 100644</span><br><span>--- a/src/openvpn/ps=2Ec</span><=
br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -334,7 +334,7 @@</span=
><br><span>  * the proxy can determine true client origin=2E</span><br><spa=
n>  */</span><br><span> static void</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-journal_add(const char *journal_dir, struct proxy_connection =
*pc, struct proxy_connection *cp)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+journal_add(const char *journal_dir, const struct proxy_conne=
ction *pc, struct proxy_connection *cp)</span><br><span> {</span><br><span>=
     struct openvpn_sockaddr from, to;</span><br><span> </span><br><span>@@=
 -412,7 +412,7 @@</span><br><span> static bool</span><br><span> proxy_entry=
_new(struct proxy_connection **list, struct event_set *es,</span><br><span>=
                 const struct openvpn_sockaddr server_addr, const socket_de=
scriptor_t sd_client,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                struct buffer *initial_data, const char *journal_dir)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                const str=
uct buffer *initial_data, const char *journal_dir)</span><br><span> {</span=
><br><span>     socket_descriptor_t sd_server;</span><br><span>     int sta=
tus;</span><br><span>@@ -1015,7 +1015,7 @@</span><br><span>  * call=2E</spa=
n><br><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-port_share_redirect(struct port_share *ps, const struct bu=
ffer *head, socket_descriptor_t sd)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+port_share_redirect(const struct port_share *ps, const stru=
ct buffer *head, socket_descriptor_t sd)</span><br><span> {</span><br><span=
>     if (ps)</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/ps=2Eh b/src/openvpn/ps=2Eh</span><br><span>index 557ecf5=2E=2E918ceb6 1=
00644</span><br><span>--- a/src/openvpn/ps=2Eh</span><br><span>+++ b/src/op=
envpn/ps=2Eh</span><br><span>@@ -49,7 +49,7 @@</span><br><span> </span><br>=
<span> bool is_openvpn_protocol(const struct buffer *buf);</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void port_share_redi=
rect(struct port_share *ps, const struct buffer *head, socket_descriptor_t =
sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void port_share=
_redirect(const struct port_share *ps, const struct buffer *head, socket_de=
scriptor_t sd);</span><br><span> </span><br><span> #endif /* if PORT_SHARE =
*/</span><br><span> #endif /* ifndef PS_H */</span><br><span>diff --git a/s=
rc/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 0e281d2=2E=
=2E8dfe0d5 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><spa=
n>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -430,7 +430,7 @@</span><br>=
<span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-send_auth_pending_messages(struct tls_multi *tls=
_multi, struct tls_session *session,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+send_auth_pending_messages(const struct tls_multi *tls_mul=
ti, struct tls_session *session,</span><br><span>                          =
  const char *extra, unsigned int timeout)</span><br><span> {</span><br><sp=
an>     struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><b=
r><span>diff --git a/src/openvpn/push=2Eh b/src/openvpn/push=2Eh</span><br>=
<span>index dff945f=2E=2E39302f6 100644</span><br><span>--- a/src/openvpn/p=
ush=2Eh</span><br><span>+++ b/src/openvpn/push=2Eh</span><br><span>@@ -117,=
7 +117,7 @@</span><br><span>  * doc/management-notes=2Etxt under client-pen=
ding-auth for</span><br><span>  * more details on message format</span><br>=
<span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool send_a=
uth_pending_messages(struct tls_multi *tls_multi, struct tls_session *sessi=
on,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool send_auth_p=
ending_messages(const struct tls_multi *tls_multi, struct tls_session *sess=
ion,</span><br><span>                                 const char *extra, un=
signed int timeout);</span><br><span> </span><br><span> void send_restart(s=
truct context *c, const char *kill_msg);</span><br><span>diff --git a/src/o=
penvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><span>index 0213=
041=2E=2E7fa5987 100644</span><br><span>--- a/src/openvpn/push_util=2Ec</sp=
an><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@@ -222,7 +222=
,7 @@</span><br><span> </span><br><span> /* Return true if the client suppo=
rts push-update */</span><br><span> static bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-support_push_update(struct multi_instance *mi)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+support_push_update(co=
nst struct multi_instance *mi)</span><br><span> {</span><br><span>     ASSE=
RT(mi-&gt;context=2Ec2=2Etls_multi);</span><br><span>     const unsigned in=
t iv_proto_peer =3D extract_iv_proto(mi-&gt;context=2Ec2=2Etls_multi-&gt;pe=
er_info);</span><br><span>diff --git a/src/openvpn/reliable=2Ec b/src/openv=
pn/reliable=2Ec</span><br><span>index b5315ff=2E=2E6f3d1c8 100644</span><br=
><span>--- a/src/openvpn/reliable=2Ec</span><br><span>+++ b/src/openvpn/rel=
iable=2Ec</span><br><span>@@ -92,7 +92,7 @@</span><br><span> </span><br><sp=
an> /* check if a particular packet_id is present in ack */</span><br><span=
> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-r=
eliable_ack_packet_id_present(struct reliable_ack *ack, packet_id_type pid)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ack_packet=
_id_present(const struct reliable_ack *ack, packet_id_type pid)</span><br><=
span> {</span><br><span>     for (int i =3D 0; i &lt; ack-&gt;len; ++i)</sp=
an><br><span>     {</span><br><span>@@ -391,7 +391,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-validate_packet_id_window(struct reliable *rel, packet_id_=
type pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+validate_p=
acket_id_window(const struct reliable *rel, packet_id_type pid)</span><br><=
span> {</span><br><span>     return reliable_pid_min(pid, rel-&gt;packet_id=
)</span><br><span>            &amp;&amp; reliable_pid_min(subtract_pid(rel-=
&gt;packet_id, RELIABLE_CAPACITY), pid);</span><br><span>@@ -768,7 +768,7 @=
@</span><br><span>  */</span><br><span> </span><br><span> void</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_active_incoming(stru=
ct reliable *rel, struct buffer *buf, packet_id_type pid,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+reliable_mark_active_incoming(struct =
reliable *rel, const struct buffer *buf, packet_id_type pid,</span><br><spa=
n>                               int opcode)</span><br><span> {</span><br><=
span>     for (int i =3D 0; i &lt; rel-&gt;size; ++i)</span><br><span>@@ -8=
28,7 +828,7 @@</span><br><span> </span><br><span> /* delete a buffer previo=
usly activated by reliable_mark_active() */</span><br><span> void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-reliable_mark_deleted(struct re=
liable *rel, struct buffer *buf)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+reliable_mark_deleted(struct reliable *rel, const struct buffe=
r *buf)</span><br><span> {</span><br><span>     for (int i =3D 0; i &lt; re=
l-&gt;size; ++i)</span><br><span>     {</span><br><span>diff --git a/src/op=
envpn/reliable=2Eh b/src/openvpn/reliable=2Eh</span><br><span>index a85f2e9=
=2E=2E12d5367 100644</span><br><span>--- a/src/openvpn/reliable=2Eh</span><=
br><span>+++ b/src/openvpn/reliable=2Eh</span><br><span>@@ -184,7 +184,7 @@=
</span><br><span>  * @li False, if there are packet IDs to be acknowledged=
=2E</span><br><span>  */</span><br><span> static inline bool</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-reliable_ack_empty(struct reliable_a=
ck *ack)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reliable_ac=
k_empty(const struct reliable_ack *ack)</span><br><span> {</span><br><span>=
     return !ack-&gt;len;</span><br><span> }</span><br><span>@@ -198,7 +198=
,7 @@</span><br><span>  * included in the valid range=2E</span><br><span>  =
*/</span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-validate_packet_id_window(struct reliable *rel, packet_id_type pid);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+validate_packet_id_windo=
w(const struct reliable *rel, packet_id_type pid);</span><br><span> </span>=
<br><span> /**</span><br><span>  * Returns the number of packets that need =
to be acked=2E</span><br><span>@@ -208,7 +208,7 @@</span><br><span>  * @ret=
urns the number of outstanding acks</span><br><span>  */</span><br><span> s=
tatic inline int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-relia=
ble_ack_outstanding(struct reliable_ack *ack)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+reliable_ack_outstanding(const struct reliable_ac=
k *ack)</span><br><span> {</span><br><span>     return ack-&gt;len;</span><=
br><span> }</span><br><span>@@ -358,7 +358,7 @@</span><br><span>  * @param =
pid The packet&#39;s packet ID=2E</span><br><span>  * @param opcode The pac=
ket&#39;s opcode=2E</span><br><span>  */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-void reliable_mark_active_incoming(struct reliable *rel,=
 struct buffer *buf, packet_id_type pid,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void reliable_mark_active_incoming(struct reliable *re=
l, const struct buffer *buf, packet_id_type pid,</span><br><span>          =
                          int opcode);</span><br><span> </span><br><span> /=
**</span><br><span>@@ -411,7 +411,7 @@</span><br><span>  * @param rel The r=
eliable structure associated with the given buffer=2E</span><br><span>  * @=
param buf The buffer of the reliable entry which is to be removed=2E</span>=
<br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void re=
liable_mark_deleted(struct reliable *rel, struct buffer *buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void reliable_mark_deleted(struc=
t reliable *rel, const struct buffer *buf);</span><br><span> </span><br><sp=
an> /** @} name Functions for extracting incoming packets */</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index 33b2387=2E=2E4830a5b 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -898,8 +898,9 @@</span><br><span> }</span><br><span> </span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ad=
d_bypass_routes(struct route_bypass *rb, in_addr_t gateway, const struct tu=
ntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
      unsigned int flags, const struct route_gateway_info *rgi,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+add_bypass_routes(const struct =
route_bypass *rb, in_addr_t gateway,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                  const struct tuntap *tt, unsigned int fl=
ags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
   const struct route_gateway_info *rgi,</span><br><span>                  =
 const struct env_set *es, openvpn_net_ctx_t *ctx)</span><br><span> {</span=
><br><span>     int ret =3D true;</span><br><span>@@ -916,8 +917,9 @@</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-del_bypass_routes(struct route_bypas=
s *rb, in_addr_t gateway, const struct tuntap *tt,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                  unsigned int flags, const st=
ruct route_gateway_info *rgi,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+del_bypass_routes(const struct route_bypass *rb, in_addr_t gatewa=
y,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
 const struct tuntap *tt, unsigned int flags,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                  const struct route_gateway_info=
 *rgi,</span><br><span>                   const struct env_set *es, openvpn=
_net_ctx_t *ctx)</span><br><span> {</span><br><span>     int i;</span><br><=
span>@@ -3939,7 +3941,8 @@</span><br><span> #else  /* if defined(_WIN32) */=
</span><br><span> </span><br><span> static void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-get_bypass_addresses(struct route_bypass *rb, con=
st unsigned int flags) /* PLATFORM-SPECIFIC */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+// cppcheck-suppress constParameterPointer ; stu=
b</span><br><span style=3D"color: hsl(120, 100%, 40%);">+get_bypass_address=
es(struct route_bypass *rb, const unsigned int flags)</span><br><span> {</s=
pan><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn=
/schedule=2Ec b/src/openvpn/schedule=2Ec</span><br><span>index 6c60dc2=2E=
=2Eff243dc 100644</span><br><span>--- a/src/openvpn/schedule=2Ec</span><br>=
<span>+++ b/src/openvpn/schedule=2Ec</span><br><span>@@ -389,4 +389,4 @@</s=
pan><br><span> {</span><br><span>     s-&gt;earliest_wakeup =3D NULL; /* in=
validate cache */</span><br><span>     schedule_remove_node(s, e);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>\ No newline=
 at end of file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec<=
/span><br><span>index 33def4e=2E=2Edf8e400 100644</span><br><span>--- a/src=
/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br>=
<span>@@ -620,7 +620,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bind_=
local(struct link_socket *sock)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bind_local(const struct link_socket *sock)</span><br><span> {</=
span><br><span>     /* bind to local address/port */</span><br><span>     i=
f (sock-&gt;bind_local)</span><br><span>@@ -916,8 +916,8 @@</span><br><span=
> }</span><br><span> </span><br><span> void</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-socket_bind(socket_descriptor_t sd, struct addrinfo *=
local, int ai_family, const char *prefix,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            bool ipv6only)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+socket_bind(socket_descriptor_t sd, const struct=
 addrinfo *local, int ai_family,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            const char *prefix, bool ipv6only)</span><br><span=
> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> =
</span><br><span>@@ -1125,8 +1125,8 @@</span><br><span>  * such as TCP=2E</=
span><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-static void stream_buf_init(struct stream_buf *sb, struct b=
uffer *buf, const unsigned int sockflags,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                            const int proto);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void stream_buf_init(s=
truct stream_buf *sb, const struct buffer *buf,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                            const unsigned int =
sockflags, const int proto);</span><br><span> </span><br><span> static void=
 stream_buf_close(struct stream_buf *sb);</span><br><span> </span><br><span=
>@@ -1479,7 +1479,7 @@</span><br><span> }</span><br><span> </span><br><span=
> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-phase2_s=
et_socket_flags(struct link_socket *sock)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+phase2_set_socket_flags(const struct link_socket *soc=
k)</span><br><span> {</span><br><span>     /* TCP_NODELAY is enabled by def=
ault on every TCP socket; dco-win is</span><br><span>      * skipped as it =
manages its own socket */</span><br><span>@@ -2075,7 +2075,7 @@</span><br><=
span> }</span><br><span> </span><br><span> static void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-stream_buf_init(struct stream_buf *sb, str=
uct buffer *buf, const unsigned int sockflags,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+stream_buf_init(struct stream_buf *sb, const str=
uct buffer *buf, const unsigned int sockflags,</span><br><span>            =
     const int proto)</span><br><span> {</span><br><span>     sb-&gt;buf_in=
it =3D *buf;</span><br><span>@@ -2341,7 +2341,7 @@</span><br><span> #endif<=
/span><br><span> </span><br><span> static ssize_t</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-link_socket_read_udp_posix_recvmsg(struct link_=
socket *sock, struct buffer *buf,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+link_socket_read_udp_posix_recvmsg(const struct link_socket *=
sock, struct buffer *buf,</span><br><span>                                 =
   struct link_socket_actual *from, socklen_t *fromlen)</span><br><span> {<=
/span><br><span>     struct iovec iov;</span><br><span>@@ -2413,7 +2413,7 @=
@</span><br><span> #endif /* if ENABLE_IP_PKTINFO */</span><br><span> </spa=
n><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-l=
ink_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_read_udp_po=
six(const struct link_socket *sock, struct buffer *buf,</span><br><span>   =
                         struct link_socket_actual *from)</span><br><span> =
{</span><br><span>     ssize_t recvlen;</span><br><span>@@ -2476,7 +2476,7 =
@@</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span> </span><br><span=
> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_=
write_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_write_udp_pos=
ix_sendmsg(const struct link_socket *sock, const struct buffer *buf,</span>=
<br><span>                                     struct link_socket_actual *t=
o)</span><br><span> {</span><br><span>     struct iovec iov;</span><br><spa=
n>@@ -2672,7 +2672,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket_send_que=
ue(struct link_socket *sock, struct buffer *buf, const struct link_socket_a=
ctual *to)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_se=
nd_queue(struct link_socket *sock, const struct buffer *buf, const struct l=
ink_socket_actual *to)</span><br><span> {</span><br><span>     if (sock-&gt=
;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span><br><span>     {</span><br>=
<span>@@ -2772,8 +2772,8 @@</span><br><span>     return sock-&gt;writes=2Ei=
ostate;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-read_sockaddr_from_overlapped(struct overlapped_io *io, struct sockad=
dr *dst, int overlapped_ret)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+read_sockaddr_from_overlapped(const struct overlapped_io *io, struct socka=
ddr *dst, int overlapped_ret)</span><br><span> {</span><br><span>     if (o=
verlapped_ret &gt;=3D 0 &amp;&amp; io-&gt;addr_defined)</span><br><span>   =
  {</span><br><span>diff --git a/src/openvpn/socket=2Eh b/src/openvpn/socke=
t=2Eh</span><br><span>index 46fa29c=2E=2Ecbcdeef 100644</span><br><span>---=
 a/src/openvpn/socket=2Eh</span><br><span>+++ b/src/openvpn/socket=2Eh</spa=
n><br><span>@@ -268,7 +268,7 @@</span><br><span> </span><br><span> int sock=
et_recv_queue(struct link_socket *sock, int maxsize);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-int socket_send_queue(str=
uct link_socket *sock, struct buffer *buf,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+int socket_send_queue(struct link_socket *sock, cons=
t struct buffer *buf,</span><br><span>                       const struct l=
ink_socket_actual *to);</span><br><span> </span><br><span> typedef struct</=
span><br><span>@@ -348,8 +348,8 @@</span><br><span> </span><br><span> struc=
t link_socket *link_socket_new(void);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-void socket_bind(socket_descriptor_t sd, =
struct addrinfo *local, int af_family, const char *prefix,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                 bool ipv6only);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void socket_bind(socket_d=
escriptor_t sd, const struct addrinfo *local, int af_family,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 const char *prefi=
x, bool ipv6only);</span><br><span> </span><br><span> int openvpn_connect(s=
ocket_descriptor_t sd, const struct sockaddr *remote, int connect_timeout,<=
/span><br><span>                     volatile int *signal_received);</span>=
<br><span>@@ -496,7 +496,7 @@</span><br><span> }</span><br><span> </span><b=
r><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-link_socket_verify_incoming_addr(struct buffer *buf, const struct lin=
k_socket_info *info,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+link_socket_verify_incoming_addr(const struct buffer *buf, const struct li=
nk_socket_info *info,</span><br><span>                                  con=
st struct link_socket_actual *from_addr)</span><br><span> {</span><br><span=
>     if (buf-&gt;len &gt; 0)</span><br><span>@@ -620,7 +620,7 @@</span><br=
><span> </span><br><span> #else  /* ifdef _WIN32 */</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t link_socket_read_ud=
p_posix(struct link_socket *sock, struct buffer *buf,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socket_read_udp_posix(const =
struct link_socket *sock, struct buffer *buf,</span><br><span>             =
                       struct link_socket_actual *from);</span><br><span> <=
/span><br><span> #endif /* ifdef _WIN32 */</span><br><span>@@ -706,12 +706,=
12 @@</span><br><span> </span><br><span> #else /* ifdef _WIN32 */</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t link_=
socket_write_udp_posix_sendmsg(struct link_socket *sock, struct buffer *buf=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t link_socke=
t_write_udp_posix_sendmsg(const struct link_socket *sock, const struct buff=
er *buf,</span><br><span>                                             struc=
t link_socket_actual *to);</span><br><span> </span><br><span> </span><br><s=
pan> static inline ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-link_socket_write_udp_posix(struct link_socket *sock, struct buffer *b=
uf,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_writ=
e_udp_posix(const struct link_socket *sock, const struct buffer *buf,</span=
><br><span>                             struct link_socket_actual *to)</spa=
n><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><br><span>@@ -7=
27,7 +727,7 @@</span><br><span> }</span><br><span> </span><br><span> static=
 inline ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_s=
ocket_write_tcp_posix(struct link_socket *sock, struct buffer *buf)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+link_socket_write_tcp_posix=
(const struct link_socket *sock, const struct buffer *buf)</span><br><span>=
 {</span><br><span>     return send(sock-&gt;sd, CBPTR(buf), BLENZ(buf), MS=
G_NOSIGNAL);</span><br><span> }</span><br><span>@@ -785,7 +785,7 @@</span><=
br><span>  * from tunnel packet=2E</span><br><span>  */</span><br><span> st=
atic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_=
socket_set_tos(struct link_socket *sock)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+link_socket_set_tos(const struct link_socket *sock)</s=
pan><br><span> {</span><br><span>     if (sock &amp;&amp; sock-&gt;ptos_def=
ined)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/socke=
t_util=2Eh b/src/openvpn/socket_util=2Eh</span><br><span>index 13f5962=2E=
=2Eadd08ba 100644</span><br><span>--- a/src/openvpn/socket_util=2Eh</span><=
br><span>+++ b/src/openvpn/socket_util=2Eh</span><br><span>@@ -439,7 +439,7=
 @@</span><br><span> </span><br><span> </span><br><span> static inline bool=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-addrlist_match_proto(=
const struct openvpn_sockaddr *a1, struct addrinfo *addr_list, const int pr=
oto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+addrlist_match_=
proto(const struct openvpn_sockaddr *a1, const struct addrinfo *addr_list, =
const int proto)</span><br><span> {</span><br><span>     return link_socket=
_proto_connection_oriented(proto) ? addrlist_match(a1, addr_list)</span><br=
><span>                                                         : addrlist_=
port_match(a1, addr_list);</span><br><span>diff --git a/src/openvpn/socks=
=2Ec b/src/openvpn/socks=2Ec</span><br><span>index b84da24=2E=2E0296349 100=
644</span><br><span>--- a/src/openvpn/socks=2Ec</span><br><span>+++ b/src/o=
penvpn/socks=2Ec</span><br><span>@@ -83,7 +83,7 @@</span><br><span> </span>=
<br><span> static bool</span><br><span> socks_proxy_recv_char(uint8_t *c, c=
onst char *name, socket_descriptor_t sd,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                      struct event_timeout *server_poll_=
timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
           const struct event_timeout *server_poll_timeout,</span><br><span=
>                       volatile int *signal_received)</span><br><span> {</=
span><br><span>     fd_set reads;</span><br><span>@@ -98,8 +98,8 @@</span><=
br><span> }</span><br><span> </span><br><span> static bool</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-socks_username_password_auth(struct so=
cks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                             struct event_timeout *ser=
ver_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+so=
cks_username_password_auth(const struct socks_proxy_info *p, socket_descrip=
tor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                   const struct event_timeout *server_poll_timeout,</span><=
br><span>                              volatile int *signal_received)</span=
><br><span> {</span><br><span>     char to_send[516];</span><br><span>@@ -1=
57,8 +157,8 @@</span><br><span> }</span><br><span> </span><br><span> static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_handshake(=
struct socks_proxy_info *p, socket_descriptor_t sd,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                struct event_timeout *serve=
r_poll_timeout, volatile int *signal_received)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+socks_handshake(const struct socks_proxy_info *p=
, socket_descriptor_t sd,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                const struct event_timeout *server_poll_timeout, vola=
tile int *signal_received)</span><br><span> {</span><br><span>     uint8_t =
buf[2];</span><br><span>     int len =3D 0;</span><br><span>@@ -232,7 +232,=
7 @@</span><br><span> </span><br><span> static bool</span><br><span> recv_s=
ocks_reply(socket_descriptor_t sd, struct openvpn_sockaddr *addr,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                 struct event_t=
imeout *server_poll_timeout, volatile int *signal_received)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 const struct event=
_timeout *server_poll_timeout, volatile int *signal_received)</span><br><sp=
an> {</span><br><span>     uint8_t atyp =3D 0;</span><br><span>     int ale=
n =3D 0;</span><br><span>@@ -334,11 +334,11 @@</span><br><span> }</span><br=
><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-establish_socks_proxy_passthru(struct socks_proxy_info *p,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+establish_socks_proxy_passt=
hru(const struct socks_proxy_info *p,</span><br><span>                     =
           socket_descriptor_t sd, /* already open to proxy */</span><br><s=
pan>                                const char *host,       /* openvpn serv=
er remote */</span><br><span>                                const char *se=
rvname,   /* openvpn server port */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                               struct event_timeout *server_p=
oll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                        const struct event_timeout *server_poll_timeout,</s=
pan><br><span>                                struct signal_info *sig_info)=
</span><br><span> {</span><br><span>     char buf[270];</span><br><span>@@ =
-392,10 +392,10 @@</span><br><span> }</span><br><span> </span><br><span> vo=
id</span><br><span style=3D"color: hsl(0, 100%, 40%);">-establish_socks_pro=
xy_udpassoc(struct socks_proxy_info *p,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+establish_socks_proxy_udpassoc(const struct socks_proxy=
_info *p,</span><br><span>                                socket_descriptor=
_t ctrl_sd, /* already open to proxy */</span><br><span>                   =
             struct openvpn_sockaddr *relay_addr,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                               struct event_tim=
eout *server_poll_timeout,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                               const struct event_timeout *server_po=
ll_timeout,</span><br><span>                                struct signal_i=
nfo *sig_info)</span><br><span> {</span><br><span>     if (!socks_handshake=
(p, ctrl_sd, server_poll_timeout, &amp;sig_info-&gt;signal_received))</span=
><br><span>diff --git a/src/openvpn/socks=2Eh b/src/openvpn/socks=2Eh</span=
><br><span>index caed18c=2E=2E7434bbf 100644</span><br><span>--- a/src/open=
vpn/socks=2Eh</span><br><span>+++ b/src/openvpn/socks=2Eh</span><br><span>@=
@ -49,17 +49,17 @@</span><br><span> </span><br><span> void socks_proxy_clos=
e(struct socks_proxy_info *sp);</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-void establish_socks_proxy_passthru(struct sock=
s_proxy_info *p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d establish_socks_proxy_passthru(const struct socks_proxy_info *p,</span><b=
r><span>                                     socket_descriptor_t sd, /* alr=
eady open to proxy */</span><br><span>                                     =
const char *host,       /* openvpn server remote */</span><br><span>       =
                              const char *servname,   /* openvpn server por=
t */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
                   struct event_timeout *server_poll_timeout,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
   const struct event_timeout *server_poll_timeout,</span><br><span>       =
                              struct signal_info *sig_info);</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void establish_soc=
ks_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void establish_socks_proxy_udpassoc(const struct =
socks_proxy_info *p,</span><br><span>                                     s=
ocket_descriptor_t ctrl_sd, /* already open to proxy */</span><br><span>   =
                                  struct openvpn_sockaddr *relay_addr,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
          struct event_timeout *server_poll_timeout,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                    const=
 struct event_timeout *server_poll_timeout,</span><br><span>               =
                      struct signal_info *sig_info);</span><br><span> </spa=
n><br><span> void socks_process_incoming_udp(struct buffer *buf, struct lin=
k_socket_actual *from);</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/=
src/openvpn/ssl=2Ec</span><br><span>index aeec020=2E=2E3594871 100644</span=
><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=
=2Ec</span><br><span>@@ -1171,7 +1171,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> struct tls_multi *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-tls_multi_init(struct tls_options *tls_options)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+tls_multi_init(const struct =
tls_options *tls_options)</span><br><span> {</span><br><span>     struct tl=
s_multi *ret;</span><br><span> </span><br><span>@@ -1212,7 +1212,7 @@</span=
><br><span>  */</span><br><span> </span><br><span> struct tls_auth_standalo=
ne *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_auth_standalo=
ne_init(struct tls_options *tls_options, struct gc_arena *gc)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+tls_auth_standalone_init(const st=
ruct tls_options *tls_options, struct gc_arena *gc)</span><br><span> {</spa=
n><br><span>     struct tls_auth_standalone *tas;</span><br><span> </span><=
br><span>@@ -1631,8 +1631,9 @@</span><br><span> </span><br><span> bool</spa=
n><br><span> tls_session_update_crypto_params_do_work(struct tls_multi *mul=
ti, struct tls_session *session,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                         struct options *options=
, struct frame *frame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                         struct frame *frame_fragment, str=
uct link_socket_info *lsi,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                         const struct options *optio=
ns, struct frame *frame,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                         struct frame *frame_fragment,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                      const struct link_socket_info *lsi,</span><br><span> =
                                         dco_context_t *dco)</span><br><spa=
n> {</span><br><span>     if (session-&gt;key[KS_PRIMARY]=2Ecrypto_options=
=2Ekey_ctx_bi=2Einitialized)</span><br><span>@@ -1704,7 +1705,7 @@</span><b=
r><span> bool</span><br><span> tls_session_update_crypto_params(struct tls_=
multi *multi, struct tls_session *session,</span><br><span>                =
                  struct options *options, struct frame *frame,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
struct frame *frame_fragment, struct link_socket_info *lsi,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                 st=
ruct frame *frame_fragment, const struct link_socket_info *lsi,</span><br><=
span>                                  dco_context_t *dco)</span><br><span>=
 {</span><br><span>     if (!check_session_cipher(session, options))</span>=
<br><span>@@ -1920,7 +1921,8 @@</span><br><span> }</span><br><span> </span>=
<br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-push_peer_info_peerid(struct buffer *out, struct tls_multi *multi, struct =
tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+push_peer_info_peerid(struct buffer *out, const struct tls_multi *multi,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
  const struct tls_session *session)</span><br><span> {</span><br><span>   =
  if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_en=
abled)</span><br><span>     {</span><br><span>@@ -1955,7 +1957,7 @@</span><=
br><span>  * @return          true if no error was encountered</span><br><s=
pan>  */</span><br><span> static bool</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-push_peer_info(struct buffer *buf, struct tls_multi *multi,=
 struct tls_session *session)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+push_peer_info(struct buffer *buf, const struct tls_multi *multi,=
 struct tls_session *session)</span><br><span> {</span><br><span>     struc=
t gc_arena gc =3D gc_new();</span><br><span>     bool ret =3D false;</span>=
<br><span>@@ -2599,8 +2601,8 @@</span><br><span> }</span><br><span> </span>=
<br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sessio=
n_skip_to_pre_start(struct tls_session *session, struct tls_pre_decrypt_sta=
te *state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
               struct link_socket_actual *from)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+session_skip_to_pre_start(struct tls_session *s=
ession, const struct tls_pre_decrypt_state *state,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                          const struct link_=
socket_actual *from)</span><br><span> {</span><br><span>     struct key_sta=
te *ks =3D &amp;session-&gt;key[KS_PRIMARY];</span><br><span>     ks-&gt;se=
ssion_id_remote =3D state-&gt;peer_session_id;</span><br><span>@@ -2829,7 +=
2831,7 @@</span><br><span> </span><br><span> static bool</span><br><span> c=
heck_outgoing_ciphertext(struct key_state *ks, struct tls_session *session,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
     struct buffer *to_link, bool *continue_tls_process)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                          const struct=
 buffer *to_link, bool *continue_tls_process)</span><br><span> {</span><br>=
<span>     if (to_link-&gt;len)</span><br><span>     {</span><br><span>@@ -=
4193,7 +4195,7 @@</span><br><span> }</span><br><span> </span><br><span> voi=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_post_encrypt(str=
uct tls_multi *multi, struct buffer *buf)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+tls_post_encrypt(struct tls_multi *multi, const struc=
t buffer *buf)</span><br><span> {</span><br><span>     struct key_state *ks=
 =3D multi-&gt;save_ks;</span><br><span>     multi-&gt;save_ks =3D NULL;</s=
pan><br><span>@@ -4324,7 +4326,7 @@</span><br><span>  * into a garbage coll=
ectable string which is returned=2E</span><br><span>  */</span><br><span> c=
onst char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-protocol_d=
ump(struct buffer *buffer, unsigned int flags, struct gc_arena *gc)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+protocol_dump(const struct =
buffer *buffer, unsigned int flags, struct gc_arena *gc)</span><br><span> {=
</span><br><span>     struct buffer out =3D alloc_buf_gc(256, gc);</span><b=
r><span>     struct buffer buf =3D *buffer;</span><br><span>diff --git a/sr=
c/openvpn/ssl=2Eh b/src/openvpn/ssl=2Eh</span><br><span>index 5483fbb=2E=2E=
76c3610 100644</span><br><span>--- a/src/openvpn/ssl=2Eh</span><br><span>++=
+ b/src/openvpn/ssl=2Eh</span><br><span>@@ -166,7 +166,7 @@</span><br><span=
>  *</span><br><span>  * @return A newly allocated and initialized \c tls_m=
ulti structure=2E</span><br><span>  */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-struct tls_multi *tls_multi_init(struct tls_options *tls_o=
ptions);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct tls_=
multi *tls_multi_init(const struct tls_options *tls_options);</span><br><sp=
an> </span><br><span> /**</span><br><span>  * Finalize initialization of a =
\c tls_multi structure=2E</span><br><span>@@ -187,7 +187,7 @@</span><br><sp=
an> /*</span><br><span>  * Initialize a standalone tls-auth verification ob=
ject=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-struct tls_auth_standalone *tls_auth_standalone_init(struct tls_opti=
ons *tls_options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
ruct tls_auth_standalone *tls_auth_standalone_init(const struct tls_options=
 *tls_options,</span><br><span>                                            =
          struct gc_arena *gc);</span><br><span> </span><br><span> /**</spa=
n><br><span>@@ -373,7 +373,7 @@</span><br><span>  * @param multi - The TLS =
state for this packet&#39;s destination VPN tunnel=2E</span><br><span>  * @=
param buf - The buffer containing the outgoing packet=2E</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void tls_post_encry=
pt(struct tls_multi *multi, struct buffer *buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void tls_post_encrypt(struct tls_multi *multi,=
 const struct buffer *buf);</span><br><span> </span><br><span> /** @} name =
Functions for managing security parameter state for data channel packets */=
</span><br><span> </span><br><span>@@ -463,7 +463,8 @@</span><br><span>  */=
</span><br><span> bool tls_session_update_crypto_params(struct tls_multi *m=
ulti, struct tls_session *session,</span><br><span>                        =
               struct options *options, struct frame *frame,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                    =
  struct frame *frame_fragment, struct link_socket_info *lsi,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
     struct frame *frame_fragment,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                      const struct link_sock=
et_info *lsi,</span><br><span>                                       dco_co=
ntext_t *dco);</span><br><span> </span><br><span> /*</span><br><span>@@ -52=
7,7 +528,7 @@</span><br><span> #define PD_VERBOSE                 (1 &lt;&l=
t; 10)</span><br><span> #define PD_TLS_CRYPT               (1 &lt;&lt; 11)<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-cons=
t char *protocol_dump(struct buffer *buffer, unsigned int flags, struct gc_=
arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const ch=
ar *protocol_dump(const struct buffer *buffer, unsigned int flags, struct g=
c_arena *gc);</span><br><span> </span><br><span> /*</span><br><span>  * deb=
ugging code</span><br><span>@@ -566,7 +567,7 @@</span><br><span> /* Special=
 method to skip the three way handshake RESET stages=2E This is</span><br><=
span>  * used by the HMAC code when seeing a packet that matches the previo=
us</span><br><span>  * HMAC based stateless server state */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-bool session_skip_to_pre_start(struct=
 tls_session *session, struct tls_pre_decrypt_state *state,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                               struct=
 link_socket_actual *from);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool session_skip_to_pre_start(struct tls_session *session, const s=
truct tls_pre_decrypt_state *state,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                               const struct link_socket_act=
ual *from);</span><br><span> </span><br><span> #endif /* ifndef OPENVPN_SSL=
_H */</span><br><span>diff --git a/src/openvpn/ssl_backend=2Eh b/src/openvp=
n/ssl_backend=2Eh</span><br><span>index a6d57f2=2E=2E2150d81 100644</span><=
br><span>--- a/src/openvpn/ssl_backend=2Eh</span><br><span>+++ b/src/openvp=
n/ssl_backend=2Eh</span><br><span>@@ -137,7 +137,7 @@</span><br><span>  *</=
span><br><span>  * @return      true if the context is initialised, false i=
f not=2E</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-bool tls_ctx_initialised(struct tls_root_ctx *ctx);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool tls_ctx_initialised(const stru=
ct tls_root_ctx *ctx);</span><br><span> </span><br><span> /**</span><br><sp=
an>  * Set any library specific options=2E</span><br><span>diff --git a/src=
/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>inde=
x 9983742=2E=2E965ecdb 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -=
146,7 +146,7 @@</span><br><span> }</span><br><span> </span><br><span> bool<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_ctx_initialised(st=
ruct tls_root_ctx *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tls_ctx_initialised(const struct tls_root_ctx *ctx)</span><br><span> {<=
/span><br><span>     /* either this should be NULL or should be non-null an=
d then have a</span><br><span>      * valid TLS ctx inside as well */</span=
><br><span>diff --git a/src/openvpn/ssl_openssl=2Ec b/src/openvpn/ssl_opens=
sl=2Ec</span><br><span>index b88e1d9=2E=2E73cda0c 100644</span><br><span>--=
- a/src/openvpn/ssl_openssl=2Ec</span><br><span>+++ b/src/openvpn/ssl_opens=
sl=2Ec</span><br><span>@@ -129,7 +129,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-tls_ctx_initialised(struct tls_root_ctx *ctx)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+tls_ctx_initialised(const struct tls_root_ct=
x *ctx)</span><br><span> {</span><br><span>     /* either this should be NU=
LL or should be non-null and then have a</span><br><span>      * valid TLS =
ctx inside as well */</span><br><span>@@ -2010,7 +2010,7 @@</span><br><span=
> }</span><br><span> </span><br><span> static void</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-bio_debug_data(const char *mode, BIO *bio, con=
st uint8_t *buf, int len, const char *desc)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bio_debug_data(const char *mode, const BIO *bio, co=
nst uint8_t *buf, int len, const char *desc)</span><br><span> {</span><br><=
span>     struct gc_arena gc =3D gc_new();</span><br><span>     if (len &gt=
; 0)</span><br><span>@@ -2024,7 +2024,7 @@</span><br><span> }</span><br><sp=
an> </span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bio_debug_oc(const char *mode, BIO *bio)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bio_debug_oc(const char *mode, const BIO =
*bio)</span><br><span> {</span><br><span>     open_biofp();</span><br><span=
>     fprintf(biofp, &quot;BIO %s time=3D%&quot; PRIi64 &quot; bio=3D&quot;=
 ptr_format &quot;\n&quot;, mode, (int64_t)time(NULL),</span><br><span>diff=
 --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>=
index e9afda4=2E=2Ef78782f 100644</span><br><span>--- a/src/openvpn/ssl_pkt=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -119,=
7 +119,7 @@</span><br><span>  */</span><br><span> static void</span><br><sp=
an> tls_wrap_control(struct tls_wrap_ctx *ctx, uint8_t header, struct buffe=
r *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
   struct session_id *session_id)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                 const struct session_id *session_id)</span><=
br><span> {</span><br><span>     if (ctx-&gt;mode =3D=3D TLS_WRAP_AUTH || c=
tx-&gt;mode =3D=3D TLS_WRAP_NONE)</span><br><span>     {</span><br><span>@@=
 -403,9 +403,9 @@</span><br><span> </span><br><span> </span><br><span> stru=
ct buffer</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_reset_st=
andalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalone *tas,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                     struct s=
ession_id *own_sid, struct session_id *remote_sid, uint8_t header,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                     bool requ=
est_resend_wkc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_=
reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standalone=
 *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
        const struct session_id *own_sid, const struct session_id *remote_s=
id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
     uint8_t header, bool request_resend_wkc)</span><br><span> {</span><br>=
<span>     /* Copy buffer here to point at the same data but allow tls_wrap=
_control</span><br><span>      * to potentially change buf to point to anot=
her buffer without</span><br><span>@@ -490,7 +490,7 @@</span><br><span> boo=
l</span><br><span> check_session_hmac_and_pkt_id(struct tls_pre_decrypt_sta=
te *state,</span><br><span>                               const struct open=
vpn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                            uint8_t *key,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              const uint8_t *key,</sp=
an><br><span>                               int handwindow,</span><br><span=
>                               bool pkt_is_ack)</span><br><span> {</span><=
br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</sp=
an><br><span>index 03e8930=2E=2E8203e4a 100644</span><br><span>--- a/src/op=
envpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><=
span>@@ -183,7 +183,7 @@</span><br><span>  * @return              the expec=
ted server session id</span><br><span>  */</span><br><span> bool check_sess=
ion_hmac_and_pkt_id(struct tls_pre_decrypt_state *state, const struct openv=
pn_sockaddr *from,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                uint8_t *key, int handwindow, bool pkt_is_a=
ck);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                    const uint8_t *key, int handwindow, bool pkt_is_ack);</=
span><br><span> </span><br><span> /*</span><br><span>  * Write a control ch=
annel authentication record=2E</span><br><span>@@ -210,8 +210,9 @@</span><b=
r><span>  * from the tls pre decrypt state=2E</span><br><span>  *</span><br=
><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-struct buf=
fer tls_reset_standalone(struct tls_wrap_ctx *ctx, struct tls_auth_standalo=
ne *tas,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                      struct session_id *own_sid, struct session_id *remote=
_sid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct buffer =
tls_reset_standalone(struct tls_wrap_ctx *ctx, const struct tls_auth_standa=
lone *tas,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                          const struct session_id *own_sid,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
const struct session_id *remote_sid,</span><br><span>                      =
              uint8_t header, bool request_resend_wkc);</span><br><span> </=
span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/=
src/openvpn/ssl_verify=2Ec</span><br><span>index 6631718=2E=2E0acba2b 10064=
4</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/sr=
c/openvpn/ssl_verify=2Ec</span><br><span>@@ -1140,7 +1140,7 @@</span><br><s=
pan>  * cache=2E</span><br><span>  */</span><br><span> static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-tls_authentication_status_use_=
cache(struct tls_multi *multi)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+tls_authentication_status_use_cache(const struct tls_multi *mult=
i)</span><br><span> {</span><br><span>     unsigned int idx =3D min_uint(mu=
lti-&gt;tas_cache_num_updates, SIZE(cache_intervals) - 1);</span><br><span>=
     time_t latency =3D cache_intervals[idx];</span><br><span>@@ -1284,7 +1=
284,7 @@</span><br><span>  * Check if the script/plugin left a message in t=
he auth failed message</span><br><span>  * file and relay it to the user */=
</span><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-check_for_client_reason(struct tls_multi *multi, struct auth_deferr=
ed_status *status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
heck_for_client_reason(struct tls_multi *multi, const struct auth_deferred_=
status *status)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     const char *msg =3D key_state_check_auth=
_failed_message_file(status, &amp;gc);</span><br><span>@@ -1553,7 +1553,7 @=
@</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </=
span><br><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-set_verify_user_pass_env(struct user_pass *up, struct tls_multi *mult=
i, struct tls_session *session)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+set_verify_user_pass_env(const struct user_pass *up, struct tls=
_multi *multi, struct tls_session *session)</span><br><span> {</span><br><s=
pan>     /* Is username defined? */</span><br><span>     if ((session-&gt;o=
pt-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up-&gt;usern=
ame))</span><br><span>@@ -1581,7 +1581,7 @@</span><br><span> }</span><br><s=
pan> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-ssl_verify_username_length(struct tls_session *session, const char *u=
sername)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_verify_=
username_length(const struct tls_session *session, const char *username)</s=
pan><br><span> {</span><br><span>     if ((session-&gt;opt-&gt;ssl_flags &a=
mp; SSLF_USERNAME_AS_COMMON_NAME)</span><br><span>         &amp;&amp; strle=
n(username) &gt; TLS_USERNAME_LEN)</span><br><span>diff --git a/src/openvpn=
/ssl_verify=2Eh b/src/openvpn/ssl_verify=2Eh</span><br><span>index 3176d76=
=2E=2Ee77bc4a 100644</span><br><span>--- a/src/openvpn/ssl_verify=2Eh</span=
><br><span>+++ b/src/openvpn/ssl_verify=2Eh</span><br><span>@@ -202,7 +202,=
7 @@</span><br><span>  * @return              true if name is under limit o=
r username-as-common-name</span><br><span>  *                      is not a=
ctive</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-bool ssl_verify_username_length(struct tls_session *session, const cha=
r *username);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool s=
sl_verify_username_length(const struct tls_session *session, const char *us=
ername);</span><br><span> </span><br><span> /**</span><br><span>  * Runs th=
e --client-crresponse script if one is defined=2E</span><br><span>@@ -275,7=
 +275,7 @@</span><br><span> void auth_set_client_reason(struct tls_multi *m=
ulti, const char *client_reason);</span><br><span> </span><br><span> static=
 inline const char *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-t=
ls_client_reason(struct tls_multi *multi)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+tls_client_reason(const struct tls_multi *multi)</spa=
n><br><span> {</span><br><span>     return multi-&gt;client_reason;</span><=
br><span> }</span><br><span>diff --git a/src/openvpn/status=2Ec b/src/openv=
pn/status=2Ec</span><br><span>index c7d375b=2E=2Ecfbc38d 100644</span><br><=
span>--- a/src/openvpn/status=2Ec</span><br><span>+++ b/src/openvpn/status=
=2Ec</span><br><span>@@ -135,7 +135,7 @@</span><br><span> }</span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-status_reset(struct status_output *so)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+status_reset(const struct status_output *so)</span><b=
r><span> {</span><br><span>     if (so &amp;&amp; so-&gt;fd &gt;=3D 0)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/status=2Eh b/sr=
c/openvpn/status=2Eh</span><br><span>index 7953a4e=2E=2E4c01d75 100644</spa=
n><br><span>--- a/src/openvpn/status=2Eh</span><br><span>+++ b/src/openvpn/=
status=2Eh</span><br><span>@@ -69,7 +69,7 @@</span><br><span> </span><br><s=
pan> bool status_trigger(struct status_output *so);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-void status_reset(struct st=
atus_output *so);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id status_reset(const struct status_output *so);</span><br><span> </span><b=
r><span> void status_flush(struct status_output *so);</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><=
br><span>index 133f670=2E=2Ef191a6b 100644</span><br><span>--- a/src/openvp=
n/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -835=
,7 +835,7 @@</span><br><span>          const char *ifconfig_ipv6_local_parm=
,     /* --ifconfig parm 1 IPv6 */</span><br><span>          int ifconfig_i=
pv6_netbits_parm,</span><br><span>          const char *ifconfig_ipv6_remot=
e_parm,    /* --ifconfig parm 2 IPv6 */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-         struct addrinfo *local_public, struct addrinfo *=
remote_public, const bool strict_warn,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         const struct addrinfo *local_public, const stru=
ct addrinfo *remote_public, const bool strict_warn,</span><br><span>       =
   struct env_set *es, openvpn_net_ctx_t *ctx, struct tuntap *tt)</span><br=
><span> {</span><br><span>     if (!tt)</span><br><span>@@ -978,7 +978,7 @@=
</span><br><span>  * -&gt; helper function to simplify code below</span><br=
><span>  */</span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-add_route_connected_v6_net(struct tuntap *tt, const stru=
ct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_=
route_connected_v6_net(const struct tuntap *tt, const struct env_set *es)</=
span><br><span> {</span><br><span>     struct route_ipv6 r6;</span><br><spa=
n> </span><br><span>@@ -1020,7 +1020,7 @@</span><br><span>  */</span><br><s=
pan> </span><br><span> in_addr_t</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-create_arbitrary_remote(struct tuntap *tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+create_arbitrary_remote(const struct tunt=
ap *tt)</span><br><span> {</span><br><span>     in_addr_t remote;</span><br=
><span> </span><br><span>@@ -1592,7 +1592,7 @@</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ct=
x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+undo_ifconfig_ipv=
4(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span> {</span=
><br><span> #if defined(TARGET_LINUX)</span><br><span>     int netbits =3D =
netmask_to_netbits2(tt-&gt;remote_netmask);</span><br><span>@@ -1627,7 +162=
7,7 @@</span><br><span> }</span><br><span> </span><br><span> static void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig_ipv6(struc=
t tuntap *tt, openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+undo_ifconfig_ipv6(const struct tuntap *tt, openvpn_net_c=
tx_t *ctx)</span><br><span> {</span><br><span> #if defined(TARGET_LINUX)</s=
pan><br><span>     if (net_addr_v6_del(ctx, tt-&gt;actual_name, &amp;tt-&gt=
;local_ipv6, tt-&gt;netbits_ipv6) &lt; 0)</span><br><span>@@ -1652,7 +1652,=
7 @@</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-undo_ifconfig(struct tuntap *tt, =
openvpn_net_ctx_t *ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx)</span><b=
r><span> {</span><br><span>     if (tt-&gt;backend_driver !=3D DRIVER_NULL =
&amp;&amp; tt-&gt;backend_driver !=3D DRIVER_AFUNIX)</span><br><span>     {=
</span><br><span>@@ -1720,13 +1720,13 @@</span><br><span> }</span><br><span=
> </span><br><span> static ssize_t</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-write_tun_header(struct tuntap *tt, uint8_t *buf, int len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun_header(const =
struct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><b=
r><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</s=
pan><br><span>         u_int32_t type;</span><br><span>         struct iove=
c iv[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const=
 struct ip *iph =3D (struct ip *)buf;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const struct ip *iph =3D (const struct ip *)buf;<=
/span><br><span> </span><br><span>         if (iph-&gt;ip_v =3D=3D 6)</span=
><br><span>         {</span><br><span>@@ -1737,9 +1737,11 @@</span><br><spa=
n>             type =3D htonl(AF_INET);</span><br><span>         }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 argument to writev is a pointer to const but we still need to drop</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+         * the const from b=
uf pointer here */</span><br><span>         iv[0]=2Eiov_base =3D &amp;type;=
</span><br><span>         iv[0]=2Eiov_len =3D sizeof(type);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        iv[1]=2Eiov_base =3D buf;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        iv[1]=2Eiov_bas=
e =3D (void *)buf;</span><br><span>         iv[1]=2Eiov_len =3D len;</span>=
<br><span> </span><br><span>         return header_modify_read_write_return=
(writev(tt-&gt;fd, iv, 2));</span><br><span>@@ -1751,7 +1753,7 @@</span><br=
><span> }</span><br><span> </span><br><span> static ssize_t</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-read_tun_header(struct tuntap *tt, ui=
nt8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+read_tun_header(const struct tuntap *tt, uint8_t *buf, int len)</span><br>=
<span> {</span><br><span>     if (tt-&gt;type =3D=3D DEV_TYPE_TUN)</span><b=
r><span>     {</span><br><span>@@ -1777,13 +1779,13 @@</span><br><span>  */=
</span><br><span> #if !defined(TARGET_DARWIN)</span><br><span> ssize_t</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *t=
t, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span=
><br><span> {</span><br><span>     return write_tun_header(tt, buf, len);</=
span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t =
*buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_=
tun(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</spa=
n><br><span>     return read_tun_header(tt, buf, len);</span><br><span> }</=
span><br><span>@@ -1799,7 +1801,7 @@</span><br><span> </span><br><span> #if=
 defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span> static b=
ool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_dco_enabled(st=
ruct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun=
_dco_enabled(const struct tuntap *tt)</span><br><span> {</span><br><span>  =
   return tt-&gt;backend_driver =3D=3D DRIVER_DCO;</span><br><span> }</span=
><br><span>@@ -2047,13 +2049,13 @@</span><br><span> }</span><br><span> </sp=
an><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap *tt, const =
uint8_t *buf, int len)</span><br><span> {</span><br><span>     return write=
(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> </span><br><span=
> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-read_tun(str=
uct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *buf, int len)=
</span><br><span> {</span><br><span>     return read(tt-&gt;fd, buf, len);<=
/span><br><span> }</span><br><span>@@ -2252,13 +2254,13 @@</span><br><span>=
 }</span><br><span> </span><br><span> ssize_t</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const str=
uct tuntap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><=
span>     return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><=
span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, =
uint8_t *buf, int len)</span><br><span> {</span><br><span>     return read(=
tt-&gt;fd, buf, len);</span><br><span> }</span><br><span>@@ -2588,7 +2590,7=
 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tuntap *tt, ui=
nt8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)</span><br>=
<span> {</span><br><span>     struct strbuf sbuf;</span><br><span>     sbuf=
=2Elen =3D len;</span><br><span>@@ -2597,7 +2599,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tun=
tap *tt, uint8_t *buf, int len)</span><br><span> {</span><br><span>     str=
uct strbuf sbuf;</span><br><span>     int f =3D 0;</span><br><span>@@ -3095=
,7 +3097,7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun(struct tunt=
ap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+write_tun(const struct tuntap *tt, const uint8_t *buf, int len)<=
/span><br><span> {</span><br><span>     if (tt-&gt;backend_driver =3D=3D DR=
IVER_UTUN)</span><br><span>     {</span><br><span>@@ -3108,7 +3110,7 @@</sp=
an><br><span> }</span><br><span> </span><br><span> ssize_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-read_tun(struct tuntap *tt, uint8_t *b=
uf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_tu=
n(const struct tuntap *tt, uint8_t *buf, int len)</span><br><span> {</span>=
<br><span>     if (tt-&gt;backend_driver =3D=3D DRIVER_UTUN)</span><br><spa=
n>     {</span><br><span>@@ -3243,13 +3245,13 @@</span><br><span> }</span><=
br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tuntap=
 *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     =
return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> </sp=
an><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t *b=
uf, int len)</span><br><span> {</span><br><span>     return read(tt-&gt;fd,=
 buf, len);</span><br><span> }</span><br><span>@@ -3311,7 +3313,7 @@</span>=
<br><span> }</span><br><span> </span><br><span> int</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tun_write_queue(struct tuntap *tt, struct b=
uffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_writ=
e_queue(struct tuntap *tt, const struct buffer *buf)</span><br><span> {</sp=
an><br><span>     if (tt-&gt;writes=2Eiostate =3D=3D IOSTATE_INITIAL)</span=
><br><span>     {</span><br><span>@@ -3365,7 +3367,7 @@</span><br><span> }<=
/span><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-tun_write_win32(struct tuntap *tt, struct buffer *buf)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_write_win32(struct =
tuntap *tt, const struct buffer *buf)</span><br><span> {</span><br><span>  =
   int err =3D 0;</span><br><span>     int status =3D 0;</span><br><span>@@=
 -5370,7 +5372,7 @@</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fork_register_dns_=
action(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+fork_register_dns_action(const struct tuntap *tt)</span><br><span> {<=
/span><br><span>     if (tt &amp;&amp; tt-&gt;options=2Eregister_dns &amp;&=
amp; tt-&gt;options=2Emsg_channel)</span><br><span>     {</span><br><span>@=
@ -5460,7 +5462,7 @@</span><br><span> }</span><br><span> </span><br><span> =
static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_get=
_mtu(struct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+tuntap_get_mtu(const struct tuntap *tt)</span><br><span> {</span><br><s=
pan>     ULONG mtu =3D 0;</span><br><span>     DWORD len;</span><br><span>@=
@ -6035,7 +6037,7 @@</span><br><span> }</span><br><span> </span><br><span> =
void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_show_debug(st=
ruct tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun=
_show_debug(const struct tuntap *tt)</span><br><span> {</span><br><span>   =
  if (tt-&gt;backend_driver =3D=3D WINDOWS_DRIVER_TAP_WINDOWS6)</span><br><=
span>     {</span><br><span>@@ -6295,13 +6297,13 @@</span><br><span> }</spa=
n><br><span> </span><br><span> ssize_t</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-write_tun(struct tuntap *tt, uint8_t *buf, int len)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+write_tun(const struct tun=
tap *tt, const uint8_t *buf, int len)</span><br><span> {</span><br><span>  =
   return write(tt-&gt;fd, buf, len);</span><br><span> }</span><br><span> <=
/span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-read_tun(struct tuntap *tt, uint8_t *buf, int len)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+read_tun(const struct tuntap *tt, uint8_t=
 *buf, int len)</span><br><span> {</span><br><span>     return read(tt-&gt;=
fd, buf, len);</span><br><span> }</span><br><span>diff --git a/src/openvpn/=
tun=2Eh b/src/openvpn/tun=2Eh</span><br><span>index 7340e7e=2E=2E61fe943 10=
0644</span><br><span>--- a/src/openvpn/tun=2Eh</span><br><span>+++ b/src/op=
envpn/tun=2Eh</span><br><span>@@ -272,9 +272,9 @@</span><br><span> </span><=
br><span> void close_tun_handle(struct tuntap *tt);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-ssize_t write_tun(struct tu=
ntap *tt, uint8_t *buf, int len);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ssize_t write_tun(const struct tuntap *tt, const uint8_t *buf=
, int len);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-ssize_t read_tun(struct tuntap *tt, uint8_t *buf, int len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t read_tun(const stru=
ct tuntap *tt, uint8_t *buf, int len);</span><br><span> </span><br><span> #=
ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span> void tuncfg(const char *d=
ev, const char *dev_type, const char *dev_node, int persist_mode,</span><br=
><span>@@ -293,7 +293,7 @@</span><br><span>                         const c=
har *ifconfig_ipv6_local_parm,     /* --ifconfig parm 1 / IPv6 */</span><br=
><span>                         int ifconfig_ipv6_netbits_parm,           /=
* --ifconfig parm 1 / bits */</span><br><span>                         cons=
t char *ifconfig_ipv6_remote_parm,    /* --ifconfig parm 2 / IPv6 */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        stru=
ct addrinfo *local_public, struct addrinfo *remote_public,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        const struct=
 addrinfo *local_public, const struct addrinfo *remote_public,</span><br><s=
pan>                         const bool strict_warn, struct env_set *es, op=
envpn_net_ctx_t *ctx,</span><br><span>                         struct tunta=
p *tt);</span><br><span> </span><br><span>@@ -320,7 +320,7 @@</span><br><sp=
an>  * @param tt    the tuntap interface context</span><br><span>  * @param=
 ctx   the networking API opaque context</span><br><span>  */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void undo_ifconfig(struct tuntap *t=
t, openvpn_net_ctx_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void undo_ifconfig(const struct tuntap *tt, openvpn_net_ctx_t *ctx)=
;</span><br><span> </span><br><span> bool is_dev_type(const char *dev, cons=
t char *dev_type, const char *match_type);</span><br><span> </span><br><spa=
n>@@ -351,7 +351,7 @@</span><br><span> #define IFCONFIG_DEFAULT IFCONFIG_AF=
TER_TUN_OPEN</span><br><span> </span><br><span> static inline int</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(struct tuntap *t=
t)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_order(co=
nst struct tuntap *tt)</span><br><span> {</span><br><span>     if (tt-&gt;b=
ackend_driver =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>=
@@ -381,7 +381,7 @@</span><br><span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTE=
R_TUN</span><br><span> </span><br><span> static inline int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-route_order(struct tuntap *tt)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+route_order(const struct tu=
ntap *tt)</span><br><span> {</span><br><span>     if (tt-&gt;backend_driver=
 =3D=3D DRIVER_AFUNIX)</span><br><span>     {</span><br><span>@@ -454,13 +4=
54,13 @@</span><br><span> </span><br><span> const char *tap_win_getinfo(con=
st struct tuntap *tt, struct gc_arena *gc);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-void tun_show_debug(struct tuntap *=
tt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tun_show_d=
ebug(const struct tuntap *tt);</span><br><span> </span><br><span> bool dhcp=
_release_by_adapter_index(const DWORD adapter_index);</span><br><span> </sp=
an><br><span> bool dhcp_renew_by_adapter_index(const DWORD adapter_index);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void=
 fork_register_dns_action(struct tuntap *tt);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void fork_register_dns_action(const struct tuntap=
 *tt);</span><br><span> </span><br><span> void ipconfig_register_dns(const =
struct env_set *es);</span><br><span> </span><br><span>@@ -470,7 +470,7 @@<=
/span><br><span> </span><br><span> int tun_read_queue(struct tuntap *tt, in=
t maxsize);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-int tun_write_queue(struct tuntap *tt, struct buffer *buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+int tun_write_queue(struct =
tuntap *tt, const struct buffer *buf);</span><br><span> </span><br><span> s=
tatic inline bool</span><br><span> tuntap_stop(int status)</span><br><span>=
@@ -499,7 +499,7 @@</span><br><span>     return false;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-int t=
un_write_win32(struct tuntap *tt, struct buffer *buf);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+int tun_write_win32(struct tuntap *tt, c=
onst struct buffer *buf);</span><br><span> </span><br><span> static inline =
bool</span><br><span> is_ip_packet_valid(const struct buffer *buf)</span><b=
r><span>@@ -529,19 +529,21 @@</span><br><span> }</span><br><span> </span><b=
r><span> static inline bool</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-tuntap_is_dco_win(struct tuntap *tt)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+tuntap_is_dco_win(const struct tuntap *tt)</span><br=
><span> {</span><br><span>     return tt &amp;&amp; tt-&gt;backend_driver =
=3D=3D DRIVER_DCO;</span><br><span> }</span><br><span> </span><br><span> st=
atic inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tunta=
p_is_dco_win_timeout(struct tuntap *tt, ssize_t status)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct =
tuntap *tt, ssize_t status)</span><br><span> {</span><br><span>     return =
tuntap_is_dco_win(tt) &amp;&amp; (status &lt; 0) &amp;&amp; (openvpn_errno(=
) =3D=3D ERROR_NETNAME_DELETED);</span><br><span> }</span><br><span> </span=
><br><span> #else  /* ifdef _WIN32 */</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-begin constParamet=
erPointer ; stubs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> static inline bool</span><br><span> tuntap_stop(int status)=
</span><br><span> {</span><br><span>@@ -565,19 +567,20 @@</span><br><span> =
    return true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline bool</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco_win(struct tun=
tap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_is_d=
co_win(const struct tuntap *tt)</span><br><span> {</span><br><span>     ret=
urn false;</span><br><span> }</span><br><span> </span><br><span> static inl=
ine bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_is_dco=
_win_timeout(struct tuntap *tt, ssize_t status)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+tuntap_is_dco_win_timeout(const struct tuntap *=
tt, ssize_t status)</span><br><span> {</span><br><span>     return false;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+// cppcheck-suppress-end constParameterPointer</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifde=
f _WIN32 */</span><br><span> </span><br><span> /*</span><br><span>diff --gi=
t a/src/openvpn/tun_afunix=2Ec b/src/openvpn/tun_afunix=2Ec</span><br><span=
>index f494d42=2E=2E79d706a 100644</span><br><span>--- a/src/openvpn/tun_af=
unix=2Ec</span><br><span>+++ b/src/openvpn/tun_afunix=2Ec</span><br><span>@=
@ -49,7 +49,7 @@</span><br><span> </span><br><span> </span><br><span> stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tun_afunix_exec=
_child(const char *dev_node, struct tuntap *tt, struct env_set *env)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_exec_child(cons=
t char *dev_node, struct tuntap *tt, const struct env_set *env)</span><br><=
span> {</span><br><span>     const char *msgprefix =3D &quot;ERROR: failure=
 executing process for tun:&quot;;</span><br><span>     struct argv argv =
=3D argv_new();</span><br><span>@@ -74,7 +74,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-open_tun_afunix(struct options *o, int mtu, struct tuntap *tt, =
struct env_set *orig_env)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+open_tun_afunix(const struct options *o, int mtu, struct tuntap *tt, =
const struct env_set *orig_env)</span><br><span> {</span><br><span>     str=
uct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>@@ -146,7 +=
146,7 @@</span><br><span> }</span><br><span> </span><br><span> ssize_t</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-write_tun_afunix(struct tu=
ntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+write_tun_afunix(struct tuntap *tt, const uint8_t *buf, int le=
n)</span><br><span> {</span><br><span>     const char *msg =3D &quot;ERROR:=
 failure during write to AF_UNIX socket: &quot;;</span><br><span>     if (!=
openvpn_waitpid_check(tt-&gt;afunix=2Echildprocess, msg, M_WARN))</span><br=
><span>@@ -172,8 +172,11 @@</span><br><span>     return read(tt-&gt;fd, buf=
, len);</span><br><span> }</span><br><span> #else  /* ifndef WIN32 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+// cppcheck-suppress-begin constParameterPoi=
nter ; stubs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-open_t=
un_afunix(struct options *o, int mtu, struct tuntap *tt, struct env_set *or=
ig_env)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_afu=
nix(const struct options *o, int mtu, struct tuntap *tt, const struct env_s=
et *orig_env)</span><br><span> {</span><br><span>     msg(M_ERR, &quot;AF_U=
NIX socket support not available on this platform&quot;);</span><br><span> =
}</span><br><span>@@ -186,7 +189,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> ssize_t</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+write_tun_afunix(struct tuntap *t=
t, const uint8_t *buf, int len)</span><br><span> {</span><br><span>     /* =
should never be called as open_tun_afunix always fails */</span><br><span> =
    ASSERT(0);</span><br><span>@@ -199,4 +202,6 @@</span><br><span>     ASS=
ERT(0);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+// cppcheck-suppress-end constParameterPointer</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endi=
f /* ifndef WIN32 */</span><br><span>diff --git a/src/openvpn/tun_afunix=2E=
h b/src/openvpn/tun_afunix=2Eh</span><br><span>index 5b6a8e0=2E=2E5307e31 1=
00644</span><br><span>--- a/src/openvpn/tun_afunix=2Eh</span><br><span>+++ =
b/src/openvpn/tun_afunix=2Eh</span><br><span>@@ -31,7 +31,7 @@</span><br><s=
pan>  * the user provided taking care of implementing the actual tun</span>=
<br><span>  * device=2E</span><br><span>  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-void open_tun_afunix(struct options *o, int mtu, str=
uct tuntap *tt, struct env_set *env);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void open_tun_afunix(const struct options *o, int mtu, st=
ruct tuntap *tt, const struct env_set *env);</span><br><span> </span><br><s=
pan> </span><br><span> /**</span><br><span>@@ -43,7 +43,7 @@</span><br><spa=
n> /**</span><br><span>  * Writes a packet to a AF_UNIX based tun device=2E=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
ssize_t write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t write_tun_afunix(st=
ruct tuntap *tt, const uint8_t *buf, int len);</span><br><span> </span><br>=
<span> /**</span><br><span>  * Reads a packet from a AF_UNIX based tun devi=
ce=2E</span><br><span>diff --git a/src/openvpn/vlan=2Ec b/src/openvpn/vlan=
=2Ec</span><br><span>index 69ac10d=2E=2E04e18d6 100644</span><br><span>--- =
a/src/openvpn/vlan=2Ec</span><br><span>+++ b/src/openvpn/vlan=2Ec</span><br=
><span>@@ -288,7 +288,7 @@</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-vlan_proces=
s_outgoing_tun(struct multi_context *m, struct multi_instance *mi)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+vlan_process_outgoing_tun(co=
nst struct multi_context *m, struct multi_instance *mi)</span><br><span> {<=
/span><br><span>     if (!m-&gt;top=2Eoptions=2Evlan_tagging)</span><br><sp=
an>     {</span><br><span>diff --git a/src/openvpn/vlan=2Eh b/src/openvpn/v=
lan=2Eh</span><br><span>index 9389f89=2E=2Ecd2f66f 100644</span><br><span>-=
-- a/src/openvpn/vlan=2Eh</span><br><span>+++ b/src/openvpn/vlan=2Eh</span>=
<br><span>@@ -35,6 +35,6 @@</span><br><span> </span><br><span> bool vlan_is=
_tagged(const struct buffer *buf);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void vlan_process_outgoing_tun(struct multi=
_context *m, struct multi_instance *mi);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void vlan_process_outgoing_tun(const struct multi_cont=
ext *m, struct multi_instance *mi);</span><br><span> </span><br><span> #end=
if /* VLAN_H */</span><br><span>diff --git a/src/openvpn/win32=2Eh b/src/op=
envpn/win32=2Eh</span><br><span>index 8be3d96=2E=2E39ff7d8 100644</span><br=
><span>--- a/src/openvpn/win32=2Eh</span><br><span>+++ b/src/openvpn/win32=
=2Eh</span><br><span>@@ -227,7 +227,7 @@</span><br><span> void overlapped_i=
o_close(struct overlapped_io *o);</span><br><span> </span><br><span> static=
 inline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-overlappe=
d_io_active(struct overlapped_io *o)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+overlapped_io_active(const struct overlapped_io *o)</span>=
<br><span> {</span><br><span>     return o-&gt;iostate =3D=3D IOSTATE_QUEUE=
D || o-&gt;iostate =3D=3D IOSTATE_IMMEDIATE_RETURN;</span><br><span> }</spa=
n><br><span>diff --git a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsi=
ca/openvpnmsica=2Ec</span><br><span>index 1a17d95=2E=2Ed2fd9af 100644</span=
><br><span>--- a/src/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/sr=
c/openvpnmsica/openvpnmsica=2Ec</span><br><span>@@ -77,7 +77,7 @@</span><br=
><span>  * @return ERROR_SUCCESS on success; An error code otherwise</span>=
<br><span>  */</span><br><span> static UINT</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LPCWST=
R szProperty, _In_ struct msica_arg_seq *seq)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+setup_sequence(_In_ MSIHANDLE hInstall, _In_z_ LP=
CWSTR szProperty, _In_ const struct msica_arg_seq *seq)</span><br><span> {<=
/span><br><span>     UINT uiResult;</span><br><span>     LPWSTR szSequence =
=3D msica_arg_seq_join(seq);</span><br><span>diff --git a/src/openvpnserv/i=
nteractive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 9a68=
bbb=2E=2Ed8cf6e1 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -522,7 +522,7 @@</span><br><span> </span><br><span> </span><br><span> st=
atic SOCKADDR_INET</span><br><span style=3D"color: hsl(0, 100%, 40%);">-soc=
kaddr_inet(short family, inet_address_t *addr)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+sockaddr_inet(short family, const inet_address_t=
 *addr)</span><br><span> {</span><br><span>     SOCKADDR_INET sa_inet;</spa=
n><br><span>     ZeroMemory(&amp;sa_inet, sizeof(sa_inet));</span><br><span=
>diff --git a/tests/unit_tests/openvpn/mock_management=2Ec b/tests/unit_tes=
ts/openvpn/mock_management=2Ec</span><br><span>index 77f6ce2=2E=2Efff4c2b 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/mock_management=2Ec</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/mock_management=2Ec</span><br>=
<span>@@ -36,7 +36,7 @@</span><br><span> struct management *management; /* =
GLOBAL */</span><br><span> </span><br><span> void</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-management_auth_failure(struct management *man,=
 const char *type, const char *reason)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_auth_failure(const struct management *man, co=
nst char *type, const char *reason)</span><br><span> {</span><br><span>    =
 ASSERT(false);</span><br><span> }</span><br><span>diff --git a/tests/unit_=
tests/openvpn/siphash_openssl=2Ec b/tests/unit_tests/openvpn/siphash_openss=
l=2Ec</span><br><span>index 52f13b8=2E=2Ee7282b2 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>+++ b/tests=
/unit_tests/openvpn/siphash_openssl=2Ec</span><br><span>@@ -100,7 +100,7 @@=
</span><br><span> }</span><br><span> </span><br><span> bool</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-siphash_openssl_available(void *sip_c=
ontext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+siphash_open=
ssl_available(const void *sip_context)</span><br><span> {</span><br><span> =
    const struct siphash_context *sip =3D sip_context;</span><br><span> </s=
pan><br><span>@@ -117,6 +117,8 @@</span><br><span> }</span><br><span> #else=
</span><br><span> /* Do avoid a lot more ifdefs in the test we put dummy fu=
nctions here */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+// c=
ppcheck-suppress-begin constParameterPointer ; stubs</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> si=
phash_openssl(void *sip_context, const void *in, const size_t inlen,</span>=
<br><span>                 const void *k, uint8_t *out, const size_t outlen=
)</span><br><span>@@ -125,7 +127,7 @@</span><br><span> }</span><br><span> <=
/span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
siphash_openssl_available(void *sip_context)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+siphash_openssl_available(const void *sip_context)=
</span><br><span> {</span><br><span>     return false;</span><br><span> }</=
span><br><span>@@ -141,5 +143,6 @@</span><br><span> {</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+// c=
ppcheck-suppress-end constParameterPointer</span><br><span> </span><br><spa=
n> #endif /* if defined(ENABLE_CRYPTO_OPENSSL) &amp;&amp; OPENSSL_VERSION_N=
UMBER &gt;=3D 0x30000000L */</span><br><span>diff --git a/tests/unit_tests/=
openvpn/siphash_openssl=2Eh b/tests/unit_tests/openvpn/siphash_openssl=2Eh<=
/span><br><span>index 0f1d329=2E=2Ea44457e 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/siphash_openssl=2Eh</span><br><span>+++ b/tests/unit_=
tests/openvpn/siphash_openssl=2Eh</span><br><span>@@ -60,5 +60,5 @@</span><=
br><span>  *</span><br><span>  */</span><br><span> bool</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-siphash_openssl_available(void *sip_conte=
xt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef =
SIPHASH_OPENSSL_H */</span><br><span>\ No newline at end of file</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+siphash_openssl_available(cons=
t void *sip_context);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif /* ifndef SIPHASH_OPENSSL_H */</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</=
span><br><span>index a41c27b=2E=2Ea8daee6 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_misc=2Ec</span><br><span>@@ -146,7 +146,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static struct hash_element *</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-hash_lookup_by_value(struct hash=
 *hash, void *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+hash_lookup_by_value(struct hash *hash, const void *value)</span><br><span=
> {</span><br><span>     struct hash_iterator hi;</span><br><span>     stru=
ct hash_element *he;</span><br><span>diff --git a/tests/unit_tests/openvpn/=
test_user_pass=2Ec b/tests/unit_tests/openvpn/test_user_pass=2Ec</span><br>=
<span>index c0a0866=2E=2E7636a33 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_user_pass=2Ec</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_user_pass=2Ec</span><br><span>@@ -59,7 +59,7 @@</span><br><span>   =
  return mock();</span><br><span> }</span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-management_auth_failure(struct manageme=
nt *man, const char *type, const char *reason)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+management_auth_failure(const struct management =
*man, const char *type, const char *reason)</span><br><span> {</span><br><s=
pan>     assert_true(0);</span><br><span> }</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">=
change 1663</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/166=
3?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 31 </div>
<div style=3D"display:none"> Gerrit-Owner: Fr=
ank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &l=
t;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@m=
ailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>

</body></html>
--rpnYIPKniVw=--


--===============3134488263388296521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3134488263388296521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3134488263388296521==--

