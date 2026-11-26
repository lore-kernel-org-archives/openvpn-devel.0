Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DAF606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 09:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GYj48z2/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lIF731YJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mMuGJu0F;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YwUb1QpY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fBoERecjyvYkd1rNA6Y7CVQfVEsGn/zdtkmySTr2H9k=; b=GYj48z2/4TwFSKfxWKtjN7p71l
	oUQ2aZ5Wk1gjtSD8TrJ2DAoG9/ZO6vo7tzjdqMR2IExOY46sBkz9fTcrboHxmT8EsVXzso2c9bxYH
	lyVmYIY6geAoVbFgjQ7xO14uFN4Q0TgHf/1HnthqyTNi5RhGVJv4yx/gDa/PgRIWGEGg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWVae-000000001hm-2omM;
	Thu, 26 Nov 2026 09:16:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWVac-000000001hA-2BsR
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:16:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pm+pH99g8Ca7oken5Cxei72XK2PQ5c4O8/KjrKdNX+M=; b=lIF731YJidsVJJSC/Lc8QmRMRW
 ncaDbtzo5pmuRlinEBK5R/gYuXjKPxBIBU5FEWjpNHX6awCJN7ABDIDgT5CHkZUZdFg0LqjDc+1mP
 88Wnwyg8ZPEHu+n0orzdo0Bocy0CPUE7Zi3c9pTFWFJVCdXyVNJh6IBMPVL66ytBRZ4s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pm+pH99g8Ca7oken5Cxei72XK2PQ5c4O8/KjrKdNX+M=; b=mMuGJu0F0cKNfPzGmtQB2M3ic6
 EKCKTrdAtQl8B3WoYeUrYVjEjnk2zAx3lx/eit2hMg2zs2Pn9GWhMrTtTlVVqTPzX1MtJF3Jrjy1W
 ccEjVvNtJLCf7dm+Z2pRXnV3RHwdX+5bHLgR7D4vA08Lr52Q2CX7ZITFCgR0E+26y3J4=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWVaa-0000000052m-3M3n for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 09:16:26 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-4b52fcb410dso2367094f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 01:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795684578; x=1796289378; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pm+pH99g8Ca7oken5Cxei72XK2PQ5c4O8/KjrKdNX+M=;
 b=YwUb1QpYS77pIo66nhzBRaEuSb2bAOpggPHNuu/kspd4uK3iHVhOG+qdywhmv5jb7l
 jGqcb0Y9FsID0KRT8IY5ZQqbqb6WLYp6KcQSZwYa3n+WT0sh5hZCB/kpTfRG/3VEMKuN
 HJ46l8mov8Ed7nla0O+nOkXWkBSpkubD2Uu8mmmMoEUOEue6XP1Z7ya/XJ9GEqQZQEef
 csDu1+9+DNAE5vwRfidSZUsE6Zg8B/QP3ygUXbR7ssgs9FvCglloOyJtYHeJORh0yTOF
 JDIdA8CpYBudoVlcl8buWAfT8EW0+aXSybQQorPNkdKZpYP55CT0gpwjaBdTocGiNMN1
 bz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795684578; x=1796289378;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=pm+pH99g8Ca7oken5Cxei72XK2PQ5c4O8/KjrKdNX+M=;
 b=r1Y5Sxkf/Llc97TfqmTx/fBJ4pOcL9FfYb1FiwSsTXrm3ir97lhXEE8+AaFjcjK6oa
 cpUD1MkiDPxZ0iUE2RSIhUiFFvL+MiLpXg4cHfedI1QkIdkGX02Nh1L4GteQO9FAfTPI
 izuuD2EdfnsW/SXrmGhWZLct7cWAj3AJWz2L8oVypVABK2p/9eJVeJrpsfda/NhzCmfY
 /hG8w+Aa/Fth65M/lB/f6AszTJWMKnn3OlojgO8fF1Olxb2MTQ8vXacWwhPRJKM3/F/j
 X78knzgATo/WOQYJMuq0tZCx+nYlzZf+pcZmWFuQ+ov53JMgk9zxp1rhvNY9V2ngFKs/
 sVVQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFc+sKD7Mf/FqR7HhG9/R47ZUODOAglGq6Tqz9ia1JOx4pP8SbupCUS7s+w3asmBrR2BHe2G0ayYTp+RHJk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8yI90Wg6vwQdk4jK8Lk2r74UeG6CUqMo5//gKYc8hY47xV9zEn
 GmA5lIZSGbL9fqleU+YB/uIoR0M1FzTcy/oZbVkd5c5LfpxpiSAgsCYIceN2KFIL86rQWmECOVM
 ntLrPU/hM/tsinSC1EnHKN43cKv6cTMUPqzHeTQNYCY104XSX/TKB8GZCCQqW6M4QkWT9
X-Gm-Gg: AZFdTZf45UJWF2MEIPXatYIa96t4PDLiWBRVNcbbgzefIyRaprst5zgoU8HYdt/ntvz
 GxcnmlKcoFKjnbG0cSZ3iKr1EM1yYpuZ39QAIQPhi4ZfgcIeyeZUxSwI+o3vytsQBmhRUc1ng74
 ezwGOvo6nmVmNa6gyocHrOwm2SDO4cKcv/4BepxPUw1S/4OIFF4jLMH3b77s/liSn7r4nPIxZ6f
 VR3OWpj3QvKaFc46QCrG7H6BhSybgt56JXjV2D0GqxtEAGZDxBhX+k75rpuy4gHyZ0lVmKdFGsM
 IYfP1QC2oPbvXkDyUyqEdaIrhEGvzbo+f2ABjnz/RJdesOwdTbOPNFm+nVeRpoYdsOcqpwfxTtx
 BLJeFSD6Iq6tG0KfAlMFjQeYg9yxqvCzPnKbYAEQW/jwmEbHzpAQqlPTMehHbG0Jm7FQUdkYz/S
 MXL6rNxP+LNd2+bEjM28dcj2fNqWZl6Ijqb4HV++7keTOOfS0Wbj6mi4Eqo8KK5gyS0nByAhDNt
 QEB/xYY6E21oGhltnw7yk2wzf2PCSbV+VkcJlTx+gMRKxtbMCnAvzwLkulSI7XPXuiULilc5OvK
 JjEKPcSsfWxD5yPDWWxNgCPxoiI0WVFp523lVXHhk7l8K2BKeaMslaokvNN7d9l4PLC93t20T1l
 ODtkBdbOD9s/npD2SEei5Ejh/+SlYub7SVRJs8trWEuxYhjT31iU+NdIgrYE1s2GPpSsBpNKr33
 5+LaUbRRkbDEYytkg=
X-Received: by 2002:a05:6000:40ce:b0:488:8347:a110 with SMTP id
 ffacd0b85a97d-4abafd02fa0mr42870957f8f.7.1795684577907; 
 Thu, 26 Nov 2026 01:16:17 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6c61e53asm42005247f8f.59.2026.11.26.01.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 01:16:17 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 09:16:17 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
X-Gerrit-Change-Number: 2344
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2344?usp=email>
X-Gerrit-Commit: 2f930baf5b0846f745efd99b510533ceeaadb662
In-Reply-To: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
References: <gerrit.1795621690000.I0f659eb20441edd411ec13f4d09f434141b2da32@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NjIxNjkwMDAwLkkwZjY1OWViMjA0NDFlZGQ0MTFlYzEzZjRkMDlmNDM0MTQxYjJkYTMyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <755077879d5bcedbed9f4adf8c39cdf80cbbb570-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWVaa-0000000052m-3M3n
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1070155899410977678=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1070155899410977678==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qOdAf5/tHeA="; charset=UTF-8

--qOdAf5/tHeA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2344?usp=3Demail )

Change subject: push: remove dead code
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

push: remove dea=
d code

- push_option_ex(): drop the "enable" parameter; it was ignored and=

  every caller passed true=2E
- push_remove_option(): drop the NULL check =
on o, already dereferenced
  by the ifconfig/ifconfig-ipv6 checks above it=
=2E
- receive_auth_failed(): drop a repeated no_advance =3D true and a BLEN=
()
  check implied by the preceding "CRV1:" prefix match, and the blank
  l=
ine hiding that the auth-token check is an else-if of the TEMP one=2E

Chan=
ge-Id: I0f659eb20441edd411ec13f4d09f434141b2da32
Signed-off-by: Razvan Cojo=
caru <razvanc@mailbox=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344
Message=
-Id: <20261125171133=2E21392-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41963=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/pus=
h=2Ec
1 file changed, 6 insertions(+), 8 deletions(-)




diff --git a/src/=
openvpn/push=2Ec b/src/openvpn/push=2Ec
index eb11107=2E=2E274f652 100644
-=
-- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -75,7 +75,6 @@
    =
     parse_auth_failed_temp(&c->options, reason + strlen("TEMP"));
        =
 register_signal(c->sig, SIGUSR1, "auth-temp-failure (server temporary reje=
ct)");
     }
-
     /* Before checking how to react on AUTH_FAILED, first =
check if the
      * failed auth might be the result of an expired auth-tok=
en=2E
      * Note that a server restart will trigger a generic AUTH_FAILED=

@@ -85,7 +84,6 @@
     {
         /* SOFT-SIGUSR1 -- Auth failure error */=

         register_signal(c->sig, SIGUSR1, "auth-failure (auth-token)");
- =
       c->options=2Eno_advance =3D true;
     }
     else
     {
@@ -117,7 =
+115,7 @@
     /*
      * Save the dynamic-challenge text even when managem=
ent is defined
      */
-    if (authfail_extended && buf_string_match_head=
_str(&buf, "CRV1:") && BLEN(&buf))
+    if (authfail_extended && buf_string=
_match_head_str(&buf, "CRV1:"))
     {
         ssl_put_auth_challenge(CBST=
R(&buf));
     }
@@ -931,7 +929,7 @@
 }
 
 static void
-push_option_ex(stru=
ct gc_arena *gc, struct push_list *push_list, const char *opt, bool enable,=

+push_option_ex(struct gc_arena *gc, struct push_list *push_list, const ch=
ar *opt,
                msglvl_t msglevel)
 {
     if (!string_class(opt, =
CC_ANY, CC_COMMA))
@@ -962,7 +960,7 @@
 void
 push_option(struct options *o=
, const char *opt, msglvl_t msglevel)
 {
-    push_option_ex(&o->gc, &o->pu=
sh_list, opt, true, msglevel);
+    push_option_ex(&o->gc, &o->push_list, o=
pt, msglevel);
 }
 
 void
@@ -974,7 +972,7 @@
         push_reset(o);
     =
    while (e)
         {
-            push_option_ex(&o->gc, &o->push_list,=
 string_alloc(e->option, &o->gc), true, M_FATAL);
+            push_option_=
ex(&o->gc, &o->push_list, string_alloc(e->option, &o->gc), M_FATAL);
      =
       e =3D e->next;
         }
     }
@@ -1002,7 +1000,7 @@
     {
      =
   return false;
     }
-    push_option_ex(gc, push_list, string_alloc(tmp=
, gc), true, msglevel);
+    push_option_ex(gc, push_list, string_alloc(tmp=
, gc), msglevel);
     return true;
 }
 
@@ -1031,7 +1029,7 @@
         ret=
urn;
     }
 
-    if (o && o->push_list=2Ehead)
+    if (o->push_list=2Ehe=
ad)
     {
         struct push_entry *e =3D o->push_list=2Ehead;
 

-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f659eb20441edd411ec13f4d0=
9f434141b2da32
Gerrit-Change-Number: 2344
Gerrit-PatchSet: 3
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--qOdAf5/tHeA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2344?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">push: remove dead code<br><br>- pu=
sh_option_ex(): drop the &quot;enable&quot; parameter; it was ignored and<b=
r>  every caller passed true=2E<br>- push_remove_option(): drop the NULL ch=
eck on o, already dereferenced<br>  by the ifconfig/ifconfig-ipv6 checks ab=
ove it=2E<br>- receive_auth_failed(): drop a repeated no_advance =3D true a=
nd a BLEN()<br>  check implied by the preceding &quot;CRV1:&quot; prefix ma=
tch, and the blank<br>  line hiding that the auth-token check is an else-if=
 of the TEMP one=2E<br><br>Change-Id: I0f659eb20441edd411ec13f4d09f434141b2=
da32<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Ack=
ed-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344<br>Message-Id: &lt;20261125171=
133=2E21392-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41963=2Ehtml<br>Signed-o=
ff-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn=
/push=2Ec<br>1 file changed, 6 insertions(+), 8 deletions(-)<br><br></pre>
=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span=
>index eb11107=2E=2E274f652 100644</span><br><span>--- a/src/openvpn/push=
=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -75,7 +7=
5,6 @@</span><br><span>         parse_auth_failed_temp(&amp;c-&gt;options, =
reason + strlen(&quot;TEMP&quot;));</span><br><span>         register_signa=
l(c-&gt;sig, SIGUSR1, &quot;auth-temp-failure (server temporary reject)&quo=
t;);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>     /* Before checking how to react on AUTH_FAILED,=
 first check if the</span><br><span>      * failed auth might be the result=
 of an expired auth-token=2E</span><br><span>      * Note that a server res=
tart will trigger a generic AUTH_FAILED</span><br><span>@@ -85,7 +84,6 @@</=
span><br><span>     {</span><br><span>         /* SOFT-SIGUSR1 -- Auth fail=
ure error */</span><br><span>         register_signal(c-&gt;sig, SIGUSR1, &=
quot;auth-failure (auth-token)&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        c-&gt;options=2Eno_advance =3D true;</span><br><sp=
an>     }</span><br><span>     else</span><br><span>     {</span><br><span>=
@@ -117,7 +115,7 @@</span><br><span>     /*</span><br><span>      * Save th=
e dynamic-challenge text even when management is defined</span><br><span>  =
    */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (authfai=
l_extended &amp;&amp; buf_string_match_head_str(&amp;buf, &quot;CRV1:&quot;=
) &amp;&amp; BLEN(&amp;buf))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (authfail_extended &amp;&amp; buf_string_match_head_str(&am=
p;buf, &quot;CRV1:&quot;))</span><br><span>     {</span><br><span>         =
ssl_put_auth_challenge(CBSTR(&amp;buf));</span><br><span>     }</span><br><=
span>@@ -931,7 +929,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-push_o=
ption_ex(struct gc_arena *gc, struct push_list *push_list, const char *opt,=
 bool enable,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_o=
ption_ex(struct gc_arena *gc, struct push_list *push_list, const char *opt,=
</span><br><span>                msglvl_t msglevel)</span><br><span> {</spa=
n><br><span>     if (!string_class(opt, CC_ANY, CC_COMMA))</span><br><span>=
@@ -962,7 +960,7 @@</span><br><span> void</span><br><span> push_option(stru=
ct options *o, const char *opt, msglvl_t msglevel)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    push_option_ex(&amp;o-&=
gt;gc, &amp;o-&gt;push_list, opt, true, msglevel);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    push_option_ex(&amp;o-&gt;gc, &amp;o-&gt=
;push_list, opt, msglevel);</span><br><span> }</span><br><span> </span><br>=
<span> void</span><br><span>@@ -974,7 +972,7 @@</span><br><span>         pu=
sh_reset(o);</span><br><span>         while (e)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            push_optio=
n_ex(&amp;o-&gt;gc, &amp;o-&gt;push_list, string_alloc(e-&gt;option, &amp;o=
-&gt;gc), true, M_FATAL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            push_option_ex(&amp;o-&gt;gc, &amp;o-&gt;push_list, strin=
g_alloc(e-&gt;option, &amp;o-&gt;gc), M_FATAL);</span><br><span>           =
  e =3D e-&gt;next;</span><br><span>         }</span><br><span>     }</span=
><br><span>@@ -1002,7 +1000,7 @@</span><br><span>     {</span><br><span>   =
      return false;</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    push_option_ex(gc, push_list, string_alloc(tmp, gc=
), true, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    push_option_ex(gc, push_list, string_alloc(tmp, gc), msglevel);</span><=
br><span>     return true;</span><br><span> }</span><br><span> </span><br><=
span>@@ -1031,7 +1029,7 @@</span><br><span>         return;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (o &amp;&amp; o-&gt;push_list=2Ehead)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (o-&gt;push_list=2Ehead)</span><br><spa=
n>     {</span><br><span>         struct push_entry *e =3D o-&gt;push_list=
=2Ehead;</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2344?usp=3Demail">change 2344</a>=2E To unsubscribe, =
or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2344?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I0f659eb20441edd411ec13f4d09=
f434141b2da32 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 234=
4 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--qOdAf5/tHeA=--


--===============1070155899410977678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1070155899410977678==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1070155899410977678==--

