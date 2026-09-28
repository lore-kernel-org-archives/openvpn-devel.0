Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ACCCA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 12:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PoMDKPVItuN1KaZTIZ14TYBiGB40JXczgPW1U8vv6Cg=; b=fZx29Ewlc/NREyPySWXaq7M0iX
	fwFeUGOyVb2Ru4BHvXjhH9ge7VTb8ikV6+opz6ehlGsVrPcAZLUNdV29iBFyRPgOz2FBqIfp84/TN
	bI2lwsNP5U3Qe/snZNBPsluwQMvRUxsHZ1Mlp4AVYfHJ8XxQKYRv7H4xeGiBI0aqMTj8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBAFX-0002AQ-CZ;
	Mon, 28 Sep 2026 12:14:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBAFW-0002AD-3b
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 12:14:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=133vFuzWsxBm3RQd9fgiLkijqt2O4PUVWrIn8tfXV9w=; b=L75ugehtCvkmURJmCM8ZuAvD4d
 q8NRpTYsEDjjBu+ifZijX4mjo6lWaj3jmbdyyvu8AXh6ku78Z2ZZe+cNvVBbDMoobFkS4yUa6n0Wa
 BtZhGMIiN3TuC7eOTwmyEggVjlw+yEtg5mzRwHIRFu4VIb2x+EckDXFzWQUaGRr5COOQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=133vFuzWsxBm3RQd9fgiLkijqt2O4PUVWrIn8tfXV9w=; b=T
 YwYY+GUQRumJJZGR2O3eRPGqeQchVqUZ5p2z8Wa7Uv4Qot+PlAAa18SFVhv2IdPqpv42V4mV6z0De
 vatZ690D244y9GefnMeAso1VGlPNR+sr/iPaxwTl6Qpi34QJatso8FUVmVDOiUvqpwxWy2eCfurIa
 2LZs0wtsre2ynyDE=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBAFU-000192-US for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 12:14:26 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a006bb267eso3198875e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 05:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790597658; x=1791202458; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=133vFuzWsxBm3RQd9fgiLkijqt2O4PUVWrIn8tfXV9w=;
 b=bmtYGAsR5XDjAZ/rzM10u8BuG0oPZzEs1S5IskLFF+0tq7kfdcUIgdt/NC0ohPFAja
 otuJwYq+cy7hiCRzIh7qrfzZ4u7H/6xdOgqT2aWd2kdHPokKB+Uh9gbHcBBgD2AaWzkp
 Z/zvHlE0X0G/rzWVGc1lk7TgUn7BGxZD3AUpVvUFxbq+9V2scJe5MLb+98cljy89RQQt
 zaR54Dgmgjy+J6R5RhEFhoXZKpfLxZA2tkHIMy5diidMrs5gLR/q3RIUltNGOXp9YCL7
 XG420HYDDqRaIxoIo/6pDfrQdFvNFaZjROYa+6zf4Jzjvle+PMpCJRizKYITS42txmyv
 1dCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790597658; x=1791202458;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=133vFuzWsxBm3RQd9fgiLkijqt2O4PUVWrIn8tfXV9w=;
 b=gkUsq/CpAbSgXC5UKY4RlB+vjIx34ml8pH8yaW91cUEWs9lLdb9yxhqk+dVAKmqDps
 KQMYULmDSipzGlNwLnIaLoTZAE4HgMluoUb5R+qvHlVyNQFeamKJ69rqURiiedl7wyK5
 xZ/iEMu7j4fwr6rU2NPhDbT+Ak7VIvt2Qr33SIID8ncpsiGeErWCkM9/Ps5Pdp51V68b
 Tpy8Rt4549q7/mlEsvyZHXxf3QrJZ5c9AfaziAjFUrmcMnbD9KYqusTu+E0/EfkyAvT5
 cFZc44LHAMF6n7ZYyjUIdhPrJdKiSsPxQnWOSwRAikfv0epU17QWm37LAttd+jA4SRPt
 RjWw==
X-Gm-Message-State: AFuF++nmOwbf5VPXTOTRGmyejx6O4KFAMbQwBrTo5C8rlvQCjJSbii1U
 b5MPATE88425dNeVCppK2VzNCisQHfys+PiPYLKuNyWVmX/KiIxcCKlOlVlWJxStH9JGcGkcKCn
 6hChxcNMpNOVstkOdFX9t/xLx3fv1yzwVAZuQv6NPFJVb/bYgzTRe4et40n+7i+jQAfwD
X-Gm-Gg: AYBFou0lPa78UwRthaWARReWXA/HN+NzxImZQoFlHpC9Qx5TdloOR29EAlPx5ZZ+KzD
 R0Z9QTMsWc+E4RTsePSwDW4jMcTl5jf7zmeo29mvtgr4S/SvOSZZ9qMbSGeMXJOdpmSErVZ9/TE
 /gR7PKs+lLRIyABzDUXztP+I6BCshVGpFwJAyxFoJ3dISPQnsvfUfoWbIuMcnrQQojpJtxg0JeW
 sqN5OWWB1jsJ/JjGxSIj2mOIelJIq0e2P1YUQCoq1BsT2kHK9EJ8SNPmFzxwXndBRYzMLGYqKRy
 gMlVJDHM4IhMcUqF43t8/LtBauNt8rWQPzmcvwKKSP4xwCOqTQ8m+qduCQV/H/hCSpqZ50YbWr7
 4nghwtMJ1gx0c4XN2A+cZxc9TqF6Gw9ATBDJVIZ9zFAKAgyi7wekqCnIm0YX6b1nDK/gPZUNfWp
 ssx+v2CtoL5EfSKF9uEHpwnznjr9MZGWXhtUGiECldOT4p0ZejWpOK1f1257zxOJZoLy1a9hOFc
 NsrrvNKnfsCSSiH39wPuuE+s6IuxZpBjfl+r1a2LfgPmt7XuFU05ojKE6L2sx38GbJxT3Z6hL/A
 UL7AdfradTC2NRyJhw2VynBcBiRKspzdI9gAUWJ98/msceb9Bv/yTCueaVJL
X-Received: by 2002:a05:600c:354e:b0:49e:6e7c:d895 with SMTP id
 5b1f17b1804b1-49fe66ef3f5mr234549515e9.26.1790597658191; 
 Mon, 28 Sep 2026 05:14:18 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00c076dc3sm259205e9.0.2026.09.28.05.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 05:14:17 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 12:14:15 +0000
To: ralf_lici <ralf@mandelbit.com>, razvanc <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
X-Gerrit-Change-Number: 1952
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1952?usp=email>
X-Gerrit-Commit: 459fcbb252b9c9781d2807f4d44dbfd758a26afa
In-Reply-To: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
References: <gerrit.1790344336000.Ic535bb1f0da1739f87e9d6bef6fd1061247b05de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzQ0MzM2MDAwLkljNTM1YmIxZjBkYTE3MzlmODdlOWQ2YmVmNmZkMTA2MTI0N2IwNWRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0a32cfe003b0bd310d9eaaf92cd39dadaa66a718-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBAFU-000192-US
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: stop fetching
 peer stats during client disconnect
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0681189798169337363=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0681189798169337363==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9vUQm8Tm5bM="; charset=UTF-8

--9vUQm8Tm5bM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ralf_lici=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
ordex, Code-Review+2 by razvanc


Change subject: dco: stop fetching peer s=
tats during client disconnect
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

dco: stop fetching peer stats during client disconnect

Th=
e disconnect path asks DCO for a fresh peer dump after the multi
instance h=
as already been removed from the peer-id lookup table=2E For
kernel-initiat=
ed disconnects, the peer has also already been deleted by
the time its noti=
fication is processed=2E The reply therefore cannot
update the disconnectin=
g instance=2E

Moreover, each disconnect dumps all surviving peers, causing=
 avoidable
netlink traffic and repeated work when many clients disconnect a=
t once=2E

During shutdown or restart, fetch a single final peer snapshot b=
efore
closing any instances, while all peers can still be mapped to their
u=
serspace contexts=2E

For individual disconnects, use the cached counters d=
irectly=2E Kernels
that provide a final statistics snapshot in the deletion=
 notification
can update them before the disconnect environment is prepared=
=2E

Change-Id: Ic535bb1f0da1739f87e9d6bef6fd1061247b05de
Signed-off-by: Ra=
lf Lici <ralf@mandelbit=2Ecom>
Acked-by: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952
Message-Id: <20260926200956=2E=
24545-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg39533=2Ehtml
Signed-off-by: Gert Doe=
ring <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, =
13 insertions(+), 15 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/52/1952/3

diff --git a/src/openvpn/multi=2Ec b=
/src/openvpn/multi=2Ec
index 52364f9=2E=2E9b9cdc3 100644
--- a/src/openvpn/=
multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -496,37 +496,29 @@
 }
 
 static vo=
id
-setenv_stats(struct multi_context *m, struct context *c)
+setenv_stats(=
struct context *c)
 {
-    if (dco_enabled(&m->top=2Eoptions))
-    {
-    =
    if (dco_get_peer_stats_multi(&m->top=2Ec1=2Etuntap->dco, false) < 0)
- =
       {
-            return;
-        }
-    }
-
     setenv_counter(c->c2=
=2Ees, "bytes_received", c->c2=2Elink_read_bytes + c->c2=2Edco_read_bytes);=

     setenv_counter(c->c2=2Ees, "bytes_sent", c->c2=2Elink_write_bytes + c=
->c2=2Edco_write_bytes);
 }
 
 static void
-multi_client_disconnect_setenv(=
struct multi_context *m, struct multi_instance *mi)
+multi_client_disconnec=
t_setenv(struct multi_instance *mi)
 {
     /* setenv client real IP addres=
s */
     setenv_trusted(mi->context=2Ec2=2Ees, get_link_socket_info(&mi->c=
ontext));
 
     /* setenv stats */
-    setenv_stats(m, &mi->context);
+  =
  setenv_stats(&mi->context);
 
     /* setenv connection duration */
     =
setenv_long_long(mi->context=2Ec2=2Ees, "time_duration", now - mi->created)=
;
 }
 
 static void
-multi_client_disconnect_script(struct multi_context *m=
, struct multi_instance *mi)
+multi_client_disconnect_script(struct multi_i=
nstance *mi)
 {
-    multi_client_disconnect_setenv(m, mi);
+    multi_clie=
nt_disconnect_setenv(mi);
 
     if (plugin_defined(mi->context=2Eplugins, =
OPENVPN_PLUGIN_CLIENT_DISCONNECT))
     {
@@ -634,7 +626,7 @@
 
     if (mi=
->context=2Ec2=2Etls_multi->multi_state >=3D CAS_CONNECT_DONE)
     {
-    =
    multi_client_disconnect_script(m, mi);
+        multi_client_disconnect=
_script(mi);
     }
 
     close_context(&mi->context, SIGTERM, CC_GC_FREE)=
;
@@ -659,6 +651,12 @@
 {
     if (m->hash)
     {
+        /* fetch final =
stats while all peers can still be mapped to their instances */
+        if=
 (dco_enabled(&m->top=2Eoptions))
+        {
+            dco_get_peer_stat=
s_multi(&m->top=2Ec1=2Etuntap->dco, false);
+        }
+
         for (uint=
32_t i =3D 0; i <=3D m->max_peerid; i++)
         {
             struct mul=
ti_instance *mi =3D m->instances[i];
@@ -2750,7 +2748,7 @@
          * did =
not fail */
         if (mi->context=2Ec2=2Etls_multi->multi_state =3D=3D C=
AS_PENDING_DEFERRED_PARTIAL)
         {
-            multi_client_disconnec=
t_script(m, mi);
+            multi_client_disconnect_script(mi);
         =
}
 
         mi->context=2Ec2=2Etls_multi->multi_state =3D CAS_FAILED;

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic535bb1f0da1739f87e9=
d6bef6fd1061247b05de
Gerrit-Change-Number: 1952
Gerrit-PatchSet: 3
Gerrit-O=
wner: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: ordex <antonio@mand=
elbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>

--9vUQm8Tm5bM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by ralf_lici=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1952?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by ordex, Code-Review+2 by razvanc</p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">d=
co: stop fetching peer stats during client disconnect<br><br>The disconnect=
 path asks DCO for a fresh peer dump after the multi<br>instance has alread=
y been removed from the peer-id lookup table=2E For<br>kernel-initiated dis=
connects, the peer has also already been deleted by<br>the time its notific=
ation is processed=2E The reply therefore cannot<br>update the disconnectin=
g instance=2E<br><br>Moreover, each disconnect dumps all surviving peers, c=
ausing avoidable<br>netlink traffic and repeated work when many clients dis=
connect at once=2E<br><br>During shutdown or restart, fetch a single final =
peer snapshot before<br>closing any instances, while all peers can still be=
 mapped to their<br>userspace contexts=2E<br><br>For individual disconnects=
, use the cached counters directly=2E Kernels<br>that provide a final stati=
stics snapshot in the deletion notification<br>can update them before the d=
isconnect environment is prepared=2E<br><br>Change-Id: Ic535bb1f0da1739f87e=
9d6bef6fd1061247b05de<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom&=
gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked=
-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1952<br>Message-Id: &lt;20260926200956=2E=
24545-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg39533=2Ehtml<br>Signed-off-by:=
 Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi=
=2Ec<br>1 file changed, 13 insertions(+), 15 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/=
52/1952/3</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2E=
c</span><br><span>index 52364f9=2E=2E9b9cdc3 100644</span><br><span>--- a/s=
rc/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br>=
<span>@@ -496,37 +496,29 @@</span><br><span> }</span><br><span> </span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set=
env_stats(struct multi_context *m, struct context *c)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+setenv_stats(struct context *c)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_=
enabled(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (dco_get_peer_stats_multi(&amp;m-&gt;top=2Ec1=2Etuntap-&gt;dco, fal=
se) &lt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span>     setenv_counter(c-&gt;c2=2Ees, =
&quot;bytes_received&quot;, c-&gt;c2=2Elink_read_bytes + c-&gt;c2=2Edco_rea=
d_bytes);</span><br><span>     setenv_counter(c-&gt;c2=2Ees, &quot;bytes_se=
nt&quot;, c-&gt;c2=2Elink_write_bytes + c-&gt;c2=2Edco_write_bytes);</span>=
<br><span> }</span><br><span> </span><br><span> static void</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-multi_client_disconnect_setenv(struct=
 multi_context *m, struct multi_instance *mi)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+multi_client_disconnect_setenv(struct multi_insta=
nce *mi)</span><br><span> {</span><br><span>     /* setenv client real IP a=
ddress */</span><br><span>     setenv_trusted(mi-&gt;context=2Ec2=2Ees, get=
_link_socket_info(&amp;mi-&gt;context));</span><br><span> </span><br><span>=
     /* setenv stats */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    setenv_stats(m, &amp;mi-&gt;context);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    setenv_stats(&amp;mi-&gt;context);</span><br><s=
pan> </span><br><span>     /* setenv connection duration */</span><br><span=
>     setenv_long_long(mi-&gt;context=2Ec2=2Ees, &quot;time_duration&quot;,=
 now - mi-&gt;created);</span><br><span> }</span><br><span> </span><br><spa=
n> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi_c=
lient_disconnect_script(struct multi_context *m, struct multi_instance *mi)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client_discon=
nect_script(struct multi_instance *mi)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    multi_client_disconnect_setenv(m, m=
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_client=
_disconnect_setenv(mi);</span><br><span> </span><br><span>     if (plugin_d=
efined(mi-&gt;context=2Eplugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT))</span><=
br><span>     {</span><br><span>@@ -634,7 +626,7 @@</span><br><span> </span=
><br><span>     if (mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_state &gt;=3D=
 CAS_CONNECT_DONE)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        multi_client_disconnect_script(m, mi);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        multi_client_disconn=
ect_script(mi);</span><br><span>     }</span><br><span> </span><br><span>  =
   close_context(&amp;mi-&gt;context, SIGTERM, CC_GC_FREE);</span><br><span=
>@@ -659,6 +651,12 @@</span><br><span> {</span><br><span>     if (m-&gt;has=
h)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* fetch final stats while all peers can still be mapped to t=
heir instances */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (dco_enabled(&amp;m-&gt;top=2Eoptions))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            dco_get_peer_stats_multi(&amp;m-&gt;top=2Ec1=
=2Etuntap-&gt;dco, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>         for (uint32_t i =3D 0; i &lt;=3D m-&gt;max_peerid; i=
++)</span><br><span>         {</span><br><span>             struct multi_in=
stance *mi =3D m-&gt;instances[i];</span><br><span>@@ -2750,7 +2748,7 @@</s=
pan><br><span>          * did not fail */</span><br><span>         if (mi-&=
gt;context=2Ec2=2Etls_multi-&gt;multi_state =3D=3D CAS_PENDING_DEFERRED_PAR=
TIAL)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            multi_client_disconnect_script(m, mi);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            multi_client_disconne=
ct_script(mi);</span><br><span>         }</span><br><span> </span><br><span=
>         mi-&gt;context=2Ec2=2Etls_multi-&gt;multi_state =3D CAS_FAILED;</=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1952?usp=3Demail">change 1952</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1952?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: Ic535bb1f0da1739f87e9d6bef6fd106124=
7b05de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1952 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>

</body></html>
--9vUQm8Tm5bM=--


--===============0681189798169337363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0681189798169337363==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0681189798169337363==--

