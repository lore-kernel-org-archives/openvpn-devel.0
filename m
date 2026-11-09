Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052D0606A325
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=G2cYjdk+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DeBHXwbg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gOOhZtKG;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dFv7Sy5g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=fcznakSbjS+qE9xRn0gms1iEkx8ckpRdTg54kArNe/4=; b=G2cYjdk+XnT0ql1c+kc7bYTzlR
	Fh93RvQK1u1WAkQzwhj++p7lTmXZlBVB0nUZUq7WimMV1rJq/kpC072nzT4ZLToq/Lz00iK8OJwWV
	iha723zDnDR0G2GvXSmX76S5ivMwMgAkV7onzckB+cO/KvZjJ3OkCReCW3PqLx/J1koo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQT9x-000000007HL-2tjk;
	Mon, 09 Nov 2026 17:27:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQT9w-000000007HE-2m6I
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dgLz2EMliADBo5ZqQU52lboFL6yYrFFfs5RaQhEiPJg=; b=DeBHXwbgSIx2NK0faSR50rcQDE
 y9GDcn+77A8Yjnfr7eNU0fsXjEoMMjY2XGRclUQ3hwjNl4NB1501uXWxazs1NJ+kxynfR2zQuUMIi
 O3fss2oasqSwpH4zHxh8/TyxDvKzFkN0hieGaeoV9VY8voxXkitqhj7oOL+qcX5+W4Uk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dgLz2EMliADBo5ZqQU52lboFL6yYrFFfs5RaQhEiPJg=; b=gOOhZtKGJXWUBILLoKZGOpG9F6
 SUNWYarlvhC+T6pd4ZRHo0EivOI1s5aFqttdtuxEURlb8qgCZ8Gq5a2RhKCy3LdonjplNvovbyDRd
 +W/5ogpmrAaUxywSaHXyYKc5kxSELOWXWYqtD5ggpOABIXQKk/fuArw68tF+wg5Ia1XE=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQT9s-000000003q9-0fEX for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:27:56 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so940089f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 09:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794245265; x=1794850065; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=dgLz2EMliADBo5ZqQU52lboFL6yYrFFfs5RaQhEiPJg=;
 b=dFv7Sy5ghISjIahhRyUu85dpYPynxLEL3j5hckhaHYaey6bNvBKYd7/XMjf/Zl/tox
 EdV++glcd+fzimpjlLvt/0dNV++amS7xrYZV2LCcSeViJCXK1CSvKEX0NoeyYZi8b0I3
 lgPP76MQ/k9Al2ExEwf6572WHsiKk3Qh/0h91TKH5P6UbvufxBjUsGPns/KaQFuMx04j
 qCh12k08EYuOf1gCHDz4kZqwfzb3phOHOo9XYNx+4s5JrkvpSGG2gIYWkD3YUhRQ4rSe
 51P5jHQXThXR3aZPI7E+ZgDfw1K/CBAQuqlcPxBPQHWiRfSAWr9RytVeSTj/+BKYKVwL
 4aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245265; x=1794850065;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=dgLz2EMliADBo5ZqQU52lboFL6yYrFFfs5RaQhEiPJg=;
 b=ev4zAA+TC1ahBgGoEql2fTrWWoQbxjbeVCrOJRb59tjoYsh9ayn0/IN1XNvWkbtXAr
 tng+tWM28C4y7VW1CMrQ0h6VsZYCL5ansX1P5qPRWVsJdmCEXTyQECKjwQ89/5I1qJKf
 Yl3NDBSJzjOY7o+TjVi/4Yiy5XBppVqJjwQji+U7YthhHR4gZv199/bv+UYVs4gjlB7w
 In5CV+u6fbua476mXpxmTiE3JGylwXMVji7ymLSm04HHElDjHcVUVEOoO1oaxg9AoBd9
 fMsXtrVPTn0Z85XusUsuzRUJ41q9KcDziyqoSJ8z5lc4L41gMdmjBBFfOQCo2tF8AnSt
 ZTig==
X-Forwarded-Encrypted: i=1;
 AL+hErFimc/QVqteVNmBVFaVe7+zMzinjASj0W0/udl4R6Z6V/8Vw2omDT4n/rMyjbItzlGeR7Q9iQidqiO0RyLJ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+xFxBuqvEXApa8E6Bo77M8UdeNvbrqTXH50vl6KMKbwozJ/D9+
 hJJSSt8Scdd+yubZbOQb+MiWeOwPzI6ertzLKJ1waTGrvWuEpX80Qpvdc/E3vpnUoW9ER/Grcmg
 wb6DejG1TvC6GuyHfe9IPyfO4G1u68umDrxhWUvD4lkySeUb8E94zBop+DH5U8lR83DB7
X-Gm-Gg: AYBFou3Etbqxd45s6o62gVnAHghhKfQGFUDLGedsGcVK2R1f/WiXFLMKX2QymKCOC8d
 U5SbAKCuAVnU0Y0cPJvG05R3UFk2f3EqMYYkwQiDS+n5YhaQ8EQQTajRM29ujqHtL8iVSsJ94fa
 7LT4TRNB6da6H6JyOF58KixkYkihdRu16w1t7GO7gttb8Yta66/IWZWDpkzt3GBpj7y8ZTSjmbq
 WFV6uIs7irvpsHJd0mFG0wyj8IcbYu1iHyNGPqdbAOTVPwwSH9Di43yqP4d10aV9CXvUs3g5AUl
 QjyyXr2X+kIH/UoCgXLATwyzJb3rK4zhgvdWzOZoTSICDntWzUtXKX1FY/9t7U+g5HpN7Q3fb6o
 e4XDyLCtI95ZiOYSDYyqwWadhk1Taxt722b/Ja6whzQLJhtfLBYeL2orrGDWSU08nPxlm3RVsMh
 qEtPBlk+GP7+jPa08LVR2u6ItXeaEn7B3B3k6lkHN+GAj8NOGQeiT6pT7w8e11uu028aZBJqfO4
 G5nBysQ4OzZD1HVwM4DjVxLd9mHePylueQbmT1+AWEJcC70A8V0/JfT2Eww6nctEsTj1/swhpzu
 co20gun16buE3bxw0HG6VBbByNgdc+eSmtrOCR98LxqrtfvMrKxgNmwuaBzvLkwtzzdqd66qJ5f
 lTHbatyElk5iTvlxphYEOCwPe++pMzqjFhKkH+IY0TRyg8Xmp6DiXz8GRz2Kt69K4JKuNeO7ftZ
 uN3XycF4lrJ8sPAg==
X-Received: by 2002:a05:6000:2612:b0:48e:6651:5956 with SMTP id
 ffacd0b85a97d-49827bfa5f5mr425179f8f.0.1794245265274; 
 Mon, 09 Nov 2026 09:27:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365ccbccsm78968f8f.44.2026.11.09.09.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:27:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 17:27:44 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f
X-Gerrit-Change-Number: 2149
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2149?usp=email>
X-Gerrit-Commit: 83c988d49fddc7e0ad9c40741ab6f391f236ed45
In-Reply-To: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
References: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM0MDAwLkllZmNjM2NiOTBmM2U2YjAzNmE1ODRhNzQyNjg2NzhkYmMxN2RhNjlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <30581871d7cc1cb75797a75fa558caab86d2290f-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQT9s-000000003q9-0fEX
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unused
 gc_arena variables
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
Content-Type: multipart/mixed; boundary="===============6385882026009447123=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6385882026009447123==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rEgyQX3O4wI="; charset=UTF-8

--rEgyQX3O4wI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2149?usp=3Demail )

Change subject: Remove unused gc_arena vari=
ables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Remove =
unused gc_arena variables

These functions create and free a gc_arena they =
never allocate from=2E

Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69=
f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2149
Message-Id: <20261109124623=2E26716-1-gert@greenie=2Em=
uc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg40981=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/mu=
lti=2Ec
M src/openvpn/options_string=2Ec
M src/openvpn/plugin=2Ec
M src/ope=
nvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/tun=2Ec
8 files chang=
ed, 0 insertions(+), 32 deletions(-)




diff --git a/src/openvpn/init=2Ec =
b/src/openvpn/init=2Ec
index ff3bfe5=2E=2E3bc4de4 100644
--- a/src/openvpn/=
init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -117,8 +117,6 @@
             const =
char *ifconfig_remote, const char *context, const char *signal_text,
      =
       const char *script_type, struct env_set *es)
 {
-    struct gc_arena=
 gc =3D gc_new();
-
     if (signal_text)
     {
         setenv_str(es, "s=
ignal", signal_text);
@@ -174,8 +172,6 @@
         openvpn_run_script(&argv=
, es, S_FATAL, "--up/--down");
         argv_free(&argv);
     }
-
-    gc_=
free(&gc);
 }
 
 /*
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec
index 3e3b1c2=2E=2E581e7be 100644
--- a/src/openvpn/manage=2Ec
+++ b/=
src/openvpn/manage=2Ec
@@ -2325,9 +2325,7 @@
 
     if (!ignore_sys_error(e=
rr, crt_error))
     {
-        struct gc_arena gc =3D gc_new();
         m=
sg(D_MANAGEMENT, "MANAGEMENT: TCP %s error: %s", prefix, strerror(err));
- =
       gc_free(&gc);
         return true;
     }
     else
@@ -3151,11 +31=
49,8 @@
 management_notify_client_cr_response(unsigned mda_key_id, const st=
ruct man_def_auth_context *mdac,
                                      cons=
t struct env_set *es, const char *response)
 {
-    struct gc_arena gc;
   =
  if (management)
     {
-        gc =3D gc_new();
-
         msg(M_CLIENT,=
 ">CLIENT:CR_RESPONSE,%lu,%u,%s", mdac->cid, mda_key_id, response);
       =
  man_output_extra_env(management, "CLIENT");
         if (management->conn=
ection=2Eenv_filter_level > 0)
@@ -3163,7 +3158,6 @@
             man_outpu=
t_peer_info_env(management, mdac);
         }
         man_output_env(es, t=
rue, management->connection=2Eenv_filter_level, "CLIENT");
-        gc_free=
(&gc);
     }
 }
 
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=
=2Ec
index 03844fb=2E=2Ebcaa012 100644
--- a/src/openvpn/multi=2Ec
+++ b/sr=
c/openvpn/multi=2Ec
@@ -726,7 +726,6 @@
 multi_create_instance(struct multi=
_context *m, const struct mroute_addr *real,
                       struct =
link_socket *sock)
 {
-    struct gc_arena gc =3D gc_new();
     struct mul=
ti_instance *mi;
 
     msg(D_MULTI_MEDIUM, "MULTI: multi_create_instance c=
alled");
@@ -792,12 +791,10 @@
     mi->ev_arg=2Etype =3D EVENT_ARG_MULTI_I=
NSTANCE;
     mi->ev_arg=2Eu=2Emi =3D mi;
 
-    gc_free(&gc);
     return =
mi;
 
 err:
     multi_close_instance(m, mi, false);
-    gc_free(&gc);
   =
  return NULL;
 }
 
@@ -2213,7 +2210,6 @@
     if (mi->context=2Eoptions=2E=
client_connect_script)
     {
         struct argv argv =3D argv_new();
-  =
      struct gc_arena gc =3D gc_new();
 
         setenv_str(mi->context=2E=
c2=2Ees, "script_type", "client-connect");
 
@@ -2249,7 +2245,6 @@
        =
     ccs_delete_deferred_ret_file(mi);
         }
         argv_free(&argv)=
;
-        gc_free(&gc);
     }
     return ret;
 }
diff --git a/src/openvp=
n/options_string=2Ec b/src/openvpn/options_string=2Ec
index cfc0595=2E=2Eed=
4d742 100644
--- a/src/openvpn/options_string=2Ec
+++ b/src/openvpn/options=
_string=2Ec
@@ -344,7 +344,6 @@
 bool
 options_cmp_equal_safe(char *actual,=
 const char *expected, size_t actual_n)
 {
-    struct gc_arena gc =3D gc_n=
ew();
     bool ret =3D true;
 
     if (actual_n > 0)
@@ -360,7 +359,6 @@
=
             ret =3D !strcmp(actual, expected);
         }
     }
-    gc_f=
ree(&gc);
     return ret;
 }
 
diff --git a/src/openvpn/plugin=2Ec b/src/o=
penvpn/plugin=2Ec
index 08461b8=2E=2Ed1f228e 100644
--- a/src/openvpn/plugi=
n=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -560,7 +560,6 @@
 
     if (p->plugin=
_handle && (p->plugin_type_mask & OPENVPN_PLUGIN_MASK(type)))
     {
-     =
   struct gc_arena gc =3D gc_new();
         struct argv a =3D argv_insert_=
head(av, p->so_pathname);
 
         dmsg(D_PLUGIN_DEBUG, "PLUGIN_CALL: PRE=
 type=3D%s", plugin_type_name(type));
@@ -609,7 +608,6 @@
         }
 
    =
     argv_free(&a);
-        gc_free(&gc);
     }
     return status;
 }
di=
ff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 53550c4=2E=
=2Ed0d26c6 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@=
@ -3090,7 +3090,6 @@
 void
 get_default_gateway(struct route_gateway_info *=
rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena gc =3D=
 gc_new();
     int sd =3D -1;
     char best_name[IFNAMSIZ];
 
@@ -3216,7 =
+3215,6 @@
     {
         close(sd);
     }
-    gc_free(&gc);
 }
 
 /* IP=
v6 implementation using netlink
diff --git a/src/openvpn/socket=2Ec b/src/o=
penvpn/socket=2Ec
index 307b5c6=2E=2E1fbd07b 100644
--- a/src/openvpn/socke=
t=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -499,7 +499,6 @@
                    =
  const struct addrinfo *local, bool do_listen,
                      bool =
nowait, volatile int *signal_received)
 {
-    struct gc_arena gc =3D gc_ne=
w();
     socket_descriptor_t new_sd =3D SOCKET_UNDEFINED;
 
     CLEAR(*ac=
t);
@@ -521,7 +520,6 @@
         get_signal(signal_received);
         if (=
*signal_received)
         {
-            gc_free(&gc);
             return=
 sd;
         }
 
@@ -552,7 +550,6 @@
 
     tcp_connection_established(act=
);
 
-    gc_free(&gc);
     return new_sd;
 }
 
@@ -803,8 +800,6 @@
 stati=
c void
 resolve_bind_local(struct link_socket *sock)
 {
-    struct gc_aren=
a gc =3D gc_new();
-
     /* resolve local address if undefined */
     if =
(!sock->info=2Elsa->bind_local)
     {
@@ -846,8 +841,6 @@
             soc=
k->info=2Eaf =3D (sa_family_t)sock->info=2Elsa->bind_local->ai_family;
    =
     }
     }
-
-    gc_free(&gc);
 }
 
 static void
@@ -2673,7 +2666,6 @@
=
 void
 socket_bind_unix(socket_descriptor_t sd, struct sockaddr_un *local, =
const char *prefix)
 {
-    struct gc_arena gc =3D gc_new();
     const mod=
e_t orig_umask =3D umask(0);
 
     if (bind(sd, (struct sockaddr *)local, =
sizeof(struct sockaddr_un)))
@@ -2683,7 +2675,6 @@
     }
 
     umask(orig=
_umask);
-    gc_free(&gc);
 }
 
 socket_descriptor_t
diff --git a/src/open=
vpn/tun=2Ec b/src/openvpn/tun=2Ec
index 943ad9f=2E=2Ebcea331 100644
--- a/s=
rc/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -666,7 +666,6 @@
 void
 war=
n_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena =
gc =3D gc_new();
     struct route_gateway_info rgi;
     const unsigned in=
t needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
 
@@ -680,7 +679,6 @=
@
                 "NOTE: your local LAN uses the extremely common subnet a=
ddress 192=2E168=2E0=2Ex or 192=2E168=2E1=2Ex=2E  Be aware that this might =
create routing conflicts if you connect to the VPN server from public locat=
ions such as internet cafes that use the same subnet=2E");
         }
     =
}
-    gc_free(&gc);
 }
 
 /*

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2149?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f
Gerrit-Change-Number: =
2149
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-dev=
el <openvpn-devel@lists=2Esourceforge=2Enet>

--rEgyQX3O4wI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2149?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Remove unused gc_arena variables<b=
r><br>These functions create and free a gc_arena they never allocate from=
=2E<br><br>Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f<br>Signed-o=
ff-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2149<br>Message-Id: &lt;20261109124623=2E26716-1-ge=
rt@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-=
devel@lists=2Esourceforge=2Enet/msg40981=2Ehtml<br>Signed-off-by: Gert Doer=
ing &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/init=2Ec<br>M s=
rc/openvpn/manage=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options_s=
tring=2Ec<br>M src/openvpn/plugin=2Ec<br>M src/openvpn/route=2Ec<br>M src/o=
penvpn/socket=2Ec<br>M src/openvpn/tun=2Ec<br>8 files changed, 0 insertions=
(+), 32 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/s=
rc/openvpn/init=2Ec</span><br><span>index ff3bfe5=2E=2E3bc4de4 100644</span=
><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/ini=
t=2Ec</span><br><span>@@ -117,8 +117,6 @@</span><br><span>             cons=
t char *ifconfig_remote, const char *context, const char *signal_text,</spa=
n><br><span>             const char *script_type, struct env_set *es)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>     if (signal_text)</span><br><span>     {</span>=
<br><span>         setenv_str(es, &quot;signal&quot;, signal_text);</span><=
br><span>@@ -174,8 +172,6 @@</span><br><span>         openvpn_run_script(&a=
mp;argv, es, S_FATAL, &quot;--up/--down&quot;);</span><br><span>         ar=
gv_free(&amp;argv);</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span>=
 /*</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manag=
e=2Ec</span><br><span>index 3e3b1c2=2E=2E581e7be 100644</span><br><span>---=
 a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</spa=
n><br><span>@@ -2325,9 +2325,7 @@</span><br><span> </span><br><span>     if=
 (!ignore_sys_error(err, crt_error))</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new=
();</span><br><span>         msg(D_MANAGEMENT, &quot;MANAGEMENT: TCP %s err=
or: %s&quot;, prefix, strerror(err));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span>         return t=
rue;</span><br><span>     }</span><br><span>     else</span><br><span>@@ -3=
151,11 +3149,8 @@</span><br><span> management_notify_client_cr_response(uns=
igned mda_key_id, const struct man_def_auth_context *mdac,</span><br><span>=
                                      const struct env_set *es, const char =
*response)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct gc_arena gc;</span><br><span>     if (management)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>         msg(M_CLIENT, &quot;&gt;CLIENT:CR_RESPONSE,%lu,%u,%=
s&quot;, mdac-&gt;cid, mda_key_id, response);</span><br><span>         man_=
output_extra_env(management, &quot;CLIENT&quot;);</span><br><span>         =
if (management-&gt;connection=2Eenv_filter_level &gt; 0)</span><br><span>@@=
 -3163,7 +3158,6 @@</span><br><span>             man_output_peer_info_env(m=
anagement, mdac);</span><br><span>         }</span><br><span>         man_o=
utput_env(es, true, management-&gt;connection=2Eenv_filter_level, &quot;CLI=
ENT&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc=
_free(&amp;gc);</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec=
</span><br><span>index 03844fb=2E=2Ebcaa012 100644</span><br><span>--- a/sr=
c/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><=
span>@@ -726,7 +726,6 @@</span><br><span> multi_create_instance(struct mult=
i_context *m, const struct mroute_addr *real,</span><br><span>             =
          struct link_socket *sock)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span=
><br><span>     struct multi_instance *mi;</span><br><span> </span><br><spa=
n>     msg(D_MULTI_MEDIUM, &quot;MULTI: multi_create_instance called&quot;)=
;</span><br><span>@@ -792,12 +791,10 @@</span><br><span>     mi-&gt;ev_arg=
=2Etype =3D EVENT_ARG_MULTI_INSTANCE;</span><br><span>     mi-&gt;ev_arg=2E=
u=2Emi =3D mi;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_free(&amp;gc);</span><br><span>     return mi;</span><br>=
<span> </span><br><span> err:</span><br><span>     multi_close_instance(m, =
mi, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_fre=
e(&amp;gc);</span><br><span>     return NULL;</span><br><span> }</span><br>=
<span> </span><br><span>@@ -2213,7 +2210,6 @@</span><br><span>     if (mi-&=
gt;context=2Eoptions=2Eclient_connect_script)</span><br><span>     {</span>=
<br><span>         struct argv argv =3D argv_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</s=
pan><br><span> </span><br><span>         setenv_str(mi-&gt;context=2Ec2=2Ee=
s, &quot;script_type&quot;, &quot;client-connect&quot;);</span><br><span> <=
/span><br><span>@@ -2249,7 +2245,6 @@</span><br><span>             ccs_dele=
te_deferred_ret_file(mi);</span><br><span>         }</span><br><span>      =
   argv_free(&amp;argv);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        gc_free(&amp;gc);</span><br><span>     }</span><br><span>     re=
turn ret;</span><br><span> }</span><br><span>diff --git a/src/openvpn/optio=
ns_string=2Ec b/src/openvpn/options_string=2Ec</span><br><span>index cfc059=
5=2E=2Eed4d742 100644</span><br><span>--- a/src/openvpn/options_string=2Ec<=
/span><br><span>+++ b/src/openvpn/options_string=2Ec</span><br><span>@@ -34=
4,7 +344,6 @@</span><br><span> bool</span><br><span> options_cmp_equal_safe=
(char *actual, const char *expected, size_t actual_n)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =
=3D gc_new();</span><br><span>     bool ret =3D true;</span><br><span> </sp=
an><br><span>     if (actual_n &gt; 0)</span><br><span>@@ -360,7 +359,6 @@<=
/span><br><span>             ret =3D !strcmp(actual, expected);</span><br><=
span>         }</span><br><span>     }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span>     return ret;</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/=
plugin=2Ec b/src/openvpn/plugin=2Ec</span><br><span>index 08461b8=2E=2Ed1f2=
28e 100644</span><br><span>--- a/src/openvpn/plugin=2Ec</span><br><span>+++=
 b/src/openvpn/plugin=2Ec</span><br><span>@@ -560,7 +560,6 @@</span><br><sp=
an> </span><br><span>     if (p-&gt;plugin_handle &amp;&amp; (p-&gt;plugin_=
type_mask &amp; OPENVPN_PLUGIN_MASK(type)))</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D=
 gc_new();</span><br><span>         struct argv a =3D argv_insert_head(av, =
p-&gt;so_pathname);</span><br><span> </span><br><span>         dmsg(D_PLUGI=
N_DEBUG, &quot;PLUGIN_CALL: PRE type=3D%s&quot;, plugin_type_name(type));</=
span><br><span>@@ -609,7 +608,6 @@</span><br><span>         }</span><br><sp=
an> </span><br><span>         argv_free(&amp;a);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span>     }=
</span><br><span>     return status;</span><br><span> }</span><br><span>dif=
f --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</span><br><span>ind=
ex 53550c4=2E=2Ed0d26c6 100644</span><br><span>--- a/src/openvpn/route=2Ec<=
/span><br><span>+++ b/src/openvpn/route=2Ec</span><br><span>@@ -3090,7 +309=
0,6 @@</span><br><span> void</span><br><span> get_default_gateway(struct ro=
ute_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_a=
rena gc =3D gc_new();</span><br><span>     int sd =3D -1;</span><br><span> =
    char best_name[IFNAMSIZ];</span><br><span> </span><br><span>@@ -3216,7 =
+3215,6 @@</span><br><span>     {</span><br><span>         close(sd);</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span> /* =
IPv6 implementation using netlink</span><br><span>diff --git a/src/openvpn/=
socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 307b5c6=2E=2E1fbd=
07b 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++=
 b/src/openvpn/socket=2Ec</span><br><span>@@ -499,7 +499,6 @@</span><br><sp=
an>                      const struct addrinfo *local, bool do_listen,</spa=
n><br><span>                      bool nowait, volatile int *signal_receive=
d)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    struct gc_arena gc =3D gc_new();</span><br><span>     socket_descriptor=
_t new_sd =3D SOCKET_UNDEFINED;</span><br><span> </span><br><span>     CLEA=
R(*act);</span><br><span>@@ -521,7 +520,6 @@</span><br><span>         get_s=
ignal(signal_received);</span><br><span>         if (*signal_received)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            gc_free(&amp;gc);</span><br><span>             return sd;</spa=
n><br><span>         }</span><br><span> </span><br><span>@@ -552,7 +550,6 @=
@</span><br><span> </span><br><span>     tcp_connection_established(act);</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    g=
c_free(&amp;gc);</span><br><span>     return new_sd;</span><br><span> }</sp=
an><br><span> </span><br><span>@@ -803,8 +800,6 @@</span><br><span> static =
void</span><br><span> resolve_bind_local(struct link_socket *sock)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span>     /* resolve local address if undefined */</span><b=
r><span>     if (!sock-&gt;info=2Elsa-&gt;bind_local)</span><br><span>     =
{</span><br><span>@@ -846,8 +841,6 @@</span><br><span>             sock-&gt=
;info=2Eaf =3D (sa_family_t)sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_famil=
y;</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span=
><br><span> static void</span><br><span>@@ -2673,7 +2666,6 @@</span><br><sp=
an> void</span><br><span> socket_bind_unix(socket_descriptor_t sd, struct s=
ockaddr_un *local, const char *prefix)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</s=
pan><br><span>     const mode_t orig_umask =3D umask(0);</span><br><span> <=
/span><br><span>     if (bind(sd, (struct sockaddr *)local, sizeof(struct s=
ockaddr_un)))</span><br><span>@@ -2683,7 +2675,6 @@</span><br><span>     }<=
/span><br><span> </span><br><span>     umask(orig_umask);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span> =
}</span><br><span> </span><br><span> socket_descriptor_t</span><br><span>di=
ff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index =
943ad9f=2E=2Ebcea331 100644</span><br><span>--- a/src/openvpn/tun=2Ec</span=
><br><span>+++ b/src/openvpn/tun=2Ec</span><br><span>@@ -666,7 +666,6 @@</s=
pan><br><span> void</span><br><span> warn_on_use_of_common_subnets(openvpn_=
net_ctx_t *ctx)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span>     stru=
ct route_gateway_info rgi;</span><br><span>     const unsigned int needed =
=3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);</span><br><span> </span><br><=
span>@@ -680,7 +679,6 @@</span><br><span>                 &quot;NOTE: your =
local LAN uses the extremely common subnet address 192=2E168=2E0=2Ex or 192=
=2E168=2E1=2Ex=2E  Be aware that this might create routing conflicts if you=
 connect to the VPN server from public locations such as internet cafes tha=
t use the same subnet=2E&quot;);</span><br><span>         }</span><br><span=
>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&a=
mp;gc);</span><br><span> }</span><br><span> </span><br><span> /*</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2149?usp=3Demail">change 2149</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2149?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2149 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--rEgyQX3O4wI=--


--===============6385882026009447123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6385882026009447123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6385882026009447123==--

