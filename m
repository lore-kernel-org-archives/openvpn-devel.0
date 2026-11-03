Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C25606B36C
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 10:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pu5EZ0Jc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IvsC7Fta;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XhK0V5Ay;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=aQwWVMPH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XuNPg89jnnwLfKxEfDADSwiUsqhmU+PErtUgimEiyag=; b=Pu5EZ0JcVGxxnQF2xyd6JYtzuu
	Wp0OCfDOhvIAZEcfBgNXdzCKc9hnvckwdQjVi4BJ/Unmm6fKVHwK9rowJJERK3Uw5D4g5nyLxE98E
	NZnIecL+WpJ7RcT24/9gWRIyc0XaNzNROaKUCQUwHKj4P1beD+sV+sPIE/42Zld4lQA0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOBKd-000000007XB-1L42;
	Tue, 03 Nov 2026 10:01:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOBKb-000000007Wu-29gV
 for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:01:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e3wAF8O1/hLF0hSx4fHl7ybdkgqbck7EBgPJk8OUBEA=; b=IvsC7FtaI1agmHB/XAuiB7P/nR
 5kKCE+feI7ldRskGcbb/0XazCwiQSGBnxOnT/DpEKrAQ0buYpNgqs6a4+bpMzy4HuD4eaZNIrjGhg
 cVZ44fWtAWcJZ4cBtb3tMqKsGhHTzZ/ZDBZ2jXh/0LBRagHJbqJIYFkFSrXBvOmy+4c4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e3wAF8O1/hLF0hSx4fHl7ybdkgqbck7EBgPJk8OUBEA=; b=XhK0V5Ay6mLWLWxkg4e5hxI2tM
 XTG1LrytPxuyA3+9/AnagWQIreV79Ic8JMLF6ZAhnx0bgm7xSLj82mGRjySDs0DrQUcENwk8wqTqu
 zeBS8j1I2lsfBJpmEeYthKAuWCa8epC/AQSBw8QaBUlvnvKQPhwG2Qm6l+IKfvX4CAHw=;
Received: from mail-ed1-f50.google.com ([209.85.208.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOBKZ-000000000DO-43NF for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 10:01:29 +0000
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6a642495d81so5974765a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 02:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793700081; x=1794304881; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=e3wAF8O1/hLF0hSx4fHl7ybdkgqbck7EBgPJk8OUBEA=;
 b=aQwWVMPHTbJsUv8ViBY/TD7R5XWlrI6Aon+DBV3TI0y5sI4wLHVcQ3oTT4zQcq1Zds
 hX5XvqoXx5t5GLLTOvn4QImAhlwB/4ZoJs4DZ1hdlrZT2muVzEvjizOIlg4dUugfbD8+
 NPa7RHkBaAg1x+sSzbb/I1IMTPXr0o4WECHJj++tdDVmaQHCJiF7zIedgzWG7Mv1LR5X
 uEBYOn6p9vbi1HHpSSbaEd44QrSr4JqaK44+cjTxBQV1uyT3nNgRt5gEHPvDdITBTImD
 9o/+L1s2d/TqIDALX9+ypQwAkii+9kOsGmJ9YSyw4CYwdOqnRb82FVnxCIYnZ6TIDswB
 +rTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793700081; x=1794304881;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=e3wAF8O1/hLF0hSx4fHl7ybdkgqbck7EBgPJk8OUBEA=;
 b=dz9k3R99uM8EvxYO5m8m3OSisI+qFlzr5CQGpYVa9R/+K7leE+kQ0DkdQrrNC8aojG
 j8CczZWQ5Xg9Hd8Bcn2Kzc5k0GfqckeL9mjkIl6uiQOyWrA0WB6E6VMc3cjysVNLjBJW
 B6VBELiZBgg5M0sZxozQlOt/QWiCeMmpjb+YzosGc6TweHyWktjxuhHcC6DekpSf/QXQ
 GsvG1P2cKePRh2ydexKzZ97a8NTuOajRW5LIUKLJgCzwZeBQz38SivDcl7jfdgXRla6E
 mrmI+YBg0ToA7dy1+2inRWtEmFCKnw9H0HA+s6dylgnIUbrmTFGdYJPUA1EHaoPjS5jx
 K57g==
X-Gm-Message-State: APuU4Z+fCl+bQKnOP9QBjISc+SH306mbUVqBymYGKh8SC+EFpKgWGFXJ
 IzQi4tbZkZquayTfTR9hYnoEr4lCODGA65FtL7jyLD9jAL44AFwn0TgUYdGbR0CEwgnpmbF52qd
 m48q5hjzAa9gYv4zHzbmNtI7oxbwXSdfpd4zBTegPlhwItSv5dlNxdtNVuupp0Xc8LDC5
X-Gm-Gg: AYBFou32AFcIQtrSgJrskJPgCHnhJ3aOHqPqlGMoVvcxQJpFMJlryPyK43GuYeNyIs/
 pZsXmbLecoFSrmqmIsr14INti7pR7fQP+Ec+5ZMZ1aVCEUsnQksDvRmSutZ90OZDamyv1Q/b7dB
 BdGyYeqEmbTz6Xv2LAfVfGGXuxS6eKmc2U0r3G8gLurBqG2zrKkAH1SOOZj1JBkEKRpxADrZHIZ
 eTR8xB4VKIH9ZPJfeFHtvEEk2vatP7EzTITpkA/geBZWdIXCjAI/j7YZZgo5ITcq3tK2p9RrKxd
 4rZnl06TIpebU9TpEIv3vHhvg2Ucfi1yHzgU8iebEhObzM1pfEt2DQ/E8TePiX76oMQtDD9viwn
 OcTgVRTHV2qO3H3HoECwhHnms8kwyuelzZ+XRIb1jShHei0SRJNa9kwF3sfLB9gzZkGYZZanXYd
 CBBG0IU+yBzhO8EWT+CRAYlOkkUSagFtnjHh9WgpVfXa6GOhDOQj82jWTuWgRlMhZebIHLw6Cl0
 c1YRO7YCDs3TRsMhMC8b0Eu06LVMQee3+dEprI3k9wLOpcixTXbfCHNx/Fi1ovhb5Oe+O6h0bZ/
 HgwI9uowcXmas8byccfc3G/oetyVTXBMS+RVAD0oYmvLfnfODlMmhB8ZjcnBbYYQN45j29tRrpG
 tk5S+QZgaGPmI1aAZObT0dyT5zOrzaHkibtlYY1fV0ua2DbmohdQ3anmk+vu7Ug4juTkHRXoKeR
 0=
X-Received: by 2002:a05:6402:3441:b0:6b1:c355:c7c0 with SMTP id
 4fb4d7f45d1cf-6b4d4d78d65mr6525061a12.26.1793700080818; 
 Tue, 03 Nov 2026 02:01:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b728f9sm24127005f8f.10.2026.11.03.02.01.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 02:01:20 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 3 Nov 2026 10:01:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: bdffcbf4c648ffabd4d06de8fd5263ae4b71d203
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1adc459e7c122a1aaa289f05d8d70656103bf40c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOBKZ-000000000DO-43NF
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
Content-Type: multipart/mixed; boundary="===============7628733256776426536=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7628733256776426536==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KJzp8+gxXvE="; charset=UTF-8

--KJzp8+gxXvE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Gert Doering has uploaded a new patch set (#14) to the=
 change originally created by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1856?usp=3Demail )

The following approvals got outdated an=
d were removed:
Code-Review+2 by R=C4=83zvan Cojocaru

The change is no lon=
ger submittable: Code-Review and checks~ChecksSubmitRule are unsatisfied no=
w=2E


Change subject: Introduce get_key_by_management_key_id helper functi=
on
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Introduce =
get_key_by_management_key_id helper function

This function allows us to ma=
p from a management key id to a key structure
and also allows this function=
 to be reused=2E

Patch v2: add message when key is not found=2E
Patch v3: =
only consider valid keys

Change-Id: I42d8785959c24bf688190965e58b9b98251b8=
557
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Acked-by: Razvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1856
Message-Id: <20261102134628=2E26248-1-gert@greenie=2Emuc=2Ede>=

URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2E=
net/msg40434=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
-=
--
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_verify=2Ec
2 files change=
d, 32 insertions(+), 10 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2E=
net:29418/openvpn refs/changes/56/1856/14

diff --git a/src/openvpn/ssl_com=
mon=2Eh b/src/openvpn/ssl_common=2Eh
index 579f46c=2E=2E9a55ead 100644
--- =
a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -764,4 +76=
4,24 @@
     return &multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY];
 }
 
+#if=
def ENABLE_MANAGEMENT
+/**
+ * Gets the \c key_state object that belongs to=
 the management key id or
+ * return NULL if not found=2E
+ */
+static inli=
ne struct key_state *
+get_key_by_management_key_id(struct tls_multi *multi=
, unsigned int mda_key_id)
+{
+    for (int i =3D 0; i < KEY_SCAN_SIZE; ++i=
)
+    {
+        struct key_state *ks =3D get_key_scan(multi, i);
+       =
 if (ks->mda_key_id =3D=3D mda_key_id && ks->state > S_UNDEF)
+        {
+ =
           return ks;
+        }
+    }
+    return NULL;
+}
+#endif
+
 #en=
dif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_verify=2Ec b/src/openv=
pn/ssl_verify=2Ec
index 73e3696=2E=2E7baa4fc 100644
--- a/src/openvpn/ssl_v=
erify=2Ec
+++ b/src/openvpn/ssl_verify=2Ec
@@ -1250,22 +1250,24 @@
 tls_aut=
henticate_key(struct tls_multi *multi, const unsigned int mda_key_id, const=
 bool auth,
                      const char *client_reason)
 {
-    bool r=
et =3D false;
+    struct key_state *ks =3D NULL;
     if (multi)
     {
- =
       int i;
         auth_set_client_reason(multi, client_reason);
-     =
   for (i =3D 0; i < KEY_SCAN_SIZE; ++i)
+        ks =3D get_key_by_managem=
ent_key_id(multi, mda_key_id);
+
+        if (ks)
         {
-            s=
truct key_state *ks =3D get_key_scan(multi, i);
-            if (ks->mda_ke=
y_id =3D=3D mda_key_id)
-            {
-                ks->mda_status =3D =
auth ? ACF_SUCCEEDED : ACF_FAILED;
-                ret =3D true;
-        =
    }
+            ks->mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;
+ =
       }
+        else
+        {
+            msg(D_TLS_DEBUG_LOW,
+      =
          "%s: no key state found for management key id %u",
+             =
   __func__, mda_key_id);
         }
     }
-    return ret;
+    return (b=
ool)ks;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 

-- 
To view, visit http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b85=
57
Gerrit-Change-Number: 1856
Gerrit-PatchSet: 14
Gerrit-Owner: Arne Schwab=
e <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerr=
it-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichten=
held <frank@lichtenheld=2Ecom>

--KJzp8+gxXvE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Gert Doering <strong>uploaded patch set #14</strong> to the cha=
nge originally created by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Change</a></p><p>The fo=
llowing approvals got outdated and were removed:
Code-Review+2 by R=C4=83zv=
an Cojocaru</p><p>The change is no longer submittable: Code-Review and chec=
ks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">Introduce get=
_key_by_management_key_id helper function<br><br>This function allows us to=
 map from a management key id to a key structure<br>and also allows this fu=
nction to be reused=2E<br><br>Patch v2: add message when key is not found=
=2E<br>Patch v3: only consider valid keys<br><br>Change-Id: I42d8785959c24b=
f688190965e58b9b98251b8557<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=
=2Eorg&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856<br>Message-Id: &l=
t;20261102134628=2E26248-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40434=2Eht=
ml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br=
>M src/openvpn/ssl_common=2Eh<br>M src/openvpn/ssl_verify=2Ec<br>2 files ch=
anged, 32 insertions(+), 10 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/56/1856/14</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</spa=
n><br><span>index 579f46c=2E=2E9a55ead 100644</span><br><span>--- a/src/ope=
nvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span>=
<br><span>@@ -764,4 +764,24 @@</span><br><span>     return &amp;multi-&gt;s=
ession[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEM=
ENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Gets the \c key_state object =
that belongs to the management key id or</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * return NULL if not found=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline struct key_state *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+get_key_by_management_key_id(struct tls_mult=
i *multi, unsigned int mda_key_id)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct key_state *ks =3D get_key_scan(multi, i);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ks-&gt;mda_key=
_id =3D=3D mda_key_id &amp;&amp; ks-&gt;state &gt; S_UNDEF)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return ks;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif=
 /* SSL_COMMON_H_ */</span><br><span>diff --git a/src/openvpn/ssl_verify=2E=
c b/src/openvpn/ssl_verify=2Ec</span><br><span>index 73e3696=2E=2E7baa4fc 1=
00644</span><br><span>--- a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ =
b/src/openvpn/ssl_verify=2Ec</span><br><span>@@ -1250,22 +1250,24 @@</span>=
<br><span> tls_authenticate_key(struct tls_multi *multi, const unsigned int=
 mda_key_id, const bool auth,</span><br><span>                      const c=
har *client_reason)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    bool ret =3D false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct key_state *ks =3D NULL;</span><br><span>   =
  if (multi)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        int i;</span><br><span>         auth_set_client_reaso=
n(multi, client_reason);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        for (i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ks =3D get_key_by_management_key_=
id(multi, mda_key_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ks)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            struct key_state *ks =3D get_key_scan(multi, i);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            if (ks-&gt;mda_key_=
id =3D=3D mda_key_id)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        ks-&gt;mda_status =3D auth ? ACF_SUCCEEDED : ACF_FAILED;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                ret =3D true;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            ks-&gt;mda_status =
=3D auth ? ACF_SUCCEEDED : ACF_FAILED;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(D_TLS_DEBUG_LOW,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                &quot;%s: no key state found for management key id %u&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   __func__, mda_key_id);</span><br><span>         }</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (bool)ks;</spa=
n><br><span> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1856?usp=3Demail">change 1856</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b9825=
1b8557 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1856 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--KJzp8+gxXvE=--


--===============7628733256776426536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7628733256776426536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7628733256776426536==--

