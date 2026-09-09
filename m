Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED48C79FB6
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CqXMtRxv4YA1/zaLUKM+5beUOJ3Gp1Fqpt9LD8r8zeU=; b=TDIW8NEzTEwGIwlgWNduu5FTpS
	KWaU3rAJ8U7PpXKuv8RUiF9U94L5eXbjg58BvNe8UZuN+KLzJsjjBFyMHCqM4z7NDkV/Psdb/UKsv
	KdK6QE+UJCRIkJ1MLjg/UrhHVmBFd1oHdqsvimriQWD6FcFDfSLU4hFkY4t54V5YzFUs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4GPa-0006Rw-Mk;
	Wed, 09 Sep 2026 11:24:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4GPZ-0006Rj-3e
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:24:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=btJrA4rR189Te5lcy9u9/9Tg4i8ZrgkHtFcXifDjPIo=; b=GCkjTWB6KhyX+j8oJ+jGjPbu1e
 c+x4YTtcSnh91zNpcYtE3RDXzoSq53tGdw0R5UgA2986pyzF9bh4tYbP07ZLriXybzcKlzSBN9qZd
 xLHtaGr0yut3DtVg4lhfrDrH7Dd6CLV21vEYwbo0dGXDaEFq/GbHzWFYqbOzGeTXE4zE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=btJrA4rR189Te5lcy9u9/9Tg4i8ZrgkHtFcXifDjPIo=; b=W
 Obvp91jmaOoYHAsH8zx+KWRroEbIZ6Fx4z/vzN4nZQlEUfyPiHAi9foSysHKEndwDUxRRNtsIFtQ+
 4/EPpI34E8LyUmJegDyqu12KVNYjc8JJGr99q4GRxVGe6OtYTb6pVSu9dOEZ9l3ZWND1FY+oci9hm
 sXuOzFQBcnxqgysk=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4GPU-0007Al-7o for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:24:14 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so80246075e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 04:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788953046; x=1789557846; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=btJrA4rR189Te5lcy9u9/9Tg4i8ZrgkHtFcXifDjPIo=;
 b=PYT4fBqhf2Z3LUvUogxAEtebkWsSt9eXgftT3iYsMJkhNf6CxRkEqkiLKvTRsUJBhi
 PQZKw9qY0KM50Z3lsCkzFx6y7BUcy5hHE/v8c+833fwkUI8nnQhAXh153rcCpbTEnMnK
 etzTYr0vlxeULT7Ham/W8flLv/babX/0sDWLMGktNc7EZXT8E5W77T0S9Gkagqt8TnCe
 Wh96CqIyREn1VzANAiyEiy4wBV7gyngeGDMPrvjustFXxkgTuOAgmqtLd5mNE+DPWT/v
 CHJSQU0yQM/VkKkSReRO4iQyFTrl0P131JxAHV+MXwgJA+CvVwPcDeTlgJvnFL0AtnZS
 TbEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788953046; x=1789557846;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=btJrA4rR189Te5lcy9u9/9Tg4i8ZrgkHtFcXifDjPIo=;
 b=FHz8yNhSMxw/aWX1KFdhzhvohLg3ucNCTYkABvmW/YU73H01BQy61rSGK+gEHBDZVx
 ZRan+ULw3La9VGlqsX+bnHo+/Uc5jizaErH5NKgxs7zMyslfRKlC8XtuWOImCdZiqnDf
 qRMbNB+oQyjYBri8kW+VoQeVTTAwwRVOShDU9o5Si1wIsHckxvJ/sR7zs/dcyF0OVIHg
 H0DKh8BvfOyH1X1E4pzY20GqBg/D9ptHVrSERpFE91BETq7j+RGkmYlqkg36apLHDeNV
 OA7dED+88HYuw2sAasw+1B7QNCK++wqfEQ8+iKQ7kFHUWCpuh/gCnNsII6OpAHyvI8P3
 WxLg==
X-Gm-Message-State: AFuF++kg9l3f8flixPwviNAcMc0Eqiqtn//13mWG57IvF2DjgYmRyRJs
 wKnB7p/BWXeXbdqX3PpsyOZdHLjei3wDvX5Trt3ixDD/GIR9cZ0TzauNDl7qZ0EB4lWF5jFR2kA
 nkfmR03++1xE1oS6H1cHL7EHvjK4WN27MyuPvI3kAZnArMkz9RA6MGRCfnq0X29HPGSLp
X-Gm-Gg: AYBFou2ekdscT8rywAOuv2uGyq6tVjNu0sWq2W1f14oGf8owy3ji3KC62NJp3oNrfBb
 8sbBHvAKXRKKjJ2JxcvZyZsyU4wnl0WgH38qQD5PmvL1RmPSpjY9fNWP0K/2JZlyo0pRFpeZ1Nj
 pry8nxPrLr8H5sbtjLRCQmS8X6MUGwL7oeCRc66FmcANqxtyzGNeXckL1/DRNvLUPp8tw5izjT1
 be/4xmna3bnv8KbIlwtdLZt7ZD9Duv/2ce5+8dAJDbjFbbdG8ZhLr2rinEQK+yIlpb329VS+pin
 EsbWGvmrmR8dRz15xrlPdA1LtnrVAUEkzn3eI/l26wLf9aSFlQ2eAyJjrXHwMBKt5dXaUugnww1
 n3AFbuORPV8TGpR4yyOiAbHWKA2o18GYk0L8FIryzxd3EkiYnDSmV4prJIwWHleCSQGyxJUmwvK
 2eF+Nu15MREvhOScluTe2+EcdPyWKg/ybp72qdXF1T+XrCESoeiHzY4p0PPMt0EA3tktSgya79z
 G9z6ztZ4t2FGeh1eZdtfdZ8fE1zryTDH85+ez4LQFfR3aAk17MA4Ts5DJW3eyiENB/Dt+7vZvOG
 ULeVYN0lRQOsUcgBqRxUaQacRYDYqkL9nXbzkoVczCDPJtdvV0itfuxD1gsidw==
X-Received: by 2002:a05:600c:1551:b0:49c:fa21:1c89 with SMTP id
 5b1f17b1804b1-49cfa211d5fmr341524115e9.30.1788953045416; 
 Wed, 09 Sep 2026 04:24:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d20db6e76sm55826235e9.3.2026.09.09.04.24.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:24:04 -0700 (PDT)
X-Google-Original-From: "MaxF (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 11:24:03 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1906
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1906?usp=email>
X-Gerrit-Commit: 8020802fd71ee3fd49711e7faffa3a138ef19fac
In-Reply-To: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
References: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjA3MDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4a4db17547fd6b0d823db0bc23b3b8734df69dc8-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4GPU-0007Al-7o
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 don't allow '/' in config paths
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
From: "MaxF \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "MaxF \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6134689917948113266=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6134689917948113266==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Wb4opb6vbKU="; charset=UTF-8

--Wb4opb6vbKU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos, razvanc=2E

Hello c=
ron2, d12fk, plaisthos, razvanc, 

I'd like you to reexamine a change=2E Pl=
ease visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail
=

to look at the new patch set (#2)=2E


Change subject: openvpnserv: don't =
allow '/' in config paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

openvpnserv: don't allow '/' in config paths

Do not allow fo=
rward slashes in user provided config paths=2E The PathCch*
functions do no=
t treat them as path separators, leading to "/=2E=2E/" not
being canonicali=
zed=2E That, and the fact that Windows file APIs accept
forward slashes lea=
ds to possible directory traversal=2E

Discovered and reported by BreachX Z=
ero Day Labs, using Typhon AI Mil v2=2E
Contributing Researcher: Vivek Pari=
kh=2E

Reported-by: Vivek Parikh <vivek=2Eparikh@breachx=2Eai>
Tested-by: V=
ivek Parikh <vivek=2Eparikh@breachx=2Eai>
CVE: 2026-78043
Github: OpenVPN/o=
penvpn-private-issues#162
Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6=
087
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1885
Message-Id: <20260831184657=2E3332-1-gert@greenie=2Emu=
c=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcef=
orge=2Enet/msg38855=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
(cherry picked from commit eecebd88a38ffe1571d1a259da87f611b7b08e9c)=

---
M src/openvpnserv/validate=2Ec
1 file changed, 9 insertions(+), 6 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/06/1906/2

diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv/v=
alidate=2Ec
index b0fb6b85=2E=2E2740819 100644
--- a/src/openvpnserv/valida=
te=2Ec
+++ b/src/openvpnserv/validate=2Ec
@@ -65,15 +65,21 @@
 {
     WCHAR=
 tmp[MAX_PATH];
     const WCHAR *config_file =3D NULL;
-    const WCHAR *c=
onfig_dir =3D NULL;
+    const WCHAR *config_dir =3D s->config_dir;
+    si=
ze_t config_dir_len =3D wcslen(config_dir);
 
     /* fname =3D stdin is sp=
ecial: do not treat it as a relative path */
     if (wcscmp(fname, L"stdin=
") =3D=3D 0)
     {
         return FALSE;
     }
-    /* convert fname to =
full path */
-    if (PathIsRelativeW(fname) )
+    /* do not accept forwar=
d slashes in paths, as PathCch* functions do not handle these */
+    if (w=
cschr(workdir, L'/') || wcschr(fname, L'/'))
+    {
+        return FALSE;
=
+    }
+    /* convert fname to full canonical path */
+    if (PathIsRelat=
iveW(fname))
     {
         openvpn_swprintf(tmp, _countof(tmp), L"%ls\\%l=
s", workdir, fname);
         config_file =3D tmp;
@@ -83,9 +89,6 @@
      =
   config_file =3D fname;
     }
 
-    config_dir =3D s->config_dir;
-    =
size_t config_dir_len =3D wcslen(config_dir);
-
     /* check for a path se=
parator after config_dir */
     if (config_dir_len && config_dir_len < wcs=
len(config_file)
         && config_dir[config_dir_len - 1] !=3D L'\\'

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Change-Id: I371aafba18d33=
6bcfd3912e92c18301e39bf6087
Gerrit-Change-Number: 1906
Gerrit-PatchSet: 2
G=
errit-Owner: MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: d12fk <heiko@ope=
nvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: razvanc <razvanc@mail=
box=2Eorg>

--Wb4opb6vbKU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos, razvanc=2E </p>
<p>MaxF <strong>upl=
oaded patch set #2</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">openvpnserv: don&#39;t allow &#39;/&#39; in config paths<br><br>Do no=
t allow forward slashes in user provided config paths=2E The PathCch*<br>fu=
nctions do not treat them as path separators, leading to &quot;/=2E=2E/&quo=
t; not<br>being canonicalized=2E That, and the fact that Windows file APIs =
accept<br>forward slashes leads to possible directory traversal=2E<br><br>D=
iscovered and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E<=
br>Contributing Researcher: Vivek Parikh=2E<br><br>Reported-by: Vivek Parik=
h &lt;vivek=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek Parikh &lt;vivek=
=2Eparikh@breachx=2Eai&gt;<br>CVE: 2026-78043<br>Github: OpenVPN/openvpn-pr=
ivate-issues#162<br>Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087<br=
>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by=
: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1885<br>Message-Id: &lt;20260831184657=2E333=
2-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/op=
envpn-devel@lists=2Esourceforge=2Enet/msg38855=2Ehtml<br>Signed-off-by: Ger=
t Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>(cherry picked from commit eec=
ebd88a38ffe1571d1a259da87f611b7b08e9c)<br>---<br>M src/openvpnserv/validate=
=2Ec<br>1 file changed, 9 insertions(+), 6 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/06=
/1906/2</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpnserv/validate=2Ec b/src/openvpnserv=
/validate=2Ec</span><br><span>index b0fb6b85=2E=2E2740819 100644</span><br>=
<span>--- a/src/openvpnserv/validate=2Ec</span><br><span>+++ b/src/openvpns=
erv/validate=2Ec</span><br><span>@@ -65,15 +65,21 @@</span><br><span> {</sp=
an><br><span>     WCHAR tmp[MAX_PATH];</span><br><span>     const WCHAR *co=
nfig_file =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const WCHAR *config_dir =3D NULL;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const WCHAR *config_dir =3D s-&gt;config_dir;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size_t config_dir_len =3D=
 wcslen(config_dir);</span><br><span> </span><br><span>     /* fname =3D st=
din is special: do not treat it as a relative path */</span><br><span>     =
if (wcscmp(fname, L&quot;stdin&quot;) =3D=3D 0)</span><br><span>     {</spa=
n><br><span>         return FALSE;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* convert fname to full path */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (PathIsRelativeW(=
fname) )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* do n=
ot accept forward slashes in paths, as PathCch* functions do not handle the=
se */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (wcschr=
(workdir, L&#39;/&#39;) || wcschr(fname, L&#39;/&#39;))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return FALSE;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* convert fname to full canonical path */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (PathIsRelativeW(fname))</span>=
<br><span>     {</span><br><span>         openvpn_swprintf(tmp, _countof(tm=
p), L&quot;%ls\\%ls&quot;, workdir, fname);</span><br><span>         config=
_file =3D tmp;</span><br><span>@@ -83,9 +89,6 @@</span><br><span>         c=
onfig_file =3D fname;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    config_dir =3D s-&gt;config_di=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t config_d=
ir_len =3D wcslen(config_dir);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span>     /* check for a path separator after config_d=
ir */</span><br><span>     if (config_dir_len &amp;&amp; config_dir_len &lt=
; wcslen(config_file)</span><br><span>         &amp;&amp; config_dir[config=
_dir_len - 1] !=3D L&#39;\\&#39;</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Dem=
ail">change 1906</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1906?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1906 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12f=
k &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &l=
t;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Wb4opb6vbKU=--


--===============6134689917948113266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6134689917948113266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6134689917948113266==--

