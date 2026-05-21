Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE284CD4F3D
	for <openvpn-devel@archiver.kernel.org>; Thu, 21 May 2026 13:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bDtqscRaS4ATPRsSxiPEuOkvFaoDym47hC8Xl3rg0LQ=; b=ln9k0Z3TrKw4wtCXfxjhFjDdmP
	6QNdTvzsE0xYPlsGbtvoYZ4Iib95OZR7pbm+AKp/XPZnXlfFO4eGQtO5AY39G1LwelO+axUhcyywP
	2VSMCZpQ9yIEflNPYgwoVVfMEZ/4tQQ8YtU/qwzkZ1Ls3vNLAiN6jd4SHycfCWwH/JiI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQ3pi-0001F9-Lr;
	Thu, 21 May 2026 13:53:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQ3ph-0001F3-0x
 for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 13:53:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iZ9/pe+xAYgSP8X7n2z14YI0WF6iK97CA89zZl4buZY=; b=HzCrWcpDMIfluis+yBWjGNc8pL
 UVNkfWgnMmgLpgXG6nEXc7oc35VEtSQxAUJ0JbuGcmFAlhUfthpQA+AgJazhTViGSj2iJrj4YQvxJ
 pLrARVNuGTLmL/OYLt5QX4YT2xgN6A0QiMq2iCDr68TfKe69Rg+P3FyeZZX3TLyRDMJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iZ9/pe+xAYgSP8X7n2z14YI0WF6iK97CA89zZl4buZY=; b=S
 wKyZbtM+qMq0LbuFFZLVEkJ+ShYfrccNi93/yoCLq3v/PpHYWO2zN9pwfTisvnIxSLj5nioRsKC+/
 dIurRIzAlgXBJLAL4iTSIFOtd8hk6gmnuC9hK+sWl+01BLpW2wa6cbZr99DCSWWfn/zbDaYD4DNJr
 AqcHh2VqeT+G/RUQ=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQ3pb-0005nT-Dl for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 13:53:02 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4903997fcb5so7134375e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 21 May 2026 06:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779371573; x=1779976373; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iZ9/pe+xAYgSP8X7n2z14YI0WF6iK97CA89zZl4buZY=;
 b=KGDnIXNUE+UhRbv43gwgaR6hBNvxCOrRblBaYMItKra1RIKaE5NHfjfrHNNMYhPstU
 pjI4XLnXXcaZD1t8rPochnNBNbhv2f5F3zl94gi6EU/AKT9oxbI57urv3Y1q3EJvIP3a
 B0+6DhZvENgVW6sD6tPXoEjPaZIpa0cJJMVRC3+bR5p0lf/KICHMh5nf8JfSDp9x/6DR
 F6QRNlFtTEw9asFaOb6uywXxn9GP6SYMGJaT5WCFyYAnyWL711PTSq8McMRbZCFMpJ0n
 rj5zCMj7WQnSApWzsXga8qLpqEqvHvIvQ9F+/RqskrMkjxrFGSXV3lY+TGesgnI9eEzC
 BWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779371573; x=1779976373;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iZ9/pe+xAYgSP8X7n2z14YI0WF6iK97CA89zZl4buZY=;
 b=DJ82Qoa89sgsrKal99w0QnNAEjjEHVCkLA69IbLfFe+I1PzF1ecyfy47Ncle9v1r7H
 UymJJW6J0JwYtjqoWCFQBj0Nm65hpmrTyuFcikdabGAMbM5dsqsalhxWdCOZt40F/qQe
 R3DQhTOOgvBTwatHtjO4i78OSeKK8Y6xcGIxbxh6TMuQXtFzYtMRKifTnczDHzGjASNa
 +odctTXtcOWSCc1WWVP5VBEiyeH0U/MQfBkQENSMcVRSFokSZoAOi9plHxAmJtfX7ZS3
 mTo1WUqMcHlBgxMdIBHrREY5mtu5eA7BsZTw/Yxge7OMzUzFC4N3ktNPrrJnFwDzbfki
 KEFw==
X-Gm-Message-State: AOJu0YxuaLewybljgWuvCFS6R+iXYqrNXs7vC8EfA4EfsXImHxw4tHOy
 saMn41OA1pe5WrGux7XKdfXbHffqdovt4yYsAaekyu0JUxsZcsr8wvLsbjAe3MaQyQke1DM6cgx
 IqkLpjoiC84W2h6tbQjYPpDGyvbd9v31hM6c7yn5olhfbl1qCx/UxTQ+lGW6NElC6YmLyf4k17h
 1vpW9rcQ==
X-Gm-Gg: Acq92OGe1BhZpuRIowpvOITFDwTe8HaMUj3BOxu0yfQPiu5zf1JzA+Zk3mI2V73c2gD
 zajUT7mFX4lGJgeoq3HIze+vqSZOkIPaOEeJ08qVgUmSzQM246HL0VgO/VukfKDM/D0+QlCXYJ1
 R+CW7qEI0NHzGMCiNjckI7FPjFPbUN02fQ740JxnM3tCuQ99NkVsCTZz3/m/V+D1GuMq2Hw+UXX
 AGV1FYc8fyfmFOBJsoI9jePjTjqaCpUJ2kxAWQScteF/WfureHkdluOl2Xc2AoKCNpXAnPfTalg
 ZD9G0WTgJfZ9FblEFTepwsxgguSjiyvArtoBvxtb8Vg+JvBlygvIbMXKHeDbkNG68+tg/JvlZdq
 PpO6zOdbzMKCSPCoQuXpYFLXSwjdC+Dr+IwYP4F83nwsl6ZT537YeILBH4YL0zZb5HNm4wQVOR2
 xtWqhogj3q6BgsxtqdA+xa5HIE3da4CPmbDEdeOY4GVx6S2xNr5SgR/szFOr2k4JWM1hPck+K0T
 6C4oU8qKnDMLUZod8aJTZu/jP39G6XAF0oV9SAlJQzAhXeEmxfc+lLVqZM0m+OjKaCwuujL/ckn
 RDJ+PZnMwp2/lPANJjTU87So
X-Received: by 2002:a05:600c:8b77:b0:48e:82af:d9 with SMTP id
 5b1f17b1804b1-490360bbdf9mr50959925e9.29.1779371573036; 
 Thu, 21 May 2026 06:52:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035eeac95sm18722035e9.31.2026.05.21.06.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 06:52:52 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 21 May 2026 13:52:50 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: a6f3f92a7bd0ef1c026f5ebe7684f9494cf2deb1
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bfa0bb629e05904dabe8c4542d92e3f75382e653-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQ3pb-0005nT-Dl
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove iroute
 at client exit time instead of delayed exit
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3805820335190601057=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3805820335190601057==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zgMR8wLFSLk="; charset=UTF-8

--zgMR8wLFSLk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail

to look at=
 the new patch set (#5)=2E

The following approvals got outdated and were r=
emoved:
Code-Review-1 by flichtenheld


Change subject: dco: remove iroute =
at client exit time instead of delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: remove iroute at client exit time inst=
ead of delayed exit

When a client exits due to one of the following reason=
s:
* EEN received
* AUTH_FAILED sent
* RESTART sent
OpenVPN will perform so=
me minimal cleanup and will
then postpone the actual instance purge by 5 se=
conds=2E

If iroutes are configured for the exiting client, the actual DCO
=
iroutes removal is also postponed=2E

If during this time window the same c=
lient reconnects, a new
instance is created (for example because --duplicat=
e-cn is set or
because the same username is provided upon authentication) a=
nd the
same IP is assigned, then OpenVPN will:

* create the new client ins=
tance;
* attempt adding the related DCO iroutes (which will fail because
  =
EEXIST);
* 5 seconds timeout fires -> execute the delayed exit routine and
=
  delete the DCO iroutes;
* no iroutes exists anymore on the server despite=
 the client being
  fully connected=2E

Note that this issue is DCO specifi=
c, because without DCO OpenVPN
creates virtual routes (no system routing ta=
ble involved) and makes
the last connecting client own them=2E
This means t=
hat the delayed exit routine won't have any iroute to
delete=2E

With this =
patch we move the DCO iroutes deletion to the actual
client exit time in or=
der to avoid racing with a possible addition
being executed when the client=
 reconnects=2E The new flow will be:

* client exits (due to EEN or timeout=
)
* DCO iroutes are immediately deleted
* client re-connects -> new instanc=
e created
* DCO iroutes are added -> SUCCESS
* 5 seconds timeout fires -> o=
ld instance client is fully purged
* client is connected and iroutes are in=
 place as expected

This issue was reported by OpenVPN Access Server develo=
pers after
observing erratic iroutes disappearance with DCO in place=2E

Ch=
ange-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
GitHub: closes openvpn/O=
penVPN#1040
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
=
M src/openvpn/dco=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/forward=2Eh
M=
 src/openvpn/multi=2Ec
M src/openvpn/openvpn=2Eh
M src/openvpn/push=2Ec
6 f=
iles changed, 33 insertions(+), 6 deletions(-)


  git pull ssh://gerrit=2E=
openvpn=2Enet:29418/openvpn refs/changes/83/1683/5

diff --git a/src/openvp=
n/dco=2Ec b/src/openvpn/dco=2Ec
index 1e6638b=2E=2E403ba2f 100644
--- a/src=
/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -733,6 +733,7 @@
     }
     =
ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
+    msg(D_DCO, =
"DCO: attempt removing iroutes from system table");
 
     if (c->c2=2Epush=
_ifconfig_defined)
     {
diff --git a/src/openvpn/forward=2Ec b/src/openvp=
n/forward=2Ec
index 27cfd36=2E=2E6c5ab4d 100644
--- a/src/openvpn/forward=
=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -525,7 +525,7 @@
  * Schedule a SIGTE=
RM signal c->options=2Escheduled_exit_interval seconds from now=2E
  */
 bo=
ol
-schedule_exit(struct context *c)
+schedule_exit(openvpn_net_ctx_t *net_=
ctx, struct context *c)
 {
     const int n_seconds =3D c->options=2Eschedu=
led_exit_interval;
     /* don't reschedule if already scheduled=2E */
@@ -=
533,6 +533,23 @@
     {
         return false;
     }
+
+    /* DCO iroutes=
 must be removed now, because the delay introduced by this
+     * timer ca=
n create a race condition:
+     * the same client may reconnect before the=
 old instance is purged, leading
+     * to DCO iroutes removal *after* rec=
onnection, thus killing the routes
+     * for the new instance too=2E
+   =
  *
+     * Standard/virtual iroutes (non-DCO case) are not affected becaus=
e the
+     * last connecting client claiming the iroutes takes ownership=
=2E Therefore
+     * they are not removed during delayed cleanup=2E
+     =
*/
+    if (c->did_dco_iroutes)
+    {
+        c->did_dco_iroutes =3D fals=
e;
+        dco_delete_iroutes(net_ctx, c);
+    }
+
     tls_set_single_se=
ssion(c->c2=2Etls_multi);
     update_time();
     reset_coarse_timers(c);
=
diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 0d3e49=
2=2E=2E374e1df 100644
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forwa=
rd=2Eh
@@ -331,7 +331,7 @@
 void process_ip_header(struct context *c, unsig=
ned int flags, struct buffer *buf,
                        struct link_sock=
et *sock);
 
-bool schedule_exit(struct context *c);
+bool schedule_exit(op=
envpn_net_ctx_t *net_ctx, struct context *c);
 
 static inline struct link_=
socket_info *
 get_link_socket_info(struct context *c)
diff --git a/src/ope=
nvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a72dcd1=2E=2Eac9b986 100644
--=
- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -479,7 +479,12 @@
=
     const struct iroute *ir;
     const struct iroute_ipv6 *ir6;
 
-    dc=
o_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
+    /* check if DCO iro=
utes were already removed when scheduling a delayed exit */
+    if (mi->co=
ntext=2Edid_dco_iroutes)
+    {
+        mi->context=2Edid_dco_iroutes =3D =
false;
+        dco_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
+    }=

 
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
   =
  {
@@ -1278,6 +1283,8 @@
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =
=3D=3D DEV_TYPE_TUN)
     {
         mi->did_iroutes =3D true;
+        /* =
multi_learn_in{6}_addr_t takes care of installing the DCO iroute */
+      =
  mi->context=2Edid_dco_iroutes =3D true;
         for (ir =3D mi->context=
=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir->next)
         {
           =
  if (ir->netbits >=3D 0)
diff --git a/src/openvpn/openvpn=2Eh b/src/openvp=
n/openvpn=2Eh
index fa00822=2E=2E5747175 100644
--- a/src/openvpn/openvpn=
=2Eh
+++ b/src/openvpn/openvpn=2Eh
@@ -507,6 +507,8 @@
     bool did_we_dae=
monize;       /**< Whether demonization has already
                       =
            *   taken place=2E */
 
+    bool did_dco_iroutes;        /**< =
Whether DCO iroutes have been installed */
+
     struct context_persist pe=
rsist;
     /**< Persistent %context=2E */
     struct context_0 *c0; /**< =
Level 0 %context=2E */
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=
=2Ec
index 564ce86=2E=2E50053e9 100644
--- a/src/openvpn/push=2Ec
+++ b/src=
/openvpn/push=2Ec
@@ -202,7 +202,7 @@
      * */
     if (c->options=2Emode=
 =3D=3D MODE_SERVER)
     {
-        if (!schedule_exit(c))
+        if (!s=
chedule_exit(&c->net_ctx, c))
         {
             /* Return early when =
we don't need to notify management */
             return;
@@ -392,7 +392,7=
 @@
 void
 send_auth_failed(struct context *c, const char *client_reason)
 =
{
-    if (!schedule_exit(c))
+    if (!schedule_exit(&c->net_ctx, c))
    =
 {
         msg(D_TLS_DEBUG, "exit already scheduled for context");
       =
  return;
@@ -493,7 +493,7 @@
 void
 send_restart(struct context *c, const =
char *kill_msg)
 {
-    schedule_exit(c);
+    schedule_exit(&c->net_ctx, c=
);
     send_control_channel_string(c, kill_msg ? kill_msg : "RESTART", D_P=
USH);
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/16=
83?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ba72=
3d12d433e6e020588b7b0c3ba10bcf8c44f
Gerrit-Change-Number: 1683
Gerrit-Patch=
Set: 5
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>

--zgMR8wLFSLk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>ordex <strong>uplo=
aded patch set #5</strong> to this change=2E</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change</a></p><p>The fo=
llowing approvals got outdated and were removed:
Code-Review-1 by flichtenh=
eld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">dco: remove iroute at client exit time instead of dela=
yed exit<br><br>When a client exits due to one of the following reasons:<br=
>* EEN received<br>* AUTH_FAILED sent<br>* RESTART sent<br>OpenVPN will per=
form some minimal cleanup and will<br>then postpone the actual instance pur=
ge by 5 seconds=2E<br><br>If iroutes are configured for the exiting client,=
 the actual DCO<br>iroutes removal is also postponed=2E<br><br>If during th=
is time window the same client reconnects, a new<br>instance is created (fo=
r example because --duplicate-cn is set or<br>because the same username is =
provided upon authentication) and the<br>same IP is assigned, then OpenVPN =
will:<br><br>* create the new client instance;<br>* attempt adding the rela=
ted DCO iroutes (which will fail because<br>  EEXIST);<br>* 5 seconds timeo=
ut fires -&gt; execute the delayed exit routine and<br>  delete the DCO iro=
utes;<br>* no iroutes exists anymore on the server despite the client being=
<br>  fully connected=2E<br><br>Note that this issue is DCO specific, becau=
se without DCO OpenVPN<br>creates virtual routes (no system routing table i=
nvolved) and makes<br>the last connecting client own them=2E<br>This means =
that the delayed exit routine won&#39;t have any iroute to<br>delete=2E<br>=
<br>With this patch we move the DCO iroutes deletion to the actual<br>clien=
t exit time in order to avoid racing with a possible addition<br>being exec=
uted when the client reconnects=2E The new flow will be:<br><br>* client ex=
its (due to EEN or timeout)<br>* DCO iroutes are immediately deleted<br>* c=
lient re-connects -&gt; new instance created<br>* DCO iroutes are added -&g=
t; SUCCESS<br>* 5 seconds timeout fires -&gt; old instance client is fully =
purged<br>* client is connected and iroutes are in place as expected<br><br=
>This issue was reported by OpenVPN Access Server developers after<br>obser=
ving erratic iroutes disappearance with DCO in place=2E<br><br>Change-Id: I=
0ba723d12d433e6e020588b7b0c3ba10bcf8c44f<br>GitHub: closes openvpn/OpenVPN#=
1040<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br=
>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn=
/forward=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/openvpn=2Eh<br>M s=
rc/openvpn/push=2Ec<br>6 files changed, 33 insertions(+), 6 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/83/1683/5</pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/ope=
nvpn/dco=2Ec</span><br><span>index 1e6638b=2E=2E403ba2f 100644</span><br><s=
pan>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</sp=
an><br><span>@@ -733,6 +733,7 @@</span><br><span>     }</span><br><span>   =
  ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, =
&quot;DCO: attempt removing iroutes from system table&quot;);</span><br><sp=
an> </span><br><span>     if (c-&gt;c2=2Epush_ifconfig_defined)</span><br><=
span>     {</span><br><span>diff --git a/src/openvpn/forward=2Ec b/src/open=
vpn/forward=2Ec</span><br><span>index 27cfd36=2E=2E6c5ab4d 100644</span><br=
><span>--- a/src/openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forw=
ard=2Ec</span><br><span>@@ -525,7 +525,7 @@</span><br><span>  * Schedule a =
SIGTERM signal c-&gt;options=2Escheduled_exit_interval seconds from now=2E<=
/span><br><span>  */</span><br><span> bool</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-schedule_exit(struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+schedule_exit(openvpn_net_ctx_t *net_ctx,=
 struct context *c)</span><br><span> {</span><br><span>     const int n_sec=
onds =3D c-&gt;options=2Escheduled_exit_interval;</span><br><span>     /* d=
on&#39;t reschedule if already scheduled=2E */</span><br><span>@@ -533,6 +5=
33,23 @@</span><br><span>     {</span><br><span>         return false;</spa=
n><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* DCO iroutes m=
ust be removed now, because the delay introduced by this</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * timer can create a race conditi=
on:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the same =
client may reconnect before the old instance is purged, leading</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * to DCO iroutes removal *=
after* reconnection, thus killing the routes</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * for the new instance too=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * Standard/virtual iroutes (non-DCO case) a=
re not affected because the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * last connecting client claiming the iroutes takes ownership=
=2E Therefore</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 they are not removed during delayed cleanup=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (c-&gt;did_dco_iroutes)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        c-&gt;did_dco_iroutes =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        dco_delete_iroutes(net_ctx, c);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     tls_set_singl=
e_session(c-&gt;c2=2Etls_multi);</span><br><span>     update_time();</span>=
<br><span>     reset_coarse_timers(c);</span><br><span>diff --git a/src/ope=
nvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><br><span>index 0d3e492=2E=
=2E374e1df 100644</span><br><span>--- a/src/openvpn/forward=2Eh</span><br><=
span>+++ b/src/openvpn/forward=2Eh</span><br><span>@@ -331,7 +331,7 @@</spa=
n><br><span> void process_ip_header(struct context *c, unsigned int flags, =
struct buffer *buf,</span><br><span>                        struct link_soc=
ket *sock);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-bool schedule_exit(struct context *c);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+bool schedule_exit(openvpn_net_ctx_t *net_ctx, s=
truct context *c);</span><br><span> </span><br><span> static inline struct =
link_socket_info *</span><br><span> get_link_socket_info(struct context *c)=
</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec=
</span><br><span>index a72dcd1=2E=2Eac9b986 100644</span><br><span>--- a/sr=
c/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><=
span>@@ -479,7 +479,12 @@</span><br><span>     const struct iroute *ir;</sp=
an><br><span>     const struct iroute_ipv6 *ir6;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    dco_delete_iroutes(&amp;m-=
&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* check if DCO iroutes were already removed when =
scheduling a delayed exit */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (mi-&gt;context=2Edid_dco_iroutes)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes =3D false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_delete_iroutes=
(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     i=
f (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br=
><span>     {</span><br><span>@@ -1278,6 +1283,8 @@</span><br><span>     if=
 (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br>=
<span>     {</span><br><span>         mi-&gt;did_iroutes =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* multi_learn_in{6}=
_addr_t takes care of installing the DCO iroute */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes =3D=
 true;</span><br><span>         for (ir =3D mi-&gt;context=2Eoptions=2Eirou=
tes; ir !=3D NULL; ir =3D ir-&gt;next)</span><br><span>         {</span><br=
><span>             if (ir-&gt;netbits &gt;=3D 0)</span><br><span>diff --gi=
t a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index=
 fa00822=2E=2E5747175 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh<=
/span><br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -507,6 +50=
7,8 @@</span><br><span>     bool did_we_daemonize;       /**&lt; Whether de=
monization has already</span><br><span>                                   *=
   taken place=2E */</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool did_dco_iroutes;        /**&lt; Whether DCO iro=
utes have been installed */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span>     struct context_persist persist;</span><br><sp=
an>     /**&lt; Persistent %context=2E */</span><br><span>     struct conte=
xt_0 *c0; /**&lt; Level 0 %context=2E */</span><br><span>diff --git a/src/o=
penvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 564ce86=2E=2E5=
0053e9 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>++=
+ b/src/openvpn/push=2Ec</span><br><span>@@ -202,7 +202,7 @@</span><br><spa=
n>      * */</span><br><span>     if (c-&gt;options=2Emode =3D=3D MODE_SERV=
ER)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (!schedule_exit(c))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!schedule_exit(&amp;c-&gt;net_ctx, c))</span><b=
r><span>         {</span><br><span>             /* Return early when we don=
&#39;t need to notify management */</span><br><span>             return;</s=
pan><br><span>@@ -392,7 +392,7 @@</span><br><span> void</span><br><span> se=
nd_auth_failed(struct context *c, const char *client_reason)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!schedule=
_exit(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!s=
chedule_exit(&amp;c-&gt;net_ctx, c))</span><br><span>     {</span><br><span=
>         msg(D_TLS_DEBUG, &quot;exit already scheduled for context&quot;);=
</span><br><span>         return;</span><br><span>@@ -493,7 +493,7 @@</span=
><br><span> void</span><br><span> send_restart(struct context *c, const cha=
r *kill_msg)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    schedule_exit(c);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    schedule_exit(&amp;c-&gt;net_ctx, c);</span><br><span>     =
send_control_channel_string(c, kill_msg ? kill_msg : &quot;RESTART&quot;, D=
_PUSH);</span><br><span> }</span><br><span> </span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
683?usp=3Demail">change 1683</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1683?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1683 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> G=
errit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--zgMR8wLFSLk=--


--===============3805820335190601057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3805820335190601057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3805820335190601057==--

