Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F70606A337
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y1ZcwCYq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SEOTBmOo;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EP/IWr+m;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CIwVqKZ4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ec7ueIAssXin7NYwoo0f/XyZ/6e86Id4xU/0nvsfW00=; b=Y1ZcwCYqdfHqsctwO7h1dmvGzI
	W2MpSWpBteoTbyMhevAKH07n/+vgRbORDLzCw5znLwpnkbQwPZm4vzMAwTQFBdb02kzXw40TpdvHN
	bQsCkYkVNuByiebikjE+Iv/Dqt0gasRKyoVsGPkErOihH76TH1r+2T9naNam+IEI9Blo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKWx-000000002dp-3EGE;
	Tue, 17 Nov 2026 14:51:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKWt-000000002dG-01Vr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:51:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rFtIbAAG9Q4+mDIA1rSFW238/aOPbs3U1VrWwY6OQYI=; b=SEOTBmOoWPK2vb+OCBTcYGFL32
 6lgftuGqI0Ecr3eA8AH1TiC/lNw/0JP7UAByIlmDqk027mj94nNr0PI0QtgDafr/jFYSQPVYFbuJr
 Pb2WvlntvYU/8Hyvs/3R87nBrZ9XJGMjk7ugpSSJ61gubEt3u327K9RJnWY1vtJUNgc8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rFtIbAAG9Q4+mDIA1rSFW238/aOPbs3U1VrWwY6OQYI=; b=EP/IWr+mWLE1BtslYywl7QzpHD
 C+NSrqFPu/AbuLD2jPmq/rsvOYCQien0W+H8fYRGeGSGJXfJybJANB0H64EVYVQDZucfdWvAyKbvf
 CkQpdbigmNch2js5085wA95jd1k+Kcnz2m1iUkKTOP7zqqR/U3KCDeurJLJ7J/MMNulk=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKWQ-000000004Qj-1HCk for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:51:00 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492690dd5daso4501838f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794927052; x=1795531852; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rFtIbAAG9Q4+mDIA1rSFW238/aOPbs3U1VrWwY6OQYI=;
 b=CIwVqKZ4TtUHH7X0+XbD5GF6/sOonau8t1may3HkoqtLROTKBC9bnVwv2Po6G+YJ/O
 Jmlbgikd0zvF1bnIf8SwktBH/C6tR5cioNijaqi0R8/SxOYHe1dkMhmEOzaLJOVAo3JO
 +I5aHlBz/daUzaf4p3e9JgMqLaHu1h0cURFECr2kP+yptWMtSYl0sc4+R29DVfqOArUQ
 Ak2LH+WtI1mZCrN2oGWiMN/pp/F+goARwxu1H4HB0vVkI1H6BRzdWmIU/KHyTFDherHR
 z6Qf5YOQSrp0T4NyB2Hv0maazPnMzdeCTahd9ItkE5O8devoD88xPnVGILmztuUHbyPa
 hhyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927052; x=1795531852;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rFtIbAAG9Q4+mDIA1rSFW238/aOPbs3U1VrWwY6OQYI=;
 b=Wk6YIIXHY9OTG8XyXMTSrgtv06rsDPDPbc3jEx/iph+7xNZUXnhvcH8PtSv510/KcN
 8gDdpXmlWZ6kP6ejt1C/d3q3Eri5UnDxmEDV0Blc5KINmAosB5W2LC/TpyngCyQ3Mya8
 5bUWCZw2HakXr/coRjWEH1jlmtxE+tmEkEP0YoQIDEOvwBnBhOwzgZg9+BSlzD1FHsFW
 C36RYohfng0xnC45rvvyDk2ip1azh8MdG1JXAwDiIEDE6WxfNEsqT5lEcBETeQQXmUU0
 G8mQ5WjrNPVDYGcmuT6JsHi5GCe63fsHam8MGcsPutymFFyMdjfwBvoN+0iqQzJdrXoT
 pTuQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFJz42KL4oChinJRq+q6ekqbJJ3Qygz9FKs8o86D5/qpzIPEQXxcAGZQk6MDlEoZWd1R5Q8URvI1WLvS2A9@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/isf85ctCfs8ojDbiGFyyrCZlUivLeAdl0WFNJZ2/65yL/hLVE
 z3cqJL9jM+onFadb5TdlsuU3E9xRD2EQo25OP1WYJah7tXUCTtH678y/a6btIXmbJ8lopZ+1dsA
 bIsv+lKwNuMZGDqqfQYWVlzdqJQw5EFPEUP8YgQz7GzqBdckDnn0MLnCkXL/t0OM/Abzl
X-Gm-Gg: AZFdTZf7ogm9IYGta/OqSzl9QF7YrudKG0YOCsoe+dQu/KlAtPw2eHOWmfjGkZBs0RZ
 mJCjKBQ7+Nq46BMYbc/XS3F+jXzjnYYMBy3B6QuPc0nl3H0RBMg/7PmzNYCdgf21MMNuBdeZnoe
 GAE5PMUjImOAx1JL4M6yi9f9XuMq08b+BDDAIxusAAYW+WKcKpR0x4qLJWw850eFF5b+X4q1uZ0
 PEIt9bHs2gETc1WeGC5cHKE9x7AN2PDe55LLLcak/gmmHSC0mhuvdbwZUObdtAu9woJQ6WDZfjf
 jbwbqmrurrWBh+IaN7/x1JGlnZ7yQuYOMqearDKATKXecKFeo3RXdoQf1R6O2a6TzSWNFylDU8L
 Fs/nNURx3ssOquisNihWufnIlfd1YMwk3Bt2unbzJdqny1dGAPhYAxMkS/SWHF5UIaZW1PTwEoR
 /rzw7KuMYMZPnXwjRRQSuII8Ua4E1/4IDyGyPKpHAhlcgSJqYomCVv5bnlYRv6noeOI5QP0H9XS
 etjvAzksaw9q2AsCdQf3VWwkegziUxGHWrtStojFOS/fC3cYG3+pxXSysY9+F50KlDWVUKFrZ+h
 4gg5fI5spwI78gVzhCefgio31Nuo4CBbpx6L8Ly/031BT7fXuq7K314x+jr7nJpJ2OwJrPyBC4l
 5yLkBNucgwHs6hRey5QAt4Ss4mAvAPKByckBs0CWtcxuYaKANynHcRDmm5ZOM7sxNdpojnVJEcf
 CCaZ+1Ne6mglUxnG4=
X-Received: by 2002:a5d:5d0f:0:b0:48e:6419:ddf2 with SMTP id
 ffacd0b85a97d-49c6fd933fcmr32928617f8f.17.1794927051530; 
 Tue, 17 Nov 2026 06:50:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c605e5b2fsm30274397f8f.40.2026.11.17.06.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:50:51 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:50:50 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8
X-Gerrit-Change-Number: 2203
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2203?usp=email>
X-Gerrit-Commit: f07e67b526a76e9343beb2bb248844443692b769
In-Reply-To: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
References: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODU0MzE3MDAwLkljZTIxNTEyNTlmY2FhMjU2ZDdhZWU1ODhiYzNkNjhjODM1ZWE5ZWI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fe5d0dedcd4137d3691c2c1eb11a9f755e3784eb-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKWQ-000000004Qj-1HCk
Subject: [Openvpn-devel] [M] Change in openvpn[master]: proxy: drop
 always-on PROXY_DIGEST_AUTH guards
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
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7086994478083180158=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7086994478083180158==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gSkhqbVqZH4="; charset=UTF-8

--gSkhqbVqZH4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2203?usp=3Demail )

Change subject: proxy: drop always-on PROXY=
_DIGEST_AUTH guards
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

proxy: drop always-on PROXY_DIGEST_AUTH guards

PROXY_DIGEST_AUTH i=
s unconditionally defined to 1=2E Remove it and its
#if blocks=2E In the di=
gest branch of establish_http_proxy_passthru(),
also drop the re-check of a=
uth_method =3D=3D HTTP_AUTH_DIGEST, which the
enclosing condition already g=
uarantees, and its dead else=2E

Change-Id: Ice2151259fcaa256d7aee588bc3d68=
c835ea9eb8
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by:=
 Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2203
Message-Id: <20261116190900=2E2482-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41494=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/httpdigest=2Ec
M src/openvpn/httpdigest=2Eh
=
M src/openvpn/proxy=2Ec
M src/openvpn/syshead=2Eh
4 files changed, 93 inser=
tions(+), 121 deletions(-)




diff --git a/src/openvpn/httpdigest=2Ec b/sr=
c/openvpn/httpdigest=2Ec
index 9bfa074=2E=2Ea6803e9 100644
--- a/src/openvp=
n/httpdigest=2Ec
+++ b/src/openvpn/httpdigest=2Ec
@@ -26,8 +26,6 @@
 
 #inc=
lude "syshead=2Eh"
 
-#if PROXY_DIGEST_AUTH
-
 #include "crypto=2Eh"
 #incl=
ude "httpdigest=2Eh"
 
@@ -141,5 +139,3 @@
     md_ctx_free(md5_ctx);
     =
CvtHex(RespHash, Response);
 }
-
-#endif /* if PROXY_DIGEST_AUTH */
diff --=
git a/src/openvpn/httpdigest=2Eh b/src/openvpn/httpdigest=2Eh
index 37f3d98=
=2E=2E20db1c4 100644
--- a/src/openvpn/httpdigest=2Eh
+++ b/src/openvpn/htt=
pdigest=2Eh
@@ -20,8 +20,6 @@
  *  with this program; if not, see <https://=
www=2Egnu=2Eorg/licenses/>=2E
  */
 
-#if PROXY_DIGEST_AUTH
-
 #define HASH=
LEN 16
 typedef unsigned char HASH[HASHLEN];
 #define HASHHEXLEN 32
@@ -42,=
5 +40,3 @@
                         const HASHHEX HEntity,     /* H(entity =
body) if qop=3D"auth-int" */
                         HASHHEX Response     =
      /* request-digest or response-digest */
 );
-
-#endif /* if PROXY_DIG=
EST_AUTH */
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
inde=
x cd9f3b2=2E=2E437733e 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn=
/proxy=2Ec
@@ -348,14 +348,12 @@
                 *data =3D string_alloc(bu=
f + 26, NULL);
                 ret =3D HTTP_AUTH_BASIC;
             }
-#i=
f PROXY_DIGEST_AUTH
             else if (!strncmp(buf + 20, "Digest ", 7))=

             {
                 msg(D_PROXY, "PROXY AUTH DIGEST: '%s'", bu=
f);
                 *data =3D string_alloc(buf + 27, NULL);
              =
   ret =3D HTTP_AUTH_DIGEST;
             }
-#endif
         }
     }
 }
@@=
 -714,121 +712,108 @@
         {
             processed =3D true;
         =
}
-#if PROXY_DIGEST_AUTH
         else if (p->auth_method =3D=3D HTTP_AUTH_=
DIGEST && !processed)
         {
             const char *pa =3D p->proxy_a=
uthenticate;
-            const int method =3D p->auth_method;
            =
 ASSERT(pa);
 
-            if (method =3D=3D HTTP_AUTH_DIGEST)
+          =
  const char *http_method =3D "CONNECT";
+            const char *nonce_cou=
nt =3D "00000001";
+            const char *qop =3D "auth";
+            co=
nst char *username =3D p->up=2Eusername;
+            const char *password =
=3D p->up=2Epassword;
+            char *opaque_kv =3D "";
+            cha=
r uri[128];
+            uint8_t cnonce_raw[8];
+            HASHHEX sessio=
n_key;
+            HASHHEX response;
+
+            const char *realm =3D =
get_pa_var("realm", pa, &gc);
+            const char *nonce =3D get_pa_var=
("nonce", pa, &gc);
+            const char *algor =3D get_pa_var("algorith=
m", pa, &gc);
+            const char *opaque =3D get_pa_var("opaque", pa, =
&gc);
+
+            if (!realm || !nonce)
             {
-                =
const char *http_method =3D "CONNECT";
-                const char *nonce_c=
ount =3D "00000001";
-                const char *qop =3D "auth";
-        =
        const char *username =3D p->up=2Eusername;
-                const c=
har *password =3D p->up=2Epassword;
-                char *opaque_kv =3D ""=
;
-                char uri[128];
-                uint8_t cnonce_raw[8];
-=
                uint8_t *cnonce;
-                HASHHEX session_key;
-   =
             HASHHEX response;
-
-                const char *realm =3D get=
_pa_var("realm", pa, &gc);
-                const char *nonce =3D get_pa_va=
r("nonce", pa, &gc);
-                const char *algor =3D get_pa_var("alg=
orithm", pa, &gc);
-                const char *opaque =3D get_pa_var("opaq=
ue", pa, &gc);
-
-                if (!realm || !nonce)
-                {
=
-                    msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, ma=
lformed response "
-                                       "from server: re=
alm=3D or nonce=3D missing");
-                    goto error;
-           =
     }
-
-                /* generate a client nonce */
-                pr=
ng_bytes(cnonce_raw, sizeof(cnonce_raw));
-                cnonce =3D make_=
base64_string2(cnonce_raw, sizeof(cnonce_raw), &gc);
-
-
-                /=
* build the digest response */
-                snprintf(uri, sizeof(uri), =
"%s:%s", host, port);
-
-                if (opaque)
-                {
-  =
                  const size_t len =3D strlen(opaque) + 16;
-              =
      opaque_kv =3D gc_malloc(len, false, &gc);
-                    snprin=
tf(opaque_kv, len, ", opaque=3D\"%s\"", opaque);
-                }
-
-    =
            DigestCalcHA1(algor, username, realm, password, nonce, (char *)=
cnonce, session_key);
-                DigestCalcResponse(session_key, nonc=
e, nonce_count, (char *)cnonce, qop,
-                                   ht=
tp_method, uri, NULL, response);
-
-                /* format HTTP CONNECT =
message */
-                snprintf(buf, sizeof(buf), "%s %s HTTP/%s", htt=
p_method, uri,
-                         p->options=2Ehttp_version);
-
-   =
             msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
-
-            =
    /* send HTTP CONNECT message to proxy */
-                if (!send_lin=
e_crlf(sd, buf))
-                {
-                    goto error;
-     =
           }
-
-                /* send HOST etc, */
-                if (!=
add_proxy_headers(p, sd, host))
-                {
-                    got=
o error;
-                }
-
-                /* send digest response */
-=
                if (!checked_snprintf(
-                        buf, sizeof=
(buf),
-                        "Proxy-Authorization: Digest username=3D\"%=
s\", realm=3D\"%s\", nonce=3D\"%s\", uri=3D\"%s\", qop=3D%s, nc=3D%s, cnonc=
e=3D\"%s\", response=3D\"%s\"%s",
-                        username, realm,=
 nonce, uri, qop, nonce_count, cnonce, response, opaque_kv))
-             =
   {
-                    goto error;
-                }
-
-               =
 msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
-                if (!send_=
line_crlf(sd, buf))
-                {
-                    goto error;
-  =
              }
-                if (!send_crlf(sd))
-                {
-  =
                  goto error;
-                }
-                /* clear =
any sensitive content in buf */
-                secure_memzero(buf, sizeof=
(buf));
-
-                /* receive reply from proxy */
-                =
if (!recv_line(sd, buf, sizeof(buf),
-                               get_se=
rver_poll_remaining_time(server_poll_timeout), true, NULL,
-               =
                signal_received))
-                {
-                    g=
oto error;
-                }
-
-                /* remove trailing CR, LF =
*/
-                chomp(buf);
-
-                msg(D_PROXY, "HTTP proxy=
 returned: '%s'", buf);
-
-                /* parse return string */
-     =
           nparms =3D sscanf(buf, "%*s %d", &status);
-                proc=
essed =3D true;
-            }
-            else
-            {
-          =
      msg(D_PROXY, "HTTP proxy: digest method not supported");
+           =
     msg(D_LINK_ERRORS, "HTTP proxy: digest auth failed, malformed response=
 "
+                                   "from server: realm=3D or nonce=3D m=
issing");
                 goto error;
             }
+
+            /* gen=
erate a client nonce */
+            prng_bytes(cnonce_raw, sizeof(cnonce_r=
aw));
+            uint8_t *cnonce =3D make_base64_string2(cnonce_raw, size=
of(cnonce_raw), &gc);
+
+            /* build the digest response */
+     =
       snprintf(uri, sizeof(uri), "%s:%s", host, port);
+
+            if (=
opaque)
+            {
+                const size_t len =3D strlen(opaque)=
 + 16;
+                opaque_kv =3D gc_malloc(len, false, &gc);
+        =
        snprintf(opaque_kv, len, ", opaque=3D\"%s\"", opaque);
+           =
 }
+
+            DigestCalcHA1(algor, username, realm, password, nonce, (c=
har *)cnonce, session_key);
+            DigestCalcResponse(session_key, no=
nce, nonce_count, (char *)cnonce, qop,
+                               http=
_method, uri, NULL, response);
+
+            /* format HTTP CONNECT messag=
e */
+            snprintf(buf, sizeof(buf), "%s %s HTTP/%s", http_method, =
uri,
+                     p->options=2Ehttp_version);
+
+            msg(D=
_PROXY, "Send to HTTP proxy: '%s'", buf);
+
+            /* send HTTP CONNE=
CT message to proxy */
+            if (!send_line_crlf(sd, buf))
+        =
    {
+                goto error;
+            }
+
+            /* send HO=
ST etc, */
+            if (!add_proxy_headers(p, sd, host))
+            {=

+                goto error;
+            }
+
+            /* send digest =
response */
+            if (!checked_snprintf(
+                    buf, s=
izeof(buf),
+                    "Proxy-Authorization: Digest username=3D\"=
%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=3D\"%s\", qop=3D%s, nc=3D%s, cnon=
ce=3D\"%s\", response=3D\"%s\"%s",
+                    username, realm, no=
nce, uri, qop, nonce_count, cnonce, response, opaque_kv))
+            {
+ =
               goto error;
+            }
+
+            msg(D_PROXY, "Send=
 to HTTP proxy: '%s'", buf);
+            if (!send_line_crlf(sd, buf))
+  =
          {
+                goto error;
+            }
+            if (!s=
end_crlf(sd))
+            {
+                goto error;
+            }
+ =
           /* clear any sensitive content in buf */
+            secure_mem=
zero(buf, sizeof(buf));
+
+            /* receive reply from proxy */
+    =
        if (!recv_line(sd, buf, sizeof(buf),
+                           ge=
t_server_poll_remaining_time(server_poll_timeout), true, NULL,
+           =
                signal_received))
+            {
+                goto erro=
r;
+            }
+
+            /* remove trailing CR, LF */
+            =
chomp(buf);
+
+            msg(D_PROXY, "HTTP proxy returned: '%s'", buf);
=
+
+            /* parse return string */
+            nparms =3D sscanf(buf=
, "%*s %d", &status);
+            processed =3D true;
         }
-#endif /=
* if PROXY_DIGEST_AUTH */
         else if (p->options=2Eauth_retry)
      =
   {
             /* figure out what kind of authentication the proxy needs=
 */
diff --git a/src/openvpn/syshead=2Eh b/src/openvpn/syshead=2Eh
index 65=
baee3=2E=2E8f27436 100644
--- a/src/openvpn/syshead=2Eh
+++ b/src/openvpn/s=
yshead=2Eh
@@ -480,11 +480,6 @@
 #endif
 
 /*
- * Should we include proxy d=
igest auth functionality
- */
-#define PROXY_DIGEST_AUTH 1
-
-/*
  * Do we =
have CryptoAPI capability?
  */
 #if defined(_WIN32) && defined(ENABLE_CRYP=
TO_OPENSSL) && !defined(ENABLE_CRYPTO_WOLFSSL)

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8
Gerrit=
-Change-Number: 2203
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--gSkhqbVqZH4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2203?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">proxy: drop always-on PROXY_DIGEST=
_AUTH guards<br><br>PROXY_DIGEST_AUTH is unconditionally defined to 1=2E Re=
move it and its<br>#if blocks=2E In the digest branch of establish_http_pro=
xy_passthru(),<br>also drop the re-check of auth_method =3D=3D HTTP_AUTH_DI=
GEST, which the<br>enclosing condition already guarantees, and its dead els=
e=2E<br><br>Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8<br>Signed-=
off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2203<br>Message-Id: &lt;20261116190900=2E2482-1-gert@gr=
eenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg41494=2Ehtml<br>Signed-off-by: Gert Doering &=
lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/httpdigest=2Ec<br>M =
src/openvpn/httpdigest=2Eh<br>M src/openvpn/proxy=2Ec<br>M src/openvpn/sysh=
ead=2Eh<br>4 files changed, 93 insertions(+), 121 deletions(-)<br><br></pre=
>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/httpdigest=2Ec b/src/openvpn/httpdigest=2Ec</=
span><br><span>index 9bfa074=2E=2Ea6803e9 100644</span><br><span>--- a/src/=
openvpn/httpdigest=2Ec</span><br><span>+++ b/src/openvpn/httpdigest=2Ec</sp=
an><br><span>@@ -26,8 +26,6 @@</span><br><span> </span><br><span> #include =
&quot;syshead=2Eh&quot;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if PROXY_DIGEST_AUTH</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> #include &quot;crypto=2Eh&quot;</span=
><br><span> #include &quot;httpdigest=2Eh&quot;</span><br><span> </span><br=
><span>@@ -141,5 +139,3 @@</span><br><span>     md_ctx_free(md5_ctx);</span=
><br><span>     CvtHex(RespHash, Response);</span><br><span> }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif /* if PROXY_DIGEST_AUTH */</span><br><span>diff =
--git a/src/openvpn/httpdigest=2Eh b/src/openvpn/httpdigest=2Eh</span><br><=
span>index 37f3d98=2E=2E20db1c4 100644</span><br><span>--- a/src/openvpn/ht=
tpdigest=2Eh</span><br><span>+++ b/src/openvpn/httpdigest=2Eh</span><br><sp=
an>@@ -20,8 +20,6 @@</span><br><span>  *  with this program; if not, see &l=
t;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span>  */</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if PROXY_DIGES=
T_AUTH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> #define HASHLEN 16</span><br><span> typedef unsigned char HASH[HASHLEN];=
</span><br><span> #define HASHHEXLEN 32</span><br><span>@@ -42,5 +40,3 @@</=
span><br><span>                         const HASHHEX HEntity,     /* H(ent=
ity body) if qop=3D&quot;auth-int&quot; */</span><br><span>                =
         HASHHEX Response           /* request-digest or response-digest */=
</span><br><span> );</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if PROXY_DIG=
EST_AUTH */</span><br><span>diff --git a/src/openvpn/proxy=2Ec b/src/openvp=
n/proxy=2Ec</span><br><span>index cd9f3b2=2E=2E437733e 100644</span><br><sp=
an>--- a/src/openvpn/proxy=2Ec</span><br><span>+++ b/src/openvpn/proxy=2Ec<=
/span><br><span>@@ -348,14 +348,12 @@</span><br><span>                 *dat=
a =3D string_alloc(buf + 26, NULL);</span><br><span>                 ret =
=3D HTTP_AUTH_BASIC;</span><br><span>             }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if PROXY_DIGEST_AUTH</span><br><span>     =
        else if (!strncmp(buf + 20, &quot;Digest &quot;, 7))</span><br><spa=
n>             {</span><br><span>                 msg(D_PROXY, &quot;PROXY =
AUTH DIGEST: &#39;%s&#39;&quot;, buf);</span><br><span>                 *da=
ta =3D string_alloc(buf + 27, NULL);</span><br><span>                 ret =
=3D HTTP_AUTH_DIGEST;</span><br><span>             }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>         }</span><br=
><span>     }</span><br><span> }</span><br><span>@@ -714,121 +712,108 @@</s=
pan><br><span>         {</span><br><span>             processed =3D true;</=
span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if PROXY_DIGEST_AUTH</span><br><span>         else if (p-&gt;auth_meth=
od =3D=3D HTTP_AUTH_DIGEST &amp;&amp; !processed)</span><br><span>         =
{</span><br><span>             const char *pa =3D p-&gt;proxy_authenticate;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const int=
 method =3D p-&gt;auth_method;</span><br><span>             ASSERT(pa);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (method =3D=3D HTTP_AUTH_DIGEST)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            const char *http_method =3D &quot;CONNECT&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
onst char *nonce_count =3D &quot;00000001&quot;;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            const char *qop =3D &quot;auth&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cons=
t char *username =3D p-&gt;up=2Eusername;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            const char *password =3D p-&gt;up=2Epassw=
ord;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cha=
r *opaque_kv =3D &quot;&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            char uri[128];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            uint8_t cnonce_raw[8];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            HASHHEX session_key;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            HASHHEX response=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            const char *realm =3D get=
_pa_var(&quot;realm&quot;, pa, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            const char *nonce =3D get_pa_var(&quot;non=
ce&quot;, pa, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            const char *algor =3D get_pa_var(&quot;algorithm&quot;, pa,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   const char *opaque =3D get_pa_var(&quot;opaque&quot;, pa, &amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!realm || !nonce)</span><=
br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                const char *http_method =3D &quot;CONNECT&quot;;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                const char *no=
nce_count =3D &quot;00000001&quot;;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                const char *qop =3D &quot;auth&quot;;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                const char *u=
sername =3D p-&gt;up=2Eusername;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                const char *password =3D p-&gt;up=2Epassword;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                char *op=
aque_kv =3D &quot;&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                char uri[128];</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                uint8_t cnonce_raw[8];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                uint8_t *cnonce;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                HASHHEX session_=
key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                H=
ASHHEX response;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                const char=
 *realm =3D get_pa_var(&quot;realm&quot;, pa, &amp;gc);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                const char *nonce =3D get=
_pa_var(&quot;nonce&quot;, pa, &amp;gc);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                const char *algor =3D get_pa_var(&quot;a=
lgorithm&quot;, pa, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                const char *opaque =3D get_pa_var(&quot;opaque&quot=
;, pa, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!realm=
 || !nonce)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      msg(D_LINK_ERRORS, &quot;HTTP proxy: digest auth failed, malformed re=
sponse &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                               &quot;from server: realm=3D or nonce=3D miss=
ing&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* genera=
te a client nonce */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               prng_bytes(cnonce_raw, sizeof(cnonce_raw));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                cnonce =3D make_base64=
_string2(cnonce_raw, sizeof(cnonce_raw), &amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   /* build the digest response */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                snprintf(uri, sizeof(uri), &quot;%s:%s&quot;, =
host, port);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                if (opaque)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    const si=
ze_t len =3D strlen(opaque) + 16;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    opaque_kv =3D gc_malloc(len, false, &amp;gc=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 snprintf(opaque_kv, len, &quot;, opaque=3D\&quot;%s\&quot;&quot;, opaque);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                DigestCalcHA1(algor, username,=
 realm, password, nonce, (char *)cnonce, session_key);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                DigestCalcResponse(session=
_key, nonce, nonce_count, (char *)cnonce, qop,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                                   http_method, ur=
i, NULL, response);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* form=
at HTTP CONNECT message */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                snprintf(buf, sizeof(buf), &quot;%s %s HTTP/%s&quot;, =
http_method, uri,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                     p-&gt;options=2Ehttp_version);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#=
39;&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                /* send HT=
TP CONNECT message to proxy */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                if (!send_line_crlf(sd, buf))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    goto error;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                /* send HOST etc, */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                if (!add_proxy_headers(p, sd, =
host))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
 goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                /* send digest res=
ponse */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   if (!checked_snprintf(</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                        buf, sizeof(buf),</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                        &quot;Proxy-Authorization: =
Digest username=3D\&quot;%s\&quot;, realm=3D\&quot;%s\&quot;, nonce=3D\&quo=
t;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=3D%s, cnonce=3D\&quot;%s\=
&quot;, response=3D\&quot;%s\&quot;%s&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        username, realm, nonce, uri,=
 qop, nonce_count, cnonce, response, opaque_kv))</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    goto error;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;=
&quot;, buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        if (!send_line_crlf(sd, buf))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    goto error;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                if (!send_crlf(sd))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    goto error;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                /* clear any sensitive co=
ntent in buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          secure_memzero(buf, sizeof(buf));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                /* receive reply from proxy */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                if (!recv_line(sd, buf, sizeof(bu=
f),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
             get_server_poll_remaining_time(server_poll_timeout), true, NUL=
L,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
            signal_received))</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    goto error;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     /* remove trailing CR, LF */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                chomp(buf);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             msg(D_PROXY, &quot;HTTP proxy returned: &#39;%s&#39;&quot;, bu=
f);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                /* parse return string =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                npa=
rms =3D sscanf(buf, &quot;%*s %d&quot;, &amp;status);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                processed =3D true;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                msg(D_PROXY, &quot;HTTP proxy: dig=
est method not supported&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                msg(D_LINK_ERRORS, &quot;HTTP proxy: digest au=
th failed, malformed response &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                   &quot;from server: real=
m=3D or nonce=3D missing&quot;);</span><br><span>                 goto erro=
r;</span><br><span>             }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* generate a client nonce */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            prng_bytes(cnonce_raw, sizeof(cnonce_raw));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t *c=
nonce =3D make_base64_string2(cnonce_raw, sizeof(cnonce_raw), &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* build the digest response =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            snpri=
ntf(uri, sizeof(uri), &quot;%s:%s&quot;, host, port);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (opaque)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                const size_t len =3D strlen(opaque) + 16;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                opaque_k=
v =3D gc_malloc(len, false, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                snprintf(opaque_kv, len, &quot;, opaque=
=3D\&quot;%s\&quot;&quot;, opaque);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   DigestCalcHA1(algor, username, realm, password, nonce, (char *)cnonce, s=
ession_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     DigestCalcResponse(session_key, nonce, nonce_count, (char *)cnonce, qo=
p,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
              http_method, uri, NULL, response);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            /* format HTTP CONNECT message */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            snprintf(buf, sizeof(buf), =
&quot;%s %s HTTP/%s&quot;, http_method, uri,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     p-&gt;options=2Ehttp_version)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(D_PROXY, &quot;Send t=
o HTTP proxy: &#39;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* send HTTP CONNECT message to proxy */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!send_line_crlf(sd, buf))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                goto erro=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* send HOST etc, */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            if (!add_proxy_h=
eaders(p, sd, host))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* send di=
gest response */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (!checked_snprintf(</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    buf, sizeof(buf),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    &quot;Proxy-Authorization=
: Digest username=3D\&quot;%s\&quot;, realm=3D\&quot;%s\&quot;, nonce=3D\&q=
uot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=3D%s, cnonce=3D\&quot;%=
s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    username, realm, nonce, uri,=
 qop, nonce_count, cnonce, response, opaque_kv))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                goto error;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;=
, buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!send_line_crlf(sd, buf))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                goto error;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (!send_crlf(sd))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                goto error;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* clear any sensitive content in buf */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            secure_memzero(b=
uf, sizeof(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* receiv=
e reply from proxy */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (!recv_line(sd, buf, sizeof(buf),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                           get_server_poll_r=
emaining_time(server_poll_timeout), true, NULL,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                           signal_received))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                goto error;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            /* remove trailing CR, LF */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            chomp(buf);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(D_PROXY, &quot;HTTP pro=
xy returned: &#39;%s&#39;&quot;, buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            /* parse return string */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            nparms =3D sscanf(buf, &quot;%*s %d&quot;, &a=
mp;status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    processed =3D true;</span><br><span>         }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif /* if PROXY_DIGEST_AUTH */</span><br><s=
pan>         else if (p-&gt;options=2Eauth_retry)</span><br><span>         =
{</span><br><span>             /* figure out what kind of authentication th=
e proxy needs */</span><br><span>diff --git a/src/openvpn/syshead=2Eh b/src=
/openvpn/syshead=2Eh</span><br><span>index 65baee3=2E=2E8f27436 100644</spa=
n><br><span>--- a/src/openvpn/syshead=2Eh</span><br><span>+++ b/src/openvpn=
/syshead=2Eh</span><br><span>@@ -480,11 +480,6 @@</span><br><span> #endif</=
span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * Should we include proxy digest auth functionality</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define PROXY_DIGEST_AUTH 1</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-/*</span><br><span>  * Do we have CryptoAPI capability?</span>=
<br><span>  */</span><br><span> #if defined(_WIN32) &amp;&amp; defined(ENAB=
LE_CRYPTO_OPENSSL) &amp;&amp; !defined(ENABLE_CRYPTO_WOLFSSL)</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2203?usp=3Demail">change 2203</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2203?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merg=
ed </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 2203 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerr=
it-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--gSkhqbVqZH4=--


--===============7086994478083180158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7086994478083180158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7086994478083180158==--

