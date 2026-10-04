Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B808CA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2OEiL1vmxP15Oe/pFZcunIoyRtT4+7iRoELQuLfQKz8=; b=OBn3CAn01F0QvXkCU3nyzWTcUz
	oIXrEw0LGxjwbtjq3EHxh0F4yFNZTQokVH6lL9uONocPQRoH74G5oQ24M9eHSoWRvq/LXRsWVKYD1
	38hjlRWQ5SBBRbbmFIDWfQKOkePi0GKM3fA9wJrmTuCQjeen4ZO1V+jGg4jC0l3TldWw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDJPK-0005tA-FD;
	Sun, 04 Oct 2026 10:25:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDJPJ-0005sw-KN
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=s2fKL+qJf66TO40vVlVDBTY/Rwu2G0O3rIlaNbEuNNM=; b=kelEsEp6zsl5qgPStuNzee6Oki
 LwwQ3xX1WUScs7arbDzHeKniy34c7EeDIlFz51kLe66HtprhBfzHk69C7ywqIqqz5SV/mUICEAMNu
 hAr6speF80nAB9MV4Vlfge6SMSahg6G1Cjan+9DpinN8Ogcyd73mnhj+pitHoDIGR9Fk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s2fKL+qJf66TO40vVlVDBTY/Rwu2G0O3rIlaNbEuNNM=; b=E
 5sL2L9XBMd3EuEAPDz29m2Sz1HahC2u5hHwEAxFDRq9LwbI4KE8mPhy9Y3CmJBzMC6OsaZv+54mVY
 1HV2QCgUPPOmN09W8zLJDIH9+zb59VnqDQ6x5+D1N81cP9K45hznBFiNpNSFk9VmlOZumNRymTbRb
 ietbPo9R8gD1jKc8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDJPJ-00048U-MN for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 10:25:26 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b06bb6e40so638861f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791109519; x=1791714319; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=s2fKL+qJf66TO40vVlVDBTY/Rwu2G0O3rIlaNbEuNNM=;
 b=PirQ2+HErwx/5+kIQOHmn0/T/Uk9q2/KiIYbKatYmBgPSGoSVnwLdbVtL/kx6J3fwE
 bVnEUVy8ROt5Jfmr46x/2791sNg+LMtIzZ9i0rxiStATjGfayFzhXuGLgF1Ij6TYUNNr
 Lfva1jSAVFyFZK3UiSWrUbuq5KSKbrjRxAHBkuq7e6kN4S997xsDQZTMVu/NX0lIC7Ji
 G6bMnBWZm+kmi+7XBoYaxCSVVhwOLqtQOlcqqb9zuswMspl8hvB73c4e60N/XU4+8hwb
 yyfqqtKFjfXctJN6KeciUiCFOVJPb7LD0/IE8g5nfE5y2Eyhv5J4t9msEKqarcU1b4HC
 eEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791109519; x=1791714319;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=s2fKL+qJf66TO40vVlVDBTY/Rwu2G0O3rIlaNbEuNNM=;
 b=wilAqy/gd5PWpsBGpXZWnnJCtNFrk98I57k6AJfwVvxkfoxx0Qxc65NVGQNLX2C7PR
 9p7JUYUEpHoPsTtKmJ8RzvT+g24OK9iiZY+D73Ck5lOItgy4Rm6/moBPrmMYyXEtIWiD
 nk8ktizYGHFAcEewUZLhmXLh0Ri8NaDTmDtudnaLFu+4muxaMeChYCCqZ2TpibM1gZX1
 Z6TxSFKQetBZfTGYaeBDM3LlquOvYF0rJMfkyoJPEWrbjSz7/zIx6kAg2tGQ0ds1BI9R
 Ub/ZhyR+SXQmsfj5LGTbPA41K5Riwfew4OxzbOqTe4moihM5wNKgA8uKmxf/lrF+mfUZ
 BUOw==
X-Gm-Message-State: AFq9FYJDko/ikAlwlCZwNCqqL4GR0XwtVcHGKEbLI1yVZVktnGxtuvRC
 plWV3388mtJ2Lu1kqJ4zMWG19nqbpDXpqfuyYSUGY7Vi+AJ7wc6zh5kwyB3qLHCUtD6LgiBwb67
 t8kIHd6uv9zWJg6cis8PKDoxNrwiMo9jJnnT8UooxSuBAjaXXW/+vgPml2rSQ89AcSIUL
X-Gm-Gg: AYBFou0lsx5UR3W9aJPmrupjEJmU3o6vW2Y5Gqlc1weBmtqjW9LEnSuerkgHeY2Rcuq
 6XYNlWwmfBgvi9fak34Fp/5M6X9ZEyuig6oJsNgTEcw3u+h1Ylg/oifbC9DNiJNFmMr/QkuWUzG
 e/OPvpp1VB7Mw5wOuQ1GyuOCYTAlLC9GOLC0tH5P8P9BcAzJJSlFteTqE/jC/m3mdynOzBquDTp
 Ts5fechOvYqnyXmTMAWVwA04I46dPKESR3rSqPIxuV0RWGLbIz8ioCwGqG0t+LI3b0F45uExiV/
 QopRl1TN/q94B9vwim3/SUpkaRoypd150FAUK/IDPsxg6/Jy+Wm92+opj7/W3W3M/7qHQlGpDpU
 GbOtm/Dd4fmiHtu5dN5bVKEXQH7uQR3YOvhPc3/13YtwFkhwU7/b1S/SNy+dmC73wltSaqYUY9S
 2pNuCGfxiii5FepxKqgBJJ6VCazGPW6uATNgzELGdVQrLcgI+M7yfGXC5HVKLpEfJD9Z1zMw/zL
 sJ0ylWVEWtGETfa1iAJ4ksy5f95Vo440iWHENj6g21NP0EcZ09Lx9zZpO+fCHAUWm7ZNZLk8NeD
 N9M8EFaThcSeeGrsVRqwRhoH7e/xu23X17tHYpyc6AdbUGjYDM+v/jzpXqNiXksq211/Ucw=
X-Received: by 2002:a05:6000:2c01:b0:48c:a08:5858 with SMTP id
 ffacd0b85a97d-48c47fd0eb2mr8603926f8f.23.1791109518807; 
 Sun, 04 Oct 2026 03:25:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380fa61csm18152322f8f.17.2026.10.04.03.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 03:25:18 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 10:25:17 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
X-Gerrit-Change-Number: 890
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/890?usp=email>
X-Gerrit-Commit: cb0aa9691012e936da7a1099e6e3e746500e531e
In-Reply-To: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
References: <gerrit.1739361204000.I22e4b73e744c765a43bdb29f6e18813d103ea757@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzM5MzYxMjA0MDAwLkkyMmU0YjczZTc0NGM3NjVhNDNiZGIyOWY2ZTE4ODEzZDEwM2VhNzU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <901550c27065eff4155970243ad8d64516db6e12-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDJPJ-00048U-MN
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Always use a
 0.0.0.0/0 default on Android instead of def1
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8082010011972052599=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8082010011972052599==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/ZdMYxpBJHo="; charset=UTF-8

--/ZdMYxpBJHo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by plaisthos=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Gert Doering


Change subject: Always use a 0=2E0=2E0=2E0/0 defaul=
t on Android instead of def1
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Always use a 0=2E0=2E0=2E0/0 default on Android instead of=
 def1

Certain handset manufacturers (like Samsung iirc)  are handling
0=2E=
0=2E0=2E0/0 different from the split /1 routes, so push the 0=2E0=2E0=2E0/0=

route to the OS=2E

Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
S=
igned-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/890
Message-Id: <20261004100035=2E860-1-gert@greenie=2Emuc=2Ede>
URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39=
688=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/=
openvpn/options=2Ec
1 file changed, 7 insertions(+), 0 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/890/4

dif=
f --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 3316053=
=2E=2E5d10390 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -5625,7 +5625,14 @@
             }
             else if (streq(p[j=
], "def1"))
             {
+#ifndef TARGET_ANDROID
+                /* The =
hack that def1 uses to split 0=2E0=2E0=2E0 into 0=2E0=2E0=2E0/1 and
+      =
           * 128=2E0=2E0=2E0/1 is not needed on Android and will even
+    =
             * make some Android implementations (e=2Eg=2E Samsung)
+      =
           * misbehave, so silently ignore the flag and always use
+       =
          * 0=2E0=2E0=2E0/0 instead */
                 options->routes->fl=
ags |=3D RG_DEF1;
+#endif
             }
             else if (streq(p[j], =
"bypass-dhcp"))
             {

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/890?usp=3Demail
To unsubscribe, or for help writing mail=
 filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757
Gerrit-Change-Numb=
er: 890
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan=
 Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>

--/ZdMYxpBJHo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by plai=
sthos=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?us=
p=3Demail">View Change</a></p><p>The following approvals got outdated and w=
ere removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">Always use a =
0=2E0=2E0=2E0/0 default on Android instead of def1<br><br>Certain handset m=
anufacturers (like Samsung iirc)  are handling<br>0=2E0=2E0=2E0/0 different=
 from the split /1 routes, so push the 0=2E0=2E0=2E0/0<br>route to the OS=
=2E<br><br>Change-Id: I22e4b73e744c765a43bdb29f6e18813d103ea757<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doering &l=
t;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/890<br>Message-Id: &lt;20261004100035=2E860-1-gert@greenie=2Em=
uc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2E=
sourceforge=2Enet/msg39688=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/options=2Ec<br>1 file changed=
, 7 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/90/890/4</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>in=
dex 3316053=2E=2E5d10390 100644</span><br><span>--- a/src/openvpn/options=
=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -5625=
,7 +5625,14 @@</span><br><span>             }</span><br><span>             =
else if (streq(p[j], &quot;def1&quot;))</span><br><span>             {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TARGET_ANDROID</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* Th=
e hack that def1 uses to split 0=2E0=2E0=2E0 into 0=2E0=2E0=2E0/1 and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 * 128=2E=
0=2E0=2E0/1 is not needed on Android and will even</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 * make some Android impleme=
ntations (e=2Eg=2E Samsung)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                 * misbehave, so silently ignore the flag and alway=
s use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   * 0=2E0=2E0=2E0/0 instead */</span><br><span>                 options-&g=
t;routes-&gt;flags |=3D RG_DEF1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span>             }</span><br><span>        =
     else if (streq(p[j], &quot;bypass-dhcp&quot;))</span><br><span>       =
      {</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/890?usp=3Demail">change 890</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/890?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: I22e4b73e744c765a43bdb29f6=
e18813d103ea757 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 8=
90 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=
=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"=
display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--/ZdMYxpBJHo=--


--===============8082010011972052599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8082010011972052599==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8082010011972052599==--

