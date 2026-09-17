Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1A3C982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 10:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JJg7gT7PoSvNM5yvtJ53zYAgyyu9+pwEC8w9bJ+Vk+0=; b=VIvyM5BvDwenu8cHJSu7CxDuT3
	InSc3akZqZa5tL5VkSzT5JRxw+5QFuEMBgm7IfuBKCT1JffBpWg1qe5A95z0EDeROetnSyBiT01rj
	uRTUxg4X+SBzKofJZ2dedeZATResGtVZ9anqAYZ+S3K8LWXaauu4vpDn76wRWV1eoGns=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x79lI-0003HH-Kr;
	Thu, 17 Sep 2026 10:54:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x79lF-0003Gq-Dp
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 10:54:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SiqgPsVTsQTM4Ejt217esEUgk/h2sCdu2znaiHwk1t4=; b=Hripm6owByOGtfKiP82oQhr7s4
 g9VDzP4iAG5NHotMZYTjR/aCPBzfW2tBPe3u6DPtZ82rxG28OIFKBjRwOrZHyH8gK3yGtrdR0wXTf
 3vyENQ3sDjH8XkYa0J79CD2MOqANUpQxK2sKih+Xw9AO7Mysx9OG89hn0ZAwTunJLwWM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SiqgPsVTsQTM4Ejt217esEUgk/h2sCdu2znaiHwk1t4=; b=H
 Sn3df0h8sTiXxJo96d4peP2j3abfVBqQBemhxCHIxBghUsmgWJEyk2FuenjdkCXHcU0My60h2ltmt
 Xbz+wO7rmeyaYmYWiERhxMHXjEEJqjOnO/GAZkXDmP5NqnaYTnuIyT+aFGcPyGN3twFJiYBG37sM7
 p9HICxB+ab+CUFlU=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x79kq-00064N-W8 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 10:54:14 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48437356d60so369153f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 03:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789642446; x=1790247246; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SiqgPsVTsQTM4Ejt217esEUgk/h2sCdu2znaiHwk1t4=;
 b=Xw9lq+66TJbK8kKd+4frF1qkvcMiQdQC/23yXk65Q2sPGciHuXZgm6L+Tb0Tp/gRay
 XlL2a0ArcFrJHKmHinliQZIUxQ5MpoGrL3Nou+fq+AQEV/KrItbq/DA0Hei6GIEzmM+J
 csXjAGDItwyO9Ga9NRxkPGbYO/O2g1fXx3loryVd+y3VZtm/tJjk6hWZ8JQZieJgHKUA
 4HQ9gN5jEAyKiI7xnB9XW5xJC5enpZywXIROG1s8ShHrR05yrWZ51Xd/qUE4h674tTmJ
 bT6rGrwRbuUUTpcVyKljPZ/FnxClIcrxamBJyPhxnY2xhJlMiogYUpQ7AFvyGttJbRuM
 f1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789642446; x=1790247246;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SiqgPsVTsQTM4Ejt217esEUgk/h2sCdu2znaiHwk1t4=;
 b=lGv0Oba4i5J0LT3K7MYC0GxPSmRgmFwX8qcs12O4iMo3s7sW/N+8spCTTyc3ZlGa/p
 Gdbtklw43/Gj37QEEfVyAC7uTlGpe93L3sP/D1+1/Szyt/aK3kQp3XXPd7AcYCqe6qCp
 SOeyZvvEIT1wrnnVyOlHdLz29JHR7g/ajuReX8PW+Q6In9R1/m4UOAyJFXDOvIkkL0QE
 eV6Q7EwphTefZhPTIQYvtFBETLCcKnN6VkG5RPcqha/ZHdaIV7xEl41I0dYgkSK5DvLI
 X/+sBcqgogR9tNxkdNEzdaxexSA16S2u3gC6Yl2lC9u2e8yXlerdzL6MnS6AZR8InMy2
 JurA==
X-Gm-Message-State: AFuF++mqIeLQGh8wsT6ka7+CteWmvxwcoZeUhPnvZ2AU2ziBQqbUg/5W
 cAaJJKl59hpcMbnCW7LOJv1sB+xafuxlsxb49pTJDU4wDpv5NQ94veC00dy6kp30Fo8D4KH46x5
 o0uuMq0UgN+W6gBxfWMhpGzBlVoaOI9kAuCvukNDdzsZ1F3ruYvrnrKn8feKPEox3/TLS/p45WL
 i+fuIBUA==
X-Gm-Gg: AYBFou031qnQKTsqdp1ReTSOYWLuFjSSrhgdVN36hhjWNlRpDvOL+EYvNGlwRt1r2tB
 MvuacF0kp1PWyGHEw2O4r10r/5JGNIAYJuRxzj0tfrZa1YLfc/phAlO5ewWWcuzTucZH+cI59vr
 hWkvnJTegcda6xUiNSfvzvGv3xN+6mD9YmcQ6LocxxiE9J72AC+2Tdf8IJbKl6ZPeIGTjrXppB6
 gwcgynJW4FSFRZi0zi5lZ99uc7s/ZxgGCZiDiJYJRwGqgJAtE/3swOR5Z2Wp3o2O7nczqYHmLS8
 1CV0WQI0YHLfO4VSLseJDx8dEIyAsvaR030qx2DzOKMYq3LQzvGRH2YYyjLnpHmRnOlFMMsmESQ
 UXIcVlVkSmysfxu0sA+JSzoSEIRjPghlwykSqC9lyzYq8KGWAom+OF56IjBb+lkQZuhoerBiU5e
 j4WzCuPVsexoQkHALBAypjo1G0Ko+aJSyrNetLisgqZopDRHhDL4gQtFUmbKogtZRILSyE0F4tX
 hKl37Mfp6wrRbhx6Ioqh10MROCwvuN4dD91PiDBB7IRrjgh8sRAzvehdlh0CTy6WoP+hWintopH
 9+jQnaMIscTdOYC9I1Uryq+5WaLbMRuF3FzwfgmxcHfmM0ArE5gh5Ne4qRtk2Y78WeJ1HwOIGg=
 =
X-Received: by 2002:a5d:5f43:0:b0:487:732:9964 with SMTP id
 ffacd0b85a97d-4870cf38810mr8132707f8f.13.1789642446263; 
 Thu, 17 Sep 2026 03:54:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm16199688f8f.23.2026.09.17.03.54.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 03:54:05 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 10:54:04 +0000
To: plaisthos <arne-openvpn@rfc2549.org>,
	razvanc <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
X-Gerrit-Change-Number: 1918
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1918?usp=email>
X-Gerrit-Commit: 17f6cec06fbced967cb64338c83e902e949ece95
In-Reply-To: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
References: <gerrit.1789560307000.Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTYwMzA3MDAwLkliZjcyMzhiYWRlMmFlZDgxYWM3ZmU0ZmRhMmFmNThlMDkxZGM4Y2QwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <61889cababbf5a8ed3d4e44a3ae1686ada520496-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x79kq-00064N-W8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Improve auth token
 related comments
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5066626771941108850=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5066626771941108850==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5rpawZQ6xJs="; charset=UTF-8

--5rpawZQ6xJs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
razvanc


Change subject: Improve auth token related comments
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Improve auth token relate=
d comments

Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
Signed-off=
-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <r=
azvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1918
Message-Id: <20260916203425=2E21448-1-gert@greenie=2Emuc=2Ede>
URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g39269=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M s=
rc/openvpn/auth_token=2Ec
M src/openvpn/auth_token=2Eh
2 files changed, 4 i=
nsertions(+), 6 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:2941=
8/openvpn refs/changes/18/1918/2

diff --git a/src/openvpn/auth_token=2Ec b=
/src/openvpn/auth_token=2Ec
index f928a41=2E=2Eb457b6f 100644
--- a/src/ope=
nvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=2Ec
@@ -22,7 +22,7 @@
 #de=
fine AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_LENGTH(AUTH_TOKEN_SES=
SION_ID_LEN))
 
 /* We want our token to be a multiple of 3 bytes to avoid =
the base64 padding */
-static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0=
, "AUTH_TOKEN_SESSION_ID_LEN needs to be multiple a 3");
+static_assert(AUT=
H_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, "AUTH_TOKEN_SESSION_ID_LEN must be mul=
tiple of 3");
 
 #define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH
 /* Siz=
e of the data of the token (not b64 encoded and without prefix) */
@@ -34,7=
 +34,7 @@
 
 /* Ensure that TOKEN_DATA_LEN is a multiple of 3 so the we avo=
id the base64
  * padding */
-static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, "T=
OKEN_DATA_BASE64_LEN is not a multiple of 3");
+static_assert(TOKEN_DATA_LE=
N % 3 =3D=3D 0, "TOKEN_DATA_LEN is not a multiple of 3");
 
 bool
 is_auth_=
token(const char *password)
diff --git a/src/openvpn/auth_token=2Eh b/src/o=
penvpn/auth_token=2Eh
index fd8317d=2E=2E62ac012 100644
--- a/src/openvpn/a=
uth_token=2Eh
+++ b/src/openvpn/auth_token=2Eh
@@ -109,16 +109,14 @@
 #defi=
ne SESSION_ID_PREFIX "SESS_ID_AT_"
 
 /**
- * Return if the password string=
 has the format of a password=2E
+ * Return if the password string has the =
format of an auth token=2E
  *
- * This function will always read as many b=
ytes as SESSION_ID_PREFIX is longer
- * the caller needs ensure that passwo=
rd memory is at least that long (true for
- * calling with struct user_pass=
)
  * @param password
  * @return whether the password string starts with t=
he session token prefix
  */
 bool
 is_auth_token(const char *password);
+
=
 /**
  * Checks if a client should be sent a new auth token to update its
 =
 * current auth-token

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1918?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0
Gerrit-Change-Number: 1918
G=
errit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--5rpawZQ6xJs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by razvanc</p><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">Improve auth token relate=
d comments<br><br>Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0<br>S=
igned-off-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1918<br>Message-Id: &lt;20260916203425=2E21448=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39269=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/auth_token=
=2Ec<br>M src/openvpn/auth_token=2Eh<br>2 files changed, 4 insertions(+), 6=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/18/1918/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/a=
uth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index f928a41=2E=
=2Eb457b6f 100644</span><br><span>--- a/src/openvpn/auth_token=2Ec</span><b=
r><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -22,7 +22,7 @@<=
/span><br><span> #define AUTH_TOKEN_SESSION_ID_BASE64_LEN (OPENVPN_BASE64_L=
ENGTH(AUTH_TOKEN_SESSION_ID_LEN))</span><br><span> </span><br><span> /* We =
want our token to be a multiple of 3 bytes to avoid the base64 padding */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static_assert(AUTH_TOKE=
N_SESSION_ID_LEN % 3 =3D=3D 0, &quot;AUTH_TOKEN_SESSION_ID_LEN needs to be =
multiple a 3&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static_assert(AUTH_TOKEN_SESSION_ID_LEN % 3 =3D=3D 0, &quot;AUTH_TOKEN_SES=
SION_ID_LEN must be multiple of 3&quot;);</span><br><span> </span><br><span=
> #define AUTH_TOKEN_HMAC_LEN   SHA256_DIGEST_LENGTH</span><br><span> /* Si=
ze of the data of the token (not b64 encoded and without prefix) */</span><=
br><span>@@ -34,7 +34,7 @@</span><br><span> </span><br><span> /* Ensure tha=
t TOKEN_DATA_LEN is a multiple of 3 so the we avoid the base64</span><br><s=
pan>  * padding */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_BASE64_LEN is not =
a multiple of 3&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static_assert(TOKEN_DATA_LEN % 3 =3D=3D 0, &quot;TOKEN_DATA_LEN is not =
a multiple of 3&quot;);</span><br><span> </span><br><span> bool</span><br><=
span> is_auth_token(const char *password)</span><br><span>diff --git a/src/=
openvpn/auth_token=2Eh b/src/openvpn/auth_token=2Eh</span><br><span>index f=
d8317d=2E=2E62ac012 100644</span><br><span>--- a/src/openvpn/auth_token=2Eh=
</span><br><span>+++ b/src/openvpn/auth_token=2Eh</span><br><span>@@ -109,1=
6 +109,14 @@</span><br><span> #define SESSION_ID_PREFIX &quot;SESS_ID_AT_&q=
uot;</span><br><span> </span><br><span> /**</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * Return if the password string has the format of a =
password=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retur=
n if the password string has the format of an auth token=2E</span><br><span=
>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function =
will always read as many bytes as SESSION_ID_PREFIX is longer</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * the caller needs ensure that pas=
sword memory is at least that long (true for</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * calling with struct user_pass)</span><br><span>  =
* @param password</span><br><span>  * @return whether the password string s=
tarts with the session token prefix</span><br><span>  */</span><br><span> b=
ool</span><br><span> is_auth_token(const char *password);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span=
>  * Checks if a client should be sent a new auth token to update its</span=
><br><span>  * current auth-token</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1918?usp=3De=
mail">change 1918</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1918?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>=

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"=
display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ge=
rrit-Change-Id: Ibf7238bade2aed81ac7fe4fda2af58e091dc8cd0 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1918 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>

</body></html>
--5rpawZQ6xJs=--


--===============5066626771941108850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5066626771941108850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5066626771941108850==--

