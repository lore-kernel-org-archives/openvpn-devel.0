Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFF4606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 19:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lxDvgoUn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GKJMd1F/;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T2tDU3IU;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Qqvj3m+3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=H7MVwiEOAovMZi8zwFDoWxOSZVyBnd/93O5843HNfmo=; b=lxDvgoUncOhp3XvR9IPclHj2I9
	CrD2kPUrj9vQNTZV41ecLOZozjCaN7aYQyKZKsTkKHwJPEHzf/w+t6rS31lETnf2ctvNoYQafWOXa
	ObCpTZpXQ0B4tW8dlglNAQFRAcnSNEzSfMRYBs53MqoD27EcvnfSfww5xR+k6o/seIJE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNEQp-0000000037E-2DHY;
	Sat, 31 Oct 2026 19:07:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNEQn-00000000377-1mXt
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 19:07:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+bMA47oz3CzFs9Vs5Uw0WEmGqSBLG9Np61Lcye4p/g=; b=GKJMd1F/Rm+d/ucOAPF1qXWnXt
 VNTz95zf5CIlxKIYkxSWvSw4+IU9Rf9aVU5EgsnGqiaPAiMycxxcZ9TiTKGpi6EU7JZrvpFgo1Tyu
 gUpVmgImw/ZderSaOfW5654L0o0KVj9YGw3FvT14HA0f+nyc/oluMfW8O05H/qzuXZpE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w+bMA47oz3CzFs9Vs5Uw0WEmGqSBLG9Np61Lcye4p/g=; b=T2tDU3IUou4V8AoAPX/a0ly2Jq
 0LWVD405QWiQEh6e60/0ywcKcIGc2bn0+ocXMxkz05hWcJqac0ewgnI/yZCxqA4VRXMEzTta9UQUj
 Bb9YYa/HqIHljKoKCUAbswdFLrtD0ogWoVNWYy+ePXjiFn8/43fhhCWv5G2iWIYyuNiI=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNEQm-000000001KT-28qQ for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 19:07:57 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso860510f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 12:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793473670; x=1794078470; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w+bMA47oz3CzFs9Vs5Uw0WEmGqSBLG9Np61Lcye4p/g=;
 b=Qqvj3m+3go2lGXvqW4t9774zFb5sWym1MlDSNXI1/dY1vJ+tz8ZOPJriw8mJDlCwvJ
 PXHE+ahmuT0wU8b96al4NgBtZOm4ppy8hrOnVdPbNvbBpwivolBRH1hpXQ2R6N6WU4+z
 7+IynBQbCXJ9NjTbBTUb/jUBCgq2ocwe3n7S7zxjjnM4CGWtQB13km0J53uDbQCHnpzj
 kkA8MCJJx7Qy9oXghz52RpmQ9qdiyHTbEJWOJ7nAsxuTGyTE7XBrCM3ZE5yIvuHVQ4E7
 8XRfO31c8GcWkn3cmljsS8aBbThKUAFi/3VZTZE9CS58q05Q6KAfe2WBV/uDKm4aFeOZ
 21aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793473670; x=1794078470;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=w+bMA47oz3CzFs9Vs5Uw0WEmGqSBLG9Np61Lcye4p/g=;
 b=RotMwl/mqH+nCCDcnDwc0sPjTgT5lhamAUk12itxowU7jowAZkF0Dqa+dnHTBfdx7O
 TaR95d2v2k7pYvLFGK/3ogv0Z5xsgjBDos2adbvjxiCH78s9rXr8xrlPfCfHpOZqvAne
 Swcf+W4VGmTVMOyekmIIU1KWIwku/Sn+OavZxSDSTonnWl6UuoGsrjW0Arlz9YFVLEL1
 IlZmI9Mf8/Z871ERlP+Tt/4OGz/rqSz0kU3DtfBd8DEJcssake5KPORRCl61OcwDb2GN
 U2GJcYNSbBVMCKwfZyTw1zmPbWG1wySGXoxfRH03h0H29LZnts7yMmzJAQY2zbfEOwCd
 1B0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzKikNwofa9J8+derv6HBOI/tZlhRY9+zldnV3WzOOP+mFSOTT1KEmGq3X4QOVWJnpMPx3ZjRUYSsDalyCj@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIIICJe3oiCxp7ZYejwC3JQeFPEGhUmHvoMJ/vXavI+vsROdMDC
 dXheTgAAgV9EWwZeuOaF2yPEAsGNL5A/jcCavOzf0HWnm5kkWgEYR8I0aRngAYR6zhgU8ZYa6Nm
 fJpax3Tqb9KVwsWKpp/8nFDGH1VUHJayJpIERMfrzOI+ALRHZ5vWQY6uAoIk+KRfg0EXer4KR9O
 JAryDLZg==
X-Gm-Gg: AYBFou09Ih/8/MYxakIYmR4dVoQXFKjiHokokwGaxB80+40aBjuKRWw6aoBDzO0rBMN
 hljNCiMfbfY/Si3M+pJ5I6lwinEY2NgapqxMugF91ixPMIMkYZFi34txmQ3h8SSc70WZwjCXvl5
 gRDSCh2/yCSWQi0KxOqHqgA8N7ZLXkdorv+e7Uq+MKf7vN0urr77TR7S5KOlKVf1R2MTowPkpPL
 8gdofOtwAar8jhVJn1rSUm6sSjd9nitP3ejmLBpv/2WIueOeuYEPayHzgjJ7SaVpX5mKOUnmK07
 Yy3fUt3W34qMEn8ndHjM6oYghYzM9LuDAkCYxu0TsGAQ8L09b2GvQT8K1e3bq04/MMSzLjK1eR9
 NYMV0LSkX4HY54FqRHKmvHgHiRGKS8neay9N4yFGiyplFl+RhXpAVpZ1BLLBnnLIy7H3tQPMih3
 fFBLQTWKn2xYROxftzWZos09AtqjJ+LlIhkdvyKVJ/E13N4AJj45GEko7xQP7cP3mXzfsE+aqqV
 eITzxw3h7Bh28sbZhxELMwjxr9Dh8lpYIA2VQr4z8L2H45hG7RmEfFbkLyS+g1AOF8wwttOkOd1
 AmYjEEhx8lUC0RDF7BEF4IdNmijeI+3U8zrLFUc5W101IidXNc6ydoPALD4/A09G6MaSoWxMdKs
 d9JGE1Fhp4jmX1Wl0Zlq1L6UTMoT8FyH0N1fzQyiRDl2oInCdkgfzTupm6d8iAZ6U9f00VsajDS
 Y2bk9LU15a5vas7L6kKedLFf9hBfuS9vMbt6+OsA==
X-Received: by 2002:a5d:6f08:0:b0:48d:f877:3349 with SMTP id
 ffacd0b85a97d-48e6e4f8cf7mr13069592f8f.42.1793473669683; 
 Sat, 31 Oct 2026 12:07:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d5dfsm11914165f8f.3.2026.10.31.12.07.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 12:07:48 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 19:07:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee
X-Gerrit-Change-Number: 2032
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2032?usp=email>
X-Gerrit-Commit: 3e2d92c7f7e53f329795c865cb36d1fc788e9a9a
In-Reply-To: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
References: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTY1Mzg4MDAwLkk2MmQ5NWRhZDIxODkxMzUxYTE2Y2Q2YmU0MzA2MzQwNmEwMjRhY2VlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5300146f350523bcf81172eba8fe1f6de9cf05e5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xNEQm-000000001KT-28qQ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi: release the
 session-id hash reference on shutdown
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6157251083390696154=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6157251083390696154==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="haJuIr5d89w="; charset=UTF-8

--haJuIr5d89w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2032?usp=3Demail )

Change subject: multi: release the session-=
id hash reference on shutdown
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

multi: release the session-id hash reference on shutdown

=
multi_hash_sid_add() takes a reference on the multi_instance, but
multi_clo=
se_instance() only drops it via multi_hash_sid_remove() when
not shutting d=
own=2E On shutdown hash_free() then frees the table without
releasing the r=
eference, so every instance still connected when the
server stops is leaked=
 (reported by LeakSanitizer, which also turns the
exit code into 1)=2E

Rem=
ove the instance from the session-id hash regardless of shutdown=2E
Unlike =
the other tables handled in that block, this one holds a
reference=2E

Fixe=
s: 66f8cdb9 ("Add lookup of multi session by session id")
Change-Id: I62d95=
dad21891351a16cd6be43063406a024acee
Signed-off-by: Antonio Quartulli <anton=
io@mandelbit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032
Message-Id: <20261=
026110324=2E55339-1-frank@lichtenheld=2Ecom>
URL: https://www=2Email-archiv=
e=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40135=2Ehtml
Signed-off-=
by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 fi=
le changed, 7 insertions(+), 6 deletions(-)




diff --git a/src/openvpn/mu=
lti=2Ec b/src/openvpn/multi=2Ec
index b69a209=2E=2E0366c11 100644
--- a/src=
/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -584,6 +584,13 @@
       =
  m->earliest_wakeup =3D NULL;
     }
 
+    /* The sid hash holds a refere=
nce on the instance: drop it on
+     * instance close, otherwise the insta=
nce is never freed */
+    if (session_id_defined(&mi->sid_hashed_value))
+=
    {
+        multi_hash_sid_remove(m, &mi->sid_hashed_value);
+    }
+
  =
   if (!shutdown)
     {
         if (mi->did_real_hash)
@@ -605,12 +612,6 =
@@
         }
 #endif
 
-
-        if (session_id_defined(&mi->sid_hashed_v=
alue))
-        {
-            multi_hash_sid_remove(m, &mi->sid_hashed_val=
ue);
-        }
-
         if (mi->context=2Ec2=2Etls_multi->rx_peer_id !=
=3D MAX_PEER_ID)
         {
             m->instances[mi->context=2Ec2=2Etl=
s_multi->rx_peer_id] =3D NULL;

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2032?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I62d95dad21891351a16cd6be43063406a024acee
Gerrit-Change-Number: =
2032
Gerrit-PatchSet: 2
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--haJuIr5d89w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2032?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">multi: release the session-id hash=
 reference on shutdown<br><br>multi_hash_sid_add() takes a reference on the=
 multi_instance, but<br>multi_close_instance() only drops it via multi_hash=
_sid_remove() when<br>not shutting down=2E On shutdown hash_free() then fre=
es the table without<br>releasing the reference, so every instance still co=
nnected when the<br>server stops is leaked (reported by LeakSanitizer, whic=
h also turns the<br>exit code into 1)=2E<br><br>Remove the instance from th=
e session-id hash regardless of shutdown=2E<br>Unlike the other tables hand=
led in that block, this one holds a<br>reference=2E<br><br>Fixes: 66f8cdb9 =
(&quot;Add lookup of multi session by session id&quot;)<br>Change-Id: I62d9=
5dad21891351a16cd6be43063406a024acee<br>Signed-off-by: Antonio Quartulli &l=
t;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
032<br>Message-Id: &lt;20261026110324=2E55339-1-frank@lichtenheld=2Ecom&gt;=
<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg40135=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file changed, 7 insertion=
s(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi=2Ec b/=
src/openvpn/multi=2Ec</span><br><span>index b69a209=2E=2E0366c11 100644</sp=
an><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/=
multi=2Ec</span><br><span>@@ -584,6 +584,13 @@</span><br><span>         m-&=
gt;earliest_wakeup =3D NULL;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The sid hash holds=
 a reference on the instance: drop it on</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * instance close, otherwise the instance is never=
 freed */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (se=
ssion_id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        multi_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_value=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!shut=
down)</span><br><span>     {</span><br><span>         if (mi-&gt;did_real_h=
ash)</span><br><span>@@ -605,12 +612,6 @@</span><br><span>         }</span>=
<br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (session_id_defined(&amp;mi-&gt;sid_hashed_value))</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            multi_hash_sid_remove(m, &amp;mi-&gt;sid_h=
ashed_value);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>   =
      if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)<=
/span><br><span>         {</span><br><span>             m-&gt;instances[mi-=
&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?us=
p=3Demail">change 2032</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2032?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2032 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@=
greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--haJuIr5d89w=--


--===============6157251083390696154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6157251083390696154==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6157251083390696154==--

