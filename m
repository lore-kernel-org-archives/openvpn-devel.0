Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614FC606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HizpVYtD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EfDdPjLp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fed/ZOoi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NkmoM0VK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YHc8+dvWrAxglovY6J4TrUV+c357ik6iPl3AzNGhBDM=; b=HizpVYtDPpSZgb5hxDjc/9Mi6l
	tMsdALyXqOHcyGZObP2lEWHF6ha9+scdCKhqrjaJ8PW/Wz0s2GdCJmHrIPtyGzeTzl9v5xCXnPqv1
	rT/vZ3ESlwyrgspHHgyTZ6vzAGLo7JzhUXKWrvBmshsWN+ShQWxYJZDaoXQO/F9Jjchs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNpWr-000000000kD-0Iam;
	Mon, 02 Nov 2026 10:44:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNpWq-000000000k0-0doM
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:44:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f1fwVk8k6rGUx5gCCi65MhJfnuYn4brKjSukgYsFbJc=; b=EfDdPjLp5LXKNhrMlPU3HoR5gD
 aNtSnz8GcdT7czS/LKUUXWHE5NckikOYo1RJmwfQJMjwwFQOTKYhq9c2H08lptJ/OdFUKaAF5yEiz
 Htd1hKmycSLv6zL+PqWmbFf/uC6U/DtLpKdVUuZocs9Fm+RQBLFkWJWK51sABMTyxRe8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f1fwVk8k6rGUx5gCCi65MhJfnuYn4brKjSukgYsFbJc=; b=fed/ZOoiFmzWFvZlLEn+xZnpjU
 vfdvE9ZOMZE+utNJdRgg2TaI4XsW3Pv382UbSyxC46BeMs8Py/Y54OCuY7blL+05F70JU+s67L79P
 8CqiTRkIYqScthgstHCvbf/MMlFDESiPahL8SoLl/jj8uHz3v75F4OQEoRjCH9OWlYUQ=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNpWo-000000003cc-3yc8 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:44:40 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48e04773687so761579f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 02:44:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793616272; x=1794221072; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=f1fwVk8k6rGUx5gCCi65MhJfnuYn4brKjSukgYsFbJc=;
 b=NkmoM0VKEAbWiS0VKuXQJ/6IECRi/Fii9KbF/H99O3gSVNTCp/BB4FXdbySXNW7mnu
 hhJn6JYtEwDqO6qnPXJisJDxtecs7mBpnADLiBujLa6/RKuREg5eiIH8mELxor1/fG4h
 UXFMqgmtyzozyzrZYEw3KqyFa3Egf00hSvFY/EpGNLGvi8V1n7FYvLQ21xOtN5czVIUr
 CJvn2Ok7DEwNGqBUUzn4ZCRhA/io/L7/aYeInx1wE20c6ASh44ZOnZ2mhpzvaZ6pqtON
 5W1xVBBSPd4CmBZk8aqTfPo0w7MepFcaoU5cR8lsm0QT5kGL0uz1NqRjVM9yj1IJH9P+
 KdBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793616272; x=1794221072;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=f1fwVk8k6rGUx5gCCi65MhJfnuYn4brKjSukgYsFbJc=;
 b=FfB31AACmMaDbRx+phqGGb+QiLknRfY318TNh88qnwepGi4p1lJ+O6v12+whEY1Xrk
 AidmZ77C9b9tzg6DJiiHl0D4l7uFEe/MH3uSLPibVLZnKQs67zlTpfAeWsmswBPnXSIN
 HzwA9OL1Q6DA5Awp+o8fszWg2j99XIbdPHB39/ZfRqv8/y9rKrjPLlJwm8HoPE4Go8vx
 qkvLrcHT/aSWaCdQJcx+4w4pWL6yyCMF1jvGFH5aMtNHQ5I6aVkpYMXTh0Dlu6+F96Md
 MV9CGzxnAOyF6BFsDMP48CPVtwXGM7WmBF2O5rf4zO4I0e4JTrUCGULfooqerGSpX6yG
 KZOQ==
X-Gm-Message-State: APuU4Z/d4CcoV5f0SQ5b8ke3STc734k8SPY+0G/6U/q2U/m8JQFMKxLp
 lHCI/ovUInbXTMQmNCoHVHYQpwh1butLjLFeyinlkWXME2GiCIN+ElRtQhOSo5ZDQXb55xVx3kG
 UVS/yYD3nYh1Nqd/XZfuwNIMcmutq21qsMAyCZdoNQIiZSMnF23WwwKrpcOZPXAoAIe8F
X-Gm-Gg: AYBFou0s8ttfKP6LD2hfKXGO4HPQ4KLijM7jadwY2/D4X35OKw1sqVYVb0fPCjF9Gog
 8kp7Tr7jUYCeQEJRGTAAH4uCw50F008ju7arAARyrrdsaTV3/11in4JD9QeX37/81NJWSJTgPOk
 DNGCpBA90wc3Cq/QPfW+w8Wy4Ekfl8Ztp5GQeON+fPaMmmGhaGYUU+iPl+em7+6I/5DokcAi3nK
 d+ckAyWDghM5T7siV5RmXV2rdBtaxsfdnb1cKmcRgpb3D+L4XPfYOmeq1M6FstyQxt+8q5rtBd9
 3fZprLqsq3g9fLEWaazA3U3l+/7XvC6QKA/q3mDfjdidcy8C9Ez/bDrZV0SzK4mSdwB1NA8EWMN
 gNE1bVZ0CDOyy6u5JUo6g1l9CJZHrRTBqJVxn9UrMyx8NKJpJzM/HcRhGi6D9lUv8dS146TL2Dj
 c7YMWpkISgnRzZQWn56r4dKEd4zfS3nO8OIcvxmIYxM4frRjepJ4Iygqq5e14Ygmz+TIhdzW+hj
 K4dhvXt3aFD40WToiklCgdEbpDIBU95eVaXe7p7fdoiAuvgs8pGTIcQIZ6n2CR5w5G2iFKO/TGX
 qaoRUlIZ85kfmq+4qRzpt6Rltc2M8tz7HPwzOHd2pdgggZLfoRTYMtFm5aSfCvPn0j2qwd2Liip
 QUTADvvJLRocknpkaiiD6G+NNF53AESIlR0jVrcy5ferCWLx1L4RHGRFbv+QrocviIqHK9NM0/c
 B1b67OW2DZccZLjQ==
X-Received: by 2002:a05:6000:2997:20b0:488:57ad:d5c8 with SMTP id
 ffacd0b85a97d-48e6e2bc78dmr15969679f8f.3.1793616272089; 
 Mon, 02 Nov 2026 02:44:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80eb1sm20491969f8f.34.2026.11.02.02.44.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:44:31 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 10:44:30 +0000
To: Selva Nair <selva.nair@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
X-Gerrit-Change-Number: 2073
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2073?usp=email>
X-Gerrit-Commit: 35f40a2cb94317dc15dfbae82b7477c86a8d4219
In-Reply-To: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
References: <gerrit.1793389270000.Iea14ef08268e6f6309e4bac4acff27958da8b045@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMzg5MjcwMDAwLkllYTE0ZWYwODI2OGU2ZjYzMDllNGJhYzRhY2ZmMjc5NThkYThiMDQ1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f63e6fe220dab917fe4211c34c48642855a4a1b9-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNpWo-000000003cc-3yc8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Increase the buffer
 size for alert-message in management user-pass query
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7888288602534486052=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7888288602534486052==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KraDe2EOYTk="; charset=UTF-8

--KraDe2EOYTk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#3) to the change originally cre=
ated by Selva Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru


Change subject: Increase the buffer size fo=
r alert-message in management user-pass query
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Increase the buffer size for alert-messa=
ge in management user-pass query

Increase the buffer size from 128 to 256 =
to accommodate a reasonably
long username and static challenge message when=
 both are included in
the prompt=2E Print a warning if the text is truncate=
d=2E

If the encoded " UN:<username-base64>" string is longer than 128 byte=
s,
skip adding it to the prompt=2E Print a warning=2E This caters to up to
=
about 90 bytes long usernames=2E

Change-Id: Iea14ef08268e6f6309e4bac4acff2=
7958da8b045
Signed-off-by: Selva Nair <selva=2Enair@gmail=2Ecom>
Acked-by: =
Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2073
Message-Id: <20261031074840=2E27546-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40361=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/manage=2Ec
1 file changed, 16 insertions(+),=
 8 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/73/2073/3

diff --git a/src/openvpn/manage=2Ec b/src/openvpn/mana=
ge=2Ec
index 65e2881=2E=2E16864c8 100644
--- a/src/openvpn/manage=2Ec
+++ b=
/src/openvpn/manage=2Ec
@@ -3618,7 +3618,7 @@
     {
         volatile int =
signal_received =3D 0;
         const bool standalone_disabled_save =3D man=
->persist=2Estandalone_disabled;
-        struct buffer alert_msg =3D alloc=
_buf_gc(128, &gc);
+        struct buffer alert_msg =3D alloc_buf_gc(256, &=
gc);
         const char *alert_type =3D NULL;
         const char *prefix =
=3D NULL;
         unsigned int up_query_mode =3D 0;
@@ -3680,23 +3680,31 @=
@
              * Indicate it in the prompt as base64 encoded=2E
          =
    */
             char *user64 =3D NULL;
-            if (openvpn_base64_=
encode(up->username, (int)strlen(up->username), &user64) !=3D -1)
+        =
    const int user64_len =3D openvpn_base64_encode(up->username, (int)strle=
n(up->username), &user64);
+            if (user64_len =3D=3D -1)
         =
    {
-                buf_printf(&alert_msg, " UN:%s", user64);
+         =
       msg(M_NONFATAL, "ERROR: could not base64-encode username");
+       =
     }
+            else if (user64_len + 4 > 128)
+            {
+        =
        msg(M_WARN | M_INFO, "Preferred username too long for user-pass pro=
mpt sent to management; omitting UN:<username> hint=2E");
             }
  =
           else
             {
-                msg(M_NONFATAL, "ERROR: cou=
ld not base64-encode username");
+                buf_printf(&alert_msg, " =
UN:%s", user64);
             }
             free(user64);
         }
 
   =
      if (sc)
         {
-            buf_printf(&alert_msg, " SC:%d,%s",
-=
                       BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_ECH=
O)
-                           | (BOOL_CAST(flags & GET_USER_PASS_STATIC_CH=
ALLENGE_CONCAT) << 1),
-                       sc);
+            if (!buf_p=
rintf(&alert_msg, " SC:%d,%s",
+                            BOOL_CAST(flags=
 & GET_USER_PASS_STATIC_CHALLENGE_ECHO)
+                                | =
(BOOL_CAST(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT) << 1),
+         =
                   sc))
+            {
+                msg(M_WARN | M_INFO=
, "SC:<challenge-text> in user-pass prompt sent to management got truncated=
=2E");
+            }
         }
 
         man_wait_for_client_connection(=
man, &signal_received, 0, MWCC_PASSWORD_WAIT);

-- 
To view, visit https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-B=
ranch: master
Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b045
G=
errit-Change-Number: 2073
Gerrit-PatchSet: 3
Gerrit-Owner: Selva Nair <selv=
a=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--KraDe2EOYTk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #3</strong> to the change originally created by Selv=
a Nair=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Incre=
ase the buffer size for alert-message in management user-pass query<br><br>=
Increase the buffer size from 128 to 256 to accommodate a reasonably<br>lon=
g username and static challenge message when both are included in<br>the pr=
ompt=2E Print a warning if the text is truncated=2E<br><br>If the encoded &=
quot; UN:&lt;username-base64&gt;&quot; string is longer than 128 bytes,<br>=
skip adding it to the prompt=2E Print a warning=2E This caters to up to<br>=
about 90 bytes long usernames=2E<br><br>Change-Id: Iea14ef08268e6f6309e4bac=
4acff27958da8b045<br>Signed-off-by: Selva Nair &lt;selva=2Enair@gmail=2Ecom=
&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit U=
RL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2073<br>Message-Id: &lt;2026=
1031074840=2E27546-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email=
-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40361=2Ehtml<br>S=
igned-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/=
openvpn/manage=2Ec<br>1 file changed, 16 insertions(+), 8 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/73/2073/3</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage=2Ec b/src/op=
envpn/manage=2Ec</span><br><span>index 65e2881=2E=2E16864c8 100644</span><b=
r><span>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/mana=
ge=2Ec</span><br><span>@@ -3618,7 +3618,7 @@</span><br><span>     {</span><=
br><span>         volatile int signal_received =3D 0;</span><br><span>     =
    const bool standalone_disabled_save =3D man-&gt;persist=2Estandalone_di=
sabled;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct=
 buffer alert_msg =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer alert_msg =3D alloc_buf=
_gc(256, &amp;gc);</span><br><span>         const char *alert_type =3D NULL=
;</span><br><span>         const char *prefix =3D NULL;</span><br><span>   =
      unsigned int up_query_mode =3D 0;</span><br><span>@@ -3680,23 +3680,3=
1 @@</span><br><span>              * Indicate it in the prompt as base64 en=
coded=2E</span><br><span>              */</span><br><span>             char=
 *user64 =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (openvpn_base64_encode(up-&gt;username, (int)strlen(up-&gt;user=
name), &amp;user64) !=3D -1)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            const int user64_len =3D openvpn_base64_encode(up-&gt;=
username, (int)strlen(up-&gt;username), &amp;user64);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (user64_len =3D=3D -1)</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user64=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
sg(M_NONFATAL, &quot;ERROR: could not base64-encode username&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            else if (user64_len =
+ 4 &gt; 128)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(M_WARN | M_INFO, &quot;Preferred username too long for user-pass pr=
ompt sent to management; omitting UN:&lt;username&gt; hint=2E&quot;);</span=
><br><span>             }</span><br><span>             else</span><br><span=
>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          msg(M_NONFATAL, &quot;ERROR: could not base64-encode username&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user64);</span><br><span>  =
           }</span><br><span>             free(user64);</span><br><span>   =
      }</span><br><span> </span><br><span>         if (sc)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 buf_printf(&amp;alert_msg, &quot; SC:%d,%s&quot;,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                       BOOL_CAST(flags &amp; G=
ET_USER_PASS_STATIC_CHALLENGE_ECHO)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                           | (BOOL_CAST(flags &amp; GET_USER_=
PASS_STATIC_CHALLENGE_CONCAT) &lt;&lt; 1),</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                       sc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            if (!buf_printf(&amp;alert_msg, &q=
uot; SC:%d,%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                            BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHA=
LLENGE_ECHO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                         | (BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHAL=
LENGE_CONCAT) &lt;&lt; 1),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                            sc))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                msg(M_WARN | M_INFO, &quot;SC:&lt;challenge-t=
ext&gt; in user-pass prompt sent to management got truncated=2E&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span>         }</span><br><span> </span><br><span>         man_wait_for_c=
lient_connection(man, &amp;signal_received, 0, MWCC_PASSWORD_WAIT);</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2073?usp=3Demail">change 2073</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2073?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Iea14ef08268e6f6309e4bac4acff27958da8b=
045 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2073 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>

</body></html>
--KraDe2EOYTk=--


--===============7888288602534486052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7888288602534486052==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7888288602534486052==--

