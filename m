Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA09FC44507
	for <openvpn-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XtAU6GQBxbo80bZphmOWG0Zs7CmDn2qOcCOxoUYI+Jc=; b=I7uQNIKY0LXTg2H8vTpHiNMcfG
	SnmJ3SoQHUX+ZDzxdcG5lZbOnBzVt0gGjbvNtpNUvLh5k4w7rQQU745tFbdmxK8qNI2kiuBknKeow
	kfucfQxBJv0igcub0HGDDByHfuydU8NSyocAPgbS7a94QGXkkwxAiFHniJE0bETOp+vE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjIzK-0005Zl-6W;
	Mon, 13 Jul 2026 15:54:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjIzI-0005Zd-M3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:54:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Cx1OCP+DSR7oqGSZDdaeDQ1bl4ZqoxmvbzZFsEmBDu8=; b=R5IF58JJrrG5soNgU0kfo5iX6c
 Yhz+w7qyi7PrOYAZLgaZea+ZiX8RlUmjv+aADm2fVwTOt6NZwc1IhXCelYQmdoCqU5TfK4B+vNpYx
 cVpg+TYE8GVPZMwp11XyNaW/TyVYMoV9k+VhoM6mxJWotvcnf8wfr/tYGAByEwKvv2MQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Cx1OCP+DSR7oqGSZDdaeDQ1bl4ZqoxmvbzZFsEmBDu8=; b=W
 +9wtcRq34eV3EEyKSxmIxkiZOe5iktBKaz2j0+nIQiP4m+eMT79SaFQ31gx+x6p20pGgSQHKEHHsK
 NiutTbtc/Lmi4nQW6IpQwlSi7ODvmJwe/V+IhzAg4BJeMLU5B8jhmSVn0qbRVJrlHFPIOjNjv7Z/g
 0VzDirw+LqZfZ23s=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjIzG-0004HH-24 for openvpn-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 15:54:33 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47362928f65so3224028f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 13 Jul 2026 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783958063; x=1784562863; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Cx1OCP+DSR7oqGSZDdaeDQ1bl4ZqoxmvbzZFsEmBDu8=;
 b=UhWuwpI2iARMJYvBHAM08nl+UJq5fd8JdkeauqDUgRMWoFjJlQ1QBt2Lr/U9IZyKhp
 ww5g09CcoV9OB0ck0DZ0gnw/+PMFCFzUK53sKTTAmVYIz5nvZ8HWxGqzUllzX8SyUyvD
 klo2mZ94zylkxmobDJOyxnOWklCNmRZAdcVRiUlGFka5JWk7HU2i180INYVdBByo0Co2
 2qh+1ne49atVF215SALCFm4YNCfHZyphfriW42tw6qjCi5nZ3VTC+9YqdnPVciYbNQsR
 SmLFQ8Evd+ue7Cmsqb/1BSxsJHrwgldgdss/ZUPEQ34JhcHBFi6nBp9dfXbU8YExjDo8
 yXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783958063; x=1784562863;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Cx1OCP+DSR7oqGSZDdaeDQ1bl4ZqoxmvbzZFsEmBDu8=;
 b=Zi4yFHUZ6GXvO6Hwb5/JuQxee77VYVs7HI4hy+JExIsLmfODOg7ihkXOHw//D25WyA
 M9YQxuW6712pjd49TiTT/XlJCkamBLYk4+b9rogaVPTmeOIZXGe7JmZ7cu+B/zjDWdPL
 cmX6NUBF4OnnDcR5+wh7BvbU3DqbjG7r2hlzY8Af86Yx65TGmITsezgIlZAmbO1MEG6f
 BIYhc1sxi4GvIINoeDvZHvgY7hKrJ33T8zLM2sZCfh5bcSVjGAfAqbfpofDm+EnooGpT
 AAkUZKyNJyLAzDyZTLQn2Ec0Fd57UavhUy6OU+swowLww1oikUss2WrgrL0ASwJQ2aQA
 IAgw==
X-Gm-Message-State: AOJu0YzRBl0Ep/1hefKELZZZ4FJRvhj0/jj8+K/sWJRfsyNGfaoWoPov
 57mEjjYAIDntIdEbUxDhAGTCGNa4Ha3NqTiSWXcI/R6qD+Fbyvyf2yaQrh3uB1jZIDeTrFm/5Ug
 0K84DO2YZfH4AEbVDA7wuScKMMxVDO2WdOiEs/IZIzzvewPNI+4EhUXHnXApvGA/H3jMDToF2jx
 6jZygPPw==
X-Gm-Gg: AfdE7cmRixzEPSJT6Gd0KZgSSGGTv1nSiR4198OqGmn+K0WdOc88l+7GOh63D29ltiW
 RtwJ5Di1JFhqDgpS4fKMaKnvI67QzoaXeUbNQTWhJenchapfeVZoEXUTLthRzVKNPyLXnFiaB0Z
 w0C2sjoYisxmDfZP9ciK6tvuJdhHw1uQdfdAdlAPpUwQcghKz5LBdFsrelBWjd3tmpojvy0MoFH
 uFl85EZoVZFtgKG86vPpRYy1CPLuWTCMvWqFchkax3h3ishMhdH7bae/Qwrjl7oQ4efOt76CxLi
 DhhkobJPHskvOalTD89iW34pvNnXiLDGENQk6Di9KUt8Yisb5SkOQCIbrEcwlXnuSw5HMH73KN3
 9U4uqrOVt5zYk5jOSVH3kkwTYIzHVNZctvTFSV6O09eshfOSnOhCca7UjsS2eDQZNRwSXICCysd
 Qnl4wpCinsPFXsmxj0xRdoQ7Hjy2hMWYLE5/cjwBkPRNfeW5InoOWsFwOVRkr1RCTKj6q7MCnlG
 ttcOyRKjVC+7yb8R5TSi4amFKXCy3q7QMNIeRNAenK6GDHfnim/3sCW/IA+bx5GJd8sn0Zyo26L
 PDFhmpYtaNuQwA==
X-Received: by 2002:a05:6000:1a86:b0:46f:f12b:e44b with SMTP id
 ffacd0b85a97d-47f2dcd7193mr12661340f8f.31.1783958063394; 
 Mon, 13 Jul 2026 08:54:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634debesm339021f8f.8.2026.07.13.08.54.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:54:22 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 13 Jul 2026 15:54:21 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
X-Gerrit-Change-Number: 1739
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1739?usp=email>
X-Gerrit-Commit: 2c2fec4a965cf046b3d71b3250f8d84f6af81b89
In-Reply-To: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
References: <gerrit.1782719911000.Icc14b286f2409738c73873aa7550dcc005ee8cbb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljYzE0YjI4NmYyNDA5NzM4YzczODczYWE3NTUwZGNjMDA1ZWU4Y2JiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e4120d3efb93022c27bec8b6281324f7ca0503cf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjIzG-0004HH-24
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CMake: detect
 cmocka_version.h via include path, not by linking
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1015944289688353412=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1015944289688353412==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uyRgh7YExgc="; charset=UTF-8

--uyRgh7YExgc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by flic=
htenheld


Change subject: CMake: detect cmocka_version=2Eh via include pat=
h, not by linking
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

CMake: detect cmocka_version=2Eh via include path, not by linking

che=
ck_include_files() was invoked with cmocka in CMAKE_REQUIRED_LIBRARIES,
whi=
ch makes the probe link the (shared, imported) cmocka library=2E On some
pl=
atforms that link step fails inside the minimal probe, so the header check
=
reports failure and HAVE_CMOCKA_VERSION_H is left undefined even though
cmo=
cka_version=2Eh is present=2E

test_common=2Eh then selects its cmocka 1=2E=
x compatibility shims and redefines
macros (check_expected_uint, expect_uin=
t_value, =2E=2E=2E) that cmocka 2=2Ex already
provides, which breaks the -W=
error build of every unit test driver=2E

Detecting a header only needs the=
 include search path, so pass cmocka's
INTERFACE_INCLUDE_DIRECTORIES via CM=
AKE_REQUIRED_INCLUDES and drop the library
link requirement from the probe=
=2E

Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
Signed-off-by: Le=
v Stipakov <lev@openvpn=2Enet>
Acked-by: Frank Lichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739
Messa=
ge-Id: <20260709144240=2E61362-1-frank@lichtenheld=2Ecom>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37552=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=
=2Etxt
1 file changed, 9 insertions(+), 1 deletion(-)


  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/39/1739/2

diff --git a/CMa=
keLists=2Etxt b/CMakeLists=2Etxt
index 4779d69=2E=2E8de836a 100644
--- a/CM=
akeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -385,12 +385,20 @@
     find_packa=
ge(cmocka CONFIG)
     if (TARGET cmocka::cmocka)
         set(CMOCKA_LIBRA=
RIES cmocka::cmocka)
+        get_target_property(CMOCKA_INCLUDE_DIRS cmock=
a::cmocka INTERFACE_INCLUDE_DIRECTORIES)
     else ()
         pkg_search_m=
odule(cmocka cmocka REQUIRED IMPORTED_TARGET)
         set(CMOCKA_LIBRARIES=
 PkgConfig::cmocka)
+        set(CMOCKA_INCLUDE_DIRS ${cmocka_INCLUDE_DIRS}=
)
     endif ()
-    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES})
+   =
 # cmocka_version=2Eh exists since cmocka 2=2E0; its absence selects the
+ =
   # cmocka 1=2Ex compat shims in test_common=2Eh=2E Detecting a header onl=
y needs
+    # the include path - do NOT add cmocka to CMAKE_REQUIRED_LIBRA=
RIES, as that
+    # makes check_include_files link the shared library, whi=
ch can fail in the
+    # probe for unrelated reasons and wrongly mis-detec=
t cmocka 2=2Ex as < 2=2E0=2E
+    set(CMAKE_REQUIRED_INCLUDES ${CMOCKA_INCL=
UDE_DIRS})
     check_include_files(cmocka_version=2Eh HAVE_CMOCKA_VERSION_=
H)
+    unset(CMAKE_REQUIRED_INCLUDES)
 endif ()
 
 configure_file(config=
=2Eh=2Ecmake=2Ein config=2Eh)

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1739?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Icc14b286f2409738c73873aa7550dcc005ee8cbb
Gerrit-Change-Numb=
er: 1739
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ger=
rit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plais=
thos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--uyRgh7YExgc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by stipa=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">CMake: detect cmocka_versi=
on=2Eh via include path, not by linking<br><br>check_include_files() was in=
voked with cmocka in CMAKE_REQUIRED_LIBRARIES,<br>which makes the probe lin=
k the (shared, imported) cmocka library=2E On some<br>platforms that link s=
tep fails inside the minimal probe, so the header check<br>reports failure =
and HAVE_CMOCKA_VERSION_H is left undefined even though<br>cmocka_version=
=2Eh is present=2E<br><br>test_common=2Eh then selects its cmocka 1=2Ex com=
patibility shims and redefines<br>macros (check_expected_uint, expect_uint_=
value, =2E=2E=2E) that cmocka 2=2Ex already<br>provides, which breaks the -=
Werror build of every unit test driver=2E<br><br>Detecting a header only ne=
eds the include search path, so pass cmocka&#39;s<br>INTERFACE_INCLUDE_DIRE=
CTORIES via CMAKE_REQUIRED_INCLUDES and drop the library<br>link requiremen=
t from the probe=2E<br><br>Change-Id: Icc14b286f2409738c73873aa7550dcc005ee=
8cbb<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1739<br>Message-Id: &lt;20260709144240=2E6=
1362-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg37552=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<b=
r>1 file changed, 9 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/39/1739/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>i=
ndex 4779d69=2E=2E8de836a 100644</span><br><span>--- a/CMakeLists=2Etxt</sp=
an><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -385,12 +385,20 @@</=
span><br><span>     find_package(cmocka CONFIG)</span><br><span>     if (TA=
RGET cmocka::cmocka)</span><br><span>         set(CMOCKA_LIBRARIES cmocka::=
cmocka)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        get_=
target_property(CMOCKA_INCLUDE_DIRS cmocka::cmocka INTERFACE_INCLUDE_DIRECT=
ORIES)</span><br><span>     else ()</span><br><span>         pkg_search_mod=
ule(cmocka cmocka REQUIRED IMPORTED_TARGET)</span><br><span>         set(CM=
OCKA_LIBRARIES PkgConfig::cmocka)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        set(CMOCKA_INCLUDE_DIRS ${cmocka_INCLUDE_DIRS})</span=
><br><span>     endif ()</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES})</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    # cmocka_version=2Eh exists since =
cmocka 2=2E0; its absence selects the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    # cmocka 1=2Ex compat shims in test_common=2Eh=2E Det=
ecting a header only needs</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    # the include path - do NOT add cmocka to CMAKE_REQUIRED_LIBRARI=
ES, as that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # ma=
kes check_include_files link the shared library, which can fail in the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    # probe for unrelate=
d reasons and wrongly mis-detect cmocka 2=2Ex as &lt; 2=2E0=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    set(CMAKE_REQUIRED_INCLUDES =
${CMOCKA_INCLUDE_DIRS})</span><br><span>     check_include_files(cmocka_ver=
sion=2Eh HAVE_CMOCKA_VERSION_H)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    unset(CMAKE_REQUIRED_INCLUDES)</span><br><span> endif ()</s=
pan><br><span> </span><br><span> configure_file(config=2Eh=2Ecmake=2Ein con=
fig=2Eh)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail">change 1739</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1739?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc14b286=
f2409738c73873aa7550dcc005ee8cbb </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1739 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>

</body></html>
--uyRgh7YExgc=--


--===============1015944289688353412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1015944289688353412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1015944289688353412==--

