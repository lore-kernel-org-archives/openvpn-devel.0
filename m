Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0E3606A335
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Hi/medsV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cloBxy6T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JXJagAOo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UyjTl3ub
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=53+FdH0xn74RdSjDl1zaNnq1Sn69hBXDVBdGciL3vtQ=; b=Hi/medsVILKegTzREKSPQEk22y
	iY2aK5oF91knPMGp86rGqgoiGVQ8L884818+bgtaumaY/EVZnQZRgsQoK2SiNj3XMqLgwzmg5/kuE
	ovBU3zcQ1jqvNUaHkvyI38i/8bYeCdutrSuzwhZlp5OTq1XcEQbHAUjT+ICS6zll+6Xw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT1w0-000000007ne-3ZPy;
	Mon, 16 Nov 2026 19:00:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT1vy-000000007nS-3sdS
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:00:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TOOyZZu5f8S8nVfjfwe2VXVHX+dwExZlyFxJ/BiWKkw=; b=cloBxy6T/xANJqq6bwgG7aDFuf
 Fo8v2WvKGj/NNnzRsaDW7+5Icmvog3iGzAqdfDItU8clSeLpCxpSDOafIjS27nVfATPG2GV96SVvw
 u38Dl7SWdEdZvb5ZL6rP0EZnYynXWwDAM1poQHFvDg7GGl6kmRMrK74ZtTBXBQvysmOs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TOOyZZu5f8S8nVfjfwe2VXVHX+dwExZlyFxJ/BiWKkw=; b=JXJagAOoa4lLfUJtqtBoUmt/Al
 hbO7MNmsV2/kFToz+NZ6mYTO7ewajwly7qj8bADE4ahjvGO9nMYRll0zYI9++xaEkjFYukXmG6AcY
 FLM2ymYdX18bIKyJ6gh/iOOppRlNMEhCLmNIEMmspn9zQEUXLGKP4fXfPe+uVxfdJj8o=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT1vx-000000006yE-0UK2 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:00:06 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb6886d30aso15036405e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 11:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794855598; x=1795460398; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TOOyZZu5f8S8nVfjfwe2VXVHX+dwExZlyFxJ/BiWKkw=;
 b=UyjTl3ubZuDRAARYyIr+xMYVGO17WupPE/c446DVKnx+nzsPfT7l7a1fbV1ObX66e4
 ktOJaorPCEU+1ar9hElMLbKP0DnwgfVvDEIr1SXyWVcZnZZliEBmcedLVyDonJ62R22G
 P3e/0tWYHcWVzAQJywqDgq1iLVrRqYP20WdOHdS5kehqYVYiTwxh+KH93pXe81Glbnhy
 Q8AyeyVARXSCtxnRGCv3jfv1ucQllVdvgWgfqHjP0lEy+PSD+G89L7VKjn3AmAmLnxBB
 tAaUROYW5TOhP82nPM2AfUfIDHaUFCp7D4hHAYsQEYVyzh/r9F16eYObq6P8nv/oi26f
 EcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855598; x=1795460398;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TOOyZZu5f8S8nVfjfwe2VXVHX+dwExZlyFxJ/BiWKkw=;
 b=utO/xiOCbvDYbHB6lXtVhUhLGfCV8phIcslp7WiUyQ479cNzfJKfusp0oC6GqgmyG3
 IBcM0drfrdMM6MUbqLDbPVMSWzaRTwyGIbFB2uvqsPLmyCsWb3S+AZLBOLAlbfbish/O
 N+kNmrQAVa+d+GkrK58bUG4e6xpzxzqgg8FnJoQQT3UM8wlxwwV0Ko6KZPXbfIPyFpYX
 +4aCrMrxtDI/oy0RPWBSfyQTJXn8sBrBWa68+EiSrLtVdx6aTr0m+Ma2SFf8xXJrkZ+b
 C7ig9IMad4jFUV6LPtb/5QmQyYBR7pi6+cpSOuxYSROggstWeuW0RxiWh61qiSVcykfs
 3FWA==
X-Gm-Message-State: APuU4Z/7fA/wiEiph1I9EOfSNCmB5l3c837Xa+jNwt8D8i19FPrbnCaG
 u1wl5mp+tvZnvlpN5po7pX9JvXhS/GaWbNsNz8fDNXJSKS68bVlUVhe60UtpKkhsDe3P8AMXXMk
 TlME36aD1r6AjADehRJTSyqZ6zyv/VpE4Ol5l/p1FA1BetZVqNC1fMpvYjSbOrfZUA3/0
X-Gm-Gg: AYBFou024eF48qarbt4uKEcHRCdTKgmjdEJxbgiSF1jjmLJ3Kuf8PQauNiYSzn9lhzT
 q8AJQq2QnRvCe9kXzyJETYssoiX7CUCigeaVDsxPoBDBoMk36zsW26JQzCW/VnNiUGblE+pd1/K
 5Xj4CdlwF5PBmdcvNt1Y/APYJAvJyTqHjtxtZQ4hlZNDQ7LYyrOoPtKGKbDzqFrBTBxYm3oMQ5G
 K3Dyf7wmewf0XgT+sUTtrrXPOVu0P1gRBEYw4xg1zMOSQ1xZgII5RMjQRACCAwoX9v+9VpONh+a
 0BM+rn2P0ThzrYXknsVE+3P+0Az+zVhpppgqOKHQU840nuc/SyXl6IHnoOI8q7vvnMc9xRk/94h
 +1MQQLqQfZikK0EW1GNbZvWWOGvTk7cRe4cODeSrx6u51mHElesICV19pfNEXkzeASdSoZ4cu7L
 fjlz1XEOBXp1H8ePEZJWJ7bwlGfcmjy6POKY2x7o/B9SDpzLDyiUoEE+o/VvgnNMo23BT7KIJEk
 B+IXKqJiQZcI/sgkAbkoc7kUfVEhalNYV8qNiEJ+ki1/ga3ugtyTm7iu09lV9uQSy32m0xizFWB
 nsoexZKFbelWqoU6IqZUnNCV0Q52x6WGeG/nDLvIvLAtIkR5jr83FuMo/4m9J601lt7moDbrbbr
 oVMMZ0pq/pGce7MQQCj+ua+LPvhOWdIOYHN2rpiZgtt3sQA6CDMNcIWPIKQL8wiHH+5wYJG4rIn
 WNo7CXjx/+RooN368=
X-Received: by 2002:a05:600c:1145:b0:4bb:5fd4:3fd2 with SMTP id
 5b1f17b1804b1-4bb5fd44259mr137212835e9.17.1794855598274; 
 Mon, 16 Nov 2026 10:59:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7840b05bsm11531775e9.7.2026.11.16.10.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:59:57 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 18:59:56 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
X-Gerrit-Change-Number: 2197
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2197?usp=email>
X-Gerrit-Commit: 4721ed8df56c8d2e97da0079d01e5e2a87054fb8
In-Reply-To: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
References: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkkzM2Y3MDgyNWMwNThjMjRlY2FiZDhlODBlNWFjODRiZmYwN2M5MjUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ea822a9d47d75ccd4d61ce0a6ade878f274aa9b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT1vx-000000006yE-0UK2
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Various trivial
 -Wsign-conversion fixes (part 2)
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
Content-Type: multipart/mixed; boundary="===============1635809646500784329=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1635809646500784329==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PPR7MNvrmcM="; charset=UTF-8

--PPR7MNvrmcM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
197?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Various trivial -Wsi=
gn-conversion fixes (part 2)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

Various trivial -Wsign-conversion fixes (part 2)

Change-I=
d: I33f70825c058c24ecabd8e80e5ac84bff07c9253
Signed-off-by: Frank Lichtenhe=
ld <frank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197
Message-Id:=
 <20261116164803=2E19431-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41470=2Ehtml
Sign=
ed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/env_set=
=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/ps=2Ec
M src/openvpn/ssl_mbedtl=
s=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
M tests/unit_tests/openvpn=
/test_cryptoapi=2Ec
6 files changed, 15 insertions(+), 60 deletions(-)


  =
git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97/2197/3
=

diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec
index d5911=
5a=2E=2E55190b8 100644
--- a/src/openvpn/env_set=2Ec
+++ b/src/openvpn/env_=
set=2Ec
@@ -432,11 +432,6 @@
     return (script_security() >=3D SSEC_PW_EN=
V || !is_password_env_var(str));
 }
 
-#if defined(__GNUC__) || defined(__c=
lang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsig=
n-conversion"
-#endif
-
 /* Make arrays of strings */
 
 const char **
@@ -=
444,7 +439,7 @@
 {
     char **ret =3D NULL;
     struct env_item *e =3D NU=
LL;
-    int i =3D 0, n =3D 0;
+    size_t i =3D 0, n =3D 0;
 
     /* figu=
re length of es */
     if (es)
@@ -475,7 +470,3 @@
     ret[i] =3D NULL;
 =
    return (const char **)ret;
 }
-
-#if defined(__GNUC__) || defined(__cla=
ng__)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec
index ca0a7dd=2E=2Eae30930 100644
--- a/src/o=
penvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -779,14 +779,9 @@
     }
=
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic p=
ush
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static v=
oid
 man_query_user_pass(struct management *man, const char *type, const ch=
ar *string, const bool needed,
-                    const char *prompt, cha=
r *dest, int len)
+                    const char *prompt, char *dest, size=
_t len)
 {
     if (needed)
     {
@@ -809,10 +804,6 @@
     }
 }
 
-#if de=
fined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-=

 static void
 man_query_username(struct management *man, const char *type,=
 const char *string)
 {
@@ -2700,11 +2691,6 @@
     CLEAR(*mp);
 }
 
-#if d=
efined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragm=
a GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 man_se=
ttings_init(struct man_settings *ms, const char *addr, const char *port,
  =
                 const char *pass_file, const char *client_user, const char=
 *client_group,
@@ -3315,15 +3301,11 @@
         {
             return fals=
e;
         }
-        *persistent =3D n;
+        *persistent =3D (unsigne=
d int)n;
     }
     return true;
 }
 
-#if defined(__GNUC__) || defined(__=
clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef _WIN32
 
 void
@@ -3=
708,7 +3690,7 @@
         struct buffer alert_msg =3D alloc_buf_gc(256, &gc=
);
         const char *alert_type =3D NULL;
         const char *prefix =
=3D NULL;
-        unsigned int up_query_mode =3D 0;
+        int up_query_=
mode =3D 0;
         const char *sc =3D NULL;
         ret =3D true;
      =
   /* This is so M_CLIENT messages will be correctly passed through msg() *=
/
@@ -4052,8 +4034,8 @@
         const bool standalone_disabled_save =3D ma=
n->persist=2Estandalone_disabled;
         struct gc_arena gc =3D gc_new();=

 
-        man->persist=2Estandalone_disabled =3D
-            false; /* T=
his is so M_CLIENT messages will be correctly passed through msg() */
+    =
    /* This is so M_CLIENT messages will be correctly passed through msg() =
*/
+        man->persist=2Estandalone_disabled =3D false;
         man->per=
sist=2Especial_state_msg =3D NULL;
         man->settings=2Emansig |=3D MAN=
SIG_IGNORE_USR1_HUP;
 
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec=

index 86b4fc9=2E=2E89ae371 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openv=
pn/ps=2Ec
@@ -159,7 +159,7 @@
     }
 }
 
-static int
+static socklen_t
 cm=
sg_size(void)
 {
     return CMSG_SPACE(sizeof(socket_descriptor_t));
@@ -3=
57,8 +357,8 @@
         }
         if (fd !=3D -1)
         {
-            =
ssize_t write_len =3D strlen(f);
-            if (write(fd, f, write_len) !=
=3D write_len)
+            const size_t write_len =3D strlen(f);
+        =
    if (write(fd, f, write_len) !=3D (ssize_t)write_len)
             {
   =
              msg(M_WARN, "PORT SHARE: writing to journal file (%s) failed"=
, jfn);
             }
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openv=
pn/ssl_mbedtls=2Ec
index dc9f527=2E=2E93e67fd 100644
--- a/src/openvpn/ssl_=
mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1012,7 +1012,7 @@
 
     =
if (1 =3D=3D retval)
     {
-        memset(BPTR(buf), 0, BLEN(buf)); /* er=
ase data just written */
+        memset(BPTR(buf), 0, BLENZ(buf)); /* eras=
e data just written */
         buf->len =3D 0;
     }
 
@@ -1034,7 +1034,7=
 @@
 
     ASSERT(data);
 
-    retval =3D mbedtls_ssl_write(ks->ctx, data,=
 len);
+    retval =3D mbedtls_ssl_write(ks->ctx, data, (size_t)len);
 
   =
  if (retval < 0)
     {
@@ -1138,7 +1138,7 @@
     /* successful write */
=
     dmsg(D_HANDSHAKE_VERBOSE, "write tls_write_ciphertext %d bytes", retva=
l);
 
-    memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
+=
    memset(BPTR(buf), 0, BLENZ(buf)); /* erase data just written */
     bu=
f->len =3D 0;
 
     return 1;
diff --git a/tests/unit_tests/openvpn/test_b=
uffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index b480985=2E=2E14f=
5d1d 100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit=
_tests/openvpn/test_buffer=2Ec
@@ -106,20 +106,15 @@
     gc_free(&gc);
 }
=
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push=

-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void=

 test_buffer_format_hex_ex(void **state)
 {
-    const int input_size =3D =
10;
+    const size_t input_size =3D 10;
     const uint8_t input[] =3D { 0=
x01, 0x00, 0xff, 0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0x0a };
     char *out=
put;
     struct gc_arena gc =3D gc_new();
 
-    int maxoutput =3D 0;
+   =
 size_t maxoutput =3D 0;
     unsigned int blocksize =3D 5;
     const char=
 *separator =3D " ";
     output =3D format_hex_ex(input, input_size, maxou=
tput, blocksize, separator, &gc);
@@ -144,10 +139,6 @@
     gc_free(&gc);
 =
}
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic po=
p
-#endif
-
 struct test_buffer_list_aggregate_ctx
 {
     struct buffer_li=
st *empty;
diff --git a/tests/unit_tests/openvpn/test_cryptoapi=2Ec b/tests=
/unit_tests/openvpn/test_cryptoapi=2Ec
index 55aafbb=2E=2E2517a55 100644
--=
- a/tests/unit_tests/openvpn/test_cryptoapi=2Ec
+++ b/tests/unit_tests/open=
vpn/test_cryptoapi=2Ec
@@ -137,11 +137,6 @@
     return c->cert ? c : NULL;=

 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic =
push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /* impo=
rt sample certificates into windows cert store */
 static void
 import_cert=
s(void **state)
@@ -201,7 +196,7 @@
             fail_msg("Failed to DER en=
code PKCS12: <%s>", c->friendly_name);
             return;
         }
-   =
     blob=2EcbData =3D len;
+        blob=2EcbData =3D (DWORD)len;
 
      =
   DWORD flags =3D PKCS12_ALLOW_OVERWRITE_KEY | PKCS12_ALWAYS_CNG_KSP;
    =
     HCERTSTORE tmp_store =3D PFXImportCertStore(&blob, wpass, flags);
@@ -=
228,10 +223,6 @@
     certs_loaded =3D true;
 }
 
-#if defined(__GNUC__) ||=
 defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 clea=
nup(void **state)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2197?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
Gerrit-Change-Number: 2197
=
Gerrit-PatchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--PPR7MNvrmcM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2197?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Various trivial -Wsign-conversion fixes (part 2)<br><br>Change-Id: I33f=
70825c058c24ecabd8e80e5ac84bff07c9253<br>Signed-off-by: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mai=
lbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
97<br>Message-Id: &lt;20261116164803=2E19431-1-gert@greenie=2Emuc=2Ede&gt;<=
br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41470=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/env_set=2Ec<br>M src/openvpn/manage=2Ec<=
br>M src/openvpn/ps=2Ec<br>M src/openvpn/ssl_mbedtls=2Ec<br>M tests/unit_te=
sts/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openvpn/test_cryptoapi=2E=
c<br>6 files changed, 15 insertions(+), 60 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/97=
/2197/3</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=
=2Ec</span><br><span>index d59115a=2E=2E55190b8 100644</span><br><span>--- =
a/src/openvpn/env_set=2Ec</span><br><span>+++ b/src/openvpn/env_set=2Ec</sp=
an><br><span>@@ -432,11 +432,6 @@</span><br><span>     return (script_secur=
ity() &gt;=3D SSEC_PW_ENV || !is_password_env_var(str));</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conver=
sion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Make =
arrays of strings */</span><br><span> </span><br><span> const char **</span=
><br><span>@@ -444,7 +439,7 @@</span><br><span> {</span><br><span>     char=
 **ret =3D NULL;</span><br><span>     struct env_item *e =3D NULL;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    int i =3D 0, n =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t i =3D 0, n =
=3D 0;</span><br><span> </span><br><span>     /* figure length of es */</sp=
an><br><span>     if (es)</span><br><span>@@ -475,7 +470,3 @@</span><br><sp=
an>     ret[i] =3D NULL;</span><br><span>     return (const char **)ret;</s=
pan><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || d=
efined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pra=
gma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/m=
anage=2Ec</span><br><span>index ca0a7dd=2E=2Eae30930 100644</span><br><span=
>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec<=
/span><br><span>@@ -779,14 +779,9 @@</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-con=
version&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> stati=
c void</span><br><span> man_query_user_pass(struct management *man, const c=
har *type, const char *string, const bool needed,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    const char *prompt, char *d=
est, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              const char *prompt, char *dest, size_t len)</span><br><span> =
{</span><br><span>     if (needed)</span><br><span>     {</span><br><span>@=
@ -809,10 +804,6 @@</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> static void</span><br><span> man_query_username(struct managem=
ent *man, const char *type, const char *string)</span><br><span> {</span><b=
r><span>@@ -2700,11 +2691,6 @@</span><br><span>     CLEAR(*mp);</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign=
-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#end=
if</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> s=
tatic void</span><br><span> man_settings_init(struct man_settings *ms, cons=
t char *addr, const char *port,</span><br><span>                   const ch=
ar *pass_file, const char *client_user, const char *client_group,</span><br=
><span>@@ -3315,15 +3301,11 @@</span><br><span>         {</span><br><span> =
            return false;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *persistent =3D n;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        *persistent =3D (unsigned in=
t)n;</span><br><span>     }</span><br><span>     return true;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> #ifdef _WIN32</span><br><span> </span><br><=
span> void</span><br><span>@@ -3708,7 +3690,7 @@</span><br><span>         s=
truct buffer alert_msg =3D alloc_buf_gc(256, &amp;gc);</span><br><span>    =
     const char *alert_type =3D NULL;</span><br><span>         const char *=
prefix =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   unsigned int up_query_mode =3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        int up_query_mode =3D 0;</span><br><span>         =
const char *sc =3D NULL;</span><br><span>         ret =3D true;</span><br><=
span>         /* This is so M_CLIENT messages will be correctly passed thro=
ugh msg() */</span><br><span>@@ -4052,8 +4034,8 @@</span><br><span>        =
 const bool standalone_disabled_save =3D man-&gt;persist=2Estandalone_disab=
led;</span><br><span>         struct gc_arena gc =3D gc_new();</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        man-&gt;=
persist=2Estandalone_disabled =3D</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            false; /* This is so M_CLIENT messages will be corr=
ectly passed through msg() */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* This is so M_CLIENT messages will be correctly passed =
through msg() */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     man-&gt;persist=2Estandalone_disabled =3D false;</span><br><span>     =
    man-&gt;persist=2Especial_state_msg =3D NULL;</span><br><span>         =
man-&gt;settings=2Emansig |=3D MANSIG_IGNORE_USR1_HUP;</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec</span><b=
r><span>index 86b4fc9=2E=2E89ae371 100644</span><br><span>--- a/src/openvpn=
/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</span><br><span>@@ -159,7 =
+159,7 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static socklen_t</span><br><span> cm=
sg_size(void)</span><br><span> {</span><br><span>     return CMSG_SPACE(siz=
eof(socket_descriptor_t));</span><br><span>@@ -357,8 +357,8 @@</span><br><s=
pan>         }</span><br><span>         if (fd !=3D -1)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ss=
ize_t write_len =3D strlen(f);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            if (write(fd, f, write_len) !=3D write_len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            const size_t write=
_len =3D strlen(f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (write(fd, f, write_len) !=3D (ssize_t)write_len)</span><br>=
<span>             {</span><br><span>                 msg(M_WARN, &quot;POR=
T SHARE: writing to journal file (%s) failed&quot;, jfn);</span><br><span> =
            }</span><br><span>diff --git a/src/openvpn/ssl_mbedtls=2Ec b/sr=
c/openvpn/ssl_mbedtls=2Ec</span><br><span>index dc9f527=2E=2E93e67fd 100644=
</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec</span><br><span>+++ b/sr=
c/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -1012,7 +1012,7 @@</span><br><=
span> </span><br><span>     if (1 =3D=3D retval)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        memset(BPTR(buf),=
 0, BLEN(buf)); /* erase data just written */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        memset(BPTR(buf), 0, BLENZ(buf)); /* eras=
e data just written */</span><br><span>         buf-&gt;len =3D 0;</span><b=
r><span>     }</span><br><span> </span><br><span>@@ -1034,7 +1034,7 @@</spa=
n><br><span> </span><br><span>     ASSERT(data);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    retval =3D mbedtls_ssl_wri=
te(ks-&gt;ctx, data, len);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    retval =3D mbedtls_ssl_write(ks-&gt;ctx, data, (size_t)len);</sp=
an><br><span> </span><br><span>     if (retval &lt; 0)</span><br><span>    =
 {</span><br><span>@@ -1138,7 +1138,7 @@</span><br><span>     /* successful=
 write */</span><br><span>     dmsg(D_HANDSHAKE_VERBOSE, &quot;write tls_wr=
ite_ciphertext %d bytes&quot;, retval);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    memset(BPTR(buf), 0, BLEN(buf)); /*=
 erase data just written */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    memset(BPTR(buf), 0, BLENZ(buf)); /* erase data just written */=
</span><br><span>     buf-&gt;len =3D 0;</span><br><span> </span><br><span>=
     return 1;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_b=
uffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index =
b480985=2E=2E14f5d1d 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_buffer=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=
=2Ec</span><br><span>@@ -106,20 +106,15 @@</span><br><span>     gc_free(&am=
p;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ig=
nored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> static void</span><br><span> test_buffer_format_hex_ex(voi=
d **state)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const int input_size =3D 10;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const size_t input_size =3D 10;</span><br><span>  =
   const uint8_t input[] =3D { 0x01, 0x00, 0xff, 0x10, 0xff, 0x00, 0xf0, 0x=
0f, 0x09, 0x0a };</span><br><span>     char *output;</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    int maxoutput =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t maxoutput =3D 0;</span><br><sp=
an>     unsigned int blocksize =3D 5;</span><br><span>     const char *sepa=
rator =3D &quot; &quot;;</span><br><span>     output =3D format_hex_ex(inpu=
t, input_size, maxoutput, blocksize, separator, &amp;gc);</span><br><span>@=
@ -144,10 +139,6 @@</span><br><span>     gc_free(&amp;gc);</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> struct test_buffer_list_aggregate_ctx</span><b=
r><span> {</span><br><span>     struct buffer_list *empty;</span><br><span>=
diff --git a/tests/unit_tests/openvpn/test_cryptoapi=2Ec b/tests/unit_tests=
/openvpn/test_cryptoapi=2Ec</span><br><span>index 55aafbb=2E=2E2517a55 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><span=
>@@ -137,11 +137,6 @@</span><br><span>     return c-&gt;cert ? c : NULL;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &qu=
ot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span> /* import sample certificates into windows cert store */</span><br>=
<span> static void</span><br><span> import_certs(void **state)</span><br><s=
pan>@@ -201,7 +196,7 @@</span><br><span>             fail_msg(&quot;Failed =
to DER encode PKCS12: &lt;%s&gt;&quot;, c-&gt;friendly_name);</span><br><sp=
an>             return;</span><br><span>         }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        blob=2EcbData =3D len;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        blob=2EcbData =3D (DWORD)le=
n;</span><br><span> </span><br><span>         DWORD flags =3D PKCS12_ALLOW_=
OVERWRITE_KEY | PKCS12_ALWAYS_CNG_KSP;</span><br><span>         HCERTSTORE =
tmp_store =3D PFXImportCertStore(&amp;blob, wpass, flags);</span><br><span>=
@@ -228,10 +223,6 @@</span><br><span>     certs_loaded =3D true;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static int</span><br><span> cleanup(void=
 **state)</span><br><span> {</span><br></pre><p>To view, visit <a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=3Demail">change 2197</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3=
3f70825c058c24ecabd8e80e5ac84bff07c9253 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2197 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailb=
ox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--PPR7MNvrmcM=--


--===============1635809646500784329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1635809646500784329==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1635809646500784329==--

