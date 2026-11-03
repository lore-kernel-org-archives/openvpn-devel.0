Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E42606A329
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 17:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OcAkapc+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Rt0BDaJG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i9sp3mKO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KqwVogIt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=cKpdgLyMQHh6kE0xqmhAAaFBzjZyJ1U1TxCrV8b7oWU=; b=OcAkapc+N65NNjvfaKZ9tBOQAm
	cuhCWR6IVNZv6/GmQjU1OwnNmgdonbCOsnO2NczRcYiBgwAgFVk8Im/SjEmMrb/UdjbXscYxla+SU
	PkRL9hs/LLuoMn/8XvIym0NBPNyjmFbd8+J2ODzMr53ZR2y54XhtkVdSoHqt4Zznbdxo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOI9C-000000001go-1ATp;
	Tue, 03 Nov 2026 17:18:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOI99-000000001gh-3Mrs
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:18:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lA6Xjxf+uSAYLE7VRX6Aqo+b2lfaIbPvLfRBCpvbV58=; b=Rt0BDaJGwJ0KGLBztwrtdtu7AR
 kvhOOohBOtvgb+RXrqWoHy0I5KV6GQtFztfp5FoRiQnhmQnAwv+SiO4Jt+3+YVFqYji2shX4FOrlY
 7r/zZbWaC7jOS0jhf32+1DUq+AxX/zLf+BBAM/tt43ZHCHfA5yl4FFmnpF0+vKnlLOB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lA6Xjxf+uSAYLE7VRX6Aqo+b2lfaIbPvLfRBCpvbV58=; b=i9sp3mKOHtiRc7i4HVi9fe+S0R
 AXyrMd7Tm/MuY0LpREpO3IpmJZhRRn43kiBG/0OR9y8mY0IR9ULcchhl3zOAf8kH5JYOhTHu6i2da
 +3pLEhmGTCY6HKI2CctMY3cm+F0J8ee85U/BPuT1Qpc+9GGtYB8AWMqBfx4GZK8CutQI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOI97-000000000xz-0eu1 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 17:18:07 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so9636995e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 09:18:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793726278; x=1794331078; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lA6Xjxf+uSAYLE7VRX6Aqo+b2lfaIbPvLfRBCpvbV58=;
 b=KqwVogItCROvU4K9gpY+8KaPcYEoop9FulQDYQmyZOkoZQsZGVRmpjwzhEvijCsHe9
 xRMxz6t3cH0447XdkUS/ihWF06cveR6/2t9OWLY68Yg1FS+GA6WKs/eGNt6BTtHmvf8P
 eJDHIWGo9HsRhu19svPAVjR+CySvYWRdz2QrBrJHT8ptVXxOf7chQrnpmtncu2oA++kB
 0Q3h708OQrBFSCv3FT1AGeDy6zmBe7b2KnxfFY9DbiVpLGlHTFfOlkas67EeV1BHBUQq
 XVdNSddVQepcIEVvZ8SZd6vGJoXKuYGuu6b/Amzaaf9+nDoJFY9JKqeXf+3xIUKDruH+
 L96A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793726278; x=1794331078;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lA6Xjxf+uSAYLE7VRX6Aqo+b2lfaIbPvLfRBCpvbV58=;
 b=hIMe70CnRA/1vYW5mMxuVrd0E51lA812N2tXRqtIW4Jas35uIEVJdeEe8QFBZbUohA
 6gdJDwWm8z7Vp6f3lKT+WmfW26ZkoXYPhMG7pB0M/qcwvbFiHJ7twaDm9VuJwcb0OTCo
 ZtDNSihr9cT8aO9UYrKPyH1PVsR6exTDMsYYTxsvmHRLHeujH2EEr9y0GTJkmZ/UqOTh
 OUjFeNJt15GDLQhs0urtGUHmR4eXX7w5Aqf/LwfPvwkNg3wabXNk+QDwb8xQXpOUlOo8
 JlwS5JVTt4/ka3Cx+8ibsUo2y4huFi0VFnKx1IEBy1vIfktpNZ5YRgJ9Q0/t5/BSJaj0
 zOzg==
X-Gm-Message-State: APuU4Z+2ui230Y453GT5YOslzmIfdCdNdVQ05KRj5EaKVBl7gXsMuPFX
 MSnO447zgotsMz0uul2Nld/om22NuzS3aR5l0Ls9rebcQJIvS7R4sS/JsyrWp5Qcg5rZd3uq3sW
 lntSV3Nsfqb9PiCFNuIWPy6fcSufTUT53R+hIvDYpjMLwGMvslOriaqUfyJ7hFHvPBiHdlIV7DL
 HmSSqZdw==
X-Gm-Gg: AYBFou2FbA9ZbHUp3uuCM6dewxtkHqDu+LR6FSdL4/x4bek0di4CliGOb7etE0zztAy
 uF9bbYLZwAMWjy+vwUMYNJxkjQilk5ahn2uVJX1f75O4LHQZ7CXVl9GFFcRghDHHGJVbhSSBgWR
 Qfv24A5obDEri303Xb/ABlUgRvfSoNKhBIORI98O0vi7GMi9WI0SxgZWoec3iqi6d187plwO6c8
 w0ZuF5qFfhK3Jl2tkek3rZxXMfMsCVYeVI89pmAYxeNnCynf9i5U472i3j4CE/ql5Sn9Oj5kCNA
 jtZik4OxuNLws/dftEJdPfOfU+RlFF5MBhJtsKi55zCdGsU/WY/DgMILzNAFOxy1wVzWdO9Dp9m
 K554PepsDzXXIBkuZZx8YI2pkx4wtlOC34lRZYdvLS8jEJF3HngtaEoBx1ycEvZmfBXbTu/NhoY
 tbV+t7SX2NfwQ0hE7lxfRWwAPfsKJHu1oDqeUH626pwSDMJ0al47mIL5igYgwvjm3UA6caVJsMg
 kH8Y4r9LNH2RZRFohyaIbPfw/7XY0kbvmD/1fbb5EJ5344mb9QHGce+mkKU/tljkV7njGkV4acA
 vYd0FJ4rAnFrI2atB+7IJETCf+6UnKDr+oVwtBFhYfapLm9UDnY/UR21LBdfz3i3WQx7Aunrl0N
 DsHQ79KwrYpVVFn8SzttONn0Cz8thFx/vCfUcgAStKMX2c72Pi/uc4mNwrgrXU1SVx9uASS8wlb
 PQ7TFTm5qRrYZosw==
X-Received: by 2002:a05:600c:5246:b0:4a2:1960:6fa with SMTP id
 5b1f17b1804b1-4ac16acd947mr327382695e9.4.1793726278118; 
 Tue, 03 Nov 2026 09:17:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2a82cf248sm108655915e9.2.2026.11.03.09.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 09:17:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 17:17:56 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8
X-Gerrit-Change-Number: 2097
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2097?usp=email>
X-Gerrit-Commit: 4a6bd5f532195ca89550c3e930576734ac7ff486
In-Reply-To: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
References: <gerrit.1793686207000.Iad78e78cf51812c392f53cd58b33b54cb99cc6a8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjg2MjA3MDAwLklhZDc4ZTc4Y2Y1MTgxMmMzOTJmNTNjZDU4YjMzYjU0Y2I5OWNjNmE4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a006f13e8f47167386315bf33a777e96cdcc742-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOI97-000000000xz-0eu1
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: console_systemd:
 free argv when openvpn_popen() fails
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6489496885621303338=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6489496885621303338==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="89yt4fQglKA="; charset=UTF-8

--89yt4fQglKA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2097?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: console_systemd: fre=
e argv when openvpn_popen() fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

console_systemd: free argv when openvpn_popen() fail=
s

get_console_input_systemd() returned without freeing argv on popen
failu=
re=2E Free it right after openvpn_popen(), which no longer needs it=2E

Cha=
nge-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8
Signed-off-by: Razvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2097
Messag=
e-Id: <20261103121903=2E2369-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40566=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/con=
sole_systemd=2Ec
1 file changed, 3 insertions(+), 3 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/2097/2

diff =
--git a/src/openvpn/console_systemd=2Ec b/src/openvpn/console_systemd=2Ec
i=
ndex 9588b95=2E=2Eeaed24e 100644
--- a/src/openvpn/console_systemd=2Ec
+++ =
b/src/openvpn/console_systemd=2Ec
@@ -69,7 +69,9 @@
     argv_printf_cat(&a=
rgv, "--timeout=3D0");
     argv_printf_cat(&argv, "%s", prompt);
 
-    if=
 ((std_out =3D openvpn_popen(&argv, NULL)) < 0)
+    std_out =3D openvpn_po=
pen(&argv, NULL);
+    argv_free(&argv);
+    if (std_out < 0)
     {
     =
    return false;
     }
@@ -81,8 +83,6 @@
     }
     close(std_out);
 
- =
   argv_free(&argv);
-
     return ret;
 }
 

-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2097?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8
Ge=
rrit-Change-Number: 2097
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--89yt4fQglKA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2097?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">console_systemd: free argv when openvpn_popen() fails<br><br>get_consol=
e_input_systemd() returned without freeing argv on popen<br>failure=2E Free=
 it right after openvpn_popen(), which no longer needs it=2E<br><br>Change-=
Id: Iad78e78cf51812c392f53cd58b33b54cb99cc6a8<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2097<br>Message-Id: &lt;20261103121903=2E2369-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg40566=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/console_systemd=2Ec<br>1 file chan=
ged, 3 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/2097/2</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/src/openvpn/console_systemd=2Ec b/src/openvpn/console_systemd=2Ec=
</span><br><span>index 9588b95=2E=2Eeaed24e 100644</span><br><span>--- a/sr=
c/openvpn/console_systemd=2Ec</span><br><span>+++ b/src/openvpn/console_sys=
temd=2Ec</span><br><span>@@ -69,7 +69,9 @@</span><br><span>     argv_printf=
_cat(&amp;argv, &quot;--timeout=3D0&quot;);</span><br><span>     argv_print=
f_cat(&amp;argv, &quot;%s&quot;, prompt);</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if ((std_out =3D openvpn_popen(&a=
mp;argv, NULL)) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    std_out =3D openvpn_popen(&amp;argv, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    argv_free(&amp;argv);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (std_out &lt; 0)</span><br><=
span>     {</span><br><span>         return false;</span><br><span>     }</=
span><br><span>@@ -81,8 +83,6 @@</span><br><span>     }</span><br><span>   =
  close(std_out);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    argv_free(&amp;argv);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>     return ret;</span><br><span> }</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2097?usp=3Demail">change 2097</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2097?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Iad78e78cf51812c392f53cd58b33b54cb9=
9cc6a8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2097 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--89yt4fQglKA=--


--===============6489496885621303338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6489496885621303338==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6489496885621303338==--

