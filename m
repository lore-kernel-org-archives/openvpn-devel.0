Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8DE606A31E
	for <openvpn-devel@archiver.kernel.org>; Wed, 25 Nov 2026 18:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OIa06WVZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NVaXyUzi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gdvvgG3Y;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BbJy16BP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FErb8j8WcjvaK9NAHuWdKROF3xSQPOirGL5hF00pIyA=; b=OIa06WVZG49fdbfdaP1pMs5seC
	zJHWwFMD0edh+VP2/e6N8b2r9LxWddwWRM841lfJVhH1nfkHxA3egSE5CYGZNgNVq9KusSp5tV0xG
	pEu8zY6GzysIQTa6IeYLnk8GiI4l1j8lKEtq0xA6GV6kuHAeW1dc7wKHonHiuYwGOCrA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWHed-000000001sS-17ST;
	Wed, 25 Nov 2026 18:23:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWHec-000000001sM-3Z2F
 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:23:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Agm0/hyJ2lO2tw/Y3OVhbEml+GwkEvtDopWNgXehidg=; b=NVaXyUziVByrfrkT0RbusDuiLS
 xPIT+Ra4sxcKtuQPohOJvEqXADJdmQvCYIyM6Xc3rUSl07k9xnhUAFSt1B4iwl7472pXF7QBqjBMc
 ldK2dXloAa31w3NGk6tuASGnPFHR0fgBq0cCCp7oPa476Fgy3cXYEYmTjZG8Ph53MyJ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Agm0/hyJ2lO2tw/Y3OVhbEml+GwkEvtDopWNgXehidg=; b=gdvvgG3YsSWz0h+q4CfB0PqyU4
 Lqbkf5s+2gVyHWoaDsoUg44pvKTERrp99ZFrhZOY04UhE1zis3dHcv5wBPXc3Ng3MsLP/7a2Hjjjd
 5erno7OODIvKin8cLBbKOFvtCnejgYxRWiG5PQqn2XtZ8AYIPO2LmmRh4sfoYQoW3kEM=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWHeb-000000001U9-1YC0 for openvpn-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 18:23:38 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bba60271d7so9142915e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 25 Nov 2026 10:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795631011; x=1796235811; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Agm0/hyJ2lO2tw/Y3OVhbEml+GwkEvtDopWNgXehidg=;
 b=BbJy16BPioEFO77dxCwCmOCUOeaOC0wKJxpNvhIDKyQj7IVwoQv7oKffwif8hQ22Mo
 a5CJ8PfJmkl6kRhBDmyvTRLd8uuj88vIl1Vgv7P0hDbgVSlKJY1C4hE8kaQpeCneT7+c
 D9G/PBwl0G1DMj7jdcpyvktB37YhCxkxMRUWjV7/droeg41YlLLHY8OPt0UloPLAnEFp
 VUiRQ1HDMb8wFhgtdgRfYLc9ySZbEF27dTBw+SgYyVqABK67W3eIQmTv60iK+/PnsSqT
 +Qcap+37iYEl3fh5E2qzU3MLHipi+CEHyJjbDAeSd/6XXwE2yX4qpsypuJQtCVIHm3JF
 VfbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795631011; x=1796235811;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Agm0/hyJ2lO2tw/Y3OVhbEml+GwkEvtDopWNgXehidg=;
 b=wYR+AjEKOJY8VKhRtM26UJOFdoDBTg8cmFW/oZfSvZX/T0TJ/SrH7G7Zvk1uf+0oUZ
 /W4kdXD4L8sb3VqYLx2dSifZdzEB6DcYFxE1eWZ932mUJticbbPU4EWdsFnMyuShV9A4
 N5OSwdErwOPgN6TyOElXfmbDHyEhbR7GIssrtquWr9Lf2JEMQwQhuL4oOrr/9sZZSCN2
 thd0oFLdRSUQw+DTONePtP8kUddix9/lRs5OrBAyk+rFH9+foyy8znIbVL4EUYiMKcfB
 kaLHYb6NCEor7fYTFrXjHXXPY5Ai5812PAeQbWLxuGrjzBqIO4LgFY7ClVD2CszXQdoH
 4nOg==
X-Forwarded-Encrypted: i=1;
 AL+hErG0d8W/AjfOvRBqgFOAmdEtP3FYS8Rp35UtD5vmhm5AEn4h0AMzeucvngCpT5rZwpEY9er8vaRJBGpXRzTv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/MqefNS4YpnlHU4mDcQvIDIQa1ToC4F9k6LyaMQJhmyRd6wel3
 X+GsyyR+aTJVLNM6o7n+uFLUUJgxBucC7JJki/MHUjyYGt6nLiKw512kvZm7robN7DATN0LNLMX
 J1X139c2eRhUktRgyjtkabC/83UkkaLCBzFChcP2pQBvYzbvXzTMOk4Kt4YpTaIpc4k5X471nv6
 IiW2Dsyg==
X-Gm-Gg: AZFdTZciub5QJu0jh7euQDDAhBPLCJFYdCN5vqsS+xUj+LpGtmRx5OHJ5EhWTjdwOS9
 C8geiaGa17d46kQfbf2tMLp1/EZAyts4czPQFrYZwLBgoEtTgS33N192qh4/Mf41NIR6ayuVB4+
 KN9hRh2JX2kfWcVE/XSi9KB75T+XrARbnPo1BLIckq4d/Q2L8KQ9FLVG4NNG10CQ7Tybd8a1QoQ
 IU1zwAFMq3dWrJsD+7wM5wTK8fsYENVS+14d2oKsP4QQ+5j9ihe1dvvxRhsAZr/hmmoztUqVfAU
 Nv23yynXawRW4lNu3bcWA6feO8nEaErzr0zo6xoW5MonmOVHQBQXEqlHLkjExV1WJMPIOBWrQ7y
 MCjKxaaEgPlGF/SpI6NnKvkOz0Ejc2JwbqChbaAs24KIzsb5M0jFV6d5f5/LjLsAxtvpJ7I6LYn
 9BfS+iW7Tsd4H39bOaRJGJV7lYqKgLfcIz5XfsKVTSSJsuCUODyPqulAW0WhOogD6JaQcLRHsz2
 Z6OteUf8VC2JJ3y8dlnGrTPEOC9h3kIzhK/HrQ6dUFtAmwyzT0hsrGEUKlSTDec33WVaw5yFNRg
 r6qi6sFgI09vzfYc+DUCsMLa9GXjcQVCOx2kSKeRhfB4cvAHwXVX7S0safYkGgaqJwQmgirqoqQ
 OBlkuf2UXnBnv8LH4FsdzFhESImIsINvfsGUgRw0Wa3nsDehtSbpzmJ1CdRdvDeFXnpwppj5FJH
 ohV92hmK0O7OycIXU=
X-Received: by 2002:a05:600c:1d09:b0:4bb:6b59:aac3 with SMTP id
 5b1f17b1804b1-4bb88816050mr394332125e9.29.1795631010710; 
 Wed, 25 Nov 2026 10:23:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm522337245e9.15.2026.11.25.10.23.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 10:23:30 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 25 Nov 2026 18:23:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1
X-Gerrit-Change-Number: 2334
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2334?usp=email>
X-Gerrit-Commit: 27d9a806e2ceaccf8155a70ee55dc0b1f5ca82b7
In-Reply-To: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
References: <gerrit.1795515857000.Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTE1ODU3MDAwLkllOTAyZGJjNDVlNGFjYTBjNzJiYzRiNGU4Y2MxZTE3ZDI5YjQ3YWExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e62155acb2702bc46f214c59b90f153430ca6bb-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWHeb-000000001U9-1YC0
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: make the
 options mode an enum
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6275853289184774028=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6275853289184774028==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wWu8mECbza0="; charset=UTF-8

--wWu8mECbza0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2334?usp=3Demail )

Change subject: options: make the options m=
ode an enum
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

o=
ptions: make the options mode an enum

Turn the MODE_* defines into enum op=
tions_mode and use it for the mode
fields and parameters=2E With both modes=
 being distinct enum types,
-Wenum-compare catches comparing a context mode=
 against an options
mode=2E

Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29=
b47aa1
Signed-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Lev=
 Stipakov <lstipakov@gmail=2Ecom>
Gerrit URL: https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2334
Message-Id: <20261124122559=2E8549-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg41880=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/dco=2Ec
M src/openvpn/options=2Ec
M src/openvpn/op=
tions=2Eh
M src/openvpn/ssl_common=2Eh
4 files changed, 11 insertions(+), 7=
 deletions(-)




diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
in=
dex fdee465=2E=2E3c85c11 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn=
/dco=2Ec
@@ -255,7 +255,7 @@
 }
 
 static bool
-dco_check_option_ce(const s=
truct connection_entry *ce, msglvl_t msglevel, int mode)
+dco_check_option_=
ce(const struct connection_entry *ce, msglvl_t msglevel, enum options_mode =
mode)
 {
     if (ce->fragment)
     {
diff --git a/src/openvpn/options=2Ec=
 b/src/openvpn/options=2Ec
index 1a8604e=2E=2E1e0b4d8 100644
--- a/src/open=
vpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -2309,7 +2309,7 @@
 }
 
 s=
tatic void
-options_postprocess_mutate_le(const struct connection_entry *ce=
, struct local_entry *le, int mode)
+options_postprocess_mutate_le(const st=
ruct connection_entry *ce, struct local_entry *le, enum options_mode mode)
=
 {
     /* use the global port if none is specified */
     if (!le->port)
=
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index b390eb=
c=2E=2E0112c5f 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/optio=
ns=2Eh
@@ -252,6 +252,13 @@
     struct verify_hash_list *next;
 };
 
+/** =
Major mode */
+enum options_mode
+{
+    MODE_POINT_TO_POINT,
+    MODE_SER=
VER,
+};
+
 /* Command line options */
 struct options
 {
@@ -260,10 +267,7=
 @@
     /* first config file */
     const char *config;
 
-    /* major m=
ode */
-#define MODE_POINT_TO_POINT 0
-#define MODE_SERVER         1
-    i=
nt mode;
+    enum options_mode mode;
 
     /* enable forward compatibilit=
y for post-2=2E1 features */
     bool forward_compatible;
diff --git a/src=
/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index cfe3fea=2E=2Efe3=
33a3 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=
=2Eh
@@ -324,7 +324,7 @@
 
     /* from command line */
     bool single_se=
ssion;
-    int mode;
+    enum options_mode mode;
     bool pull;
     /**=

      * The detail of info we push in peer info

-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2334?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1
Gerr=
it-Change-Number: 2334
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--wWu8mECbza0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2334?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">options: make the options mode an =
enum<br><br>Turn the MODE_* defines into enum options_mode and use it for t=
he mode<br>fields and parameters=2E With both modes being distinct enum typ=
es,<br>-Wenum-compare catches comparing a context mode against an options<b=
r>mode=2E<br><br>Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47aa1<br>Si=
gned-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Lev=
 Stipakov &lt;lstipakov@gmail=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2334<br>Message-Id: &lt;20261124122559=2E8549-1-gert=
@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-de=
vel@lists=2Esourceforge=2Enet/msg41880=2Ehtml<br>Signed-off-by: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/=
openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/ssl_commo=
n=2Eh<br>4 files changed, 11 insertions(+), 7 deletions(-)<br><br></pre>
<p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>ind=
ex fdee465=2E=2E3c85c11 100644</span><br><span>--- a/src/openvpn/dco=2Ec</s=
pan><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -255,7 +255,7 @@=
</span><br><span> }</span><br><span> </span><br><span> static bool</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_option_ce(const stru=
ct connection_entry *ce, msglvl_t msglevel, int mode)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dco_check_option_ce(const struct connecti=
on_entry *ce, msglvl_t msglevel, enum options_mode mode)</span><br><span> {=
</span><br><span>     if (ce-&gt;fragment)</span><br><span>     {</span><br=
><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span=
><br><span>index 1a8604e=2E=2E1e0b4d8 100644</span><br><span>--- a/src/open=
vpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><sp=
an>@@ -2309,7 +2309,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-option=
s_postprocess_mutate_le(const struct connection_entry *ce, struct local_ent=
ry *le, int mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+op=
tions_postprocess_mutate_le(const struct connection_entry *ce, struct local=
_entry *le, enum options_mode mode)</span><br><span> {</span><br><span>    =
 /* use the global port if none is specified */</span><br><span>     if (!l=
e-&gt;port)</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/open=
vpn/options=2Eh</span><br><span>index b390ebc=2E=2E0112c5f 100644</span><br=
><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/opti=
ons=2Eh</span><br><span>@@ -252,6 +252,13 @@</span><br><span>     struct ve=
rify_hash_list *next;</span><br><span> };</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/** Major mode */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+enum options_mode</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    MODE_POINT_TO_POINT,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    MODE_SERVER,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /* Command line options */</span><br><span> struct opt=
ions</span><br><span> {</span><br><span>@@ -260,10 +267,7 @@</span><br><spa=
n>     /* first config file */</span><br><span>     const char *config;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* =
major mode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
MODE_POINT_TO_POINT 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define MODE_SERVER         1</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int mode;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    enum options_mode mode;</span><br><span> </span><br><span>     /* ena=
ble forward compatibility for post-2=2E1 features */</span><br><span>     b=
ool forward_compatible;</span><br><span>diff --git a/src/openvpn/ssl_common=
=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index cfe3fea=2E=2Efe333a=
3 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+=
++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -324,7 +324,7 @@</span><=
br><span> </span><br><span>     /* from command line */</span><br><span>   =
  bool single_session;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int mode;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
num options_mode mode;</span><br><span>     bool pull;</span><br><span>    =
 /**</span><br><span>      * The detail of info we push in peer info</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2334?usp=3Demail">change 2334</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2334?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ie902dbc45e4aca0c72bc4b4e8cc1e17d29b47=
aa1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2334 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--wWu8mECbza0=--


--===============6275853289184774028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6275853289184774028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6275853289184774028==--

