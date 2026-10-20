Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629E3606A31B
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 14:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=l6WKbjx8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lSZgb9//;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d+wyDDQx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CY2vbm1f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TvRwnJzj87+fgHBSyVvP3J0HRzbP868btZi+cW70FVU=; b=l6WKbjx8wm7qlEx8rZcbvRvNEm
	XjCPbxJwjOOi47cqO2xL8/2txmT4co/HnXJz5d6vNClL9B33w86EYMabbripbkcoJhv39Bg3pCnM+
	8hU4MRIKxj/MrIRYUA/1Va9xG3qi4FWiO8XvZ5yjWb1vKEkchrb6EBXRYAcVtF/PVSFw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJBHu-0007ES-Rn;
	Tue, 20 Oct 2026 14:58:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJBHr-0007EK-V7
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:57:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=92X8BkamrzO6E2hK+MkFQeZlr94W+FPw5lYg57JyI/A=; b=lSZgb9//kmRn7gRkRFSZeTqNWj
 PGzuxYncFQppwYCdziTioNaEb6pHNalAGkdn7wyICeajxrs1hcke2+s8fStQ8vCyLiVOBNor0Rwbe
 8sjPO3MNUFl2xMNuVsmRI3QBtWDhtoI3W9dOTEasNsJC27En6ndp9FE/Gxxjl4hV6sEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=92X8BkamrzO6E2hK+MkFQeZlr94W+FPw5lYg57JyI/A=; b=d
 +wyDDQxD/4V/Zk5t7Qb9V//m1b9vzgaRpxtLUibAcnH4Mi96SRyneEBiQ64Q8u2tn+QM4CGQNVcw3
 wyFJmmDVjifW/9ywzIc7eyx3clBD5dndiIkQUos0PZCqw8r0110qCIJf278QzYbcia01NbqPSSUwb
 STgJh8JeTzTP4fCA=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJBHo-0007VI-L8 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 14:57:57 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a1d484b4a9so42608005e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 07:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792508270; x=1793113070; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=92X8BkamrzO6E2hK+MkFQeZlr94W+FPw5lYg57JyI/A=;
 b=CY2vbm1fw+FmiYK1Tlo51ThDHwNES2sa85k5viiiryh3slVtI5wY8w24zVU2/FLpKL
 cOVjDQLzkzePV7PlrNukZbwoGu1zYC0tkJiLsI50M0KYn8AvHMhPrP3ovPMTRtFQFog9
 BlUXph+ETaJAQxZ1FN+7k4v5W08Cls2XpaW0InZWl7QBkc/qVDOWfgEP8EO3hPthghf9
 fXGdXWeyO7HQKfCfte1ASqZgJbrI9y8F5dzukvwBxOoFd9uMdCIMGxannxxI7Hx7ANas
 FxyQ+deBJE5/fSkd6wTK2wH7JFBBgwW/4/hwXVKkXEhlGGb+7laZNWYoLQ+e1Fk0uQWG
 0gQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792508270; x=1793113070;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=92X8BkamrzO6E2hK+MkFQeZlr94W+FPw5lYg57JyI/A=;
 b=wGi8tc9oVMxRvQkfX4CpiFJLv2P+q9FHeo/ETLH5TIzr2fF93CuiCTd79QDbu1/E8v
 L/0V0CUZtn+YxXRoUI4w/OTrV+OwWFSHPfQ84318j1D4g7elYq9u93qKrl2NooV+tjMY
 WxAo/G9z5Bv4yHpqQ/C9dR6drvK7YNmsCaZhUIZ9emaEngYcDnLkZeTHtrvRoVekRDG4
 BBiwZGj0LWH1whC3BZf6BoxnUakxD8EIq8b8REpDbJRk2GttGxki8HaJMrFcznwCB2HD
 iGCAxPcCPNe4WjWuDivCbxuq90CO0NoGPjJwnoKCU96C0EmtbvVGS2VHD5TM8BIqkNiI
 B8xw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcJlYhAUfhUwgvQtrsSzJCilGOoXiBVC1Kg78SoFhMWo7spi8fkQrNzpX+8LxeXieCc4PGEp/t976Lr4uQ@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJr4Fa6qGARpPqevXvhfmJi0/tK7WrAv08x1d128/PVRBiBo+8z
 Twqaj39zcV6XKnW7lO+TG7Yps2KB0IW+Mf1bjmrP7AfLqiya/kWS9yP4JNBWghQCPvsQKXsXDYA
 cEptQZ/JoUT+41oDWJE2aHWZ8m8X78cjHaWOJnSXZLDIZWONzNjBFgsWgtSm9kknb/z8T
X-Gm-Gg: AYBFou3A2fXRWEZw4aoWPrky+wCMuUHZEH+ihZEf6bP63HpMXtEVOmYjGLzHtprI/R2
 NzK5aSf1QS6dzLkuOTd7x51TO4huxDb98migBtSON4zCEUZ2CUWsxr7JACPUIdbIMlJxtaUfC+o
 V62LsMCMzcMIPO+lwnYNR3xYkX9+rzUbxCOFbLDav78Z3TcL0N9HRNloOG8ddR7xh1dBRCR3LOg
 n7hoa9mPBAY5337TQKlaGCx7XnFkNw/qKii4sY7dPjZ2n0dAmDLvL4eLsQ9E8hQ5PebVWH0qVG9
 ElvrKlaEmUiqSHCPSAtaWyo/nxiSUaaHvBfL6gsvxH1uri10f8aRQ4NiWZfeq298uJcJ2fTpHx9
 BeOKIuvVg0ah94j42q/BCN6Gvn4cTi7hAwrHMhDkf7McNPIDRPkGZjB34bxpYBFOG0L/YauHJY+
 8FJrHECsvwLsFlX0t/6us1c77swrzz6XpPjp5wzo8LiyLOR5x0a4LIrQ1dWDKrCepZIIz50Pw26
 gH3QIUFjyHE9uNW+xf6hRb0XdgJUyUh8kex5F0J1owdBCTjGXSTqlef3w+ulHW1XCXDWELHaWT+
 Pft2UTbLDQFhdAUeZRFy7tAlIA81G54AMJ4hrD8LARrXfyIg7MkjjQ/Y6qBW
X-Received: by 2002:a05:600c:3e05:b0:4a1:71ab:63ba with SMTP id
 5b1f17b1804b1-4a1d763625emr230426715e9.29.1792508269831; 
 Tue, 20 Oct 2026 07:57:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fb83ff02sm755155e9.6.2026.10.20.07.57.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 07:57:49 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 14:57:48 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf
X-Gerrit-Change-Number: 2024
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2024?usp=email>
X-Gerrit-Commit: b50d336d00c93853ad542702516c1e0b99149fde
In-Reply-To: <gerrit.1792500876000.Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf@gerrit.openvpn.net>
References: <gerrit.1792500876000.Ib92282b5a4c3c8da7b5818d3ce78e91660a13cbf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTAwODc2MDAwLkliOTIyODJiNWE0YzNjOGRhN2I1ODE4ZDNjZTc4ZTkxNjYwYTEzY2JmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b2f68c4467e44826fc20eb30d84bc3427d3ca52d-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJBHo-0007VI-L8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Require
 automake 1.16
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8289286796685054969=="
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8289286796685054969==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MUeRdu0iA9k="; charset=UTF-8

--MUeRdu0iA9k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2024?usp=3Demail )

Change subject: configure: Require automake=
 1=2E16
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

conf=
igure: Require automake 1=2E16

Removes some ugly compat code=2E automake 1=
=2E16 is
in EOL distros like Ubuntu 20=2E04 and Debian 11,
so this should b=
e fine on all our current distros=2E

Change-Id: Ib92282b5a4c3c8da7b5818d3c=
e78e91660a13cbf
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
=
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2024
Message-Id: <20261020131943=2E24892-1-ge=
rt@greenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/openvpn-devel/20261=
020131943=2E24892-1-gert@greenie=2Emuc=2Ede/
Signed-off-by: Gert Doering <g=
ert@greenie=2Emuc=2Ede>
---
M configure=2Eac
1 file changed, 1 insertion(+)=
, 13 deletions(-)




diff --git a/configure=2Eac b/configure=2Eac
index e8=
3aba7=2E=2E52b0d20 100644
--- a/configure=2Eac
+++ b/configure=2Eac
@@ -40,=
21 +40,9 @@
 AC_CONFIG_SRCDIR([src/openvpn/syshead=2Eh])
 AC_CONFIG_MACRO_D=
IR([m4])
 
-dnl Automake 1=2E14+ warns if sources are in sub-directories bu=
t subdir-objects
-dnl options is not enabled=2E However, automake before 1=
=2E15a has a bug that causes
-dnl variable expansion to fail in foo_SOURCES=
 when this option is used=2E
-dnl As most of our build systems are now like=
ly to use automake 1=2E16+ add a
-dnl work around to conditionally add subd=
ir-objects option=2E
-m4_define([subdir_objects], [
-    m4_esyscmd([automa=
ke --version |
-                head -1 |
-                awk '{split ($NF=
,a,"=2E"); if (a[1] =3D=3D 1 && a[2] >=3D 16) { print "subdir-objects" }}'
=
-    ])
-])
-
 # This foreign option prevents autoreconf from overriding ou=
r COPYING and
 # INSTALL targets:
-AM_INIT_AUTOMAKE(foreign subdir_objects =
1=2E9) dnl NB: Do not [quote] this parameter=2E
+AM_INIT_AUTOMAKE(foreign s=
ubdir-objects 1=2E16) dnl NB: Do not [quote] this parameter=2E
 AM_SILENT_R=
ULES([yes])
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: Ib92282b5a4c3c8da7b5818d3ce78e91660a13=
cbf
Gerrit-Change-Number: 2024
Gerrit-PatchSet: 2
Gerrit-Owner: Frank Licht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--MUeRdu0iA9k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2024?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">configure: Require automake 1=2E16=
<br><br>Removes some ugly compat code=2E automake 1=2E16 is<br>in EOL distr=
os like Ubuntu 20=2E04 and Debian 11,<br>so this should be fine on all our =
current distros=2E<br><br>Change-Id: Ib92282b5a4c3c8da7b5818d3ce78e91660a13=
cbf<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>=
Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024<br>Message-Id: &lt;202610201319=
43=2E24892-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekernel=2Eor=
g/openvpn-devel/20261020131943=2E24892-1-gert@greenie=2Emuc=2Ede/<br>Signed=
-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M configure=
=2Eac<br>1 file changed, 1 insertion(+), 13 deletions(-)<br><br></pre>
<pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/configure=2Eac b/configure=2Eac</span><br><span>index e83aba7=
=2E=2E52b0d20 100644</span><br><span>--- a/configure=2Eac</span><br><span>+=
++ b/configure=2Eac</span><br><span>@@ -40,21 +40,9 @@</span><br><span> AC_=
CONFIG_SRCDIR([src/openvpn/syshead=2Eh])</span><br><span> AC_CONFIG_MACRO_D=
IR([m4])</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dnl Automake 1=2E14+ warns if sources are in sub-directories but subdi=
r-objects</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dnl options =
is not enabled=2E However, automake before 1=2E15a has a bug that causes</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-dnl variable expansion t=
o fail in foo_SOURCES when this option is used=2E</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-dnl As most of our build systems are now likely=
 to use automake 1=2E16+ add a</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-dnl work around to conditionally add subdir-objects option=2E</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-m4_define([subdir_objects]=
, [</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m4_esyscmd([au=
tomake --version |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             head -1 |</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                awk &#39;{split ($NF,a,&quot;=2E&quot;); if (a[1] =3D=3D 1=
 &amp;&amp; a[2] &gt;=3D 16) { print &quot;subdir-objects&quot; }}&#39;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ])</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-])</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span> # This foreign option prevents autoreconf=
 from overriding our COPYING and</span><br><span> # INSTALL targets:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-AM_INIT_AUTOMAKE(foreign sub=
dir_objects 1=2E9) dnl NB: Do not [quote] this parameter=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+AM_INIT_AUTOMAKE(foreign subdir-obj=
ects 1=2E16) dnl NB: Do not [quote] this parameter=2E</span><br><span> AM_S=
ILENT_RULES([yes])</span><br><span> AC_CANONICAL_HOST</span><br><span> AC_U=
SE_SYSTEM_EXTENSIONS</span><br></pre><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=3Demail">change 2024</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2024?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib92282b5a4c3c8d=
a7b5818d3ce78e91660a13cbf </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2024 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--MUeRdu0iA9k=--


--===============8289286796685054969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8289286796685054969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8289286796685054969==--

