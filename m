Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCED606A326
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LH5Lf2Hp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=k3r/PJAk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bpYNkEOv;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ex5xpG3p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W8Ef4LoTHdmnCk78E15ik0wBda04Hn50XoQoWqIRwzc=; b=LH5Lf2HpZYQIIzwfoP7pf7ra1D
	LWTXskipOOThIMY2/fIyHhFfhwp+NzsHGfdF0yavuy2h+Qnuv73NoCCxVNG82WRXPmkukIusiCQEq
	3l43Gq9tYAsJZo2rMD1g8qevm07B/cRGglVlGthh2LcTvaxYeR/v7EIDOjHyu6cBVGqc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUMI9-000000006J4-07AQ;
	Fri, 20 Nov 2026 10:56:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUMI8-000000006Iv-1NGM
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:56:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lTVUZi4glDyTNu7rVPMXQ/cnwll6bjRxEVnVNBHGUAA=; b=k3r/PJAkinTdAA2BgY/XmqUoxV
 tP370WBRNrjPBzeVQcVwhngIbhpd1cWfjbMiXC/NvjpS7T3LXJC1LlLBD8qON9IRZh2CfAIv4qOhZ
 INGA33BRthcOscLT0e+F8HH/IHL0/L14Wkhu7xTMBgfEVYVvUCokPkaxNhkNuKWXlO0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lTVUZi4glDyTNu7rVPMXQ/cnwll6bjRxEVnVNBHGUAA=; b=bpYNkEOvIQ0LwCBwLT+bOj7a36
 8lQKLqTreGVvUN7d8puDDd/YnyDgnhPzwe/Z5N7YYVNn2GlskJQoHkYu1LINwqy9c+04rEezplYF0
 bxJS2UCGfoCg7HzZESUcBN8XU4FZZnBilfqGaBJIz+PEukAwRSTHA4aAbcQWHp/7gUOw=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUMI7-000000004WG-0qu9 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:56:28 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so6562415e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795172181; x=1795776981; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lTVUZi4glDyTNu7rVPMXQ/cnwll6bjRxEVnVNBHGUAA=;
 b=ex5xpG3piRvVdius4DvB+HbrMdyqQFIiEGMdG3j8vtiSH5TNWhQK8Vbhpe4ZqzqIsI
 3ts9YSiyuGrmbKe21dbpGkZctOexkgL+KA7WttmELfGU9AHA3zPWDlst0ijfkvBhbugy
 pM+TVQiXoiiWg6iPfKcaqwmChaKZKQ9yAjzm4o9Wa5xQCdRlvwmB/u85UBFiYlhOtW8h
 oPITVhzPEqDQBqZCpvaNREeEJpxKhJiH0+D2UjZw6JGKbKwBliA7CPiDIBCfhwmSBlhD
 PcBJmu16BOiF8KXRBMqWagdT7TEKktWBltVCAsqe1qu3UB0aAaUydFwMkq4k7POK3I0l
 r4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795172181; x=1795776981;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lTVUZi4glDyTNu7rVPMXQ/cnwll6bjRxEVnVNBHGUAA=;
 b=iIMgFTu8/AbI3nPkYAI62hYyUjkbVhvR8JSAq02tYYTCvoiOl290h7muGi305yaC4h
 4roRbff/gFd4Yg0LJEIcL61ufYVLk2pvXFWMqkYs87/3gst6ZdFoOzDrSWiodSBHTa/L
 9QbzcGOio9NI4X0Raz1mvdUZKdH0/Z753M4ts2GFc8NTYV4mdv+7KEh1sqSxqL3YgSEI
 GvJxHyCqkPYiM1953gjXyMLH3naYsFCQYlyOkH9aEQq3Ypu9TqfVACHcTJVErA1PueUS
 spcxxl4a0O12SpsMZWYpCLGbQwQ36unessw/Hyrk4wHJtirp3OzJSK1Iux9Mg0PKvi/U
 2yAA==
X-Forwarded-Encrypted: i=1;
 AL+hErF1eitXbGHHJblqfMCI6wwdG+sTMfW5nBkc/i6qdtSMULNAcFaLYhIf9pHXt2IiPD9stpLa+X3sWgxjZd6O@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9UKTO6+gSABnRYQZHX8EhokyhH26w2mfdlZbgWqiL0N4KtNB5V
 1Bl0rB/3v7NnpdhUVbd6azVtMLE7OZsX1lwoDXF4GkKg91tLfs23xFd8mb57tmBRuCdWFoMPAIa
 A4Sy33dOkHvQLP6bU4YEQeFnSs2NrhVQCxPzVugH4x485ks/RdwE3JlOFwWOA2mmZXzqCmLFfhY
 fYsGgUdw==
X-Gm-Gg: AYBFou2JuRqvzLTwUipD/P7f2F2RCgDGBC6bmSJ7C8XlnNloa8czk6wfUG0A9hzXGG+
 hrCeaJbz3l8ZlwacZwomKKYc+vdzjKOJdegaDt32Qkbk+nhNd8axtNPiUv/JndwPCafXFS4hKod
 wjav2DGXVTlHRhdGPl6+hn06wpn9rD/BwAk25F/JaRGcVrrknKLT200NdqAihF6OylWxYWihPcW
 vlgYKQ/8pG6W1g5kBbv23/I0LInSEUDjMniybGtQZ5S/WADCVNe8/9bJb3OA+6Vm4WpNWcvUzXS
 EwdU7TMGEfN0R9lbjcobYz7NAM6ZCb0SeazVvZTzAe/cNdI6JKR0FePzlmPSpz1BUIpuoYhDkcj
 evOQlN+cZBOcqL4hK/Fwd4aiR8OOZNh06Ezmt0WxplUmR1h8m2SXxQk5IGw6mXg2qk5gVA9sgph
 Gd0+FLpa9VZ9makVCPVZa/jLyojYd5o+SuK/1Cluw93vRjeqDdtaOT0p0tqSFiVR1cGc56qs6os
 QajVSVgrF6uTUvfXeEmZ/tuNPMsnLv+ydZ9lqVrLmxETwnYx/ubvFgBVZ8Rtm6AjMa0HIzR3M9U
 UAdmFaVR1AH+OF5hoddawNOBFMZGmnHm70XCyk6j+HhUj31fH22qz9NYPbBMRm33+Vz50hwRxgm
 wTnTNssJJTWuobOKJCF79UuJGBg+EtgDPE4jajcrnYB8t6zLO94cOiJRiXeU6kpghoXWECGCDkr
 hQRoP3MWlW4Ry7dvo=
X-Received: by 2002:a05:600c:1d8c:b0:4a1:c5eb:b445 with SMTP id
 5b1f17b1804b1-4bb88820436mr56180045e9.35.1795172180398; 
 Fri, 20 Nov 2026 02:56:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88f6b6a6sm82369505e9.5.2026.11.20.02.56.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:56:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:56:19 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
X-Gerrit-Change-Number: 2223
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2223?usp=email>
X-Gerrit-Commit: 297cbcc1633e5259d0455124af574fecc436c53a
In-Reply-To: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
References: <gerrit.1795075601000.I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc1NjAxMDAwLkkzZDVjYWFiMzIxMGI2NTU1MWUyZjJmZjhmNmUyZWRiNTAwMjJlNGJhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f755f766a32d4fb54788f8b2f56477aaa7ea3aad-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUMI7-000000004WG-0qu9
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3577513165387571928=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3577513165387571928==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jvCY+kBSfKM="; charset=UTF-8

--jvCY+kBSfKM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2223?usp=3Demail )

Change subject: sample-plugins: drop broken=
 defer and log winbuild scripts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

sample-plugins: drop broken defer and log winbuild scri=
pts

Both need a $1=2Edef that doesn't exist in their directory=2E

defer/s=
imple=2Ec and its =2Edef were removed in d816207b ("plugins:
Remove defer/s=
imple=2Ec sample plugin"); the remaining multi-auth=2Ec
uses fork() and doe=
sn't build on Windows=2E log/winbuild came from
the examples/ -> log/ renam=
e and never had a =2Edef there=2E

log=2Ec builds on Windows with a plain "=
gcc -shared", since
OPENVPN_EXPORT already marks the entry points __declspe=
c(dllexport)=2E

Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
Signe=
d-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev Stipakov <l=
stipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2223
Message-Id: <20261119130456=2E20423-1-gert@greenie=2Emuc=2Ede>
URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g41679=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
D s=
ample/sample-plugins/defer/winbuild
D sample/sample-plugins/log/winbuild
2 =
files changed, 0 insertions(+), 36 deletions(-)




diff --git a/sample/sam=
ple-plugins/defer/winbuild b/sample/sample-plugins/defer/winbuild
deleted f=
ile mode 100755
index 82927d9=2E=2E0000000
--- a/sample/sample-plugins/defe=
r/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-# Build an OpenVPN plugin mod=
ule on Windows/MinGW=2E
-# The argument should be the base name of the C so=
urce file
-# (without the =2Ec)=2E
-#
-
-# This directory is where we will =
look for openvpn-plugin=2Eh
-INCLUDE=3D"-I=2E=2E/=2E=2E/=2E=2E/build"
-
-CC=
_FLAGS=3D"-O2 -Wall"
-
-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1=2Ec
-gcc -=
-disable-stdcall-fixup -mdll -DBUILD_DLL -o junk=2Etmp -Wl,--base-file,base=
=2Etmp $1=2Eo
-rm junk=2Etmp
-dlltool --dllname $1=2Edll --base-file base=
=2Etmp --output-exp temp=2Eexp --input-def $1=2Edef
-rm base=2Etmp
-gcc --e=
nable-stdcall-fixup -mdll -DBUILD_DLL -o $1=2Edll $1=2Eo -Wl,temp=2Eexp
-rm=
 temp=2Eexp
diff --git a/sample/sample-plugins/log/winbuild b/sample/sample=
-plugins/log/winbuild
deleted file mode 100755
index decf05f=2E=2E0000000
-=
-- a/sample/sample-plugins/log/winbuild
+++ /dev/null
@@ -1,18 +0,0 @@
-#
-=
# Build an OpenVPN plugin module on Windows/MinGW=2E
-# The argument should=
 be the base name of the C source file
-# (without the =2Ec)=2E
-#
-
-# Thi=
s directory is where we will look for openvpn-plugin=2Eh
-INCLUDE=3D"-I=2E=
=2E/=2E=2E/=2E=2E/include"
-
-CC_FLAGS=3D"-O2 -Wall"
-
-gcc -DBUILD_DLL $CC=
_FLAGS $INCLUDE -c $1=2Ec
-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL -o=
 junk=2Etmp -Wl,--base-file,base=2Etmp $1=2Eo
-rm junk=2Etmp
-dlltool --dll=
name $1=2Edll --base-file base=2Etmp --output-exp temp=2Eexp --input-def $1=
=2Edef
-rm base=2Etmp
-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1=
=2Edll $1=2Eo -Wl,temp=2Eexp
-rm temp=2Eexp

-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba
Gerrit-=
Change-Number: 2223
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: op=
envpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--jvCY+kBSfKM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2223?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">sample-plugins: drop broken defer =
and log winbuild scripts<br><br>Both need a $1=2Edef that doesn&#39;t exist=
 in their directory=2E<br><br>defer/simple=2Ec and its =2Edef were removed =
in d816207b (&quot;plugins:<br>Remove defer/simple=2Ec sample plugin&quot;)=
; the remaining multi-auth=2Ec<br>uses fork() and doesn&#39;t build on Wind=
ows=2E log/winbuild came from<br>the examples/ -&gt; log/ rename and never =
had a =2Edef there=2E<br><br>log=2Ec builds on Windows with a plain &quot;g=
cc -shared&quot;, since<br>OPENVPN_EXPORT already marks the entry points __=
declspec(dllexport)=2E<br><br>Change-Id: I3d5caab3210b65551e2f2ff8f6e2edb50=
022e4ba<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>=
Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223<br>Message-Id: &lt;20261119130456=
=2E20423-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41679=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>D sample/sampl=
e-plugins/defer/winbuild<br>D sample/sample-plugins/log/winbuild<br>2 files=
 changed, 0 insertions(+), 36 deletions(-)<br><br></pre>
<pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sa=
mple/sample-plugins/defer/winbuild b/sample/sample-plugins/defer/winbuild</=
span><br><span>deleted file mode 100755</span><br><span>index 82927d9=2E=2E=
0000000</span><br><span>--- a/sample/sample-plugins/defer/winbuild</span><b=
r><span>+++ /dev/null</span><br><span>@@ -1,18 +0,0 @@</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# Build an OpenVPN plugin module on Windows/MinGW=2E</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-# The argument should be the ba=
se name of the C source file</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# (without the =2Ec)=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# This directory is where we wil=
l look for openvpn-plugin=2Eh</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-INCLUDE=3D&quot;-I=2E=2E/=2E=2E/=2E=2E/build&quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-CC_FLAGS=3D&quot;-O2 -Wall&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c $1=2Ec</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-gcc --disable-stdcall-fixup -mdll -DBUILD_DLL =
-o junk=2Etmp -Wl,--base-file,base=2Etmp $1=2Eo</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-rm junk=2Etmp</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-dlltool --dllname $1=2Edll --base-file base=2Etmp --outpu=
t-exp temp=2Eexp --input-def $1=2Edef</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-rm base=2Etmp</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-gcc --enable-stdcall-fixup -mdll -DBUILD_DLL -o $1=2Edll $1=2Eo -Wl=
,temp=2Eexp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm temp=2E=
exp</span><br><span>diff --git a/sample/sample-plugins/log/winbuild b/sampl=
e/sample-plugins/log/winbuild</span><br><span>deleted file mode 100755</spa=
n><br><span>index decf05f=2E=2E0000000</span><br><span>--- a/sample/sample-=
plugins/log/winbuild</span><br><span>+++ /dev/null</span><br><span>@@ -1,18=
 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-# Build an OpenVPN plugin module =
on Windows/MinGW=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
The argument should be the base name of the C source file</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-# (without the =2Ec)=2E</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# T=
his directory is where we will look for openvpn-plugin=2Eh</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-INCLUDE=3D&quot;-I=2E=2E/=2E=2E/=2E=2E=
/include&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-CC_FLAGS=3D&quot;-O2 -Wall&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-gcc -DBUILD_DLL $CC_FLAGS $INCLUDE -c =
$1=2Ec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-gcc --disable-s=
tdcall-fixup -mdll -DBUILD_DLL -o junk=2Etmp -Wl,--base-file,base=2Etmp $1=
=2Eo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-rm junk=2Etmp</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-dlltool --dllname $1=2Edl=
l --base-file base=2Etmp --output-exp temp=2Eexp --input-def $1=2Edef</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-rm base=2Etmp</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-gcc --enable-stdcall-fixup -mdll -D=
BUILD_DLL -o $1=2Edll $1=2Eo -Wl,temp=2Eexp</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-rm temp=2Eexp</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=3Demail">change 2=
223</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2223?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I3d5caab3210b65551e2f2ff8f6e2edb50022e4ba </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2223 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--jvCY+kBSfKM=--


--===============3577513165387571928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3577513165387571928==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3577513165387571928==--

