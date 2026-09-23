Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE84C9830B
	for <openvpn-devel@archiver.kernel.org>; Wed, 23 Sep 2026 15:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VZjSDB/b7g28/E+c0pJ9SP02H92JJTOfDPHHYZ8WJ5Q=; b=m8+pjVCgsSpiUKQ/dDSZ8oikqI
	Agx+1AcQKpTuC51B5f+y/D6zpBO7MOcwcc9n95+FYqvYqE0VvpVSZ8vOS+PJC4TS0fnEjoa2PwoPy
	Ld1yXF8aSFDbu0XYv+OMRdJNmzcypURkGztr4quAiDiz+Ok4aHR9Wfx+OckuZi2sxhqs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9PDY-00011Y-Uv;
	Wed, 23 Sep 2026 15:49:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9PDY-00011Q-0Q
 for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IdLzvqmZgCU3HuIuuxg49gmpefET0NN8S3l5Ki7mA44=; b=ZwKtZhzZ5FWXXLEyLbjcsjBLnG
 sHWxGi785gvXV/fjenqgq1+61PK4maPubuoxPJV8VpLkRsv14s9AE+vpJcptelZgz8+FFXrWL3gEg
 mN+h0c+1yWhGRtfevP3N9frUrS1vV/hJi9zkkkwqxMyCecGSiK0vT+Bbn73Goy3t9QwA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IdLzvqmZgCU3HuIuuxg49gmpefET0NN8S3l5Ki7mA44=; b=I
 uU7cFDWJ4g0viMOqtU/R/WHrm9Hn8AbnyKV5d5CKQBWCRftFJy/NoxO/g++hxOs3dJCs7yX0MxAbD
 SiWspGNzqiFpaIlamSCZ0Z1RN2WdvIJuOFfSjvC8oxaRVH2KtC1tOfnwz4ps7u5Jupmb2S6YHXfCm
 pcbHR85BE1Z5yMwo=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9PDX-0005HT-3J for openvpn-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 15:49:08 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so839076f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 08:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790178540; x=1790783340; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IdLzvqmZgCU3HuIuuxg49gmpefET0NN8S3l5Ki7mA44=;
 b=L1D206YkynIhMV0Qky5MoUYHTKfBrasyEEgtj679JWjU2AwjZIqNCp+x9RAZFqb0JX
 VkboSPvmtZbEZBZ4ZuqWZCZyiP77i7xDA6+4Js8aTFJVSQWWv5jxwZR/+yQdgi6dj44+
 I5IfmeVpZFmwAX7JNcMgJ7xEZ4G2TzegcV/afVEKMkW8EcNSmFIV1VBbj9yGWDAO0DPv
 eTOCJ7LymtFv12WOO+QIQFDD+j9BgzQFOMaC4ukXbdefZbbHYVRD5c+fSOVP37fJFe6F
 en6looSXFld8naSqWcj0tn3Ep6Bt11fKpel1Qe/ja5cnO7AecFF5v7qgguPUnYBiqgK0
 A5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790178540; x=1790783340;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IdLzvqmZgCU3HuIuuxg49gmpefET0NN8S3l5Ki7mA44=;
 b=aZ5ei1LgVVyajZCj/HSbIpoRkVtlfDo39qlQUeUkgbeTnp2+cDJFqc8Bc7TcFoG5p6
 P5KlURm+/SQrbjerVo7nLsjyZGT8tgDypsP7ssK0RIf3WGVImWEJVzXlBBSMlZ5ET4xz
 GHNTdEbvR+KkHMPrJO1zb2Qgvton7esX9ewyPUMqDbVKi0iQqXdvD7iF24mdhkA1NcsP
 lILxFy8BQLCXXtPfXWr9cUTTqOfLfqlC2b4/cx+3JAbPlPc9Di0KwErmfcC6Aex6Sqmd
 P4G4M5b+REqmH9AaKVwPJacPIr4xrOV1vMxmyMW6vtAK3dquTKElvKLcCOAfrBe4BJTL
 yfGg==
X-Gm-Message-State: AFuF++nue2b+MfOlEDG+ibZbJMufgn/g+36UsZt7rudOGNuoyjJh2l80
 XsVlrbyOhdpjX1GvRZ/HceOtgmwm8p5q3fUi5eA2JpnHBNkFURBfQQTzz8w3R7xlWuRmvSMA8Wk
 nyRBrCMhNhrMBYiM2lpvLjEUGJgbmTyarND+w6Q2z8Xh0EmGlnipZqzVNUhQYr2dP8M0nVbxQ/s
 3lAEbSFA==
X-Gm-Gg: AYBFou04YytL0EkgRr52eSuOfX73doGWiifMDBMwfx06YEJzy/i3o7bxbBgm8tEc8K1
 AFELu8sbExkAry22tsJ/5zIUbXqx0GgiwmUQykpILaAKH+K7lRH/QoWrXYb/Ff/ByqJyp60UO99
 /pNjHp+cehIt45Zs7NkcFz8k30LMX+n3ZtlMIzkjI1f5vr9OCLVEqIRxfuMdKpt8v3ggBrfQyR7
 2FnI9Ssewa5BBZzijsriEacZcLVEF07AYZ4Ne8SbJUVNkatfscOUk5jcfDxgxTSuBVPFyWfakXv
 AAzgMatZmkgQ+SxkNrtmHwF5A6JngcITfA9jP1NK43GQdmgxMqbapJdbk7uFPkGJCDiFlNEuQwq
 wO7zexNUI9JRd7KWBa7IsEaYYzodRLjE1YQC84aFeMTuI2MspHySGTPELcMAiWVVZ1to6Z6M6C5
 RdMGHrVV717dfR19JAWTk/bn4RCMUGCT+oRXWZYQOR0yK274HM+kKG73pggSwXFxZAYc+GW5ky2
 iFaHkzm+AWGVwbeB6ybYLU0H+rV5MsYYRE02otIUltxuXu2CAq4JlkYjHKEsPoJMmEqZ5z0/CyO
 e4AEVI0P9H1RTLzTuInI1k1S9ym8iH5v/mu7Vgq7A2kLFjX2t8cKEWSoy1j8KbRviyifhS8=
X-Received: by 2002:a5d:64e6:0:b0:487:27f6:a4e2 with SMTP id
 ffacd0b85a97d-4886709d539mr5907950f8f.50.1790178540299; 
 Wed, 23 Sep 2026 08:49:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886877a2d5sm7714650f8f.27.2026.09.23.08.48.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 08:48:59 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 23 Sep 2026 15:48:56 +0000
To: razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: 0fb2bf0e0043b17f6bd0f1fcd0dfa9264234e39e
In-Reply-To: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8c1a49c743bfe2fe062d5660b5bfca3637a31832-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9PDX-0005HT-3J
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4482271386494435022=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4482271386494435022==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PBgNnnHKhc0="; charset=UTF-8

--PBgNnnHKhc0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello razvanc, 

I'd like you to reexamine a change=2E Please visit

    ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail

to look at the ne=
w patch set (#4)=2E

The change is no longer submittable: checks~ChecksSubm=
itRule is unsatisfied now=2E


Change subject: Document notify as auth pend=
ing method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

D=
ocument notify as auth pending method

This allows a server to signal a pen=
ding authentication that does
not require any action from the user or clien=
t but can still take
a while to complete and enter the auth pending state=
=2E

Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
Signed-off-by: Ar=
ne Schwabe <arne@rfc2549=2Eorg>
---
M doc/management-notes=2Etxt
1 file cha=
nged, 30 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/19/1919/4

diff --git a/doc/management-no=
tes=2Etxt b/doc/management-notes=2Etxt
index 1126468=2E=2Eefbe757 100644
--=
- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -794,6 +=
794,36 @@
 The client should return the response to the crtext challenge
 u=
sing the cr-response command=2E
 
+notify
+=3D=3D=3D=3D=3D=3D
+This is noti=
fication that there might be some activity that potentially takes
+a while =
to finish is happening beyond the control of the client=2E This might be
+a=
 server side check or an out-of-band authentication like requiring to have
=
+to authorise the connection on a mobile phone app=2E Beyond the control of=

+the client is here meant in the strict sense of OpenVPN client program=2E=

+This message still might prompt the user to look at their phone for examp=
le=2E
+
+The syntax of {EXTRA} for notify is:
+
+    NOTIFY:<flags>:<notify=
_message>
+
+<flags>: a series of optional, comma-separated flags=2E No fla=
gs have
+been defined yet=2E
+
+<notify_message>: The message to show the u=
ser to inform them about the
+ongoing authentication
+
+An example for a no=
tify EXTRA of a server that does some checks against
+well known list of bl=
acklists could be
+
+    NOTIFY::Please wait while your IP is checked again=
st multiple online abuse databases=2E
+
+to inform the user that there is a=
 delay in the connection attempt=2E
+
+Since the notify pending auth is not=
 requiring any action on the client side
+that is required to continue the =
connection (unlike MFA or opening a browser)
+this message is not negotiate=
d but can just be sent as a gratuitous message=2E
+
 COMMAND -- client-deny=
  (OpenVPN 2=2E1 or higher)
 ----------------------------------------------=
-
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6217c0541bf=
f81eefa63a987db8904b2feda2546
Gerrit-Change-Number: 1919
Gerrit-PatchSet: 4=

Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--PBgNnnHKhc0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #4</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail">View Change</a></p><p>T=
he change is no longer submittable: checks~ChecksSubmitRule is unsatisfied =
now=2E</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Document notify as auth pending method<br><br>This =
allows a server to signal a pending authentication that does<br>not require=
 any action from the user or client but can still take<br>a while to comple=
te and enter the auth pending state=2E<br><br>Change-Id: I6217c0541bff81eef=
a63a987db8904b2feda2546<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eo=
rg&gt;<br>---<br>M doc/management-notes=2Etxt<br>1 file changed, 30 inserti=
ons(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/19/1919/4</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/=
management-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 1=
126468=2E=2Eefbe757 100644</span><br><span>--- a/doc/management-notes=2Etxt=
</span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -794,6=
 +794,36 @@</span><br><span> The client should return the response to the c=
rtext challenge</span><br><span> using the cr-response command=2E</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+notify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+This is notification that=
 there might be some activity that potentially takes</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+a while to finish is happening beyond the=
 control of the client=2E This might be</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+a server side check or an out-of-band authentication li=
ke requiring to have</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+to authorise the connection on a mobile phone app=2E Beyond the control of=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+the client is here =
meant in the strict sense of OpenVPN client program=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+This message still might prompt the user=
 to look at their phone for example=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
The syntax of {EXTRA} for notify is:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  NOTIFY:&lt;flags&gt;:&lt;notify_message&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+&lt;flags&gt;: a series of optional, comma-separated flags=2E No fla=
gs have</span><br><span style=3D"color: hsl(120, 100%, 40%);">+been defined=
 yet=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+&lt;notify_message&gt;: The mes=
sage to show the user to inform them about the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ongoing authentication</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+An example for a notify EXTRA of a server that does some checks =
against</span><br><span style=3D"color: hsl(120, 100%, 40%);">+well known l=
ist of blacklists could be</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NOTIFY::=
Please wait while your IP is checked against multiple online abuse database=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+to inform the user that there is a=
 delay in the connection attempt=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Sin=
ce the notify pending auth is not requiring any action on the client side</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+that is required to c=
ontinue the connection (unlike MFA or opening a browser)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+this message is not negotiated but can=
 just be sent as a gratuitous message=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> COMMAND -- client-deny  (OpenVPN 2=
=2E1 or higher)</span><br><span> ------------------------------------------=
-----</span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919?usp=3Demail">change 1919</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I6217c0541bff81eefa63a987d=
b8904b2feda2546 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1=
919 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--PBgNnnHKhc0=--


--===============4482271386494435022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4482271386494435022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4482271386494435022==--

