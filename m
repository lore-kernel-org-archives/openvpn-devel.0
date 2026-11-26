Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4581606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QlGC3l4o;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=W5QQN0Xy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G5xoqXl6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cCoaYcI2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=hBc+SKpcNF2DC2LV7fBk50B3j64ybiTKpeSp9sNXgjY=; b=QlGC3l4oBySkO1w+e69ySopDfQ
	8mDqTy+OwZ2TlQpL/oaJ8N349c/B/UhkZm6nie4xyF6tY3kGZ5rx6cSiYnL5vKjq1+074hLb7FAKA
	dPobe15hGBimkcFc97zYOHuq6O2khsZk9qaKIu0eA+TLcqG8R38BXOsXeHi9SCyGHYG4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWX0g-000000004gv-3B5Z;
	Thu, 26 Nov 2026 10:47:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWX0f-000000004gp-1wSj
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:47:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DT1vcHMTJV+HhZliQ6LyQjnYGaVdtRRtKvQWQhilx+4=; b=W5QQN0XybDEH5/HVe07aJmoPnl
 c3Q+Fq//bRZwk06F+a6Xz6cZzsoSa8qXJCJQkl5MGqC0bO3mbcP3W37qdewyC6bVdsZuSCOWiAE5i
 lXzmmJNdKYgZgHuaQ0JlWBQ9j+s0W06I88QmJZMm537OEsK8wRPgXCy9iiFza97NWWkg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DT1vcHMTJV+HhZliQ6LyQjnYGaVdtRRtKvQWQhilx+4=; b=G5xoqXl6IYNAiWM/ctGUEN1wW0
 4hbjWIvf3KVwzIH9Xuxm+5Jp2Am6vA+hqs4PzfIYS0vc1nGR+T8oZQIXrvM5oc2GLapxXbG6Z/plR
 5KwsMfkJKcXkGLj1DbU3w9nfH+diwkGL+DkyZba9CeLtLDtdvcQjCPEYngCWuAMA7Gp0=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWX0c-0000000041g-1Sxl for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:47:25 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bba5e17728so15352125e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 02:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795690036; x=1796294836; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DT1vcHMTJV+HhZliQ6LyQjnYGaVdtRRtKvQWQhilx+4=;
 b=cCoaYcI2rh1Ka+Ldm77S+voHWf1nf1fgWSBhxFh1NochOdZ462y22koNhpfoYEA3zT
 qDv86sZo2mqn/V86SXFYLa4u9kcJda8TrvOOWOdpVt8PrwoaeknAKbIylwQSK1eetW5m
 VUHDost7f4S9pi96xXE9WI2lJx7tozF+qIC+l6yx4Mvt+BjwSv0lfYWGXi7d91r//70r
 +oi24DBQoKMZRT6fLs0xDDdPBhWRyLscu7fgWD3L58JMEnMEe64OJJUWUm7q1Yn7EONX
 L35NygnuykofBW4A2Vl5btP1DYH38rCPC/srxCHcjaNiyZHii1El8KCWfswF0744mu6P
 wVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795690036; x=1796294836;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=DT1vcHMTJV+HhZliQ6LyQjnYGaVdtRRtKvQWQhilx+4=;
 b=DhVtBsCXFpgJKcROTDNhBcspICm8S7QbyjSOmR1ONx7FjRyUjM8py/UOAf7Ywxn5nj
 qpnH/m4BHVjg7e04rRaTckdAHf2FjTS9DFtlbYsK9GlC68hi/dNSk6nzdGWwHjYCJ97d
 7cxsrrK3h6qhh/DJFFFqwtUYd9en9tZzUBInBU+QBFUSQe95RCvqEl7OeYqobU0aDxZO
 jdlfR2dOet6YSTA8jlpU6U0mul0dnq9gmxU9lOqMxt/EZgBQY63GHszrp6Mu9CRGYrmw
 1oFOwh+H9C5kEW740X8iQlMZ2KqJmaVYPthmStvC+H25ZKTCTWNbz7Ocddm1pKIikGNq
 qifQ==
X-Gm-Message-State: APuU4Z9GnDJoig8cGA3Yb2qZ9arur/uez5ItlbUD1AxfHUDuilbA2Eyy
 dz9RGHlhjoz51RiufFXUB8kNoxx9RPfW2SLotUdXCvj5OIHje9sNRFe8lXPPnAy96YXMGd7LQ42
 +AMTjfFSDLYjoaG3amwDfa7l4/SmMMpKh76E9SjQ2Ckbd7aC/4M8jki5ksoXm8Po0bBOhR7b/kO
 XSnMOCWQ==
X-Gm-Gg: AZFdTZeOKNy0V7MzC4uEpHQsgZQnp5YJ3wuvvk2y2U7AF6zrxkHQezHVK0bEC+qMMGm
 kcbJPYMHP+ACvJ7IIYNZl/fUiBWHWp978ENjbJwF7oisKgygu2V8k7kuKWUAtfACk3bcwbCp5DK
 g89b3YpEzQaGRhTbPKQadI7wJJc4OEjeMoCBImx5U7REBuvXgii/nPEEoKeewJ62E7XkLqD07yt
 VsAMvKCABmMXO5XuCbB4IKaAseLViSFm2YW3Zah7D64S01sMqx0sG4aqYFHFaDJW1xqK73uWn+v
 SCm7GP/XHT8R1ZAm0bI8l3qb/Jp+xDwXZeMY8ZEtbHnlnkaQTZMFblOc+se9Rres/mcJ/GtZGer
 Db86MQW5CsF/q+0bdVQ7MtJ92QnkAJeMwS2GPK2kK+5aBUR4NT4t26U4k/04BinrwJ5j9PQ7Kd2
 QOKCsOLkBsgx3KTDfWeb8K9L5pN5YM07kEEcBbfD0IuHe+Krm/J5ve7P58KeYmKa51auJSJSqTi
 as24/92qAk7c9ntGq3L89ndyHMylqConHsdXIeBiqkQsXaVrCSVQBNy0KKjnJUgSe/iZw9iL1oR
 taWs2fy1DO3rIOBaiI3tcS6Gks99L9ZqlrAxIm8DkmM9DciGB5B2f7hRF8y8ZoUiDBWW3GMOtXQ
 PZ7gVy77bL6hPUDMsQols8YDjV/aF5shE0iiZsV0eMeLoOsveFp3s5LLYPnzRkdyu+TgxL95Utd
 Ehh7bTrJazGv27wWk=
X-Received: by 2002:a05:600d:1b:b0:4bb:ac7a:23f7 with SMTP id
 5b1f17b1804b1-4bbac7a25f1mr19203245e9.26.1795690035690; 
 Thu, 26 Nov 2026 02:47:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853ca452sm573802905e9.15.2026.11.26.02.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 02:47:15 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 10:47:14 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5
X-Gerrit-Change-Number: 2339
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2339?usp=email>
X-Gerrit-Commit: b4d1901c7b19ab7993e9216371e1b51618869dff
In-Reply-To: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
References: <gerrit.1795538311000.I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM4MzExMDAwLkk4N2RkNDFiNjZmN2Q3N2NhYjdhYWY4MGZhOWQ5MDk1ZTQ2YzAzM2Q1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e0ff3cf39e56b762028c9340fbe617700fa223ca-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWX0c-0000000041g-1Sxl
Subject: [Openvpn-devel] [S] Change in openvpn[master]: manage: Fix
 conversion warnings in man_write
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
Content-Type: multipart/mixed; boundary="===============8677800006640907315=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8677800006640907315==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EjiHeWDrrtk="; charset=UTF-8

--EjiHeWDrrtk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
339?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: manage: Fix conversi=
on warnings in man_write
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

manage: Fix conversion warnings in man_write

Use openvpn_sen=
d to avoid warnings due to
Windows/Unix differences=2E

Change-Id: I87dd41b=
66f7d77cab7aaf80fa9d9095e46c033d5
Signed-off-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339
Message-Id: <202611241=
90648=2E16745-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg41907=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file =
changed, 4 insertions(+), 13 deletions(-)


  git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/39/2339/4

diff --git a/src/openvpn/man=
age=2Ec b/src/openvpn/manage=2Ec
index bbf454a=2E=2Ecdd9501 100644
--- a/sr=
c/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -2448,11 +2448,6 @@
 
=
 #endif /* ifdef TARGET_ANDROID */
 
-#if defined(__GNUC__) || defined(__cl=
ang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign=
-conversion"
-#endif
-
 static ssize_t
 man_read(struct management *man)
 {=

@@ -2550,14 +2545,14 @@
 static ssize_t
 man_write(struct management *man)=

 {
-    const int size_hint =3D 1024;
+    const size_t size_hint =3D 1024=
;
     ssize_t sent =3D 0;
 
     buffer_list_aggregate(man->connection=2Eo=
ut, size_hint);
     const struct buffer *buf =3D buffer_list_peek(man->con=
nection=2Eout);
-    if (buf && BLEN(buf))
+    if (buf && BLEN(buf) > 0)
 =
    {
-        const int len =3D min_int(size_hint, BLEN(buf));
+        co=
nst size_t len =3D min_size(size_hint, BLENZ(buf));
 #ifdef TARGET_ANDROID
=
         if (man->connection=2Efdtosend > 0)
         {
@@ -2568,7 +2563,7 =
@@
         else
 #endif
         {
-            sent =3D send(man->connect=
ion=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
+            sent =3D openvpn=
_send(man->connection=2Esd_cli, CBSTR(buf), len, MSG_NOSIGNAL);
         }
=
         if (sent >=3D 0)
         {
@@ -2591,10 +2586,6 @@
     return sen=
t;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnosti=
c pop
-#endif
-
 static void
 man_connection_clear(struct man_connection *m=
c)
 {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87dd41b6=
6f7d77cab7aaf80fa9d9095e46c033d5
Gerrit-Change-Number: 2339
Gerrit-PatchSet=
: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@li=
sts=2Esourceforge=2Enet>

--EjiHeWDrrtk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2339?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">manage: Fix conversion warnings in man_write<br><br>Use openvpn_send to=
 avoid warnings due to<br>Windows/Unix differences=2E<br><br>Change-Id: I87=
dd41b66f7d77cab7aaf80fa9d9095e46c033d5<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
339<br>Message-Id: &lt;20261124190648=2E16745-1-gert@greenie=2Emuc=2Ede&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg41907=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/manage=2Ec<br>1 file changed, 4 insertio=
ns(+), 13 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/39/2339/4</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><span>index bbf454a=
=2E=2Ecdd9501 100644</span><br><span>--- a/src/openvpn/manage=2Ec</span><br=
><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -2448,11 +2448,6 @@<=
/span><br><span> </span><br><span> #endif /* ifdef TARGET_ANDROID */</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-conversion&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static ssize_t<=
/span><br><span> man_read(struct management *man)</span><br><span> {</span>=
<br><span>@@ -2550,14 +2545,14 @@</span><br><span> static ssize_t</span><br=
><span> man_write(struct management *man)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const int size_hint =3D 1024;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t size_=
hint =3D 1024;</span><br><span>     ssize_t sent =3D 0;</span><br><span> </=
span><br><span>     buffer_list_aggregate(man-&gt;connection=2Eout, size_hi=
nt);</span><br><span>     const struct buffer *buf =3D buffer_list_peek(man=
-&gt;connection=2Eout);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (buf &amp;&amp; BLEN(buf))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const int=
 len =3D min_int(size_hint, BLEN(buf));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const size_t len =3D min_size(size_hint, BLENZ(=
buf));</span><br><span> #ifdef TARGET_ANDROID</span><br><span>         if (=
man-&gt;connection=2Efdtosend &gt; 0)</span><br><span>         {</span><br>=
<span>@@ -2568,7 +2563,7 @@</span><br><span>         else</span><br><span> =
#endif</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            sent =3D send(man-&gt;connection=2Esd_cli, CBSTR(bu=
f), len, MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            sent =3D openvpn_send(man-&gt;connection=2Esd_cli, CBSTR(bu=
f), len, MSG_NOSIGNAL);</span><br><span>         }</span><br><span>        =
 if (sent &gt;=3D 0)</span><br><span>         {</span><br><span>@@ -2591,10=
 +2586,6 @@</span><br><span>     return sent;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> static void</span><br><span> man_connection_clear(struct ma=
n_connection *mc)</span><br><span> {</span><br></pre><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=3Demail">change =
2339</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2339?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I87dd41b66f7d77cab7aaf80fa9d9095e46c033d5 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2339 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--EjiHeWDrrtk=--


--===============8677800006640907315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8677800006640907315==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8677800006640907315==--

