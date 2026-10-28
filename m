Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2BF606A336
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ERzTHexQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QDT0rNHO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MyoQwz7U;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TCQC+R4o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=2FKpr7Vtz2+WIVgh7OPpskVwRFL/T4l6+rhCAUGcNmc=; b=ERzTHexQwlW4kgsgs+/kdAyFpY
	QuQxYt54uvP11LEwShRjgbpe6sFWyAtQbgAwVWA7SqfMKvyijp6K7lg+mMdC7JY/1+43I6DNVq9LS
	wB4nQp6qGiy0pEUyH4c80q7/G2VNuOn/lox9Dhbowqyk7mV74iZS3CmkWYF2Ll2ZCk/M=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8bz-000000001sG-0UA5;
	Wed, 28 Oct 2026 18:42:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8bx-000000001sA-04w5
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:42:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1p5OOz7s19pNAyYtfgYrk6ECJEj2HU4L/97Ymp0ztPU=; b=QDT0rNHOGZz+82HR9Z68vhjM4G
 GqyBo+H4iYMrr0bbLkAA1m055zFhfQsuKl/AxnDa2J5eD2PzmAdC6J+vDRSBTbklb8h6cZyRU7BQK
 cuDQkwh0Tiv1Jo9hZ4kT46SZ7DY69KIWNSB67a0ZU+oqLzzGFcKkX8olm9KnVeSVx+l4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1p5OOz7s19pNAyYtfgYrk6ECJEj2HU4L/97Ymp0ztPU=; b=MyoQwz7U5hXhBrCkrYGz29W5DN
 Figs+28iKqitcmXdUvhUaEJvOiLLTMtHqon7hC50w6tQkHtTgYf/Iqvltv89bf9fwbwm8RiltBNEu
 e5+bD7q3OwZuGMcH+PlSki1Tsuhxq3OEXoAEmDdbgRwtPyPkHXw+GVI2nAmzlE1kCp6k=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8bv-0000000084E-27ac for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:42:56 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4956869750eso9379635e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793212969; x=1793817769; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1p5OOz7s19pNAyYtfgYrk6ECJEj2HU4L/97Ymp0ztPU=;
 b=TCQC+R4oQHVHw1raxtCUS2crOftyj7ZsFbDn6INZw3FCvLuQ1UlGS5zELht/qsunAr
 gvox0vhq2priBXXCZhtiXLzutKZI7JoKgr91c1bQrGj6t/4A9RpwnB/wzmaz/uPcg9Ce
 Yx81CXjWNMC6NPRGHQu6i/z9hP9XNchm+5XILBefgPbOLWSVh7HmEgoUWX24m2Ld+KBp
 hcDWcaqvQXZo+fauU4MTeteF2TnZ4VvJBfda5l7ArEsIY8Ejn3SKybE4bS/4mqLUq3S8
 1baGgiojDvbJBr1+OizajuVau6Qed1loSJSyjn5Er0njlEn+azd1Js6T6ClIXPVKfj0B
 J2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212969; x=1793817769;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1p5OOz7s19pNAyYtfgYrk6ECJEj2HU4L/97Ymp0ztPU=;
 b=cOfRwQzh7Qt1Hd2grfHNHKBMQCFMoTIakzRG+ki2AIi/yrbtSlPGozl5I2aKRPtYiE
 +6TPFOTsKdMFDB1U+R4pBHpVj2jRsLy2dL6nZplELWr3/nhavs8bwAY0AWKuihmjI6JT
 EeZW15fq51nILnTGzU2f6lHXmXIkOpcRfqzfw7wicr11FOkLBxBTg6hFYsAM7aIo0rKa
 QMFj3Tn1CLhemQkEsIvHWDMSj08HmWt5h2Mms8zmaRbQ+ywWe2w+RwXMbM/qaay2MB/O
 PQQCfZ/MkhauHV+NVYFP4zfbJgVo1lp0EIdbtNuLNAh/aIxInp+J+Od0bW1FArY0y31F
 CfPw==
X-Gm-Message-State: AFq9FYLucalmMS7grXkteIIARlKcXThgsweeHt0IToqgE5s9meI/R8vi
 a7uIiEgWmsSnQ5kcN0xOrXCEj6N8p/BOYxvVKc+HLNnWsrS2p8LTclDF4xl3905S0LhS5pfOFDO
 8rJAXZXLUPQ3ZACuiHUe4gJaoprrjVylqQeXH5g06LZLgFvj27lgn6gO2BKdtXU/ZOOP7NFDz7k
 py7NA6MA==
X-Gm-Gg: AYBFou0QjVWc4B9SGxhMMLbZN5VySBRYK+JTtD6OmEaz3lVvwTgTM1Y/HkcHUloCZHm
 7jDpwkvHqukoVKZXY5JXmKF45NugRRQxER0oJu6Z4UvxJvIp1Vp8+aa3yfRoUsjuaf0WW475oNh
 y+etlgnR5J6lLWyhZDtqU8ULOFbvPMjlBUa+F++QsPOK6SAjo39/TJEUe/IDV+4i4ubj/HoH1Ha
 xKzgPm3ax+IGyd1yMyoUpwrLFNBUCe1k81vK9OblMR5QMuIIWSWEDVhOmZrH3D4JDXbwftlhwlG
 WxE8Km2a4TvFDdH3onB3Au3CmwCShav3HlTZDTAyhCdCMhGS8/7so5oBh3MPDmLeCFMWp0H1Ufr
 dHLt0GoeNuQ/lH5e94aUfxv7kjeBTIUo6wGXq/sXbDQJtymuk1DR29xNuyYsTuYplbZnbZEXz0d
 +691opkVG74vV6Y0CXfUyKMf59wRNEJ8fz2EvqUxWU5nsBg/cMXUCXCchWdtJcuWHqQ+tpzM+tK
 S/fAGPDVljII89NJVvaD07fzU0ErcgQuZReLmj048CgcB1U35N43ZAulR6UB2I6tszm7luXYhjz
 VSv58GG+Pv17tPQuzPcKmKQd2+ttAxGt4McyrRI/e48v2DaEJhDdQvDIi32AY9sHSh7EEn9Ld1X
 8ppqDhSP9QiyecRiGIgiOlk0s2F1obCaVlzYYuRRMSS5C8sVB08Vf0AmgPhf14UQdzo6CzxReT8
 YNlND6Jld/MP3LWRWlhU7IKscjRQ4n+jJh5l6F
X-Received: by 2002:a05:600c:6206:b0:4a2:59:f568 with SMTP id
 5b1f17b1804b1-4a9661ab56dmr66687345e9.14.1793212968582; 
 Wed, 28 Oct 2026 11:42:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7c5063e3sm10945985e9.0.2026.10.28.11.42.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:42:48 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:42:47 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: ad26ba310eb387d5558d527898bda4e17a0c2783
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <520536f9bbbcad46826c56979d051414ed9a1188-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM8bv-0000000084E-27ac
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD 'Auth' prompt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2086731550288703586=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2086731550288703586==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yp4ZdbNiVH8="; charset=UTF-8

--Yp4ZdbNiVH8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2069?usp=3Demail

to review the following change=2E
=


Change subject: Optionally indicate username in >PASSWORD 'Auth' prompt
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Optionally in=
dicate username in >PASSWORD 'Auth' prompt

When username is included in th=
e config file as inlined or
read from a file, indicate it as a preferred-us=
ername in
>PASSWORD Need 'Auth' username/password prompt=2E The prompt
is a=
ppended with "UN:foo64" where foo64 is the pre-defined
username, base64 enc=
oded=2E

This is treated as a hint, not an enforced value=2E The management=

client still responds with both username and password obtained
from the us=
er=2E Whether the the management client allows the
user to input a differen=
t username is left to the client
implementation=2E

Only clients that annou=
nce version >=3D6 are prompted this way=2E

This helps to fix user reports =
on OpenVPN-GUI not respecting username
set in the config file=2E

Change-Id=
: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Signed-off-by: Selva Nair <selv=
a=2Enair@gmail=2Ecom>
---
M doc/management-notes=2Etxt
M src/openvpn/manage=
=2Ec
2 files changed, 43 insertions(+), 0 deletions(-)



  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/2069/1

diff --git a/d=
oc/management-notes=2Etxt b/doc/management-notes=2Etxt
index eac91a4=2E=2E0=
757c75 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=
=2Etxt
@@ -394,6 +394,28 @@
   response along with the username and passwor=
d formatted as described
   in the Challenge/Response Protocol section belo=
w
 
+  Example 10:
+
+    >PASSWORD:Need 'Auth' username/password UN:<user-=
base64>
+    >PASSWORD:Need 'Auth' username/password UN:<user-base64> SC:1,=
Please enter token PIN
+
+  These work exactly as Examples 3 and 8, resepct=
ively, with the following
+  difference=2E The prompt has an addiitonal wor=
d "UN:<user-base64>" where
+  <user-base64> is the base64 encoded form a pr=
e-defined username=2E This
+  may be a username inlined in the config file =
or read from an external
+  user-pass file=2E
+
+  The management client is=
 expected to show the base64 decoded value to
+  the user=2E Whether the us=
er can change this username or not is left to
+  the client implementation=
=2E
+
+  The response from the management client should follow the same for=
mat
+  as in example 3 or example 8, as applicable=2E
+
+  This prompt is s=
hown only if the management-client announces a
+  version >=3D 6=2E Older c=
lients will see the prompt shown in Example 3
+  or 8=2E
+
 See the "Challe=
nge/Response Protocol" section below for more details
 about examples 8 and=
 9, including how the management interface client
 should respond=2E
@@ -53=
0,6 +552,7 @@
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
    =
 >PASSWORD:Need 'Auth' username -- version 4 or greater
     multiline pass=
word from client -- version 5 or greater
+    preferred username in >PASSWO=
RD prompt -- version 6 or greater
 
 COMMAND -- auth-retry
 ---------------=
------
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index 0=
fc9ee2=2E=2Ec5344cb 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/m=
anage=2Ec
@@ -71,6 +71,7 @@
     MCV_PKSIGN_ALG =3D 3,
     MCV_USERNAME_ON=
LY =3D 4,
     MCV_MULTILINE_PASSWORD =3D 5,
+    MCV_PREFERRED_USERNAME =
=3D 6,
 };
 
 struct management *management; /* GLOBAL */
@@ -3670,6 +3671,=
25 @@
             buf_printf(&alert_msg, " MSG:%s", up->username);
       =
  }
 
+        if (up_query_mode =3D=3D UP_QUERY_USER_PASS
+            && =
(man->connection=2Eclient_version >=3D MCV_PREFERRED_USERNAME)
+           =
 && up->username[0])
+        {
+            /*
+             * The buffer =
up is prefilled with username from auth-file or inline=2E
+             * I=
ndicate it in the prompt as base64 encoded=2E
+             */
+           =
 char *user64 =3D NULL;
+            if (openvpn_base64_encode(up->username=
, (int)strlen(up->username), &user64) !=3D -1)
+            {
+            =
    buf_printf(&alert_msg, " UN:%s", user64);
+            }
+            e=
lse
+            {
+                msg(M_NONFATAL, "ERROR: could not base6=
4-encode username");
+            }
+            free(user64);
+        }
 =
        if (sc)
         {
             buf_printf(&alert_msg, " SC:%d,%s",=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iac23d5141a8c29e=
239d0f2aeea497d3a002e609b
Gerrit-Change-Number: 2069
Gerrit-PatchSet: 1
Ger=
rit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>

--Yp4ZdbNiVH8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Selva Nair would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Optionally indicate username in &gt;PASSWORD &#39;Auth&#39; promp=
t<br><br>When username is included in the config file as inlined or<br>read=
 from a file, indicate it as a preferred-username in<br>&gt;PASSWORD Need &=
#39;Auth&#39; username/password prompt=2E The prompt<br>is appended with &q=
uot;UN:foo64&quot; where foo64 is the pre-defined<br>username, base64 encod=
ed=2E<br><br>This is treated as a hint, not an enforced value=2E The manage=
ment<br>client still responds with both username and password obtained<br>f=
rom the user=2E Whether the the management client allows the<br>user to inp=
ut a different username is left to the client<br>implementation=2E<br><br>O=
nly clients that announce version &gt;=3D6 are prompted this way=2E<br><br>=
This helps to fix user reports on OpenVPN-GUI not respecting username<br>se=
t in the config file=2E<br><br>Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a=
002e609b<br>Signed-off-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br>-=
--<br>M doc/management-notes=2Etxt<br>M src/openvpn/manage=2Ec<br>2 files c=
hanged, 43 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/2069/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span=
><br><span>index eac91a4=2E=2E0757c75 100644</span><br><span>--- a/doc/mana=
gement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span><=
br><span>@@ -394,6 +394,28 @@</span><br><span>   response along with the us=
ername and password formatted as described</span><br><span>   in the Challe=
nge/Response Protocol section below</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  Example 10:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &gt;PASSWORD:Need &#39;Auth&#39; username/password UN:&lt;user=
-base64&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;=
PASSWORD:Need &#39;Auth&#39; username/password UN:&lt;user-base64&gt; SC:1,=
Please enter token PIN</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  These work exa=
ctly as Examples 3 and 8, resepctively, with the following</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  difference=2E The prompt has an ad=
diitonal word &quot;UN:&lt;user-base64&gt;&quot; where</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  &lt;user-base64&gt; is the base64 enco=
ded form a pre-defined username=2E This</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  may be a username inlined in the config file or read =
from an external</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  u=
ser-pass file=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  The management clien=
t is expected to show the base64 decoded value to</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  the user=2E Whether the user can change thi=
s username or not is left to</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  the client implementation=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  The response from the management client should follow the same format</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  as in example 3 or e=
xample 8, as applicable=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This promp=
t is shown only if the management-client announces a</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  version &gt;=3D 6=2E Older clients will=
 see the prompt shown in Example 3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  or 8=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> See the &quot;Challenge/Response Protocol&quot; sect=
ion below for more details</span><br><span> about examples 8 and 9, includi=
ng how the management interface client</span><br><span> should respond=2E</=
span><br><span>@@ -530,6 +552,7 @@</span><br><span>     &gt;PK_SIGN:[base64=
],[alg]     -- version 3 or greater</span><br><span>     &gt;PASSWORD:Need =
&#39;Auth&#39; username -- version 4 or greater</span><br><span>     multil=
ine password from client -- version 5 or greater</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    preferred username in &gt;PASSWORD prompt =
-- version 6 or greater</span><br><span> </span><br><span> COMMAND -- auth-=
retry</span><br><span> ---------------------</span><br><span>diff --git a/s=
rc/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 0fc9ee=
2=2E=2Ec5344cb 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><b=
r><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -71,6 +71,7 @@</spa=
n><br><span>     MCV_PKSIGN_ALG =3D 3,</span><br><span>     MCV_USERNAME_ON=
LY =3D 4,</span><br><span>     MCV_MULTILINE_PASSWORD =3D 5,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    MCV_PREFERRED_USERNAME =3D 6,<=
/span><br><span> };</span><br><span> </span><br><span> struct management *m=
anagement; /* GLOBAL */</span><br><span>@@ -3670,6 +3671,25 @@</span><br><s=
pan>             buf_printf(&amp;alert_msg, &quot; MSG:%s&quot;, up-&gt;use=
rname);</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (up_query_mode =3D=3D UP_QUERY=
_USER_PASS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &amp;&amp; (man-&gt;connection=2Eclient_version &gt;=3D MCV_PREFERRED_US=
ERNAME)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&amp;&amp; up-&gt;username[0])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
         * The buffer up is prefilled with username from auth-file or inlin=
e=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * =
Indicate it in the prompt as base64 encoded=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            char *user64 =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (openvpn_base64_encode=
(up-&gt;username, (int)strlen(up-&gt;username), &amp;user64) !=3D -1)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                buf_printf(&amp=
;alert_msg, &quot; UN:%s&quot;, user64);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                msg(M_NONFATAL, &quot;ERROR: could not base64-encode =
username&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   free(user64);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span>         if (sc)</span><br><span>         {</span><b=
r><span>             buf_printf(&amp;alert_msg, &quot; SC:%d,%s&quot;,</spa=
n><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2069?usp=3Demail">change 2069</a>=2E To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2069?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e=
609b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2069 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>

</body></html>
--Yp4ZdbNiVH8=--


--===============2086731550288703586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2086731550288703586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2086731550288703586==--

