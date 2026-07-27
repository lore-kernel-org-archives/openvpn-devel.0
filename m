Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D782C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 14:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mVlq7pjzgF/KQQGFlJCyYTUkUFt8EZya3xKlEmDz2Rk=; b=eXnlBBG8gMeIwDB+S1sThUgxZf
	QRX0q2NQyRL/3vadEbN0pQPq030IdwzClYWXnGMT5oIN9LGol3p+D/dKs2ILxrUBS+OF5emakRn8S
	E01tkTjdQ46NTjYJeUMDp3negE/zf5OtY7yCS2iIHrOiHDjG1QCCtEXtEfltDUjiguLk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woMRd-0007Ez-2n;
	Mon, 27 Jul 2026 14:36:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woMRb-0007El-I0
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:36:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=i0z3VIvJGJlweQHTG/s2MLAuT5OLBZfDtnsK4IY0HiA=; b=Ki4uLw75jwVbam/cwNemrhUokQ
 +5FRgsqftn3ylgZ7AxKU+TE353qTJI7EgICwUq9RB40SoBFOAbQMtqTtfIg7rYiGCnJWRdK+KfiGC
 wihHv76kOMGhC4bBKaFAZM+K9VDQH5FX2X3uzp0hqWn81f8Af0XVByGSIHY0wmsikMzY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i0z3VIvJGJlweQHTG/s2MLAuT5OLBZfDtnsK4IY0HiA=; b=F
 9Fnr6C4/dhpnFmCWF7z+gp5RRSh+0VNVf6Z26NlDZCdweAA4B14c9h7mf6t1kn0eMfNj3jCJFH3oe
 P2v0tAAL4k5Ogi5OUrEZOZ3gK2Q9QQqwhV7UbaPyxu5fqTdtIZrrxCh8NTRpQXl5TsCsZDncGpmZk
 g1ym60bl9ojcbtTc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woMRW-00008M-D7 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 14:36:40 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-495635a85d2so23450375e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785162988; x=1785767788; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i0z3VIvJGJlweQHTG/s2MLAuT5OLBZfDtnsK4IY0HiA=;
 b=IxiyM/oAtXvJlrzD+TQ8jyKwe/+vl95m4imoADdQNfEp31dWCf9NDPckyhIIZBrBmA
 flI/vEoAccOues4fE0vHOmCSMJKWuVAQow+SDLk0b4+H1B30AilgwtHwbDW6CCuWUChY
 y02ILei76lQaiv6A2TQxvu9+YkMQ3/+k+Mu7oGiIn7LqAIH7cNyc6Y23bimfpbafoDly
 VqvDkNy6CAY3AeDrqcKnOvCNMn2BLdFrsg6B4k9M1zjmtQYqz3RxBYImLB75E34jgl9R
 rzP1Fuq31GQu4dTHqtxXCPZvToFKd+qS5YXtEQfQbIaxrqRzghLgCiIeT1BTsSPrNJkl
 nknA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785162988; x=1785767788;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=i0z3VIvJGJlweQHTG/s2MLAuT5OLBZfDtnsK4IY0HiA=;
 b=jUO4O6VRIpZZ45VeoFlaZUPPlanGi4VXksHG5aBJMSzI9TKzwgmVX/+hYxptoe1Vvg
 WA3sPNKjVEtXNc22apYu8fKnrkyZV0NwcXjo5kY213OvhTZMYPeyc2rn1E/4XrzVsM3y
 pNQGMTwlK4n+u0N4jond8Zd2mAHKrwrfA6DqTCRX+zkI5uAMzDskpUBJGTp1ZWnQZaDP
 /ewr+R1bh4S3Cu7dJykfzISdSzD4DF1gbAEVID9W4C4H6yRP9+NwO0bmiZUyTzDoW6j+
 8c8S+dyv7dDMtAWpRoDq38glwIk36I7a2hNEFzIPvRn8ViEJZyGcclfeF+/cOJIbFurj
 kntQ==
X-Gm-Message-State: AOJu0YxMDQrUxRRvE1ArO7JhNZN2RM+jchjDLO0zlaaAauz12G6d9cou
 0lmDFb72t+F+Y3g8Z9kLlb1JriyY3akU6JXjpm/sEflFHvslHbSXSa0UO7iuDZvGYQQ3d6Echde
 TAHnhOp4cK/xQ3dStqPIjg52CtOeqs8IskM3XBOJM5LR2cLWOvaT1ykjkFmmQ0CPyrnc7UL5bx7
 4FZqDnUw==
X-Gm-Gg: AR+sD13rXuEcbbXBHPI3QeDv7Vyck4OEUe7FnMGbKUnceDBMDsvYNHyl5KmyQuhiQsb
 t1lVbfh76IFmIqI8DHlmRDKTozKvFbjiI222Ywew3Mir4yj7R8UTfLIcm6nd2i6mf2kaKkV4jQQ
 4jWcAlPzMmFpHmZ/vlefO4gb3ujkpt+jaj3t/zwxX5wwh7b2TuDMYuGQ8c9UqQKLhbnHMhZhdtY
 wxnHZ1MN0AGE5e4/GCpvphIoFsB7FE+suxmErsYkjqTgfgBTg3DvIX7U996qEwi+jmQhNYP6apU
 MewRZ6iLFgxTN/JMm8i3e3iEgpD7Iv9G4EaytpV/4qh9nITfTtUC8wOFEV7nAa05b0vdls+gDAe
 vRy3R02syWWhCA7En0YK0Y0mMbBG9//6dDlerTlUfijWGDL1pZGLtSN+gfJ2yVolEY0CmL9bYrS
 LSxdsXXRCUjDuvOn+BePgeDDS6qPy86kx7mvazjHcKoNRJEWK1YjPM6F3LWG851A1PNi+F/fm4k
 eRWKamYiVhu/N9kjDSF4Ze/7Z3vzKQ0c7l6zLeOR/p3SEDxTYF7pVWljlX6FAGu5Cow
X-Received: by 2002:a05:600c:a00b:b0:493:c182:6b08 with SMTP id
 5b1f17b1804b1-496b570f64cmr115629725e9.36.1785162986786; 
 Mon, 27 Jul 2026 07:36:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5d9sm47819858f8f.5.2026.07.27.07.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 07:36:25 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 14:36:10 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
X-Gerrit-Change-Number: 1661
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1661?usp=email>
X-Gerrit-Commit: e2c8416504c08352637e26a3c406a76602081bf6
In-Reply-To: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDEzNjAxMDAwLkkyYjcxZGFlMzdlYmU2M2MyNmE2Njc2MWY4NzdiMjVkMzI2ZWQxNDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dcd5dba3dbba784977bf5b35579e405513bdf3ab-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woMRW-00008M-D7
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constVariable/constVariablePointer cppcheck warnings
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8804155321862256572=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8804155321862256572==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TMBGNhBVMbM="; charset=UTF-8

--TMBGNhBVMbM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1661?usp=3Demail

to look at the new patch set (#8)=2E

=

Change subject: Remove instances of constVariable/constVariablePointer cpp=
check warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Remove instances of constVariable/constVariablePointer cppcheck warnings
=

Of varied usefulness, but easier to just address all of
them=2E

Also chan=
ge vpn_* parameters of dco_new_peer to const since
that is required by one =
of the changes and it works (and would
happen anyway when doing constParame=
terPointer)=2E

Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
Signed=
-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-tools/cppche=
ck-suppression
M sample/sample-plugins/defer/multi-auth=2Ec
M sample/sample=
-plugins/log/log=2Ec
M sample/sample-plugins/log/log_v3=2Ec
M sample/sample=
-plugins/simple/simple=2Ec
M src/openvpn/argv=2Ec
M src/openvpn/auth_token=
=2Ec
M src/openvpn/base64=2Ec
M src/openvpn/buffer=2Ec
M src/openvpn/buffer=
=2Eh
M src/openvpn/comp-lz4=2Ec
M src/openvpn/crypto=2Ec
M src/openvpn/cryp=
to_epoch=2Ec
M src/openvpn/cryptoapi=2Ec
M src/openvpn/dco=2Ec
M src/openvp=
n/dco_freebsd=2Ec
M src/openvpn/dco_internal=2Eh
M src/openvpn/dco_linux=2E=
c
M src/openvpn/dco_win=2Ec
M src/openvpn/dns=2Ec
M src/openvpn/event=2Ec
M=
 src/openvpn/forward=2Ec
M src/openvpn/init=2Ec
M src/openvpn/list=2Ec
M sr=
c/openvpn/manage=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/mss=2Ec
M src/ope=
nvpn/mtcp=2Ec
M src/openvpn/mudp=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/=
networking_sitnl=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options_parse=
=2Ec
M src/openvpn/options_util=2Ec
M src/openvpn/pool=2Ec
M src/openvpn/pr=
oxy=2Ec
M src/openvpn/push=2Ec
M src/openvpn/route=2Ec
M src/openvpn/socket=
=2Ec
M src/openvpn/socket=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_mbedt=
ls=2Ec
M src/openvpn/ssl_verify=2Ec
M src/openvpn/tun=2Ec
M src/openvpn/win=
32=2Ec
M src/openvpnmsica/msica_arg=2Ec
M src/openvpnmsica/openvpnmsica=2Ec=

M src/openvpnserv/interactive=2Ec
M src/plugins/auth-pam/auth-pam=2Ec
M sr=
c/tapctl/main=2Ec
M tests/unit_tests/openvpn/test_buffer=2Ec
M tests/unit_t=
ests/openvpn/test_crypto=2Ec
M tests/unit_tests/openvpn/test_cryptoapi=2Ec
=
M tests/unit_tests/openvpn/test_misc=2Ec
M tests/unit_tests/openvpn/test_pk=
t=2Ec
M tests/unit_tests/openvpn/test_ssl=2Ec
M tests/unit_tests/plugins/au=
th-pam/test_search_and_replace=2Ec
57 files changed, 170 insertions(+), 171=
 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/=
changes/61/1661/8

diff --git a/dev-tools/cppcheck-suppression b/dev-tools/=
cppcheck-suppression
index 2e3350b=2E=2E900e03c 100644
--- a/dev-tools/cppc=
heck-suppression
+++ b/dev-tools/cppcheck-suppression
@@ -3,8 +3,6 @@
 cons=
tParameter
 constParameterCallback
 constParameterPointer
-constVariable
-c=
onstVariablePointer
 invalidPrintfArgType_sint
 invalidPrintfArgType_uint
 =
usleepCalled
diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/samp=
le/sample-plugins/defer/multi-auth=2Ec
index f6bbf44=2E=2Ebacf557 100644
--=
- a/sample/sample-plugins/defer/multi-auth=2Ec
+++ b/sample/sample-plugins/=
defer/multi-auth=2Ec
@@ -381,7 +381,7 @@
     }
     const char **argv =3D =
args->argv;
     const char **envp =3D args->envp;
-    struct plugin_conte=
xt *context =3D (struct plugin_context *)args->handle;
+    const struct pl=
ugin_context *context =3D (struct plugin_context *)args->handle;
     struc=
t plugin_per_client_context *pcc =3D
         (struct plugin_per_client_con=
text *)args->per_client_context;
     switch (args->type)
@@ -399,7 +399,7 =
@@
 OPENVPN_EXPORT void *
 openvpn_plugin_client_constructor_v1(openvpn_plu=
gin_handle_t handle)
 {
-    struct plugin_context *context =3D (struct plu=
gin_context *)handle;
+    const struct plugin_context *context =3D (struct=
 plugin_context *)handle;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plug=
in_client_constructor_v1");
     return calloc(1, sizeof(struct plugin_per_=
client_context));
 }
@@ -407,7 +407,7 @@
 OPENVPN_EXPORT void
 openvpn_plug=
in_client_destructor_v1(openvpn_plugin_handle_t handle, void *per_client_co=
ntext)
 {
-    struct plugin_context *context =3D (struct plugin_context *)=
handle;
+    const struct plugin_context *context =3D (struct plugin_contex=
t *)handle;
     plog(context, PLOG_NOTE, "FUNC: openvpn_plugin_client_dest=
ructor_v1");
     free(per_client_context);
 }
diff --git a/sample/sample-p=
lugins/log/log=2Ec b/sample/sample-plugins/log/log=2Ec
index 330e3e0=2E=2E7=
6350ee 100644
--- a/sample/sample-plugins/log/log=2Ec
+++ b/sample/sample-p=
lugins/log/log=2Ec
@@ -173,7 +173,7 @@
 openvpn_plugin_func_v1(openvpn_plug=
in_handle_t handle, const int type, const char *argv[],
                   =
     const char *envp[])
 {
-    struct plugin_context *context =3D (struct=
 plugin_context *)handle;
+    const struct plugin_context *context =3D (st=
ruct plugin_context *)handle;
 
     show(type, argv, envp);
 
diff --git a=
/sample/sample-plugins/log/log_v3=2Ec b/sample/sample-plugins/log/log_v3=2E=
c
index d2d44c7=2E=2E09c6735 100644
--- a/sample/sample-plugins/log/log_v3=
=2Ec
+++ b/sample/sample-plugins/log/log_v3=2Ec
@@ -245,7 +245,7 @@
 openvp=
n_plugin_func_v3(const int version, struct openvpn_plugin_args_func_in cons=
t *args,
                        struct openvpn_plugin_args_func_return *re=
tptr)
 {
-    struct plugin_context *context =3D (struct plugin_context *)a=
rgs->handle;
+    const struct plugin_context *context =3D (struct plugin_c=
ontext *)args->handle;
 
     printf("\nopenvpn_plugin_func_v3() :::::>> ")=
;
     show(args->type, args->argv, args->envp);
diff --git a/sample/sample=
-plugins/simple/simple=2Ec b/sample/sample-plugins/simple/simple=2Ec
index =
687a633=2E=2E3182be0 100644
--- a/sample/sample-plugins/simple/simple=2Ec
+=
++ b/sample/sample-plugins/simple/simple=2Ec
@@ -104,7 +104,7 @@
 openvpn_p=
lugin_func_v1(openvpn_plugin_handle_t handle, const int type, const char *a=
rgv[],
                        const char *envp[])
 {
-    struct plugin_co=
ntext *context =3D (struct plugin_context *)handle;
+    const struct plugi=
n_context *context =3D (struct plugin_context *)handle;
 
     /* get usern=
ame/password from envp string array */
     const char *username =3D get_en=
v("username", envp);
diff --git a/src/openvpn/argv=2Ec b/src/openvpn/argv=
=2Ec
index 6a5d92e=2E=2E028671d 100644
--- a/src/openvpn/argv=2Ec
+++ b/src=
/openvpn/argv=2Ec
@@ -359,7 +359,7 @@
      *
      */
     size_t argc =3D=
 argres->argc;
-    char *f =3D argv_prep_format(format, delim, &argc, &arg=
res->gc);
+    const char *f =3D argv_prep_format(format, delim, &argc, &ar=
gres->gc);
     if (f =3D=3D NULL)
     {
         goto out;
diff --git a/s=
rc/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec
index bd90212=2E=2Ef=
928a41 100644
--- a/src/openvpn/auth_token=2Ec
+++ b/src/openvpn/auth_token=
=2Ec
@@ -235,7 +235,7 @@
      * a new token with the empty username since =
we do not want to loose
      * the information that the username cannot be=
 trusted
      */
-    struct key_state *ks =3D &multi->session[TM_ACTIVE]=
=2Ekey[KS_PRIMARY];
+    const struct key_state *ks =3D &multi->session[TM_=
ACTIVE]=2Ekey[KS_PRIMARY];
     if (ks->auth_token_state_flags & AUTH_TOKEN=
_VALID_EMPTYUSER)
     {
         hmac_ctx_update(ctx, (const uint8_t *)"",=
 0);
diff --git a/src/openvpn/base64=2Ec b/src/openvpn/base64=2Ec
index 7af=
8976=2E=2E5752844 100644
--- a/src/openvpn/base64=2Ec
+++ b/src/openvpn/bas=
e64=2Ec
@@ -161,7 +161,7 @@
 {
     const char *p;
     unsigned char *q;
-=
    unsigned char *e =3D NULL;
+    const unsigned char *e =3D NULL;
 
    =
 q =3D data;
     if (size >=3D 0)
diff --git a/src/openvpn/buffer=2Ec b/sr=
c/openvpn/buffer=2Ec
index 922238d=2E=2Ef57c8c2 100644
--- a/src/openvpn/bu=
ffer=2Ec
+++ b/src/openvpn/buffer=2Ec
@@ -536,7 +536,7 @@
 void
 buf_null_t=
erminate(struct buffer *buf)
 {
-    char *last =3D (char *)BLAST(buf);
+  =
  const char *last =3D (char *)BLAST(buf);
     if (last && *last =3D=3D '\=
0') /* already terminated? */
     {
         return;
@@ -559,7 +559,7 @@
 =
{
     while (true)
     {
-        char *last =3D (char *)BLAST(buf);
+   =
     const char *last =3D (char *)BLAST(buf);
         if (!last)
         =
{
             break;
diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buf=
fer=2Eh
index c6722c7=2E=2E93aa786 100644
--- a/src/openvpn/buffer=2Eh
+++ =
b/src/openvpn/buffer=2Eh
@@ -720,7 +720,7 @@
 static inline bool
 buf_copy_=
n(struct buffer *dest, struct buffer *src, int n)
 {
-    uint8_t *cp =3D b=
uf_read_alloc(src, n);
+    const uint8_t *cp =3D buf_read_alloc(src, n);
 =
    if (!cp)
     {
         return false;
@@ -772,7 +772,7 @@
 static inli=
ne bool
 buf_read(struct buffer *src, void *dest, int size)
 {
-    uint8_t=
 *cp =3D buf_read_alloc(src, size);
+    const uint8_t *cp =3D buf_read_all=
oc(src, size);
     if (!cp)
     {
         return false;
diff --git a/src=
/openvpn/comp-lz4=2Ec b/src/openvpn/comp-lz4=2Ec
index 45f138c=2E=2E48797b0=
 100644
--- a/src/openvpn/comp-lz4=2Ec
+++ b/src/openvpn/comp-lz4=2Ec
@@ -1=
64,7 +164,7 @@
     ASSERT(buf_init(&work, frame->buf=2Eheadroom));
 
     =
/* do unframing/swap (assumes buf->len > 0) */
-    uint8_t *head =3D BPTR(=
buf);
+    const uint8_t *head =3D BPTR(buf);
     c =3D *head;
 
     /* N=
ot compressed */
diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=
=2Ec
index 6127fdb=2E=2E67ff0d3 100644
--- a/src/openvpn/crypto=2Ec
+++ b/s=
rc/openvpn/crypto=2Ec
@@ -1210,7 +1210,7 @@
 
     /* init implicit IV */
 =
    {
-        cipher_ctx_t *cipher =3D co->key_ctx_bi=2Eencrypt=2Ecipher;
=
+        const cipher_ctx_t *cipher =3D co->key_ctx_bi=2Eencrypt=2Ecipher;
=
         if (cipher_ctx_mode_aead(cipher))
         {
             ASSERT(c=
ipher_ctx_iv_length(cipher) <=3D OPENVPN_MAX_IV_LENGTH);
@@ -1920,7 +1920,7=
 @@
     const char *seed =3D "tls1-prf-test";
     const char *secret =3D =
"tls1-prf-test-secret";
     uint8_t out[8];
-    uint8_t expected_out[] =
=3D { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
+    const uint8_t expect=
ed_out[] =3D { 'q', 'D', 0xfe, '%', '@', 's', 'u', 0x95 };
 
     int ret =
=3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8_t *)secret,
        =
                    strlen(secret), out, sizeof(out));
diff --git a/src/ope=
nvpn/crypto_epoch=2Ec b/src/openvpn/crypto_epoch=2Ec
index 54225bf=2E=2E381=
2435 100644
--- a/src/openvpn/crypto_epoch=2Ec
+++ b/src/openvpn/crypto_epo=
ch=2Ec
@@ -213,7 +213,7 @@
      *
      * The last generated key might hav=
e been moved to the decrypt key already=2E
      */
-    struct key_ctx *hi=
ghest_future_key =3D
+    const struct key_ctx *highest_future_key =3D
    =
     &co->epoch_data_keys_future[co->epoch_data_keys_future_count - 1];
 
 =
    ASSERT(co->epoch_key_recv=2Eepoch =3D=3D 1 || highest_future_key->epoch=
 =3D=3D co->epoch_key_recv=2Eepoch
diff --git a/src/openvpn/cryptoapi=2Ec b=
/src/openvpn/cryptoapi=2Ec
index 0f95ab7=2E=2Ead2706c 100644
--- a/src/open=
vpn/cryptoapi=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -225,7 +225,6 @@
     =
const CERT_INFO *info =3D cert_ctx->pCertInfo;
     const CERT_EXTENSION *e=
xt;
     DWORD cbext;
-    void *pvext;
     struct gc_arena gc =3D gc_new(=
);
     const WCHAR *tmpl_name =3D wide_string(cert_prop, &gc);
 
@@ -233,7=
 +232,7 @@
     ext =3D CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info-=
>cExtension, info->rgExtension);
     if (ext)
     {
-        pvext =3D de=
code_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Value, 0, &cbext);
+     =
   const void *pvext =3D decode_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext=
->Value, 0, &cbext);
         if (pvext && cbext >=3D sizeof(CERT_TEMPLATE_=
EXT))
         {
             const CERT_TEMPLATE_EXT *cte =3D (const CERT_=
TEMPLATE_EXT *)pvext;
diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2E=
c
index 2584368=2E=2Ef5d409d 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/ope=
nvpn/dco=2Ec
@@ -112,7 +112,7 @@
     for (int i =3D 0; i < KEY_SCAN_SIZE; =
++i)
     {
         struct key_state *ks =3D get_key_scan(multi, i);
-    =
    struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
+        c=
onst struct key_ctx_bi *key =3D &ks->crypto_options=2Ekey_ctx_bi;
 
       =
  if (ks =3D=3D primary)
         {
@@ -576,7 +576,7 @@
                   =
      struct sockaddr_storage *local)
 {
 #if ENABLE_IP_PKTINFO
-    struct=
 context *c =3D &mi->context;
+    const struct context *c =3D &mi->context=
;
 
     if (!proto_is_udp(c->c2=2Elink_sockets[0]->info=2Eproto)
         =
|| !(c->options=2Esockflags & SF_USE_IP_PKTINFO))
@@ -624,7 +624,7 @@
 int
=
 dco_multi_add_new_peer(struct multi_context *m, struct multi_instance *mi)=

 {
-    struct context *c =3D &mi->context;
+    const struct context *c =
=3D &mi->context;
 
     int peer_id =3D c->c2=2Etls_multi->peer_id;
     s=
truct sockaddr *remoteaddr, *localaddr =3D NULL;
@@ -645,14 +645,14 @@
 
  =
   /* In server mode we need to fetch the remote addresses from the push co=
nfig */
     struct in_addr vpn_ip4 =3D { 0 };
-    struct in_addr *vpn_add=
r4 =3D NULL;
+    const struct in_addr *vpn_addr4 =3D NULL;
     if (c->c2=
=2Epush_ifconfig_defined)
     {
         vpn_ip4=2Es_addr =3D htonl(c->c2=
=2Epush_ifconfig_local);
         vpn_addr4 =3D &vpn_ip4;
     }
 
-    str=
uct in6_addr *vpn_addr6 =3D NULL;
+    const struct in6_addr *vpn_addr6 =3D=
 NULL;
     if (c->c2=2Epush_ifconfig_ipv6_defined)
     {
         vpn_add=
r6 =3D &c->c2=2Epush_ifconfig_ipv6_local;
@@ -701,7 +701,7 @@
     }
 #endi=
f
 
-    struct context *c =3D &mi->context;
+    const struct context *c =
=3D &mi->context;
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if define=
d(_WIN32)
@@ -749,7 +749,7 @@
     }
     ASSERT(TUNNEL_TYPE(mi->context=2E=
c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
-    struct context *c =3D &mi->contex=
t;
+    const struct context *c =3D &mi->context;
 
     if (mi->context=2E=
c2=2Epush_ifconfig_defined)
     {
diff --git a/src/openvpn/dco_freebsd=2Ec=
 b/src/openvpn/dco_freebsd=2Ec
index eaca86b=2E=2Ed933aaf 100644
--- a/src/=
openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -134,7 +134,8 =
@@
 
 int
 dco_new_peer(dco_context_t *dco, unsigned int peerid, int sd, st=
ruct sockaddr *localaddr,
-             struct sockaddr *remoteaddr, struct=
 in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)
+             struct sockadd=
r *remoteaddr, const struct in_addr *vpn_ipv4,
+             const struct i=
n6_addr *vpn_ipv6)
 {
     struct ifdrv drv;
     nvlist_t *nvl, *local_nvl=
, *remote_nvl;
diff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_=
internal=2Eh
index da07780=2E=2Efcf8aca 100644
--- a/src/openvpn/dco_intern=
al=2Eh
+++ b/src/openvpn/dco_internal=2Eh
@@ -60,7 +60,7 @@
  */
 
 int dco=
_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, =
struct sockaddr *localaddr,
-                 struct sockaddr *remoteaddr, =
struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6);
+                 str=
uct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6_=
addr *vpn_ipv6);
 
 int dco_del_peer(dco_context_t *dco, unsigned int peeri=
d);
 
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
in=
dex 40746bd=2E=2E56f6259 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/o=
penvpn/dco_linux=2Ec
@@ -222,7 +222,8 @@
 
 int
 dco_new_peer(dco_context_t=
 *dco, unsigned int peerid, int sd, struct sockaddr *localaddr,
-          =
   struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *=
vpn_ipv6)
+             struct sockaddr *remoteaddr, const struct in_addr *=
vpn_ipv4,
+             const struct in6_addr *vpn_ipv6)
 {
     struct gc_=
arena gc =3D gc_new();
     const char *remotestr =3D "[undefined]";
@@ -69=
7,7 +698,7 @@
 {
     dco_context_t *dco =3D arg;
     struct nlattr *tb[CT=
RL_ATTR_MAX + 1];
-    struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg=
));
+    const struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));
 
  =
   nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(gnlh, 0), genlmsg_attrlen(=
gnlh, 0), NULL);
 
@@ -706,7 +707,7 @@
         return NL_SKIP;
     }
 
- =
   struct nlattr *mcgrp;
+    const struct nlattr *mcgrp;
     int rem_mcgr=
p;
     nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GROUPS], rem_mcgrp)
 =
    {
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index =
2e26f2a=2E=2Eb3268bc 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn=
/dco_win=2Ec
@@ -285,8 +285,8 @@
     msg(D_DCO_DEBUG, "%s", __func__);
 
 =
    int ai_family =3D sock->info=2Elsa->bind_local->ai_family;
-    struct =
addrinfo *local =3D sock->info=2Elsa->bind_local;
-    struct addrinfo *cur=
 =3D NULL;
+    const struct addrinfo *local =3D sock->info=2Elsa->bind_loc=
al;
+    const struct addrinfo *cur =3D NULL;
 
     for (cur =3D local; cu=
r; cur =3D cur->ai_next)
     {
@@ -334,7 +334,7 @@
     struct addrinfo *r=
emoteaddr =3D sock->info=2Elsa->current_remote;
 
     struct sockaddr *loc=
al =3D NULL;
-    struct sockaddr *remote =3D remoteaddr->ai_addr;
+    con=
st struct sockaddr *remote =3D remoteaddr->ai_addr;
 
     if (remoteaddr->=
ai_protocol =3D=3D IPPROTO_TCP || remoteaddr->ai_socktype =3D=3D SOCK_STREA=
M)
     {
@@ -348,7 +348,7 @@
     if (sock->bind_local)
     {
         /*=
 Use first local address with correct address family */
-        struct add=
rinfo *bind =3D sock->info=2Elsa->bind_local;
+        const struct addrinf=
o *bind =3D sock->info=2Elsa->bind_local;
         while (bind && !local)
 =
        {
             if (bind->ai_family =3D=3D remote->sa_family)
@@ -41=
5,8 +415,9 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned int peer=
id, socket_descriptor_t sd, struct sockaddr *localaddr,
-             struc=
t sockaddr *remoteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6=
)
+dco_new_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_=
t sd,
+             struct sockaddr *localaddr, struct sockaddr *remoteaddr=
,
+             const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_=
ipv6)
 {
     msg(D_DCO_DEBUG, "%s: peer-id %d, fd " SOCKET_PRINTF, __func_=
_, peerid, sd);
 
@@ -745,7 +746,7 @@
     struct gc_arena gc =3D gc_new();=

 
     int ret =3D 0;
-    struct tuntap *tt =3D dco->tt;
+    const struc=
t tuntap *tt =3D dco->tt;
 
     if (!tuntap_defined(tt))
     {
@@ -869,7 =
+870,7 @@
 int
 dco_get_peer_stats_fallback(struct context *c, const bool r=
aise_sigusr1_on_err)
 {
-    struct tuntap *tt =3D c->c1=2Etuntap;
+    con=
st struct tuntap *tt =3D c->c1=2Etuntap;
 
     if (!tuntap_defined(tt))
  =
   {
@@ -898,7 +899,7 @@
 int
 dco_get_peer_stats(struct context *c, const =
bool raise_sigusr1_on_err)
 {
-    struct tuntap *tt =3D c->c1=2Etuntap;
+ =
   const struct tuntap *tt =3D c->c1=2Etuntap;
 
     if (!tuntap_defined(t=
t))
     {
diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec
index 146=
5cdf=2E=2E7f4dde4 100644
--- a/src/openvpn/dns=2Ec
+++ b/src/openvpn/dns=2E=
c
@@ -132,7 +132,7 @@
     }
     else
     {
-        struct sockaddr_in6 =
*sin6 =3D (struct sockaddr_in6 *)ai->ai_addr;
+        const struct sockadd=
r_in6 *sin6 =3D (struct sockaddr_in6 *)ai->ai_addr;
         server->addr[s=
erver->addr_count]=2Ein=2Ea6 =3D sin6->sin6_addr;
     }
 
@@ -156,7 +156,7=
 @@
     /* Append all domains to the end of the list */
     while (*domai=
ns)
     {
-        char *domain =3D *domains++;
+        const char *domai=
n =3D *domains++;
         if (!validate_domain(domain))
         {
       =
      return false;
@@ -699,7 +699,7 @@
 run_up_down_command(bool up, struc=
t options *o, const struct tuntap *tt,
                     struct dns_updo=
wn_runner_info *updown_runner)
 {
-    struct dns_options *dns =3D &o->dns_=
options;
+    const struct dns_options *dns =3D &o->dns_options;
     if (!=
dns->updown || (o->up_script && !dns_updown_user_set(dns) && !dns_updown_fo=
rced(dns)))
     {
         return;
@@ -864,7 +864,7 @@
     }
 #ifdef _WIN=
32
     /* Don't use iservice in DHCP mode */
-    struct tuntap_options *t=
to =3D &o->tuntap_options;
+    const struct tuntap_options *tto =3D &o->tu=
ntap_options;
     if (tto->ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ || tto=
->ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)
     {
         return;
diff --g=
it a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec
index 9e17807=2E=2E8b771=
6a 100644
--- a/src/openvpn/event=2Ec
+++ b/src/openvpn/event=2Ec
@@ -557,7=
 +557,7 @@
 ep_del(struct event_set *es, event_t event)
 {
     struct epol=
l_event ev;
-    struct ep_set *eps =3D (struct ep_set *)es;
+    const str=
uct ep_set *eps =3D (struct ep_set *)es;
 
     dmsg(D_EVENT_WAIT, "EP_DEL =
ev=3D%d", (int)event);
 
@@ -572,7 +572,7 @@
 static void
 ep_ctl(struct ev=
ent_set *es, event_t event, unsigned int rwflags, void *arg)
 {
-    struct=
 ep_set *eps =3D (struct ep_set *)es;
+    const struct ep_set *eps =3D (st=
ruct ep_set *)es;
     struct epoll_event ev;
 
     CLEAR(ev);
diff --git =
a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index c5b9278=2E=2E6581=
998 100644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -=
1213,7 +1213,7 @@
 {
     if (float_sa->sa_family =3D=3D AF_INET)
     {
- =
       struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;
+    =
    const struct sockaddr_in *float4 =3D (struct sockaddr_in *)float_sa;
  =
       /* DCO treats IPv4-mapped IPv6 addresses as pure IPv4=2E However, on=
 a
          * dual-stack socket, we need to preserve the mapping otherwise=
 openvpn
          * will not be able to find the peer by its transport add=
ress=2E
@@ -1236,7 +1236,7 @@
     }
     else
     {
-        struct socka=
ddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
+        const struct =
sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;
         memcpy(&=
out_osaddr->addr=2Ein6, float6, sizeof(struct sockaddr_in6));
     }
 }
@@ =
-1366,8 +1366,8 @@
         return;
     }
 
-    struct openvpn_sockaddr *=
link_addr =3D &c->c2=2Eto_link_addr->dest;
-    struct link_socket_info *ls=
i =3D get_link_socket_info(c);
+    const struct openvpn_sockaddr *link_add=
r =3D &c->c2=2Eto_link_addr->dest;
+    const struct link_socket_info *lsi =
=3D get_link_socket_info(c);
 
     int ip_hdr_offset =3D 0;
     int tun_i=
p_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1=2Etuntap), buf, &ip_hdr_offset);=

@@ -1404,7 +1404,7 @@
         }
 
         /* drop packets with same dest=
 addr and port as remote */
-        uint8_t *l4_hdr =3D (uint8_t *)pip + i=
p_hlen;
+        const uint8_t *l4_hdr =3D (uint8_t *)pip + ip_hlen;
 
    =
     uint16_t link_port =3D ntohs(link_addr->addr=2Ein4=2Esin_port);
 
@@ -=
1451,7 +1451,7 @@
         uint16_t link_port =3D ntohs(link_addr->addr=2Ei=
n6=2Esin6_port);
 
         /* drop packets with same dest addr and port as=
 remote */
-        uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct ope=
nvpn_ipv6hdr);
+        const uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(=
struct openvpn_ipv6hdr);
         uint16_t src_port =3D ntohs(*(uint16_t *)=
l4_hdr);
         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof=
(uint16_t)));
         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr->addr=2Ei=
n6=2Esin6_addr, &pip6->daddr)) && (link_port =3D=3D dst_port))
@@ -2209,7 +=
2209,7 @@
 
                     if (e->arg >=3D MULTI_N)
                 =
    {
-                        struct event_arg *ev_arg =3D (struct event_a=
rg *)e->arg;
+                        const struct event_arg *ev_arg =3D (s=
truct event_arg *)e->arg;
                         if (ev_arg->type !=3D EV=
ENT_ARG_LINK_SOCKET)
                         {
                           =
  c->c2=2Eevent_set_status =3D ES_ERROR;
diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec
index 914d191=2E=2Ea068b8b 100644
--- a/src/openvpn/=
init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -319,8 +319,8 @@
 management_callbac=
k_remote_entry_count(void *arg)
 {
     ASSERT(arg);
-    struct context *c=
 =3D (struct context *)arg;
-    struct connection_list *l =3D c->options=
=2Econnection_list;
+    const struct context *c =3D (struct context *)arg;=

+    const struct connection_list *l =3D c->options=2Econnection_list;
 
 =
    return l->len;
 }
@@ -342,7 +342,7 @@
 
     if (index < l->len)
     {=

-        struct connection_entry *ce =3D l->array[index];
+        const s=
truct connection_entry *ce =3D l->array[index];
         const char *proto =
=3D proto2ascii(ce->proto, ce->af, false);
         const char *status =3D =
(ce->flags & CE_DISABLED) ? "disabled" : "enabled";
 
@@ -525,7 +525,7 @@
 =
{
     struct connection_list *l =3D c->options=2Econnection_list;
     boo=
l ce_defined;
-    struct connection_entry *ce;
+    const struct connectio=
n_entry *ce;
     int n_cycles =3D 0;
 
     do
@@ -1581,10 +1581,10 @@
   =
  /* Tell management interface that we initialized */
     if (management)
=
     {
-        in_addr_t *tun_local =3D NULL;
-        struct in6_addr *tu=
n_local6 =3D NULL;
+        const in_addr_t *tun_local =3D NULL;
+        c=
onst struct in6_addr *tun_local6 =3D NULL;
         struct openvpn_sockaddr=
 local, remote;
-        struct link_socket_actual *actual;
+        const =
struct link_socket_actual *actual;
         socklen_t sa_len =3D sizeof(loc=
al);
         const char *detail =3D "SUCCESS";
         if (flags & ISC_ER=
RORS)
@@ -4293,7 +4293,7 @@
     /* On some newer Android handsets, changin=
g to a different network
      * often does not trigger a TCP reset but con=
tinue using the old
      * connection (e=2Eg=2E using mobile connection wh=
en WiFi becomes available */
-    struct link_socket_info *lsi =3D get_link=
_socket_info(c);
+    const struct link_socket_info *lsi =3D get_link_socke=
t_info(c);
     if (lsi && proto_is_tcp(lsi->proto) && !samenetwork)
     {=

         return -2;
diff --git a/src/openvpn/list=2Ec b/src/openvpn/list=
=2Ec
index c07e764=2E=2E09349e7 100644
--- a/src/openvpn/list=2Ec
+++ b/src=
/openvpn/list=2Ec
@@ -165,7 +165,7 @@
 hash_remove_by_value(struct hash *ha=
sh, void *value)
 {
     struct hash_iterator hi;
-    struct hash_element =
*he;
+    const struct hash_element *he;
 
     hash_iterator_init(hash, &h=
i);
     while ((he =3D hash_iterator_next(&hi)))
diff --git a/src/openvpn/=
manage=2Ec b/src/openvpn/manage=2Ec
index c082f51=2E=2E604bbcd 100644
--- a=
/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -3820,7 +3820,7 @@
=
 {
     int ok;
     char *result =3D NULL;
-    struct buffer *buf;
+    c=
onst struct buffer *buf;
 
     ok =3D management_query_multiline(man, b64_=
data, prompt, cmd, state, input);
     if (ok && buffer_list_defined(*input=
))
@@ -3849,7 +3849,7 @@
 {
     int ok;
     char *result =3D NULL;
-    s=
truct buffer *buf;
+    const struct buffer *buf;
 
     ok =3D management_=
query_multiline(man, b64_data, prompt, cmd, state, input);
     if (ok && b=
uffer_list_defined(*input))
diff --git a/src/openvpn/misc=2Ec b/src/openvpn=
/misc=2Ec
index 10bfc35=2E=2E6563b83 100644
--- a/src/openvpn/misc=2Ec
+++ =
b/src/openvpn/misc=2Ec
@@ -131,7 +131,7 @@
     struct auth_challenge_info =
*ac;
     const int len =3D strlen(auth_challenge);
     char *work =3D (ch=
ar *)gc_malloc(len + 1, false, gc);
-    char *cp;
+    const char *cp;
 
 =
    struct buffer b;
     buf_set_read(&b, (const uint8_t *)auth_challenge,=
 len);
diff --git a/src/openvpn/mss=2Ec b/src/openvpn/mss=2Ec
index 14112b4=
=2E=2E36bbb43 100644
--- a/src/openvpn/mss=2Ec
+++ b/src/openvpn/mss=2Ec
@@=
 -65,7 +65,7 @@
         struct buffer newbuf =3D *buf;
         if (buf_ad=
vance(&newbuf, hlen))
         {
-            struct openvpn_tcphdr *tc =3D=
 (struct openvpn_tcphdr *)BPTR(&newbuf);
+            const struct openvpn_=
tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&newbuf);
             if (tc-=
>flags & OPENVPN_TCPH_SYN_MASK)
             {
                 mss_fixup_d=
owork(&newbuf, maxmss);
@@ -122,7 +122,7 @@
     newbuf =3D *buf;
     if (=
buf_advance(&newbuf, 40) && BLENZ(&newbuf) >=3D sizeof(struct openvpn_tcphd=
r))
     {
-        struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)=
BPTR(&newbuf);
+        const struct openvpn_tcphdr *tc =3D (struct openvpn=
_tcphdr *)BPTR(&newbuf);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
  =
       {
             mss_fixup_dowork(&newbuf, maxmss - 20);
diff --git a/=
src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec
index f000283=2E=2E5d88f8a 1006=
44
--- a/src/openvpn/mtcp=2Ec
+++ b/src/openvpn/mtcp=2Ec
@@ -130,7 +130,7 @=
@
 void
 multi_tcp_dereference_instance(struct multi_io *multi_io, struct m=
ulti_instance *mi)
 {
-    struct link_socket *sock =3D mi->context=2Ec2=2E=
link_sockets[0];
+    const struct link_socket *sock =3D mi->context=2Ec2=
=2Elink_sockets[0];
     if (sock && mi->socket_set_called)
     {
        =
 event_del(multi_io->es, socket_event_handle(sock));
diff --git a/src/openv=
pn/mudp=2Ec b/src/openvpn/mudp=2Ec
index 9acf297=2E=2E49dc4eb 100644
--- a/=
src/openvpn/mudp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -88,7 +88,7 @@
     verd=
ict =3D tls_pre_decrypt_lite(tas, state, &m->top=2Ec2=2Efrom, &m->top=2Ec2=
=2Ebuf);
 
     hmac_ctx_t *hmac =3D m->top=2Ec2=2Esession_id_hmac;
-    st=
ruct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
+    const stru=
ct openvpn_sockaddr *from =3D &m->top=2Ec2=2Efrom=2Edest;
     int handwind=
ow =3D m->top=2Eoptions=2Ehandshake_window;
 
     if (verdict =3D=3D VERDI=
CT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_V2)
@@ -283,7 +283,=
7 @@
         struct hash_element *he;
         const uint64_t hv =3D hash_=
value(hash, &real);
         struct hash_bucket *bucket =3D hash_bucket(has=
h, hv);
-        uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
+        const =
uint8_t *ptr =3D BPTR(&m->top=2Ec2=2Ebuf);
         uint8_t op =3D ptr[0] >=
> P_OPCODE_SHIFT;
         bool v2 =3D (op =3D=3D P_DATA_V2) && (m->top=2Ec=
2=2Ebuf=2Elen >=3D (1 + 3));
         bool peer_id_disabled =3D false;
diff=
 --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index fe2badb=2E=2E5=
b4bc4e 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -8=
6,7 +86,7 @@
     struct gc_arena gc =3D gc_new();
     struct env_set *es;=

     bool ret =3D true;
-    struct plugin_list *plugins;
+    const struc=
t plugin_list *plugins;
 
     /* get environmental variable source */
    =
 if (mi && mi->context=2Ec2=2Ees)
@@ -1794,7 +1794,7 @@
      * Push the fi=
rst cipher from --data-ciphers to the client that
      * the client announ=
ces to be supporting=2E
      */
-    char *push_cipher =3D
+    const char=
 *push_cipher =3D
         ncp_get_best_cipher(o->ncp_ciphers, peer_info, t=
ls_multi->remote_ciphername, &o->gc);
     if (push_cipher)
     {
@@ -1925=
,7 +1925,7 @@
 static enum client_connect_return
 ccs_test_deferred_ret_fil=
e(struct multi_instance *mi)
 {
-    struct client_connect_defer_state *ccs=
 =3D &(mi->client_connect_defer_state);
+    const struct client_connect_de=
fer_state *ccs =3D &(mi->client_connect_defer_state);
     FILE *fp =3D fop=
en(ccs->deferred_ret_file, "r");
     if (!fp)
     {
@@ -2166,7 +2166,7 @@=

 {
     ASSERT(mi);
     ASSERT(option_types_found);
-    struct client_co=
nnect_defer_state *ccs =3D &(mi->client_connect_defer_state);
+    const st=
ruct client_connect_defer_state *ccs =3D &(mi->client_connect_defer_state);=

     enum client_connect_return ret =3D CC_RET_SKIPPED;
 
     ret =3D ccs=
_test_deferred_ret_file(mi);
@@ -2568,7 +2568,7 @@
 override_locked_usernam=
e(struct multi_instance *mi)
 {
     struct tls_multi *multi =3D mi->contex=
t=2Ec2=2Etls_multi;
-    struct options *options =3D &mi->context=2Eoptions=
;
+    const struct options *options =3D &mi->context=2Eoptions;
     struc=
t tls_session *session =3D &multi->session[TM_ACTIVE];
 
     if (!multi->l=
ocked_username)
@@ -2987,7 +2987,7 @@
     {
 #if defined(ENABLE_ASYNC_PUSH=
)
         bool was_unauthenticated =3D true;
-        struct key_state *ks=
 =3D NULL;
+        const struct key_state *ks =3D NULL;
         if (mi->c=
ontext=2Ec2=2Etls_multi)
         {
             ks =3D &mi->context=2Ec2=
=2Etls_multi->session[TM_ACTIVE]=2Ekey[KS_PRIMARY];
@@ -3104,7 +3104,7 @@
 =
        struct multi_instance *ex_mi =3D (struct multi_instance *)he->value=
;
 
         struct tls_multi *m1 =3D mi->context=2Ec2=2Etls_multi;
-      =
  struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
+        const =
struct tls_multi *m2 =3D ex_mi->context=2Ec2=2Etls_multi;
 
         /* do =
not float if target address is taken by client with another cert */
       =
  if (!cert_hash_compare(m1->locked_cert_hash_set, m2->locked_cert_hash_set=
))
@@ -3877,7 +3877,7 @@
 static int
 management_callback_n_clients(void *a=
rg)
 {
-    struct multi_context *m =3D (struct multi_context *)arg;
+    c=
onst struct multi_context *m =3D (struct multi_context *)arg;
     return m=
->n_clients;
 }
 
@@ -4388,7 +4388,7 @@
 bool
 multi_check_push_ifconfig_ex=
tra_route(struct multi_instance *mi, in_addr_t dest)
 {
-    struct options=
 *o =3D &mi->context=2Eoptions;
+    const struct options *o =3D &mi->conte=
xt=2Eoptions;
     in_addr_t local_addr, local_netmask;
 
     if (!o->ifco=
nfig_local || !o->ifconfig_remote_netmask)
@@ -4410,7 +4410,7 @@
 multi_che=
ck_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,
              =
                              struct in6_addr *dest)
 {
-    struct options=
 *o =3D &mi->context=2Eoptions;
+    const struct options *o =3D &mi->conte=
xt=2Eoptions;
 
     if (!o->ifconfig_ipv6_local || !o->ifconfig_ipv6_netbi=
ts)
     {
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/netw=
orking_sitnl=2Ec
index b3f8e2b=2E=2Ee6e72d0 100644
--- a/src/openvpn/networ=
king_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -462,7 +462,7 @@
 =
    struct rtattr *rta =3D RTM_RTA(r);
     size_t len =3D n->nlmsg_len - N=
LMSG_LENGTH(sizeof(*r));
     unsigned int table, ifindex =3D 0;
-    void =
*gw =3D NULL;
+    const void *gw =3D NULL;
 
     /* filter-out non-zero d=
st prefixes */
     if (res->default_only && r->rtm_dst_len !=3D 0)
@@ -117=
9,7 +1179,7 @@
 net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *d=
st, int prefixlen, const in_addr_t *gw,
                  const char *iface=
, uint32_t table, int metric)
 {
-    in_addr_t *dst_ptr =3D NULL, *gw_ptr =
=3D NULL;
+    const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;
     in=
_addr_t dst_be =3D 0, gw_be =3D 0;
     char dst_str[INET_ADDRSTRLEN];
    =
 char gw_str[INET_ADDRSTRLEN];
@@ -1326,7 +1326,7 @@
 #if defined(ENABLE_DC=
O)
     if (arg && (strcmp(type, OVPN_FAMILY_NAME) =3D=3D 0))
     {
-     =
   dco_context_t *dco =3D arg;
+        const dco_context_t *dco =3D arg;
 =
        struct rtattr *data =3D SITNL_NEST(&req=2En, sizeof(req), IFLA_INFO=
_DATA);
 
         /* the netlink format is uint8_t for this and using some=
thing
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index =
2b22b1d=2E=2E5451f86 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn=
/options=2Ec
@@ -1893,7 +1893,7 @@
         SHOW_INT(verify_hash_algo);
   =
      SHOW_INT(verify_hash_depth);
         struct gc_arena gc =3D gc_new()=
;
-        struct verify_hash_list *hl =3D o->verify_hash;
+        const s=
truct verify_hash_list *hl =3D o->verify_hash;
         int digest_len =3D
=
             (o->verify_hash_algo =3D=3D MD_SHA1) ? SHA_DIGEST_LENGTH : SHA=
256_DIGEST_LENGTH;
         while (hl)
@@ -2349,7 +2349,7 @@
 
     for (in=
t i =3D 0; i < ce->local_list->len; i++)
     {
-        struct local_entry=
 *le =3D ce->local_list->array[i];
+        const struct local_entry *le =
=3D ce->local_list->array[i];
 
         if (proto_is_net(le->proto) && str=
ing_defined_equal(le->local, ce->remote)
             && string_defined_equ=
al(le->port, ce->remote_port))
@@ -4014,7 +4014,7 @@
     {
         char *=
fullpath =3D
             string_alloc(file, NULL); /* POSIX dirname() impl=
ementation may modify its arguments */
-        char *dirpath =3D dirname(f=
ullpath);
+        const char *dirpath =3D dirname(fullpath);
 
         if=
 (platform_access(dirpath, mode | X_OK) !=3D 0)
         {
@@ -4245,7 +4245=
,7 @@
     ASSERT(options->connection_list);
     for (int i =3D 0; i < opt=
ions->connection_list->len; ++i)
     {
-        struct connection_entry *c=
e =3D options->connection_list->array[i];
+        const struct connection_=
entry *ce =3D options->connection_list->array[i];
 
         errs |=3D chec=
k_file_access_inline(ce->tls_auth_file_inline, CHKACC_FILE | CHKACC_PRIVATE=
,
                                          ce->tls_auth_file, R_OK, "--tls=
-auth");
@@ -9122,7 +9122,7 @@
 #ifdef ENABLE_PKCS11
     else if (streq(p[=
0], "show-pkcs11-ids") && !p[3])
     {
-        char *provider =3D p[1];
+=
        const char *provider =3D p[1];
         bool cert_private =3D (p[2]=
 =3D=3D NULL ? false : (atoi_warn(p[2], msglevel) !=3D 0));
 
 #ifdef DEFAU=
LT_PKCS11_MODULE
diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/o=
ptions_parse=2Ec
index a8c4aee=2E=2E88ab4d2 100644
--- a/src/openvpn/option=
s_parse=2Ec
+++ b/src/openvpn/options_parse=2Ec
@@ -268,7 +268,7 @@
     wh=
ile (in_src_get(is, line, sizeof(line)))
     {
         (*num_lines)++;
- =
       char *line_ptr =3D line;
+        const char *line_ptr =3D line;
   =
      /* Remove leading spaces */
         while (isspace(*line_ptr))
     =
    {
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=
=2Ec
index d72ea25c=2E=2E779c38e 100644
--- a/src/openvpn/options_util=2Ec
=
+++ b/src/openvpn/options_util=2Ec
@@ -273,7 +273,7 @@
         return true=
;
     }
 
-    struct pull_filter *f;
+    const struct pull_filter *f;
 
=
     for (f =3D o->pull_filter_list->head; f; f =3D f->next)
     {
diff --=
git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index ff74e7c=2E=2E80dec6=
c 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -63,7 +63=
,7 @@
 
     for (i =3D 0; i < pool->size; ++i)
     {
-        struct ifco=
nfig_pool_entry *ipe =3D &pool->list[i];
+        const struct ifconfig_poo=
l_entry *ipe =3D &pool->list[i];
         if (!ipe->in_use)
         {
    =
         /*
diff --git a/src/openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec
inde=
x 9f3ec93=2E=2E4de7615 100644
--- a/src/openvpn/proxy=2Ec
+++ b/src/openvpn=
/proxy=2Ec
@@ -703,7 +703,7 @@
 #if PROXY_DIGEST_AUTH
         else if (p->=
auth_method =3D=3D HTTP_AUTH_DIGEST && !processed)
         {
-            =
char *pa =3D p->proxy_authenticate;
+            const char *pa =3D p->prox=
y_authenticate;
             const int method =3D p->auth_method;
         =
    ASSERT(pa);
 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
=
index 13c8936=2E=2E79f20e1 100644
--- a/src/openvpn/push=2Ec
+++ b/src/open=
vpn/push=2Ec
@@ -271,8 +271,8 @@
     }
 #ifdef ENABLE_MANAGEMENT
     stru=
ct tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
-    st=
ruct man_def_auth_context *mda =3D session->opt->mda_context;
-    struct e=
nv_set *es =3D session->opt->es;
+    const struct man_def_auth_context *md=
a =3D session->opt->mda_context;
+    const struct env_set *es =3D session-=
>opt->es;
     unsigned int mda_key_id =3D get_primary_key(c->c2=2Etls_mult=
i)->mda_key_id;
 
     management_notify_client_cr_response(mda_key_id, mda=
, es, m);
@@ -918,7 +918,7 @@
 push_options(struct options *o, char **p, ms=
glvl_t msglevel, struct gc_arena *gc)
 {
     const char **argv =3D make_ex=
tended_arg_array(p, false, gc);
-    char *opt =3D print_argv(argv, gc, 0);=

+    const char *opt =3D print_argv(argv, gc, 0);
     push_option(o, opt,=
 msglevel);
 }
 
@@ -1202,7 +1202,7 @@
                     /* parse route-=
ipv6 arguments */
                     if (get_ipv6_addr(p[1], &network, &n=
etbits, D_ROUTE_DEBUG))
                     {
-                        str=
uct iroute_ipv6 *ir;
+                        const struct iroute_ipv6 *ir;=

 
                         /* does this route-ipv6 match an iroute-ipv6? *=
/
                         for (ir =3D o->iroutes_ipv6; ir !=3D NULL; ir =
=3D ir->next)
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
in=
dex 6dbe3ec=2E=2E03a2526 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openv=
pn/route=2Ec
@@ -667,7 +667,7 @@
 
     /* parse the routes from opt to rl =
*/
     {
-        struct route_option *ro;
+        const struct route_opt=
ion *ro;
         for (ro =3D opt->routes; ro; ro =3D ro->next)
         {
=
             struct addrinfo *netlist =3D NULL;
@@ -679,7 +679,7 @@
       =
      }
             else
             {
-                struct addrinfo *=
curele;
+                const struct addrinfo *curele;
                 fo=
r (curele =3D netlist; curele; curele =3D curele->ai_next)
                =
 {
                     struct route_ipv4 *new;
@@ -799,7 +799,7 @@
     ne=
ed_remote_ipv6_route =3D false;
 
     {
-        struct route_ipv6_option =
*ro6;
+        const struct route_ipv6_option *ro6;
         for (ro6 =3D o=
pt6->routes_ipv6; ro6; ro6 =3D ro6->next)
         {
             struct ro=
ute_ipv6 *r6;
@@ -1187,7 +1187,7 @@
 {
     if (rl6 && (rl6->iflags & RL_RO=
UTES_ADDED))
     {
-        struct route_ipv6 *r6;
+        const struct r=
oute_ipv6 *r6;
         for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
=
         {
             delete_route_ipv6(r6, tt, es, ctx);
@@ -1226,7 +122=
6,7 @@
 void
 print_route_options(const struct route_option_list *rol, msgl=
vl_t msglevel)
 {
-    struct route_option *ro;
+    const struct route_opt=
ion *ro;
     if (rol->flags & RG_ENABLE)
     {
         msg(msglevel, "  =
[redirect_default_gateway local=3D%d]", (rol->flags & RG_LOCAL) !=3D 0);
@@=
 -1335,7 +1335,7 @@
 setenv_routes(struct env_set *es, const struct route_l=
ist *rl)
 {
     int i =3D 1;
-    struct route_ipv4 *r;
+    const struct =
route_ipv4 *r;
     for (r =3D rl->routes; r; r =3D r->next)
     {
       =
  setenv_route(es, r, i++);
@@ -1372,7 +1372,7 @@
 setenv_routes_ipv6(struc=
t env_set *es, const struct route_ipv6_list *rl6)
 {
     int i =3D 1;
-   =
 struct route_ipv6 *r6;
+    const struct route_ipv6 *r6;
     for (r6 =3D =
rl6->routes_ipv6; r6; r6 =3D r6->next)
     {
         setenv_route_ipv6(es=
, r6, i++);
@@ -2423,7 +2423,7 @@
          */
         if (rl && tt->did_i=
fconfig_setup)
         {
-            struct route_ipv4 *r;
+            c=
onst struct route_ipv4 *r;
             for (r =3D rl->routes, len =3D 0; r=
; r =3D r->next, ++len)
             {
                 test_route_helper(&=
ret, &count, &good, &ambig, adapters, r->gateway);
@@ -3110,7 +3110,8 @@
  =
   /* scan adapter list */
     if (rgi->flags & RGI_ADDR_DEFINED)
     {
-=
        struct ifreq *ifr, *ifend;
+        const struct ifreq *ifr;
+     =
   const struct ifreq *ifend;
         in_addr_t addr, netmask;
         st=
ruct ifreq ifreq;
         struct ifconf ifc;
diff --git a/src/openvpn/sock=
et=2Ec b/src/openvpn/socket=2Ec
index 47edbdb=2E=2E50126bf 100644
--- a/src=
/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -393,7 +393,7 @@
 
    =
         for (int j =3D 0; j < ce->local_list->len; j++)
             {
-  =
              struct local_entry *le =3D ce->local_list->array[j];
+       =
         const struct local_entry *le =3D ce->local_list->array[j];
 
     =
            if (!le->local)
                 {
@@ -898,12 +898,10 @@
      =
* What is the correct way to deal with it?
      */
 
-    struct addrinfo =
*cur;
-
     ASSERT(local);
 
-
     /* find the first addrinfo with correc=
t ai_family */
+    const struct addrinfo *cur;
     for (cur =3D local; cu=
r; cur =3D cur->ai_next)
     {
         if (cur->ai_family =3D=3D ai_famil=
y)
@@ -1490,7 +1488,7 @@
         /* Socket is always bound on the first ma=
tching address,
          * For bound sockets with no remote addr this is t=
he element of
          * the list */
-        struct addrinfo *cur;
+     =
   const struct addrinfo *cur;
         for (cur =3D sock->info=2Elsa->bind=
_local; cur; cur =3D cur->ai_next)
         {
             if (!ai_family |=
| ai_family =3D=3D cur->ai_family)
@@ -1621,7 +1619,7 @@
 create_socket_dco=
_win(struct context *c, struct link_socket *sock, struct signal_info *sig_i=
nfo)
 {
     /* in P2P mode we must have remote resolved at this point */
-=
    struct addrinfo *remoteaddr =3D sock->info=2Elsa->current_remote;
+    =
const struct addrinfo *remoteaddr =3D sock->info=2Elsa->current_remote;
   =
  if ((c->options=2Emode =3D=3D MODE_POINT_TO_POINT) && (!remoteaddr))
    =
 {
         return;
@@ -1910,7 +1908,7 @@
                               co=
nst struct link_socket_actual *from_addr)
 {
     struct gc_arena gc =3D gc=
_new();
-    struct addrinfo *ai;
+    const struct addrinfo *ai;
 
     sw=
itch (from_addr->dest=2Eaddr=2Esa=2Esa_family)
     {
diff --git a/src/open=
vpn/socket=2Eh b/src/openvpn/socket=2Eh
index 1a532e1=2E=2E89465bc 100644
-=
-- a/src/openvpn/socket=2Eh
+++ b/src/openvpn/socket=2Eh
@@ -761,7 +761,7 @=
@
 {
     if (sock && ipbuf)
     {
-        struct openvpn_iphdr *iph =3D =
(struct openvpn_iphdr *)BPTR(ipbuf);
+        const struct openvpn_iphdr *i=
ph =3D (struct openvpn_iphdr *)BPTR(ipbuf);
         sock->ptos =3D iph->to=
s;
         sock->ptos_defined =3D true;
     }
diff --git a/src/openvpn/ss=
l=2Ec b/src/openvpn/ssl=2Ec
index 60df7ce=2E=2E7a7b3b4 100644
--- a/src/ope=
nvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1478,7 +1478,7 @@
 static bool
 =
generate_key_expansion(struct tls_multi *multi, struct key_state *ks, struc=
t tls_session *session)
 {
-    struct key_ctx_bi *key =3D &ks->crypto_opti=
ons=2Ekey_ctx_bi;
+    const struct key_ctx_bi *key =3D &ks->crypto_options=
=2Ekey_ctx_bi;
     bool ret =3D false;
     struct key2 key2;
 
@@ -1740,7=
 +1740,7 @@
 static void
 flush_payload_buffer(struct key_state *ks)
 {
-  =
  struct buffer *b;
+    const struct buffer *b;
 
     while ((b =3D buffe=
r_list_peek(ks->paybuf)))
     {
@@ -2719,7 +2719,7 @@
     /* Outgoing Cip=
hertext to reliable buffer */
     if (ks->state >=3D S_START)
     {
-    =
    struct buffer *buf =3D reliable_get_buf_output_sequenced(ks->send_relia=
ble);
+        const struct buffer *buf =3D reliable_get_buf_output_sequenc=
ed(ks->send_reliable);
         if (buf)
         {
             if (!write=
_outgoing_tls_ciphertext(session, continue_tls_process))
@@ -2788,7 +2788,7=
 @@
     {
         int opcode;
 
-        struct buffer *buf =3D reliable_=
send(ks->send_reliable, &opcode);
+        const struct buffer *buf =3D rel=
iable_send(ks->send_reliable, &opcode);
         ASSERT(buf);
         stru=
ct buffer b =3D *buf;
         INCR_SENT;
@@ -3151,7 +3151,7 @@
 static voi=
d
 check_session_buf_not_used(struct buffer *to_link, struct tls_session *s=
ession)
 {
-    uint8_t *dataptr =3D to_link->data;
+    const uint8_t *dat=
aptr =3D to_link->data;
     if (!dataptr)
     {
         return;
@@ -3173=
,7 +3173,7 @@
 
     for (int i =3D 0; i < KS_SIZE; i++)
     {
-        st=
ruct key_state *ks =3D &session->key[i];
+        const struct key_state *k=
s =3D &session->key[i];
         if (ks->state =3D=3D S_UNDEF)
         {
 =
            continue;
@@ -3244,7 +3244,7 @@
     {
         struct tls_sess=
ion *session =3D &multi->session[i];
         struct key_state *ks =3D &ses=
sion->key[KS_PRIMARY];
-        struct key_state *ks_lame =3D &session->key=
[KS_LAME_DUCK];
+        const struct key_state *ks_lame =3D &session->key[=
KS_LAME_DUCK];
 
         /* set initial remote address=2E This triggers co=
nnecting with that
          * session=2E So we only do that if the TM_ACTI=
VE session is not
@@ -3445,7 +3445,7 @@
 
     for (int i =3D 0; i < KEY_SC=
AN_SIZE; ++i)
     {
-        struct key_state *ks =3D get_key_scan(multi, =
i);
+        const struct key_state *ks =3D get_key_scan(multi, i);
       =
  if (ks->key_id !=3D key_id)
         {
             continue;
@@ -3996,7 =
+3996,7 @@
 void
 tls_prepend_opcode_v1(const struct tls_multi *multi, stru=
ct buffer *buf)
 {
-    struct key_state *ks =3D multi->save_ks;
+    const=
 struct key_state *ks =3D multi->save_ks;
 
     msg(D_TLS_DEBUG, __func__)=
;
 
@@ -4010,7 +4010,7 @@
 void
 tls_prepend_opcode_v2(const struct tls_mul=
ti *multi, struct buffer *buf)
 {
-    struct key_state *ks =3D multi->save=
_ks;
+    const struct key_state *ks =3D multi->save_ks;
     uint32_t peer=
;
 
     msg(D_TLS_DEBUG, __func__);
diff --git a/src/openvpn/ssl_mbedtls=
=2Ec b/src/openvpn/ssl_mbedtls=2Ec
index 07caf08=2E=2Ed5c9e5c 100644
--- a/=
src/openvpn/ssl_mbedtls=2Ec
+++ b/src/openvpn/ssl_mbedtls=2Ec
@@ -301,7 +30=
1,7 @@
 void
 tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char=
 *ciphers)
 {
-    char *tmp_ciphers, *tmp_ciphers_orig, *token;
+    char =
*tmp_ciphers, *tmp_ciphers_orig;
 
     if (NULL =3D=3D ciphers)
     {
@@ =
-745,7 +745,7 @@
 static inline size_t
 external_key_len(void *vctx)
 {
-  =
  struct external_context *const ctx =3D vctx;
+    const struct external_c=
ontext *const ctx =3D vctx;
 
     return ctx->signature_length;
 }
diff --=
git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 162f68f=
=2E=2E063fa5d 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl=
_verify=2Ec
@@ -409,7 +409,7 @@
                     const char *subject, c=
onst struct x509_track *x509_track)
 {
     char envname[64];
-    char *se=
rial =3D NULL;
+    const char *serial =3D NULL;
     struct gc_arena gc =
=3D gc_new();
 
     /* Save X509 fields in environment */
@@ -699,7 +699,7=
 @@
                 goto cleanup;
         }
 
-        struct verify_hash=
_list *current_hash =3D opt->verify_hash;
+        const struct verify_hash=
_list *current_hash =3D opt->verify_hash;
 
         while (current_hash)
 =
        {
@@ -1532,7 +1532,7 @@
 verify_user_pass_management(struct tls_ses=
sion *session, const struct user_pass *up)
 {
     int retval =3D KMDA_ERRO=
R;
-    struct key_state *ks =3D &session->key[KS_PRIMARY]; /* primary key =
*/
+    const struct key_state *ks =3D &session->key[KS_PRIMARY]; /* primar=
y key */
 
     /* set username/password in private env space */
     seten=
v_str(session->opt->es, "password", up->password);
diff --git a/src/openvpn=
/tun=2Ec b/src/openvpn/tun=2Ec
index e7193d8=2E=2Ebc262cd 100644
--- a/src/=
openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -871,7 +871,7 @@
          */
=
         if (strict_warn)
         {
-            struct addrinfo *curele;
=
+            const struct addrinfo *curele;
             ifconfig_sanity_ch=
eck(tun_p2p, tt->remote_netmask);
 
             /*
@@ -1735,7 +1735,7 @@
 =
    {
         u_int32_t type;
         struct iovec iv[2];
-        struct=
 ip *iph =3D (struct ip *)buf;
+        const struct ip *iph =3D (struct ip=
 *)buf;
 
         if (iph->ip_v =3D=3D 6)
         {
@@ -3423,7 +3423,7 @@=

         SP_DEVINFO_DATA device_info_data;
         BOOL res;
         HKE=
Y dev_key;
-        char net_cfg_instance_id_string[] =3D "NetCfgInstanceId=
";
+        const char net_cfg_instance_id_string[] =3D "NetCfgInstanceId";=

         BYTE net_cfg_instance_id[256];
         char device_instance_id[2=
56];
         DWORD len;
@@ -3551,7 +3551,7 @@
         HKEY unit_key;
    =
     char component_id_string[] =3D "ComponentId";
         char component_=
id[256];
-        char net_cfg_instance_id_string[] =3D "NetCfgInstanceId";=

+        const char net_cfg_instance_id_string[] =3D "NetCfgInstanceId";
 =
        BYTE net_cfg_instance_id[256];
         DWORD data_type;
 
diff --g=
it a/src/openvpn/win32=2Ec b/src/openvpn/win32=2Ec
index ade7ec0=2E=2E81437=
c1 100644
--- a/src/openvpn/win32=2Ec
+++ b/src/openvpn/win32=2Ec
@@ -889,7=
 +889,7 @@
 
     if (es)
     {
-        struct env_item *e;
+        cons=
t struct env_item *e;
         char *ret;
         char *p;
         size_t=
 nchars =3D 1;
diff --git a/src/openvpnmsica/msica_arg=2Ec b/src/openvpnmsi=
ca/msica_arg=2Ec
index a334710=2E=2Ed763d93 100644
--- a/src/openvpnmsica/m=
sica_arg=2Ec
+++ b/src/openvpnmsica/msica_arg=2Ec
@@ -92,7 +92,7 @@
 {
    =
 /* Count required space=2E */
     size_t size =3D 2 /*x + zero-terminator=
*/;
-    for (struct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->next=
)
+    for (const struct msica_arg *p =3D seq->head; p !=3D NULL; p =3D p->=
next)
     {
         size +=3D wcslen(p->val) + 1 /*space delimiter|zero-t=
erminator*/;
     }
@@ -119,7 +119,7 @@
 
     /* Join=2E */
     LPWSTR s =
=3D str + 1 /*x*/;
-    for (struct msica_arg *p =3D seq->head; p !=3D NULL=
; p =3D p->next)
+    for (const struct msica_arg *p =3D seq->head; p !=3D =
NULL; p =3D p->next)
     {
         /* Convert zero-terminator into space =
delimiter=2E */
         s[0] =3D L' ';
diff --git a/src/openvpnmsica/openv=
pnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec
index 95e457c=2E=2Ea861e8a =
100644
--- a/src/openvpnmsica/openvpnmsica=2Ec
+++ b/src/openvpnmsica/openv=
pnmsica=2Ec
@@ -196,7 +196,7 @@
 
     /* Count adapters=2E */
     size_t =
adapter_count =3D 0;
-    for (struct tap_adapter_node *pAdapter =3D pAdapt=
erList; pAdapter; pAdapter =3D pAdapter->pNext)
+    for (const struct tap_=
adapter_node *pAdapter =3D pAdapterList; pAdapter; pAdapter =3D pAdapter->p=
Next)
     {
         adapter_count++;
     }
diff --git a/src/openvpnserv/=
interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 32c1b9c=2E=2Ea9e966=
5 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/intera=
ctive=2Ec
@@ -2685,7 +2685,7 @@
     unsigned n =3D 0;
     for (size_t i =
=3D 0; i < _countof(data); ++i)
     {
-        nrpt_exclude_data_t *d =3D =
&data[i];
+        const nrpt_exclude_data_t *d =3D &data[i];
         if (=
d->domains_size =3D=3D 0)
         {
             break;
diff --git a/src/p=
lugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec
index 3b7b=
cc2=2E=2E948b6af 100644
--- a/src/plugins/auth-pam/auth-pam=2Ec
+++ b/src/p=
lugins/auth-pam/auth-pam=2Ec
@@ -526,7 +526,7 @@
 openvpn_plugin_func_v1(op=
envpn_plugin_handle_t handle, const int type, const char *argv[],
         =
               const char *envp[])
 {
-    struct auth_pam_context *context=
 =3D (struct auth_pam_context *)handle;
+    const struct auth_pam_context =
*context =3D (struct auth_pam_context *)handle;
 
     if (type =3D=3D OPEN=
VPN_PLUGIN_AUTH_USER_PASS_VERIFY && context->foreground_fd >=3D 0)
     {
d=
iff --git a/src/tapctl/main=2Ec b/src/tapctl/main=2Ec
index 6a4a240=2E=2E66=
97d14 100644
--- a/src/tapctl/main=2Ec
+++ b/src/tapctl/main=2Ec
@@ -317,7 =
+317,7 @@
             return NULL;
         }
 
-        struct tap_adapte=
r_node *conflict =3D find_adapter_by_name(requested_name, adapter_list);
+ =
       const struct tap_adapter_node *conflict =3D find_adapter_by_name(req=
uested_name, adapter_list);
         if (conflict)
         {
             =
LPOLESTR adapter_id =3D NULL;
diff --git a/tests/unit_tests/openvpn/test_bu=
ffer=2Ec b/tests/unit_tests/openvpn/test_buffer=2Ec
index 326de40=2E=2Ece38=
bbe 100644
--- a/tests/unit_tests/openvpn/test_buffer=2Ec
+++ b/tests/unit_=
tests/openvpn/test_buffer=2Ec
@@ -88,7 +88,7 @@
 
     int maxoutput =3D 0;=

     unsigned int blocksize =3D 5;
-    char *separator =3D " ";
+    cons=
t char *separator =3D " ";
     output =3D format_hex_ex(input, input_size,=
 maxoutput, blocksize, separator, &gc);
     assert_string_equal(output, "0=
100ff10ff 00f00f090a");
 
@@ -174,7 +174,7 @@
     /* With a max length of =
2, no aggregation should take place */
     buffer_list_aggregate_separator=
(ctx->one_two_three, 2, testsep);
     assert_int_equal(ctx->one_two_three-=
>size, 3);
-    struct buffer *buf =3D buffer_list_peek(ctx->one_two_three)=
;
+    const struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
 =
    assert_buf_equals_str(buf, teststr1);
 }
 
@@ -189,7 +189,7 @@
      */=

     buffer_list_aggregate_separator(ctx->one_two_three, strlen(expected) =
+ 1, testsep);
     assert_int_equal(ctx->one_two_three->size, 2);
-    str=
uct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
+    const struct=
 buffer *buf =3D buffer_list_peek(ctx->one_two_three);
     assert_buf_equa=
ls_str(buf, expected);
 }
 
@@ -201,7 +201,7 @@
     /* Aggregate all */
  =
   buffer_list_aggregate_separator(ctx->one_two_three, 1 << 16, testsep);
 =
    assert_int_equal(ctx->one_two_three->size, 1);
-    struct buffer *buf =
=3D buffer_list_peek(ctx->one_two_three);
+    const struct buffer *buf =3D=
 buffer_list_peek(ctx->one_two_three);
     assert_buf_equals_str(buf, test=
str1 testsep teststr2 testsep teststr3 testsep);
 }
 
@@ -213,7 +213,7 @@
 =
    /* Aggregate all */
     buffer_list_aggregate_separator(ctx->one_two_t=
hree, 1 << 16, testnosep);
     assert_int_equal(ctx->one_two_three->size, =
1);
-    struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
+    =
const struct buffer *buf =3D buffer_list_peek(ctx->one_two_three);
     ass=
ert_buf_equals_str(buf, teststr1 teststr2 teststr3);
 }
 
@@ -226,7 +226,7 =
@@
     /* Aggregate all */
     buffer_list_aggregate_separator(bl_zerolen=
, 1 << 16, testnosep);
     assert_int_equal(bl_zerolen->size, 1);
-    str=
uct buffer *buf =3D buffer_list_peek(bl_zerolen);
+    const struct buffer =
*buf =3D buffer_list_peek(bl_zerolen);
     assert_buf_equals_str(buf, "");=

 }
 
@@ -239,7 +239,7 @@
     /* Aggregate all */
     buffer_list_aggrega=
te_separator(bl_emptybuffers, 1 << 16, testnosep);
     assert_int_equal(bl=
_emptybuffers->size, 1);
-    struct buffer *buf =3D buffer_list_peek(bl_em=
ptybuffers);
+    const struct buffer *buf =3D buffer_list_peek(bl_emptybuf=
fers);
     assert_int_equal(BLEN(buf), 0);
 }
 
diff --git a/tests/unit_te=
sts/openvpn/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec
inde=
x cb4eaa2=2E=2E8393e1c 100644
--- a/tests/unit_tests/openvpn/test_crypto=2E=
c
+++ b/tests/unit_tests/openvpn/test_crypto=2Ec
@@ -479,9 +479,9 @@
 crypt=
o_test_hkdf_expand_testa1(void **state)
 {
     /* RFC 5889 A=2E1 Test Case=
 1 */
-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, =
0xdf, 0x0d, 0xdc, 0x3f,
-                        0x0d, 0xc4, 0x7b, 0xba, 0x=
63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
-                        0x9c, 0x31=
, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
+    const uint8_t prk[=
32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,=

+                              0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0=
xc7, 0x3b, 0xb5, 0x0f,
+                              0x9c, 0x31, 0x22, 0xe=
c, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
 
     uint8_t info[10] =3D { 0xf0=
, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };
 
@@ -500,9 +500,=
9 @@
 crypto_test_hkdf_expand_testa2(void **state)
 {
     /* RFC 5889 A=2E=
2 Test Case 2 */
-    uint8_t prk[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0=
x53, 0x36, 0x1a, 0x06, 0x10, 0x4c,
-                        0x9c, 0xeb, 0x3=
5, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x46,
-                       =
 0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };
+    const u=
int8_t prk[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, =
0x10, 0x4c,
+                              0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0x=
ef, 0x76, 0x00, 0x14, 0x90, 0x46,
+                              0x71, 0x01=
, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };
 
     uint8_t info[80]=
 =3D { 0xb0, 0xb1, 0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0x=
bb,
                          0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc=
3, 0xc4, 0xc5, 0xc6, 0xc7,
@@ -531,11 +531,11 @@
 crypto_test_hkdf_expand_t=
esta3(void **state)
 {
     /* RFC 5889 A=2E3 Test Case 3 */
-    uint8_t p=
rk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0x=
a9,
-                        0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67=
, 0x76, 0xaf, 0xdb,
-                        0x63, 0x77, 0xac, 0x43, 0x4c, =
0x1c, 0x29, 0x3c, 0xcb, 0x04 };
+    const uint8_t prk[32] =3D { 0x19, 0xef=
, 0x24, 0xa3, 0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0xa9,
+                  =
            0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x59, 0x67, 0x76, 0xaf, 0xd=
b,
+                              0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x29,=
 0x3c, 0xcb, 0x04 };
 
-    uint8_t info[] =3D { 0 };
+    const uint8_t in=
fo[] =3D { 0 };
 
     int L =3D 42;
     uint8_t okm[42] =3D { 0x8d, 0xa4,=
 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x80,
@@ -555,9 +555,9 @@
=
     /* tests the HDKF with a label/okm that OpenVPN itself uses in OpenSSL=
 3
      * HDKF unit test*/
 
-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, =
0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,
-                        0x=
0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
-          =
              0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };=

+    const uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32,=
 0xdf, 0x0d, 0xdc, 0x3f,
+                              0x0d, 0xc4, 0x7b, 0=
xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,
+                           =
   0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3, 0xe5 };
 
     uin=
t8_t info[18] =3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,
 =
                         0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74, 0x=
00 };
@@ -677,7 +677,7 @@
 static int
 crypto_test_epoch_setup(void **state=
)
 {
-    uint16_t *num_future_keys =3D (uint16_t *)*state;
+    const uint=
16_t *num_future_keys =3D (uint16_t *)*state;
     struct epoch_test_state =
*data =3D calloc(1, sizeof(struct epoch_test_state));
 
     data->gc =3D g=
c_new();
diff --git a/tests/unit_tests/openvpn/test_cryptoapi=2Ec b/tests/u=
nit_tests/openvpn/test_cryptoapi=2Ec
index 508afc9=2E=2E37bbe92 100644
--- =
a/tests/unit_tests/openvpn/test_cryptoapi=2Ec
+++ b/tests/unit_tests/openvp=
n/test_cryptoapi=2Ec
@@ -233,7 +233,7 @@
         const CERT_CONTEXT *ctx =
=3D NULL;
         while ((ctx =3D CertEnumCertificatesInStore(user_store, =
ctx)))
         {
-            char *friendly_name =3D get_cert_name(ctx, &=
gc);
+            const char *friendly_name =3D get_cert_name(ctx, &gc);
  =
           if (!lookup_cert(friendly_name)) /* not our cert */
            =
 {
                 continue;
@@ -310,7 +310,7 @@
          */
         ass=
ert_non_null(ctx);
 
-        char *friendly_name =3D get_cert_name(ctx, &g=
c);
+        const char *friendly_name =3D get_cert_name(ctx, &gc);
       =
  struct test_cert *found =3D lookup_cert(friendly_name);
         assert_n=
on_null(found);
         assert_string_equal(found->cname, c->cname);
@@ -3=
43,7 +343,7 @@
          */
         assert_non_null(ctx);
 
-        char =
*friendly_name =3D get_cert_name(ctx, &gc);
+        const char *friendly_n=
ame =3D get_cert_name(ctx, &gc);
         struct test_cert *found =3D looku=
p_cert(friendly_name);
         assert_non_null(found);
         assert_str=
ing_equal(found->issuer, c->issuer);
diff --git a/tests/unit_tests/openvpn/=
test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index fc9840a=2E=2Ee=
1b03dd 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tests/unit=
_tests/openvpn/test_misc=2Ec
@@ -304,7 +304,7 @@
     {
         for (ptr_t=
ype i =3D 1; i <=3D 16; ++i)
         {
-            struct hash_element *i=
tem =3D hash_lookup_by_value(nhash, (void *)i);
+            const struct h=
ash_element *item =3D hash_lookup_by_value(nhash, (void *)i);
             =
hash_remove_by_value(nhash, (void *)i);
             /* check item got remo=
ved if it was present before */
             if (item)
diff --git a/tests/u=
nit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
inde=
x cad2ce0=2E=2Edf9fed7 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+=
++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -567,7 +567,7 @@
     ASSERT(=
md_valid("SHA256"));
     hmac_ctx_t *hmac_ctx =3D hmac_ctx_new();
 
-    u=
int8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };
+    const uint8_t key=
[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };
 
     hmac_ctx_init(hmac_ctx, k=
ey, "SHA256");
     return hmac_ctx;
diff --git a/tests/unit_tests/openvpn/=
test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index afadd31=2E=2E196=
6dab 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/tests/unit_te=
sts/openvpn/test_ssl=2Ec
@@ -683,7 +683,7 @@
     openvpn_encrypt(&buf, enc=
rypt_workspace, &co);
 
     /* separate buffer in authenticated data and e=
ncrypted data */
-    uint8_t *ad_start =3D BPTR(&buf);
+    const uint8_t =
*ad_start =3D BPTR(&buf);
     buf_advance(&buf, 4);
 
     if (epoch)
diff=
 --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec b/te=
sts/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec
index a861bfd=
=2E=2E89f0642 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_an=
d_replace=2Ec
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_repla=
ce=2Ec
@@ -12,7 +12,7 @@
 static void
 pass_any_null_param__returns_null(vo=
id **state)
 {
-    char DUMMY[] =3D "DUMMY";
+    const char DUMMY[] =3D "=
DUMMY";
 
     assert_null(searchandreplace(NULL, DUMMY, DUMMY));
     asse=
rt_null(searchandreplace(DUMMY, NULL, DUMMY));
@@ -22,8 +22,8 @@
 static vo=
id
 pass_any_empty_string__returns_null(void **state)
 {
-    char DUMMY[] =
=3D "DUMMY";
-    char EMPTY[] =3D "";
+    const char DUMMY[] =3D "DUMMY";=

+    const char EMPTY[] =3D "";
 
     assert_null(searchandreplace(EMPTY,=
 DUMMY, DUMMY));
     assert_null(searchandreplace(DUMMY, EMPTY, DUMMY));

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b71dae37ebe63c26=
a66761f877b25d326ed140f
Gerrit-Change-Number: 1661
Gerrit-PatchSet: 8
Gerri=
t-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>

--TMBGNhBVMbM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld <strong>uploaded pa=
tch set #8</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1661?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Re=
move instances of constVariable/constVariablePointer cppcheck warnings<br><=
br>Of varied usefulness, but easier to just address all of<br>them=2E<br><b=
r>Also change vpn_* parameters of dco_new_peer to const since<br>that is re=
quired by one of the changes and it works (and would<br>happen anyway when =
doing constParameterPointer)=2E<br><br>Change-Id: I2b71dae37ebe63c26a66761f=
877b25d326ed140f<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=
=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-suppression<br>M sample/sample-pl=
ugins/defer/multi-auth=2Ec<br>M sample/sample-plugins/log/log=2Ec<br>M samp=
le/sample-plugins/log/log_v3=2Ec<br>M sample/sample-plugins/simple/simple=
=2Ec<br>M src/openvpn/argv=2Ec<br>M src/openvpn/auth_token=2Ec<br>M src/ope=
nvpn/base64=2Ec<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/buffer=2Eh<br>=
M src/openvpn/comp-lz4=2Ec<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/cry=
pto_epoch=2Ec<br>M src/openvpn/cryptoapi=2Ec<br>M src/openvpn/dco=2Ec<br>M =
src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_internal=2Eh<br>M src/open=
vpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/dns=2Ec<br>=
M src/openvpn/event=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/init=
=2Ec<br>M src/openvpn/list=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn=
/misc=2Ec<br>M src/openvpn/mss=2Ec<br>M src/openvpn/mtcp=2Ec<br>M src/openv=
pn/mudp=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/networking_sitnl=2E=
c<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_parse=2Ec<br>M src/=
openvpn/options_util=2Ec<br>M src/openvpn/pool=2Ec<br>M src/openvpn/proxy=
=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/=
socket=2Ec<br>M src/openvpn/socket=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/op=
envpn/ssl_mbedtls=2Ec<br>M src/openvpn/ssl_verify=2Ec<br>M src/openvpn/tun=
=2Ec<br>M src/openvpn/win32=2Ec<br>M src/openvpnmsica/msica_arg=2Ec<br>M sr=
c/openvpnmsica/openvpnmsica=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M s=
rc/plugins/auth-pam/auth-pam=2Ec<br>M src/tapctl/main=2Ec<br>M tests/unit_t=
ests/openvpn/test_buffer=2Ec<br>M tests/unit_tests/openvpn/test_crypto=2Ec<=
br>M tests/unit_tests/openvpn/test_cryptoapi=2Ec<br>M tests/unit_tests/open=
vpn/test_misc=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>M tests/uni=
t_tests/openvpn/test_ssl=2Ec<br>M tests/unit_tests/plugins/auth-pam/test_se=
arch_and_replace=2Ec<br>57 files changed, 170 insertions(+), 171 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/o=
penvpn refs/changes/61/1661/8</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppr=
ession b/dev-tools/cppcheck-suppression</span><br><span>index 2e3350b=2E=2E=
900e03c 100644</span><br><span>--- a/dev-tools/cppcheck-suppression</span><=
br><span>+++ b/dev-tools/cppcheck-suppression</span><br><span>@@ -3,8 +3,6 =
@@</span><br><span> constParameter</span><br><span> constParameterCallback<=
/span><br><span> constParameterPointer</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-constVariable</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-constVariablePointer</span><br><span> invalidPrintfArgType_sint</s=
pan><br><span> invalidPrintfArgType_uint</span><br><span> usleepCalled</spa=
n><br><span>diff --git a/sample/sample-plugins/defer/multi-auth=2Ec b/sampl=
e/sample-plugins/defer/multi-auth=2Ec</span><br><span>index f6bbf44=2E=2Eba=
cf557 100644</span><br><span>--- a/sample/sample-plugins/defer/multi-auth=
=2Ec</span><br><span>+++ b/sample/sample-plugins/defer/multi-auth=2Ec</span=
><br><span>@@ -381,7 +381,7 @@</span><br><span>     }</span><br><span>     =
const char **argv =3D args-&gt;argv;</span><br><span>     const char **envp=
 =3D args-&gt;envp;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  struct plugin_context *context =3D (struct plugin_context *)args-&gt;hand=
le;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 plugin_context *context =3D (struct plugin_context *)args-&gt;handle;</spa=
n><br><span>     struct plugin_per_client_context *pcc =3D</span><br><span>=
         (struct plugin_per_client_context *)args-&gt;per_client_context;</=
span><br><span>     switch (args-&gt;type)</span><br><span>@@ -399,7 +399,7=
 @@</span><br><span> OPENVPN_EXPORT void *</span><br><span> openvpn_plugin_=
client_constructor_v1(openvpn_plugin_handle_t handle)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct plugin_contex=
t *context =3D (struct plugin_context *)handle;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const struct plugin_context *context =3D (s=
truct plugin_context *)handle;</span><br><span>     plog(context, PLOG_NOTE=
, &quot;FUNC: openvpn_plugin_client_constructor_v1&quot;);</span><br><span>=
     return calloc(1, sizeof(struct plugin_per_client_context));</span><br>=
<span> }</span><br><span>@@ -407,7 +407,7 @@</span><br><span> OPENVPN_EXPOR=
T void</span><br><span> openvpn_plugin_client_destructor_v1(openvpn_plugin_=
handle_t handle, void *per_client_context)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct plugin_context *context =
=3D (struct plugin_context *)handle;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const struct plugin_context *context =3D (struct plugi=
n_context *)handle;</span><br><span>     plog(context, PLOG_NOTE, &quot;FUN=
C: openvpn_plugin_client_destructor_v1&quot;);</span><br><span>     free(pe=
r_client_context);</span><br><span> }</span><br><span>diff --git a/sample/s=
ample-plugins/log/log=2Ec b/sample/sample-plugins/log/log=2Ec</span><br><sp=
an>index 330e3e0=2E=2E76350ee 100644</span><br><span>--- a/sample/sample-pl=
ugins/log/log=2Ec</span><br><span>+++ b/sample/sample-plugins/log/log=2Ec</=
span><br><span>@@ -173,7 +173,7 @@</span><br><span> openvpn_plugin_func_v1(=
openvpn_plugin_handle_t handle, const int type, const char *argv[],</span><=
br><span>                        const char *envp[])</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct plugin_context=
 *context =3D (struct plugin_context *)handle;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct plugin_context *context =3D (st=
ruct plugin_context *)handle;</span><br><span> </span><br><span>     show(t=
ype, argv, envp);</span><br><span> </span><br><span>diff --git a/sample/sam=
ple-plugins/log/log_v3=2Ec b/sample/sample-plugins/log/log_v3=2Ec</span><br=
><span>index d2d44c7=2E=2E09c6735 100644</span><br><span>--- a/sample/sampl=
e-plugins/log/log_v3=2Ec</span><br><span>+++ b/sample/sample-plugins/log/lo=
g_v3=2Ec</span><br><span>@@ -245,7 +245,7 @@</span><br><span> openvpn_plugi=
n_func_v3(const int version, struct openvpn_plugin_args_func_in const *args=
,</span><br><span>                        struct openvpn_plugin_args_func_r=
eturn *retptr)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct plugin_context *context =3D (struct plugin_context *=
)args-&gt;handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct plugin_context *context =3D (struct plugin_context *)args-&g=
t;handle;</span><br><span> </span><br><span>     printf(&quot;\nopenvpn_plu=
gin_func_v3() :::::&gt;&gt; &quot;);</span><br><span>     show(args-&gt;typ=
e, args-&gt;argv, args-&gt;envp);</span><br><span>diff --git a/sample/sampl=
e-plugins/simple/simple=2Ec b/sample/sample-plugins/simple/simple=2Ec</span=
><br><span>index 687a633=2E=2E3182be0 100644</span><br><span>--- a/sample/s=
ample-plugins/simple/simple=2Ec</span><br><span>+++ b/sample/sample-plugins=
/simple/simple=2Ec</span><br><span>@@ -104,7 +104,7 @@</span><br><span> ope=
nvpn_plugin_func_v1(openvpn_plugin_handle_t handle, const int type, const c=
har *argv[],</span><br><span>                        const char *envp[])</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
truct plugin_context *context =3D (struct plugin_context *)handle;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const struct plugin_cont=
ext *context =3D (struct plugin_context *)handle;</span><br><span> </span><=
br><span>     /* get username/password from envp string array */</span><br>=
<span>     const char *username =3D get_env(&quot;username&quot;, envp);</s=
pan><br><span>diff --git a/src/openvpn/argv=2Ec b/src/openvpn/argv=2Ec</spa=
n><br><span>index 6a5d92e=2E=2E028671d 100644</span><br><span>--- a/src/ope=
nvpn/argv=2Ec</span><br><span>+++ b/src/openvpn/argv=2Ec</span><br><span>@@=
 -359,7 +359,7 @@</span><br><span>      *</span><br><span>      */</span><b=
r><span>     size_t argc =3D argres-&gt;argc;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    char *f =3D argv_prep_format(format, delim, &am=
p;argc, &amp;argres-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const char *f =3D argv_prep_format(format, delim, &amp;argc, &=
amp;argres-&gt;gc);</span><br><span>     if (f =3D=3D NULL)</span><br><span=
>     {</span><br><span>         goto out;</span><br><span>diff --git a/src=
/openvpn/auth_token=2Ec b/src/openvpn/auth_token=2Ec</span><br><span>index =
bd90212=2E=2Ef928a41 100644</span><br><span>--- a/src/openvpn/auth_token=2E=
c</span><br><span>+++ b/src/openvpn/auth_token=2Ec</span><br><span>@@ -235,=
7 +235,7 @@</span><br><span>      * a new token with the empty username sin=
ce we do not want to loose</span><br><span>      * the information that the=
 username cannot be trusted</span><br><span>      */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct key_state *ks =3D &amp;multi-&gt=
;session[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const struct key_state *ks =3D &amp;multi-&gt;sessio=
n[TM_ACTIVE]=2Ekey[KS_PRIMARY];</span><br><span>     if (ks-&gt;auth_token_=
state_flags &amp; AUTH_TOKEN_VALID_EMPTYUSER)</span><br><span>     {</span>=
<br><span>         hmac_ctx_update(ctx, (const uint8_t *)&quot;&quot;, 0);<=
/span><br><span>diff --git a/src/openvpn/base64=2Ec b/src/openvpn/base64=2E=
c</span><br><span>index 7af8976=2E=2E5752844 100644</span><br><span>--- a/s=
rc/openvpn/base64=2Ec</span><br><span>+++ b/src/openvpn/base64=2Ec</span><b=
r><span>@@ -161,7 +161,7 @@</span><br><span> {</span><br><span>     const c=
har *p;</span><br><span>     unsigned char *q;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    unsigned char *e =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const unsigned char *e =3D NULL;</s=
pan><br><span> </span><br><span>     q =3D data;</span><br><span>     if (s=
ize &gt;=3D 0)</span><br><span>diff --git a/src/openvpn/buffer=2Ec b/src/op=
envpn/buffer=2Ec</span><br><span>index 922238d=2E=2Ef57c8c2 100644</span><b=
r><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buff=
er=2Ec</span><br><span>@@ -536,7 +536,7 @@</span><br><span> void</span><br>=
<span> buf_null_terminate(struct buffer *buf)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    char *last =3D (char *)BLAST=
(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const cha=
r *last =3D (char *)BLAST(buf);</span><br><span>     if (last &amp;&amp; *l=
ast =3D=3D &#39;\0&#39;) /* already terminated? */</span><br><span>     {</=
span><br><span>         return;</span><br><span>@@ -559,7 +559,7 @@</span><=
br><span> {</span><br><span>     while (true)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        char *last =3D (char=
 *)BLAST(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const char *last =3D (char *)BLAST(buf);</span><br><span>         if (!l=
ast)</span><br><span>         {</span><br><span>             break;</span><=
br><span>diff --git a/src/openvpn/buffer=2Eh b/src/openvpn/buffer=2Eh</span=
><br><span>index c6722c7=2E=2E93aa786 100644</span><br><span>--- a/src/open=
vpn/buffer=2Eh</span><br><span>+++ b/src/openvpn/buffer=2Eh</span><br><span=
>@@ -720,7 +720,7 @@</span><br><span> static inline bool</span><br><span> b=
uf_copy_n(struct buffer *dest, struct buffer *src, int n)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *cp =3D =
buf_read_alloc(src, n);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const uint8_t *cp =3D buf_read_alloc(src, n);</span><br><span>     =
if (!cp)</span><br><span>     {</span><br><span>         return false;</spa=
n><br><span>@@ -772,7 +772,7 @@</span><br><span> static inline bool</span><=
br><span> buf_read(struct buffer *src, void *dest, int size)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *cp =
=3D buf_read_alloc(src, size);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const uint8_t *cp =3D buf_read_alloc(src, size);</span><br><=
span>     if (!cp)</span><br><span>     {</span><br><span>         return f=
alse;</span><br><span>diff --git a/src/openvpn/comp-lz4=2Ec b/src/openvpn/c=
omp-lz4=2Ec</span><br><span>index 45f138c=2E=2E48797b0 100644</span><br><sp=
an>--- a/src/openvpn/comp-lz4=2Ec</span><br><span>+++ b/src/openvpn/comp-lz=
4=2Ec</span><br><span>@@ -164,7 +164,7 @@</span><br><span>     ASSERT(buf_i=
nit(&amp;work, frame-&gt;buf=2Eheadroom));</span><br><span> </span><br><spa=
n>     /* do unframing/swap (assumes buf-&gt;len &gt; 0) */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *head =3D BPTR(buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t *head =
=3D BPTR(buf);</span><br><span>     c =3D *head;</span><br><span> </span><b=
r><span>     /* Not compressed */</span><br><span>diff --git a/src/openvpn/=
crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 6127fdb=2E=2E67ff=
0d3 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++=
 b/src/openvpn/crypto=2Ec</span><br><span>@@ -1210,7 +1210,7 @@</span><br><=
span> </span><br><span>     /* init implicit IV */</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cipher_ctx_t *c=
ipher =3D co-&gt;key_ctx_bi=2Eencrypt=2Ecipher;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const cipher_ctx_t *cipher =3D co-&gt;k=
ey_ctx_bi=2Eencrypt=2Ecipher;</span><br><span>         if (cipher_ctx_mode_=
aead(cipher))</span><br><span>         {</span><br><span>             ASSER=
T(cipher_ctx_iv_length(cipher) &lt;=3D OPENVPN_MAX_IV_LENGTH);</span><br><s=
pan>@@ -1920,7 +1920,7 @@</span><br><span>     const char *seed =3D &quot;t=
ls1-prf-test&quot;;</span><br><span>     const char *secret =3D &quot;tls1-=
prf-test-secret&quot;;</span><br><span>     uint8_t out[8];</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint8_t expected_out[] =3D { &#39=
;q&#39;, &#39;D&#39;, 0xfe, &#39;%&#39;, &#39;@&#39;, &#39;s&#39;, &#39;u&#=
39;, 0x95 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint8_t expected_out[] =3D { &#39;q&#39;, &#39;D&#39;, 0xfe, &#39;%&#39;=
, &#39;@&#39;, &#39;s&#39;, &#39;u&#39;, 0x95 };</span><br><span> </span><b=
r><span>     int ret =3D ssl_tls1_PRF((uint8_t *)seed, strlen(seed), (uint8=
_t *)secret,</span><br><span>                            strlen(secret), ou=
t, sizeof(out));</span><br><span>diff --git a/src/openvpn/crypto_epoch=2Ec =
b/src/openvpn/crypto_epoch=2Ec</span><br><span>index 54225bf=2E=2E3812435 1=
00644</span><br><span>--- a/src/openvpn/crypto_epoch=2Ec</span><br><span>++=
+ b/src/openvpn/crypto_epoch=2Ec</span><br><span>@@ -213,7 +213,7 @@</span>=
<br><span>      *</span><br><span>      * The last generated key might have=
 been moved to the decrypt key already=2E</span><br><span>      */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct key_ctx *highest_fu=
ture_key =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct key_ctx *highest_future_key =3D</span><br><span>         &amp;co-=
&gt;epoch_data_keys_future[co-&gt;epoch_data_keys_future_count - 1];</span>=
<br><span> </span><br><span>     ASSERT(co-&gt;epoch_key_recv=2Eepoch =3D=
=3D 1 || highest_future_key-&gt;epoch =3D=3D co-&gt;epoch_key_recv=2Eepoch<=
/span><br><span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/crypto=
api=2Ec</span><br><span>index 0f95ab7=2E=2Ead2706c 100644</span><br><span>-=
-- a/src/openvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn/cryptoapi=
=2Ec</span><br><span>@@ -225,7 +225,6 @@</span><br><span>     const CERT_IN=
FO *info =3D cert_ctx-&gt;pCertInfo;</span><br><span>     const CERT_EXTENS=
ION *ext;</span><br><span>     DWORD cbext;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    void *pvext;</span><br><span>     struct gc_arena=
 gc =3D gc_new();</span><br><span>     const WCHAR *tmpl_name =3D wide_stri=
ng(cert_prop, &amp;gc);</span><br><span> </span><br><span>@@ -233,7 +232,7 =
@@</span><br><span>     ext =3D CertFindExtension(szOID_CERTIFICATE_TEMPLAT=
E, info-&gt;cExtension, info-&gt;rgExtension);</span><br><span>     if (ext=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        pvext =3D decode_object(&amp;gc, X509_CERTIFICATE_TEMPLATE, &amp=
;ext-&gt;Value, 0, &amp;cbext);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        const void *pvext =3D decode_object(&amp;gc, X509_CERTI=
FICATE_TEMPLATE, &amp;ext-&gt;Value, 0, &amp;cbext);</span><br><span>      =
   if (pvext &amp;&amp; cbext &gt;=3D sizeof(CERT_TEMPLATE_EXT))</span><br>=
<span>         {</span><br><span>             const CERT_TEMPLATE_EXT *cte =
=3D (const CERT_TEMPLATE_EXT *)pvext;</span><br><span>diff --git a/src/open=
vpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 2584368=2E=2Ef5d409=
d 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/sr=
c/openvpn/dco=2Ec</span><br><span>@@ -112,7 +112,7 @@</span><br><span>     =
for (int i =3D 0; i &lt; KEY_SCAN_SIZE; ++i)</span><br><span>     {</span><=
br><span>         struct key_state *ks =3D get_key_scan(multi, i);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct key_ctx_bi *key=
 =3D &amp;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        const struct key_ctx_bi *key =3D &amp;ks-=
&gt;crypto_options=2Ekey_ctx_bi;</span><br><span> </span><br><span>        =
 if (ks =3D=3D primary)</span><br><span>         {</span><br><span>@@ -576,=
7 +576,7 @@</span><br><span>                         struct sockaddr_storag=
e *local)</span><br><span> {</span><br><span> #if ENABLE_IP_PKTINFO</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =3D &am=
p;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span>=
<br><span>     if (!proto_is_udp(c-&gt;c2=2Elink_sockets[0]-&gt;info=2Eprot=
o)</span><br><span>         || !(c-&gt;options=2Esockflags &amp; SF_USE_IP_=
PKTINFO))</span><br><span>@@ -624,7 +624,7 @@</span><br><span> int</span><b=
r><span> dco_multi_add_new_peer(struct multi_context *m, struct multi_insta=
nce *mi)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct context *c =3D &amp;mi-&gt;context;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct context *c =3D &amp;mi-&=
gt;context;</span><br><span> </span><br><span>     int peer_id =3D c-&gt;c2=
=2Etls_multi-&gt;peer_id;</span><br><span>     struct sockaddr *remoteaddr,=
 *localaddr =3D NULL;</span><br><span>@@ -645,14 +645,14 @@</span><br><span=
> </span><br><span>     /* In server mode we need to fetch the remote addre=
sses from the push config */</span><br><span>     struct in_addr vpn_ip4 =
=3D { 0 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
in_addr *vpn_addr4 =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct in_addr *vpn_addr4 =3D NULL;</span><br><span>    =
 if (c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><sp=
an>         vpn_ip4=2Es_addr =3D htonl(c-&gt;c2=2Epush_ifconfig_local);</sp=
an><br><span>         vpn_addr4 =3D &amp;vpn_ip4;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct in6_addr *vpn_addr6 =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct in6_addr *vpn_addr6 =3D NULL;</span><br><sp=
an>     if (c-&gt;c2=2Epush_ifconfig_ipv6_defined)</span><br><span>     {</=
span><br><span>         vpn_addr6 =3D &amp;c-&gt;c2=2Epush_ifconfig_ipv6_lo=
cal;</span><br><span>@@ -701,7 +701,7 @@</span><br><span>     }</span><br><=
span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    struct context *c =3D &amp;mi-&gt;context;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct context *c =3D &amp;mi=
-&gt;context;</span><br><span>     if (addrtype =3D=3D MR_ADDR_IPV6)</span>=
<br><span>     {</span><br><span> #if defined(_WIN32)</span><br><span>@@ -7=
49,7 +749,7 @@</span><br><span>     }</span><br><span>     ASSERT(TUNNEL_TY=
PE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct context *c =
=3D &amp;mi-&gt;context;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const struct context *c =3D &amp;mi-&gt;context;</span><br><span> =
</span><br><span>     if (mi-&gt;context=2Ec2=2Epush_ifconfig_defined)</spa=
n><br><span>     {</span><br><span>diff --git a/src/openvpn/dco_freebsd=2Ec=
 b/src/openvpn/dco_freebsd=2Ec</span><br><span>index eaca86b=2E=2Ed933aaf 1=
00644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><br><span>+++=
 b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -134,7 +134,8 @@</span><b=
r><span> </span><br><span> int</span><br><span> dco_new_peer(dco_context_t =
*dco, unsigned int peerid, int sd, struct sockaddr *localaddr,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-             struct sockaddr *remo=
teaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             struct sockaddr *remo=
teaddr, const struct in_addr *vpn_ipv4,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             const struct in6_addr *vpn_ipv6)</span><br=
><span> {</span><br><span>     struct ifdrv drv;</span><br><span>     nvlis=
t_t *nvl, *local_nvl, *remote_nvl;</span><br><span>diff --git a/src/openvpn=
/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh</span><br><span>index da07=
780=2E=2Efcf8aca 100644</span><br><span>--- a/src/openvpn/dco_internal=2Eh<=
/span><br><span>+++ b/src/openvpn/dco_internal=2Eh</span><br><span>@@ -60,7=
 +60,7 @@</span><br><span>  */</span><br><span> </span><br><span> int dco_n=
ew_peer(dco_context_t *dco, unsigned int peerid, socket_descriptor_t sd, st=
ruct sockaddr *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                 struct sockaddr *remoteaddr, struct in_addr *vpn_ipv4,=
 struct in6_addr *vpn_ipv6);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                 struct sockaddr *remoteaddr, const struct in_addr=
 *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br><span> </span><br><=
span> int dco_del_peer(dco_context_t *dco, unsigned int peerid);</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src/openvp=
n/dco_linux=2Ec</span><br><span>index 40746bd=2E=2E56f6259 100644</span><br=
><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/openvpn/dc=
o_linux=2Ec</span><br><span>@@ -222,7 +222,8 @@</span><br><span> </span><br=
><span> int</span><br><span> dco_new_peer(dco_context_t *dco, unsigned int =
peerid, int sd, struct sockaddr *localaddr,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-             struct sockaddr *remoteaddr, struct in_a=
ddr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+             struct sockaddr *remoteaddr, const struc=
t in_addr *vpn_ipv4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             const struct in6_addr *vpn_ipv6)</span><br><span> {</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>     const cha=
r *remotestr =3D &quot;[undefined]&quot;;</span><br><span>@@ -697,7 +698,7 =
@@</span><br><span> {</span><br><span>     dco_context_t *dco =3D arg;</spa=
n><br><span>     struct nlattr *tb[CTRL_ATTR_MAX + 1];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct genlmsghdr *gnlh =3D nlmsg_data=
(nlmsg_hdr(msg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const struct genlmsghdr *gnlh =3D nlmsg_data(nlmsg_hdr(msg));</span><br><=
span> </span><br><span>     nla_parse(tb, CTRL_ATTR_MAX, genlmsg_attrdata(g=
nlh, 0), genlmsg_attrlen(gnlh, 0), NULL);</span><br><span> </span><br><span=
>@@ -706,7 +707,7 @@</span><br><span>         return NL_SKIP;</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct nlattr *mcgrp;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct nlattr *mcgrp;</span><br><span>     int rem_mc=
grp;</span><br><span>     nla_for_each_nested(mcgrp, tb[CTRL_ATTR_MCAST_GRO=
UPS], rem_mcgrp)</span><br><span>     {</span><br><span>diff --git a/src/op=
envpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index 2e26f2a=
=2E=2Eb3268bc 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</span><b=
r><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -285,8 +285,8 @@</=
span><br><span>     msg(D_DCO_DEBUG, &quot;%s&quot;, __func__);</span><br><=
span> </span><br><span>     int ai_family =3D sock-&gt;info=2Elsa-&gt;bind_=
local-&gt;ai_family;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   struct addrinfo *local =3D sock-&gt;info=2Elsa-&gt;bind_local;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *cur =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 addrinfo *local =3D sock-&gt;info=2Elsa-&gt;bind_local;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct addrinfo *cur =3D NUL=
L;</span><br><span> </span><br><span>     for (cur =3D local; cur; cur =3D =
cur-&gt;ai_next)</span><br><span>     {</span><br><span>@@ -334,7 +334,7 @@=
</span><br><span>     struct addrinfo *remoteaddr =3D sock-&gt;info=2Elsa-&=
gt;current_remote;</span><br><span> </span><br><span>     struct sockaddr *=
local =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct sockaddr *remote =3D remoteaddr-&gt;ai_addr;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct sockaddr *remote =3D remotea=
ddr-&gt;ai_addr;</span><br><span> </span><br><span>     if (remoteaddr-&gt;=
ai_protocol =3D=3D IPPROTO_TCP || remoteaddr-&gt;ai_socktype =3D=3D SOCK_ST=
REAM)</span><br><span>     {</span><br><span>@@ -348,7 +348,7 @@</span><br>=
<span>     if (sock-&gt;bind_local)</span><br><span>     {</span><br><span>=
         /* Use first local address with correct address family */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct addrinfo *bind =
=3D sock-&gt;info=2Elsa-&gt;bind_local;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const struct addrinfo *bind =3D sock-&gt;info=
=2Elsa-&gt;bind_local;</span><br><span>         while (bind &amp;&amp; !loc=
al)</span><br><span>         {</span><br><span>             if (bind-&gt;ai=
_family =3D=3D remote-&gt;sa_family)</span><br><span>@@ -415,8 +415,9 @@</s=
pan><br><span> }</span><br><span> </span><br><span> int</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_context_t *dco, unsigned=
 int peerid, socket_descriptor_t sd, struct sockaddr *localaddr,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-             struct sockaddr *re=
moteaddr, struct in_addr *vpn_ipv4, struct in6_addr *vpn_ipv6)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+dco_new_peer(dco_context_t *dco,=
 unsigned int peerid, socket_descriptor_t sd,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             struct sockaddr *localaddr, struct s=
ockaddr *remoteaddr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+             const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ip=
v6)</span><br><span> {</span><br><span>     msg(D_DCO_DEBUG, &quot;%s: peer=
-id %d, fd &quot; SOCKET_PRINTF, __func__, peerid, sd);</span><br><span> </=
span><br><span>@@ -745,7 +746,7 @@</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span> </span><br><span>     int ret =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tuntap *tt =3D dco=
-&gt;tt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct tuntap *tt =3D dco-&gt;tt;</span><br><span> </span><br><span>     if =
(!tuntap_defined(tt))</span><br><span>     {</span><br><span>@@ -869,7 +870=
,7 @@</span><br><span> int</span><br><span> dco_get_peer_stats_fallback(str=
uct context *c, const bool raise_sigusr1_on_err)</span><br><span> {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tuntap *tt =3D c-&=
gt;c1=2Etuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct tuntap *tt =3D c-&gt;c1=2Etuntap;</span><br><span> </span><br>=
<span>     if (!tuntap_defined(tt))</span><br><span>     {</span><br><span>=
@@ -898,7 +899,7 @@</span><br><span> int</span><br><span> dco_get_peer_stat=
s(struct context *c, const bool raise_sigusr1_on_err)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tuntap *tt =
=3D c-&gt;c1=2Etuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const struct tuntap *tt =3D c-&gt;c1=2Etuntap;</span><br><span> </sp=
an><br><span>     if (!tuntap_defined(tt))</span><br><span>     {</span><br=
><span>diff --git a/src/openvpn/dns=2Ec b/src/openvpn/dns=2Ec</span><br><sp=
an>index 1465cdf=2E=2E7f4dde4 100644</span><br><span>--- a/src/openvpn/dns=
=2Ec</span><br><span>+++ b/src/openvpn/dns=2Ec</span><br><span>@@ -132,7 +1=
32,7 @@</span><br><span>     }</span><br><span>     else</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct so=
ckaddr_in6 *sin6 =3D (struct sockaddr_in6 *)ai-&gt;ai_addr;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const struct sockaddr_in6 *=
sin6 =3D (struct sockaddr_in6 *)ai-&gt;ai_addr;</span><br><span>         se=
rver-&gt;addr[server-&gt;addr_count]=2Ein=2Ea6 =3D sin6-&gt;sin6_addr;</spa=
n><br><span>     }</span><br><span> </span><br><span>@@ -156,7 +156,7 @@</s=
pan><br><span>     /* Append all domains to the end of the list */</span><b=
r><span>     while (*domains)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        char *domain =3D *domains++;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *domain=
 =3D *domains++;</span><br><span>         if (!validate_domain(domain))</sp=
an><br><span>         {</span><br><span>             return false;</span><b=
r><span>@@ -699,7 +699,7 @@</span><br><span> run_up_down_command(bool up, s=
truct options *o, const struct tuntap *tt,</span><br><span>                =
     struct dns_updown_runner_info *updown_runner)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct dns_options *dns=
 =3D &amp;o-&gt;dns_options;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct dns_options *dns =3D &amp;o-&gt;dns_options;</spa=
n><br><span>     if (!dns-&gt;updown || (o-&gt;up_script &amp;&amp; !dns_up=
down_user_set(dns) &amp;&amp; !dns_updown_forced(dns)))</span><br><span>   =
  {</span><br><span>         return;</span><br><span>@@ -864,7 +864,7 @@</s=
pan><br><span>     }</span><br><span> #ifdef _WIN32</span><br><span>     /*=
 Don&#39;t use iservice in DHCP mode */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct tuntap_options *tto =3D &amp;o-&gt;tuntap_opti=
ons;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t tuntap_options *tto =3D &amp;o-&gt;tuntap_options;</span><br><span>     i=
f (tto-&gt;ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ || tto-&gt;ip_win32_typ=
e =3D=3D IPW32_SET_ADAPTIVE)</span><br><span>     {</span><br><span>       =
  return;</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/=
event=2Ec</span><br><span>index 9e17807=2E=2E8b7716a 100644</span><br><span=
>--- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</s=
pan><br><span>@@ -557,7 +557,7 @@</span><br><span> ep_del(struct event_set =
*es, event_t event)</span><br><span> {</span><br><span>     struct epoll_ev=
ent ev;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct ep_=
set *eps =3D (struct ep_set *)es;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct ep_set *eps =3D (struct ep_set *)es;</span><=
br><span> </span><br><span>     dmsg(D_EVENT_WAIT, &quot;EP_DEL ev=3D%d&quo=
t;, (int)event);</span><br><span> </span><br><span>@@ -572,7 +572,7 @@</spa=
n><br><span> static void</span><br><span> ep_ctl(struct event_set *es, even=
t_t event, unsigned int rwflags, void *arg)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct ep_set *eps =3D (struct=
 ep_set *)es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct ep_set *eps =3D (struct ep_set *)es;</span><br><span>     struct=
 epoll_event ev;</span><br><span> </span><br><span>     CLEAR(ev);</span><b=
r><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</spa=
n><br><span>index c5b9278=2E=2E6581998 100644</span><br><span>--- a/src/ope=
nvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><s=
pan>@@ -1213,7 +1213,7 @@</span><br><span> {</span><br><span>     if (float=
_sa-&gt;sa_family =3D=3D AF_INET)</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        struct sockaddr_in *float4 =3D (=
struct sockaddr_in *)float_sa;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const struct sockaddr_in *float4 =3D (struct sockaddr_in=
 *)float_sa;</span><br><span>         /* DCO treats IPv4-mapped IPv6 addres=
ses as pure IPv4=2E However, on a</span><br><span>          * dual-stack so=
cket, we need to preserve the mapping otherwise openvpn</span><br><span>   =
       * will not be able to find the peer by its transport address=2E</spa=
n><br><span>@@ -1236,7 +1236,7 @@</span><br><span>     }</span><br><span>  =
   else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)flo=
at_sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const=
 struct sockaddr_in6 *float6 =3D (struct sockaddr_in6 *)float_sa;</span><br=
><span>         memcpy(&amp;out_osaddr-&gt;addr=2Ein6, float6, sizeof(struc=
t sockaddr_in6));</span><br><span>     }</span><br><span> }</span><br><span=
>@@ -1366,8 +1366,8 @@</span><br><span>         return;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct openvpn_sockaddr *link_addr =3D &amp;c-&gt;c2=2Eto_link_addr-&gt=
;dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link=
_socket_info *lsi =3D get_link_socket_info(c);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct openvpn_sockaddr *link_addr =3D=
 &amp;c-&gt;c2=2Eto_link_addr-&gt;dest;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct link_socket_info *lsi =3D get_link_soc=
ket_info(c);</span><br><span> </span><br><span>     int ip_hdr_offset =3D 0=
;</span><br><span>     int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c-&gt;=
c1=2Etuntap), buf, &amp;ip_hdr_offset);</span><br><span>@@ -1404,7 +1404,7 =
@@</span><br><span>         }</span><br><span> </span><br><span>         /*=
 drop packets with same dest addr and port as remote */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        uint8_t *l4_hdr =3D (uint8_t *)pi=
p + ip_hlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 const uint8_t *l4_hdr =3D (uint8_t *)pip + ip_hlen;</span><br><span> </spa=
n><br><span>         uint16_t link_port =3D ntohs(link_addr-&gt;addr=2Ein4=
=2Esin_port);</span><br><span> </span><br><span>@@ -1451,7 +1451,7 @@</span=
><br><span>         uint16_t link_port =3D ntohs(link_addr-&gt;addr=2Ein6=
=2Esin6_port);</span><br><span> </span><br><span>         /* drop packets w=
ith same dest addr and port as remote */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(str=
uct openvpn_ipv6hdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        const uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn=
_ipv6hdr);</span><br><span>         uint16_t src_port =3D ntohs(*(uint16_t =
*)l4_hdr);</span><br><span>         uint16_t dst_port =3D ntohs(*(uint16_t =
*)(l4_hdr + sizeof(uint16_t)));</span><br><span>         if ((OPENVPN_IN6_A=
RE_ADDR_EQUAL(&amp;link_addr-&gt;addr=2Ein6=2Esin6_addr, &amp;pip6-&gt;dadd=
r)) &amp;&amp; (link_port =3D=3D dst_port))</span><br><span>@@ -2209,7 +220=
9,7 @@</span><br><span> </span><br><span>                     if (e-&gt;arg=
 &gt;=3D MULTI_N)</span><br><span>                     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                        struct event_arg=
 *ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        const struct event_arg *ev_=
arg =3D (struct event_arg *)e-&gt;arg;</span><br><span>                    =
     if (ev_arg-&gt;type !=3D EVENT_ARG_LINK_SOCKET)</span><br><span>      =
                   {</span><br><span>                             c-&gt;c2=
=2Eevent_set_status =3D ES_ERROR;</span><br><span>diff --git a/src/openvpn/=
init=2Ec b/src/openvpn/init=2Ec</span><br><span>index 914d191=2E=2Ea068b8b =
100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src=
/openvpn/init=2Ec</span><br><span>@@ -319,8 +319,8 @@</span><br><span> mana=
gement_callback_remote_entry_count(void *arg)</span><br><span> {</span><br>=
<span>     ASSERT(arg);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct context *c =3D (struct context *)arg;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct connection_list *l =3D c-&gt;option=
s=2Econnection_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct context *c =3D (struct context *)arg;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct connection_list *l =3D=
 c-&gt;options=2Econnection_list;</span><br><span> </span><br><span>     re=
turn l-&gt;len;</span><br><span> }</span><br><span>@@ -342,7 +342,7 @@</spa=
n><br><span> </span><br><span>     if (index &lt; l-&gt;len)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t connection_entry *ce =3D l-&gt;array[index];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const struct connection_entry *ce =3D l-=
&gt;array[index];</span><br><span>         const char *proto =3D proto2asci=
i(ce-&gt;proto, ce-&gt;af, false);</span><br><span>         const char *sta=
tus =3D (ce-&gt;flags &amp; CE_DISABLED) ? &quot;disabled&quot; : &quot;ena=
bled&quot;;</span><br><span> </span><br><span>@@ -525,7 +525,7 @@</span><br=
><span> {</span><br><span>     struct connection_list *l =3D c-&gt;options=
=2Econnection_list;</span><br><span>     bool ce_defined;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct connection_entry *ce;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct connectio=
n_entry *ce;</span><br><span>     int n_cycles =3D 0;</span><br><span> </sp=
an><br><span>     do</span><br><span>@@ -1581,10 +1581,10 @@</span><br><spa=
n>     /* Tell management interface that we initialized */</span><br><span>=
     if (management)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        in_addr_t *tun_local =3D NULL;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        struct in6_addr *tun_local6 =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst in_addr_t *tun_local =3D NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct in6_addr *tun_local6 =3D NULL;</span><b=
r><span>         struct openvpn_sockaddr local, remote;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        struct link_socket_actual *actual=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const stru=
ct link_socket_actual *actual;</span><br><span>         socklen_t sa_len =
=3D sizeof(local);</span><br><span>         const char *detail =3D &quot;SU=
CCESS&quot;;</span><br><span>         if (flags &amp; ISC_ERRORS)</span><br=
><span>@@ -4293,7 +4293,7 @@</span><br><span>     /* On some newer Android =
handsets, changing to a different network</span><br><span>      * often doe=
s not trigger a TCP reset but continue using the old</span><br><span>      =
* connection (e=2Eg=2E using mobile connection when WiFi becomes available =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_soc=
ket_info *lsi =3D get_link_socket_info(c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const struct link_socket_info *lsi =3D get_link_=
socket_info(c);</span><br><span>     if (lsi &amp;&amp; proto_is_tcp(lsi-&g=
t;proto) &amp;&amp; !samenetwork)</span><br><span>     {</span><br><span>  =
       return -2;</span><br><span>diff --git a/src/openvpn/list=2Ec b/src/o=
penvpn/list=2Ec</span><br><span>index c07e764=2E=2E09349e7 100644</span><br=
><span>--- a/src/openvpn/list=2Ec</span><br><span>+++ b/src/openvpn/list=2E=
c</span><br><span>@@ -165,7 +165,7 @@</span><br><span> hash_remove_by_value=
(struct hash *hash, void *value)</span><br><span> {</span><br><span>     st=
ruct hash_iterator hi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct hash_element *he;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct hash_element *he;</span><br><span> </span><br><s=
pan>     hash_iterator_init(hash, &amp;hi);</span><br><span>     while ((he=
 =3D hash_iterator_next(&amp;hi)))</span><br><span>diff --git a/src/openvpn=
/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index c082f51=2E=2E604=
bbcd 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br><span>++=
+ b/src/openvpn/manage=2Ec</span><br><span>@@ -3820,7 +3820,7 @@</span><br>=
<span> {</span><br><span>     int ok;</span><br><span>     char *result =3D=
 NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buff=
er *buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const s=
truct buffer *buf;</span><br><span> </span><br><span>     ok =3D management=
_query_multiline(man, b64_data, prompt, cmd, state, input);</span><br><span=
>     if (ok &amp;&amp; buffer_list_defined(*input))</span><br><span>@@ -38=
49,7 +3849,7 @@</span><br><span> {</span><br><span>     int ok;</span><br><=
span>     char *result =3D NULL;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct buffer *buf;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct buffer *buf;</span><br><span> </span><br><s=
pan>     ok =3D management_query_multiline(man, b64_data, prompt, cmd, stat=
e, input);</span><br><span>     if (ok &amp;&amp; buffer_list_defined(*inpu=
t))</span><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2E=
c</span><br><span>index 10bfc35=2E=2E6563b83 100644</span><br><span>--- a/s=
rc/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><s=
pan>@@ -131,7 +131,7 @@</span><br><span>     struct auth_challenge_info *ac=
;</span><br><span>     const int len =3D strlen(auth_challenge);</span><br>=
<span>     char *work =3D (char *)gc_malloc(len + 1, false, gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    char *cp;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const char *cp;</span><br><span> <=
/span><br><span>     struct buffer b;</span><br><span>     buf_set_read(&am=
p;b, (const uint8_t *)auth_challenge, len);</span><br><span>diff --git a/sr=
c/openvpn/mss=2Ec b/src/openvpn/mss=2Ec</span><br><span>index 14112b4=2E=2E=
36bbb43 100644</span><br><span>--- a/src/openvpn/mss=2Ec</span><br><span>++=
+ b/src/openvpn/mss=2Ec</span><br><span>@@ -65,7 +65,7 @@</span><br><span> =
        struct buffer newbuf =3D *buf;</span><br><span>         if (buf_adv=
ance(&amp;newbuf, hlen))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            struct openvpn_tcphdr *tc =3D (=
struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            const struct openvpn_tcphdr *tc =3D (str=
uct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span>             if (tc=
-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>             {</spa=
n><br><span>                 mss_fixup_dowork(&amp;newbuf, maxmss);</span><=
br><span>@@ -122,7 +122,7 @@</span><br><span>     newbuf =3D *buf;</span><b=
r><span>     if (buf_advance(&amp;newbuf, 40) &amp;&amp; BLENZ(&amp;newbuf)=
 &gt;=3D sizeof(struct openvpn_tcphdr))</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        struct openvpn_tcphdr *tc =
=3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        const struct openvpn_tcphdr *tc =3D (st=
ruct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span>         if (tc-&g=
t;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>         {</span><br><=
span>             mss_fixup_dowork(&amp;newbuf, maxmss - 20);</span><br><sp=
an>diff --git a/src/openvpn/mtcp=2Ec b/src/openvpn/mtcp=2Ec</span><br><span=
>index f000283=2E=2E5d88f8a 100644</span><br><span>--- a/src/openvpn/mtcp=
=2Ec</span><br><span>+++ b/src/openvpn/mtcp=2Ec</span><br><span>@@ -130,7 +=
130,7 @@</span><br><span> void</span><br><span> multi_tcp_dereference_insta=
nce(struct multi_io *multi_io, struct multi_instance *mi)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct link_sock=
et *sock =3D mi-&gt;context=2Ec2=2Elink_sockets[0];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket *sock =3D mi=
-&gt;context=2Ec2=2Elink_sockets[0];</span><br><span>     if (sock &amp;&am=
p; mi-&gt;socket_set_called)</span><br><span>     {</span><br><span>       =
  event_del(multi_io-&gt;es, socket_event_handle(sock));</span><br><span>di=
ff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>inde=
x 9acf297=2E=2E49dc4eb 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</s=
pan><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -88,7 +88,7 @@<=
/span><br><span>     verdict =3D tls_pre_decrypt_lite(tas, state, &amp;m-&g=
t;top=2Ec2=2Efrom, &amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span> </span><br>=
<span>     hmac_ctx_t *hmac =3D m-&gt;top=2Ec2=2Esession_id_hmac;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct openvpn_sockaddr *fr=
om =3D &amp;m-&gt;top=2Ec2=2Efrom=2Edest;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const struct openvpn_sockaddr *from =3D &amp;m-&g=
t;top=2Ec2=2Efrom=2Edest;</span><br><span>     int handwindow =3D m-&gt;top=
=2Eoptions=2Ehandshake_window;</span><br><span> </span><br><span>     if (v=
erdict =3D=3D VERDICT_VALID_RESET_V3 || verdict =3D=3D VERDICT_VALID_RESET_=
V2)</span><br><span>@@ -283,7 +283,7 @@</span><br><span>         struct has=
h_element *he;</span><br><span>         const uint64_t hv =3D hash_value(ha=
sh, &amp;real);</span><br><span>         struct hash_bucket *bucket =3D has=
h_bucket(hash, hv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      uint8_t *ptr =3D BPTR(&amp;m-&gt;top=2Ec2=2Ebuf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const uint8_t *ptr =3D BPTR(&am=
p;m-&gt;top=2Ec2=2Ebuf);</span><br><span>         uint8_t op =3D ptr[0] &gt=
;&gt; P_OPCODE_SHIFT;</span><br><span>         bool v2 =3D (op =3D=3D P_DAT=
A_V2) &amp;&amp; (m-&gt;top=2Ec2=2Ebuf=2Elen &gt;=3D (1 + 3));</span><br><s=
pan>         bool peer_id_disabled =3D false;</span><br><span>diff --git a/=
src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index fe2badb=
=2E=2E5b4bc4e 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br>=
<span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -86,7 +86,7 @@</span><=
br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     struct =
env_set *es;</span><br><span>     bool ret =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct plugin_list *plugins;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const struct plugin_list *=
plugins;</span><br><span> </span><br><span>     /* get environmental variab=
le source */</span><br><span>     if (mi &amp;&amp; mi-&gt;context=2Ec2=2Ee=
s)</span><br><span>@@ -1794,7 +1794,7 @@</span><br><span>      * Push the f=
irst cipher from --data-ciphers to the client that</span><br><span>      * =
the client announces to be supporting=2E</span><br><span>      */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    char *push_cipher =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *push_ciph=
er =3D</span><br><span>         ncp_get_best_cipher(o-&gt;ncp_ciphers, peer=
_info, tls_multi-&gt;remote_ciphername, &amp;o-&gt;gc);</span><br><span>   =
  if (push_cipher)</span><br><span>     {</span><br><span>@@ -1925,7 +1925,=
7 @@</span><br><span> static enum client_connect_return</span><br><span> cc=
s_test_deferred_ret_file(struct multi_instance *mi)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct client_connect_=
defer_state *ccs =3D &amp;(mi-&gt;client_connect_defer_state);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const struct client_connect_=
defer_state *ccs =3D &amp;(mi-&gt;client_connect_defer_state);</span><br><s=
pan>     FILE *fp =3D fopen(ccs-&gt;deferred_ret_file, &quot;r&quot;);</spa=
n><br><span>     if (!fp)</span><br><span>     {</span><br><span>@@ -2166,7=
 +2166,7 @@</span><br><span> {</span><br><span>     ASSERT(mi);</span><br><=
span>     ASSERT(option_types_found);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct client_connect_defer_state *ccs =3D &amp;(mi-&gt=
;client_connect_defer_state);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct client_connect_defer_state *ccs =3D &amp;(mi-&gt=
;client_connect_defer_state);</span><br><span>     enum client_connect_retu=
rn ret =3D CC_RET_SKIPPED;</span><br><span> </span><br><span>     ret =3D c=
cs_test_deferred_ret_file(mi);</span><br><span>@@ -2568,7 +2568,7 @@</span>=
<br><span> override_locked_username(struct multi_instance *mi)</span><br><s=
pan> {</span><br><span>     struct tls_multi *multi =3D mi-&gt;context=2Ec2=
=2Etls_multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct options *options =3D &amp;mi-&gt;context=2Eoptions;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct options *options =3D &a=
mp;mi-&gt;context=2Eoptions;</span><br><span>     struct tls_session *sessi=
on =3D &amp;multi-&gt;session[TM_ACTIVE];</span><br><span> </span><br><span=
>     if (!multi-&gt;locked_username)</span><br><span>@@ -2987,7 +2987,7 @@=
</span><br><span>     {</span><br><span> #if defined(ENABLE_ASYNC_PUSH)</sp=
an><br><span>         bool was_unauthenticated =3D true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        struct key_state *ks =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct =
key_state *ks =3D NULL;</span><br><span>         if (mi-&gt;context=2Ec2=2E=
tls_multi)</span><br><span>         {</span><br><span>             ks =3D &=
amp;mi-&gt;context=2Ec2=2Etls_multi-&gt;session[TM_ACTIVE]=2Ekey[KS_PRIMARY=
];</span><br><span>@@ -3104,7 +3104,7 @@</span><br><span>         struct mu=
lti_instance *ex_mi =3D (struct multi_instance *)he-&gt;value;</span><br><s=
pan> </span><br><span>         struct tls_multi *m1 =3D mi-&gt;context=2Ec2=
=2Etls_multi;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
struct tls_multi *m2 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const struct tls_multi *m2=
 =3D ex_mi-&gt;context=2Ec2=2Etls_multi;</span><br><span> </span><br><span>=
         /* do not float if target address is taken by client with another =
cert */</span><br><span>         if (!cert_hash_compare(m1-&gt;locked_cert_=
hash_set, m2-&gt;locked_cert_hash_set))</span><br><span>@@ -3877,7 +3877,7 =
@@</span><br><span> static int</span><br><span> management_callback_n_clien=
ts(void *arg)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    struct multi_context *m =3D (struct multi_context *)arg;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct multi_=
context *m =3D (struct multi_context *)arg;</span><br><span>     return m-&=
gt;n_clients;</span><br><span> }</span><br><span> </span><br><span>@@ -4388=
,7 +4388,7 @@</span><br><span> bool</span><br><span> multi_check_push_ifcon=
fig_extra_route(struct multi_instance *mi, in_addr_t dest)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct options =
*o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const struct options *o =3D &amp;mi-&gt;context=2Eopt=
ions;</span><br><span>     in_addr_t local_addr, local_netmask;</span><br><=
span> </span><br><span>     if (!o-&gt;ifconfig_local || !o-&gt;ifconfig_re=
mote_netmask)</span><br><span>@@ -4410,7 +4410,7 @@</span><br><span> multi_=
check_push_ifconfig_ipv6_extra_route(struct multi_instance *mi,</span><br><=
span>                                            struct in6_addr *dest)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    st=
ruct options *o =3D &amp;mi-&gt;context=2Eoptions;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const struct options *o =3D &amp;mi-&gt;=
context=2Eoptions;</span><br><span> </span><br><span>     if (!o-&gt;ifconf=
ig_ipv6_local || !o-&gt;ifconfig_ipv6_netbits)</span><br><span>     {</span=
><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/netw=
orking_sitnl=2Ec</span><br><span>index b3f8e2b=2E=2Ee6e72d0 100644</span><b=
r><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/op=
envpn/networking_sitnl=2Ec</span><br><span>@@ -462,7 +462,7 @@</span><br><s=
pan>     struct rtattr *rta =3D RTM_RTA(r);</span><br><span>     size_t len=
 =3D n-&gt;nlmsg_len - NLMSG_LENGTH(sizeof(*r));</span><br><span>     unsig=
ned int table, ifindex =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    void *gw =3D NULL;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const void *gw =3D NULL;</span><br><span> </span><br><span> =
    /* filter-out non-zero dst prefixes */</span><br><span>     if (res-&gt=
;default_only &amp;&amp; r-&gt;rtm_dst_len !=3D 0)</span><br><span>@@ -1179=
,7 +1179,7 @@</span><br><span> net_route_v4_add(openvpn_net_ctx_t *ctx, con=
st in_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span>    =
              const char *iface, uint32_t table, int metric)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in_addr_t *ds=
t_ptr =3D NULL, *gw_ptr =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;</spa=
n><br><span>     in_addr_t dst_be =3D 0, gw_be =3D 0;</span><br><span>     =
char dst_str[INET_ADDRSTRLEN];</span><br><span>     char gw_str[INET_ADDRST=
RLEN];</span><br><span>@@ -1326,7 +1326,7 @@</span><br><span> #if defined(E=
NABLE_DCO)</span><br><span>     if (arg &amp;&amp; (strcmp(type, OVPN_FAMIL=
Y_NAME) =3D=3D 0))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        dco_context_t *dco =3D arg;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const dco_context_t *dco =3D ar=
g;</span><br><span>         struct rtattr *data =3D SITNL_NEST(&amp;req=2En=
, sizeof(req), IFLA_INFO_DATA);</span><br><span> </span><br><span>         =
/* the netlink format is uint8_t for this and using something</span><br><sp=
an>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br=
><span>index 2b22b1d=2E=2E5451f86 100644</span><br><span>--- a/src/openvpn/=
options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@=
@ -1893,7 +1893,7 @@</span><br><span>         SHOW_INT(verify_hash_algo);</=
span><br><span>         SHOW_INT(verify_hash_depth);</span><br><span>      =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        struct verify_hash_list *hl =3D o-&gt;verify_hash;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct v=
erify_hash_list *hl =3D o-&gt;verify_hash;</span><br><span>         int dig=
est_len =3D</span><br><span>             (o-&gt;verify_hash_algo =3D=3D MD_=
SHA1) ? SHA_DIGEST_LENGTH : SHA256_DIGEST_LENGTH;</span><br><span>         =
while (hl)</span><br><span>@@ -2349,7 +2349,7 @@</span><br><span> </span><b=
r><span>     for (int i =3D 0; i &lt; ce-&gt;local_list-&gt;len; i++)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    struct local_entry *le =3D ce-&gt;local_list-&gt;array[i];</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const struct local_entry=
 *le =3D ce-&gt;local_list-&gt;array[i];</span><br><span> </span><br><span>=
         if (proto_is_net(le-&gt;proto) &amp;&amp; string_defined_equal(le-=
&gt;local, ce-&gt;remote)</span><br><span>             &amp;&amp; string_de=
fined_equal(le-&gt;port, ce-&gt;remote_port))</span><br><span>@@ -4014,7 +4=
014,7 @@</span><br><span>     {</span><br><span>         char *fullpath =3D=
</span><br><span>             string_alloc(file, NULL); /* POSIX dirname() =
implementation may modify its arguments */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        char *dirpath =3D dirname(fullpath);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const char *dirpath =
=3D dirname(fullpath);</span><br><span> </span><br><span>         if (platf=
orm_access(dirpath, mode | X_OK) !=3D 0)</span><br><span>         {</span><=
br><span>@@ -4245,7 +4245,7 @@</span><br><span>     ASSERT(options-&gt;conn=
ection_list);</span><br><span>     for (int i =3D 0; i &lt; options-&gt;con=
nection_list-&gt;len; ++i)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        struct connection_entry *ce =3D options=
-&gt;connection_list-&gt;array[i];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct connection_entry *ce =3D options-&gt;co=
nnection_list-&gt;array[i];</span><br><span> </span><br><span>         errs=
 |=3D check_file_access_inline(ce-&gt;tls_auth_file_inline, CHKACC_FILE | C=
HKACC_PRIVATE,</span><br><span>                                          ce=
-&gt;tls_auth_file, R_OK, &quot;--tls-auth&quot;);</span><br><span>@@ -9122=
,7 +9122,7 @@</span><br><span> #ifdef ENABLE_PKCS11</span><br><span>     el=
se if (streq(p[0], &quot;show-pkcs11-ids&quot;) &amp;&amp; !p[3])</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
char *provider =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        const char *provider =3D p[1];</span><br><span>         bool c=
ert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2], msglevel) !=3D=
 0));</span><br><span> </span><br><span> #ifdef DEFAULT_PKCS11_MODULE</span=
><br><span>diff --git a/src/openvpn/options_parse=2Ec b/src/openvpn/options=
_parse=2Ec</span><br><span>index a8c4aee=2E=2E88ab4d2 100644</span><br><spa=
n>--- a/src/openvpn/options_parse=2Ec</span><br><span>+++ b/src/openvpn/opt=
ions_parse=2Ec</span><br><span>@@ -268,7 +268,7 @@</span><br><span>     whi=
le (in_src_get(is, line, sizeof(line)))</span><br><span>     {</span><br><s=
pan>         (*num_lines)++;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        char *line_ptr =3D line;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const char *line_ptr =3D line;</span><br><span>=
         /* Remove leading spaces */</span><br><span>         while (isspac=
e(*line_ptr))</span><br><span>         {</span><br><span>diff --git a/src/o=
penvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</span><br><span>inde=
x d72ea25c=2E=2E779c38e 100644</span><br><span>--- a/src/openvpn/options_ut=
il=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@=
@ -273,7 +273,7 @@</span><br><span>         return true;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct pull_filter *f;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const struct pull_filter *f;</span><br><span> </span><br><span>=
     for (f =3D o-&gt;pull_filter_list-&gt;head; f; f =3D f-&gt;next)</span=
><br><span>     {</span><br><span>diff --git a/src/openvpn/pool=2Ec b/src/o=
penvpn/pool=2Ec</span><br><span>index ff74e7c=2E=2E80dec6c 100644</span><br=
><span>--- a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=2E=
c</span><br><span>@@ -63,7 +63,7 @@</span><br><span> </span><br><span>     =
for (i =3D 0; i &lt; pool-&gt;size; ++i)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        struct ifconfig_pool_entr=
y *ipe =3D &amp;pool-&gt;list[i];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const struct ifconfig_pool_entry *ipe =3D &amp;pool-&=
gt;list[i];</span><br><span>         if (!ipe-&gt;in_use)</span><br><span> =
        {</span><br><span>             /*</span><br><span>diff --git a/src/=
openvpn/proxy=2Ec b/src/openvpn/proxy=2Ec</span><br><span>index 9f3ec93=2E=
=2E4de7615 100644</span><br><span>--- a/src/openvpn/proxy=2Ec</span><br><sp=
an>+++ b/src/openvpn/proxy=2Ec</span><br><span>@@ -703,7 +703,7 @@</span><b=
r><span> #if PROXY_DIGEST_AUTH</span><br><span>         else if (p-&gt;auth=
_method =3D=3D HTTP_AUTH_DIGEST &amp;&amp; !processed)</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cha=
r *pa =3D p-&gt;proxy_authenticate;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            const char *pa =3D p-&gt;proxy_authenticate;</s=
pan><br><span>             const int method =3D p-&gt;auth_method;</span><b=
r><span>             ASSERT(pa);</span><br><span> </span><br><span>diff --g=
it a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 13c8=
936=2E=2E79f20e1 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><b=
r><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -271,8 +271,8 @@</spa=
n><br><span>     }</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><spa=
n>     struct tls_session *session =3D &amp;c-&gt;c2=2Etls_multi-&gt;sessio=
n[TM_ACTIVE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct man_def_auth_context *mda =3D session-&gt;opt-&gt;mda_context;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct env_set *es =3D sess=
ion-&gt;opt-&gt;es;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const struct man_def_auth_context *mda =3D session-&gt;opt-&gt;mda_cont=
ext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t env_set *es =3D session-&gt;opt-&gt;es;</span><br><span>     unsigned int=
 mda_key_id =3D get_primary_key(c-&gt;c2=2Etls_multi)-&gt;mda_key_id;</span=
><br><span> </span><br><span>     management_notify_client_cr_response(mda_=
key_id, mda, es, m);</span><br><span>@@ -918,7 +918,7 @@</span><br><span> p=
ush_options(struct options *o, char **p, msglvl_t msglevel, struct gc_arena=
 *gc)</span><br><span> {</span><br><span>     const char **argv =3D make_ex=
tended_arg_array(p, false, gc);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    char *opt =3D print_argv(argv, gc, 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *opt =3D print_argv(argv, =
gc, 0);</span><br><span>     push_option(o, opt, msglevel);</span><br><span=
> }</span><br><span> </span><br><span>@@ -1202,7 +1202,7 @@</span><br><span=
>                     /* parse route-ipv6 arguments */</span><br><span>    =
                 if (get_ipv6_addr(p[1], &amp;network, &amp;netbits, D_ROUT=
E_DEBUG))</span><br><span>                     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        struct iroute_ipv6 *ir;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    const struct iroute_ipv6 *ir;</span><br><span> </span><br><span>       =
                  /* does this route-ipv6 match an iroute-ipv6? */</span><b=
r><span>                         for (ir =3D o-&gt;iroutes_ipv6; ir !=3D NU=
LL; ir =3D ir-&gt;next)</span><br><span>diff --git a/src/openvpn/route=2Ec =
b/src/openvpn/route=2Ec</span><br><span>index 6dbe3ec=2E=2E03a2526 100644</=
span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvp=
n/route=2Ec</span><br><span>@@ -667,7 +667,7 @@</span><br><span> </span><br=
><span>     /* parse the routes from opt to rl */</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct route_opt=
ion *ro;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st struct route_option *ro;</span><br><span>         for (ro =3D opt-&gt;ro=
utes; ro; ro =3D ro-&gt;next)</span><br><span>         {</span><br><span>  =
           struct addrinfo *netlist =3D NULL;</span><br><span>@@ -679,7 +67=
9,7 @@</span><br><span>             }</span><br><span>             else</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                struct addrinfo *curele;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                const struct addrinfo *curele;</=
span><br><span>                 for (curele =3D netlist; curele; curele =3D=
 curele-&gt;ai_next)</span><br><span>                 {</span><br><span>   =
                  struct route_ipv4 *new;</span><br><span>@@ -799,7 +799,7 =
@@</span><br><span>     need_remote_ipv6_route =3D false;</span><br><span> =
</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct route_ipv6_option *ro6;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const struct route_ipv6_option *ro6;</span><br=
><span>         for (ro6 =3D opt6-&gt;routes_ipv6; ro6; ro6 =3D ro6-&gt;nex=
t)</span><br><span>         {</span><br><span>             struct route_ipv=
6 *r6;</span><br><span>@@ -1187,7 +1187,7 @@</span><br><span> {</span><br><=
span>     if (rl6 &amp;&amp; (rl6-&gt;iflags &amp; RL_ROUTES_ADDED))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct route_ipv6 *r6;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        const struct route_ipv6 *r6;</span><br><span>         for (r6=
 =3D rl6-&gt;routes_ipv6; r6; r6 =3D r6-&gt;next)</span><br><span>         =
{</span><br><span>             delete_route_ipv6(r6, tt, es, ctx);</span><b=
r><span>@@ -1226,7 +1226,7 @@</span><br><span> void</span><br><span> print_=
route_options(const struct route_option_list *rol, msglvl_t msglevel)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct route_option *ro;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct route_option *ro;</span><br><span>     if (rol-&gt;flags =
&amp; RG_ENABLE)</span><br><span>     {</span><br><span>         msg(msglev=
el, &quot;  [redirect_default_gateway local=3D%d]&quot;, (rol-&gt;flags &am=
p; RG_LOCAL) !=3D 0);</span><br><span>@@ -1335,7 +1335,7 @@</span><br><span=
> setenv_routes(struct env_set *es, const struct route_list *rl)</span><br>=
<span> {</span><br><span>     int i =3D 1;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    struct route_ipv4 *r;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const struct route_ipv4 *r;</span><br><span>=
     for (r =3D rl-&gt;routes; r; r =3D r-&gt;next)</span><br><span>     {<=
/span><br><span>         setenv_route(es, r, i++);</span><br><span>@@ -1372=
,7 +1372,7 @@</span><br><span> setenv_routes_ipv6(struct env_set *es, const=
 struct route_ipv6_list *rl6)</span><br><span> {</span><br><span>     int i=
 =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct rou=
te_ipv6 *r6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct route_ipv6 *r6;</span><br><span>     for (r6 =3D rl6-&gt;routes_i=
pv6; r6; r6 =3D r6-&gt;next)</span><br><span>     {</span><br><span>       =
  setenv_route_ipv6(es, r6, i++);</span><br><span>@@ -2423,7 +2423,7 @@</sp=
an><br><span>          */</span><br><span>         if (rl &amp;&amp; tt-&gt=
;did_ifconfig_setup)</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            struct route_ipv4 *r;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            const struct route_ipv4=
 *r;</span><br><span>             for (r =3D rl-&gt;routes, len =3D 0; r; r=
 =3D r-&gt;next, ++len)</span><br><span>             {</span><br><span>    =
             test_route_helper(&amp;ret, &amp;count, &amp;good, &amp;ambig,=
 adapters, r-&gt;gateway);</span><br><span>@@ -3110,7 +3110,8 @@</span><br>=
<span>     /* scan adapter list */</span><br><span>     if (rgi-&gt;flags &=
amp; RGI_ADDR_DEFINED)</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct ifreq *ifr, *ifend;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const struct ifreq *ifr;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct if=
req *ifend;</span><br><span>         in_addr_t addr, netmask;</span><br><sp=
an>         struct ifreq ifreq;</span><br><span>         struct ifconf ifc;=
</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=
=2Ec</span><br><span>index 47edbdb=2E=2E50126bf 100644</span><br><span>--- =
a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span=
><br><span>@@ -393,7 +393,7 @@</span><br><span> </span><br><span>          =
   for (int j =3D 0; j &lt; ce-&gt;local_list-&gt;len; j++)</span><br><span=
>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          struct local_entry *le =3D ce-&gt;local_list-&gt;array[j];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                const stru=
ct local_entry *le =3D ce-&gt;local_list-&gt;array[j];</span><br><span> </s=
pan><br><span>                 if (!le-&gt;local)</span><br><span>         =
        {</span><br><span>@@ -898,12 +898,10 @@</span><br><span>      * Wha=
t is the correct way to deal with it?</span><br><span>      */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct addri=
nfo *cur;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span>     ASSERT(local);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>     /* find the first addrinfo with =
correct ai_family */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct addrinfo *cur;</span><br><span>     for (cur =3D local; c=
ur; cur =3D cur-&gt;ai_next)</span><br><span>     {</span><br><span>       =
  if (cur-&gt;ai_family =3D=3D ai_family)</span><br><span>@@ -1490,7 +1488,=
7 @@</span><br><span>         /* Socket is always bound on the first matchi=
ng address,</span><br><span>          * For bound sockets with no remote ad=
dr this is the element of</span><br><span>          * the list */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        struct addrinfo *cur;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct =
addrinfo *cur;</span><br><span>         for (cur =3D sock-&gt;info=2Elsa-&g=
t;bind_local; cur; cur =3D cur-&gt;ai_next)</span><br><span>         {</spa=
n><br><span>             if (!ai_family || ai_family =3D=3D cur-&gt;ai_fami=
ly)</span><br><span>@@ -1621,7 +1619,7 @@</span><br><span> create_socket_dc=
o_win(struct context *c, struct link_socket *sock, struct signal_info *sig_=
info)</span><br><span> {</span><br><span>     /* in P2P mode we must have r=
emote resolved at this point */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct addrinfo *remoteaddr =3D sock-&gt;info=2Elsa-&gt;curre=
nt_remote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 struct addrinfo *remoteaddr =3D sock-&gt;info=2Elsa-&gt;current_remote;</s=
pan><br><span>     if ((c-&gt;options=2Emode =3D=3D MODE_POINT_TO_POINT) &a=
mp;&amp; (!remoteaddr))</span><br><span>     {</span><br><span>         ret=
urn;</span><br><span>@@ -1910,7 +1908,7 @@</span><br><span>                =
               const struct link_socket_actual *from_addr)</span><br><span>=
 {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    struct addrinfo *ai;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const struct addrinfo *ai;</spa=
n><br><span> </span><br><span>     switch (from_addr-&gt;dest=2Eaddr=2Esa=
=2Esa_family)</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/socket=2Eh b/src/openvpn/socket=2Eh</span><br><span>index 1a532e1=2E=2E8=
9465bc 100644</span><br><span>--- a/src/openvpn/socket=2Eh</span><br><span>=
+++ b/src/openvpn/socket=2Eh</span><br><span>@@ -761,7 +761,7 @@</span><br>=
<span> {</span><br><span>     if (sock &amp;&amp; ipbuf)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct op=
envpn_iphdr *iph =3D (struct openvpn_iphdr *)BPTR(ipbuf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        const struct openvpn_iphdr *i=
ph =3D (struct openvpn_iphdr *)BPTR(ipbuf);</span><br><span>         sock-&=
gt;ptos =3D iph-&gt;tos;</span><br><span>         sock-&gt;ptos_defined =3D=
 true;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 60df7ce=2E=2E7a7b3b4 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -1478,7 +1478,7 @@</span><br><span> static bo=
ol</span><br><span> generate_key_expansion(struct tls_multi *multi, struct =
key_state *ks, struct tls_session *session)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct key_ctx_bi *key =3D &am=
p;ks-&gt;crypto_options=2Ekey_ctx_bi;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const struct key_ctx_bi *key =3D &amp;ks-&gt;crypto_o=
ptions=2Ekey_ctx_bi;</span><br><span>     bool ret =3D false;</span><br><sp=
an>     struct key2 key2;</span><br><span> </span><br><span>@@ -1740,7 +174=
0,7 @@</span><br><span> static void</span><br><span> flush_payload_buffer(s=
truct key_state *ks)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct buffer *b;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct buffer *b;</span><br><span> </span><br=
><span>     while ((b =3D buffer_list_peek(ks-&gt;paybuf)))</span><br><span=
>     {</span><br><span>@@ -2719,7 +2719,7 @@</span><br><span>     /* Outgo=
ing Ciphertext to reliable buffer */</span><br><span>     if (ks-&gt;state =
&gt;=3D S_START)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct buffer *buf =3D reliable_get_buf_output_se=
quenced(ks-&gt;send_reliable);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const struct buffer *buf =3D reliable_get_buf_output_seq=
uenced(ks-&gt;send_reliable);</span><br><span>         if (buf)</span><br><=
span>         {</span><br><span>             if (!write_outgoing_tls_cipher=
text(session, continue_tls_process))</span><br><span>@@ -2788,7 +2788,7 @@<=
/span><br><span>     {</span><br><span>         int opcode;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buff=
er *buf =3D reliable_send(ks-&gt;send_reliable, &amp;opcode);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        const struct buffer *buf =
=3D reliable_send(ks-&gt;send_reliable, &amp;opcode);</span><br><span>     =
    ASSERT(buf);</span><br><span>         struct buffer b =3D *buf;</span><=
br><span>         INCR_SENT;</span><br><span>@@ -3151,7 +3151,7 @@</span><b=
r><span> static void</span><br><span> check_session_buf_not_used(struct buf=
fer *to_link, struct tls_session *session)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *dataptr =3D to_link-&g=
t;data;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ui=
nt8_t *dataptr =3D to_link-&gt;data;</span><br><span>     if (!dataptr)</sp=
an><br><span>     {</span><br><span>         return;</span><br><span>@@ -31=
73,7 +3173,7 @@</span><br><span> </span><br><span>     for (int i =3D 0; i =
&lt; KS_SIZE; i++)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        struct key_state *ks =3D &amp;session-&gt;key[i=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const str=
uct key_state *ks =3D &amp;session-&gt;key[i];</span><br><span>         if =
(ks-&gt;state =3D=3D S_UNDEF)</span><br><span>         {</span><br><span>  =
           continue;</span><br><span>@@ -3244,7 +3244,7 @@</span><br><span>=
     {</span><br><span>         struct tls_session *session =3D &amp;multi-=
&gt;session[i];</span><br><span>         struct key_state *ks =3D &amp;sess=
ion-&gt;key[KS_PRIMARY];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        struct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK]=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const stru=
ct key_state *ks_lame =3D &amp;session-&gt;key[KS_LAME_DUCK];</span><br><sp=
an> </span><br><span>         /* set initial remote address=2E This trigger=
s connecting with that</span><br><span>          * session=2E So we only do=
 that if the TM_ACTIVE session is not</span><br><span>@@ -3445,7 +3445,7 @@=
</span><br><span> </span><br><span>     for (int i =3D 0; i &lt; KEY_SCAN_S=
IZE; ++i)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct key_state *ks =3D get_key_scan(multi, i);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct key_st=
ate *ks =3D get_key_scan(multi, i);</span><br><span>         if (ks-&gt;key=
_id !=3D key_id)</span><br><span>         {</span><br><span>             co=
ntinue;</span><br><span>@@ -3996,7 +3996,7 @@</span><br><span> void</span><=
br><span> tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffe=
r *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct key_state *ks =3D multi-&gt;save_ks;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct key_state *ks =3D multi-=
&gt;save_ks;</span><br><span> </span><br><span>     msg(D_TLS_DEBUG, __func=
__);</span><br><span> </span><br><span>@@ -4010,7 +4010,7 @@</span><br><spa=
n> void</span><br><span> tls_prepend_opcode_v2(const struct tls_multi *mult=
i, struct buffer *buf)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    struct key_state *ks =3D multi-&gt;save_ks;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct key_state =
*ks =3D multi-&gt;save_ks;</span><br><span>     uint32_t peer;</span><br><s=
pan> </span><br><span>     msg(D_TLS_DEBUG, __func__);</span><br><span>diff=
 --git a/src/openvpn/ssl_mbedtls=2Ec b/src/openvpn/ssl_mbedtls=2Ec</span><b=
r><span>index 07caf08=2E=2Ed5c9e5c 100644</span><br><span>--- a/src/openvpn=
/ssl_mbedtls=2Ec</span><br><span>+++ b/src/openvpn/ssl_mbedtls=2Ec</span><b=
r><span>@@ -301,7 +301,7 @@</span><br><span> void</span><br><span> tls_ctx_=
restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *tmp_=
ciphers, *tmp_ciphers_orig, *token;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    char *tmp_ciphers, *tmp_ciphers_orig;</span><br><span> =
</span><br><span>     if (NULL =3D=3D ciphers)</span><br><span>     {</span=
><br><span>@@ -745,7 +745,7 @@</span><br><span> static inline size_t</span>=
<br><span> external_key_len(void *vctx)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct external_context *const ctx=
 =3D vctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 struct external_context *const ctx =3D vctx;</span><br><span> </span><br><=
span>     return ctx-&gt;signature_length;</span><br><span> }</span><br><sp=
an>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec</sp=
an><br><span>index 162f68f=2E=2E063fa5d 100644</span><br><span>--- a/src/op=
envpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=2Ec</span=
><br><span>@@ -409,7 +409,7 @@</span><br><span>                     const c=
har *subject, const struct x509_track *x509_track)</span><br><span> {</span=
><br><span>     char envname[64];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    char *serial =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *serial =3D NULL;</span><br><span>     st=
ruct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     /* Sa=
ve X509 fields in environment */</span><br><span>@@ -699,7 +699,7 @@</span>=
<br><span>                 goto cleanup;</span><br><span>         }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        str=
uct verify_hash_list *current_hash =3D opt-&gt;verify_hash;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        const struct verify_hash_li=
st *current_hash =3D opt-&gt;verify_hash;</span><br><span> </span><br><span=
>         while (current_hash)</span><br><span>         {</span><br><span>@=
@ -1532,7 +1532,7 @@</span><br><span> verify_user_pass_management(struct tl=
s_session *session, const struct user_pass *up)</span><br><span> {</span><b=
r><span>     int retval =3D KMDA_ERROR;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct key_state *ks =3D &amp;session-&gt;key[KS_PRIM=
ARY]; /* primary key */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /*=
 primary key */</span><br><span> </span><br><span>     /* set username/pass=
word in private env space */</span><br><span>     setenv_str(session-&gt;op=
t-&gt;es, &quot;password&quot;, up-&gt;password);</span><br><span>diff --gi=
t a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index e7193d8=
=2E=2Ebc262cd 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><s=
pan>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -871,7 +871,7 @@</span><br=
><span>          */</span><br><span>         if (strict_warn)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    struct addrinfo *curele;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            const struct addrinfo *curele;</span><br><span>       =
      ifconfig_sanity_check(tun_p2p, tt-&gt;remote_netmask);</span><br><spa=
n> </span><br><span>             /*</span><br><span>@@ -1735,7 +1735,7 @@</=
span><br><span>     {</span><br><span>         u_int32_t type;</span><br><s=
pan>         struct iovec iv[2];</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct ip *iph =3D (struct ip *)buf;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        const struct ip *iph =3D (struc=
t ip *)buf;</span><br><span> </span><br><span>         if (iph-&gt;ip_v =3D=
=3D 6)</span><br><span>         {</span><br><span>@@ -3423,7 +3423,7 @@</sp=
an><br><span>         SP_DEVINFO_DATA device_info_data;</span><br><span>   =
      BOOL res;</span><br><span>         HKEY dev_key;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        char net_cfg_instance_id_string[] =
=3D &quot;NetCfgInstanceId&quot;;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const char net_cfg_instance_id_string[] =3D &quot;Net=
CfgInstanceId&quot;;</span><br><span>         BYTE net_cfg_instance_id[256]=
;</span><br><span>         char device_instance_id[256];</span><br><span>  =
       DWORD len;</span><br><span>@@ -3551,7 +3551,7 @@</span><br><span>   =
      HKEY unit_key;</span><br><span>         char component_id_string[] =
=3D &quot;ComponentId&quot;;</span><br><span>         char component_id[256=
];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char net_cf=
g_instance_id_string[] =3D &quot;NetCfgInstanceId&quot;;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        const char net_cfg_instance_id=
_string[] =3D &quot;NetCfgInstanceId&quot;;</span><br><span>         BYTE n=
et_cfg_instance_id[256];</span><br><span>         DWORD data_type;</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/win32=2Ec b/src/openvpn/=
win32=2Ec</span><br><span>index ade7ec0=2E=2E81437c1 100644</span><br><span=
>--- a/src/openvpn/win32=2Ec</span><br><span>+++ b/src/openvpn/win32=2Ec</s=
pan><br><span>@@ -889,7 +889,7 @@</span><br><span> </span><br><span>     if=
 (es)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        struct env_item *e;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const struct env_item *e;</span><br><span>         c=
har *ret;</span><br><span>         char *p;</span><br><span>         size_t=
 nchars =3D 1;</span><br><span>diff --git a/src/openvpnmsica/msica_arg=2Ec =
b/src/openvpnmsica/msica_arg=2Ec</span><br><span>index a334710=2E=2Ed763d93=
 100644</span><br><span>--- a/src/openvpnmsica/msica_arg=2Ec</span><br><spa=
n>+++ b/src/openvpnmsica/msica_arg=2Ec</span><br><span>@@ -92,7 +92,7 @@</s=
pan><br><span> {</span><br><span>     /* Count required space=2E */</span><=
br><span>     size_t size =3D 2 /*x + zero-terminator*/;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    for (struct msica_arg *p =3D seq-&gt=
;head; p !=3D NULL; p =3D p-&gt;next)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (const struct msica_arg *p =3D seq-&gt;head; p !=
=3D NULL; p =3D p-&gt;next)</span><br><span>     {</span><br><span>        =
 size +=3D wcslen(p-&gt;val) + 1 /*space delimiter|zero-terminator*/;</span=
><br><span>     }</span><br><span>@@ -119,7 +119,7 @@</span><br><span> </sp=
an><br><span>     /* Join=2E */</span><br><span>     LPWSTR s =3D str + 1 /=
*x*/;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (struct =
msica_arg *p =3D seq-&gt;head; p !=3D NULL; p =3D p-&gt;next)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (const struct msica_arg *=
p =3D seq-&gt;head; p !=3D NULL; p =3D p-&gt;next)</span><br><span>     {</=
span><br><span>         /* Convert zero-terminator into space delimiter=2E =
*/</span><br><span>         s[0] =3D L&#39; &#39;;</span><br><span>diff --g=
it a/src/openvpnmsica/openvpnmsica=2Ec b/src/openvpnmsica/openvpnmsica=2Ec<=
/span><br><span>index 95e457c=2E=2Ea861e8a 100644</span><br><span>--- a/src=
/openvpnmsica/openvpnmsica=2Ec</span><br><span>+++ b/src/openvpnmsica/openv=
pnmsica=2Ec</span><br><span>@@ -196,7 +196,7 @@</span><br><span> </span><br=
><span>     /* Count adapters=2E */</span><br><span>     size_t adapter_cou=
nt =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (str=
uct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; pAdapter =3D pAd=
apter-&gt;pNext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (const struct tap_adapter_node *pAdapter =3D pAdapterList; pAdapter; p=
Adapter =3D pAdapter-&gt;pNext)</span><br><span>     {</span><br><span>    =
     adapter_count++;</span><br><span>     }</span><br><span>diff --git a/s=
rc/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br>=
<span>index 32c1b9c=2E=2Ea9e9665 100644</span><br><span>--- a/src/openvpnse=
rv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</s=
pan><br><span>@@ -2685,7 +2685,7 @@</span><br><span>     unsigned n =3D 0;<=
/span><br><span>     for (size_t i =3D 0; i &lt; _countof(data); ++i)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    nrpt_exclude_data_t *d =3D &amp;data[i];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const nrpt_exclude_data_t *d =3D &amp;data=
[i];</span><br><span>         if (d-&gt;domains_size =3D=3D 0)</span><br><s=
pan>         {</span><br><span>             break;</span><br><span>diff --g=
it a/src/plugins/auth-pam/auth-pam=2Ec b/src/plugins/auth-pam/auth-pam=2Ec<=
/span><br><span>index 3b7bcc2=2E=2E948b6af 100644</span><br><span>--- a/src=
/plugins/auth-pam/auth-pam=2Ec</span><br><span>+++ b/src/plugins/auth-pam/a=
uth-pam=2Ec</span><br><span>@@ -526,7 +526,7 @@</span><br><span> openvpn_pl=
ugin_func_v1(openvpn_plugin_handle_t handle, const int type, const char *ar=
gv[],</span><br><span>                        const char *envp[])</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct a=
uth_pam_context *context =3D (struct auth_pam_context *)handle;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const struct auth_pam_conte=
xt *context =3D (struct auth_pam_context *)handle;</span><br><span> </span>=
<br><span>     if (type =3D=3D OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY &amp;&a=
mp; context-&gt;foreground_fd &gt;=3D 0)</span><br><span>     {</span><br><=
span>diff --git a/src/tapctl/main=2Ec b/src/tapctl/main=2Ec</span><br><span=
>index 6a4a240=2E=2E6697d14 100644</span><br><span>--- a/src/tapctl/main=2E=
c</span><br><span>+++ b/src/tapctl/main=2Ec</span><br><span>@@ -317,7 +317,=
7 @@</span><br><span>             return NULL;</span><br><span>         }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   struct tap_adapter_node *conflict =3D find_adapter_by_name(requested_nam=
e, adapter_list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const struct tap_adapter_node *conflict =3D find_adapter_by_name(requ=
ested_name, adapter_list);</span><br><span>         if (conflict)</span><br=
><span>         {</span><br><span>             LPOLESTR adapter_id =3D NULL=
;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer=2Ec b/t=
ests/unit_tests/openvpn/test_buffer=2Ec</span><br><span>index 326de40=2E=2E=
ce38bbe 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer=2Ec</span><=
br><span>@@ -88,7 +88,7 @@</span><br><span> </span><br><span>     int maxou=
tput =3D 0;</span><br><span>     unsigned int blocksize =3D 5;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    char *separator =3D &quot; &qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*separator =3D &quot; &quot;;</span><br><span>     output =3D format_hex_ex=
(input, input_size, maxoutput, blocksize, separator, &amp;gc);</span><br><s=
pan>     assert_string_equal(output, &quot;0100ff10ff 00f00f090a&quot;);</s=
pan><br><span> </span><br><span>@@ -174,7 +174,7 @@</span><br><span>     /*=
 With a max length of 2, no aggregation should take place */</span><br><spa=
n>     buffer_list_aggregate_separator(ctx-&gt;one_two_three, 2, testsep);<=
/span><br><span>     assert_int_equal(ctx-&gt;one_two_three-&gt;size, 3);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =
=3D buffer_list_peek(ctx-&gt;one_two_three);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(=
ctx-&gt;one_two_three);</span><br><span>     assert_buf_equals_str(buf, tes=
tstr1);</span><br><span> }</span><br><span> </span><br><span>@@ -189,7 +189=
,7 @@</span><br><span>      */</span><br><span>     buffer_list_aggregate_s=
eparator(ctx-&gt;one_two_three, strlen(expected) + 1, testsep);</span><br><=
span>     assert_int_equal(ctx-&gt;one_two_three-&gt;size, 2);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer_=
list_peek(ctx-&gt;one_two_three);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(ctx-&gt;one=
_two_three);</span><br><span>     assert_buf_equals_str(buf, expected);</sp=
an><br><span> }</span><br><span> </span><br><span>@@ -201,7 +201,7 @@</span=
><br><span>     /* Aggregate all */</span><br><span>     buffer_list_aggreg=
ate_separator(ctx-&gt;one_two_three, 1 &lt;&lt; 16, testsep);</span><br><sp=
an>     assert_int_equal(ctx-&gt;one_two_three-&gt;size, 1);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D buffer_li=
st_peek(ctx-&gt;one_two_three);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_t=
wo_three);</span><br><span>     assert_buf_equals_str(buf, teststr1 testsep=
 teststr2 testsep teststr3 testsep);</span><br><span> }</span><br><span> </=
span><br><span>@@ -213,7 +213,7 @@</span><br><span>     /* Aggregate all */=
</span><br><span>     buffer_list_aggregate_separator(ctx-&gt;one_two_three=
, 1 &lt;&lt; 16, testnosep);</span><br><span>     assert_int_equal(ctx-&gt;=
one_two_three-&gt;size, 1);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct buffer *buf =3D buffer_list_peek(ctx-&gt;one_two_three);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct buff=
er *buf =3D buffer_list_peek(ctx-&gt;one_two_three);</span><br><span>     a=
ssert_buf_equals_str(buf, teststr1 teststr2 teststr3);</span><br><span> }</=
span><br><span> </span><br><span>@@ -226,7 +226,7 @@</span><br><span>     /=
* Aggregate all */</span><br><span>     buffer_list_aggregate_separator(bl_=
zerolen, 1 &lt;&lt; 16, testnosep);</span><br><span>     assert_int_equal(b=
l_zerolen-&gt;size, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct buffer *buf =3D buffer_list_peek(bl_zerolen);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct buffer *buf =3D buf=
fer_list_peek(bl_zerolen);</span><br><span>     assert_buf_equals_str(buf, =
&quot;&quot;);</span><br><span> }</span><br><span> </span><br><span>@@ -239=
,7 +239,7 @@</span><br><span>     /* Aggregate all */</span><br><span>     =
buffer_list_aggregate_separator(bl_emptybuffers, 1 &lt;&lt; 16, testnosep);=
</span><br><span>     assert_int_equal(bl_emptybuffers-&gt;size, 1);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer *buf =3D b=
uffer_list_peek(bl_emptybuffers);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const struct buffer *buf =3D buffer_list_peek(bl_emptybuf=
fers);</span><br><span>     assert_int_equal(BLEN(buf), 0);</span><br><span=
> }</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_crypto=2Ec b/tests/unit_tests/openvpn/test_crypto=2Ec</span><br><span=
>index cb4eaa2=2E=2E8393e1c 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/test_crypto=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
crypto=2Ec</span><br><span>@@ -479,9 +479,9 @@</span><br><span> crypto_test=
_hkdf_expand_testa1(void **state)</span><br><span> {</span><br><span>     /=
* RFC 5889 A=2E1 Test Case 1 */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x3=
2, 0xdf, 0x0d, 0xdc, 0x3f,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7=
, 0x3b, 0xb5, 0x0f,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3,=
 0xe5 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0xdf, 0x0d, =
0xdc, 0x3f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                      0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, 0xc7, 0x3b,=
 0xb5, 0x0f,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                       0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, 0xc2, 0xb3=
, 0xe5 };</span><br><span> </span><br><span>     uint8_t info[10] =3D { 0xf=
0, 0xf1, 0xf2, 0xf3, 0xf4, 0xf5, 0xf6, 0xf7, 0xf8, 0xf9 };</span><br><span>=
 </span><br><span>@@ -500,9 +500,9 @@</span><br><span> crypto_test_hkdf_exp=
and_testa2(void **state)</span><br><span> {</span><br><span>     /* RFC 588=
9 A=2E2 Test Case 2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint8_t prk[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, =
0x06, 0x10, 0x4c,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0=
x90, 0x46,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t pr=
k[32] =3D { 0x06, 0xa6, 0xb8, 0x8c, 0x58, 0x53, 0x36, 0x1a, 0x06, 0x10, 0x4=
c,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
             0x9c, 0xeb, 0x35, 0xb4, 0x5c, 0xef, 0x76, 0x00, 0x14, 0x90, 0x=
46,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
              0x71, 0x01, 0x4a, 0x19, 0x3f, 0x40, 0xc1, 0x5f, 0xc2, 0x44 };=
</span><br><span> </span><br><span>     uint8_t info[80] =3D { 0xb0, 0xb1, =
0xb2, 0xb3, 0xb4, 0xb5, 0xb6, 0xb7, 0xb8, 0xb9, 0xba, 0xbb,</span><br><span=
>                          0xbc, 0xbd, 0xbe, 0xbf, 0xc0, 0xc1, 0xc2, 0xc3, =
0xc4, 0xc5, 0xc6, 0xc7,</span><br><span>@@ -531,11 +531,11 @@</span><br><sp=
an> crypto_test_hkdf_expand_testa3(void **state)</span><br><span> {</span><=
br><span>     /* RFC 5889 A=2E3 Test Case 3 */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, =
0x2c, 0x71, 0x7b, 0x16, 0x7f, 0x33, 0xa9,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0=
x96, 0x59, 0x67, 0x76, 0xaf, 0xdb,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0x=
29, 0x3c, 0xcb, 0x04 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const uint8_t prk[32] =3D { 0x19, 0xef, 0x24, 0xa3, 0x2c, 0x71, 0x7=
b, 0x16, 0x7f, 0x33, 0xa9,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                              0x1d, 0x6f, 0x64, 0x8b, 0xdf, 0x96, 0x=
59, 0x67, 0x76, 0xaf, 0xdb,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                              0x63, 0x77, 0xac, 0x43, 0x4c, 0x1c, 0=
x29, 0x3c, 0xcb, 0x04 };</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint8_t info[] =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const uint8_t info[] =3D { 0 };</span><b=
r><span> </span><br><span>     int L =3D 42;</span><br><span>     uint8_t o=
km[42] =3D { 0x8d, 0xa4, 0xe7, 0x75, 0xa5, 0x63, 0xc1, 0x8f, 0x71, 0x5f, 0x=
80,</span><br><span>@@ -555,9 +555,9 @@</span><br><span>     /* tests the H=
DKF with a label/okm that OpenVPN itself uses in OpenSSL 3</span><br><span>=
      * HDKF unit test*/</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c=
, 0x2e, 0x32, 0xdf, 0x0d, 0xdc, 0x3f,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90,=
 0xb6, 0xc7, 0x3b, 0xb5, 0x0f,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                        0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7, =
0xc2, 0xb3, 0xe5 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const uint8_t prk[32] =3D { 0x07, 0x77, 0x09, 0x36, 0x2c, 0x2e, 0x32, 0=
xdf, 0x0d, 0xdc, 0x3f,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                              0x0d, 0xc4, 0x7b, 0xba, 0x63, 0x90, 0xb6, =
0xc7, 0x3b, 0xb5, 0x0f,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                              0x9c, 0x31, 0x22, 0xec, 0x84, 0x4a, 0xd7,=
 0xc2, 0xb3, 0xe5 };</span><br><span> </span><br><span>     uint8_t info[18=
] =3D { 0x00, 0x1b, 0x0e, 0x6f, 0x76, 0x70, 0x6e, 0x20, 0x75,</span><br><sp=
an>                          0x6e, 0x69, 0x74, 0x20, 0x74, 0x65, 0x73, 0x74=
, 0x00 };</span><br><span>@@ -677,7 +677,7 @@</span><br><span> static int</=
span><br><span> crypto_test_epoch_setup(void **state)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint16_t *num_future=
_keys =3D (uint16_t *)*state;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint16_t *num_future_keys =3D (uint16_t *)*state;</span=
><br><span>     struct epoch_test_state *data =3D calloc(1, sizeof(struct e=
poch_test_state));</span><br><span> </span><br><span>     data-&gt;gc =3D g=
c_new();</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoa=
pi=2Ec b/tests/unit_tests/openvpn/test_cryptoapi=2Ec</span><br><span>index =
508afc9=2E=2E37bbe92 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_cryptoapi=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryp=
toapi=2Ec</span><br><span>@@ -233,7 +233,7 @@</span><br><span>         cons=
t CERT_CONTEXT *ctx =3D NULL;</span><br><span>         while ((ctx =3D Cert=
EnumCertificatesInStore(user_store, ctx)))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            char *friendly_=
name =3D get_cert_name(ctx, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            const char *friendly_name =3D get_cert_name(c=
tx, &amp;gc);</span><br><span>             if (!lookup_cert(friendly_name))=
 /* not our cert */</span><br><span>             {</span><br><span>        =
         continue;</span><br><span>@@ -310,7 +310,7 @@</span><br><span>    =
      */</span><br><span>         assert_non_null(ctx);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char *friendly_=
name =3D get_cert_name(ctx, &amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const char *friendly_name =3D get_cert_name(ctx, =
&amp;gc);</span><br><span>         struct test_cert *found =3D lookup_cert(=
friendly_name);</span><br><span>         assert_non_null(found);</span><br>=
<span>         assert_string_equal(found-&gt;cname, c-&gt;cname);</span><br=
><span>@@ -343,7 +343,7 @@</span><br><span>          */</span><br><span>   =
      assert_non_null(ctx);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        char *friendly_name =3D get_cert_name(ctx, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst char *friendly_name =3D get_cert_name(ctx, &amp;gc);</span><br><span>  =
       struct test_cert *found =3D lookup_cert(friendly_name);</span><br><s=
pan>         assert_non_null(found);</span><br><span>         assert_string=
_equal(found-&gt;issuer, c-&gt;issuer);</span><br><span>diff --git a/tests/=
unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</=
span><br><span>index fc9840a=2E=2Ee1b03dd 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_misc=2Ec</span><br><span>@@ -304,7 +304,7 @@</span><br><span>  =
   {</span><br><span>         for (ptr_type i =3D 1; i &lt;=3D 16; ++i)</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            struct hash_element *item =3D hash_lookup_by_value(nhash, (vo=
id *)i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 const struct hash_element *item =3D hash_lookup_by_value(nhash, (void *)i)=
;</span><br><span>             hash_remove_by_value(nhash, (void *)i);</spa=
n><br><span>             /* check item got removed if it was present before=
 */</span><br><span>             if (item)</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec<=
/span><br><span>index cad2ce0=2E=2Edf9fed7 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_pkt=2Ec</span><br><span>@@ -567,7 +567,7 @@</span><br><span>   =
  ASSERT(md_valid(&quot;SHA256&quot;));</span><br><span>     hmac_ctx_t *hm=
ac_ctx =3D hmac_ctx_new();</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    uint8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3,=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint=
8_t key[SHA256_DIGEST_LENGTH] =3D { 1, 2, 3, 0 };</span><br><span> </span><=
br><span>     hmac_ctx_init(hmac_ctx, key, &quot;SHA256&quot;);</span><br><=
span>     return hmac_ctx;</span><br><span>diff --git a/tests/unit_tests/op=
envpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>=
index afadd31=2E=2E1966dab 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_ssl=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl=
=2Ec</span><br><span>@@ -683,7 +683,7 @@</span><br><span>     openvpn_encry=
pt(&amp;buf, encrypt_workspace, &amp;co);</span><br><span> </span><br><span=
>     /* separate buffer in authenticated data and encrypted data */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *ad_start =3D BP=
TR(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst uint8_t *ad_start =3D BPTR(&amp;buf);</span><br><span>     buf_advance(=
&amp;buf, 4);</span><br><span> </span><br><span>     if (epoch)</span><br><=
span>diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace=
=2Ec b/tests/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec</span>=
<br><span>index a861bfd=2E=2E89f0642 100644</span><br><span>--- a/tests/uni=
t_tests/plugins/auth-pam/test_search_and_replace=2Ec</span><br><span>+++ b/=
tests/unit_tests/plugins/auth-pam/test_search_and_replace=2Ec</span><br><sp=
an>@@ -12,7 +12,7 @@</span><br><span> static void</span><br><span> pass_any=
_null_param__returns_null(void **state)</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    char DUMMY[] =3D &quot;DUMMY&quot;=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char DUM=
MY[] =3D &quot;DUMMY&quot;;</span><br><span> </span><br><span>     assert_n=
ull(searchandreplace(NULL, DUMMY, DUMMY));</span><br><span>     assert_null=
(searchandreplace(DUMMY, NULL, DUMMY));</span><br><span>@@ -22,8 +22,8 @@</=
span><br><span> static void</span><br><span> pass_any_empty_string__returns=
_null(void **state)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    char DUMMY[] =3D &quot;DUMMY&quot;;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    char EMPTY[] =3D &quot;&quot;;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char DUMMY[] =
=3D &quot;DUMMY&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char EMPTY[] =3D &quot;&quot;;</span><br><span> </span><br><sp=
an>     assert_null(searchandreplace(EMPTY, DUMMY, DUMMY));</span><br><span=
>     assert_null(searchandreplace(DUMMY, EMPTY, DUMMY));</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1661?usp=3Demail">change 1661</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1661?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326=
ed140f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1661 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-de=
vel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>

</body></html>
--TMBGNhBVMbM=--


--===============8804155321862256572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8804155321862256572==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8804155321862256572==--

