Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05580606A326
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 17:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QvY39bg8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Nn0TdGEL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MUh9A2g1;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fqRIy8Jj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=eclajUGheu+WOaCH6A91JJUc/QbiTQJ3Z2JH3VQFVJw=; b=QvY39bg8ja/ZBugwTaXXlSFa+k
	qGybwqfV0thMWxkUJE/8NSpkJbEgdxCeMo/9BQGJIEqzKd0LxWBQidXAtj6PAodcUDqivn3qCF4cI
	nc4TKm3rd/6eUvvVPRiYQWLKY9Pbv9z+JzesGmv5Og7xLmqOXk/2LpZr8lCT4psZ2SVA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQT9v-000000005j6-1hf5;
	Mon, 09 Nov 2026 17:27:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQT9u-000000005j0-0zID
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Swsm+AYUzomYG6my1aOj8O8dE8gM3jr5jnEB8f5F1S4=; b=Nn0TdGEL3lNYUZguAwVTKPl8/L
 8906hdbG+lVIiymIuyRso1nE2yuw+lMtl7IhWIRpo473FGQkV4kzKhEWs/xbmFfKTbhzfzYBUQQqm
 fRS5UjYu7wukoJy4niwx4UWMY06qNI+StyJ0CHVtivK8uCudrGbklOeMdlRW/WThDDec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Swsm+AYUzomYG6my1aOj8O8dE8gM3jr5jnEB8f5F1S4=; b=MUh9A2g133TBIXXOqLi7OtPD/0
 8WXQYEEZol9G2mcnLx300v6bP7vKhCcBU9b49tkuuiYolBQPR8Lb+hPvIiGNOFsIEPkHI4DwyxX3u
 v95XYLv9tmWfFWNr3FvaocptCcwEhD07L9TnZ66occBFKA6n2353kQzsNaFBw17kMI+w=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQT9r-000000004wl-0p7r for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 17:27:54 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a59100fa83so9796945e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 09:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794245265; x=1794850065; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Swsm+AYUzomYG6my1aOj8O8dE8gM3jr5jnEB8f5F1S4=;
 b=fqRIy8JjX7DvzI3mGIbZiuvaRnXEjy+xUH+Pv4hZNUKMqaZdRcCpcHaLadN6LQHCes
 etPmH/m4YYmKFAidPNZOOY0ov1wHchznBhJEN2KD3WF9c9X5Wn9kCvyJTej2LuTgdNop
 fnNHeVnnA5sluIPsZncUrUlHXWMOaPTpWP7n85MZoXPKC2gSmxj9BpmovSE5/Edrdh8R
 h5VkTVhjIhBflRjCFCkXSrN0DB6rU/kuiBPy3TRgKkWyK0IV/MywWSlTUT3mZyWZ9tkV
 Nt2HeGmpaBigbVBo0mrYfDE/t26Qd32FSfHijxqCO5Hsfz61yCC5aRVT2XuhgVIMgGF9
 xJug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794245265; x=1794850065;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Swsm+AYUzomYG6my1aOj8O8dE8gM3jr5jnEB8f5F1S4=;
 b=Pq93FLIEMp6531iKy10zItjc5S9lBne/WM+cuPq0xEoHDteIQTS2yx4TINhPnJzXi6
 ed7Ni1fB1RbYg0zRXn6RxBkPw1XoyoI5j6gq0VdqG5aXKMfwUgkLLqszBqk9zbYJbefK
 tdpcUJ7kvKDTwVqJS/a0ZnMzEuGmlG73DC7DcEEFZfodjuFicr2ruFMYR8wjo39Rly23
 y5Z7mGtaXHKymqxgEDw3E75bBxuSmcfUo3d0VPsLO7aIRR8BbRaeBhOeUkEhCcJHspW4
 1FIg+6ZF90GbBma1GiO+YXljsKO6SWFFDwMkZQvLCkS+9uESOhULDES2HMLN2RQbVPGR
 1RHw==
X-Gm-Message-State: APuU4Z9lafchBbsvx5vWfqwpNf7eCiGQI2atPdZSlts7EyaUSRzqmLXX
 gaMxXZPZVUhVtjmo1HSjrQHKV+kNnNpl/oLDoLvYkRUrs407mwOAfyqyF0+hDTBE2mkGO+WDEN5
 XUiMfhIrNfroQXxoG83FXhVBrkMaF8ZF2I1b3LbohKZYzzXG0WD6OjNLNE0IObHNij4ka
X-Gm-Gg: AYBFou3Oe3oQNc1bkIV2rSBMJ+NEST0/JCwHlxxnD/jH+XvW3kYgA08ueZuE9VcjR5x
 TCfByZEzKlur6dBHUKjEwli1mq0aftrsmoH+2XuR723XHd0GW/QqGBZ9uXnP6MwlRZ4NtrAcSWj
 +8LNQdJ25L/c1DLXykiURSVhry9IgoX+AdFkEwPCoFii5X5PMY6qkB3JvMgGk+A1rS1M36hSaeH
 p8Ife0thO33ZSNN8oQJ+mxdR3eEjy7jKD5eIgOKBFngr1fNfGN7mCD/pIc+EDGYrQbQZFFlxlC9
 xFKqGyoV1O7jSezyEjW4ka4HsXaoytwOGDdxRVLujkjQKRnXpasX0tQqh1QQTxUbKAzbDFc4fYM
 xgLRTPwB9psquDrwZ5NlRUOoPvq3H8ZzmZreKfQynGa6x7pGbZ516QH9dXlWdPPL2WQkB7tJBNs
 QeH+3Om+jMXf6QLnZ0ury2tkJqv9v++YY5PPrGa5xJ77G04C1dGrmCHgJ9CfeUu5YIXVXL9pZBT
 b/e3tBMGzI07ujWMdeY8GNFwYDceCg6Bgo0xnPSKC0gpBIP3KCBjp/SNFM8+VLFopn5nb+Bc1Nl
 fyok9ZtNH1ff2iYKu0OPwyQMgw5/z3uw8NbadPgb7xKmhMkBJD4xJ9LaE0h6ICW24VTkxK8/hZF
 qSmtIiVp+iySuHzTCfltjK5NDzxNraOyi+IQ7Md5tYJceOdIMlsZdpEeK6NBooyS0YehorVOLjb
 DIabiLB0p6xu7VzQ==
X-Received: by 2002:a05:600c:1d18:b0:4a6:42cc:bf6c with SMTP id
 5b1f17b1804b1-4b960d9bb75mr88399085e9.7.1794245264415; 
 Mon, 09 Nov 2026 09:27:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba020433casm1238405e9.7.2026.11.09.09.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 09:27:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 17:27:42 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f
X-Gerrit-Change-Number: 2149
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2149?usp=email>
X-Gerrit-Commit: 83c988d49fddc7e0ad9c40741ab6f391f236ed45
In-Reply-To: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
References: <gerrit.1794064434000.Iefcc3cb90f3e6b036a584a74268678dbc17da69f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MDY0NDM0MDAwLkllZmNjM2NiOTBmM2U2YjAzNmE1ODRhNzQyNjg2NzhkYmMxN2RhNjlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <30581871d7cc1cb75797a75fa558caab86d2290f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQT9r-000000004wl-0p7r
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0349785752763619300=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0349785752763619300==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4EAvHWSoNVc="; charset=UTF-8

--4EAvHWSoNVc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by R=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2149?usp=3Demail )

The following approvals got outdated and were removed=
:
Code-Review+2 by Frank Lichtenheld


Change subject: Remove unused gc_are=
na variables
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Remove unused gc_arena variables

These functions create and free a gc_ar=
ena they never allocate from=2E

Change-Id: Iefcc3cb90f3e6b036a584a74268678=
dbc17da69f
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL: https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2149
Message-Id: <20261109124623=2E26716-1-gert@gr=
eenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40981=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/openvpn/manage=2Ec
M src/o=
penvpn/multi=2Ec
M src/openvpn/options_string=2Ec
M src/openvpn/plugin=2Ec
=
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/tun=2Ec
8 fi=
les changed, 0 insertions(+), 32 deletions(-)


  git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/49/2149/2

diff --git a/src/openvpn=
/init=2Ec b/src/openvpn/init=2Ec
index ff3bfe5=2E=2E3bc4de4 100644
--- a/sr=
c/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -117,8 +117,6 @@
         =
    const char *ifconfig_remote, const char *context, const char *signal_te=
xt,
             const char *script_type, struct env_set *es)
 {
-    struc=
t gc_arena gc =3D gc_new();
-
     if (signal_text)
     {
         setenv_=
str(es, "signal", signal_text);
@@ -174,8 +172,6 @@
         openvpn_run_sc=
ript(&argv, es, S_FATAL, "--up/--down");
         argv_free(&argv);
     }
=
-
-    gc_free(&gc);
 }
 
 /*
diff --git a/src/openvpn/manage=2Ec b/src/ope=
nvpn/manage=2Ec
index 3e3b1c2=2E=2E581e7be 100644
--- a/src/openvpn/manage=
=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2325,9 +2325,7 @@
 
     if (!ignore_=
sys_error(err, crt_error))
     {
-        struct gc_arena gc =3D gc_new();=

         msg(D_MANAGEMENT, "MANAGEMENT: TCP %s error: %s", prefix, strerro=
r(err));
-        gc_free(&gc);
         return true;
     }
     else
@@ -=
3151,11 +3149,8 @@
 management_notify_client_cr_response(unsigned mda_key_i=
d, const struct man_def_auth_context *mdac,
                               =
       const struct env_set *es, const char *response)
 {
-    struct gc_ar=
ena gc;
     if (management)
     {
-        gc =3D gc_new();
-
         ms=
g(M_CLIENT, ">CLIENT:CR_RESPONSE,%lu,%u,%s", mdac->cid, mda_key_id, respons=
e);
         man_output_extra_env(management, "CLIENT");
         if (manag=
ement->connection=2Eenv_filter_level > 0)
@@ -3163,7 +3158,6 @@
           =
  man_output_peer_info_env(management, mdac);
         }
         man_outpu=
t_env(es, true, management->connection=2Eenv_filter_level, "CLIENT");
-    =
    gc_free(&gc);
     }
 }
 
diff --git a/src/openvpn/multi=2Ec b/src/open=
vpn/multi=2Ec
index 03844fb=2E=2Ebcaa012 100644
--- a/src/openvpn/multi=2Ec=

+++ b/src/openvpn/multi=2Ec
@@ -726,7 +726,6 @@
 multi_create_instance(str=
uct multi_context *m, const struct mroute_addr *real,
                     =
  struct link_socket *sock)
 {
-    struct gc_arena gc =3D gc_new();
     s=
truct multi_instance *mi;
 
     msg(D_MULTI_MEDIUM, "MULTI: multi_create_i=
nstance called");
@@ -792,12 +791,10 @@
     mi->ev_arg=2Etype =3D EVENT_AR=
G_MULTI_INSTANCE;
     mi->ev_arg=2Eu=2Emi =3D mi;
 
-    gc_free(&gc);
   =
  return mi;
 
 err:
     multi_close_instance(m, mi, false);
-    gc_free(=
&gc);
     return NULL;
 }
 
@@ -2213,7 +2210,6 @@
     if (mi->context=2Eo=
ptions=2Eclient_connect_script)
     {
         struct argv argv =3D argv_n=
ew();
-        struct gc_arena gc =3D gc_new();
 
         setenv_str(mi->c=
ontext=2Ec2=2Ees, "script_type", "client-connect");
 
@@ -2249,7 +2245,6 @@=

             ccs_delete_deferred_ret_file(mi);
         }
         argv_fr=
ee(&argv);
-        gc_free(&gc);
     }
     return ret;
 }
diff --git a/s=
rc/openvpn/options_string=2Ec b/src/openvpn/options_string=2Ec
index cfc059=
5=2E=2Eed4d742 100644
--- a/src/openvpn/options_string=2Ec
+++ b/src/openvp=
n/options_string=2Ec
@@ -344,7 +344,6 @@
 bool
 options_cmp_equal_safe(char=
 *actual, const char *expected, size_t actual_n)
 {
-    struct gc_arena gc=
 =3D gc_new();
     bool ret =3D true;
 
     if (actual_n > 0)
@@ -360,7 +=
359,6 @@
             ret =3D !strcmp(actual, expected);
         }
     }
=
-    gc_free(&gc);
     return ret;
 }
 
diff --git a/src/openvpn/plugin=2E=
c b/src/openvpn/plugin=2Ec
index 08461b8=2E=2Ed1f228e 100644
--- a/src/open=
vpn/plugin=2Ec
+++ b/src/openvpn/plugin=2Ec
@@ -560,7 +560,6 @@
 
     if (=
p->plugin_handle && (p->plugin_type_mask & OPENVPN_PLUGIN_MASK(type)))
    =
 {
-        struct gc_arena gc =3D gc_new();
         struct argv a =3D arg=
v_insert_head(av, p->so_pathname);
 
         dmsg(D_PLUGIN_DEBUG, "PLUGIN_=
CALL: PRE type=3D%s", plugin_type_name(type));
@@ -609,7 +608,6 @@
        =
 }
 
         argv_free(&a);
-        gc_free(&gc);
     }
     return stat=
us;
 }
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 535=
50c4=2E=2Ed0d26c6 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rout=
e=2Ec
@@ -3090,7 +3090,6 @@
 void
 get_default_gateway(struct route_gateway=
_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
-    struct gc_arena=
 gc =3D gc_new();
     int sd =3D -1;
     char best_name[IFNAMSIZ];
 
@@ -=
3216,7 +3215,6 @@
     {
         close(sd);
     }
-    gc_free(&gc);
 }
 =

 /* IPv6 implementation using netlink
diff --git a/src/openvpn/socket=2Ec =
b/src/openvpn/socket=2Ec
index 307b5c6=2E=2E1fbd07b 100644
--- a/src/openvp=
n/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -499,7 +499,6 @@
             =
         const struct addrinfo *local, bool do_listen,
                    =
  bool nowait, volatile int *signal_received)
 {
-    struct gc_arena gc =
=3D gc_new();
     socket_descriptor_t new_sd =3D SOCKET_UNDEFINED;
 
     =
CLEAR(*act);
@@ -521,7 +520,6 @@
         get_signal(signal_received);
    =
     if (*signal_received)
         {
-            gc_free(&gc);
          =
   return sd;
         }
 
@@ -552,7 +550,6 @@
 
     tcp_connection_establ=
ished(act);
 
-    gc_free(&gc);
     return new_sd;
 }
 
@@ -803,8 +800,6 =
@@
 static void
 resolve_bind_local(struct link_socket *sock)
 {
-    struc=
t gc_arena gc =3D gc_new();
-
     /* resolve local address if undefined */=

     if (!sock->info=2Elsa->bind_local)
     {
@@ -846,8 +841,6 @@
       =
      sock->info=2Eaf =3D (sa_family_t)sock->info=2Elsa->bind_local->ai_fam=
ily;
         }
     }
-
-    gc_free(&gc);
 }
 
 static void
@@ -2673,7 +2=
666,6 @@
 void
 socket_bind_unix(socket_descriptor_t sd, struct sockaddr_un=
 *local, const char *prefix)
 {
-    struct gc_arena gc =3D gc_new();
     =
const mode_t orig_umask =3D umask(0);
 
     if (bind(sd, (struct sockaddr =
*)local, sizeof(struct sockaddr_un)))
@@ -2683,7 +2675,6 @@
     }
 
     u=
mask(orig_umask);
-    gc_free(&gc);
 }
 
 socket_descriptor_t
diff --git a=
/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
index 943ad9f=2E=2Ebcea331 10064=
4
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/tun=2Ec
@@ -666,7 +666,6 @@
 =
void
 warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)
 {
-    struct =
gc_arena gc =3D gc_new();
     struct route_gateway_info rgi;
     const un=
signed int needed =3D (RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED);
 
@@ -680,7=
 +679,6 @@
                 "NOTE: your local LAN uses the extremely common=
 subnet address 192=2E168=2E0=2Ex or 192=2E168=2E1=2Ex=2E  Be aware that th=
is might create routing conflicts if you connect to the VPN server from pub=
lic locations such as internet cafes that use the same subnet=2E");
       =
  }
     }
-    gc_free(&gc);
 }
 
 /*

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2149?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f
Gerrit-=
Change-Number: 2149
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--4EAvHWSoNVc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by R=C4=
=83zvan Cojocaru=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2149?usp=3Demail">View Change</a></p><p>The following approvals got ou=
tdated and were removed:
Code-Review+2 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Remove unused gc_arena variables<br><br>These functions create and free=
 a gc_arena they never allocate from=2E<br><br>Change-Id: Iefcc3cb90f3e6b03=
6a584a74268678dbc17da69f<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2149<br>Message=
-Id: &lt;20261109124623=2E26716-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg4098=
1=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/init=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/=
multi=2Ec<br>M src/openvpn/options_string=2Ec<br>M src/openvpn/plugin=2Ec<b=
r>M src/openvpn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src/openvpn/tun=
=2Ec<br>8 files changed, 0 insertions(+), 32 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
49/2149/2</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec<=
/span><br><span>index ff3bfe5=2E=2E3bc4de4 100644</span><br><span>--- a/src=
/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><spa=
n>@@ -117,8 +117,6 @@</span><br><span>             const char *ifconfig_rem=
ote, const char *context, const char *signal_text,</span><br><span>        =
     const char *script_type, struct env_set *es)</span><br><span> {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan>     if (signal_text)</span><br><span>     {</span><br><span>         s=
etenv_str(es, &quot;signal&quot;, signal_text);</span><br><span>@@ -174,8 +=
172,6 @@</span><br><span>         openvpn_run_script(&amp;argv, es, S_FATAL=
, &quot;--up/--down&quot;);</span><br><span>         argv_free(&amp;argv);<=
/span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc)=
;</span><br><span> }</span><br><span> </span><br><span> /*</span><br><span>=
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><spa=
n>index 3e3b1c2=2E=2E581e7be 100644</span><br><span>--- a/src/openvpn/manag=
e=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2325=
,9 +2325,7 @@</span><br><span> </span><br><span>     if (!ignore_sys_error(=
err, crt_error))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span>=
         msg(D_MANAGEMENT, &quot;MANAGEMENT: TCP %s error: %s&quot;, prefix=
, strerror(err));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    gc_free(&amp;gc);</span><br><span>         return true;</span><br><span=
>     }</span><br><span>     else</span><br><span>@@ -3151,11 +3149,8 @@</s=
pan><br><span> management_notify_client_cr_response(unsigned mda_key_id, co=
nst struct man_def_auth_context *mdac,</span><br><span>                    =
                  const struct env_set *es, const char *response)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct g=
c_arena gc;</span><br><span>     if (management)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     =
    msg(M_CLIENT, &quot;&gt;CLIENT:CR_RESPONSE,%lu,%u,%s&quot;, mdac-&gt;ci=
d, mda_key_id, response);</span><br><span>         man_output_extra_env(man=
agement, &quot;CLIENT&quot;);</span><br><span>         if (management-&gt;c=
onnection=2Eenv_filter_level &gt; 0)</span><br><span>@@ -3163,7 +3158,6 @@<=
/span><br><span>             man_output_peer_info_env(management, mdac);</s=
pan><br><span>         }</span><br><span>         man_output_env(es, true, =
management-&gt;connection=2Eenv_filter_level, &quot;CLIENT&quot;);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</spa=
n><br><span>     }</span><br><span> }</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>ind=
ex 03844fb=2E=2Ebcaa012 100644</span><br><span>--- a/src/openvpn/multi=2Ec<=
/span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -726,7 +726,=
6 @@</span><br><span> multi_create_instance(struct multi_context *m, const =
struct mroute_addr *real,</span><br><span>                       struct lin=
k_socket *sock)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span>     stru=
ct multi_instance *mi;</span><br><span> </span><br><span>     msg(D_MULTI_M=
EDIUM, &quot;MULTI: multi_create_instance called&quot;);</span><br><span>@@=
 -792,12 +791,10 @@</span><br><span>     mi-&gt;ev_arg=2Etype =3D EVENT_ARG=
_MULTI_INSTANCE;</span><br><span>     mi-&gt;ev_arg=2Eu=2Emi =3D mi;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_fre=
e(&amp;gc);</span><br><span>     return mi;</span><br><span> </span><br><sp=
an> err:</span><br><span>     multi_close_instance(m, mi, false);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br=
><span>     return NULL;</span><br><span> }</span><br><span> </span><br><sp=
an>@@ -2213,7 +2210,6 @@</span><br><span>     if (mi-&gt;context=2Eoptions=
=2Eclient_connect_script)</span><br><span>     {</span><br><span>         s=
truct argv argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span> </span>=
<br><span>         setenv_str(mi-&gt;context=2Ec2=2Ees, &quot;script_type&q=
uot;, &quot;client-connect&quot;);</span><br><span> </span><br><span>@@ -22=
49,7 +2245,6 @@</span><br><span>             ccs_delete_deferred_ret_file(m=
i);</span><br><span>         }</span><br><span>         argv_free(&amp;argv=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&am=
p;gc);</span><br><span>     }</span><br><span>     return ret;</span><br><s=
pan> }</span><br><span>diff --git a/src/openvpn/options_string=2Ec b/src/op=
envpn/options_string=2Ec</span><br><span>index cfc0595=2E=2Eed4d742 100644<=
/span><br><span>--- a/src/openvpn/options_string=2Ec</span><br><span>+++ b/=
src/openvpn/options_string=2Ec</span><br><span>@@ -344,7 +344,6 @@</span><b=
r><span> bool</span><br><span> options_cmp_equal_safe(char *actual, const c=
har *expected, size_t actual_n)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br=
><span>     bool ret =3D true;</span><br><span> </span><br><span>     if (a=
ctual_n &gt; 0)</span><br><span>@@ -360,7 +359,6 @@</span><br><span>       =
      ret =3D !strcmp(actual, expected);</span><br><span>         }</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc=
_free(&amp;gc);</span><br><span>     return ret;</span><br><span> }</span><=
br><span> </span><br><span>diff --git a/src/openvpn/plugin=2Ec b/src/openvp=
n/plugin=2Ec</span><br><span>index 08461b8=2E=2Ed1f228e 100644</span><br><s=
pan>--- a/src/openvpn/plugin=2Ec</span><br><span>+++ b/src/openvpn/plugin=
=2Ec</span><br><span>@@ -560,7 +560,6 @@</span><br><span> </span><br><span>=
     if (p-&gt;plugin_handle &amp;&amp; (p-&gt;plugin_type_mask &amp; OPENV=
PN_PLUGIN_MASK(type)))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        struct gc_arena gc =3D gc_new();</span><br>=
<span>         struct argv a =3D argv_insert_head(av, p-&gt;so_pathname);</=
span><br><span> </span><br><span>         dmsg(D_PLUGIN_DEBUG, &quot;PLUGIN=
_CALL: PRE type=3D%s&quot;, plugin_type_name(type));</span><br><span>@@ -60=
9,7 +608,6 @@</span><br><span>         }</span><br><span> </span><br><span>=
         argv_free(&amp;a);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        gc_free(&amp;gc);</span><br><span>     }</span><br><span>    =
 return status;</span><br><span> }</span><br><span>diff --git a/src/openvpn=
/route=2Ec b/src/openvpn/route=2Ec</span><br><span>index 53550c4=2E=2Ed0d26=
c6 100644</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b=
/src/openvpn/route=2Ec</span><br><span>@@ -3090,7 +3090,6 @@</span><br><spa=
n> void</span><br><span> get_default_gateway(struct route_gateway_info *rgi=
, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();=
</span><br><span>     int sd =3D -1;</span><br><span>     char best_name[IF=
NAMSIZ];</span><br><span> </span><br><span>@@ -3216,7 +3215,6 @@</span><br>=
<span>     {</span><br><span>         close(sd);</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</sp=
an><br><span> }</span><br><span> </span><br><span> /* IPv6 implementation u=
sing netlink</span><br><span>diff --git a/src/openvpn/socket=2Ec b/src/open=
vpn/socket=2Ec</span><br><span>index 307b5c6=2E=2E1fbd07b 100644</span><br>=
<span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/openvpn/socket=
=2Ec</span><br><span>@@ -499,7 +499,6 @@</span><br><span>                  =
    const struct addrinfo *local, bool do_listen,</span><br><span>         =
             bool nowait, volatile int *signal_received)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena g=
c =3D gc_new();</span><br><span>     socket_descriptor_t new_sd =3D SOCKET_=
UNDEFINED;</span><br><span> </span><br><span>     CLEAR(*act);</span><br><s=
pan>@@ -521,7 +520,6 @@</span><br><span>         get_signal(signal_received=
);</span><br><span>         if (*signal_received)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            gc_free(=
&amp;gc);</span><br><span>             return sd;</span><br><span>         =
}</span><br><span> </span><br><span>@@ -552,7 +550,6 @@</span><br><span> </=
span><br><span>     tcp_connection_established(act);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</spa=
n><br><span>     return new_sd;</span><br><span> }</span><br><span> </span>=
<br><span>@@ -803,8 +800,6 @@</span><br><span> static void</span><br><span>=
 resolve_bind_local(struct link_socket *sock)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     /* resolve local address if undefined */</span><br><span>     if (!soc=
k-&gt;info=2Elsa-&gt;bind_local)</span><br><span>     {</span><br><span>@@ =
-846,8 +841,6 @@</span><br><span>             sock-&gt;info=2Eaf =3D (sa_fa=
mily_t)sock-&gt;info=2Elsa-&gt;bind_local-&gt;ai_family;</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free=
(&amp;gc);</span><br><span> }</span><br><span> </span><br><span> static voi=
d</span><br><span>@@ -2673,7 +2666,6 @@</span><br><span> void</span><br><sp=
an> socket_bind_unix(socket_descriptor_t sd, struct sockaddr_un *local, con=
st char *prefix)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span>     con=
st mode_t orig_umask =3D umask(0);</span><br><span> </span><br><span>     i=
f (bind(sd, (struct sockaddr *)local, sizeof(struct sockaddr_un)))</span><b=
r><span>@@ -2683,7 +2675,6 @@</span><br><span>     }</span><br><span> </spa=
n><br><span>     umask(orig_umask);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </s=
pan><br><span> socket_descriptor_t</span><br><span>diff --git a/src/openvpn=
/tun=2Ec b/src/openvpn/tun=2Ec</span><br><span>index 943ad9f=2E=2Ebcea331 1=
00644</span><br><span>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/o=
penvpn/tun=2Ec</span><br><span>@@ -666,7 +666,6 @@</span><br><span> void</s=
pan><br><span> warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t gc_arena gc =3D gc_new();</span><br><span>     struct route_gateway_info =
rgi;</span><br><span>     const unsigned int needed =3D (RGI_ADDR_DEFINED |=
 RGI_NETMASK_DEFINED);</span><br><span> </span><br><span>@@ -680,7 +679,6 @=
@</span><br><span>                 &quot;NOTE: your local LAN uses the extr=
emely common subnet address 192=2E168=2E0=2Ex or 192=2E168=2E1=2Ex=2E  Be a=
ware that this might create routing conflicts if you connect to the VPN ser=
ver from public locations such as internet cafes that use the same subnet=
=2E&quot;);</span><br><span>         }</span><br><span>     }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><sp=
an> }</span><br><span> </span><br><span> /*</span><br></pre><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2149?usp=3Demail">=
change 2149</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/214=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: Iefcc3cb90f3e6b036a584a74268678dbc17da69f </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2149 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--4EAvHWSoNVc=--


--===============0349785752763619300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0349785752763619300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0349785752763619300==--

