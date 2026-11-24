Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9A606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JURr/VRA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FKl5uh9O;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eufsXs19;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=C6/qdf++
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XtpkXWI0qflkWl5E8ElGDWW9hslREjPex4XEuZbfqlE=; b=JURr/VRAHVvmB6MHR5E9bComai
	HmaKBgvgJkB0uLM5gtuVCs+KdBJEPlmzdTOLQzu1nu/1BC2A9K0kMjjM0Zcanj3M1NgRk1dstXObp
	ykrnSujOITnMIQD2X4KSgPURXNnxU/QT3P47BGJ0cBrJaqCw8ov2UuB3SD+oR1GkPjC8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVoJI-0000000053T-2aNv;
	Tue, 24 Nov 2026 11:03:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVoJH-0000000053N-1kf0
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:03:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6xTThW9qMNknT3kcObzcFWMpTjWfWgxUB3qrBrutr+o=; b=FKl5uh9OpnD0VUF/d1YjQJ0cuA
 1E98iFYS0ih795cxCa8ntj3kzZlD9joSo02psZ2pFneAxkr/VObn4ZS11E0V5VoMiIfuy4Fyb+V8T
 WYmJGC0eef7knOSvxge/3I4HO7WKuWAXJnw2kaJjrZYSg/8GKp9MwDzhNbh3DfMAWhlM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6xTThW9qMNknT3kcObzcFWMpTjWfWgxUB3qrBrutr+o=; b=eufsXs19eQX4/+fFvEyGhDakql
 9jB+calHLS22nuhukQ+T0Iqoxx/quNpdrmH0DpKh5MkzPy7CUPoz/eBA9VYRjfCjyTAr6t2AOk0WO
 Fc+pcZBjfUQ3wuzha/16cg+PaiapVPQZXWIXEnyHA3ffRddsk/Cy/EGrcr3DXJLn9FFk=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVoJE-000000008RD-1BEc for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 11:03:39 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48e47347279so2560299f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 03:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795518210; x=1796123010; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6xTThW9qMNknT3kcObzcFWMpTjWfWgxUB3qrBrutr+o=;
 b=C6/qdf++7Do8ZCiGGoXl92y9p6jrdOOTVVtajFR8Gyc4q5zYd2KDDO+do2FQvtK2QT
 QQZ2V5uVNQEWpojdjxS6b8hJ59G3kZLJhzAHzL+vt/s9CdoZvwAErImsnIVdRsywqzif
 ded77yj2//dkRD5f5N/xkjM2ax6h3dbkIGbujyEyBaQU3KaOxAdzJLxcKSvi43S7OAgQ
 8bFmaen6z6NMnma9izPrgZXqfWtqiQU/Lt7+ZwZ/+mpLbkQbqBfGDuYkBXXmxnUFk3Qg
 mzgREufXE1p7zNaWja/thZm55tZLeuUhGq0M4Se61LmJVyY2uaQMBU0WsEm5UCOzjikz
 LNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795518210; x=1796123010;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6xTThW9qMNknT3kcObzcFWMpTjWfWgxUB3qrBrutr+o=;
 b=ZxjsRmFaL8byGb7p+g5h5q566WPx1riWtV/Hi3a+IVOYnGDpxGXwknWYuJu0s6kM9R
 dHlfJcSNm7zjqM8lTMs6hoovEq3E8jgb/qGvqFMAfLXaVEk0z/vtGJkGOOS2dn5AaAUR
 TixqqCWgZm+3ZQdoRO1Y7QSBn53BSoxOyTRQdz8q2Vb3ggVyvIzPWo80MZ4LjZ3xFM1l
 EyCXMJfrNtBaBfFOEfWRr/5gL/AVGUzNP0kLtxBWDyG64XhEV4SP02vxHhLiK+4QF4vc
 TsTnGIjcx1dCGG0nf92MOh/pXwpzxC3MW6NcKXNOKEkT/Ah8dPGXERwNhXZPPCu7CZWw
 Zpsw==
X-Gm-Message-State: APuU4Z+mwSHt2RhGhqQEdRop4AT1wWW/gOCb7X/BZqbmz3xaYoRFZ0Ss
 RR/godNpAI2lGOxA+wMpt8GVDhg0Bnd2c4+E2jeRpHPCalHi5QmSHwh3sLvbwb1wYR+br8MnZ9X
 9UvPfOliCnQZn4x7PrTYD7nwe7BNqLodMqmJ1FQ2I8ZhzEmUvjgMfnk3IyIeN0WFCzGPG
X-Gm-Gg: AZFdTZdzuZDVifV2il/c3u1demyL8pvkLTbl+N9Bkdhgw5bCIgqCns9lIgikN1pJfQz
 8Hi8TOTusUpdPg0vxHAerR6YHypqM/cPouLj3B/3JL4RMWFokDJWmIn+gjibbT9ey6MOsKsxTOO
 fx56rK5jf5umB/VouMcco0pDc4ksoinoQUDe1YFHmcJjY7llW5ihDQ36WN4wJFcizOZsEXwOL8O
 kc9eUm4mGSIWBU+MuEWFzIMfxkitUH5kJ0mkK12PCUb6u8EikuGCLDVSGEXOZwHH7aG0gck0WRP
 lWj2Cd/P8tLejNnQYVuQKDHfSf752oKwuWCv6w7tsrGVc67L+2nuzGHLno9NErz/zbhw2AgpG+6
 9ZxkTpj3DZAQ4scGigc3Uo8nsFS0Zgy4KZCeAf21DuwTrMij72mw561X2Z5xGooeiL+L/eaeo+h
 YF1Bq6IfbRsKbJK1pAAJK/DG8nNTOtbd5n6pA6Gj8xpDC0ckUYL8tfdkbeZvokaKjXfUyRabz3K
 aDJGOWirhe1ofPcK7rGl+rNFf/QrMNe7OgRtmGaTZCee3x5sVRJ9EeXDyfir1cWH7T2blpiqVQi
 sbhZxMDmkG+cEEw1Y5H7YbA8JSjvEEd7CSBHtEjGt/gAqGcYmWw7hiJ8sEfcrAkU4++AkLoJF+R
 HOov5nmq1MAHAUayJMhZ288MVbL1mS8FUPe5HSOUr3XRLYE3LUqlpNvSOofA2ESy/J9HN/vKY9/
 mF0R2o6QTe+7Lqg/Q=
X-Received: by 2002:a05:6000:2dc6:b0:4b4:55f3:a7d2 with SMTP id
 ffacd0b85a97d-4b455f3ae70mr11646962f8f.54.1795518209483; 
 Tue, 24 Nov 2026 03:03:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf62f7sm29152584f8f.13.2026.11.24.03.03.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 03:03:29 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 11:03:27 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
X-Gerrit-Change-Number: 2333
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2333?usp=email>
X-Gerrit-Commit: 20621756e209873f71742fd856fe0bb494a49ecd
In-Reply-To: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLklmYTA1YjlmZDA2ZTVkNTI4MThjOTFjNWIxNjBiNmRkMDZlYzcxMzk2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1dcb8fc274a4935466508067d5115b8e2e2a48cb-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVoJE-000000008RD-1BEc
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8511697633422217617=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8511697633422217617==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HQiXu4zDeoA="; charset=UTF-8

--HQiXu4zDeoA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2333?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: openvpn: make the context mode an enum
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn: make the context=
 mode an enum

Turn the CM_* defines into enum context_mode and use it for
=
struct context=2Emode, so -Wswitch covers switches over it=2E

Drop the sta=
le CM_THREAD mention from the comments=2E

Change-Id: Ifa05b9fd06e5d52818c9=
1c5b160b6dd06ec71396
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>=

---
M src/openvpn/init=2Ec
M src/openvpn/openvpn=2Eh
2 files changed, 19 i=
nsertions(+), 14 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/33/2333/2

diff --git a/src/openvpn/init=2Ec b/src/=
openvpn/init=2Ec
index 8b64944=2E=2E10a232c 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2768,6 +2768,9 @@
         case CM_CHIL=
D_TCP:
             sec =3D c->options=2Ece=2Econnect_retry_seconds;
      =
       break;
+
+        default:
+            break;
     }
 
 #ifdef ENAB=
LE_DEBUG
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh
ind=
ex ad6be88=2E=2Ecbda2e3 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/src/open=
vpn/openvpn=2Eh
@@ -430,6 +430,16 @@
 };
 
 
+/** Role of a context within =
the OpenVPN process */
+enum context_mode
+{
+    CM_P2P,       /**< standa=
lone point-to-point session or client */
+    CM_TOP,       /**< top level =
of a multi-client or point-to-multipoint server */
+    CM_TOP_CLONE, /**< =
clone of a CM_TOP context for one thread */
+    CM_CHILD_UDP, /**< child c=
ontext of a CM_TOP */
+    CM_CHILD_TCP, /**< child context of a CM_TOP */
=
+};
+
 /**
  * Contains all state information for one tunnel=2E
  *
@@ -443=
,22 +453,14 @@
  */
 struct context
 {
-    struct options options; /**< Op=
tions loaded from command line or
-                             *   configu=
ration file=2E */
+    struct options options;      /**< Options loaded fro=
m command line or
+                                  *   configuration file=
=2E */
 
-    bool first_time;        /**< True on the first iteration of
-=
                             *   OpenVPN's main loop=2E */
+    bool first_=
time;             /**< True on the first iteration of
+                    =
              *   OpenVPN's main loop=2E */
 
-    /* context modes */
-#de=
fine CM_P2P       0           /* standalone point-to-point session or clien=
t */
-#define CM_TOP       1           /* top level of a multi-client or po=
int-to-multipoint server */
-#define CM_TOP_CLONE 2           /* clone of a=
 CM_TOP context for one thread */
-#define CM_CHILD_UDP 3           /* chil=
d context of a CM_TOP or CM_THREAD */
-#define CM_CHILD_TCP 4           /* =
child context of a CM_TOP or CM_THREAD */
-    int mode;                   =
 /**< Role of this context within the
-                                  * =
  OpenVPN process=2E  Valid values are \c
-                                =
  *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,
-                                =
  *   \c CM_CHILD_UDP, and \c CM_CHILD_TCP=2E */
+    enum context_mode mod=
e;      /**< Role of this context within the
+                             =
     *   OpenVPN process=2E */
 
     struct multi_context *multi; /**< Poi=
nter to the main P2MP context=2E
                                   *   Non=
-NULL only when mode =3D=3D CM_TOP=2E */

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396
Gerrit-=
Change-Number: 2333
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--HQiXu4zDeoA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpn: make the context mode an enum<br><br>Turn the CM_* defin=
es into enum context_mode and use it for<br>struct context=2Emode, so -Wswi=
tch covers switches over it=2E<br><br>Drop the stale CM_THREAD mention from=
 the comments=2E<br><br>Change-Id: Ifa05b9fd06e5d52818c91c5b160b6dd06ec7139=
6<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br=
>M src/openvpn/init=2Ec<br>M src/openvpn/openvpn=2Eh<br>2 files changed, 19=
 insertions(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/2333/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 8b6=
4944=2E=2E10a232c 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><=
br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -2768,6 +2768,9 @@</=
span><br><span>         case CM_CHILD_TCP:</span><br><span>             sec=
 =3D c-&gt;options=2Ece=2Econnect_retry_seconds;</span><br><span>          =
   break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><sp=
an>     }</span><br><span> </span><br><span> #ifdef ENABLE_DEBUG</span><br>=
<span>diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span>=
<br><span>index ad6be88=2E=2Ecbda2e3 100644</span><br><span>--- a/src/openv=
pn/openvpn=2Eh</span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><spa=
n>@@ -430,6 +430,16 @@</span><br><span> };</span><br><span> </span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Role of a co=
ntext within the OpenVPN process */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+enum context_mode</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
CM_P2P,       /**&lt; standalone point-to-point session or client */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    CM_TOP,       /**&lt; =
top level of a multi-client or point-to-multipoint server */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    CM_TOP_CLONE, /**&lt; clone of=
 a CM_TOP context for one thread */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    CM_CHILD_UDP, /**&lt; child context of a CM_TOP */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    CM_CHILD_TCP, /**&lt=
; child context of a CM_TOP */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /**</span><br><span>  * Contains all state information for one =
tunnel=2E</span><br><span>  *</span><br><span>@@ -443,22 +453,14 @@</span><=
br><span>  */</span><br><span> struct context</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct options options; /**&=
lt; Options loaded from command line or</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                             *   configuration file=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct options =
options;      /**&lt; Options loaded from command line or</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                  *  =
 configuration file=2E */</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    bool first_time;        /**&lt; True on the first=
 iteration of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                     *   OpenVPN&#39;s main loop=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool first_time;             /**&lt;=
 True on the first iteration of</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                  *   OpenVPN&#39;s main loop=
=2E */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* context modes */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#define CM_P2P       0           /* standalone point-to-point session =
or client */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define C=
M_TOP       1           /* top level of a multi-client or point-to-multipoi=
nt server */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define C=
M_TOP_CLONE 2           /* clone of a CM_TOP context for one thread */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CM_CHILD_UDP 3    =
       /* child context of a CM_TOP or CM_THREAD */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define CM_CHILD_TCP 4           /* child c=
ontext of a CM_TOP or CM_THREAD */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    int mode;                    /**&lt; Role of this context =
within the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                       *   OpenVPN process=2E  Valid values are \c</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
    *   CM_P2P, \c CM_TOP, \c CM_TOP_CLONE,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                  *   \c CM_CHILD_UDP=
, and \c CM_CHILD_TCP=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    enum context_mode mode;      /**&lt; Role of this context withi=
n the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                    *   OpenVPN process=2E */</span><br><span> </span><br><=
span>     struct multi_context *multi; /**&lt; Pointer to the main P2MP con=
text=2E</span><br><span>                                   *   Non-NULL onl=
y when mode =3D=3D CM_TOP=2E */</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Demail">change 233=
3</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2333?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ifa05b9fd06e5d52818c91c5b160b6dd06ec71396 </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2333 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--HQiXu4zDeoA=--


--===============8511697633422217617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8511697633422217617==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8511697633422217617==--

