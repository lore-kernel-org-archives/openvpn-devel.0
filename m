Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B1CD5BAC
	for <openvpn-devel@archiver.kernel.org>; Thu, 21 May 2026 10:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Igi2d3v3EsU6PPPSKA1/qYnbCTSe0bIaeMIozDdQg70=; b=FAME964gN8Kkaluct+OWHLDCbn
	pIBS2QvMAWodKalWhPpGK/fL1nPxmbkjMOAEBTHB5i7BI6xXBgLEJeiSSkgXY0H0BHiuN1SPFoU/Y
	gm277JOF1eBS8M2ZC8QKadybFiMZ7f6QiCsS5pqrM9jd7FGs1dC1OC0TM79IiGn4RgLk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wQ0Qg-0008KZ-8R;
	Thu, 21 May 2026 10:15:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wQ0QR-0008IF-M4
 for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 10:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YLXczmVHiin9yClKr1UaGo5qhBdZuw/W6iUCCDFi43o=; b=RS5d2Qd6rrP0GS357EBbiWI2wL
 w+uJ6IXTlzAef2tZuV6Pnq+VIVthp+slYr9+YNfVPJ1pQOPkNu1R93+V0+QtycjA1lgYf2sy2qyfc
 Xxzmsc23zg2L2srHb4losU8SNqfEG5fYRa94ypCrc+HrPs2PnwbXO3XeYT7TcxmN4wns=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YLXczmVHiin9yClKr1UaGo5qhBdZuw/W6iUCCDFi43o=; b=C
 rPzAKtAjJlBjAEeuVY9O3qE/LpE0VYCyanJ2mDIEYAkpc9r12xseY4tDRgMnZJKd1kAiBQCZ93M+o
 TxjOPUNpeCWklKh5zFUUPVRc+NsFdsBR/AlOH7qOuSueV6VQw9Kw4Ng/VFKwDHdHNpyu4sX9hKQ03
 9Gsu+odad48D91+A=;
Received: from mail-ed1-f53.google.com ([209.85.208.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wQ0QQ-00062P-2G for openvpn-devel@lists.sourceforge.net;
 Thu, 21 May 2026 10:14:48 +0000
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-672645dbfeaso7640663a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 21 May 2026 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779358480; x=1779963280; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YLXczmVHiin9yClKr1UaGo5qhBdZuw/W6iUCCDFi43o=;
 b=Zh0gwkQZhojbr1h2rGMRrwCMV3QTTtMldQ9Vdep857MEy8SngSlTVy8qXShLRB0Flj
 cFuTyHH0pM3EO4c9HrGq4oWnRLSBzPoX0hqx1Wheb1No9yeQpjmNwwWHeritdc2gR2Ua
 DrtZ/fqWwvbnXTSj5HNdKwRPelxeniX/aOMKWusZVUEBYlZuXPXTgjQ2p3AY4AhtWDWb
 6CzE8v9LQAn8X1UZ0tGLtgUGZlxC8YYywKAQBQ655glCKZocKOuVOIjPdueY2j2/y27Z
 gaQkpLR2e9j9iSNts62MdkO35CepmLlyfeLiMLUHwLi0dXAXDhCBh/solw/b02Ph9bQq
 36lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779358480; x=1779963280;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YLXczmVHiin9yClKr1UaGo5qhBdZuw/W6iUCCDFi43o=;
 b=Jxagyu54waq8qAgoV3D7Gmu2ORwvkFd70VDGK+/YBQTXhGsJi/3/kB9KEqUhfq0JDu
 MYTjWUt5ZsT0l5bxTBTZKhsQ9OuteMMrrRp+EBpRVYFSNccw4goEuhwWvQlAJTTqrtvE
 ADWn36i7c5cd73/+cHaRBSdE72hD897ltGwMT94qlAgtidIewThIzMUDNxoSu9OMIXdp
 CPC5j4jBfnYR33iGD1n8+vP0rT1tX9QFokR0lskC7hERtIhGTo0nQba4mpr4GkAtbSG2
 qWkjos7NAfXGMjTUG8IW2yXzLYUTywPll2OWRdrP928sRBSyTOoaNY5XtnMwKZvbe7qN
 tYpw==
X-Gm-Message-State: AOJu0YxJdvIDzrEk9tHEqzbRJUore9Js07OTsacHnOxmOzYPgUKt1HhX
 ZR6cr3NngXI8lPevkKLST4Yf9zHRk7yEycsKjKe0EkJXCWmY5VH1Trf0apYS0uRvvn8/oxmY3vh
 OiYodrR2AHpY7V1z281S9SGvw4sIce3jexLKrCUuhgiUVxCuVFijVAoMVeapZiNPTnXpz8WlRCP
 WT0MgdNg==
X-Gm-Gg: Acq92OFeSl++ICmLFqIEjmQx0+aG5/4W/TpV60T58RC4SWewgAvsPenE0a50sMbA40d
 DvysOQeVZHFQuVB8EGBXG4D/MmyK+kjgAZdCDVyW0gm+DfaPGSdZKxU7JWT6Mu0z7cxsam/CJd/
 pZjXdKFPa31VjjypPRHpzPLW95drQTRQ05JEy0QyiBKk10hqE+gdY4Ow4rYArTQT4xhXb70WK/t
 gsVSBEp3Yl2f7ZLnKHHC69GBeBV907+mUEYn7rtfeY7Wuv6R80HHFC2yinTXXuGq70pl6p3TDi6
 UrHPMn1fCc2dm+5wmUpb3Fx2XtDF3B1K1VhwMVBFMg5sgdYbQ651i6ElgQbjClUoEOeX1yIlOZw
 Gyi7XDPiO3Iy4hPnJQomCcjANfxXbTZKQ9TdXMb6KN4gVsPFMaIl487vBgnQyIfpelcnRWzGj9W
 r0teA3/Lb7SPFZwrc8Zly6IEANlMTMXfHeygq+gsa06kDZYc1SO+RDNeJDT+mp6t1G76jg4xKzC
 iwTbDEc5pch34hZXmaHcIER6IOdJ6fcw/vfYvykvi+agIaA3GWEynpXSaqFDQDsDWa5jsCDQ/Ov
 Zc9q9wEVfPqtNw==
X-Received: by 2002:a05:600c:a414:b0:48f:e518:d110 with SMTP id
 5b1f17b1804b1-490360ebc07mr24057535e9.32.1779358006989; 
 Thu, 21 May 2026 03:06:46 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49035ee5956sm12477485e9.28.2026.05.21.03.06.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 03:06:46 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 21 May 2026 10:06:43 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 6ba94fe192fc58331f740bae631c15ab08827439
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c5b335ce0ea483f424cd4661b428f3dd07c00fda-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wQ0QQ-00062P-2G
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
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2745651844338825897=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2745651844338825897==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8JSZYzWfrHs="; charset=UTF-8

--8JSZYzWfrHs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1683?usp=3Demail

to look at the new patch set (#4)=2E

=

Change subject: dco: remove iroute at client exit time instead of delayed =
exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: re=
move iroute at client exit time instead of delayed exit

When a exits (beca=
use it sent an EEN or because it's connection
timed out) OpenVPN will perfo=
rm some minimal cleanup and will
then postpone the actual instance purge by=
 5 seconds=2E

If iroutes are configured for the exiting client, the actual=
 DCO
iroutes removal is also postponed=2E

If during this time window the s=
ame client reconnects and a new
instance is created (for example because --=
duplicate-cn is set or
because the same username is provided upon authentic=
ation) OpenVPN
will:

* create the new client instance;
* attempt adding th=
e related DCO iroutes (which will fail because
  EEXIST);
* 5 seconds timeo=
ut fires -> execute the delayed exit routine and
  delete the DCO iroutes;
=
* no iroutes exists anymore on the server despite the client being
  fully =
connected=2E

With this patch we move the DCO iroutes deletion to the actua=
l
client exit time in order to avoid racing with a possible addition
being =
executed when the client reconnects=2E The new flow will be:

* client exit=
s (due to EEN or timeout)
* DCO iroutes are immediately deleted
* client re=
-connects -> new instance created
* DCO iroutes are added -> SUCCESS
* 5 se=
conds timeout fires -> old instance client is fully purged
* client is conn=
ected and iroutes are in place as expected

This issue was reported by Open=
VPN Access Server developers after
observing erratic iroutes disappearance =
with DCO in place=2E

Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
=
GitHub: closes openvpn/OpenVPN#1040
Signed-off-by: Antonio Quartulli <anton=
io@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M src/openvpn/forward=2Ec
M s=
rc/openvpn/forward=2Eh
M src/openvpn/multi=2Ec
M src/openvpn/push=2Ec
5 fil=
es changed, 15 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/83/1683/4

diff --git a/src/openvpn/=
dco=2Ec b/src/openvpn/dco=2Ec
index 1e6638b=2E=2E403ba2f 100644
--- a/src/o=
penvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -733,6 +733,7 @@
     }
     AS=
SERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
+    msg(D_DCO, "D=
CO: attempt removing iroutes from system table");
 
     if (c->c2=2Epush_i=
fconfig_defined)
     {
diff --git a/src/openvpn/forward=2Ec b/src/openvpn/=
forward=2Ec
index 27cfd36=2E=2E74a330f 100644
--- a/src/openvpn/forward=2Ec=

+++ b/src/openvpn/forward=2Ec
@@ -525,7 +525,7 @@
  * Schedule a SIGTERM s=
ignal c->options=2Escheduled_exit_interval seconds from now=2E
  */
 bool
-=
schedule_exit(struct context *c)
+schedule_exit(openvpn_net_ctx_t *net_ctx,=
 struct context *c)
 {
     const int n_seconds =3D c->options=2Escheduled_=
exit_interval;
     /* don't reschedule if already scheduled=2E */
@@ -533,=
6 +533,15 @@
     {
         return false;
     }
+
+    /* DCO iroutes mus=
t be removed now, because the delay introduced by this
+     * timer can cr=
eate a race condition:
+     * the same client may reconnect before the old=
 instance is purged, leading
+     * to DCO iroutes removal *after* reconne=
ction, thus killing the routes
+     * for the new instance too=2E
+     */=

+    dco_delete_iroutes(net_ctx, c);
+
     tls_set_single_session(c->c2=
=2Etls_multi);
     update_time();
     reset_coarse_timers(c);
diff --git =
a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh
index 0d3e492=2E=2E374e=
1df 100644
--- a/src/openvpn/forward=2Eh
+++ b/src/openvpn/forward=2Eh
@@ -=
331,7 +331,7 @@
 void process_ip_header(struct context *c, unsigned int fla=
gs, struct buffer *buf,
                        struct link_socket *sock);
=
 
-bool schedule_exit(struct context *c);
+bool schedule_exit(openvpn_net_c=
tx_t *net_ctx, struct context *c);
 
 static inline struct link_socket_info=
 *
 get_link_socket_info(struct context *c)
diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec
index a72dcd1=2E=2Eda8f822 100644
--- a/src/op=
envpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -479,8 +479,6 @@
     const =
struct iroute *ir;
     const struct iroute_ipv6 *ir6;
 
-    dco_delete_ir=
outes(&m->top=2Enet_ctx, &mi->context);
-
     if (TUNNEL_TYPE(mi->context=
=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
         for (ir =3D mi->contex=
t=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir->next)
diff --git a/src/open=
vpn/push=2Ec b/src/openvpn/push=2Ec
index 564ce86=2E=2E50053e9 100644
--- a=
/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -202,7 +202,7 @@
      =
* */
     if (c->options=2Emode =3D=3D MODE_SERVER)
     {
-        if (!sc=
hedule_exit(c))
+        if (!schedule_exit(&c->net_ctx, c))
         {
   =
          /* Return early when we don't need to notify management */
      =
       return;
@@ -392,7 +392,7 @@
 void
 send_auth_failed(struct context *=
c, const char *client_reason)
 {
-    if (!schedule_exit(c))
+    if (!sche=
dule_exit(&c->net_ctx, c))
     {
         msg(D_TLS_DEBUG, "exit already s=
cheduled for context");
         return;
@@ -493,7 +493,7 @@
 void
 send_re=
start(struct context *c, const char *kill_msg)
 {
-    schedule_exit(c);
+ =
   schedule_exit(&c->net_ctx, c);
     send_control_channel_string(c, kill_=
msg ? kill_msg : "RESTART", D_PUSH);
 }
 

-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: =
master
Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
Gerrit-C=
hange-Number: 1683
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@mandelbi=
t=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>

--8JSZYzWfrHs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex <strong>uploaded patch set=
 #4</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1683?usp=3Demail">View Change</a></p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">dco: remo=
ve iroute at client exit time instead of delayed exit<br><br>When a exits (=
because it sent an EEN or because it&#39;s connection<br>timed out) OpenVPN=
 will perform some minimal cleanup and will<br>then postpone the actual ins=
tance purge by 5 seconds=2E<br><br>If iroutes are configured for the exitin=
g client, the actual DCO<br>iroutes removal is also postponed=2E<br><br>If =
during this time window the same client reconnects and a new<br>instance is=
 created (for example because --duplicate-cn is set or<br>because the same =
username is provided upon authentication) OpenVPN<br>will:<br><br>* create =
the new client instance;<br>* attempt adding the related DCO iroutes (which=
 will fail because<br>  EEXIST);<br>* 5 seconds timeout fires -&gt; execute=
 the delayed exit routine and<br>  delete the DCO iroutes;<br>* no iroutes =
exists anymore on the server despite the client being<br>  fully connected=
=2E<br><br>With this patch we move the DCO iroutes deletion to the actual<b=
r>client exit time in order to avoid racing with a possible addition<br>bei=
ng executed when the client reconnects=2E The new flow will be:<br><br>* cl=
ient exits (due to EEN or timeout)<br>* DCO iroutes are immediately deleted=
<br>* client re-connects -&gt; new instance created<br>* DCO iroutes are ad=
ded -&gt; SUCCESS<br>* 5 seconds timeout fires -&gt; old instance client is=
 fully purged<br>* client is connected and iroutes are in place as expected=
<br><br>This issue was reported by OpenVPN Access Server developers after<b=
r>observing erratic iroutes disappearance with DCO in place=2E<br><br>Chang=
e-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f<br>GitHub: closes openvpn/O=
penVPN#1040<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/forward=2Ec<br>M src/=
openvpn/forward=2Eh<br>M src/openvpn/multi=2Ec<br>M src/openvpn/push=2Ec<br=
>5 files changed, 15 insertions(+), 7 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/168=
3/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><b=
r><span>index 1e6638b=2E=2E403ba2f 100644</span><br><span>--- a/src/openvpn=
/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -733,=
6 +733,7 @@</span><br><span>     }</span><br><span>     ASSERT(TUNNEL_TYPE(=
c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, &quot;DCO: attempt re=
moving iroutes from system table&quot;);</span><br><span> </span><br><span>=
     if (c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br=
><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</span=
><br><span>index 27cfd36=2E=2E74a330f 100644</span><br><span>--- a/src/open=
vpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br><sp=
an>@@ -525,7 +525,7 @@</span><br><span>  * Schedule a SIGTERM signal c-&gt;=
options=2Escheduled_exit_interval seconds from now=2E</span><br><span>  */<=
/span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
schedule_exit(struct context *c)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+schedule_exit(openvpn_net_ctx_t *net_ctx, struct context *c)</=
span><br><span> {</span><br><span>     const int n_seconds =3D c-&gt;option=
s=2Escheduled_exit_interval;</span><br><span>     /* don&#39;t reschedule i=
f already scheduled=2E */</span><br><span>@@ -533,6 +533,15 @@</span><br><s=
pan>     {</span><br><span>         return false;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* DCO iroutes must be removed now, b=
ecause the delay introduced by this</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * timer can create a race condition:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * the same client may reconnect =
before the old instance is purged, leading</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * to DCO iroutes removal *after* reconnection, =
thus killing the routes</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * for the new instance too=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    dco_delete_iroutes(net_ctx, c);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     tls_set_single_session(c-&gt;c=
2=2Etls_multi);</span><br><span>     update_time();</span><br><span>     re=
set_coarse_timers(c);</span><br><span>diff --git a/src/openvpn/forward=2Eh =
b/src/openvpn/forward=2Eh</span><br><span>index 0d3e492=2E=2E374e1df 100644=
</span><br><span>--- a/src/openvpn/forward=2Eh</span><br><span>+++ b/src/op=
envpn/forward=2Eh</span><br><span>@@ -331,7 +331,7 @@</span><br><span> void=
 process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f,</span><br><span>                        struct link_socket *sock);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool sche=
dule_exit(struct context *c);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool schedule_exit(openvpn_net_ctx_t *net_ctx, struct context *c)=
;</span><br><span> </span><br><span> static inline struct link_socket_info =
*</span><br><span> get_link_socket_info(struct context *c)</span><br><span>=
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>=
index a72dcd1=2E=2Eda8f822 100644</span><br><span>--- a/src/openvpn/multi=
=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -479,8 =
+479,6 @@</span><br><span>     const struct iroute *ir;</span><br><span>   =
  const struct iroute_ipv6 *ir6;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    dco_delete_iroutes(&amp;m-&gt;top=2Enet_ct=
x, &amp;mi-&gt;context);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         for (ir =
=3D mi-&gt;context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D ir-&gt;next)</=
span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</sp=
an><br><span>index 564ce86=2E=2E50053e9 100644</span><br><span>--- a/src/op=
envpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@=
@ -202,7 +202,7 @@</span><br><span>      * */</span><br><span>     if (c-&g=
t;options=2Emode =3D=3D MODE_SERVER)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (!schedule_exit(c))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!schedule_exit=
(&amp;c-&gt;net_ctx, c))</span><br><span>         {</span><br><span>       =
      /* Return early when we don&#39;t need to notify management */</span>=
<br><span>             return;</span><br><span>@@ -392,7 +392,7 @@</span><b=
r><span> void</span><br><span> send_auth_failed(struct context *c, const ch=
ar *client_reason)</span><br><span> {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!schedule_exit(c))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!schedule_exit(&amp;c-&gt;net_ctx, c))</span=
><br><span>     {</span><br><span>         msg(D_TLS_DEBUG, &quot;exit alre=
ady scheduled for context&quot;);</span><br><span>         return;</span><b=
r><span>@@ -493,7 +493,7 @@</span><br><span> void</span><br><span> send_res=
tart(struct context *c, const char *kill_msg)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    schedule_exit(c);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    schedule_exit(&amp;c-&gt;n=
et_ctx, c);</span><br><span>     send_control_channel_string(c, kill_msg ? =
kill_msg : &quot;RESTART&quot;, D_PUSH);</span><br><span> }</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">change 1683</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0ba723d12d433=
e6e020588b7b0c3ba10bcf8c44f </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1683 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>

</body></html>
--8JSZYzWfrHs=--


--===============2745651844338825897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2745651844338825897==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2745651844338825897==--

