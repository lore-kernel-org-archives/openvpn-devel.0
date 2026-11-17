Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65221606A335
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 14:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MNF8cjL6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Vagqy9yh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N6gziAKX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IZkS/aec
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zf4xb91Yde4qe5QHnQJn0yP2aV2IPYDfSomQcG6/FSE=; b=MNF8cjL6z+DxJhxhLpWBxYwnBE
	2M9YghvXDjuMYUgG8LP0u34Ot2e84JikddFloM1pzHf1Gtbaxkhr9rYPkk9TVqbDRO5s5oBygnV6l
	lV974Xu2Dui6ijxK8rz3lk81x1tIUNqto93SC9V7qu+qTG7zk8C1JGLNcWITRZXI2KNM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTKdp-000000002rd-0bk8;
	Tue, 17 Nov 2026 14:58:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTKdo-000000002rX-0blM
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:58:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GooKKcKS/wkHNbfLJFKA9mQL5KIKiKQ7c0aupXRulFQ=; b=Vagqy9yhdwPF8JhtA6ZHU7IK5f
 iazrEc4eYZtW1pWBxQH1QxacoaRSJ1dkpfSvztkQ0suudefLXiPCr8TXBzKXv8cg+PP+B8v4Amifm
 yplHN1uot1mhZ0VZcIzFzhqAYzHOBtXnSdu+6PamxRJfaRC0yvD2Uyht3cM54VbbSHsY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GooKKcKS/wkHNbfLJFKA9mQL5KIKiKQ7c0aupXRulFQ=; b=N6gziAKXR9n4XxYVHTFRrWoLmK
 BhwlhY5WJJjVbawKPj4nFRNYg+X1HWgweZ8FBt+OnKluEWIQYuUjvGJ9EBQjtvO78hmC4lWAizdjF
 Y2r15UncJAOFd0O4HyuqWJWJcy7cx93Brzooj/cShJchc6xQQxliZCcs4GPbib34iLEA=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTKdm-000000000k8-2aY3 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 14:58:36 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so49872505e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 06:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794927508; x=1795532308; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GooKKcKS/wkHNbfLJFKA9mQL5KIKiKQ7c0aupXRulFQ=;
 b=IZkS/aecaJu4n1zN1aUu+OApdh76N0cEnUec++zy3/GSj1giFDNgSnnl5tbDHgojD5
 //N7lS8aHlcyRqszNuS0UBE7vUDH7AHOWP3YanNH/4Pxloy6lT7ifZP++9cbXb70zgNk
 wKg6CZTr1+AR6zAg43n2Pl3qCkGWicfVruCEwQWZ+rUm2Sgv5T3hs8a/IFvsyjNNQse+
 CBc41YTkipvbYCpaTPosSa+TKD2/rCmH/+LKz5CcpT9VSRVJe8E5taq1zxDyg8KB5Vwe
 gEPIrFtyzhzfWYiPwfHuoL32vEU5YX7YdearfhjX2N9iSwkKjeE7chaNF4xz7KOiJvzu
 eyAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927508; x=1795532308;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GooKKcKS/wkHNbfLJFKA9mQL5KIKiKQ7c0aupXRulFQ=;
 b=NeROMtCiQiWtRdpdSKEyHFSfxVm5A/+Mac6tlPPVjGEsArctknrjEyhEVG4yKTi5S2
 5PtqecsFj7BcWs1tct3F7lZRyhy0wPHrFI/E/IyaoViPzMjORwbeHh0OB+iTGcRlx3lI
 Wvzs96kJcxXDkHPjOIZ1umZ9QA4xVv0Vl3j2IpiTgsMp7mmEo/k+zwEQUm+RL3uQHeBx
 h17OZ3mwWTwfiDFiHzrKSFp6JmdM5dLazYvU/B87BV2cWJ6FXtsvmk+wVs5Wjijkw9c3
 jLDl32qmV5iGC1yZ+X6e5KH0PRmiRB0lvNnGf41CHNG3aFwjmOX44mRTro1/Z6F8XSvc
 VS2A==
X-Gm-Message-State: APuU4Z+WwgjvKu9yOfXZulbAVDg0ESJKI8hbdCXJxp2YO8OgbE+pVaC1
 JlW4NWjD5P1sdkrFvlrVgj1vB31h7ODxvsxBuNs+1BAvrAOgx3qh2ll57CG1oK50YRzh/TpIzRZ
 3xBH2h18i1l6MC6j05KGiTBYIXDkUT9BudjF/E63orRtdiu9JL5xkJoAIeL7llM+5f3ek
X-Gm-Gg: AYBFou1MD4v/vJlhJKcg0s5NmIeATGA4M/ks018pFRixCRYtbMByx+Z0sDOb+vxdmER
 l5s498JLV0/fqELz+NWouffGZDDs3TN6OfxcYkj7ngRLGOjwnYDNATxj4SZ4y8601H/nB2hWZTP
 Xn/7kty+y4qijsIfvaNpBZOBvKxbfheYYRLZ6n9fCiaCIjTchTGa2naQvBb0RLacfQ5lolB/BZE
 oTMFLIgm/SteLezVcGcm18Tg9pAZQX6AtTQWYEppW2o6Ds/YrN89SZhk2EuRamfT9YvU/4RVj+i
 14YEdGtcfA4G2DrtowT8bCOG/U6PLn8lLiwhPYqlca9lvA+yg8DoYjHoUVUScr+q6lZl9cyKfgS
 jXRjVSlxqRnlu0/Qc9SuE2WG7ubBI+zhhM7O0CROkisyJ5YIgmw24Ne/L7xws+hQefJEHLf+l6h
 t4Eqbvih/vbBwhBDBIIeCieBa9Vp5Kr3EH/jGmOwEvcJkjo6goQEOdHiF3Dy/vGAebYGApBoHxg
 +d0B1ym8sg9+s/KMH2/5oLaPSgQ0rJG/FW98qwbDAefYw65rhwyRUfdJfwXlIP/6P3Hxer/pS8S
 XbcgbZ2+hMNQmKX+CtV540ptkwZNUbvZJ4QRMDBwfQIQ+Gn4aeQasd/B/n8SKZ6jZn90pBTjdOS
 M5vxoXp6m8nuXyizwjnaISbVTOi2uSwp5/YagA1Gtph2sudlOWd28x4EjAOhWXnvHOLdbl6sN/x
 R5Rjhl5nAaaEx93TU=
X-Received: by 2002:a05:600c:8010:b0:4a7:9025:5c3b with SMTP id
 5b1f17b1804b1-4bb55a6a5f0mr289303905e9.19.1794927507847; 
 Tue, 17 Nov 2026 06:58:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783854cesm111185995e9.1.2026.11.17.06.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 06:58:27 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 14:58:24 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
X-Gerrit-Change-Number: 2212
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2212?usp=email>
X-Gerrit-Commit: 46980b1ef35880202d8b41e650f4cf73cd45e6ba
In-Reply-To: <gerrit.1794924454000.I06302e82cdc7c98503430500daa4ec95f5ce961f@gerrit.openvpn.net>
References: <gerrit.1794924454000.I06302e82cdc7c98503430500daa4ec95f5ce961f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTI0NDU0MDAwLkkwNjMwMmU4MmNkYzdjOTg1MDM0MzA1MDBkYWE0ZWM5NWY1Y2U5NjFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a665063a5424adbc7967e8c451f69c7a48a03db1-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTKdm-000000000k8-2aY3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: stop polling
 the listen socket while a client is connected
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8039191989675028035=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8039191989675028035==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8dGO9y0Bap8="; charset=UTF-8

--8dGO9y0Bap8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


Hello Arne Schwabe, R=C4=83zvan Cojocaru, 

I'd like you to reexamine a c=
hange=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?=
usp=3Demail

to look at the new patch set (#2)=2E

The change is no longer =
submittable: checks~ChecksSubmitRule is unsatisfied now=2E


Change subject=
: manage: stop polling the listen socket while a client is connected
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

manage: stop pollin=
g the listen socket while a client is connected

In server mode the managem=
ent listen socket stays in the persistent
event set after a client is accep=
ted=2E A second connection queued on it
keeps it readable, so every event w=
ait returns immediately for the
management, management_io() finds nothing t=
o do on the client socket,
and the server spins at 100% CPU while timers st=
arve=2E

Remove sd_top from the event set on accept; it is re-added when th=
e
state goes back to MS_LISTEN=2E Reset the cached state on removal, so the=

next update registers the right socket even after an accept or close in
a =
standalone management loop, and skip the removal when nothing is
registered=
=2E

Trac: #681
Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
Signed=
-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/openvpn=
/manage=2Ec
M src/openvpn/multi=2Ec
2 files changed, 16 insertions(+), 5 de=
letions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/12/2212/2

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2E=
c
index e0a490e=2E=2E10bc028 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/=
openvpn/manage=2Ec
@@ -344,6 +344,17 @@
 #endif
 }
 
+#ifndef _WIN32
+stati=
c void
+man_delete_event(struct management *man, const socket_descriptor_t =
sd)
+{
+    if (man->persist=2Ecallback=2Edelete_event)
+    {
+        (*m=
an->persist=2Ecallback=2Edelete_event)(man->persist=2Ecallback=2Earg, sd);
=
+    }
+}
+#endif
+
 static void
 man_close_socket(struct management *man, =
const socket_descriptor_t sd)
 {
@@ -352,10 +363,7 @@
      * Windows doesn=
't need this because the ne32 event is permanently
      * enabled at struc=
t management scope=2E
      */
-    if (man->persist=2Ecallback=2Edelete_ev=
ent)
-    {
-        (*man->persist=2Ecallback=2Edelete_event)(man->persist=
=2Ecallback=2Earg, sd);
-    }
+    man_delete_event(man, sd);
 #endif
    =
 openvpn_close_socket(sd);
 }
@@ -2070,6 +2078,8 @@
         {
 #ifdef _WIN=
32
             man_stop_ne32(man);
+#else
+            man_delete_event(ma=
n, man->connection=2Esd_top);
 #endif
         }
 
diff --git a/src/openvpn=
/multi=2Ec b/src/openvpn/multi=2Ec
index dacda86=2E=2E2389e66 100644
--- a/=
src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -4053,9 +4053,10 @@
 m=
anagement_delete_event(void *arg, event_t event)
 {
     struct multi_conte=
xt *m =3D (struct multi_context *)arg;
-    if (m->multi_io)
+    if (m->mu=
lti_io && m->multi_io->management_persist_flags)
     {
         multi_io_d=
elete_event(m->multi_io, event);
+        m->multi_io->management_persist_f=
lags =3D 0;
     }
 }
 

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2212?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f
Gerrit-Change-Number: 22=
12
Gerrit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schw=
abe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gi=
anmarco@mandelbit=2Ecom>

--8dGO9y0Bap8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>Gianmar=
co De Gregori <strong>uploaded patch set #2</strong> to this change=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2212?usp=3Demail">V=
iew Change</a></p><p>The change is no longer submittable: checks~ChecksSubm=
itRule is unsatisfied now=2E</p><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">manage: stop polling the list=
en socket while a client is connected<br><br>In server mode the management =
listen socket stays in the persistent<br>event set after a client is accept=
ed=2E A second connection queued on it<br>keeps it readable, so every event=
 wait returns immediately for the<br>management, management_io() finds noth=
ing to do on the client socket,<br>and the server spins at 100% CPU while t=
imers starve=2E<br><br>Remove sd_top from the event set on accept; it is re=
-added when the<br>state goes back to MS_LISTEN=2E Reset the cached state o=
n removal, so the<br>next update registers the right socket even after an a=
ccept or close in<br>a standalone management loop, and skip the removal whe=
n nothing is<br>registered=2E<br><br>Trac: #681<br>Change-Id: I06302e82cdc7=
c98503430500daa4ec95f5ce961f<br>Signed-off-by: Gianmarco De Gregori &lt;gia=
nmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/manage=2Ec<br>M src/open=
vpn/multi=2Ec<br>2 files changed, 16 insertions(+), 5 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/12/2212/2</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec</span><br><span>index e0a490e=2E=2E10bc028 100644</span><br><s=
pan>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -344,6 +344,17 @@</span><br><span> #endif</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_d=
elete_event(struct management *man, const socket_descriptor_t sd)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (man-&gt;persist=2Ecallback=2Edelete_eve=
nt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        (*man-&gt;persist=2Eca=
llback=2Edelete_event)(man-&gt;persist=2Ecallback=2Earg, sd);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static void</span><br><span> man_close_socket(struct managem=
ent *man, const socket_descriptor_t sd)</span><br><span> {</span><br><span>=
@@ -352,10 +363,7 @@</span><br><span>      * Windows doesn&#39;t need this =
because the ne32 event is permanently</span><br><span>      * enabled at st=
ruct management scope=2E</span><br><span>      */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (man-&gt;persist=2Ecallback=2Edelete_eve=
nt)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        (*man-&gt;persist=2Ecallba=
ck=2Edelete_event)(man-&gt;persist=2Ecallback=2Earg, sd);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    man_delete_event(man, sd);</span><br><span> #endi=
f</span><br><span>     openvpn_close_socket(sd);</span><br><span> }</span><=
br><span>@@ -2070,6 +2078,8 @@</span><br><span>         {</span><br><span> =
#ifdef _WIN32</span><br><span>             man_stop_ne32(man);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            man_delete_event(man, man-&gt;conn=
ection=2Esd_top);</span><br><span> #endif</span><br><span>         }</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvp=
n/multi=2Ec</span><br><span>index dacda86=2E=2E2389e66 100644</span><br><sp=
an>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec<=
/span><br><span>@@ -4053,9 +4053,10 @@</span><br><span> management_delete_e=
vent(void *arg, event_t event)</span><br><span> {</span><br><span>     stru=
ct multi_context *m =3D (struct multi_context *)arg;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (m-&gt;multi_io)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (m-&gt;multi_io &amp;&amp; m-&gt=
;multi_io-&gt;management_persist_flags)</span><br><span>     {</span><br><s=
pan>         multi_io_delete_event(m-&gt;multi_io, event);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;multi_io-&gt;managemen=
t_persist_flags =3D 0;</span><br><span>     }</span><br><span> }</span><br>=
</pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/2212?usp=3Demail">change 2212</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2212?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I06302e82cdc7c98503430500daa4ec95f5ce961f=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2212 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; <=
/div>

</body></html>
--8dGO9y0Bap8=--


--===============8039191989675028035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8039191989675028035==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8039191989675028035==--

