Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E751606A324
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 12:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CwQWUdcv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IZ+0370g;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RN6tTH7I;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=RwAmeTB2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V0Pmf+0S4Emak0SiAOwP6Cm4aCh9/6iXPwag7MtTGR8=; b=CwQWUdcvX0Ra3y3IpOMbf6VIUA
	1+z6FuTP62PgOLBibtuLNmnwDacdDEJXRapOp+2hSA5iVxsatM1qv7qRz9gIVeD4MwZRxN1k0pe4P
	lfS2ZZGSAW93SRq5HXmoeROPAIOfD0OTEX40pGuvjcPLprgTqw0u31bHVK8LlZp00g7w=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xODRG-000000001PF-1m1f;
	Tue, 03 Nov 2026 12:16:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xODRE-000000001P8-32mr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QBS3hE/sqks3bzuhvYphQLsfLXetx/H5OFzFt2WlcWg=; b=IZ+0370gSVENWOME6NxusXnrrR
 /+/fE4KxF0EhxyZGQbwL+L4rLX3VjnMcDt0NQcILSPsrCYQ/gYib5oSVq2txAGD5lUtbvj/vB6Pk/
 E29q98Eer/CFoLFNQcz/IuXWutI/ZYOXVeoH8p+QcOMqQzUOKJzl/i95R0S1hUQ1Pibo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QBS3hE/sqks3bzuhvYphQLsfLXetx/H5OFzFt2WlcWg=; b=RN6tTH7Ili21xJcQxJC86mYT3T
 /shVtqVAgO63oMSJSQUPIkaLzya5fVIqPMirrr3YXhiqSrKFN41X1/F1PxbmLFLCJ6dnYj+EjBH7G
 IkkTDQzMWpVsEipxG7WGhkb66UAYWV/6BE99/743qmk4KT3Xi1MawlpcF60Kp7hd7PCY=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xODRC-000000003AM-1xdK for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 12:16:28 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c4649b35bso3844960f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 04:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793708180; x=1794312980; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QBS3hE/sqks3bzuhvYphQLsfLXetx/H5OFzFt2WlcWg=;
 b=RwAmeTB2Yj4DdSJpPinV9fEh5yxs7N6qanNuXRO5KlikkaPhk5M7LzxspnLuSK2FdV
 avh/ABCUgm9wEqURyNcD0p0tWFkk1Uix3+hKlbgxV7DjtUuZ8m2VwVOleWGzixpUzNY8
 FkTMqh0yPjSWmMuAazjijpbEyW+OG17nur24k8WP7z8JUJHlc4NA/AUkPh2N84rGQRWG
 Otyh0u2mFf3StkGH/d54MQiLGoK3m0w67R+kNlRTgnPAQkVfqojSllw8AfZiX/9jqdO9
 FXIkz7/BltqHJMSJKs3U67BPRWWnXj9+JsJ3cF28W+MChLAeQL/1n7S9btd9IVFi+34j
 iaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793708180; x=1794312980;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=QBS3hE/sqks3bzuhvYphQLsfLXetx/H5OFzFt2WlcWg=;
 b=tqDPd1AR2ERPk2IBHNmvK6i9ZuMbJ8twzaKOson7r5q6L0bAZybE5kX9op0Jw8chTi
 GnEfMN3KGKR7+Xo9FIn2WWcTMFq1WnIY23HN8UBUBBmepZhHFY+g0r4zs5elNvAgVDHw
 I3XktvK+vTYreXNapHhjWVztVWy9pv0CmoF7RpHERRvFgzjU0InDMv+Wyx1EODPEl/mh
 UR0EcP0mPTt4LURdavKkcgxtGDlqwHoN4QGR9+61Smb2+v7g3/tHC3YcyWFx4WeV2Re6
 TSqvBU4wt/sDG4r33xjz7+Q7jsOHVgzF9VhkTYF8HbGL+0szHKRtez/sMdNegCUSRe0f
 4rAw==
X-Gm-Message-State: APuU4Z8o1d/CEUKCwy1KfplfsnL4e30O6uscgMqEGAt+EwRLUOJNgot1
 fYskHSxrcOu3HMhByhck6wesIEft5z7U5bYJIqtCjQknNQbw4BTPdRRnqClpGy3nprjqkRPKoAF
 3lHexODIuS7LOVXTXFEN4yWmkq3mRYBEiqtyuSnGBCzXotyLswtpvn6DB1/HJwJwf15p7
X-Gm-Gg: AYBFou0O4nojc/FefX5KMUbJycnIatyxGpakr9+gj0aL2tQOXLSO5IigWEcPIjra5o1
 51jZuiLCf8gyquv0zWKAPSUn7mDbVherhTOpX8oHY4pCrHPWZocJwzhKzS/sQWlhsneJawEC7qn
 nQdXwxhov9rufClDdKMpjZpv8Kc/0Pcc50zAulP0gUhys0avcZTXOkAQsQMFTJmXDft62fugEIr
 HtMPbUYKgjMd/llmdHQdJESI3utFneZBcI6O1GCZs2fw0xq438g+VfQzaDL5FGjNTsuJplR0/K5
 f6kZhU/vM3oWtoM0KOGfP4F/0LIBcTvaNNEa6eTC2b7IVBbBBWL1ut5vOAjloWFqKxwykPsf7or
 W1GGnXbwP0+TpnNkbyMgCCRTHDM57F5QXFe+TANdBcNzExtlmj5Kn5vCAd55zLv2ozdbuuuVNRu
 fT7Lx7atsUNONg3xF3tdOHR+umbgaHSgYD9jGFnJSlUGWcvDwPxnONtpwi2tqw2+wNXgzS6p4fS
 +eEjwZU46LwQxBxI/6IRG1e6ilzYrK8jk2x1Bd7K3lBNouxO1Ul6ZiAhSX/uRZFb/KyyQ+P0nFP
 w+PzEJp38SdDLn+YAEzhSZVN17BAipDvH1vJeOMp2iL/Pr22Lkyw0WqdU8q0WAEudDbO/zNP1ci
 7SaQc+PL9Pi6OW9hWs3kR1lkyr+v7Gx2B3EZszkdu+8iZ7Ag0JA9fb1yqLV0hqqO+OWtCaQQV/y
 UEud2gh7mhoa3Hdg==
X-Received: by 2002:a05:6000:200e:b0:48c:466e:9d08 with SMTP id
 ffacd0b85a97d-48e6e50ab18mr28087712f8f.43.1793708179659; 
 Tue, 03 Nov 2026 04:16:19 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e86a06078sm8748447f8f.54.2026.11.03.04.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 04:16:19 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 12:16:18 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 6b617486ada6b9b936e0076081ca878ba493a3a9
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fde164ddbb6efd910e96d92ebf80bfacc351aff3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xODRC-000000003AM-1xdK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
Content-Type: multipart/mixed; boundary="===============3556813074562273140=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3556813074562273140==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v6Ps4GxKljQ="; charset=UTF-8

--v6Ps4GxKljQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Gert Doering has upl=
oaded a new patch set (#15) to the change originally created by Arne Schwab=
e=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail )

The f=
ollowing approvals got outdated and were removed:
Code-Review+2 by Arne Sch=
wabe, Code-Review+2 by R=C4=83zvan Cojocaru


Change subject: Introduce get=
_key_by_management_key_id helper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

Introduce get_key_by_management_key_id helper =
function

This function allows us to map from a management key id to a key =
structure
and also allows this function to be reused=2E

Patch v2: add mess=
age when key is not found=2E
Patch v3: only consider valid keys

Change-Id:=
 I42d8785959c24bf688190965e58b9b98251b8557
Signed-off-by: Arne Schwabe <arn=
e@rfc2549=2Eorg>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856
Message-Id: <2026110213=
4628=2E26248-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ec=
om/openvpn-devel@lists=2Esourceforge=2Enet/msg40434=2Ehtml
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
Acked-by: Razvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856
Message-Id: <202611031009=
55=2E20917-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ekernel=2Eorg/open=
vpn-devel/20261103100955=2E20917-1-gert@greenie=2Emuc=2Ede
Signed-off-by: G=
ert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/ssl_common=2Eh
M sr=
c/openvpn/ssl_verify=2Ec
2 files changed, 32 insertions(+), 10 deletions(-)=



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/18=
56/15

diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh=

index 579f46c=2E=2E9a55ead 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/s=
rc/openvpn/ssl_common=2Eh
@@ -764,4 +764,24 @@
     return &multi->session[=
TM_ACTIVE]=2Ekey[KS_PRIMARY];
 }
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Gets =
the \c key_state object that belongs to the management key id or
+ * return=
 NULL if not found=2E
+ */
+static inline struct key_state *
+get_key_by_ma=
nagement_key_id(struct tls_multi *multi, unsigned int mda_key_id)
+{
+    f=
or (int i =3D 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *=
ks =3D get_key_scan(multi, i);
+        if (ks->mda_key_id =3D=3D mda_key_i=
d && ks->state > S_UNDEF)
+        {
+            return ks;
+        }
+  =
  }
+    return NULL;
+}
+#endif
+
 #endif /* SSL_COMMON_H_ */
diff --git a=
/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 73e3696=2E=
=2E7baa4fc 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_ve=
rify=2Ec
@@ -1250,22 +1250,24 @@
 tls_authenticate_key(struct tls_multi *mu=
lti, const unsigned int mda_key_id, const bool auth,
                      =
const char *client_reason)
 {
-    bool ret =3D false;
+    struct key_stat=
e *ks =3D NULL;
     if (multi)
     {
-        int i;
         auth_set_cl=
ient_reason(multi, client_reason);
-        for (i =3D 0; i < KEY_SCAN_SIZE=
; ++i)
+        ks =3D get_key_by_management_key_id(multi, mda_key_id);
+
+=
        if (ks)
         {
-            struct key_state *ks =3D get_key_sc=
an(multi, i);
-            if (ks->mda_key_id =3D=3D mda_key_id)
-         =
   {
-                ks->mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;=

-                ret =3D true;
-            }
+            ks->mda_status =
=3D auth ? ACF_SUCCEEDED : ACF_FAILED;
+        }
+        else
+        {
=
+            msg(D_TLS_DEBUG_LOW,
+                "%s: no key state found =
for management key id %u",
+                __func__, mda_key_id);
        =
 }
     }
-    return ret;
+    return (bool)ks;
 }
 #endif /* ifdef ENABLE=
_MANAGEMENT */
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1856?usp=3Demail
To unsubscribe, or for help writing mail filters, vis=
it https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I42d8785959c24bf688190965e58b9b98251b8557
Gerrit-Change-Number: 1856
Gerr=
it-PatchSet: 15
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>

--v6Ps4GxKljQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gert Doering <strong>uploaded=
 patch set #15</strong> to the change originally created by Arne Schwabe=2E=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Dema=
il">View Change</a></p><p>The following approvals got outdated and were rem=
oved:
Code-Review+2 by Arne Schwabe, Code-Review+2 by R=C4=83zvan Cojocaru<=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">Introduce get_key_by_management_key_id helper function<br>=
<br>This function allows us to map from a management key id to a key struct=
ure<br>and also allows this function to be reused=2E<br><br>Patch v2: add m=
essage when key is not found=2E<br>Patch v3: only consider valid keys<br><b=
r>Change-Id: I42d8785959c24bf688190965e58b9b98251b8557<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1856<br>Message-Id: &lt;20261102134628=2E26248-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg40434=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL=
: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856<br>Message-Id: &lt;202611=
03100955=2E20917-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://lore=2Ekerne=
l=2Eorg/openvpn-devel/20261103100955=2E20917-1-gert@greenie=2Emuc=2Ede<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/=
openvpn/ssl_common=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>2 files changed, =
32 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1856/15</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br>=
<span>index 579f46c=2E=2E9a55ead 100644</span><br><span>--- a/src/openvpn/s=
sl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><s=
pan>@@ -764,4 +764,24 @@</span><br><span>     return &amp;multi-&gt;session=
[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Gets the \c key_state object that b=
elongs to the management key id or</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * return NULL if not found=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static inline struct key_state *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+get_key_by_management_key_id(struct tls_multi *multi=
, unsigned int mda_key_id)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (in=
t i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct key_state *ks =3D get_key_scan(multi, i);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (ks-&gt;mda_key_id =3D=
=3D mda_key_id &amp;&amp; ks-&gt;state &gt; S_UNDEF)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return ks;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* SSL=
_COMMON_H_ */</span><br><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src=
/openvpn/ssl_verify=2Ec</span><br><span>index 73e3696=2E=2E7baa4fc 100644</=
span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/o=
penvpn/ssl_verify=2Ec</span><br><span>@@ -1250,22 +1250,24 @@</span><br><sp=
an> tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_ke=
y_id, const bool auth,</span><br><span>                      const char *cl=
ient_reason)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct key_state *ks =3D NULL;</span><br><span>     if (m=
ulti)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        int i;</span><br><span>         auth_set_client_reason(multi=
, client_reason);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    for (i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        ks =3D get_key_by_management_key_id(multi,=
 mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ks)</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        struct key_state *ks =3D get_key_scan(multi, i);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (ks-&gt;mda_key_id =3D=3D=
 mda_key_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                k=
s-&gt;mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                ret =3D true;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;mda_status =3D auth =
? ACF_SUCCEEDED : ACF_FAILED;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D=
_TLS_DEBUG_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            &quot;%s: no key state found for management key id %u&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                __func=
__, mda_key_id);</span><br><span>         }</span><br><span>     }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return (bool)ks;</span><br><sp=
an> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br></pre=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
56?usp=3Demail">change 1856</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1856?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpat=
chset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<d=
iv style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557 </div=
>
<div style=3D"display:none"> Gerrit-Change-Number: 1856 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> =
Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--v6Ps4GxKljQ=--


--===============3556813074562273140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3556813074562273140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3556813074562273140==--

