Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EF4C9833F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 11:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hEkj79xISg0YI7wgywPN26PcIZI+vXqeSUIexPfPTA4=; b=geG8F0LnDPW4jzyLBbgUEpBQfL
	15Dlf1NUTOJxOKVzqMrC3fLkKa9IypDqJG09YnHmFgQ1cuaWjXeusk5LZrM4N4JBMis51YEi8+Mfr
	Z192aO8FNgFx1gmB+mqdLzzY+7N965BpvAKGLAWxLWtlC7uP17ADeu5rJAFIOt7JZAAM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB9XB-00065h-Tg;
	Mon, 28 Sep 2026 11:28:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xB9X8-00065Z-Jh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 11:28:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lgOlhik9B3iH/udtF5f7FDOvO6KvVBKVFUDTQFyHTDI=; b=e1PDEHaYuFNQ4ugThC3tOm0ucS
 F4QDWC8BPa9U/h1H+2jml29AEy+KYXSNZjIZcAd2me/cJMYC40ma4bxpW29d4HM6/V8wYDHHPfI6q
 GzFVmLxAiP9qm4VXxWeQXly9cJxk/K5x8lnfksUgNFk94HPpQgkVPWQXfDPaID4zigCY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lgOlhik9B3iH/udtF5f7FDOvO6KvVBKVFUDTQFyHTDI=; b=n
 CfQUFwj9dICiuuBdtqKxO54yXxJgAu4pQmRxHiE5SrTT06kS3+ZdUc/DQ7U713Nm3WGL3LxX2Zs12
 0cdO93NAtew4//ALajKG1ubLjXz84xALEg+RfoROEriI7pW0E1Zw7BxXfqOftSDLlIRLptNK7FKMS
 mQOgbCVeYWFZiucs=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB9X6-0003Ds-3N for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 11:28:33 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49b912df756so23081325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790594905; x=1791199705; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lgOlhik9B3iH/udtF5f7FDOvO6KvVBKVFUDTQFyHTDI=;
 b=UtbU9Yush1My2uZ4eeYhyNPZ/ZP9vQ7cC3pwTjfHXfTLjQFzD6cEIAy7U5uaGKgoXm
 VPGDR0Xv51dSJFHKzqNrcbsRdIDTTYnihZDEgHkMIy0Xrkxhfc21svM32NKct099Z/DD
 P/MKGlFavbEZydpHC74Ji427FiCfNe0h1ic7AVM+JD1BX4Jj8v3OrDakUiSU8j4uA6u7
 1aOw5j9PpSIJ++ekDW+rPtz2Pb9KOhaxdPZrzKHeuCzMnyk75Pil4XnNIBGvEeYg3EI4
 KLpdvxZSdfDAwLWAugUxFox84HvEwYVbWM61PtsMTV4wRXx/Lp1Rw7If8fDjFCueqNpv
 0W8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790594905; x=1791199705;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lgOlhik9B3iH/udtF5f7FDOvO6KvVBKVFUDTQFyHTDI=;
 b=aQgkoMqkr1da4tB7iUVjf95OLqtUNaFNsuvJxYV+7kE2ZPv/4QGWLYGCevNCi4Xt71
 DYM4lAEK7FF9S9F7arl9br07ExMODGQrPVswgAmIcjfrRdVxQBBPaJVmQPPe5rp5pCTs
 xmdTYiiHlq5Rt+ww57fUyJHq3/Zh+EnxuVkXosOKbYRjwU7gShsDhafqbY1RDeQqNhAZ
 fkTu8ELyYWe9Li34IpaMx2SrlUCg6Es6xRv5ywCxu249XarvXGsQKHJXYDJT/8ogDBkm
 exBbB/cxJMe0LRhJFZRW+8Dzc8Qlu8qNkzCp+qpaBEjzZjbdUxZ3eR4UXDm1LdOCiVfp
 awPA==
X-Gm-Message-State: AFuF++ksCJ0aTY1IvUC7TJTIivu0ekBHNe9j52bdJpQwtEpaZMIXHnCI
 XOaCyTigk87aPCOYD3L+YbSuiGPdkGghKMQQshyFAOpUr3B7nXYrQEjbogcUWB1Q0NJP8L7LvTv
 Z/6nPsaGhMtYQFz/Cpus00Ff2uj6nU9uLf+hPH8Fj5HPUr2+3MYZPFip8we4CQbJYSK9n
X-Gm-Gg: AYBFou2FvP3XQ09/lVvDYrIFkSAGmmQUbKAShYHdNuS8K/3gAjRqn92nK2oFl96f30R
 sAKjQSEF0up+3OqeE6DAQxQvmcQoPO68DVVteh1T1kJTKk46P52I4SLTyny4mFbDS1gSE3RsNdj
 7oUK45zfFgo5f9EmKWkUVZko/EXYuHQMxfYhLRa90VxnOi18aMojHCleAKRgYY8qV7OHz863zHp
 wfak5LEBPFQiM+4NW4xtCx5O1+pluhZgxDNoIipzzYTtxKQQK/jczXqXSp8XKzQQ8uTU1L8rai9
 OQRkORMbtMaEgG/ro1VI3P6tzvdqis6OxG+5lcETLBShC1jKzlRgci8OSzLWm0Fovd2KxSCNqLQ
 EsKomiduH2gU+41kINqS6tMMQb+uFzTm4zVbF2g5q4bGUH0Sf1nefHwutI7lWE/TL+HgSh3JjXK
 mrp8HN0tMbkpm6iKLOdexyde+XaL3Qi724h4Jbl7jZe9Dl1jmtgWakNINYo0xqzjzoCjbfzRcze
 rG8Rp8DKw4sPK3Fc3zW66p0a+RBkRb/tQgrJgl7l/vYTovBmE4MX48vwrd+WrOs5kPTQRhQDK8L
 ovRe9Pt0iOMcZKeESvyK8ii6DoeRq9ehltWYgGDm2Q/qcBSHWHoxwU+u7cY8
X-Received: by 2002:a05:600c:a47:b0:49b:9202:6f80 with SMTP id
 5b1f17b1804b1-49fe66abc9cmr223807805e9.6.1790594905246; 
 Mon, 28 Sep 2026 04:28:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a001922102sm138351235e9.15.2026.09.28.04.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 04:28:24 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 11:28:23 +0000
To: razvanc <razvanc@mailbox.org>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 569eaffaf9d78054eb750d1f32982ae90fd2a75d
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d49de48194e9a99cf88fbebe0653c4a54ed88118-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xB9X6-0003Ds-3N
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6993376402724783845=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6993376402724783845==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="umkXJZkYLaM="; charset=UTF-8

--umkXJZkYLaM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos, razva=
nc=2E

Hello flichtenheld, plaisthos, razvanc, 

I'd like you to reexamine =
a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/168=
3?usp=3Demail

to look at the new patch set (#7)=2E

The following approval=
s got outdated and were removed:
Code-Review+2 by razvanc

The change is no=
 longer submittable: Code-Review and checks~ChecksSubmitRule are unsatisfie=
d now=2E


Change subject: dco: remove iroute at client exit time instead o=
f delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


dco: remove iroute at client exit time instead of delayed exit

When a cl=
ient exits due to one of the following reasons:
* EEN received
* AUTH_FAILE=
D sent
* RESTART sent
OpenVPN will perform some minimal cleanup and will
th=
en postpone the actual instance purge by 5 seconds=2E

If iroutes are confi=
gured for the exiting client, the actual DCO
iroutes removal is also postpo=
ned=2E

If during this time window the same client reconnects, a new
instan=
ce is created (for example because --duplicate-cn is set or
because the sam=
e username is provided upon authentication) and the
same IP is assigned, th=
en OpenVPN will:

* create the new client instance;
* attempt adding the re=
lated DCO iroutes (which will fail because
  EEXIST);
* 5 seconds timeout f=
ires -> execute the delayed exit routine and
  delete the DCO iroutes;
* no=
 iroutes exists anymore on the server despite the client being
  fully conn=
ected=2E

Note that this issue is DCO specific, because without DCO OpenVPN=

creates virtual routes (no system routing table involved) and makes
the la=
st connecting client own them=2E
This means that the delayed exit routine w=
on't have any iroute to
delete=2E

With this patch we move the DCO iroutes =
deletion to the actual
client exit time in order to avoid racing with a pos=
sible addition
being executed when the client reconnects=2E The new flow wi=
ll be:

* client exits (due to EEN or timeout)
* DCO iroutes are immediatel=
y deleted
* client re-connects -> new instance created
* DCO iroutes are ad=
ded -> SUCCESS
* 5 seconds timeout fires -> old instance client is fully pu=
rged
* client is connected and iroutes are in place as expected

This issue=
 was reported by OpenVPN Access Server developers after
observing erratic i=
routes disappearance with DCO in place=2E

Change-Id: I0ba723d12d433e6e0205=
88b7b0c3ba10bcf8c44f
GitHub: closes openvpn/OpenVPN#1040
Signed-off-by: Ant=
onio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M src/op=
envpn/forward=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/openvpn=2Eh
4 files=
 changed, 29 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/83/1683/7

diff --git a/src/openvpn/dco=
=2Ec b/src/openvpn/dco=2Ec
index ba1c85f=2E=2E6d88f6f 100644
--- a/src/open=
vpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -750,6 +750,8 @@
     }
     ASSER=
T(TUNNEL_TYPE(c->c1=2Etuntap) =3D=3D DEV_TYPE_TUN);
 
+    msg(D_DCO, "DCO:=
 attempt removing iroutes from system table");
+
     if (c->c2=2Epush_ifco=
nfig_defined)
     {
         for (const struct iroute *ir =3D c->options=
=2Eiroutes; ir; ir =3D ir->next)
diff --git a/src/openvpn/forward=2Ec b/src=
/openvpn/forward=2Ec
index a8a4a07=2E=2E6d85c62 100644
--- a/src/openvpn/fo=
rward=2Ec
+++ b/src/openvpn/forward=2Ec
@@ -539,6 +539,23 @@
     {
       =
  return false;
     }
+
+    /* DCO iroutes must be removed now, because t=
he delay introduced by this
+     * timer can create a race condition:
+   =
  * the same client may reconnect before the old instance is purged, leadin=
g
+     * to DCO iroutes removal *after* reconnection, thus killing the rou=
tes
+     * for the new instance too=2E
+     *
+     * Standard/virtual ir=
outes (non-DCO case) are not affected because the
+     * last connecting c=
lient claiming the iroutes takes ownership=2E Therefore
+     * they are no=
t removed during delayed cleanup=2E
+     */
+    if (c->did_dco_iroutes)
+=
    {
+        c->did_dco_iroutes =3D false;
+        dco_delete_iroutes(&c=
->net_ctx, c);
+    }
+
     tls_set_single_session(c->c2=2Etls_multi);
   =
  update_time();
     reset_coarse_timers(c);
diff --git a/src/openvpn/mult=
i=2Ec b/src/openvpn/multi=2Ec
index 52364f9=2E=2E3bef334 100644
--- a/src/o=
penvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -479,7 +479,12 @@
     cons=
t struct iroute *ir;
     const struct iroute_ipv6 *ir6;
 
-    dco_delete_=
iroutes(&m->top=2Enet_ctx, &mi->context);
+    /* check if DCO iroutes were=
 already removed when scheduling a delayed exit */
+    if (mi->context=2Ed=
id_dco_iroutes)
+    {
+        mi->context=2Edid_dco_iroutes =3D false;
+ =
       dco_delete_iroutes(&m->top=2Enet_ctx, &mi->context);
+    }
 
     i=
f (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
     {
@@ -1=
277,6 +1282,8 @@
     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV=
_TYPE_TUN)
     {
         mi->did_iroutes =3D true;
+        /* multi_lear=
n_in{6}_addr_t takes care of installing the DCO iroute */
+        mi->cont=
ext=2Edid_dco_iroutes =3D true;
         for (ir =3D mi->context=2Eoptions=
=2Eiroutes; ir !=3D NULL; ir =3D ir->next)
         {
             if (ir->=
netbits >=3D 0)
diff --git a/src/openvpn/openvpn=2Eh b/src/openvpn/openvpn=
=2Eh
index e9e18bf=2E=2Ecdd02b6 100644
--- a/src/openvpn/openvpn=2Eh
+++ b/=
src/openvpn/openvpn=2Eh
@@ -507,6 +507,8 @@
     bool did_we_daemonize;    =
   /**< Whether demonization has already
                                  =
 *   taken place=2E */
 
+    bool did_dco_iroutes;        /**< Whether DCO=
 iroutes have been installed */
+
     struct context_persist persist;
    =
 /**< Persistent %context=2E */
     struct context_0 *c0; /**< Level 0 %co=
ntext=2E */

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
683?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpat=
chset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ba7=
23d12d433e6e020588b7b0c3ba10bcf8c44f
Gerrit-Change-Number: 1683
Gerrit-Patc=
hSet: 7
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flic=
htenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: flichtenheld <frank@lichtenheld=2Ecom>

--umkXJZkYLaM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos, razvanc=2E </p>
<p>or=
dex <strong>uploaded patch set #7</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by razvanc</p><p>The change is no longer submittable: Code-Review and =
checks~ChecksSubmitRule are unsatisfied now=2E</p><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">dco: remove=
 iroute at client exit time instead of delayed exit<br><br>When a client ex=
its due to one of the following reasons:<br>* EEN received<br>* AUTH_FAILED=
 sent<br>* RESTART sent<br>OpenVPN will perform some minimal cleanup and wi=
ll<br>then postpone the actual instance purge by 5 seconds=2E<br><br>If iro=
utes are configured for the exiting client, the actual DCO<br>iroutes remov=
al is also postponed=2E<br><br>If during this time window the same client r=
econnects, a new<br>instance is created (for example because --duplicate-cn=
 is set or<br>because the same username is provided upon authentication) an=
d the<br>same IP is assigned, then OpenVPN will:<br><br>* create the new cl=
ient instance;<br>* attempt adding the related DCO iroutes (which will fail=
 because<br>  EEXIST);<br>* 5 seconds timeout fires -&gt; execute the delay=
ed exit routine and<br>  delete the DCO iroutes;<br>* no iroutes exists any=
more on the server despite the client being<br>  fully connected=2E<br><br>=
Note that this issue is DCO specific, because without DCO OpenVPN<br>create=
s virtual routes (no system routing table involved) and makes<br>the last c=
onnecting client own them=2E<br>This means that the delayed exit routine wo=
n&#39;t have any iroute to<br>delete=2E<br><br>With this patch we move the =
DCO iroutes deletion to the actual<br>client exit time in order to avoid ra=
cing with a possible addition<br>being executed when the client reconnects=
=2E The new flow will be:<br><br>* client exits (due to EEN or timeout)<br>=
* DCO iroutes are immediately deleted<br>* client re-connects -&gt; new ins=
tance created<br>* DCO iroutes are added -&gt; SUCCESS<br>* 5 seconds timeo=
ut fires -&gt; old instance client is fully purged<br>* client is connected=
 and iroutes are in place as expected<br><br>This issue was reported by Ope=
nVPN Access Server developers after<br>observing erratic iroutes disappeara=
nce with DCO in place=2E<br><br>Change-Id: I0ba723d12d433e6e020588b7b0c3ba1=
0bcf8c44f<br>GitHub: closes openvpn/OpenVPN#1040<br>Signed-off-by: Antonio =
Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<b=
r>M src/openvpn/forward=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/ope=
nvpn=2Eh<br>4 files changed, 29 insertions(+), 1 deletion(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/83/1683/7</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec=
</span><br><span>index ba1c85f=2E=2E6d88f6f 100644</span><br><span>--- a/sr=
c/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span=
>@@ -750,6 +750,8 @@</span><br><span>     }</span><br><span>     ASSERT(TUN=
NEL_TYPE(c-&gt;c1=2Etuntap) =3D=3D DEV_TYPE_TUN);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, &quot;DCO: a=
ttempt removing iroutes from system table&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     if (c-&gt;c2=2Epush_ifc=
onfig_defined)</span><br><span>     {</span><br><span>         for (const s=
truct iroute *ir =3D c-&gt;options=2Eiroutes; ir; ir =3D ir-&gt;next)</span=
><br><span>diff --git a/src/openvpn/forward=2Ec b/src/openvpn/forward=2Ec</=
span><br><span>index a8a4a07=2E=2E6d85c62 100644</span><br><span>--- a/src/=
openvpn/forward=2Ec</span><br><span>+++ b/src/openvpn/forward=2Ec</span><br=
><span>@@ -539,6 +539,23 @@</span><br><span>     {</span><br><span>        =
 return false;</span><br><span>     }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* DCO iroutes must be removed now, because the delay introduced by this=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * timer can cr=
eate a race condition:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * the same client may reconnect before the old instance is purged, =
leading</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to DC=
O iroutes removal *after* reconnection, thus killing the routes</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * for the new instance too=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * Standard/virtual irout=
es (non-DCO case) are not affected because the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * last connecting client claiming the irout=
es takes ownership=2E Therefore</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * they are not removed during delayed cleanup=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;did_dco_iroutes)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        c-&gt;did_dco_iroutes =3D false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        dco_delete_irou=
tes(&amp;c-&gt;net_ctx, c);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>     tls_set_single_session(c-&gt;c2=2Etls_multi);</span><br><sp=
an>     update_time();</span><br><span>     reset_coarse_timers(c);</span><=
br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><=
br><span>index 52364f9=2E=2E3bef334 100644</span><br><span>--- a/src/openvp=
n/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ =
-479,7 +479,12 @@</span><br><span>     const struct iroute *ir;</span><br><=
span>     const struct iroute_ipv6 *ir6;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    dco_delete_iroutes(&amp;m-&gt;top=
=2Enet_ctx, &amp;mi-&gt;context);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* check if DCO iroutes were already removed when schedul=
ing a delayed exit */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (mi-&gt;context=2Edid_dco_iroutes)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        mi-&gt;context=2Edid_dco_iroutes =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        dco_delete_iroutes(&amp;m=
-&gt;top=2Enet_ctx, &amp;mi-&gt;context);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     if (TUNN=
EL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span>=
     {</span><br><span>@@ -1277,6 +1282,8 @@</span><br><span>     if (TUNNE=
L_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)</span><br><span> =
    {</span><br><span>         mi-&gt;did_iroutes =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        /* multi_learn_in{6}_addr_t=
 takes care of installing the DCO iroute */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        mi-&gt;context=2Edid_dco_iroutes =3D true;<=
/span><br><span>         for (ir =3D mi-&gt;context=2Eoptions=2Eiroutes; ir=
 !=3D NULL; ir =3D ir-&gt;next)</span><br><span>         {</span><br><span>=
             if (ir-&gt;netbits &gt;=3D 0)</span><br><span>diff --git a/src=
/openvpn/openvpn=2Eh b/src/openvpn/openvpn=2Eh</span><br><span>index e9e18b=
f=2E=2Ecdd02b6 100644</span><br><span>--- a/src/openvpn/openvpn=2Eh</span><=
br><span>+++ b/src/openvpn/openvpn=2Eh</span><br><span>@@ -507,6 +507,8 @@<=
/span><br><span>     bool did_we_daemonize;       /**&lt; Whether demonizat=
ion has already</span><br><span>                                   *   take=
n place=2E */</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool did_dco_iroutes;        /**&lt; Whether DCO iroutes ha=
ve been installed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     struct context_persist persist;</span><br><span>    =
 /**&lt; Persistent %context=2E */</span><br><span>     struct context_0 *c=
0; /**&lt; Level 0 %context=2E */</span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">change 1683=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
0ba723d12d433e6e020588b7b0c3ba10bcf8c44f </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1683 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antoni=
o@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--umkXJZkYLaM=--


--===============6993376402724783845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6993376402724783845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6993376402724783845==--

