Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834FACD4F54
	for <openvpn-devel@archiver.kernel.org>; Wed, 20 May 2026 08:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=K7amxVOVI65ucalvx2b50y4/VlUOkaYGrCyZKhqYGTc=; b=W9mm5DMRkCx+lj
	LslYPpmE7EIXt0X7uuYv6AHVx5vG9WlManQxfnSDew9sR2nmJ7G+5vLxh/ssEy2hzea9I6RWGAlf2
	MjCtPEgg1wVoUfDIxxuyRMPmK/Cxf72AbQJ8UgnJbOQNcO/ArwRHGhCpRu0pR2rX2ma8hsWE71r58
	oOA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPcDy-0002Hm-0w;
	Wed, 20 May 2026 08:24:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPcDg-0002Bs-3U
 for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 08:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vEit8V4q9cBNKyd15uWwdlJd2HrRmpCofniPnERBicM=; b=YFWTmj/JnqtqgJq8L8vdVjOlhZ
 6m63yrr/+xCOWgDK5Rvnia2UZmMU0bOnNr4AJs1rUDc+eB/WWmTuMqvXxRfC+AHcNijX3779OK8YU
 eGQPw7Kxn+Uuf3iA52itNKp2rnpgP3i6sYm805xV3nYTEeme75UeuIY8evV4bIt6aK0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vEit8V4q9cBNKyd15uWwdlJd2HrRmpCofniPnERBicM=; b=O
 oTyOLF/Z8PK9qem/C2fib6uzrGSbpagpPh5FgUqpD79kd5OSLeeYwC23TlE4YgH3HlNMvtkBpFe1C
 rTJ3WgSOSFji8Pxu1qgL3MI+YPjQBBR15AorT49Dz/mh/u8aVnPBUmE3o9R1RQWuDHMCjo24bthzk
 wvD8FvwTEF2OKPn0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPcDb-0004cm-8F for openvpn-devel@lists.sourceforge.net;
 Wed, 20 May 2026 08:23:57 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso51219905e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 01:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779265424; x=1779870224; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vEit8V4q9cBNKyd15uWwdlJd2HrRmpCofniPnERBicM=;
 b=KoG5sXG2gzzZR2f3k0CUmDELcX1TsuMl0dukVnRJ2v5nAWz/9so+SBGQDeMgfmSaQB
 rj8t7+HofPn05OAtBuTFBYRiT0lEDftYlKrc5D0YjEztDMMx45y6EKal2koBG3zB9fSq
 hE4VuOnVPcdSB3O+w1ruqIn64VeKj//abnOg5dBLnlsLZkdEc+b5AgXiz18iUah7k7VD
 P+NdOkBnTwuFdL8b6bJtTLLMlOV0bjeNM0C5Df/Wzyj5PwfCyME3vDYGiFENgXtvGlgF
 IsVA/1uvXDkfTgYadnONowb0RK5dzSkWLoz80DmnFucZ6KcRIl/qLL7QgH5q+eivUDb9
 KIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779265424; x=1779870224;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vEit8V4q9cBNKyd15uWwdlJd2HrRmpCofniPnERBicM=;
 b=Ijz6CA4biQX09nBeoqNt3LSUbqDkHsLpQ8F/PZUQB4nEkB4REGf6GMT3Me08wpAJ8M
 aTCLNi53ZM14wvRppAWOed1CTM9SAX09qFlvG5lwZM/lFqls9L3/Z7MDxlbfly9WJLJ0
 pfK2XaZ7dhAhIPlusiMVvgiH5dVERA1EGOW1dlESKgPy8KMFWzf2y8qnKOdmRDZJJMn6
 Sn+v7uxcxE51IsJEDULcwtkiuETQg6heHIMe2HMoJe0DGWPAwFVpDotj0TNuvuH+VsOb
 ebervzz0ROe4Z24g4l0MShCz/qxNLBiga1I0Co0J9BZ6X7k1TSIwUECyRJXbrJyjRfxb
 Uuew==
X-Gm-Message-State: AOJu0YzWZRFmhkw24RMSrLI/K8RhZDglFSpn1whkL6P+tJjlFz9MGpHZ
 VYfKTYcVKg+zyxR6j2Op0New+ipzBFYuQ1SATkV7G1tD4L7Juc9VNv3qmtkjzGuc85WQKDZKjf0
 oPNo6m+q6LP+EWYI4SMoUMhev2e2/62fPeumDvT2JH9KACmT17qBlr3L1HfNHwfrx77GnCxl1C5
 Te1C0fFg==
X-Gm-Gg: Acq92OGEcpPwQUcaV84jq7GVCkcobGFKkVAqE7G8fiTdYotDdme8d0+LuWLN+6LvUE+
 jqdmKKvJaeFrY11BEWnSoL1SYjoEFhlFdU6qW952K9q0fBHkoX4+JxHJAjcE9xyByF6wsRxci5k
 EO+gSm8xzzRipLb/la+dJ/dgxTO1nRzU7arekELD1l6U845wr8jdymDSgB1vaFvkHKU9bzz0aaW
 x3reKRVIxGMo8hw7TLuEjhn+w8TGy/ff10hqK4ouBGaUGc863HVVn2tMH4JWOS/A1nDDBJY+WVe
 QTgUsl0Ds2F1oWi4jBiLOVmq2+SfVAKpV486BPBmJDn2n2zP6Q+gZAYo5uOWCjhJrSyL94f+k6m
 tjsfaCzjqaBY5JrGOiGSgs7JqqMqykGRJqiEU8N0u0gNOtROuwSWfXSmb6kpGFWSWcDgzGgz0jW
 d80We9xaKJuVC9lMTFCDoNLzThUpJAijhHmRLHgOu5hhV5RklejSfpHlmOiHD9djMnR9UCpV30x
 mOsIgxTEpgvF46gZnkP/OsnRMYcm2YYx3hu/tBWjeubjRAZC+1AKWwNYtxLCp69cuy42h1scGR3
 bWSt4msm/Nvxwg==
X-Received: by 2002:a05:600c:a010:b0:48f:e230:2a1e with SMTP id
 5b1f17b1804b1-48fe66316cfmr337510845e9.33.1779265423715; 
 Wed, 20 May 2026 01:23:43 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe5cab7c5sm408765235e9.12.2026.05.20.01.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 01:23:43 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 20 May 2026 08:23:42 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 63dad7001bf173d7068cbb215f9a596ab2a75ea8
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <549ff2e15783c8c1efd864a9446ec8f5239be405-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPcDb-0004cm-8F
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
Content-Type: multipart/mixed; boundary="===============4511073391018179354=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4511073391018179354==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iBTHgmrtCN8="; charset=UTF-8

--iBTHgmrtCN8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1683?usp=3Demail

to review the following change=2E


Chang=
e subject: dco: remove iroute at client exit time instead of delayed exit
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco: remove i=
route at client exit time instead of delayed exit

When a exits (because it=
 sent an EEN or because it's connection
timed out) OpenVPN will perform som=
e minimal cleanup and will
then postpone the actual instance purge by 5 sec=
onds=2E

If iroutes are configured for the exiting client, the actual DCO
i=
routes removal is also postponed=2E

If during this time window the same cl=
ient reconnects and a new
instance is created (for example because --duplic=
ate-cn is set or
because the same username is provided upon authentication)=
 OpenVPN
will:

* create the new client instance;
* attempt adding the rela=
ted DCO iroutes (which will fail because
  EEXIST);
* 5 seconds timeout fir=
es -> execute the delayed exit routine and
  delete the DCO iroutes;
* no i=
routes exists anymore on the server despite the client being
  fully connec=
ted=2E

With this patch we move the DCO iroutes deletion to the actual
clie=
nt exit time in order to avoid racing with a possible addition
being execut=
ed when the client reconnects=2E The new flow will be:

* client exits (due=
 to EEN or timeout)
* DCO iroutes are immediately deleted
* client re-conne=
cts -> new instance created
* DCO iroutes are added -> SUCCESS
* 5 seconds =
timeout fires -> old instance client is fully purged
* client is connected =
and iroutes are in place as expected

This issue was reported by OpenVPN Ac=
cess Server developers after
observing erratic iroutes disappearance with D=
CO in place=2E

Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
Signed=
-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/dco=
=2Ec
M src/openvpn/forward=2Ec
M src/openvpn/forward=2Eh
M src/openvpn/mult=
i=2Ec
M src/openvpn/push=2Ec
5 files changed, 15 insertions(+), 7 deletions=
(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/8=
3/1683/1

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index fae0=
548=2E=2E111e8c5 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec=

@@ -733,6 +733,7 @@
     }
     ASSERT(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D =
DEV_TYPE_TUN);
 
+    msg(D_DCO, "DCO: attempt removing iroutes from system=
 table");
 
     if (c->c2=2Epush_ifconfig_defined)
     {
diff --git a/src=
/openvpn/forward=2Ec b/src/openvpn/forward=2Ec
index 27cfd36=2E=2E74a330f 1=
00644
--- a/src/openvpn/forward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -525,7=
 +525,7 @@
  * Schedule a SIGTERM signal c->options=2Escheduled_exit_interv=
al seconds from now=2E
  */
 bool
-schedule_exit(struct context *c)
+schedu=
le_exit(openvpn_net_ctx_t *net_ctx, struct context *c)
 {
     const int n_=
seconds =3D c->options=2Escheduled_exit_interval;
     /* don't reschedule =
if already scheduled=2E */
@@ -533,6 +533,15 @@
     {
         return fals=
e;
     }
+
+    /* DCO iroutes must be removed now, because the delay intr=
oduced by this
+     * timer can create a race condition:
+     * the same =
client may reconnect before the old instance is purged, leading
+     * to =
DCO iroutes removal *after* reconnection, thus killing the routes
+     * f=
or the new instance too=2E
+     */
+    dco_delete_iroutes(net_ctx, c);
+
=
     tls_set_single_session(c->c2=2Etls_multi);
     update_time();
     re=
set_coarse_timers(c);
diff --git a/src/openvpn/forward=2Eh b/src/openvpn/fo=
rward=2Eh
index 0d3e492=2E=2E374e1df 100644
--- a/src/openvpn/forward=2Eh
+=
++ b/src/openvpn/forward=2Eh
@@ -331,7 +331,7 @@
 void process_ip_header(st=
ruct context *c, unsigned int flags, struct buffer *buf,
                  =
      struct link_socket *sock);
 
-bool schedule_exit(struct context *c);
=
+bool schedule_exit(openvpn_net_ctx_t *net_ctx, struct context *c);
 
 stat=
ic inline struct link_socket_info *
 get_link_socket_info(struct context *c=
)
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index e94a7d5=
=2E=2E68506fa 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -479,8 +479,6 @@
     const struct iroute *ir;
     const struct irout=
e_ipv6 *ir6;
 
-    dco_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
-
=
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {=

         for (ir =3D mi->context=2Eoptions=2Eiroutes; ir !=3D NULL; ir =3D=
 ir->next)
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index 5=
64ce86=2E=2E50053e9 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/pus=
h=2Ec
@@ -202,7 +202,7 @@
      * */
     if (c->options=2Emode =3D=3D MODE=
_SERVER)
     {
-        if (!schedule_exit(c))
+        if (!schedule_exit=
(&c->net_ctx, c))
         {
             /* Return early when we don't nee=
d to notify management */
             return;
@@ -392,7 +392,7 @@
 void
 s=
end_auth_failed(struct context *c, const char *client_reason)
 {
-    if (!=
schedule_exit(c))
+    if (!schedule_exit(&c->net_ctx, c))
     {
         =
msg(D_TLS_DEBUG, "exit already scheduled for context");
         return;
@@=
 -493,7 +493,7 @@
 void
 send_restart(struct context *c, const char *kill_m=
sg)
 {
-    schedule_exit(c);
+    schedule_exit(&c->net_ctx, c);
     send=
_control_channel_string(c, kill_msg ? kill_msg : "RESTART", D_PUSH);
 }
 

=
-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ba723d12d433e6e020=
588b7b0c3ba10bcf8c44f
Gerrit-Change-Number: 1683
Gerrit-PatchSet: 1
Gerrit-=
Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcef=
orge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--iBTHgmrtCN8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">dc=
o: remove iroute at client exit time instead of delayed exit<br><br>When a =
exits (because it sent an EEN or because it&#39;s connection<br>timed out) =
OpenVPN will perform some minimal cleanup and will<br>then postpone the act=
ual instance purge by 5 seconds=2E<br><br>If iroutes are configured for the=
 exiting client, the actual DCO<br>iroutes removal is also postponed=2E<br>=
<br>If during this time window the same client reconnects and a new<br>inst=
ance is created (for example because --duplicate-cn is set or<br>because th=
e same username is provided upon authentication) OpenVPN<br>will:<br><br>* =
create the new client instance;<br>* attempt adding the related DCO iroutes=
 (which will fail because<br>  EEXIST);<br>* 5 seconds timeout fires -&gt; =
execute the delayed exit routine and<br>  delete the DCO iroutes;<br>* no i=
routes exists anymore on the server despite the client being<br>  fully con=
nected=2E<br><br>With this patch we move the DCO iroutes deletion to the ac=
tual<br>client exit time in order to avoid racing with a possible addition<=
br>being executed when the client reconnects=2E The new flow will be:<br><b=
r>* client exits (due to EEN or timeout)<br>* DCO iroutes are immediately d=
eleted<br>* client re-connects -&gt; new instance created<br>* DCO iroutes =
are added -&gt; SUCCESS<br>* 5 seconds timeout fires -&gt; old instance cli=
ent is fully purged<br>* client is connected and iroutes are in place as ex=
pected<br><br>This issue was reported by OpenVPN Access Server developers a=
fter<br>observing erratic iroutes disappearance with DCO in place=2E<br><br=
>Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f<br>Signed-off-by: Ant=
onio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=
=2Ec<br>M src/openvpn/forward=2Ec<br>M src/openvpn/forward=2Eh<br>M src/ope=
nvpn/multi=2Ec<br>M src/openvpn/push=2Ec<br>5 files changed, 15 insertions(=
+), 7 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/83/1683/1</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index fae0548=2E=2E111e8c=
5 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/sr=
c/openvpn/dco=2Ec</span><br><span>@@ -733,6 +733,7 @@</span><br><span>     =
}</span><br><span>     ASSERT(TUNNEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYP=
E_TUN);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(D_DCO, &quot;DCO: attempt removing iroutes from system table&=
quot;);</span><br><span> </span><br><span>     if (c-&gt;c2=2Epush_ifconfig=
_defined)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/f=
orward=2Ec b/src/openvpn/forward=2Ec</span><br><span>index 27cfd36=2E=2E74a=
330f 100644</span><br><span>--- a/src/openvpn/forward=2Ec</span><br><span>+=
++ b/src/openvpn/forward=2Ec</span><br><span>@@ -525,7 +525,7 @@</span><br>=
<span>  * Schedule a SIGTERM signal c-&gt;options=2Escheduled_exit_interval=
 seconds from now=2E</span><br><span>  */</span><br><span> bool</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-schedule_exit(struct context *c)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+schedule_exit(openvp=
n_net_ctx_t *net_ctx, struct context *c)</span><br><span> {</span><br><span=
>     const int n_seconds =3D c-&gt;options=2Escheduled_exit_interval;</spa=
n><br><span>     /* don&#39;t reschedule if already scheduled=2E */</span><=
br><span>@@ -533,6 +533,15 @@</span><br><span>     {</span><br><span>      =
   return false;</span><br><span>     }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* DCO iroutes must be removed now, because the delay introduced by th=
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * timer can =
create a race condition:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * the same client may reconnect before the old instance is purged=
, leading</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to =
DCO iroutes removal *after* reconnection, thus killing the routes</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * for the new instance t=
oo=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    dco_delete_iroutes(net=
_ctx, c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     tls_set_single_session(c-&gt;c2=2Etls_multi);</span><br><span> =
    update_time();</span><br><span>     reset_coarse_timers(c);</span><br><=
span>diff --git a/src/openvpn/forward=2Eh b/src/openvpn/forward=2Eh</span><=
br><span>index 0d3e492=2E=2E374e1df 100644</span><br><span>--- a/src/openvp=
n/forward=2Eh</span><br><span>+++ b/src/openvpn/forward=2Eh</span><br><span=
>@@ -331,7 +331,7 @@</span><br><span> void process_ip_header(struct context=
 *c, unsigned int flags, struct buffer *buf,</span><br><span>              =
          struct link_socket *sock);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-bool schedule_exit(struct context *c);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool schedule_exit(open=
vpn_net_ctx_t *net_ctx, struct context *c);</span><br><span> </span><br><sp=
an> static inline struct link_socket_info *</span><br><span> get_link_socke=
t_info(struct context *c)</span><br><span>diff --git a/src/openvpn/multi=2E=
c b/src/openvpn/multi=2Ec</span><br><span>index e94a7d5=2E=2E68506fa 100644=
</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/open=
vpn/multi=2Ec</span><br><span>@@ -479,8 +479,6 @@</span><br><span>     cons=
t struct iroute *ir;</span><br><span>     const struct iroute_ipv6 *ir6;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dc=
o_delete_iroutes(&amp;m-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (TUNNEL=
_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span>  =
   {</span><br><span>         for (ir =3D mi-&gt;context=2Eoptions=2Eiroute=
s; ir !=3D NULL; ir =3D ir-&gt;next)</span><br><span>diff --git a/src/openv=
pn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>index 564ce86=2E=2E50053=
e9 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/=
src/openvpn/push=2Ec</span><br><span>@@ -202,7 +202,7 @@</span><br><span>  =
    * */</span><br><span>     if (c-&gt;options=2Emode =3D=3D MODE_SERVER)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (!schedule_exit(c))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!schedule_exit(&amp;c-&gt;net_ctx, c))</span><br><s=
pan>         {</span><br><span>             /* Return early when we don&#39=
;t need to notify management */</span><br><span>             return;</span>=
<br><span>@@ -392,7 +392,7 @@</span><br><span> void</span><br><span> send_a=
uth_failed(struct context *c, const char *client_reason)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!schedule_exi=
t(c))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sched=
ule_exit(&amp;c-&gt;net_ctx, c))</span><br><span>     {</span><br><span>   =
      msg(D_TLS_DEBUG, &quot;exit already scheduled for context&quot;);</sp=
an><br><span>         return;</span><br><span>@@ -493,7 +493,7 @@</span><br=
><span> void</span><br><span> send_restart(struct context *c, const char *k=
ill_msg)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    schedule_exit(c);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    schedule_exit(&amp;c-&gt;net_ctx, c);</span><br><span>     send=
_control_channel_string(c, kill_msg ? kill_msg : &quot;RESTART&quot;, D_PUS=
H);</span><br><span> }</span><br><span> </span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?=
usp=3Demail">change 1683</a>=2E To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1683?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1683 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-O=
wner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--iBTHgmrtCN8=--


--===============4511073391018179354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4511073391018179354==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4511073391018179354==--

