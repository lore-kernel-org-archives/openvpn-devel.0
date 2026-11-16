Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20A606A883
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LiefD0vz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mjEnWiiU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=btTzs5Vr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WE56nk3S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rqhyC/zLly+abkU2myXvRLoNFcInkSDtSajm+0P288I=; b=LiefD0vzcDCm7IOkRyQGccADOy
	b4AFBHJ+TtLnSe7DBP8rLc25t1Ui1qL/PIDt/baIHbgTkZDxxGBWu2wfeanxKLHaV0nQpcnT2oP8s
	MJOSfMYQcxQatJjwSC//mnfxYLKON3cvJXmyPCVYGg+Z0S2EOuSsV4i+U0L4hU/z/QlM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT1w2-000000002iA-2zHD;
	Mon, 16 Nov 2026 19:00:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT1vz-000000002i2-2uGm
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:00:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ywzfe55GhUj+R3eoEhKuq1xi0HpBxIHkqOgGVVnpsQ0=; b=mjEnWiiUBQ6qZdERAPu6Bkv+dj
 QX42Jzk8+ssUqbHL4V5l+ozXoK/O3fSqqkzHZRzotafef80VKPO7PWO6/sG/o/im0oUSvlLNrnTzS
 RrS5Fp4Ym7L5eOtJLh3D6uXTjNPivOJbqcQ1wESle8G9HQvbPwvZ1Mznp8JvfuFdmBck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ywzfe55GhUj+R3eoEhKuq1xi0HpBxIHkqOgGVVnpsQ0=; b=btTzs5VrZSm06Uv7u/rJRSebys
 erG4/YTPkXgrXr0pmh5U6In1rLL7SM4D7Yc0juF7A8CEELfbJR1l+08ycE8KuhJAGVMeff55bOG4E
 2p2T3H3wgdnu6SzD+aQR58ZsKs01IG7iojWJEFn22eqE+cu3uJPQutsbyF1gk1FSEPkQ=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT1vx-000000006yF-3d5t for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:00:07 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so40484315e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 11:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794855599; x=1795460399; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ywzfe55GhUj+R3eoEhKuq1xi0HpBxIHkqOgGVVnpsQ0=;
 b=WE56nk3SeNK3ZzOYdvDjcCaeGDLMglNBaMqyYbM+hkCl1i8RfYIdHkPEm9dcPD6euK
 S9Ni9BRg1LWvvWl97K8xJk/0oKOjnZ+xhfNhVKTOzdrPoohveN7g8GEAOMOv0tjLgrjt
 3D3HIvTGAR0XmLiha5lxlddRPhNl0991rlu3hLC2bWszjVm5vLU1XSllU79D2lqBFJZ0
 /EuDkfPmgdEB+fwcj3x9Sz8ibST1znXzvDhu/TcuC3FyJQ7tcNHP7fOE8n9n4pwZG9d9
 QORP1c3FUckmy2I7LUP1bvkhbytlOCzEWwN00hp7sM3GSzG8ZDndLIOxd+0WiBf8iBuq
 hedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794855599; x=1795460399;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ywzfe55GhUj+R3eoEhKuq1xi0HpBxIHkqOgGVVnpsQ0=;
 b=hCW7Kc92cM8lurtYued8x+7hJWYLvoAcnBMkZFZJlDoZofvKnq1h2Lt39fl0l7SNUO
 jnsb7/2pxtFhVQ+9nkBusxrd15bFbwRoc4H/Ns8D3xLj/kqK8QmkXnztsY+QDLSMlJyf
 0+mVzzzTqRWo9l+/6jpR5xnVioXcz2M9ILyMjDCQ+1gy7Gr6v6VqPJeifdMaBhvON3+G
 QZgpOElzD67FzjUPP9CDeTHcgK6sz1Zyt6bQhEgeDQn0o5eltJ7tyy/NZNFPnzvixTXd
 6ZO2uar1UFloNdPa8jTc59GfNb0vTsTJLSXPOVYS+QkTVSv6PEwNK7GJDXHpy1KERUxW
 hw7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErFcRTCgjI1W/Wnv/19isGoAvoRLzGuDi9Ck4XWwziasc1Rsh6jwXp+Orcnuk58cWGHEsgHtUnYjGNbqCEAi@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9m98LShVzUU/hV9ymUiTq2kkWda0VqwAVrYKIyAEoZE6qYPsCH
 MlVD2CUENhTVWYosYeoFE2VPgsE2J+9vlth3+xfb3ND+e53v++aiu9Ya9EghgbFB+i0WnoxnD49
 VpdfNaFOTlfzC/gN6ADk0wW5sdFzg2EvIqtcJt1EivdAaUcmO9NUKGikqEpg6LRey536S
X-Gm-Gg: AYBFou3M0Jh98Ys7dIIMbIJFAtvtXngthRfG36J0xFvnYhZnWYnePzDJkuIz4CaLKhv
 srQiiS02y7gQxxutK4OIWVerCIx1aWmuD2e+GSj1sSI19mk4FjXXfhVXxQBm2HAuEHeUpTfyePw
 jmzH/LvPect/bk9uAvJq90raTx0Mx3k+N7SZS2p9zu+wToLCI2q5fwZzxvrXix4JH8fohFXyyCs
 8LZCxWIMweFxRv560KwwZJBEwTpjziaqw1QnHfefv5AbpWXMNsYNOEitaxkFmD3U6I4corJJGF+
 6g4iePs6OUpOFTBOvgLn4c9Tgb1ktlgRdM0/rA6dlNSeY7wl1zYUO9xRKxqaUz27uRZ+xKvt29A
 GI6AR+Hx28tonNOdZzMb12fXsJ2JbNfDnbQHg069axdvilVDpn2d1Tk86k1xaWZ2XWRbY9OBp+c
 8V//MbDr2pJAhg5yXnHyvQttrxQTrPSPoIeXWaTkKAFMkeoj4kgzj+T2rNkuTODAMe+v1AgGmJf
 5tAoT9S8NACo3mM+KwzSwLVSg9U1OA1PE//ePu9r0d0TXgnolkLJ52OmMruAjc7ERbTGO2OZFtw
 3plaDKJrEdNd2Qe/zdpQJbJveLXJX2yof+yf76oi31qT0RtjNEeiizFyimPRe6Xsni8K4jJ8g0E
 /SGVwdAxh/ep9uC3VEJsDPMOriNVAeurk6DLBKRjAvGSJkSyLIaWHal5iD/jUf5wkQnnKIPa1Vc
 8JdRiEy1jPiJcnib0=
X-Received: by 2002:a05:600c:4f90:b0:4b7:6c16:7b43 with SMTP id
 5b1f17b1804b1-4bb55a47602mr240357605e9.10.1794855599094; 
 Mon, 16 Nov 2026 10:59:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5720f6basm158148355e9.4.2026.11.16.10.59.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:59:58 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 18:59:58 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
X-Gerrit-Change-Number: 2197
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2197?usp=email>
X-Gerrit-Commit: 4721ed8df56c8d2e97da0079d01e5e2a87054fb8
In-Reply-To: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
References: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkkzM2Y3MDgyNWMwNThjMjRlY2FiZDhlODBlNWFjODRiZmYwN2M5MjUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6ea822a9d47d75ccd4d61ce0a6ade878f274aa9b-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT1vx-000000006yF-3d5t
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5405102772553819550=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5405102772553819550==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JhYF+Yejvyc="; charset=UTF-8

--JhYF+Yejvyc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2197?usp=3Demail )

Change subject: Various trivial -Wsign-conv=
ersion fixes (part 2)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

Various trivial -Wsign-conversion fixes (part 2)

Change-Id: I33=
f70825c058c24ecabd8e80e5ac84bff07c9253
Signed-off-by: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197
Message-Id: <2026=
1116164803=2E19431-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41470=2Ehtml
Signed-off=
-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/env_set=2Ec
M=
 src/openvpn/manage=2Ec
M src/openvpn/ps=2Ec
M src/openvpn/ssl_mbedtls=2Ec
=
M tests/unit_tests/openvpn/test_buffer=2Ec
M tests/unit_tests/openvpn/test_=
cryptoapi=2Ec
6 files changed, 15 insertions(+), 60 deletions(-)




diff -=
-git a/src/openvpn/env_set=2Ec b/src/openvpn/env_set=2Ec
index d59115a=2E=
=2E55190b8 100644
--- a/src/openvpn/env_set=2Ec
+++ b/src/openvpn/env_set=
=2Ec
@@ -432,11 +432,6 @@
     return (script_security() >=3D SSEC_PW_ENV |=
| !is_password_env_var(str));
 }
 
-#if defined(__GNUC__) || defined(__clan=
g__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-c=
onversion"
-#endif
-
 /* Make arrays of strings */
 
 const char **
@@ -444=
,7 +439,7 @@
 {
     char **ret =3D NULL;
     struct env_item *e =3D NULL;=

-    int i =3D 0, n =3D 0;
+    size_t i =3D 0, n =3D 0;
 
     /* figure =
length of es */
     if (es)
@@ -475,7 +470,3 @@
     ret[i] =3D NULL;
    =
 return (const char **)ret;
 }
-
-#if defined(__GNUC__) || defined(__clang_=
_)
-#pragma GCC diagnostic pop
-#endif
diff --git a/src/openvpn/manage=2Ec =
b/src/openvpn/manage=2Ec
index ca0a7dd=2E=2Eae30930 100644
--- a/src/openvp=
n/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -779,14 +779,9 @@
     }
 }
 
=
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-=
#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 =
man_query_user_pass(struct management *man, const char *type, const char *s=
tring, const bool needed,
-                    const char *prompt, char *de=
st, int len)
+                    const char *prompt, char *dest, size_t le=
n)
 {
     if (needed)
     {
@@ -809,10 +804,6 @@
     }
 }
 
-#if defined=
(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 sta=
tic void
 man_query_username(struct management *man, const char *type, cons=
t char *string)
 {
@@ -2700,11 +2691,6 @@
     CLEAR(*mp);
 }
 
-#if define=
d(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC=
 diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 man_setting=
s_init(struct man_settings *ms, const char *addr, const char *port,
       =
            const char *pass_file, const char *client_user, const char *cli=
ent_group,
@@ -3315,15 +3301,11 @@
         {
             return false;
  =
       }
-        *persistent =3D n;
+        *persistent =3D (unsigned int=
)n;
     }
     return true;
 }
 
-#if defined(__GNUC__) || defined(__clang=
__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef _WIN32
 
 void
@@ -3708,7=
 +3690,7 @@
         struct buffer alert_msg =3D alloc_buf_gc(256, &gc);
  =
       const char *alert_type =3D NULL;
         const char *prefix =3D NUL=
L;
-        unsigned int up_query_mode =3D 0;
+        int up_query_mode =
=3D 0;
         const char *sc =3D NULL;
         ret =3D true;
         /*=
 This is so M_CLIENT messages will be correctly passed through msg() */
@@ =
-4052,8 +4034,8 @@
         const bool standalone_disabled_save =3D man->pe=
rsist=2Estandalone_disabled;
         struct gc_arena gc =3D gc_new();
 
- =
       man->persist=2Estandalone_disabled =3D
-            false; /* This i=
s so M_CLIENT messages will be correctly passed through msg() */
+        /=
* This is so M_CLIENT messages will be correctly passed through msg() */
+ =
       man->persist=2Estandalone_disabled =3D false;
         man->persist=
=2Especial_state_msg =3D NULL;
         man->settings=2Emansig |=3D MANSIG_=
IGNORE_USR1_HUP;
 
diff --git a/src/openvpn/ps=2Ec b/src/openvpn/ps=2Ec
ind=
ex 86b4fc9=2E=2E89ae371 100644
--- a/src/openvpn/ps=2Ec
+++ b/src/openvpn/p=
s=2Ec
@@ -159,7 +159,7 @@
     }
 }
 
-static int
+static socklen_t
 cmsg_s=
ize(void)
 {
     return CMSG_SPACE(sizeof(socket_descriptor_t));
@@ -357,8=
 +357,8 @@
         }
         if (fd !=3D -1)
         {
-            ssiz=
e_t write_len =3D strlen(f);
-            if (write(fd, f, write_len) !=3D =
write_len)
+            const size_t write_len =3D strlen(f);
+            =
if (write(fd, f, write_len) !=3D (ssize_t)write_len)
             {
       =
          msg(M_WARN, "PORT SHARE: writing to journal file (%s) failed", jf=
n);
             }
diff --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/s=
sl_mbedtls=2Ec
index dc9f527=2E=2E93e67fd 100644
--- a/src/openvpn/ssl_mbed=
tls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1012,7 +1012,7 @@
 
     if (=
1 =3D=3D retval)
     {
-        memset(BPTR(buf), 0, BLEN(buf)); /* erase =
data just written */
+        memset(BPTR(buf), 0, BLENZ(buf)); /* erase da=
ta just written */
         buf->len =3D 0;
     }
 
@@ -1034,7 +1034,7 @@
=
 
     ASSERT(data);
 
-    retval =3D mbedtls_ssl_write(ks->ctx, data, len=
);
+    retval =3D mbedtls_ssl_write(ks->ctx, data, (size_t)len);
 
     if=
 (retval < 0)
     {
@@ -1138,7 +1138,7 @@
     /* successful write */
    =
 dmsg(D_HANDSHAKE_VERBOSE, "write tls_write_ciphertext %d bytes", retval);
=
 
-    memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
+    =
memset(BPTR(buf), 0, BLENZ(buf)); /* erase data just written */
     buf->l=
en =3D 0;
 
     return 1;
diff --git a/tests/unit_tests/openvpn/test_buffe=
r=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index b480985=2E=2E14f5d1d=
 100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_tes=
ts/openvpn/test_buffer=2Ec
@@ -106,20 +106,15 @@
     gc_free(&gc);
 }
 
-#=
if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#p=
ragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 static void
 te=
st_buffer_format_hex_ex(void **state)
 {
-    const int input_size =3D 10;
=
+    const size_t input_size =3D 10;
     const uint8_t input[] =3D { 0x01,=
 0x00, 0xff, 0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0x0a };
     char *output;=

     struct gc_arena gc =3D gc_new();
 
-    int maxoutput =3D 0;
+    siz=
e_t maxoutput =3D 0;
     unsigned int blocksize =3D 5;
     const char *se=
parator =3D " ";
     output =3D format_hex_ex(input, input_size, maxoutput=
, blocksize, separator, &gc);
@@ -144,10 +139,6 @@
     gc_free(&gc);
 }
 
=
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#=
endif
-
 struct test_buffer_list_aggregate_ctx
 {
     struct buffer_list *=
empty;
diff --git a/tests/unit_tests/openvpn/test_cryptoapi=2Ec b/tests/uni=
t_tests/openvpn/test_cryptoapi=2Ec
index 55aafbb=2E=2E2517a55 100644
--- a/=
tests/unit_tests/openvpn/test_cryptoapi=2Ec
+++ b/tests/unit_tests/openvpn/=
test_cryptoapi=2Ec
@@ -137,11 +137,6 @@
     return c->cert ? c : NULL;
 }
=
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push=

-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 /* import s=
ample certificates into windows cert store */
 static void
 import_certs(vo=
id **state)
@@ -201,7 +196,7 @@
             fail_msg("Failed to DER encode=
 PKCS12: <%s>", c->friendly_name);
             return;
         }
-       =
 blob=2EcbData =3D len;
+        blob=2EcbData =3D (DWORD)len;
 
         D=
WORD flags =3D PKCS12_ALLOW_OVERWRITE_KEY | PKCS12_ALWAYS_CNG_KSP;
        =
 HCERTSTORE tmp_store =3D PFXImportCertStore(&blob, wpass, flags);
@@ -228,=
10 +223,6 @@
     certs_loaded =3D true;
 }
 
-#if defined(__GNUC__) || def=
ined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static int
 cleanup(=
void **state)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2197?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I33=
f70825c058c24ecabd8e80e5ac84bff07c9253
Gerrit-Change-Number: 2197
Gerrit-Pa=
tchSet: 3
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--JhYF+Yejvyc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2197?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Various trivial -Wsign-conversion =
fixes (part 2)<br><br>Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acke=
d-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197<br>Message-Id: &lt;20261116164803=
=2E19431-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41470=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
env_set=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/ps=2Ec<br>M src/op=
envpn/ssl_mbedtls=2Ec<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>M te=
sts/unit_tests/openvpn/test_cryptoapi=2Ec<br>6 files changed, 15 insertions=
(+), 60 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/env_set=2Ec =
b/src/openvpn/env_set=2Ec</span><br><span>index d59115a=2E=2E55190b8 100644=
</span><br><span>--- a/src/openvpn/env_set=2Ec</span><br><span>+++ b/src/op=
envpn/env_set=2Ec</span><br><span>@@ -432,11 +432,6 @@</span><br><span>    =
 return (script_security() &gt;=3D SSEC_PW_ENV || !is_password_env_var(str)=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignore=
d &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> /* Make arrays of strings */</span><br><span> </span><br><span=
> const char **</span><br><span>@@ -444,7 +439,7 @@</span><br><span> {</spa=
n><br><span>     char **ret =3D NULL;</span><br><span>     struct env_item =
*e =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i=
 =3D 0, n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 size_t i =3D 0, n =3D 0;</span><br><span> </span><br><span>     /* figure =
length of es */</span><br><span>     if (es)</span><br><span>@@ -475,7 +470=
,3 @@</span><br><span>     ret[i] =3D NULL;</span><br><span>     return (co=
nst char **)ret;</span><br><span> }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span>diff --git a/src/openvpn/manage=
=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ca0a7dd=2E=2Eae30930 10=
0644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src=
/openvpn/manage=2Ec</span><br><span>@@ -779,14 +779,9 @@</span><br><span>  =
   }</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic igno=
red &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span> static void</span><br><span> man_query_user_pass(struct mana=
gement *man, const char *type, const char *string, const bool needed,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    const c=
har *prompt, char *dest, int len)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    const char *prompt, char *dest, size_t le=
n)</span><br><span> {</span><br><span>     if (needed)</span><br><span>    =
 {</span><br><span>@@ -809,10 +804,6 @@</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static void</span><br><span> man_query_u=
sername(struct management *man, const char *type, const char *string)</span=
><br><span> {</span><br><span>@@ -2700,11 +2691,6 @@</span><br><span>     C=
LEAR(*mp);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span> static void</span><br><span> man_settings_init(struct =
man_settings *ms, const char *addr, const char *port,</span><br><span>     =
              const char *pass_file, const char *client_user, const char *c=
lient_group,</span><br><span>@@ -3315,15 +3301,11 @@</span><br><span>      =
   {</span><br><span>             return false;</span><br><span>         }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *persistent =
=3D n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        *pers=
istent =3D (unsigned int)n;</span><br><span>     }</span><br><span>     ret=
urn true;</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN32</span>=
<br><span> </span><br><span> void</span><br><span>@@ -3708,7 +3690,7 @@</sp=
an><br><span>         struct buffer alert_msg =3D alloc_buf_gc(256, &amp;gc=
);</span><br><span>         const char *alert_type =3D NULL;</span><br><spa=
n>         const char *prefix =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        unsigned int up_query_mode =3D 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        int up_query_mode =3D 0;</s=
pan><br><span>         const char *sc =3D NULL;</span><br><span>         re=
t =3D true;</span><br><span>         /* This is so M_CLIENT messages will b=
e correctly passed through msg() */</span><br><span>@@ -4052,8 +4034,8 @@</=
span><br><span>         const bool standalone_disabled_save =3D man-&gt;per=
sist=2Estandalone_disabled;</span><br><span>         struct gc_arena gc =3D=
 gc_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        man-&gt;persist=2Estandalone_disabled =3D</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            false; /* This is so M_CLIEN=
T messages will be correctly passed through msg() */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* This is so M_CLIENT messages w=
ill be correctly passed through msg() */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        man-&gt;persist=2Estandalone_disabled =3D fals=
e;</span><br><span>         man-&gt;persist=2Especial_state_msg =3D NULL;</=
span><br><span>         man-&gt;settings=2Emansig |=3D MANSIG_IGNORE_USR1_H=
UP;</span><br><span> </span><br><span>diff --git a/src/openvpn/ps=2Ec b/src=
/openvpn/ps=2Ec</span><br><span>index 86b4fc9=2E=2E89ae371 100644</span><br=
><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn/ps=2Ec</s=
pan><br><span>@@ -159,7 +159,7 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-sta=
tic int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static sockl=
en_t</span><br><span> cmsg_size(void)</span><br><span> {</span><br><span>  =
   return CMSG_SPACE(sizeof(socket_descriptor_t));</span><br><span>@@ -357,=
8 +357,8 @@</span><br><span>         }</span><br><span>         if (fd !=3D=
 -1)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            ssize_t write_len =3D strlen(f);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (write(fd, f, write_len) !=
=3D write_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       const size_t write_len =3D strlen(f);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (write(fd, f, write_len) !=3D (ssiz=
e_t)write_len)</span><br><span>             {</span><br><span>             =
    msg(M_WARN, &quot;PORT SHARE: writing to journal file (%s) failed&quot;=
, jfn);</span><br><span>             }</span><br><span>diff --git a/src/ope=
nvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>index dc=
9f527=2E=2E93e67fd 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls=2Ec=
</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@ -1012=
,7 +1012,7 @@</span><br><span> </span><br><span>     if (1 =3D=3D retval)</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        memset(BPTR(buf)=
, 0, BLENZ(buf)); /* erase data just written */</span><br><span>         bu=
f-&gt;len =3D 0;</span><br><span>     }</span><br><span> </span><br><span>@=
@ -1034,7 +1034,7 @@</span><br><span> </span><br><span>     ASSERT(data);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
etval =3D mbedtls_ssl_write(ks-&gt;ctx, data, len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    retval =3D mbedtls_ssl_write(ks-&gt;c=
tx, data, (size_t)len);</span><br><span> </span><br><span>     if (retval &=
lt; 0)</span><br><span>     {</span><br><span>@@ -1138,7 +1138,7 @@</span><=
br><span>     /* successful write */</span><br><span>     dmsg(D_HANDSHAKE_=
VERBOSE, &quot;write tls_write_ciphertext %d bytes&quot;, retval);</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memset(B=
PTR(buf), 0, BLEN(buf)); /* erase data just written */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    memset(BPTR(buf), 0, BLENZ(buf)); /*=
 erase data just written */</span><br><span>     buf-&gt;len =3D 0;</span><=
br><span> </span><br><span>     return 1;</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=
=2Ec</span><br><span>index b480985=2E=2E14f5d1d 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -106,20 +106,15 @@</span>=
<br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || de=
fined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> tes=
t_buffer_format_hex_ex(void **state)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const int input_size =3D 10;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t input_size =
=3D 10;</span><br><span>     const uint8_t input[] =3D { 0x01, 0x00, 0xff, =
0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0x0a };</span><br><span>     char *outp=
ut;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int maxoutput =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t maxou=
tput =3D 0;</span><br><span>     unsigned int blocksize =3D 5;</span><br><s=
pan>     const char *separator =3D &quot; &quot;;</span><br><span>     outp=
ut =3D format_hex_ex(input, input_size, maxoutput, blocksize, separator, &a=
mp;gc);</span><br><span>@@ -144,10 +139,6 @@</span><br><span>     gc_free(&=
amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct test_buffer_li=
st_aggregate_ctx</span><br><span> {</span><br><span>     struct buffer_list=
 *empty;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoa=
pi=2Ec b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><span>index =
55aafbb=2E=2E2517a55 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_cryptoapi=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryp=
toapi=2Ec</span><br><span>@@ -137,11 +137,6 @@</span><br><span>     return =
c-&gt;cert ? c : NULL;</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /* import sample certificates into windo=
ws cert store */</span><br><span> static void</span><br><span> import_certs=
(void **state)</span><br><span>@@ -201,7 +196,7 @@</span><br><span>        =
     fail_msg(&quot;Failed to DER encode PKCS12: &lt;%s&gt;&quot;, c-&gt;fr=
iendly_name);</span><br><span>             return;</span><br><span>        =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        blob=2EcbDa=
ta =3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
blob=2EcbData =3D (DWORD)len;</span><br><span> </span><br><span>         DW=
ORD flags =3D PKCS12_ALLOW_OVERWRITE_KEY | PKCS12_ALWAYS_CNG_KSP;</span><br=
><span>         HCERTSTORE tmp_store =3D PFXImportCertStore(&amp;blob, wpas=
s, flags);</span><br><span>@@ -228,10 +223,6 @@</span><br><span>     certs_=
loaded =3D true;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int</s=
pan><br><span> cleanup(void **state)</span><br><span> {</span><br></pre><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?u=
sp=3Demail">change 2197</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2197?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2197 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--JhYF+Yejvyc=--


--===============5405102772553819550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5405102772553819550==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5405102772553819550==--

