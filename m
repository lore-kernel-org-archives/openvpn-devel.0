Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC74606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MNfK9kCE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bGABMGfW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=V9ULgoDc;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Gv30y+NY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bNWw4rRaE/ZDkSn6OEcJVyAeIMjeR7krPhfCzZ2HtuQ=; b=MNfK9kCEp0e7d/iiiSGQHH6T8I
	pvKxT8IWCPGovrSw86EHO+HPe58jv7KdT67EHeuOXZuFl1UJywzZbJ151mTAmVw1h9kQ0V3zWKrse
	9bSb8nunJLwx5U+AOd/Iy08/xui7N0kl/KuOF8TdBGAabymaMuJVGfcOCUB/N12/4v3E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMciR-000000003Cm-1X35;
	Fri, 30 Oct 2026 02:51:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMciQ-000000003Cf-2Yz2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 02:51:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jhYMpd18vpYJeOhDgyWj07Ob/FFAHfw5JU53kypB7FM=; b=bGABMGfWZS4sWM292Hd4xfeD7M
 yaYTj6A9nNA8HIjU58+DKcwBA6CP0Xz04UryYF4KSUfa8Zz3ZXlrmyKreqQkqQUwT9uzh1oFUcuT2
 o6nxPH9y2VaMmwG6R7llcG94anZHBAEU19ucYUdlZE+9bMWYcF8vZHxM/5gGXE5gxxOg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jhYMpd18vpYJeOhDgyWj07Ob/FFAHfw5JU53kypB7FM=; b=V9ULgoDcceDlctunuEVaFtF4Kx
 KtArKlb4w/TTXWQMDIjWw8ogHZZfbr+fCzKdMlR0yx+B7GAfnNOst3LNMqcbJwWvfLZw3nNZFjwIB
 wDkVOWwpPAF39wfWZuAofv/6GDz9ai+L5xYf31eRr2leN/HP7nRrtVS7kkGcybMVfEVs=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMciP-000000005BS-0JfK for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 02:51:38 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so1340815e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 19:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793328690; x=1793933490; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jhYMpd18vpYJeOhDgyWj07Ob/FFAHfw5JU53kypB7FM=;
 b=Gv30y+NY2VfR4MKCypERz42Q5/ZJmJWU8WKbPBYe3aV3EUG/WFyDYBB+rU8KoWmwNQ
 h9RGmunG1g/3AKYiFd9S6zD+CUEoG4nG6nLSVY5PDIZ32GI2zSmiK3jikwRI8Xc0dKSf
 69hyD887lpkpUVKD6WuViXbinfsYiZqnqx1kppadOdfEwAAQIccX8faxvByUxhhHRA9Q
 mwqLhE1Tnaz4QDcChHKlDqXXZzuLWAoLLnzfLhuwAsiwD/6IHGkYniSKx7OqB2Ctms8s
 4KSs8jyncnTSKseUCkxh44SyzzCqI1GCOdlqbx9uEbEcJT8YT1Tygq40dFo1+j3PFjI+
 ci5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793328690; x=1793933490;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jhYMpd18vpYJeOhDgyWj07Ob/FFAHfw5JU53kypB7FM=;
 b=yS+TYxD+sMR0bcPdAYB87ac+jEVVVI/Yy443YmC1DUkBzNlgvnprwGCtyA4/g4z4WP
 Aby5T5fGmLS9FTR4djyDQsTKK0pPBF/RPcUPSYN8Kd0tDhLhZ/kX4YkqY8kaKEDfKRWN
 eeqq3Sr4FVUNhrC3oX6G+60fLJADkyf4j4xde4z2c/ZBJpxdPeUGc6hkRiBh6C+L3xqE
 kZ+s0FOuXPuO0YMhvwcrK0J9sSZOf1XhC8/aDIMcAwt9Zkx9y/AziD1DyaqghKDA5tby
 dl/NXqm8gLDppN2YE5cj6PWPXIYtjM4h/XRXUr9A2VjeEcSeKjaRrJrrNs5BZWPwGFzC
 gJ/w==
X-Gm-Message-State: AFq9FYKXdevdcGja+ievHdmbs8tD1bA0FW7PeJqVLY5DYOnfzhi+YjK9
 2Lja8Lid9UTnAsRezidSJy49kWy7hz+q5ZsNz4/zxCAc1cKrOqQV/GdVQRX43nRreIvT927B6iD
 wXlDKM7HfTabDiwy5hh3UvqEHRQ6GcNNj5mPlLOBRV+ytY2CZf4nTTAcoVkz7g+6OjcOj
X-Gm-Gg: AYBFou0xSqFB1qhchwZSRoztbPWW4jr/xu0NzmAeUOees9sYeMKijUb0JXoyvxV3me3
 B3nY6PPZVDbBt4QwqqzcSwkqkmMnZvpfEzFVqH7jT1VMBAAzVcgWjpG/lFKeTbJOSLWFF7QqqKj
 QgoLI+1bJIgY6s/Lwy+wMZlOZHga+VIEcaIeiTR4kpd/dGpw1vm4WucZMY+GuPdSBL2WQlfNemi
 Gulq3k6jcku+M98iDi1Xmoa7kLNAJ1lpDoBIX8oPgDPOCs+t00/5/WiVyIRQu2A3BZ3zFUM4/Ah
 +Q/uXrhDlNdEQUcxiWEz26D1Ec+cOp4a4MuV8rgs4ZPwBurWqpbhbvtUeHr6JMLgBFyGo+/X0Nz
 xzEMcNP8zOH4CSgQ5XLxQ8+OD5lmpLDSrWeRBBT2cRaeC5xDJ+OG/KrRhTpQY81d/KgeRCQys7g
 3G8RRD9FiP8Ed06UftQ1cNOqk7w7WG22Lc/jpQhQgOIfRWaf98t5c7fk+PBkx2ujnldk2eizBkQ
 kviT9r23iaefUMvCfgjoRmZcYZJJPhm7nNcVf3t/XccPVoDreLhM48Wlf5fSaGtpsqq1Yic1CFo
 GtGmyujRvezLbKnRTsIqZ4nWuGaWKSfUe0U1MOp+KV8Li91VNEOEaIkhtT0AQwFh+ejyXrhjXxl
 8Lta+pg1MTof7z28eJc3G+O55vCvttx6GteSU3CUsRd/LMV2NenkATdISgSXx3bpLI6wdn+J6Rw
 hvaduYiKG5cbBE+wU=
X-Received: by 2002:a05:600c:46d1:b0:4a1:825a:56fd with SMTP id
 5b1f17b1804b1-4ac18a88fa6mr18095945e9.32.1793328690334; 
 Thu, 29 Oct 2026 19:51:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa80f04785sm105639235e9.4.2026.10.29.19.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 19:51:30 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 02:51:28 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: 971f07290d2686ee2f082a305030d27a782a6dce
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f6233b8389c9555a6c6dff4f06cb36521c3e7c44-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMciP-000000005BS-0JfK
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
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5268054753675586004=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5268054753675586004==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZfcdgQySD4g="; charset=UTF-8

--ZfcdgQySD4g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Hello Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Coj=
ocaru, 

I'd like you to reexamine a change=2E Please visit

    https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail

to look at the new patch=
 set (#3)=2E

The following approvals got outdated and were removed:
Code-R=
eview-1 by R=C4=83zvan Cojocaru


Change subject: Optionally indicate usern=
ame in >PASSWORD 'Auth' prompt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Optionally indicate username in >PASSWORD 'Auth' prompt=


When username is included in the config file as inlined or
read from a fi=
le, indicate it as a preferred-username in
>PASSWORD Need 'Auth' username/p=
assword prompt=2E The prompt
is appended with "UN:foo64" where foo64 is the=
 pre-defined
username, base64 encoded=2E

This is treated as a hint, not an=
 enforced value=2E The management
client still responds with both username =
and password obtained
from the user=2E Whether the management client allows=
 the
user to input a different username is left to the client
implementatio=
n=2E

Only clients that announce version >=3D6 are prompted this way=2E

Th=
is helps to fix user reports on OpenVPN-GUI not respecting username
set in =
the config file=2E

Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Si=
gned-off-by: Selva Nair <selva=2Enair@gmail=2Ecom>
---
M doc/management-not=
es=2Etxt
M src/openvpn/manage=2Ec
2 files changed, 44 insertions(+), 0 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/69/2069/3

diff --git a/doc/management-notes=2Etxt b/doc/management-note=
s=2Etxt
index eac91a4=2E=2E5a8ec54 100644
--- a/doc/management-notes=2Etxt
=
+++ b/doc/management-notes=2Etxt
@@ -394,6 +394,28 @@
   response along wit=
h the username and password formatted as described
   in the Challenge/Resp=
onse Protocol section below
 
+  Example 10:
+
+    >PASSWORD:Need 'Auth' u=
sername/password UN:<user-base64>
+    >PASSWORD:Need 'Auth' username/passw=
ord UN:<user-base64> SC:1,Please enter token PIN
+
+  These work exactly as=
 Examples 2 and 8, respectively, with the following
+  difference=2E The pr=
ompt has an additional word "UN:<user-base64>" where
+  <user-base64> is th=
e base64 encoded form of a pre-defined username=2E This
+  may be a usernam=
e inlined in the config file or read from an external
+  user-pass file=2E
=
+
+  The management client is expected to show the base64 decoded value to
=
+  the user=2E Whether the user can change this username or not is left to
=
+  the client implementation=2E
+
+  The response from the management clien=
t should follow the same format
+  as in example 2 or example 8, as applica=
ble=2E
+
+  This prompt is shown only if the management-client announces a
=
+  version >=3D 6=2E Older clients will see the prompt shown in Example 2
+=
  or 8=2E
+
 See the "Challenge/Response Protocol" section below for more d=
etails
 about examples 8 and 9, including how the management interface clie=
nt
 should respond=2E
@@ -530,6 +552,7 @@
     >PK_SIGN:[base64],[alg]     =
-- version 3 or greater
     >PASSWORD:Need 'Auth' username -- version 4 or=
 greater
     multiline password from client -- version 5 or greater
+    p=
referred username in >PASSWORD prompt -- version 6 or greater
 
 COMMAND --=
 auth-retry
 ---------------------
diff --git a/src/openvpn/manage=2Ec b/sr=
c/openvpn/manage=2Ec
index 0fc9ee2=2E=2E65e2881 100644
--- a/src/openvpn/ma=
nage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -71,6 +71,7 @@
     MCV_PKSIGN_ALG=
 =3D 3,
     MCV_USERNAME_ONLY =3D 4,
     MCV_MULTILINE_PASSWORD =3D 5,
+ =
   MCV_PREFERRED_USERNAME =3D 6,
 };
 
 struct management *management; /* G=
LOBAL */
@@ -3670,6 +3671,26 @@
             buf_printf(&alert_msg, " MSG:%=
s", up->username);
         }
 
+        if (up_query_mode =3D=3D UP_QUERY_=
USER_PASS
+            && (man->connection=2Eclient_version >=3D MCV_PREFER=
RED_USERNAME)
+            && up->username[0])
+        {
+            /*
+=
             * The buffer up is prefilled with username from auth-file or i=
nline=2E
+             * Indicate it in the prompt as base64 encoded=2E
+  =
           */
+            char *user64 =3D NULL;
+            if (openvpn_=
base64_encode(up->username, (int)strlen(up->username), &user64) !=3D -1)
+ =
           {
+                buf_printf(&alert_msg, " UN:%s", user64);
+  =
          }
+            else
+            {
+                msg(M_NONFATA=
L, "ERROR: could not base64-encode username");
+            }
+            =
free(user64);
+        }
+
         if (sc)
         {
             buf_pri=
ntf(&alert_msg, " SC:%d,%s",

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2069?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Gerrit-Change-Num=
ber: 2069
Gerrit-PatchSet: 3
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--ZfcdgQySD4g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Selva Nair <strong>uploaded patch set #3</strong> to this chang=
e=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=
=3Demail">View Change</a></p><p>The following approvals got outdated and we=
re removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Optional=
ly indicate username in &gt;PASSWORD &#39;Auth&#39; prompt<br><br>When user=
name is included in the config file as inlined or<br>read from a file, indi=
cate it as a preferred-username in<br>&gt;PASSWORD Need &#39;Auth&#39; user=
name/password prompt=2E The prompt<br>is appended with &quot;UN:foo64&quot;=
 where foo64 is the pre-defined<br>username, base64 encoded=2E<br><br>This =
is treated as a hint, not an enforced value=2E The management<br>client sti=
ll responds with both username and password obtained<br>from the user=2E Wh=
ether the management client allows the<br>user to input a different usernam=
e is left to the client<br>implementation=2E<br><br>Only clients that annou=
nce version &gt;=3D6 are prompted this way=2E<br><br>This helps to fix user=
 reports on OpenVPN-GUI not respecting username<br>set in the config file=
=2E<br><br>Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b<br>Signed-o=
ff-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt;<br>---<br>M doc/manageme=
nt-notes=2Etxt<br>M src/openvpn/manage=2Ec<br>2 files changed, 44 insertion=
s(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/69/2069/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/ma=
nagement-notes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index eac=
91a4=2E=2E5a8ec54 100644</span><br><span>--- a/doc/management-notes=2Etxt</=
span><br><span>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -394,6 +=
394,28 @@</span><br><span>   response along with the username and password =
formatted as described</span><br><span>   in the Challenge/Response Protoco=
l section below</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  Example 10:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;PAS=
SWORD:Need &#39;Auth&#39; username/password UN:&lt;user-base64&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    &gt;PASSWORD:Need &#39;A=
uth&#39; username/password UN:&lt;user-base64&gt; SC:1,Please enter token P=
IN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  These work exactly as Examples 2 a=
nd 8, respectively, with the following</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  difference=2E The prompt has an additional word &quot;=
UN:&lt;user-base64&gt;&quot; where</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  &lt;user-base64&gt; is the base64 encoded form of a pre-de=
fined username=2E This</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  may be a username inlined in the config file or read from an external<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  user-pass file=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  The management client is expected to =
show the base64 decoded value to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  the user=2E Whether the user can change this username or not=
 is left to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the cl=
ient implementation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The response f=
rom the management client should follow the same format</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  as in example 2 or example 8, as appl=
icable=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  This prompt is shown only i=
f the management-client announces a</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  version &gt;=3D 6=2E Older clients will see the prompt sh=
own in Example 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  o=
r 8=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> See the &quot;Challenge/Response Protocol&quot; section below for more=
 details</span><br><span> about examples 8 and 9, including how the managem=
ent interface client</span><br><span> should respond=2E</span><br><span>@@ =
-530,6 +552,7 @@</span><br><span>     &gt;PK_SIGN:[base64],[alg]     -- ver=
sion 3 or greater</span><br><span>     &gt;PASSWORD:Need &#39;Auth&#39; use=
rname -- version 4 or greater</span><br><span>     multiline password from =
client -- version 5 or greater</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    preferred username in &gt;PASSWORD prompt -- version 6 or gr=
eater</span><br><span> </span><br><span> COMMAND -- auth-retry</span><br><s=
pan> ---------------------</span><br><span>diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec</span><br><span>index 0fc9ee2=2E=2E65e2881 10=
0644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src=
/openvpn/manage=2Ec</span><br><span>@@ -71,6 +71,7 @@</span><br><span>     =
MCV_PKSIGN_ALG =3D 3,</span><br><span>     MCV_USERNAME_ONLY =3D 4,</span><=
br><span>     MCV_MULTILINE_PASSWORD =3D 5,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    MCV_PREFERRED_USERNAME =3D 6,</span><br><span> =
};</span><br><span> </span><br><span> struct management *management; /* GLO=
BAL */</span><br><span>@@ -3670,6 +3671,26 @@</span><br><span>             =
buf_printf(&amp;alert_msg, &quot; MSG:%s&quot;, up-&gt;username);</span><br=
><span>         }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (up_query_mode =3D=3D UP_QUERY_USER_PASS</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (man=
-&gt;connection=2Eclient_version &gt;=3D MCV_PREFERRED_USERNAME)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; up-&gt;=
username[0])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             * The buf=
fer up is prefilled with username from auth-file or inline=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+             * Indicate it in the=
 prompt as base64 encoded=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            char *user64 =3D NULL;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (openvpn_base64_encode(up-&gt;username, =
(int)strlen(up-&gt;username), &amp;user64) !=3D -1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                buf_printf(&amp;alert_msg, &quo=
t; UN:%s&quot;, user64);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      msg(M_NONFATAL, &quot;ERROR: could not base64-encode username&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(user64);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if =
(sc)</span><br><span>         {</span><br><span>             buf_printf(&am=
p;alert_msg, &quot; SC:%d,%s&quot;,</span><br></pre><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">change 2=
069</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2069 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Na=
ir &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>

</body></html>
--ZfcdgQySD4g=--


--===============5268054753675586004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5268054753675586004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5268054753675586004==--

