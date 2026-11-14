Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021F1606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Io2oCVXm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OTdoEUGa;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lzXniZdl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cnfYnRDG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4CJfDI6hbDiCWMSr0Ujduf3kelKz317mYPHqIC9gjTg=; b=Io2oCVXmif9fwzcUNzwT4WMjGy
	NvjnvXBPYEBfrEzSiDCkpY67i73ys4fuiV9ABh8oZunzf0TxSLohMzJ/Nbc3hUfQjz0ghJEvgVVYa
	uH7DWe1lpyOL4NAhM0FOZKDtXLcQzcul1rTI7sBY+oYldDmVC/8OPp6oAWQCSCulZs+4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSIPo-000000003WJ-2wr9;
	Sat, 14 Nov 2026 18:23:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSIPn-000000003WD-3od1
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 18:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rH73FfhFo1GOZ5t9xR1tzczSAB3164heVQkrsP4a5p4=; b=OTdoEUGa0cw2RwviLhRU4UZoPh
 AmvdHlcDCXmaaDXjZVUdv0em9jtpIuldQMcPvUr15n+/qPJD13BeOQtwx2cm6OUaV62DvQgL1iHRN
 zv/LQSmZwMVvIJMWD6vvOmiGTHpW/JdokjvNDKFpvbDTzzyEtADzWzViHxM4ARQQdhD0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rH73FfhFo1GOZ5t9xR1tzczSAB3164heVQkrsP4a5p4=; b=lzXniZdlRi+mhbDR59TZ3XMCck
 0Zx3Y7p9gJAP2wejLVWXGnMAgFbPlMCFVD8vUKUiMfkoHqIkGJlnsbLPQpERNId07h87fsNLSP7xN
 sgCHJdJrOkeBpko2HZE12QFZcksB98oJAfapoh0oSDYHEkO8nJ1jTp46YIDWHEuGFtnc=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSIPm-000000003Wg-3V2I for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 18:23:51 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-490d59c3f0aso741501f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 10:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794680624; x=1795285424; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rH73FfhFo1GOZ5t9xR1tzczSAB3164heVQkrsP4a5p4=;
 b=cnfYnRDGhkWvU5dTmPzd/jX+TYtZpY6m7lpiUAUgRiMIHlHdGKIjqWEYiTE3kHbUTK
 mRVJvmccr6k4Mv7Eb6mKlOIx/V3em2nskGlQr1wYHq0jI7YZ+Ji6YTDjGwneFFywuPSV
 cZz7mUD20EuoAqB+XWnaC2YvUwY1DFmFx+O66YwwPO4ZtbdMQTpc/L1cj8LlnTSe58sT
 NU76hdM3ciRYKT77saRx1FD9c9gj8eqSthKHa1BXZrvNF6ii3GMdtn0+gliLrzXUss9c
 pnxqEuImOcBcJEBfdC6g4qNO8gSXDP2li+gC2hBUbc/WAOFkKoGGY1WkdSynVpssrk8x
 hx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794680624; x=1795285424;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rH73FfhFo1GOZ5t9xR1tzczSAB3164heVQkrsP4a5p4=;
 b=nvk/s8zBsiuSCYuS8VwRM7P812C5S/7wBv0zPWm9E6OrKO1qZNGWyi8CjUZgF7vdCg
 5rSdmuC49BZ5+p7HPu5iD1NQRVS1Dbsf3WOuwro4M3cE1514tKkYIqXmPu4s+e/pyg2Y
 L5KSChDteXY6GB0sm/bYnPk7oaKsd7GkkD8bAden5hsDsW4lfxo3vtgfwc3Ib+u/K8e7
 fa1A3SfxO1bOAIntRMzqbw8TX4ng1JsMfledA3cgkSeZPdxcamWPQRP3+yldu14i6dZA
 NfhUnJlZGYKlqKl2ZKcW5DCt0hiSS3gaVz8qcUteqLwPr/k9/KVzuZYOK8nmA9jeMQRy
 pTgg==
X-Forwarded-Encrypted: i=1;
 AL+hErErl+x9dw2AyALVfx+zFas37VVFPiWGwnJiA5Py76ZP61fRxI5RUhjV/V9e8clD/+FrwZBDlLeFhTEvS1//@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9SSG2zvh2ao4tQDuKhw/MbzD7oaLgU8TtHNeJezuNv8ZcfU04e
 1+VO+p/VX1GGdak97TPo+ssa0lZp75kQsDlmhrAArPJz3Nr/eg7pq2qPRwjhOush+89cKYzlwCS
 4AR+UbfbawZBKVXxKWjUglBrumocUsSMSq+qSgAC3/LUfePMcgNZetBXbcapqh0cfmx+v
X-Gm-Gg: AYBFou1zyR9GssrMsdLSd3DGyYkMVar/Q/JUABjJyRyO+NtNw/64T8W3+M7m9iFDvGy
 c7ojajwfXTr8XvZ7iYr3y3X4FqE/2UzG/1BNvQLx2qEPfZBayJzBzlN95EpCQrocZ2IVwgcqyMt
 QTz9M8QWlaBBqsBz/tdWFcEksvMPzLum1bfXVbXrQpni/J7PftJGI+F2M6kOq3LPrGrfAPZVMJa
 wfPkUibSQarfVUsT2M+1gWGVf4zarFShYKTY4RWgf0Dw3Yz61vMpjGW6OwDtXFuKhZEFlMm7iIM
 gIKhK7yvP/ODPSQ4qYpWYSeulBm13NTjrdK2W1H023+ixVbV+02Nr01WQBh0DVfG69euzQD0RU2
 ntRegqAGgl5kZRW1dE+iQTw7OMImdkC5PvbzGI3pxcKoYH1lfQFdoBbiJg40zoHv2xJeNztqgqt
 kHCX6NI8LCmTwM9TH3FXR5Bjw5C4IXGYNlUEjIjPf4HXUJNHUw+g+vzRs0Nj9nijFdTjH2iYpVC
 IqNU+12UtjBO3vI38KVc3gFwAfpo1LtgVzliY7Knc0BhF7SXP6dNY61caPJK4pFMLVA5dNTIwVG
 WpoOXIpF+/OhE6C9QBHVXdwGpDi5sdYx4DP0rGoIXpQ79pl4qynrh6VSZf2KtzlBXMMJvWAGHwk
 FKFEHrhIvgTtoArVxHGQ872TLsW2LyZbex1gD7fu+dXrh9Coymi3ypY4BWIPZadxBG2YEDyyIvh
 XcOpps1ViZyVO+ORo=
X-Received: by 2002:a05:6000:2882:b0:492:a72:9303 with SMTP id
 ffacd0b85a97d-49c723fc469mr12914541f8f.22.1794680624057; 
 Sat, 14 Nov 2026 10:23:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60f8d66esm10735385f8f.57.2026.11.14.10.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 10:23:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 18:23:43 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
X-Gerrit-Change-Number: 2118
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2118?usp=email>
X-Gerrit-Commit: ac62f4c017bac2b51bc9f2df9a6b4e0c28c0107c
In-Reply-To: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
References: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NTkxMDAwLkkwNGMxMjhhOTM0ZTlhMmU3NjczOTRkYmU4MjQyN2RmMmVlODg2MTc4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dc2897d68983bdc2e0fe3a8831bb67e2969564fe-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSIPm-000000003Wg-3V2I
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: drop the
 return value of verify_user_pass_management()
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
Content-Type: multipart/mixed; boundary="===============5553800966714764384=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5553800966714764384==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iw18GLUctOk="; charset=UTF-8

--iw18GLUctOk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2118?usp=3Demail )

Change subject: ssl_verify: drop the return=
 value of verify_user_pass_management()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_verify: drop the return value of verify_us=
er_pass_management()

The function cannot fail since a4eeef17 ("Add functio=
n for common env
setting of verify user/pass calls") moved the username che=
ck out of it,
so it always returned KMDA_SUCCESS and man_def_auth could nev=
er become
KMDA_ERROR=2E Make it void, track only whether deferred managemen=
t auth
is enabled, and drop the KMDA_* codes=2E

Change-Id: I04c128a934e9a2=
e767394dbe82427df2ee886178
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118
Message-Id: <20261104174350=
=2E15275-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40714=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify=2Ec
1 file c=
hanged, 6 insertions(+), 28 deletions(-)




diff --git a/src/openvpn/ssl_v=
erify=2Ec b/src/openvpn/ssl_verify=2Ec
index 1c3c6bf=2E=2E6e9ecb5 100644
--=
- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1546,18=
 +1546,9 @@
 
 
 #ifdef ENABLE_MANAGEMENT
-/*
- * management deferred inter=
nal ssl_verify=2Ec status codes
- */
-#define KMDA_ERROR   0
-#define KMDA_=
SUCCESS 1
-#define KMDA_UNDEF   2
-#define KMDA_DEF     3
-
-static int
+st=
atic void
 verify_user_pass_management(struct tls_session *session, const s=
truct user_pass *up)
 {
-    int retval =3D KMDA_ERROR;
     const struct k=
ey_state *ks =3D &session->key[KS_PRIMARY]; /* primary key */
 
     /* set=
 username/password in private env space */
@@ -1570,10 +1561,6 @@
     }
 
=
     setenv_del(session->opt->es, "password");
-
-    retval =3D KMDA_SUCCE=
SS;
-
-    return retval;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 
@@ -16=
38,12 +1625,7 @@
     ASSERT(up && !up->protected);
 
 #ifdef ENABLE_MANAGE=
MENT
-    int man_def_auth =3D KMDA_UNDEF;
-
-    if (management_enable_def=
_auth(management))
-    {
-        man_def_auth =3D KMDA_DEF;
-    }
+    c=
onst bool man_def_auth =3D management_enable_def_auth(management);
 #endif
=
 
     /* enforce character class restrictions in username/password */
@@ -=
1731,9 +1713,9 @@
     if (!skip_auth)
     {
 #ifdef ENABLE_MANAGEMENT
-  =
      if (man_def_auth =3D=3D KMDA_DEF)
+        if (man_def_auth)
        =
 {
-            man_def_auth =3D verify_user_pass_management(session, up);
=
+            verify_user_pass_management(session, up);
         }
 #endif
 =
        if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_=
PASS_VERIFY))
@@ -1761,11 +1743,7 @@
     bool script_ok =3D script_status =
=3D=3D OPENVPN_PLUGIN_FUNC_SUCCESS
                      || script_status =
=3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED;
 
-    if (script_ok && plugin_ok && t=
ls_lock_username(multi, up->username)
-#ifdef ENABLE_MANAGEMENT
-        &&=
 man_def_auth !=3D KMDA_ERROR
-#endif
-    )
+    if (script_ok && plugin_o=
k && tls_lock_username(multi, up->username))
     {
         ks->authentica=
ted =3D KS_AUTH_TRUE;
         if (plugin_status =3D=3D OPENVPN_PLUGIN_FUNC=
_DEFERRED
@@ -1774,7 +1752,7 @@
             ks->authenticated =3D KS_AUTH_=
DEFERRED;
         }
 #ifdef ENABLE_MANAGEMENT
-        if (man_def_auth !=
=3D KMDA_UNDEF)
+        if (man_def_auth)
         {
             if (skip=
_auth)
             {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2118?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I04c128a934e9a2e767394dbe82427df2ee886178
Gerrit-Change-Number: 2118
Gerr=
it-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--iw18GLUctOk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2118?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">ssl_verify: drop the return value =
of verify_user_pass_management()<br><br>The function cannot fail since a4ee=
ef17 (&quot;Add function for common env<br>setting of verify user/pass call=
s&quot;) moved the username check out of it,<br>so it always returned KMDA_=
SUCCESS and man_def_auth could never become<br>KMDA_ERROR=2E Make it void, =
track only whether deferred management auth<br>is enabled, and drop the KMD=
A_* codes=2E<br><br>Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178<br=
>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2118<br>Message-Id: &lt;20261104174350=2E1=
5275-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom=
/openvpn-devel@lists=2Esourceforge=2Enet/msg40714=2Ehtml<br>Signed-off-by: =
Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/ssl_ve=
rify=2Ec<br>1 file changed, 6 insertions(+), 28 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</sp=
an><br><span>index 1c3c6bf=2E=2E6e9ecb5 100644</span><br><span>--- a/src/op=
envpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span=
><br><span>@@ -1546,18 +1546,9 @@</span><br><span> </span><br><span> </span=
><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * m=
anagement deferred internal ssl_verify=2Ec status codes</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define KMDA_ERROR   0</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define KMDA_SUCCESS 1</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define KMDA_UNDEF   2</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define KMDA_DEF     3</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span> verify_user_pass_management(struct tls_session *session,=
 const struct user_pass *up)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int retval =3D KMDA_ERROR;</span><br><span>  =
   const struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* prim=
ary key */</span><br><span> </span><br><span>     /* set username/password =
in private env space */</span><br><span>@@ -1570,10 +1561,6 @@</span><br><s=
pan>     }</span><br><span> </span><br><span>     setenv_del(session-&gt;op=
t-&gt;es, &quot;password&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    retval=
 =3D KMDA_SUCCESS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return retval;</span=
><br><span> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><=
br><span> </span><br><span>@@ -1638,12 +1625,7 @@</span><br><span>     ASSE=
RT(up &amp;&amp; !up-&gt;protected);</span><br><span> </span><br><span> #if=
def ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    int man_def_auth =3D KMDA_UNDEF;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (management_enable_def_auth(management))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        man_def_auth =3D KMDA_DEF;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const bool man_def_auth =3D management_enable_def_auth(management);<=
/span><br><span> #endif</span><br><span> </span><br><span>     /* enforce c=
haracter class restrictions in username/password */</span><br><span>@@ -173=
1,9 +1713,9 @@</span><br><span>     if (!skip_auth)</span><br><span>     {<=
/span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (man_def_auth =3D=3D KMDA_DEF)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (man_def_auth)</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          man_def_auth =3D verify_user_pass_management(session, up);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            verify_user_pa=
ss_management(session, up);</span><br><span>         }</span><br><span> #en=
dif</span><br><span>         if (plugin_defined(session-&gt;opt-&gt;plugins=
, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))</span><br><span>@@ -1761,11 +1743,=
7 @@</span><br><span>     bool script_ok =3D script_status =3D=3D OPENVPN_P=
LUGIN_FUNC_SUCCESS</span><br><span>                      || script_status =
=3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (script_ok &amp;&amp; plugin_ok &am=
p;&amp; tls_lock_username(multi, up-&gt;username)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &amp;&amp; man_def_auth !=3D KMDA_E=
RROR</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    )</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (script_ok &amp;&amp; plugin_ok &amp;&a=
mp; tls_lock_username(multi, up-&gt;username))</span><br><span>     {</span=
><br><span>         ks-&gt;authenticated =3D KS_AUTH_TRUE;</span><br><span>=
         if (plugin_status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED</span><br><s=
pan>@@ -1774,7 +1752,7 @@</span><br><span>             ks-&gt;authenticated=
 =3D KS_AUTH_DEFERRED;</span><br><span>         }</span><br><span> #ifdef E=
NABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (man_def_auth !=3D KMDA_UNDEF)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (man_def_auth)</span><br><span>         {</span=
><br><span>             if (skip_auth)</span><br><span>             {</span=
><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2118?usp=3Demail">change 2118</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2118?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886=
178 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2118 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--iw18GLUctOk=--


--===============5553800966714764384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5553800966714764384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5553800966714764384==--

