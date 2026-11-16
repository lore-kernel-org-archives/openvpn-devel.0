Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3F3606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BRaqUNcH;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=O1ISrvie;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IAGEoX/R;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gFA6TCPB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=yXJPjImHxElKNVvNIxCkFZwbjOfT3vippwKEm54NRnA=; b=BRaqUNcHvcHYWqkXI5ZSz6pj73
	St7TYJOfZa2O4qo9J8ToFy3ZFf9JBCb1hZj/084oJ9N4CtYmsBjCJxJ6iXAlodxouKWCzddIYflJs
	Rq89PXSFllwm2XfvFVlQtvYelUENYit6eWuc3ThLNjLJyX5CTeJg5M8UY1jGMNibcFq8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxqG-000000006cA-2fI6;
	Mon, 16 Nov 2026 14:37:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxqF-000000006c3-24Wf
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w8Sai3iZfMkpPFXCu4lzc0winDr3YQiyVc6aN/ozS6s=; b=O1ISrviebuQoAYbCCFnxKNEXzS
 1JfIucowNQj1nIspRd3T1yGePRsXb4fD1/Yd6ghn+JtYIc3zTl8Qpnj3qosdcZbQjMf8QUGNizm73
 k1Krc+8WTeTKJGEs8KZZ0rwb0Jfiws7AwJfpA3YQFj57GbISuX+l4PFGs5R684QCvVrM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w8Sai3iZfMkpPFXCu4lzc0winDr3YQiyVc6aN/ozS6s=; b=IAGEoX/R0xYwiEH3I5fBFUXuAQ
 d50RIf8OKNWYZsERxGtiWTMn8NM9DzWHslsaFQ8n/6WvD4j3EZUf8achpAFxJIMSHXwy3uatcmp+z
 BQjyo6Tk627WRco0oOKCpANHcPx7DfkNwHUaNA9jlHcNMyoyMYCei+Mzin1WITGpTOaU=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxqD-00000000695-3mwA for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:37:55 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso20289235e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839867; x=1795444667; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=w8Sai3iZfMkpPFXCu4lzc0winDr3YQiyVc6aN/ozS6s=;
 b=gFA6TCPBJgMiXJD9Svi+n10KUndO4MjRqnfUz3XTGP7RV59ilqqqmBKbZTvnyf/TyG
 lKqR2fvRVPbmWAONaHsGPIdiCH+geQc1gix8QgglgfFohFmwTWhuPNmDMQNEBkv2NZK7
 ZNj5NVlVAzooju+LaN3U4LsvRlSGVpgCff77An2ZyrtTeXAO+s0jhjLXlSbOCCE/FQVj
 GpZgXL6IV3ebI6TBBDRJXOZUyvJqJpbNDueQreldwkRCkQ/JykrsasRwJkoik3EyrtOt
 q0kLVwVAa0XCnKbgZ/anF6dQDWjfzzmyuT5hwSacOdXbDg1cr4v/OelmhgWDUTUqy1TT
 3/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839867; x=1795444667;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w8Sai3iZfMkpPFXCu4lzc0winDr3YQiyVc6aN/ozS6s=;
 b=zUwhqwgYDIMlnVKiYGDlkfZDYhC8gZcAG1gNusdHJlkAAvP96V063SbSUwijARUwGr
 JLQ3K8YgobUqI+Jirr17L6dLCjFCVQHL57esjm9V9yIwnKvJLtiyA8k9WIRCJbChETsz
 jTuaSw1nrspo2+I2qQDDoA1rZVxlOKWMqkMh6YwUtyWKiVSO0/lIY0xhG3EJLLX75PqE
 f5c2pTE8BsRstvDkcb8xFFZFC/Q6wWo8l6JFXdF20TERw0ze0hl9LU8G4TkuQ9vj2YQt
 j5Z6t1Y16sKWT2EFumfB0J5PiDmCnJrMyaNT8e0H7E19YcqfqPGUA53kOzNC0PRLyoec
 Hiaw==
X-Gm-Message-State: APuU4Z+CCULgJ085hMtNmnuh2MjWADsyrFvIXGQcA/szhB+PmmFeY6Aj
 l1ajeY4R5S+VTCBNuMLDUpZUEeoLj4kmjqs+CcApHEG+WifYR0OcIZuIEFNTeqZiZbJDxRQOrpw
 0ZjGujv2FSAG4KHO1Nw7JXdR5gXbEljEo3oLxmIAr3RbLuGVzrM/5unsBoqLL/sdR3sKYHkh0ke
 BVoWXG5w==
X-Gm-Gg: AYBFou250syqwPheyi5DWJO92vBaZskNK9mY72VMJhffggqCe9MnXq6Ce7URhr8NDKA
 erHsGuUJ62L48OBLTKo8w9fDMDCCOUN2x9onqJxBMBi7D4tUsmweRSPTwOV8s5rhE0TvWcNTOxs
 HC6ByNs7eMKMiW2aU7YpHkjMSM07WuvfkHZo/WfzvYwk6oPc8BrV8Xg1Ltt1wC8n0Xi7Xfd7o/M
 OtS404DFdD0dPjCSbFw8kqj3kc3HIzhXx1xsZd2VGF87kLvAFUb0FsEUWZn3kxBZeG4BGB9558J
 xZ0Sn14/tnbwqDHPU8iCJXwLp+ADyJNSTUgk7i9xg20e8FuMzMgxP8OFPT6tu/CWpc6vbkKopP+
 36wGIPxm3PaalAoNFeEsQfLAKeKeiuV0tz0uWoAVMdrhkzlnqcJHQXQ0PwuNWNK0j2wlGjm9UUv
 t+hx5LcMFPphrAdFLUGbBH12EXi8KTSO56wkc2Q4giXBuUj1tmlBrMxHeYailfIzz0zpzNVhLFy
 1Uq2fq/JSFzPd7jW95pcT6wepzzJ+SXAco2mVlid2NeBdIM1bgEGDvIGjXZRNZPH+zitC50DMeL
 Bm3SFymjUlyQIIn0ZqZL2Fscb5L3npps7tMm1hL5CsXrQvUhRYo3ItXXYc4yhG8Eb0TyHYSYY/7
 zDPhLhjPKhCvuUqxP9Zfer/uZtjbKsiENu4B+btIBU8pWjb5XYBqylDRbsMnWhCUfvPLDAXvUPx
 gUhDcF9WzDHhqQvTE=
X-Received: by 2002:a05:600c:1142:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4bb5f39cdb6mr122166055e9.4.1794839867168; 
 Mon, 16 Nov 2026 06:37:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb70105a98sm69313125e9.5.2026.11.16.06.37.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:37:46 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:37:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
X-Gerrit-Change-Number: 2197
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2197?usp=email>
X-Gerrit-Commit: 7647a2f0f3d4696d9af9d973063eb76add07a39d
References: <gerrit.1794839855000.I33f70825c058c24ecabd8e80e5ac84bff07c9253@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODM5ODU1MDAwLkkzM2Y3MDgyNWMwNThjMjRlY2FiZDhlODBlNWFjODRiZmYwN2M5MjUzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <526be64dd79a35faa848d6248a794e35fefc2393-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxqD-00000000695-3mwA
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5872852787791151195=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5872852787791151195==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p+7eJe6Ax5w="; charset=UTF-8

--p+7eJe6Ax5w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2197?usp=3Demail

to review the following change=2E
=


Change subject: Various trivial -Wsign-conversion fixes (part 2)
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Various trivial -Ws=
ign-conversion fixes (part 2)

Change-Id: I33f70825c058c24ecabd8e80e5ac84bf=
f07c9253
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M s=
rc/openvpn/env_set=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/ps=2Ec
M src/=
openvpn/ssl_mbedtls=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
M tests/=
unit_tests/openvpn/test_cryptoapi=2Ec
6 files changed, 15 insertions(+), 60=
 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/97/2197/1

diff --git a/src/openvpn/env_set=2Ec b/src/openvpn/env_=
set=2Ec
index d59115a=2E=2E55190b8 100644
--- a/src/openvpn/env_set=2Ec
+++=
 b/src/openvpn/env_set=2Ec
@@ -432,11 +432,6 @@
     return (script_securit=
y() >=3D SSEC_PW_ENV || !is_password_env_var(str));
 }
 
-#if defined(__GNU=
C__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagno=
stic ignored "-Wsign-conversion"
-#endif
-
 /* Make arrays of strings */
 
=
 const char **
@@ -444,7 +439,7 @@
 {
     char **ret =3D NULL;
     struct=
 env_item *e =3D NULL;
-    int i =3D 0, n =3D 0;
+    size_t i =3D 0, n =
=3D 0;
 
     /* figure length of es */
     if (es)
@@ -475,7 +470,3 @@
  =
   ret[i] =3D NULL;
     return (const char **)ret;
 }
-
-#if defined(__GNU=
C__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
diff --git a=
/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index ca0a7dd=2E=2Eae30930=
 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -779,1=
4 +779,9 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#prag=
ma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
=
-#endif
-
 static void
 man_query_user_pass(struct management *man, const c=
har *type, const char *string, const bool needed,
-                    cons=
t char *prompt, char *dest, int len)
+                    const char *promp=
t, char *dest, size_t len)
 {
     if (needed)
     {
@@ -809,10 +804,6 @@
=
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagn=
ostic pop
-#endif
-
 static void
 man_query_username(struct management *man=
, const char *type, const char *string)
 {
@@ -2700,11 +2691,6 @@
     CLEA=
R(*mp);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diag=
nostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#endif
-
 =
static void
 man_settings_init(struct man_settings *ms, const char *addr, c=
onst char *port,
                   const char *pass_file, const char *clie=
nt_user, const char *client_group,
@@ -3315,15 +3301,11 @@
         {
     =
        return false;
         }
-        *persistent =3D n;
+        *pers=
istent =3D (unsigned int)n;
     }
     return true;
 }
 
-#if defined(__GN=
UC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef _=
WIN32
 
 void
@@ -3708,7 +3690,7 @@
         struct buffer alert_msg =3D al=
loc_buf_gc(256, &gc);
         const char *alert_type =3D NULL;
         co=
nst char *prefix =3D NULL;
-        unsigned int up_query_mode =3D 0;
+    =
    int up_query_mode =3D 0;
         const char *sc =3D NULL;
         ret=
 =3D true;
         /* This is so M_CLIENT messages will be correctly passe=
d through msg() */
@@ -4052,8 +4034,8 @@
         const bool standalone_dis=
abled_save =3D man->persist=2Estandalone_disabled;
         struct gc_arena=
 gc =3D gc_new();
 
-        man->persist=2Estandalone_disabled =3D
-      =
      false; /* This is so M_CLIENT messages will be correctly passed throu=
gh msg() */
+        /* This is so M_CLIENT messages will be correctly pass=
ed through msg() */
+        man->persist=2Estandalone_disabled =3D false;
=
         man->persist=2Especial_state_msg =3D NULL;
         man->settings=
=2Emansig |=3D MANSIG_IGNORE_USR1_HUP;
 
diff --git a/src/openvpn/ps=2Ec b/=
src/openvpn/ps=2Ec
index 86b4fc9=2E=2E4aff2f3 100644
--- a/src/openvpn/ps=
=2Ec
+++ b/src/openvpn/ps=2Ec
@@ -159,7 +159,7 @@
     }
 }
 
-static int
+=
static size_t
 cmsg_size(void)
 {
     return CMSG_SPACE(sizeof(socket_desc=
riptor_t));
@@ -357,8 +357,8 @@
         }
         if (fd !=3D -1)
       =
  {
-            ssize_t write_len =3D strlen(f);
-            if (write(fd=
, f, write_len) !=3D write_len)
+            const size_t write_len =3D str=
len(f);
+            if (write(fd, f, write_len) !=3D (ssize_t)write_len)
 =
            {
                 msg(M_WARN, "PORT SHARE: writing to journal =
file (%s) failed", jfn);
             }
diff --git a/src/openvpn/ssl_mbedtl=
s=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 43bb0ff=2E=2Eaa843c1 100644
--- a=
/src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -1017,7 +=
1017,7 @@
 
     if (1 =3D=3D retval)
     {
-        memset(BPTR(buf), 0, =
BLEN(buf)); /* erase data just written */
+        memset(BPTR(buf), 0, BLE=
NZ(buf)); /* erase data just written */
         buf->len =3D 0;
     }
 
@=
@ -1039,7 +1039,7 @@
 
     ASSERT(data);
 
-    retval =3D mbedtls_ssl_wri=
te(ks->ctx, data, len);
+    retval =3D mbedtls_ssl_write(ks->ctx, data, (s=
ize_t)len);
 
     if (retval < 0)
     {
@@ -1143,7 +1143,7 @@
     /* suc=
cessful write */
     dmsg(D_HANDSHAKE_VERBOSE, "write tls_write_ciphertext=
 %d bytes", retval);
 
-    memset(BPTR(buf), 0, BLEN(buf)); /* erase data =
just written */
+    memset(BPTR(buf), 0, BLENZ(buf)); /* erase data just w=
ritten */
     buf->len =3D 0;
 
     return 1;
diff --git a/tests/unit_tes=
ts/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index=
 b480985=2E=2E14f5d1d 100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec=

+++ b/tests/unit_tests/openvpn/test_buffer=2Ec
@@ -106,20 +106,15 @@
     =
gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GC=
C diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-#end=
if
-
 static void
 test_buffer_format_hex_ex(void **state)
 {
-    const in=
t input_size =3D 10;
+    const size_t input_size =3D 10;
     const uint8_=
t input[] =3D { 0x01, 0x00, 0xff, 0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0x0a =
};
     char *output;
     struct gc_arena gc =3D gc_new();
 
-    int maxo=
utput =3D 0;
+    size_t maxoutput =3D 0;
     unsigned int blocksize =3D 5=
;
     const char *separator =3D " ";
     output =3D format_hex_ex(input, =
input_size, maxoutput, blocksize, separator, &gc);
@@ -144,10 +139,6 @@
   =
  gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma =
GCC diagnostic pop
-#endif
-
 struct test_buffer_list_aggregate_ctx
 {
    =
 struct buffer_list *empty;
diff --git a/tests/unit_tests/openvpn/test_cryp=
toapi=2Ec b/tests/unit_tests/openvpn/test_cryptoapi=2Ec
index 55aafbb=2E=2E=
2517a55 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi=2Ec
+++ b/test=
s/unit_tests/openvpn/test_cryptoapi=2Ec
@@ -137,11 +137,6 @@
     return c-=
>cert ? c : NULL;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragm=
a GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-conversion"
-=
#endif
-
 /* import sample certificates into windows cert store */
 static =
void
 import_certs(void **state)
@@ -201,7 +196,7 @@
             fail_msg(=
"Failed to DER encode PKCS12: <%s>", c->friendly_name);
             return=
;
         }
-        blob=2EcbData =3D len;
+        blob=2EcbData =3D (DW=
ORD)len;
 
         DWORD flags =3D PKCS12_ALLOW_OVERWRITE_KEY | PKCS12_ALW=
AYS_CNG_KSP;
         HCERTSTORE tmp_store =3D PFXImportCertStore(&blob, wp=
ass, flags);
@@ -228,10 +223,6 @@
     certs_loaded =3D true;
 }
 
-#if def=
ined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
=
 static int
 cleanup(void **state)
 {

-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2197?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253
Gerrit-Chang=
e-Number: 2197
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--p+7eJe6Ax5w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld would like =
Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Various trivial -Wsign-conversion fixes (part 2)<br><br>Ch=
ange-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>---<br>M src/openvpn/env_set=
=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/ps=2Ec<br>M src/openvpn/s=
sl_mbedtls=2Ec<br>M tests/unit_tests/openvpn/test_buffer=2Ec<br>M tests/uni=
t_tests/openvpn/test_cryptoapi=2Ec<br>6 files changed, 15 insertions(+), 60=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/97/2197/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/e=
nv_set=2Ec b/src/openvpn/env_set=2Ec</span><br><span>index d59115a=2E=2E551=
90b8 100644</span><br><span>--- a/src/openvpn/env_set=2Ec</span><br><span>+=
++ b/src/openvpn/env_set=2Ec</span><br><span>@@ -432,11 +432,6 @@</span><br=
><span>     return (script_security() &gt;=3D SSEC_PW_ENV || !is_password_e=
nv_var(str));</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> /* Make arrays of strings */</span><br><span> </spa=
n><br><span> const char **</span><br><span>@@ -444,7 +439,7 @@</span><br><s=
pan> {</span><br><span>     char **ret =3D NULL;</span><br><span>     struc=
t env_item *e =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int i =3D 0, n =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    size_t i =3D 0, n =3D 0;</span><br><span> </span><br><span>    =
 /* figure length of es */</span><br><span>     if (es)</span><br><span>@@ =
-475,7 +470,3 @@</span><br><span>     ret[i] =3D NULL;</span><br><span>    =
 return (const char **)ret;</span><br><span> }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>diff --git a/src/ope=
nvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index ca0a7dd=2E=
=2Eae30930 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><s=
pan>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -779,14 +779,9 @@</span=
><br><span>     }</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnost=
ic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span> static void</span><br><span> man_query_user_pas=
s(struct management *man, const char *type, const char *string, const bool =
needed,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      const char *prompt, char *dest, int len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    const char *prompt, char *de=
st, size_t len)</span><br><span> {</span><br><span>     if (needed)</span><=
br><span>     {</span><br><span>@@ -809,10 +804,6 @@</span><br><span>     }=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span> =
man_query_username(struct management *man, const char *type, const char *st=
ring)</span><br><span> {</span><br><span>@@ -2700,11 +2691,6 @@</span><br><=
span>     CLEAR(*mp);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> static void</span><br><span> man_settings_i=
nit(struct man_settings *ms, const char *addr, const char *port,</span><br>=
<span>                   const char *pass_file, const char *client_user, co=
nst char *client_group,</span><br><span>@@ -3315,15 +3301,11 @@</span><br><=
span>         {</span><br><span>             return false;</span><br><span>=
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *pe=
rsistent =3D n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    *persistent =3D (unsigned int)n;</span><br><span>     }</span><br><span=
>     return true;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef _WIN=
32</span><br><span> </span><br><span> void</span><br><span>@@ -3708,7 +3690=
,7 @@</span><br><span>         struct buffer alert_msg =3D alloc_buf_gc(256=
, &amp;gc);</span><br><span>         const char *alert_type =3D NULL;</span=
><br><span>         const char *prefix =3D NULL;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        unsigned int up_query_mode =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        int up_query_mode =
=3D 0;</span><br><span>         const char *sc =3D NULL;</span><br><span>  =
       ret =3D true;</span><br><span>         /* This is so M_CLIENT messag=
es will be correctly passed through msg() */</span><br><span>@@ -4052,8 +40=
34,8 @@</span><br><span>         const bool standalone_disabled_save =3D ma=
n-&gt;persist=2Estandalone_disabled;</span><br><span>         struct gc_are=
na gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        man-&gt;persist=2Estandalone_disabled =3D</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            false; /* This is s=
o M_CLIENT messages will be correctly passed through msg() */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* This is so M_CLIENT me=
ssages will be correctly passed through msg() */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        man-&gt;persist=2Estandalone_disabled =
=3D false;</span><br><span>         man-&gt;persist=2Especial_state_msg =3D=
 NULL;</span><br><span>         man-&gt;settings=2Emansig |=3D MANSIG_IGNOR=
E_USR1_HUP;</span><br><span> </span><br><span>diff --git a/src/openvpn/ps=
=2Ec b/src/openvpn/ps=2Ec</span><br><span>index 86b4fc9=2E=2E4aff2f3 100644=
</span><br><span>--- a/src/openvpn/ps=2Ec</span><br><span>+++ b/src/openvpn=
/ps=2Ec</span><br><span>@@ -159,7 +159,7 @@</span><br><span>     }</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic size_t</span><br><span> cmsg_size(void)</span><br><span> {</span><br><=
span>     return CMSG_SPACE(sizeof(socket_descriptor_t));</span><br><span>@=
@ -357,8 +357,8 @@</span><br><span>         }</span><br><span>         if (=
fd !=3D -1)</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            ssize_t write_len =3D strlen(f);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (write(fd, f, write_=
len) !=3D write_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            const size_t write_len =3D strlen(f);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (write(fd, f, write_len) !=3D=
 (ssize_t)write_len)</span><br><span>             {</span><br><span>       =
          msg(M_WARN, &quot;PORT SHARE: writing to journal file (%s) failed=
&quot;, jfn);</span><br><span>             }</span><br><span>diff --git a/s=
rc/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>in=
dex 43bb0ff=2E=2Eaa843c1 100644</span><br><span>--- a/src/openvpn/ssl_mbedt=
ls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><br><span>@@=
 -1017,7 +1017,7 @@</span><br><span> </span><br><span>     if (1 =3D=3D ret=
val)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memset(BPT=
R(buf), 0, BLENZ(buf)); /* erase data just written */</span><br><span>     =
    buf-&gt;len =3D 0;</span><br><span>     }</span><br><span> </span><br><=
span>@@ -1039,7 +1039,7 @@</span><br><span> </span><br><span>     ASSERT(da=
ta);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    retval =3D mbedtls_ssl_write(ks-&gt;ctx, data, len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    retval =3D mbedtls_ssl_write(ks-&=
gt;ctx, data, (size_t)len);</span><br><span> </span><br><span>     if (retv=
al &lt; 0)</span><br><span>     {</span><br><span>@@ -1143,7 +1143,7 @@</sp=
an><br><span>     /* successful write */</span><br><span>     dmsg(D_HANDSH=
AKE_VERBOSE, &quot;write tls_write_ciphertext %d bytes&quot;, retval);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mems=
et(BPTR(buf), 0, BLEN(buf)); /* erase data just written */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    memset(BPTR(buf), 0, BLENZ(buf))=
; /* erase data just written */</span><br><span>     buf-&gt;len =3D 0;</sp=
an><br><span> </span><br><span>     return 1;</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_buffer=2Ec b/tests/unit_tests/openvpn/test_bu=
ffer=2Ec</span><br><span>index b480985=2E=2E14f5d1d 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_buffer=2Ec</span><br><span>@@ -106,20 +106,15 @@</s=
pan><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span>=
 test_buffer_format_hex_ex(void **state)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const int input_size =3D 10;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t input_s=
ize =3D 10;</span><br><span>     const uint8_t input[] =3D { 0x01, 0x00, 0x=
ff, 0x10, 0xff, 0x00, 0xf0, 0x0f, 0x09, 0x0a };</span><br><span>     char *=
output;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int maxoutput=
 =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t m=
axoutput =3D 0;</span><br><span>     unsigned int blocksize =3D 5;</span><b=
r><span>     const char *separator =3D &quot; &quot;;</span><br><span>     =
output =3D format_hex_ex(input, input_size, maxoutput, blocksize, separator=
, &amp;gc);</span><br><span>@@ -144,10 +139,6 @@</span><br><span>     gc_fr=
ee(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic po=
p</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct test_buffe=
r_list_aggregate_ctx</span><br><span> {</span><br><span>     struct buffer_=
list *empty;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cry=
ptoapi=2Ec b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><span>in=
dex 55aafbb=2E=2E2517a55 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/test_cryptoapi=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
cryptoapi=2Ec</span><br><span>@@ -137,11 +137,6 @@</span><br><span>     ret=
urn c-&gt;cert ? c : NULL;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(=
__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#prag=
ma GCC diagnostic ignored &quot;-Wsign-conversion&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /* import sample certificates into win=
dows cert store */</span><br><span> static void</span><br><span> import_cer=
ts(void **state)</span><br><span>@@ -201,7 +196,7 @@</span><br><span>      =
       fail_msg(&quot;Failed to DER encode PKCS12: &lt;%s&gt;&quot;, c-&gt;=
friendly_name);</span><br><span>             return;</span><br><span>      =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        blob=2Ecb=
Data =3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  blob=2EcbData =3D (DWORD)len;</span><br><span> </span><br><span>         =
DWORD flags =3D PKCS12_ALLOW_OVERWRITE_KEY | PKCS12_ALWAYS_CNG_KSP;</span><=
br><span>         HCERTSTORE tmp_store =3D PFXImportCertStore(&amp;blob, wp=
ass, flags);</span><br><span>@@ -228,10 +223,6 @@</span><br><span>     cert=
s_loaded =3D true;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static int<=
/span><br><span> cleanup(void **state)</span><br><span> {</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2197=
?usp=3Demail">change 2197</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2197?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I33f70825c058c24ecabd8e80e5ac84bff07c9253 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2197 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--p+7eJe6Ax5w=--


--===============5872852787791151195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5872852787791151195==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5872852787791151195==--

