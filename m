Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3D8606A322
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FtC2dg/E;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QeNN6flx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U6ucz388;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZJLiHtoe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=YPtZiyNHGzCR4aAI2RlMgdyrcxHQFHu2BdfhGlPEnJM=; b=FtC2dg/ErQvYXa6rvIs1Ok7ZzW
	lnwYRHnJFkJ3Hl5L6ogPajUpNhLZTnSLJhn3DFYJ7IHW4SNLAkSTpXfDDsJhiIsao0Xn2Ij4IoISq
	zhiJV/Gvmpugu3qeV/bgYPoaA+q0qPg7idSYacocJVDo7Zm0MlGgdtF1xAOfMlAR2fFU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVnvi-000000008GB-18br;
	Tue, 24 Nov 2026 10:39:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVnvg-000000008G5-0yft
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 10:39:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/CVLourF74pfaXtMDpv3VlOiJG22lIA+TqdDdTYkOQQ=; b=QeNN6flx5TsM2ZnbdJ+ohU5t05
 J4t+WfemUwXE/0xdI/1jiKpkfLYNesj/WM9Hrnjnjq5OApfqVHwGls/YYwuc38DmN+6nnyXC84rKS
 pY8werMWr1DtYMDzPK/NzMdnlfEtN6Ihu7jSy0BU5iYC2IiBSKsOqcUOCLZyERCU4Pjw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/CVLourF74pfaXtMDpv3VlOiJG22lIA+TqdDdTYkOQQ=; b=U6ucz388tYRIKLgBEeRMBKtQID
 AJ7HMDy009py8+z8ubA3ufcfb7m2guMy6VreDekcdQyNbm4ZaedNh7ou0/5RcCihI8tTVrC9EzjT7
 rdM92O6A/ModR7or0Ee105Ye8vzpj/ut3qQEWydk0T/rUFY9q6hj11VFgNPhJ5fsjLLo=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVnve-000000007vd-2oL6 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 10:39:16 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so2700216f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 02:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795516748; x=1796121548; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/CVLourF74pfaXtMDpv3VlOiJG22lIA+TqdDdTYkOQQ=;
 b=ZJLiHtoeDqDP1rKdQUx2WH3yNddUnbPllkH7i8bwTVTp7CSAa8k4S2EsNA+EUXHNzd
 2FauG1HWIBwZ1Lbk7AGp6bh1ecarGlKyIiBhdfto87D1gkGbebznrr/tfh/pSRvkNQ8J
 j+okR6WQ2PRsYT9FcmthIgWwebQBapTRoyFtCYylh/9bx/JTCdZsmJ+WHS42QO/RS1qz
 c8xxMbZJHllFJuf7vf5rtnFBaAm2vsQv+W+SaqeJE7aMXs+kBKj1AYSqaB2GjpodlySN
 apTnwbB6dcXR4RSz2wVv8I05PyZF3Oa7OAYmVHrWw0cyy/OAiIxAV2wsJFZj8DeDOsdO
 7pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795516748; x=1796121548;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/CVLourF74pfaXtMDpv3VlOiJG22lIA+TqdDdTYkOQQ=;
 b=BK+WIB0UcQNzRDopCrIOEi81HdH3BaTJYZFAKP9bndBaAQr7WM/5ILImEWTi66NR0j
 VCg5QhcjfpKdvGxplu4Jhu+AaXbBaTWvSFTkEtnresGswdWfzTCBRObyluuHOISE12Eb
 9YfiwSrOMrVUccq6ZrTdVLTv21OS6zreKY92aQYxUx9TlPn6znC+tRIrW4zpcc20EkXr
 CKyEsmv7JFONN0sl8JBhsejs3OcdEX+A3Fm5H1koAVsiS4p0di6gz9yotVQPBzMy2pVT
 YmEkDnTzfuOkV5nURQVcgKFI0LeM84ZzTh1m9nMWWgXVrCoyHvlYLYxNx6HPoRsDW5Ur
 L+OA==
X-Gm-Message-State: APuU4Z+cVT5ayr1gqggjAxJK+IQd9+fvQjjSj0qzMFBUSHx81R9CSSaG
 PXKAv1HyhQGxZF9Mucyl1wki7o93QH3MXcjhJVbTNoGqqhQ0pDTOS0IlwzDVQ+VJHhY9LDEkywC
 fA3eFwPhsTsitUszcdQmITzzp3Y68e1ByxAsQK/spSpz9J15yFiR+wEC9JVGEHhxQ5GfEap4EmG
 SNy5fFbA==
X-Gm-Gg: AZFdTZemBP982Xxv3qdb9cXy9v6BZY2NgUtCy2clXvZ4wixX0LZ685hoIn1+j6mLZDt
 Iw03iAwSrQoCIEIqgy+mQn58D4DWvMeYFOQp0aXvU+1kDgSVgspy8hv5TlGDcUqQjvbYuJFjMgs
 1Nhb3KaAEFWKdnUXc+T4dxA+kL0anTA6AwBvttbfXp4igZdWKeD5l1IAK6hx2DUmL+Nx3uWu/cp
 DRHtt9z9UZzlmOyzxklePRudPdoCD8BJUWOSXUY4peHsTpIer5A3tlUw60HtRDtTqzIhNXgmGTB
 mGCFthS/AgR7TdtKdNvcAtRUhR0ZeGEvD8FAi37njilFeY0nszNXxHBWdMWFCOOU4K3dRHNmsrH
 oDImFX+dxAqlL5kLZEi0wk5ePbfXVZUa2smIoF+zhCngX15HhzEC+sSztED3gCx/pXTgXCsHUM2
 gszFx0lFY0KIIdRREx8iTOuWeArM+pTaUMpa9mDFO7DHSmeo5iW8xhEuCuCXKPVJT8fg3opvls1
 8ODLX+S4hQFC/uIyOuwyDTE9xguvWe3rhNR69BN1ZdYNckmlQkTUZ4Qa50qRy/xAJg94uVoObKO
 VVimizqzzkQxBmWIdqeZ0THElRZGsGq+l1g+LM8DOmez0B9oJw61dVuNPtBLk+j9S8n+X7qOVFA
 fZSa1Qe4v3ceUOik0gqF0kvZ6mPiNK0NdNyhJHWyvMuIYjtXndAoEmleAybZtY68G935dd7pWp/
 kU09nlQSpqWrKadag=
X-Received: by 2002:a05:6000:29ce:b0:4a7:1fca:e52d with SMTP id
 ffacd0b85a97d-4abb0e46a88mr18494673f8f.9.1795516747772; 
 Tue, 24 Nov 2026 02:39:07 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4abbd84e661sm25792169f8f.18.2026.11.24.02.39.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 02:39:07 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 10:39:07 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id36f1ae9b90be55cb7e77baa6f212bc1f06e2c6b
X-Gerrit-Change-Number: 2336
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2336?usp=email>
X-Gerrit-Commit: 896bfb4322ea9d3c282f004b710cfe1f3e94e7c4
References: <gerrit.1795516745000.Id36f1ae9b90be55cb7e77baa6f212bc1f06e2c6b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE2NzQ1MDAwLklkMzZmMWFlOWI5MGJlNTVjYjdlNzdiYWE2ZjIxMmJjMWYwNmUyYzZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <93d3240e2d9435279e0ff6f85063f15cd9613e55-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVnve-000000007vd-2oL6
Subject: [Openvpn-devel] [S] Change in openvpn[master]: init: deduplicate
 crypto param update and noexec driver checks
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
Content-Type: multipart/mixed; boundary="===============6424818536470756749=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6424818536470756749==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lkAWMvPGB/k="; charset=UTF-8

--lkAWMvPGB/k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2336?usp=3Demail

to review the following change=2E
=


Change subject: init: deduplicate crypto param update and noexec driver c=
hecks
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: d=
eduplicate crypto param update and noexec driver checks

do_deferred_p2p_nc=
p() now calls do_deferred_options_part2() instead of
open-coding the peer-i=
d sync and tls_session_update_crypto_params()
call=2E The error message mov=
es to the caller in do_up()=2E

Factor the AF_UNIX/null driver test shared =
by route_noexec_enabled()
and ifconfig_noexec_enabled() into tun_driver_noe=
xec(), and fix the
truncated ifconfig_noexec_enabled() doc comment=2E

Chan=
ge-Id: Id36f1ae9b90be55cb7e77baa6f212bc1f06e2c6b
Signed-off-by: Razvan Cojo=
caru <razvanc@mailbox=2Eorg>
---
M src/openvpn/init=2Ec
1 file changed, 16 =
insertions(+), 30 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/36/2336/1

diff --git a/src/openvpn/init=2Ec b/sr=
c/openvpn/init=2Ec
index e1052c5=2E=2Ec3927cc 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -1589,6 +1589,13 @@
 #endif /* ifdef ENA=
BLE_MANAGEMENT */
 }
 
+/** Backend drivers that take no ifconfig or route =
commands */
+static bool
+tun_driver_noexec(const struct tuntap *tt)
+{
+  =
  return tt && (tt->backend_driver =3D=3D DRIVER_AFUNIX || tt->backend_driv=
er =3D=3D DRIVER_NULL);
+}
+
 /**
  * Determine if external route commands =
should be executed based on
  * configured options and backend driver
@@ -1=
596,8 +1603,7 @@
 static bool
 route_noexec_enabled(const struct options *o=
, const struct tuntap *tt)
 {
-    return o->route_noexec || (tt && tt->bac=
kend_driver =3D=3D DRIVER_AFUNIX)
-           || (tt && tt->backend_driver =
=3D=3D DRIVER_NULL);
+    return o->route_noexec || tun_driver_noexec(tt);
=
 }
 
 /*
@@ -1766,16 +1772,13 @@
 }
 
 /**
- * Determines if ifconfig execu=
tion should be disabled because of a
- * @param c
- * @return
+ * Determine=
 if ifconfig execution should be disabled, either by
+ * --ifconfig-noexec =
or by the backend driver
  */
 static bool
 ifconfig_noexec_enabled(const s=
truct context *c)
 {
-    return c->options=2Eifconfig_noexec
-           |=
| (c->c1=2Etuntap && c->c1=2Etuntap->backend_driver =3D=3D DRIVER_AFUNIX)
-=
           || (c->c1=2Etuntap && c->c1=2Etuntap->backend_driver =3D=3D DRIV=
ER_NULL);
+    return c->options=2Eifconfig_noexec || tun_driver_noexec(c->=
c1=2Etuntap);
 }
 
 static void
@@ -2290,15 +2293,9 @@
     c->options=2Eus=
e_peer_id =3D c->c2=2Etls_multi->use_peer_id;
 
     struct tls_session *se=
ssion =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
-    if (!tls_session_upd=
ate_crypto_params(c->c2=2Etls_multi, session, &c->options, &c->c2=2Eframe,
=
-                                          frame_fragment, get_link_socket_=
info(c),
-                                          &c->c1=2Etuntap->dco))
=
-    {
-        msg(D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto o=
ptions");
-        return false;
-    }
-
-    return true;
+    return tls=
_session_update_crypto_params(c->c2=2Etls_multi, session, &c->options, &c->=
c2=2Eframe,
+                                            frame_fragment, ge=
t_link_socket_info(c),
+                                            &c->c1=
=2Etuntap->dco);
 }
 
 bool
@@ -2386,6 +2383,7 @@
         {
             i=
f (!do_deferred_options_part2(c))
             {
+                msg(D_TLS=
_ERRORS, "OPTIONS ERROR: failed to import crypto options");
               =
  return false;
             }
         }
@@ -2518,8 +2516,6 @@
         re=
turn true;
     }
 
-    c->options=2Euse_peer_id =3D c->c2=2Etls_multi->us=
e_peer_id;
-
     struct tls_session *session =3D &c->c2=2Etls_multi->sessi=
on[TM_ACTIVE];
 
     const char *ncp_cipher =3D
@@ -2537,17 +2533,7 @@
   =
      return false;
     }
 
-    struct frame *frame_fragment =3D NULL;
-#=
ifdef ENABLE_FRAGMENT
-    if (c->options=2Ece=2Efragment)
-    {
-        =
frame_fragment =3D &c->c2=2Eframe_fragment;
-    }
-#endif
-
-    if (!tls_=
session_update_crypto_params(c->c2=2Etls_multi, session, &c->options, &c->c=
2=2Eframe,
-                                          frame_fragment, get_l=
ink_socket_info(c),
-                                          &c->c1=2Etun=
tap->dco))
+    if (!do_deferred_options_part2(c))
     {
         msg(D_TL=
S_ERRORS, "ERROR: failed to set crypto cipher");
         return false;

--=
 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2336?usp=3Demai=
l
To unsubscribe, or for help writing mail filters, visit https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id36f1ae9b90be55cb7e=
77baa6f212bc1f06e2c6b
Gerrit-Change-Number: 2336
Gerrit-PatchSet: 1
Gerrit-=
Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel=
@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>

--lkAWMvPGB/k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2336?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">init: deduplicate crypto param update and noexec driver=
 checks<br><br>do_deferred_p2p_ncp() now calls do_deferred_options_part2() =
instead of<br>open-coding the peer-id sync and tls_session_update_crypto_pa=
rams()<br>call=2E The error message moves to the caller in do_up()=2E<br><b=
r>Factor the AF_UNIX/null driver test shared by route_noexec_enabled()<br>a=
nd ifconfig_noexec_enabled() into tun_driver_noexec(), and fix the<br>trunc=
ated ifconfig_noexec_enabled() doc comment=2E<br><br>Change-Id: Id36f1ae9b9=
0be55cb7e77baa6f212bc1f06e2c6b<br>Signed-off-by: Razvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br>1 file changed, 16 =
insertions(+), 30 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/36/2336/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index e10=
52c5=2E=2Ec3927cc 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><=
br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -1589,6 +1589,13 @@<=
/span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** =
Backend drivers that take no ifconfig or route commands */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+tun_driver_noexec(const struct tuntap *tt)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return tt &amp;&amp; (tt-&gt;backen=
d_driver =3D=3D DRIVER_AFUNIX || tt-&gt;backend_driver =3D=3D DRIVER_NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span=
>  * Determine if external route commands should be executed based on</span=
><br><span>  * configured options and backend driver</span><br><span>@@ -15=
96,8 +1603,7 @@</span><br><span> static bool</span><br><span> route_noexec_=
enabled(const struct options *o, const struct tuntap *tt)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return o-&gt;rou=
te_noexec || (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-           || (tt &amp;&a=
mp; tt-&gt;backend_driver =3D=3D DRIVER_NULL);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return o-&gt;route_noexec || tun_driver_noex=
ec(tt);</span><br><span> }</span><br><span> </span><br><span> /*</span><br>=
<span>@@ -1766,16 +1772,13 @@</span><br><span> }</span><br><span> </span><b=
r><span> /**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Determ=
ines if ifconfig execution should be disabled because of a</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">- * @param c</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * @return</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Determine if ifconfig execution should be disabled, ei=
ther by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * --ifconfi=
g-noexec or by the backend driver</span><br><span>  */</span><br><span> sta=
tic bool</span><br><span> ifconfig_noexec_enabled(const struct context *c)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return c-&gt;options=2Eifconfig_noexec</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-           || (c-&gt;c1=2Etuntap &amp;&amp; c-&gt;c1=2Etu=
ntap-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-           || (c-&gt;c1=2Etuntap &amp;&amp; c-&gt;c=
1=2Etuntap-&gt;backend_driver =3D=3D DRIVER_NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return c-&gt;options=2Eifconfig_noexec |=
| tun_driver_noexec(c-&gt;c1=2Etuntap);</span><br><span> }</span><br><span>=
 </span><br><span> static void</span><br><span>@@ -2290,15 +2293,9 @@</span=
><br><span>     c-&gt;options=2Euse_peer_id =3D c-&gt;c2=2Etls_multi-&gt;us=
e_peer_id;</span><br><span> </span><br><span>     struct tls_session *sessi=
on =3D &amp;c-&gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!tls_session_update_crypto_param=
s(c-&gt;c2=2Etls_multi, session, &amp;c-&gt;options, &amp;c-&gt;c2=2Eframe,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
                     frame_fragment, get_link_socket_info(c),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                                   =
       &amp;c-&gt;c1=2Etuntap-&gt;dco))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        msg(D_TLS_ERRORS, &quot;OPTIONS ERROR: failed to import crypto op=
tions&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return tls_session_update_crypto_params(c-=
&gt;c2=2Etls_multi, session, &amp;c-&gt;options, &amp;c-&gt;c2=2Eframe,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                     frame_fragment, get_link_socket_info(c),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                 =
           &amp;c-&gt;c1=2Etuntap-&gt;dco);</span><br><span> }</span><br><s=
pan> </span><br><span> bool</span><br><span>@@ -2386,6 +2383,7 @@</span><br=
><span>         {</span><br><span>             if (!do_deferred_options_par=
t2(c))</span><br><span>             {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                msg(D_TLS_ERRORS, &quot;OPTIONS ERROR: fa=
iled to import crypto options&quot;);</span><br><span>                 retu=
rn false;</span><br><span>             }</span><br><span>         }</span><=
br><span>@@ -2518,8 +2516,6 @@</span><br><span>         return true;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    c-&gt;options=2Euse_peer_id =3D c-&gt;c2=2Etls_multi-&gt;u=
se_peer_id;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;s=
ession[TM_ACTIVE];</span><br><span> </span><br><span>     const char *ncp_c=
ipher =3D</span><br><span>@@ -2537,17 +2533,7 @@</span><br><span>         r=
eturn false;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct frame *frame_fragment =3D NULL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_FRAGMENT=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;options=
=2Ece=2Efragment)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        frame_fragme=
nt =3D &amp;c-&gt;c2=2Eframe_fragment;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (!tls_session_update_crypto_=
params(c-&gt;c2=2Etls_multi, session, &amp;c-&gt;options, &amp;c-&gt;c2=2Ef=
rame,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                          frame_fragment, get_link_socket_info(c),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
            &amp;c-&gt;c1=2Etuntap-&gt;dco))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (!do_deferred_options_part2(c))</span><br><=
span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;ERROR: failed =
to set crypto cipher&quot;);</span><br><span>         return false;</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2336?usp=3Demail">change 2336</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2336?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: Id36f1ae9b90be55cb7e77baa6f212bc1f06e2c6b=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2336 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>

</body></html>
--lkAWMvPGB/k=--


--===============6424818536470756749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6424818536470756749==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6424818536470756749==--

