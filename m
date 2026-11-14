Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11282606A323
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LmKgzEXA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=I5lMQ07P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aB7D8IMJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BqfX052z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Lkf0MrUVzyEqkYOyPlgSXThUQ39ukZvjNnbitBleXvA=; b=LmKgzEXAH3+0jF+NXHaHwaIJ6u
	QVwekqWGVVvDDRRNAlOeRLJNpMXcdwZvKbrowZIgHpXHNlBEx4AeEimRpjAdYCHATknHsJyT0CZx1
	pAGLUxtlRCqUGWvYkecGyJepXHWU1pSQZZ3ZJBIS0tm/xuThgbbJ/LvVsrGU7WZOLID8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSIPp-000000000zl-3EOC;
	Sat, 14 Nov 2026 18:23:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSIPn-000000000zf-457v
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 18:23:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RpQh/tuS7fqc7Qk3KpWHf7Bn1YOvkhvQ9Uzav37Z+Q0=; b=I5lMQ07PPAGSYi2R5uUGlMF7Wi
 gELRCEKnUhcWMYJnSROoDAD2JzaijykZtsNIivkXSG9FR3DYD7cQrTtVTt72mUvuSlHNLTzjBYaQZ
 SyOYENOqj9yCNRx/4B5TkPWHBKh3GyRuTRRV5ucOv0ny/29j3HYasbFv0d/5isg4kplM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RpQh/tuS7fqc7Qk3KpWHf7Bn1YOvkhvQ9Uzav37Z+Q0=; b=aB7D8IMJAn9aJTfpejGcAlXhKz
 hiX8Vt+4UVM8DvB0MTdo5S4IM1kHW30j6UMtFBixYnx1MRbyuXYSRXOgmdOjCf2O5WZ0Vmh4g1iC0
 SRmwWRydgyuLhstPIjROgphs/mxfE0HMhAHP9pIHHEZ9hqaEd2dSUMk+cbsOaWqkVdhw=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSIPm-000000003Cb-0TiW for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 18:23:51 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so2475960f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 10:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794680623; x=1795285423; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RpQh/tuS7fqc7Qk3KpWHf7Bn1YOvkhvQ9Uzav37Z+Q0=;
 b=BqfX052zCJCj0XaRfz3q+H6EEFVlcUQc6PER2Yr+l6/Ykuwhh1B7XbPvuoIUwaSJhO
 P0hNRaDl0T2FUsWrk0R+J7ykqMw9s9GJ6bLA2qj+IIypGkoDLEzGsAzyfunJZFw+BMwI
 SkYBYrg9epU43RXjab9I70ZY9E0GGQ5Y0WwkAK8+9wRKSxGuB643kLBu7DbSbPN/5xgd
 jeFJ3YsQaS903HE/Ra+uT/NjgbsplCINKE3TzrzTZoGEYfr8Y1oEt83/TiQY7Df1H4lc
 9GmWTy7H13LuLnRBMWwJCxBtZrhIwr942MqGdrhHUACj7Ex7rpJdmyOg+qHbPdRNM1BM
 Dzyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794680623; x=1795285423;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RpQh/tuS7fqc7Qk3KpWHf7Bn1YOvkhvQ9Uzav37Z+Q0=;
 b=JHv4RyNsmR7Bg5mbxYYE+EtNH/eiETIFkl8GEBpOMzvHTxzUsJ0btA9SzIBDM4Tcpq
 2ed82JHcjiOPReNVYIoGomrQSY/Dk6eeXPfZQf4o3A+rqHXLooouekcCqK2uP0Act1pK
 KC/TZPcOlJxisQ13o6+3ibbzYO3qBL9Y2DhWiMBfBtYEyHKYxHiOZZuJRTclv5Pt8/Av
 +N6PYidWavozI/5vdpJoPpT6oolOAL9/zLIMiUxkcWdzlpQnSJL6pgUDuXmVK9v0XdU1
 8MHZYqPz3y1LU5m7HxbwVrvJLMVetv3ZcraxNRm6vokLlsJaH33Vo9TJ4m0B7T0QCI9V
 4XTg==
X-Gm-Message-State: APuU4Z8vSK+BJOfCpghGD/muk673cai853ARGuUSroWwfYZPv3GkiMPJ
 GiBhgtOFcNQJuMtN7u2z8A8D5Fe8gInpgI7pAweUc5j6HS+A/QCOBpFfS8qK3Dg5ro7nausVP33
 earqEuUEig4GrcDsAoZrb7G8Vfx436uiBZjSSVWlhplwwJPTItLNvLJofTItmQBvafZGs
X-Gm-Gg: AYBFou14WqdNjIU7mvOrQIMNKA6wZ4HUHte0a04rTUqUhj/gPD4hvc0K01ONqvOYRUx
 n/pImreFEt127EwIJdE8lzRrxhawFvlCCHXrfN4Vrbd6kQHKKF5RAAjLGu/YphxopQFjRjMtrC9
 +7X9aa82yc9k2moWLzDvPy7KXsnFIr7IH4QSuhqr8OWN4Lv1ho9lO0171Y3tE9AvHCrwWfnrL0G
 DfvAUKYYoamFsCwVhXbcBg2yS0n2iegzP8/mLReV4cZVAJIoRS6R4/J0s1CANqp1hD4wPLMJejf
 V+4qfU3nmDsOVK7aGoRsiDw6sSbOI+0MIvL7sDq7t8ZCR1N7wa5oAwf7ZxalbCto4ABaslcqnLS
 PgTHhpOLW1M1dt4+bROwCvinwKAftQyt33o+3qpunES5u9CuKtzV9jtS8IoZWvh+FJXnz9Qdjn3
 qZXaSKSTKhVAAGOX5Vxo+B2Db+W1aHtUoH48slvswTMTh8yUMd8RS7jiGK+tpIY88pH9K1WYjRJ
 3wCLcyY9AbGuGEFxGeOdZ/Cz1bo4iqiUjG7JYBGay0x0RgHm0P/x0E1iKOh82IQZIqt/iVtup86
 JMYCd/UVu6ZajOwKgeHu28rTADFaCuVjB9HzvtnXh/r4Gjv/2x+FbiVH+Nai/rlJbslYWiP/YYh
 gBo06We+QhAumjSDVxESR9WOvJV7rT+9ltGZ6KzKDW2Ogwj6WiHCUpKTToLwzg6zKZYYsNVK6zO
 oCDm8uodqDPsWZnkA=
X-Received: by 2002:a05:6000:40cb:b0:492:b880:53a7 with SMTP id
 ffacd0b85a97d-49c6d453ec2mr15995321f8f.5.1794680623284; 
 Sat, 14 Nov 2026 10:23:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c60021375sm11460716f8f.29.2026.11.14.10.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 10:23:42 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 18:23:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
X-Gerrit-Change-Number: 2118
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2118?usp=email>
X-Gerrit-Commit: ac62f4c017bac2b51bc9f2df9a6b4e0c28c0107c
In-Reply-To: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
References: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NTkxMDAwLkkwNGMxMjhhOTM0ZTlhMmU3NjczOTRkYmU4MjQyN2RmMmVlODg2MTc4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dc2897d68983bdc2e0fe3a8831bb67e2969564fe-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSIPm-000000003Cb-0TiW
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6303093648899554648=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6303093648899554648==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RBNwUxlVPlY="; charset=UTF-8

--RBNwUxlVPlY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2118?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: ssl_verify: drop the=
 return value of verify_user_pass_management()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_verify: drop the return value of ver=
ify_user_pass_management()

The function cannot fail since a4eeef17 ("Add f=
unction for common env
setting of verify user/pass calls") moved the userna=
me check out of it,
so it always returned KMDA_SUCCESS and man_def_auth cou=
ld never become
KMDA_ERROR=2E Make it void, track only whether deferred man=
agement auth
is enabled, and drop the KMDA_* codes=2E

Change-Id: I04c128a9=
34e9a2e767394dbe82427df2ee886178
Signed-off-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118
Message-Id: <2026110417=
4350=2E15275-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg40714=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_verify=2Ec
1 fi=
le changed, 6 insertions(+), 28 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/18/2118/3

diff --git a/src/openvpn/=
ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 1c3c6bf=2E=2E6e9ecb5 1006=
44
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -15=
46,18 +1546,9 @@
 
 
 #ifdef ENABLE_MANAGEMENT
-/*
- * management deferred =
internal ssl_verify=2Ec status codes
- */
-#define KMDA_ERROR   0
-#define =
KMDA_SUCCESS 1
-#define KMDA_UNDEF   2
-#define KMDA_DEF     3
-
-static in=
t
+static void
 verify_user_pass_management(struct tls_session *session, co=
nst struct user_pass *up)
 {
-    int retval =3D KMDA_ERROR;
     const str=
uct key_state *ks =3D &session->key[KS_PRIMARY]; /* primary key */
 
     /=
* set username/password in private env space */
@@ -1570,10 +1561,6 @@
    =
 }
 
     setenv_del(session->opt->es, "password");
-
-    retval =3D KMDA_=
SUCCESS;
-
-    return retval;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 
@=
@ -1638,12 +1625,7 @@
     ASSERT(up && !up->protected);
 
 #ifdef ENABLE_M=
ANAGEMENT
-    int man_def_auth =3D KMDA_UNDEF;
-
-    if (management_enabl=
e_def_auth(management))
-    {
-        man_def_auth =3D KMDA_DEF;
-    }
+=
    const bool man_def_auth =3D management_enable_def_auth(management);
 #e=
ndif
 
     /* enforce character class restrictions in username/password */=

@@ -1731,9 +1713,9 @@
     if (!skip_auth)
     {
 #ifdef ENABLE_MANAGEMEN=
T
-        if (man_def_auth =3D=3D KMDA_DEF)
+        if (man_def_auth)
   =
      {
-            man_def_auth =3D verify_user_pass_management(session, =
up);
+            verify_user_pass_management(session, up);
         }
 #en=
dif
         if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_=
USER_PASS_VERIFY))
@@ -1761,11 +1743,7 @@
     bool script_ok =3D script_st=
atus =3D=3D OPENVPN_PLUGIN_FUNC_SUCCESS
                      || script_sta=
tus =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED;
 
-    if (script_ok && plugin_ok =
&& tls_lock_username(multi, up->username)
-#ifdef ENABLE_MANAGEMENT
-      =
  && man_def_auth !=3D KMDA_ERROR
-#endif
-    )
+    if (script_ok && plug=
in_ok && tls_lock_username(multi, up->username))
     {
         ks->authen=
ticated =3D KS_AUTH_TRUE;
         if (plugin_status =3D=3D OPENVPN_PLUGIN_=
FUNC_DEFERRED
@@ -1774,7 +1752,7 @@
             ks->authenticated =3D KS_A=
UTH_DEFERRED;
         }
 #ifdef ENABLE_MANAGEMENT
-        if (man_def_aut=
h !=3D KMDA_UNDEF)
+        if (man_def_auth)
         {
             if (s=
kip_auth)
             {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2118?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-C=
hange-Id: I04c128a934e9a2e767394dbe82427df2ee886178
Gerrit-Change-Number: 2=
118
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--RBNwUxlVPlY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2118?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">ssl_verify: drop the return value of verify_user_pass_management()<br><=
br>The function cannot fail since a4eeef17 (&quot;Add function for common e=
nv<br>setting of verify user/pass calls&quot;) moved the username check out=
 of it,<br>so it always returned KMDA_SUCCESS and man_def_auth could never =
become<br>KMDA_ERROR=2E Make it void, track only whether deferred managemen=
t auth<br>is enabled, and drop the KMDA_* codes=2E<br><br>Change-Id: I04c12=
8a934e9a2e767394dbe82427df2ee886178<br>Signed-off-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118=
<br>Message-Id: &lt;20261104174350=2E15275-1-gert@greenie=2Emuc=2Ede&gt;<br=
>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40714=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>---<br>M src/openvpn/ssl_verify=2Ec<br>1 file changed, 6 inser=
tions(+), 28 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/2118/3</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</span><br><span>ind=
ex 1c3c6bf=2E=2E6e9ecb5 100644</span><br><span>--- a/src/openvpn/ssl_verify=
=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1=
546,18 +1546,9 @@</span><br><span> </span><br><span> </span><br><span> #ifd=
ef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * management deferr=
ed internal ssl_verify=2Ec status codes</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define KMDA_ERROR   0</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define KMDA_SUCCESS 1</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define KMDA_UNDEF   2</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define KMDA_DEF     3</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n> verify_user_pass_management(struct tls_session *session, const struct us=
er_pass *up)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int retval =3D KMDA_ERROR;</span><br><span>     const struct =
key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* primary key */</span=
><br><span> </span><br><span>     /* set username/password in private env s=
pace */</span><br><span>@@ -1570,10 +1561,6 @@</span><br><span>     }</span=
><br><span> </span><br><span>     setenv_del(session-&gt;opt-&gt;es, &quot;=
password&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    retval =3D KMDA_SUCCES=
S;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    return retval;</span><br><span> }</s=
pan><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> </span=
><br><span>@@ -1638,12 +1625,7 @@</span><br><span>     ASSERT(up &amp;&amp;=
 !up-&gt;protected);</span><br><span> </span><br><span> #ifdef ENABLE_MANAG=
EMENT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int man_def_=
auth =3D KMDA_UNDEF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (management_ena=
ble_def_auth(management))</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man_=
def_auth =3D KMDA_DEF;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const boo=
l man_def_auth =3D management_enable_def_auth(management);</span><br><span>=
 #endif</span><br><span> </span><br><span>     /* enforce character class r=
estrictions in username/password */</span><br><span>@@ -1731,9 +1713,9 @@</=
span><br><span>     if (!skip_auth)</span><br><span>     {</span><br><span>=
 #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (man_def_auth =3D=3D KMDA_DEF)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (man_def_auth)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            man_de=
f_auth =3D verify_user_pass_management(session, up);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            verify_user_pass_management(s=
ession, up);</span><br><span>         }</span><br><span> #endif</span><br><=
span>         if (plugin_defined(session-&gt;opt-&gt;plugins, OPENVPN_PLUGI=
N_AUTH_USER_PASS_VERIFY))</span><br><span>@@ -1761,11 +1743,7 @@</span><br>=
<span>     bool script_ok =3D script_status =3D=3D OPENVPN_PLUGIN_FUNC_SUCC=
ESS</span><br><span>                      || script_status =3D=3D OPENVPN_P=
LUGIN_FUNC_DEFERRED;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (script_ok &amp;&amp; plugin_ok &amp;&amp; tls_lock=
_username(multi, up-&gt;username)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        &amp;&amp; man_def_auth !=3D KMDA_ERROR</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    )</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (script_ok &amp;&amp; plugin_ok &amp;&amp; tls_lock_user=
name(multi, up-&gt;username))</span><br><span>     {</span><br><span>      =
   ks-&gt;authenticated =3D KS_AUTH_TRUE;</span><br><span>         if (plug=
in_status =3D=3D OPENVPN_PLUGIN_FUNC_DEFERRED</span><br><span>@@ -1774,7 +1=
752,7 @@</span><br><span>             ks-&gt;authenticated =3D KS_AUTH_DEFE=
RRED;</span><br><span>         }</span><br><span> #ifdef ENABLE_MANAGEMENT<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (man_def_au=
th !=3D KMDA_UNDEF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (man_def_auth)</span><br><span>         {</span><br><span>      =
       if (skip_auth)</span><br><span>             {</span><br></pre><p>To =
view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=
=3Demail">change 2118</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2118?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 2118 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-=
Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Licht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--RBNwUxlVPlY=--


--===============6303093648899554648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6303093648899554648==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6303093648899554648==--

