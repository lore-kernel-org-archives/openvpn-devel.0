Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C6B606A326
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QUmfzz77;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lK9ilS2I;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YTJ8mXeV;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=M9iKh4ry
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4mmg0SKX+qDIL50qjNgtM8GJwrkJ6VGidzb1tgshEig=; b=QUmfzz77q3+rHD00Yq/xkO2Gwr
	uaEfh/Tbc1pWMAu+MQ40T1/KrbonJonXy5T9A9ZfJ4BKfwobPpI4gSfsuWNPRegRGKixJ0SAGwSrG
	/B5dYjJJ3JpOqDdTwYDnrmnGaFBT25yVu8hFGIpH0oMsDYe9ucg0Spz21oKWGqg8OBYA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMI9-000000001pp-2IXF;
	Fri, 20 Nov 2026 10:56:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMI8-000000001oC-1b7m
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T/06DBhP1I1J44/6Wv5izMstf80X46ohOFLXRI6IcBE=; b=lK9ilS2IM5CMe91IaIsa/uih5+
 f2r/cWGFNju1NOpaLJF6VRkG+K8BbhTD7SmBX3iMMMGa9AfneOpxg9jQ9B2QRCZz2je6RrG0kMUv0
 hS1dXXHH6TvPgSHaYvmkvrXq1x3CODBUY/oz/W9W/JkdPVofYMcjfDJ4XZu0fUdvpZL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T/06DBhP1I1J44/6Wv5izMstf80X46ohOFLXRI6IcBE=; b=YTJ8mXeVdXq130ECw0Md1HdAJZ
 FEo78oYLUmqC8t0ikGlqKrNJg4Pm75Rd3IBoiILLawvGWpiWQHW0f7j9pAzzNlRmt74rgGrvjv2uN
 AyfVcYCtEyfrSuVSWh+1lYfd8xxmw3xPDyRlbLiR3JpZiitE/OtMUmkjj9HyFuM3ZAY4=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMI7-000000005nN-20km for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:56:28 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48e09aa5264so363569f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795172181; x=1795776981; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T/06DBhP1I1J44/6Wv5izMstf80X46ohOFLXRI6IcBE=;
 b=M9iKh4rycHIgcZC3kAz3GFQsO4fh7MKQvRJokbdCdl9GWqAApOR/lZYheYq9eP+zoJ
 zTmuaRfcD2uU7Qy1RWiXxcSUffu3L8JvrrJ9WGdYJnd/rReERPf55uKktuIGOlreS5Fe
 3BEoleOeUcs5FKOWIvWRO46fGYaWjjo1C9L1Q0bcFZ1Iq9tnpvPEIG8G9WZe1zmJ5CcM
 JGeASVPtmE6ZGOLa2jErCQNhR/iatFq/sd5rEloO6WvMcLs14VURYa4nhkfMAOs7ovk0
 sKsCyb/VGMtJWxn4SENKjGuyLMHYnCWMbIpNWIfT+yy4IVgP2nuB7adio/LjBQWOxh37
 NHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795172181; x=1795776981;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=T/06DBhP1I1J44/6Wv5izMstf80X46ohOFLXRI6IcBE=;
 b=VV0zOkE2SktyK8D9xmDFiMl+6ohcweLZIet8kWvZfCs6zYrYM6UKC5Cw0VM+daTPp6
 mSuWnU/jfwm8FPFvBAXAzbDrZG4jLAdH8eQLT2ydjK6z/8Uixt3q2vZ6EcZ9iHjw0p25
 fAQbr9hl7rv86xTdRK6YU44mpR8VgIa52j+k1en1RV2DZADg1tDFnKk3Bqqh0oRkVHSc
 2jI03oHFrIcEcDN36THHygZfkMr00gU4VgRxywnz1TzMEQWrnm46d9Gfxm8JSC1RAYj7
 aKZ3VZP8S9LElyuFeVrjRtODqL4itapMlf5Pz7QNcLvePvi2O59xVVECAg+IIHZZ/O1u
 KBVA==
X-Gm-Message-State: APuU4Z9VpkMYJoFGO2EZIm400qxHl+UPCPSrqHNcbigRUWLBsZAziLA1
 AGnfsnoRj5kwOMKn488uyxsfibzYky8OLO+mbKLU0rE6P7avhCX9hxMpM27q14XO3qHyz9QckAV
 SF71vmacCRHjXNAVb7JO+jr16jR38p9XqVTBPAVvWs9pqcPgQO4UR4M6XaxcxC/Xi7QbN
X-Gm-Gg: AYBFou25UXarAc0VBWxBYjViH2HaRN5fW8G/uGZgdnfLt+Fxf5hhW+5WLvRGLWo9aik
 a6hhJvn2tHClJbPqvGXxrFipTJVLpjW7H6J9UVi4HckU1bExkI12GzsCCrI1a/kzCGdp7gVXvyN
 JHdAHcVRZcVudWKpdioziuvViNGz8l8rrj35DgiIZ+PocezWOB9BfBq03FdC6mfuSHdveSgms31
 VFsK1mVbZ164daasLqgFfst/eA44eq8SwGhDCEiz+02FKyvQAsxRkIzKgevVbK763ewWTEGem6Y
 kQ8KRT4LmZgVtJOnCTv1jQ94/LPjF6QBtrgi02w9fQgaMIYEgpeEBHomWDUupNGFhaNphBUBy7z
 QLn9aBqCoOjr94+4IETh/JfwrpK8pbRZk1StbORuZF7Xaca2Xdb0192Emud66sXQxULntQNQjoV
 7KMEWb56glD3h36U4M50StTC/Wa6TC7rz1uIy2iTncPvyaa0x3j/AT2WSU0bqlYSNcGH1iICkBZ
 giWrmogCJzhjaaQtHMT9yxLH9PvrEdfqsTUCH/6sv5kMOqyCKfah676l58GIlnm5Pgh0ZnPpIXb
 MIe0fR9iDweORbvL8xjZhLxs9ZWfWjFVbU6eXqLoViIbFYD2/pMhLOGb4ofa+Ik5CiY/tZSIlIJ
 7nqfmqzdZ4x3Riv1j+Ax5JPUDoQmHy07smhgoHP1y77oZJdvKVN6kYUGr1O+7nWpNxOcq8vvjuw
 qrHHEKGy6NTI2ICDs=
X-Received: by 2002:a05:600c:1c1a:b0:4bb:7292:b871 with SMTP id
 5b1f17b1804b1-4bb888108ffmr60659215e9.14.1795172179672; 
 Fri, 20 Nov 2026 02:56:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88442995sm83559525e9.2.2026.11.20.02.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:56:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:56:18 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Lev Stipakov <lstipakov@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
X-Gerrit-Change-Number: 2223
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2223?usp=email>
X-Gerrit-Commit: 297cbcc1633e5259d0455124af574fecc436c53a
In-Reply-To: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
References: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc1NjAxMDAwLkkzZDVjYWFiMzIxMGI2NTU1MWUyZjJmZjhmNmUyZWRiNTAwMjJlNGJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f755f766a32d4fb54788f8b2f56477aaa7ea3aad-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMI7-000000005nN-20km
Subject: [Openvpn-devel] [S] Change in openvpn[master]: sample-plugins: drop
 broken defer and log winbuild scripts
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3953673837349738725=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3953673837349738725==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F0SrR8rh92w="; charset=UTF-8

--F0SrR8rh92w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2223?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Lev Stipakov


Change subject: sample-plugins: drop brok=
en defer and log winbuild scripts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

sample-plugins: drop broken defer and log winbuild s=
cripts

Both need a $1=2Edef that doesn't exist in their directory=2E

defe=
r/simple=2Ec and its =2Edef were removed in d816207b ("plugins:
Remove defe=
r/simple=2Ec sample plugin"); the remaining multi-auth=2Ec
uses fork() and =
doesn't build on Windows=2E log/winbuild came from
the examples/ -> log/ re=
name and never had a =2Edef there=2E

log=2Ec builds on Windows with a plai=
n "gcc -shared", since
OPENVPN_EXPORT already marks the entry points __decl=
spec(dllexport)=2E

Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
Si=
gned-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev Stipakov=
 <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2223
Message-Id: <20261119130456=2E20423-1-gert@greenie=2Emuc=2Ede>
UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg41679=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
=
D sample/sample-plugins/defer/winbuild
D sample/sample-plugins/log/winbuild=

2 files changed, 0 insertions(+), 36 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/23/2223/2

diff --git a/sample=
/sample-plugins/defer/winbuild b/sample/sample-plugins/defer/winbuild
delet=
ed file mode 100755
index 82927d9=2E=2E0000000
--- a/sample/sample-plugins/=
defer/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin=
 module on Windows/MinGW=2E
-# The argument should be the base name of the =
C source file
-# (without the =2Ec)=2E
-#
-
-# This directory is where we w=
ill look for openvpn-plugin=2Eh
-INCLUDE=3D"-I=2E=2E/=2E=2E/=2E=2E/build"
-=

-CC_FLAGS=3D"-O2 -Wall"
-
-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1=2Ec
-g=
cc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk=2Etmp -Wl,--base-file,=
base=2Etmp $1=2Eo
-rm junk=2Etmp
-dlltool --dllname $1=2Edll --base-file ba=
se=2Etmp --output-exp temp=2Eexp --input-def $1=2Edef
-rm base=2Etmp
-gcc -=
-enable-stdcall-fixup -mdll -DBUILD_DLL -o $1=2Edll $1=2Eo -Wl,temp=2Eexp
-=
rm temp=2Eexp
diff --git a/sample/sample-plugins/log/winbuild b/sample/samp=
le-plugins/log/winbuild
deleted file mode 100755
index decf05f=2E=2E0000000=

--- a/sample/sample-plugins/log/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#=

-# Build an OpenVPN plugin module on Windows/MinGW=2E
-# The argument shou=
ld be the base name of the C source file
-# (without the =2Ec)=2E
-#
-
-# T=
his directory is where we will look for openvpn-plugin=2Eh
-INCLUDE=3D"-I=
=2E=2E/=2E=2E/=2E=2E/include"
-
-CC_FLAGS=3D"-O2 -Wall"
-
-gcc -DBUILD_DLL =
$CC_FLAGS $INCLUDE -c $1=2Ec
-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL=
 -o junk=2Etmp -Wl,--base-file,base=2Etmp $1=2Eo
-rm junk=2Etmp
-dlltool --=
dllname $1=2Edll --base-file base=2Etmp --output-exp temp=2Eexp --input-def=
 $1=2Edef
-rm base=2Etmp
-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $=
1=2Edll $1=2Eo -Wl,temp=2Eexp
-rm temp=2Eexp

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
Ge=
rrit-Change-Number: 2223
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--F0SrR8rh92w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2223?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Lev Stipakov</p><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">sam=
ple-plugins: drop broken defer and log winbuild scripts<br><br>Both need a =
$1=2Edef that doesn&#39;t exist in their directory=2E<br><br>defer/simple=
=2Ec and its =2Edef were removed in d816207b (&quot;plugins:<br>Remove defe=
r/simple=2Ec sample plugin&quot;); the remaining multi-auth=2Ec<br>uses for=
k() and doesn&#39;t build on Windows=2E log/winbuild came from<br>the examp=
les/ -&gt; log/ rename and never had a =2Edef there=2E<br><br>log=2Ec build=
s on Windows with a plain &quot;gcc -shared&quot;, since<br>OPENVPN_EXPORT =
already marks the entry points __declspec(dllexport)=2E<br><br>Change-Id: I=
3d5caab3210b65551e2f2ff8f6e2edb50022e4ba<br>Signed-off-by: Razvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=
=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223<b=
r>Message-Id: &lt;20261119130456=2E20423-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg41679=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>D sample/sample-plugins/defer/winbuild<br>D sample/sample-p=
lugins/log/winbuild<br>2 files changed, 0 insertions(+), 36 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/23/2223/2</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/sample/sample-plugins/defer/w=
inbuild b/sample/sample-plugins/defer/winbuild</span><br><span>deleted file=
 mode 100755</span><br><span>index 82927d9=2E=2E0000000</span><br><span>---=
 a/sample/sample-plugins/defer/winbuild</span><br><span>+++ /dev/null</span=
><br><span>@@ -1,18 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Build an Ope=
nVPN plugin module on Windows/MinGW=2E</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# The argument should be the base name of the C source fil=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# (without the =2Ec)=
=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# This directory is where we will look for openvpn-plugin=
=2Eh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-INCLUDE=3D&quot;-=
I=2E=2E/=2E=2E/=2E=2E/build&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CC_FLAGS=
=3D&quot;-O2 -Wall&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gcc -DBUILD_DLL $C=
C_FLAGS $INCLUDE -c $1=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o junk=2Etmp -Wl,--base=
-file,base=2Etmp $1=2Eo</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-rm junk=2Etmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dlltoo=
l --dllname $1=2Edll --base-file base=2Etmp --output-exp temp=2Eexp --input=
-def $1=2Edef</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm base=
=2Etmp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gcc --enable-st=
dcall-fixup -mdll -DBUILD_DLL -o $1=2Edll $1=2Eo -Wl,temp=2Eexp</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-rm temp=2Eexp</span><br><span>dif=
f --git a/sample/sample-plugins/log/winbuild b/sample/sample-plugins/log/wi=
nbuild</span><br><span>deleted file mode 100755</span><br><span>index decf0=
5f=2E=2E0000000</span><br><span>--- a/sample/sample-plugins/log/winbuild</s=
pan><br><span>+++ /dev/null</span><br><span>@@ -1,18 +0,0 @@</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# Build an OpenVPN plugin module on Windows/MinGW=2E</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-# The argument should be =
the base name of the C source file</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# (without the =2Ec)=2E</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# This directory is where =
we will look for openvpn-plugin=2Eh</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-INCLUDE=3D&quot;-I=2E=2E/=2E=2E/=2E=2E/include&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-CC_FLAGS=3D&quot;-O2 -Wall&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1=2Ec</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-gcc --disable-stdcall-fixup -mdll -DBU=
ILD_DLL -o junk=2Etmp -Wl,--base-file,base=2Etmp $1=2Eo</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-rm junk=2Etmp</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-dlltool --dllname $1=2Edll --base-file base=2Etmp=
 --output-exp temp=2Eexp --input-def $1=2Edef</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-rm base=2Etmp</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1=2Edll $1=
=2Eo -Wl,temp=2Eexp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm=
 temp=2Eexp</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2223?usp=3Demail">change 2223</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d5caab3210b65551=
e2f2ff8f6e2edb50022e4ba </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2223 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--F0SrR8rh92w=--


--===============3953673837349738725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3953673837349738725==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3953673837349738725==--

