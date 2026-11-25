Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E79F606A32A
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iM6F9KtS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qa1GT/0h;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dy7/KvO2;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Rrkkblwl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oAU10l/lq8oe9QxScq6Qpe+EWLzn4A8Vw6AuhnodJD8=; b=iM6F9KtSiC46K3lFPpMD+WZReZ
	EUmVHd5z6MELpIMFwTns2JOdzE2jtut46q0saz2UC18dECmxlx3p7na6DwvgswaAZEase5TALs3nU
	lqj58CLkK0OLjT4CX0fwPev66OsF6SaZKsBoewunWByMJsjzgFpf3UvH9E9XiutZhHTA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHZj-000000005RJ-4AQ8;
	Wed, 25 Nov 2026 18:18:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWHZi-000000005RB-2biN
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K8CJfWlViSFVOTJ26pA4wDyQljis9L9QFCrjMx3hu5k=; b=Qa1GT/0hRtHKumrgK5f0S8aMkY
 duirjcdLNEDUy5dDeUiU8B0wIvLfPOBA2zJblCHusE8ccbJGUeFH/gYgmJhXzWD6vxopQarVEEz8R
 7YQs1NXC1y65b0M+q10UITLb6sgDgNjaxUcIpwpT1Dlp9yWZxe0iGT1GrJJl35XhGO9k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K8CJfWlViSFVOTJ26pA4wDyQljis9L9QFCrjMx3hu5k=; b=dy7/KvO2lhNRofnKcgzacRJW6c
 Ld7OfFy8FKNqMP1UrVJbXG/Ls2a8SaytXOLBhoQhIweO50rQTFnD/loKeXT/I4FnkOQLDHVsN8wJD
 YMPa+eLOZafA+yJRkVa0P9wclXQUwj3e/gWwuJIk/2NbxyXrvfPXEHm/ioAWY/1OEzJ8=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWHZh-000000001Nq-2aWU for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:18:34 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so53602525e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 10:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795630707; x=1796235507; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K8CJfWlViSFVOTJ26pA4wDyQljis9L9QFCrjMx3hu5k=;
 b=Rrkkblwlt7oS3ynrZaK2F4/TS8gjHg7Xbg9JX0qyyjhVQV5B7rKtrNSnlIPUmF3ZbF
 4Zl5QdwZ33EJkhAuAXMLmLfS+y3dHLW6NqkpWS5R/kG83Oho6QrvegZYDWvyxpW36Whx
 J5W2W/NWXMWQm9EA/lKeiVBPjwf7hO9KN1SktpqdBO6jvBxpqJ9BWq1Ji/ba3/uyV7i8
 /HwTGALX7qYcy/KEGZAf2JhQzCRQMJMYTjNGUBhjN/AbICwC06xLB02oDVu4uTjPHFKe
 P/pJSOhhqYeJh0JxfM/1vajdTFqrKvVR6SvXji06jzffVItrA8p8wEHTQAUKc8qzWsdQ
 eOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795630707; x=1796235507;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K8CJfWlViSFVOTJ26pA4wDyQljis9L9QFCrjMx3hu5k=;
 b=nDctacdnFdUKTyyLEDwPvCim/WLEsfE8cy3j1y6vOzuHdYPieZRLxadqghTFy6+kDT
 P2cfK/kKyykHI4Q1OnMfzxQJo7EiTacJLxD2NLFA5NZP8uo0oPwFWk3PI9fDkISE7fXk
 WILUBBEC2g/odqCeduWzTcrz9TRLL39UjxjNMp+WkzL1MWafJGZiG11mgjfCOIxjTs7w
 Zue/yoLzgsZcElcEteGK30hnU9WVmKawMpRDIoHSh7XjEzbGpO6nW9R7caeOBX99cNJg
 tchsJSwnx/Mx4Vpciq7KCtXGuL+toXn68KOSr3X+TV1R0BRhggcr8vSExKL0umiaeO9R
 Uo6A==
X-Forwarded-Encrypted: i=1;
 AL+hErEcKQ7oXEPMSQ0FJcqdWI2SO6do/x42IlWyfOCHOvE9pzASypY1T9ubX7Zvc0YK0w3NBA+/QGVOlHX1K9m5@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+x+aWYG6es13BjEf09ZJ7+g3VUnStXVoZP1tlzdvKvF13gKyw+
 A1zZ/yCbVCnddpwbriSX3Ogq3MrnYswA+Cp3tdqpNvgmzgp0h1ZhtS+hG4V+X6S8WeMN5m3f/Tl
 uC4sn5AQTTyKzDsjcMvmwVt6+GyPZWHM1HKzudAUcG+iPqa7bV2uumkVTIZR3yIuYi6DR
X-Gm-Gg: AZFdTZc2fSX/w5qKaO/AgXepxDzmMASIE1FGpx9Vg7O4z6VfzA3+xJdVuBP+BaW5RPN
 /78EM6Wdn2NvoC8slEzkkeu0uxOC/9dMNTwDjvrtkAeSfFNIPo9J6ZDVKZy2G3DDXyggcMfhIj7
 WklTb6kjj0xmOsLRKmMWnVYIiaAQVNur6oFi9jeCmbG8dZCG5+eAx407qKwpkPNUJ9Ft8/a9OM6
 32dxOBhe/X84qtHuzNnhaL33QazbFei1j5x5w8d/NzDOFpk4KYHVhU6eX9nhBOBDfSlcXBeTIJI
 zpK1SH5IJumbylRjLidovO4oEU0KJvIxYVtLPai2UDs5f2fUEkNfdL6c6vChZfuJtHIOCNuiajC
 gnHmkqrWroxWnB8Kj/bfIm2CYvHedJKo9h2S5qvUFzNefx0kRpiLOpojvhw6YprBjQfegyssbLY
 NM03v9uVW0h2VqmldUMeclooBq58or/exXLFofyaTmYdcwnRXZYqZjKYAbHV26re3A6zX3g3HRo
 mS2nlU8pHXvdjy4g6mJaModva3ht1IhJ93ZpIsHgZAzFuoXCgGf8/1HRZTTAKtjZdI/2B8xVqyy
 cA4baGudIB5PWuaxQQvBV70yGRoLUZihRLkWgGDLMiuStPA8tP1bN3+QhVjWFtAH2KsBlvt7HtY
 3j+0WHxWDSMM/sLflBm6GXU5Dk1y8EQo8obYV/lX1pvtugveOz0h8N17Cbqwp/1LeAM8yXuqkSL
 1fdzhpzf7kdGLsjSk=
X-Received: by 2002:a05:600c:8b11:b0:4a1:dda8:eb73 with SMTP id
 5b1f17b1804b1-4bb8881c630mr394760625e9.27.1795630706660; 
 Wed, 25 Nov 2026 10:18:26 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b1ed8b6a05sm17890211f8f.43.2026.11.25.10.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:18:26 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 18:18:25 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
X-Gerrit-Change-Number: 2333
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2333?usp=email>
X-Gerrit-Commit: d16c9874876d4718be83284a7eaaa2051d18438f
In-Reply-To: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLklmYTA1YjlmZDA2ZTVkNTI4MThjOTFjNWIxNjBiNmRkMDZlYzcxMzk2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <55195525a71f4dff73123138f5f263f78643449e-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWHZh-000000001Nq-2aWU
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpn: make the
 context mode an enum
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8241926268984276395=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8241926268984276395==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QybrBalIpVY="; charset=UTF-8

--QybrBalIpVY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2333?usp=3Demail )

Change subject: openvpn: make the context m=
ode an enum
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
penvpn: make the context mode an enum

Turn the CM_* defines into enum cont=
ext_mode and use it for
struct context=2Emode, so -Wswitch covers switches =
over it=2E

Drop the stale CM_THREAD mention from the comments=2E

Change-I=
d: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
Signed-off-by: Razvan Cojocaru=
 <razvanc@mailbox=2Eorg>
Acked-by: Lev Stipakov <lstipakov@gmail=2Ecom>
Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333
Message-Id: <20261=
124122448=2E8407-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41882=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/=
openvpn/openvpn=2Eh
2 files changed, 19 insertions(+), 14 deletions(-)




=
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index 333b4e5=2E=
=2E49fcaf6 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ =
-2768,6 +2768,9 @@
         case CM_CHILD_TCP:
             sec =3D c->opti=
ons=2Ece=2Econnect_retry_seconds;
             break;
+
+        default:
+=
            break;
     }
 
 #ifdef ENABLE_DEBUG
diff --git a/src/openvpn/o=
penvpn=2Eh b/src/openvpn/openvpn=2Eh
index ad6be88=2E=2Ecbda2e3 100644
--- =
a/src/openvpn/openvpn=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -430,6 +430,16 @=
@
 };
 
 
+/** Role of a context within the OpenVPN process */
+enum contex=
t_mode
+{
+    CM_P2P,       /**< standalone point-to-point session or clie=
nt */
+    CM_TOP,       /**< top level of a multi-client or point-to-multi=
point server */
+    CM_TOP_CLONE, /**< clone of a CM_TOP context for one t=
hread */
+    CM_CHILD_UDP, /**< child context of a CM_TOP */
+    CM_CHILD=
_TCP, /**< child context of a CM_TOP */
+};
+
 /**
  * Contains all state i=
nformation for one tunnel=2E
  *
@@ -443,22 +453,14 @@
  */
 struct context=

 {
-    struct options options; /**< Options loaded from command line or
-=
                             *   configuration file=2E */
+    struct optio=
ns options;      /**< Options loaded from command line or
+                =
                  *   configuration file=2E */
 
-    bool first_time;     =
   /**< True on the first iteration of
-                             *   Op=
enVPN's main loop=2E */
+    bool first_time;             /**< True on the =
first iteration of
+                                  *   OpenVPN's main lo=
op=2E */
 
-    /* context modes */
-#define CM_P2P       0           /* st=
andalone point-to-point session or client */
-#define CM_TOP       1       =
    /* top level of a multi-client or point-to-multipoint server */
-#defin=
e CM_TOP_CLONE 2           /* clone of a CM_TOP context for one thread */
-=
#define CM_CHILD_UDP 3           /* child context of a CM_TOP or CM_THREAD =
*/
-#define CM_CHILD_TCP 4           /* child context of a CM_TOP or CM_THR=
EAD */
-    int mode;                    /**< Role of this context within t=
he
-                                  *   OpenVPN process=2E  Valid values =
are \c
-                                  *   CM_P2P, \c CM_TOP, \c CM_TOP_=
CLONE,
-                                  *   \c CM_CHILD_UDP, and \c CM_CH=
ILD_TCP=2E */
+    enum context_mode mode;      /**< Role of this context w=
ithin the
+                                  *   OpenVPN process=2E */
 
  =
   struct multi_context *multi; /**< Pointer to the main P2MP context=2E
  =
                                 *   Non-NULL only when mode =3D=3D CM_TOP=
=2E */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifa05b9fd06e5=
d52818c91c5b160b6dd06ec71396
Gerrit-Change-Number: 2333
Gerrit-PatchSet: 3
=
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <l=
stipakov@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourc=
eforge=2Enet>

--QybrBalIpVY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2333?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpn: make the context mode an =
enum<br><br>Turn the CM_* defines into enum context_mode and use it for<br>=
struct context=2Emode, so -Wswitch covers switches over it=2E<br><br>Drop t=
he stale CM_THREAD mention from the comments=2E<br><br>Change-Id: Ifa05b9fd=
06e5d52818c91c5b160b6dd06ec71396<br>Signed-off-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@gmail=2Ecom&g=
t;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333<br>Messag=
e-Id: &lt;20261124122448=2E8407-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4188=
2=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>2 files chang=
ed, 19 insertions(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 333b4e5=2E=2E49f=
caf6 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ =
b/src/openvpn/init=2Ec</span><br><span>@@ -2768,6 +2768,9 @@</span><br><spa=
n>         case CM_CHILD_TCP:</span><br><span>             sec =3D c-&gt;op=
tions=2Ece=2Econnect_retry_seconds;</span><br><span>             break;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            break;</span><br><span>     }</s=
pan><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br><span>diff -=
-git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>in=
dex ad6be88=2E=2Ecbda2e3 100644</span><br><span>--- a/src/openvpn/openvpn=
=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -430,=
6 +430,16 @@</span><br><span> };</span><br><span> </span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/** Role of a context with=
in the OpenVPN process */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+enum context_mode</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CM_P2P,   =
    /**&lt; standalone point-to-point session or client */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    CM_TOP,       /**&lt; top level =
of a multi-client or point-to-multipoint server */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    CM_TOP_CLONE, /**&lt; clone of a CM_TOP =
context for one thread */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    CM_CHILD_UDP, /**&lt; child context of a CM_TOP */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    CM_CHILD_TCP, /**&lt; child co=
ntext of a CM_TOP */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> /**</span><br><span>  * Contains all state information for one tunnel=2E<=
/span><br><span>  *</span><br><span>@@ -443,22 +453,14 @@</span><br><span> =
 */</span><br><span> struct context</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct options options; /**&lt; Option=
s loaded from command line or</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                             *   configuration file=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct options options;  =
    /**&lt; Options loaded from command line or</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                  *   configura=
tion file=2E */</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    bool first_time;        /**&lt; True on the first iteration=
 of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
           *   OpenVPN&#39;s main loop=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool first_time;             /**&lt; True on t=
he first iteration of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                  *   OpenVPN&#39;s main loop=2E */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* co=
ntext modes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 CM_P2P       0           /* standalone point-to-point session or client */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CM_TOP       =
1           /* top level of a multi-client or point-to-multipoint server */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CM_TOP_CLONE =
2           /* clone of a CM_TOP context for one thread */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define CM_CHILD_UDP 3           /* ch=
ild context of a CM_TOP or CM_THREAD */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define CM_CHILD_TCP 4           /* child context of a CM=
_TOP or CM_THREAD */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int mode;                    /**&lt; Role of this context within the</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
         *   OpenVPN process=2E  Valid values are \c</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                  *   CM_P2=
P, \c CM_TOP, \c CM_TOP_CLONE,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                  *   \c CM_CHILD_UDP, and \c CM_C=
HILD_TCP=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
num context_mode mode;      /**&lt; Role of this context within the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
       *   OpenVPN process=2E */</span><br><span> </span><br><span>     str=
uct multi_context *multi; /**&lt; Pointer to the main P2MP context=2E</span=
><br><span>                                   *   Non-NULL only when mode =
=3D=3D CM_TOP=2E */</span><br></pre><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail">change 2333</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifa05b9fd06e5d528=
18c91c5b160b6dd06ec71396 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2333 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
=
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--QybrBalIpVY=--


--===============8241926268984276395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8241926268984276395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8241926268984276395==--

