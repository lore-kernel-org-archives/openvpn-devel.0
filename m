Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55548606A321
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bHxsyTbG;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KDj+pj19;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mtXJnCaO;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FOmDgFI0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=h4yWYZDRAbfNIoz1f+QMU/iXomsAwXdfWYbOvogui9I=; b=bHxsyTbGC49F2WDXrmkP8cIGsA
	dMijFf06TDkR5GZYEx8SV0fVtMQ0PsfG/+i9rRtipCyguSCxpRA7QPlot4D/Krh4x9JuGmwR9/bjf
	JVqf6FYCoK9fxsV0uo9A4b9KLesKk3rhvmPEgdYdtsQh8F2+tBKyHv+oqAb7x6bq+lCc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWFEO-000000001CJ-1lCc;
	Wed, 25 Nov 2026 15:48:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWFEM-000000001C5-1gEB
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 15:48:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PO/imUIXam3n2aEPzzhVm/IRBiJG+7tOVnroJNMbc80=; b=KDj+pj19hauWu9+QjUTBZ+9OB3
 AD9a7GrnQnNmsolQuJpVJed6iqG69rpSTHekFm0oYrbOU6R+aunFysG2YLGKwBxKdLMVFXUDAqJey
 QCOp/ZAodBja0n4iWn9qS7EjzLRafXljhR7WyeecEeyh9+0yXp+knWWt7Cy5crsv+HNU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PO/imUIXam3n2aEPzzhVm/IRBiJG+7tOVnroJNMbc80=; b=mtXJnCaOdzj5YLgSEtkyTmfTOa
 twP0LcWyMEhFmHVCBW0XcC+u+htR1Unxjmw/G0X82Q6PFtZ9W8cWOWSTdDZh1m8Nkwr2b6BGMiQRL
 GU6T3G4a5oByeD/dDvcJYIxeUoG8KFw0iNMYTscaPUmiGRCdiecIEAs8va9s4LF/1E0Q=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWFEK-000000003Us-1nf1 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 15:48:22 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so54404585e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 07:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795621694; x=1796226494; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=PO/imUIXam3n2aEPzzhVm/IRBiJG+7tOVnroJNMbc80=;
 b=FOmDgFI0H+42hMRCi4n0pOiyGgUrNWzt2/PklO27Mxfj5yhaIW5pGkutdAWyYAFdpD
 K/+sWFyPBPM54aCAQLVOtH0LuNzbC/k7uDmmb7oXD4d6iKm70veoyqxyyCN4ia1T7vM6
 8LGNP9u1JkQpVBGlOl6kbEq8qfGs3JpRuRFa6cnMHYOf80LBo+GrZKU1FK268w8O6duC
 rqE9Tx1gUyC8A4m2tDyY0TEeo/Vrmuc5gxtjNUNIt+W/0F0Lz6N/95TyE/GYM24FhBQz
 kVMYQbWrm0R4TeVBtgy1pg5fvkAvklAYAj6G077IVXAVM/49LsizeYYBiRT0jpniRAqM
 Qz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795621694; x=1796226494;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PO/imUIXam3n2aEPzzhVm/IRBiJG+7tOVnroJNMbc80=;
 b=S7LuF+sB1K4sSanUC0nExv7MLroUWcHkFXbiv7Kg+DyjpJ6D2s/enEwgitfA9zCIXi
 F5RNl8jGGJ99iBHjh6tAd8GR7+3PymIdGXyIrrDI6CV1yqyxnpCaBqPVcis6C9Y5Bw8i
 d/urLTgmsyAjR63LxifUWLuvgCECLEJ4K258edb8pwGdX033niC8QoyVwPsMBzM5S8V2
 2sdy5+QQOM/ZX0dfpV20wFOGlbFPk1fNibejyvpuh1opBo4Lj+VeDTu5hxa94IENWZyU
 ThThtNWAvICzggoc7AV49CTRjH4CQEe926h5CIBa2pAJw26x++jN7w8R0pNmwt9GMoq5
 34+A==
X-Gm-Message-State: APuU4Z+tzxjwbItkN/J40HjoxX8QD0OSV/Inl4yNMzZtLLYSC/9GdlXm
 Aun+GTPPK4Ntky2Jm6dKDKcIViK38gZgL6nk/pXlDPVCFpl56++i0vnylq+Go/O34tWkyrHaEgo
 2IBbSBxd6YAUZhFvOMZPQ/DnN+k1SAJUMqaWuFd3PKVYunOwaV3W9BXHDBfRoUbYVS74xtGbXwz
 AIPzAt3g==
X-Gm-Gg: AZFdTZf0n1ziupCKDNoMACyTswPbl4Gbxwmag5jWYInntN2L1nwG7JbkSsUAhdOyqov
 QJa2T9X8/0+ivBQs56fxFlrKXhFwXfl5VmYPaIXhXXmeIP7VfthkAbsJgcCIrwBdYxCm4Q5xeac
 klDfM4mGFc3msHu4ZBBf+Z4ZLx2WdLG4gAivusuMc3TOiDWrEuYF8OULhnoa15TdVz7HpELRpF3
 BhT87FSbV+r+sYKBFI4HqLS25r4nac+nBMst8lmR0tPJAk01xH0+NQuilfRFKDNqAs+/IOAm3Fq
 YGFpkXQs6Prjp46n+usiUSlhoJUJ4KLQFJUCYJ+B+gVcGP0EjiFWtJyok0oBx9mQCNgo9MvEn2d
 GZXTEUZJ0B+3C2wAwwd+QHenwV5ff1/4r8DpZT606E7dBjfDjzeGISCD01CUx9ux1oEzHC4NE77
 sCmrcZsQyXsCmHJxj7sXwlGxaIGac50IabLtprC+wM5wI6cdz1YRheBXre/9E/pwpIqmjM/Y8gD
 difdNvQ1OrBrOeqoTV032GOk2cMz3NMZIIRUfbOWRmailbTuvaSmbMzBSAwd4eeEJkDwOkzDVRO
 otc/t1foHzo1zjrvDRIhZw3xdW1IHOUYv+NljKpzl2LJn9sw97XdzPx7USPze7K9iH74COhGMva
 Mk+loGJWy73cH2U/4GFalHhBIuwNPHBOsALNip+8LwxLUay7PgW7jU1OEa9C8gPxpDd9N1h8TY2
 wliXkyeqAiA9ny6k4=
X-Received: by 2002:a05:600c:6749:b0:4a2:1867:10e8 with SMTP id
 5b1f17b1804b1-4bb8881a294mr364664335e9.25.1795621692902; 
 Wed, 25 Nov 2026 07:48:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf685asm34899682f8f.20.2026.11.25.07.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 07:48:12 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 15:48:12 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
X-Gerrit-Change-Number: 2344
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2344?usp=email>
X-Gerrit-Commit: 4fc1c66f83e58e5cdafe2d7af2bb02e28bd97bb7
References: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjIxNjkwMDAwLkkwZjY1OWViMjA0NDFlZGQ0MTFlYzEzZjRkMDlmNDM0MTQxYjJkYTMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <379fa977768175044f891e0876c5b780d16890a0-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWFEK-000000003Us-1nf1
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: remove dead
 code
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
Content-Type: multipart/mixed; boundary="===============0798972847731383842=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0798972847731383842==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="80jJvFRXlFk="; charset=UTF-8

--80jJvFRXlFk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2344?usp=3Demail

to review the following change=2E
=


Change subject: push: remove dead code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: remove dead code

- push_option_ex(): dr=
op the "enable" parameter; it was ignored and
  every caller passed true=2E=

- push_remove_option(): drop the NULL check on o, already dereferenced
  b=
y the ifconfig/ifconfig-ipv6 checks above it=2E
- receive_auth_failed(): dr=
op a repeated no_advance =3D true and a BLEN()
  check implied by the prece=
ding "CRV1:" prefix match=2E

Change-Id: I0f659eb20441edd411ec13f4d09f43414=
1b2da32
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/op=
envpn/push=2Ec
1 file changed, 6 insertions(+), 7 deletions(-)



  git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/2344/1

diff -=
-git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index eb11107=2E=2E63637=
c2 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -85,7 +8=
5,6 @@
     {
         /* SOFT-SIGUSR1 -- Auth failure error */
         re=
gister_signal(c->sig, SIGUSR1, "auth-failure (auth-token)");
-        c->op=
tions=2Eno_advance =3D true;
     }
     else
     {
@@ -117,7 +116,7 @@
  =
   /*
      * Save the dynamic-challenge text even when management is defin=
ed
      */
-    if (authfail_extended && buf_string_match_head_str(&buf, "=
CRV1:") && BLEN(&buf))
+    if (authfail_extended && buf_string_match_head_=
str(&buf, "CRV1:"))
     {
         ssl_put_auth_challenge(CBSTR(&buf));
  =
   }
@@ -931,7 +930,7 @@
 }
 
 static void
-push_option_ex(struct gc_arena =
*gc, struct push_list *push_list, const char *opt, bool enable,
+push_optio=
n_ex(struct gc_arena *gc, struct push_list *push_list, const char *opt,
   =
             msglvl_t msglevel)
 {
     if (!string_class(opt, CC_ANY, CC_C=
OMMA))
@@ -962,7 +961,7 @@
 void
 push_option(struct options *o, const char=
 *opt, msglvl_t msglevel)
 {
-    push_option_ex(&o->gc, &o->push_list, opt=
, true, msglevel);
+    push_option_ex(&o->gc, &o->push_list, opt, msglevel=
);
 }
 
 void
@@ -974,7 +973,7 @@
         push_reset(o);
         while (e=
)
         {
-            push_option_ex(&o->gc, &o->push_list, string_allo=
c(e->option, &o->gc), true, M_FATAL);
+            push_option_ex(&o->gc, &=
o->push_list, string_alloc(e->option, &o->gc), M_FATAL);
             e =3D=
 e->next;
         }
     }
@@ -1002,7 +1001,7 @@
     {
         return fa=
lse;
     }
-    push_option_ex(gc, push_list, string_alloc(tmp, gc), true,=
 msglevel);
+    push_option_ex(gc, push_list, string_alloc(tmp, gc), msgle=
vel);
     return true;
 }
 
@@ -1031,7 +1030,7 @@
         return;
     }
=
 
-    if (o && o->push_list=2Ehead)
+    if (o->push_list=2Ehead)
     {
 =
        struct push_entry *e =3D o->push_list=2Ehead;
 

-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b=
2da32
Gerrit-Change-Number: 2344
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--80jJvFRXlFk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">push: remove dead code<br><br>- push_option_ex(): drop =
the &quot;enable&quot; parameter; it was ignored and<br>  every caller pass=
ed true=2E<br>- push_remove_option(): drop the NULL check on o, already der=
eferenced<br>  by the ifconfig/ifconfig-ipv6 checks above it=2E<br>- receiv=
e_auth_failed(): drop a repeated no_advance =3D true and a BLEN()<br>  chec=
k implied by the preceding &quot;CRV1:&quot; prefix match=2E<br><br>Change-=
Id: I0f659eb20441edd411ec13f4d09f434141b2da32<br>Signed-off-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/push=2Ec<br>1 fi=
le changed, 6 insertions(+), 7 deletions(-)<br><br></pre><pre class=3D"bloc=
ks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/44/2344/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><spa=
n>index eb11107=2E=2E63637c2 100644</span><br><span>--- a/src/openvpn/push=
=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -85,7 +8=
5,6 @@</span><br><span>     {</span><br><span>         /* SOFT-SIGUSR1 -- A=
uth failure error */</span><br><span>         register_signal(c-&gt;sig, SI=
GUSR1, &quot;auth-failure (auth-token)&quot;);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        c-&gt;options=2Eno_advance =3D true;</span=
><br><span>     }</span><br><span>     else</span><br><span>     {</span><b=
r><span>@@ -117,7 +116,7 @@</span><br><span>     /*</span><br><span>      *=
 Save the dynamic-challenge text even when management is defined</span><br>=
<span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(authfail_extended &amp;&amp; buf_string_match_head_str(&amp;buf, &quot;CRV=
1:&quot;) &amp;&amp; BLEN(&amp;buf))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (authfail_extended &amp;&amp; buf_string_match_head=
_str(&amp;buf, &quot;CRV1:&quot;))</span><br><span>     {</span><br><span> =
        ssl_put_auth_challenge(CBSTR(&amp;buf));</span><br><span>     }</sp=
an><br><span>@@ -931,7 +930,7 @@</span><br><span> }</span><br><span> </span=
><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-push_option_ex(struct gc_arena *gc, struct push_list *push_list, const ch=
ar *opt, bool enable,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+push_option_ex(struct gc_arena *gc, struct push_list *push_list, const ch=
ar *opt,</span><br><span>                msglvl_t msglevel)</span><br><span=
> {</span><br><span>     if (!string_class(opt, CC_ANY, CC_COMMA))</span><b=
r><span>@@ -962,7 +961,7 @@</span><br><span> void</span><br><span> push_opt=
ion(struct options *o, const char *opt, msglvl_t msglevel)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    push_option_ex(=
&amp;o-&gt;gc, &amp;o-&gt;push_list, opt, true, msglevel);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    push_option_ex(&amp;o-&gt;gc, &a=
mp;o-&gt;push_list, opt, msglevel);</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span>@@ -974,7 +973,7 @@</span><br><span>   =
      push_reset(o);</span><br><span>         while (e)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pu=
sh_option_ex(&amp;o-&gt;gc, &amp;o-&gt;push_list, string_alloc(e-&gt;option=
, &amp;o-&gt;gc), true, M_FATAL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            push_option_ex(&amp;o-&gt;gc, &amp;o-&gt;push_lis=
t, string_alloc(e-&gt;option, &amp;o-&gt;gc), M_FATAL);</span><br><span>   =
          e =3D e-&gt;next;</span><br><span>         }</span><br><span>    =
 }</span><br><span>@@ -1002,7 +1001,7 @@</span><br><span>     {</span><br><=
span>         return false;</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    push_option_ex(gc, push_list, string_alloc=
(tmp, gc), true, msglevel);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    push_option_ex(gc, push_list, string_alloc(tmp, gc), msglevel);=
</span><br><span>     return true;</span><br><span> }</span><br><span> </sp=
an><br><span>@@ -1031,7 +1030,7 @@</span><br><span>         return;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (o &amp;&amp; o-&gt;push_list=2Ehead)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;push_list=2Ehead)</span>=
<br><span>     {</span><br><span>         struct push_entry *e =3D o-&gt;pu=
sh_list=2Ehead;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail">change 2344</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f659eb20441edd41=
1ec13f4d09f434141b2da32 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 2344 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<=
div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@=
mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--80jJvFRXlFk=--


--===============0798972847731383842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0798972847731383842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0798972847731383842==--

