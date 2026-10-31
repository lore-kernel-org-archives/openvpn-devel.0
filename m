Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0C606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 19:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Xi1iTlmD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nE6phO/Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=N9n/sSbJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B2EiuKgH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=qeS3iohlLXSgVkdBfINaeC10cWpoKCFcBBVFQy5XIlg=; b=Xi1iTlmDxeC7akLBt1ck7P4K6C
	NzVSodVVWLNrHtPVs3Lk+107qgCf1/F+6ruEFxeNha2XrZF/LPhKHK8W68CxXXLEBxjkh2SwmVncx
	AdUluX9znpFHXEGWuM4TsDAH0fe0WSfzeJVQyyMfI660le4pR8DUqUqqC7ha5j18joNc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNEQm-000000005d1-2LcW;
	Sat, 31 Oct 2026 19:07:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNEQk-000000005cs-3zxS
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 19:07:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6WG6xv99wsX2fi76cbyknl7o1eilB5feuuNhR2NEfOg=; b=nE6phO/YcmjR5OCPm/0vSU9FT6
 lVkJP/r5XKkwg0bz7MVvXPVlDVdANamNnycVcrvE/p2XPXVhZP5woElvw8jwvAeHIRSIWEvZr7src
 FHXPjHkaPpxNSMwxtWqPZ4RcBN2MUq21jm8OZaxiSqmsfJVW/Zk4BYsPis87dyiMaHug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6WG6xv99wsX2fi76cbyknl7o1eilB5feuuNhR2NEfOg=; b=N9n/sSbJnIy6ymG6SFy5bSnZdl
 DNCPllH4vvWvuIQEtZIGba5BgLmYzy7SqAokHH41F3MIbDLdjwbF2EG/TSaQPA6it/xBmgZp0mUR3
 Wl28bnKcYqk08edeTYBAKZvB4KFHhHfFNgu3asi57Q26xCuh3ROtMY4OSRVCyQK9eqzY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNEQk-000000006fS-0XXl for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 19:07:54 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2167bd087so13761405e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 12:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793473667; x=1794078467; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6WG6xv99wsX2fi76cbyknl7o1eilB5feuuNhR2NEfOg=;
 b=B2EiuKgHlPiIoR1fQNrizgi4z1ytWA5ZKHphooYaIygYwsDAFqNnwM2wCj20Zq9Ws3
 N7uftImg4b+3oZjHdsiQgG3sr3l3vz4zWXOaaSR9kFZr2SR7VzcwxbIF3ALUcnqquboj
 scp3PtMRiUApkE2RE3Z5shqy0ROAlo5FJoXYCXMvprhqHWQHlcP5WohSiNfyEJ18yhrJ
 mWJT5i+kO7q3uCedZXhbWyFU8+rFh10ZEC0MJ+16F7CrxV4HZZaHZioA5PJdZnSJciJD
 /eCm7mpDOPxsJBt2H8T/X+GOKr5WJ1PIPpcQd/k5R9dA4LTnCauxtRkML0o/hW9FWxT3
 cJRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793473667; x=1794078467;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6WG6xv99wsX2fi76cbyknl7o1eilB5feuuNhR2NEfOg=;
 b=CcIytXkiOGBZYBAWuusRCN1UBlmwToRdP5oYtGQcbvlOlZrfVayfEwT1q6Ecgu6tUm
 vlzV8lXYF1MVBv1B4kvjrl77rDHbfbmWTpKtO1XT602fGhl9rX1o8bZJnp2Kw+ly6slB
 rGJTTuNc/JBltCfQL3oaOCa/yK38qWwPeslT59C3mu2Mwe1JMlOhNZn0T27vsZmvAOkG
 ZTTz1YO3D8SOJkQ7m/f6wBR9nhXSY5HnC0tAYBv65FHE1TECR1cWNRuOR8AviBcvM6LK
 0W2giCo1vT+HZWhqn1bt2CngakiOM22SbTP5Jy+bXePI2A3wdJC2JDpV5bu4MsOCgqHE
 uDxQ==
X-Gm-Message-State: AFq9FYKmjI+TV5wDR/rJjz/mmv3dPiq8pQ9wSIWsaZa+e++hQsvKUrLv
 04haVmhtfUk0zTg4FWF3/nmai/ZuyEkEAFzWxZa8CUjuc5M1RnFIJMrRvB5pkLdB4BPRA/YfWnV
 JGAJqQqeYrYEqEiiZojK0vlSXIKy46S1/8C2AhnBQiVfy0V8FyM28hBsMsAkvZ26Hk+RxhFRY/2
 Z8unkZnw==
X-Gm-Gg: AYBFou3RQn4HWj/tW0TtQbkSC4RUH+mnjOQnWTW0d1PAQhv6m+8CGF5MD98oqTDwgBf
 io5NTzd5Djz7Bg9oSdQvUgeQnrrm5Lfu0OMvqbo/cnL2y1qHDSXBQNwsbkS1c0Jtp4C9yh0vsLM
 XEbmO9cVipvbsQNVvnhlVGtCkcOU/Ey44Oaa6CdUQYW+xVUJRrGqqe01aEAlCtxyoOcRB8i7Pzt
 4XsdcsDnrGKoHMVjuPU8C9W1rjxM4SUdN8MdNId5Ns8LNgxEPM4bKGbza+SI+n9H5fc0iH42m81
 3crcKoxekFjBXy/GOgBb5CwQnFEs1l25yp6g/49jorcYyayculCVareHiNXwLpOa7JNJUh0/cP0
 QjzZhWAsB2axojECkoMqbuPfVg3vFQKnC7qa85gc6PKBbxzqLQc9pcZwVWtq5SQiE1BnhzRArV5
 ZXStvQtRzrs7CManYmeo4ctgahQY6A32HdPR4Wt21ldtNKwd0ujLHSMP1ebeslcDnc/f7zmya0D
 2OxrsJwAux5YWLu4JpcGiyfZNO1fhDPxyXiHGzMNGxDe2ajuzjegFiiJjYpjDYtUfs77aNHbe0T
 omWsmKZUvdRXydEYnZY2/iErtab/629nCcrLdTkv/U2tIpuDC7/peDVcf8LYIe5FZskW/KSxeOI
 vbkEOiwwPX4THcBzV05IeXH3ZQQ0953i0siA2Qwt0yPqWKd0kCv7NCwaqHDnVRr3ZLKSHVmJuzG
 BydUkhtC9UkZcxrvQ=
X-Received: by 2002:a05:600d:e:b0:4ad:181a:4350 with SMTP id
 5b1f17b1804b1-4ad181a44a0mr68483745e9.21.1793473667380; 
 Sat, 31 Oct 2026 12:07:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abf368bff7sm149340565e9.2.2026.10.31.12.07.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 12:07:46 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 19:07:45 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee
X-Gerrit-Change-Number: 2032
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2032?usp=email>
X-Gerrit-Commit: 3e2d92c7f7e53f329795c865cb36d1fc788e9a9a
In-Reply-To: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
References: <gerrit.1792965388000.I62d95dad21891351a16cd6be43063406a024acee@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyOTY1Mzg4MDAwLkk2MmQ5NWRhZDIxODkxMzUxYTE2Y2Q2YmU0MzA2MzQwNmEwMjRhY2VlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5300146f350523bcf81172eba8fe1f6de9cf05e5-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNEQk-000000006fS-0XXl
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0490086647973266792=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0490086647973266792==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eAcUkipLmPA="; charset=UTF-8

--eAcUkipLmPA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Antonio Quartulli=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
032?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by Arne Schwabe


Change subject: multi: release the session-i=
d hash reference on shutdown
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


  git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/32/2032/2

diff --git a/src/openvpn/m=
ulti=2Ec b/src/openvpn/multi=2Ec
index b69a209=2E=2E0366c11 100644
--- a/sr=
c/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -584,6 +584,13 @@
      =
   m->earliest_wakeup =3D NULL;
     }
 
+    /* The sid hash holds a refer=
ence on the instance: drop it on
+     * instance close, otherwise the inst=
ance is never freed */
+    if (session_id_defined(&mi->sid_hashed_value))
=
+    {
+        multi_hash_sid_remove(m, &mi->sid_hashed_value);
+    }
+
 =
    if (!shutdown)
     {
         if (mi->did_real_hash)
@@ -605,12 +612,6=
 @@
         }
 #endif
 
-
-        if (session_id_defined(&mi->sid_hashed_=
value))
-        {
-            multi_hash_sid_remove(m, &mi->sid_hashed_va=
lue);
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
t-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I62d95dad21891351a16cd6be43063406a024acee
Gerrit-Change-Num=
ber: 2032
Gerrit-PatchSet: 2
Gerrit-Owner: Antonio Quartulli <antonio@mande=
lbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--eAcUkipLmPA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Anto=
nio Quartulli=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2032?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">multi:=
 release the session-id hash reference on shutdown<br><br>multi_hash_sid_ad=
d() takes a reference on the multi_instance, but<br>multi_close_instance() =
only drops it via multi_hash_sid_remove() when<br>not shutting down=2E On s=
hutdown hash_free() then frees the table without<br>releasing the reference=
, so every instance still connected when the<br>server stops is leaked (rep=
orted by LeakSanitizer, which also turns the<br>exit code into 1)=2E<br><br=
>Remove the instance from the session-id hash regardless of shutdown=2E<br>=
Unlike the other tables handled in that block, this one holds a<br>referenc=
e=2E<br><br>Fixes: 66f8cdb9 (&quot;Add lookup of multi session by session i=
d&quot;)<br>Change-Id: I62d95dad21891351a16cd6be43063406a024acee<br>Signed-=
off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt;<br>Acked-by: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2032<br>Message-Id: &lt;20261026110324=2E55339=
-1-frank@lichtenheld=2Ecom&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg40135=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec<=
br>1 file changed, 7 insertions(+), 6 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/32/203=
2/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</spa=
n><br><span>index b69a209=2E=2E0366c11 100644</span><br><span>--- a/src/ope=
nvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>=
@@ -584,6 +584,13 @@</span><br><span>         m-&gt;earliest_wakeup =3D NUL=
L;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* The sid hash holds a reference on the instan=
ce: drop it on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* instance close, otherwise the instance is never freed */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (session_id_defined(&amp;mi-&=
gt;sid_hashed_value))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mult=
i_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_value);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     if (!shutdown)</span><br><span>  =
   {</span><br><span>         if (mi-&gt;did_real_hash)</span><br><span>@@ =
-605,12 +612,6 @@</span><br><span>         }</span><br><span> #endif</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (session_id_defined(=
&amp;mi-&gt;sid_hashed_value))</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         multi_hash_sid_remove(m, &amp;mi-&gt;sid_hashed_value);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         if (mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span>       =
  {</span><br><span>             m-&gt;instances[mi-&gt;context=2Ec2=2Etls_=
multi-&gt;rx_peer_id] =3D NULL;</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Demail">change 203=
2</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2032?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I62d95dad21891351a16cd6be43063406a024acee </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2032 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quart=
ulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--eAcUkipLmPA=--


--===============0490086647973266792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0490086647973266792==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0490086647973266792==--

