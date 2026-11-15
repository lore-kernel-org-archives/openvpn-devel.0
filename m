Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B5606A32D
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Gnsa2EQg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JnjIWbiQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PJ5j+3sL;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JGJL4Ndw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UUY6t7cPLIItcKUwTJxhDi2k4rrU4h3J25JuWd/GNhs=; b=Gnsa2EQg+dM8EjX37fP3U7XXXp
	e5WNTlHlH+7nd7jJd2nYZTBmFHxrhY7ZSpopxq+ciGNfh+sUF7q3jLjdz7qx9TrNq0QTH0J9yy9gJ
	WJZASDgK/tj/UP2Q6VR/m0vNWfge1Vn6nzni1pk70xKUJfaPeWedJee7Zrcg6Lj/FwXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xScDt-000000007Tq-2qYG;
	Sun, 15 Nov 2026 15:32:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xScDs-000000007Tj-3iAA
 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w1+HYXPLp4dDdpfe7X4pEBI6BIRyuvFKWBk/NL1vHbY=; b=JnjIWbiQwFuYoRFsSPGA/eOy4v
 atVvHcKt8ok/HmLGiCNsTKWNNzxSFvoZSGP0PL07roxlUIGSK47LaXAtrbGPjOdY6CzGnIgazXe+3
 brUvbcLlHhOKw9x7Tai74n27xjXUc4Zk1h0OSpmoTC1VAeeFKKM+wGyCfiFRt9igyoWg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w1+HYXPLp4dDdpfe7X4pEBI6BIRyuvFKWBk/NL1vHbY=; b=PJ5j+3sLg66iV2uMU3yoia24WI
 h+K4Jr1yaAmVGsIJIc6GKQe9KTln+4pn3O0KGGVWXOkBekK2/2mNDT19zow8/SNdP8GX2Ok3DnmEo
 KKk5WlpLRavjd2bCQZRn8hYybypSp5nuXjfB2G/yPSYeOQndW68mYnEUpI8cbe2ahsc4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xScDq-000000001z5-41P9 for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 15:32:51 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-497614c95f0so1127906f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 07:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794756764; x=1795361564; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w1+HYXPLp4dDdpfe7X4pEBI6BIRyuvFKWBk/NL1vHbY=;
 b=JGJL4Ndw2aFMlRDpEkLhWEh4iF15ekU2eVFHKIUERUnjfmlO9G1MJZ32JmNTNHxelc
 Wxj3SpE/sVZAQkHf+YDbMEptFVFUW9+hBdRRAP4UxPCrh01RwtrmTho4FA+6nJJa+G+U
 8qN9tVLHICxwR2/KA2vIF/eQVVnuMpUB+rTJJXyYSyo0kmOmr6KcIIBmLg1IX0B43cFd
 c403zuhqE+xCExvQuRvk8+9c3gs/jLMoU7F4tWEkiawO63Cq2aOGU9B6PYiZ/PphxPEk
 FbtXzh/g9Ypd4C5mwR53OPE8skhkaZtw6dobKcfy2n6jDVzO4Wa8R83DjEcrWNLXkMm7
 xmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794756764; x=1795361564;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w1+HYXPLp4dDdpfe7X4pEBI6BIRyuvFKWBk/NL1vHbY=;
 b=KVoovrK5h569uDlPoDhX4kM3CrccB7fhvwmn8I4pLfLc4bgUbA+xoo+Ub1bnCIET0V
 aWioHteK9e5JQVhdOKXi2B59qzCGeheIP028T3q422Ufh6dnu7YfRCiFnhwISmnC4Kfp
 cFm97mG5q5xPcf/08eHxxbTuRkBwrH1Z5CgH83JFa5WkCPfzZFXAoTMGSLu80Gf8K7Zn
 GK9NfS5S6Gkqumj04MsHMcj1rhFuHu15YlUA/NecY+tpoFtpSFFBumtF2Lo8qG2L+dEe
 T20NR8Y5UvxTNvogU3PkYIPFofm50wcmKd6gkW5YlRxVnLohlRMEjmNqIxqs1hPKB5UJ
 /Hmw==
X-Forwarded-Encrypted: i=1;
 AL+hErEPmwb7DUIAqxuN4WepqXQ4NJ58Z/V9qoZkw17XGzACUVk3QLT8Kjd1HUdBR+iMQICLgPUJ4quUHwZQ8yOj@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+kUizTR2FTFrRbusKYD7fyJu1mQ9XlFpo/kXbRR4u5CzgiWkcU
 S0mEiDhyBT2wj98K4F4YXQlPqEYRJeIK0rLqEpg+DzwhIcaDuZ2BPffJ/dt2LvyPdIi6mrrSQ23
 DLVEYci9/D7O1UHzvF8o4MkWAu9Omsn7CME/J+OlbEq4Y1yL+2oyqTsrgEaPIZ2+M0cwT
X-Gm-Gg: AYBFou0GKyV0RgHHfnhMz8cjAOzyT9Gs4b0bmnAemGx/gslm5/xSzZZT7SS8wHM0CQf
 QOXvS+fFVd+Kf8YKwRLtIWpSYCfdyqvJ/Bp9KeoYyr7uMb4shDlWhe+BHVFjQyYj04gdDrM0vU/
 jHnIS91M7rDP5QAZnRemUSMeKfRBEWC2QBI1YQI3yMGSrSnMeAGPqTs3yiJ3fR4MEW6xjk1jp+w
 DBt6SDTVs7LQSpOuWj8oIPPIf0+0B4IpyVBu9otXIZRppROZcY4JUc+nz7t+FZrZyO+HtzoSVtT
 SL0EpQgIF8Xw/IA1irrDxUq/kCSvOgv+HCaHMZIyxc5epN0TwWWXqRxZXnO5hdJu6GmfjMoxLIS
 RzB6fRY5npcX+CSxL2TMlusjdPWvo6nOka+POlVOVIQqAGo3u1vEPr8VjDfxksI9QUx00TPsnMr
 HGad3U/+KiwAquWIN/DAE7aBR+b5PYyylu3L0SIEcCVITJmwh6xbdBhpGTKJUheroPWcgd7y6SZ
 yDOk0DCrba8AzGYaqKMUL16KeQURHIrcWEQumLjftJ4fVKBb8zt7f9qT8zOnniTtXKBVj8xCoAC
 wbe8u60roUG57sqrAkfRN7VNWXlcZ1N7auHSk5zorS9TxoykJJj4pqlokZ82Y3KEH624/FM564y
 jnwD+5aCme87rppFmj+Gssgm/BidxK+Fjk8V3qAY1sHUtkU3EtOOcgMf5Jd7MppHsuYSY9ywXbv
 K5Mg8pDi/lJWAKVm8=
X-Received: by 2002:a05:6000:2c02:b0:493:fdf6:14aa with SMTP id
 ffacd0b85a97d-49c74e22bd3mr18441414f8f.56.1794756764199; 
 Sun, 15 Nov 2026 07:32:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c604ecda5sm16195846f8f.37.2026.11.15.07.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 07:32:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 15 Nov 2026 15:32:43 +0000
To: Hansaem Wi <hansaemw@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0
X-Gerrit-Change-Number: 2079
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2079?usp=email>
X-Gerrit-Commit: 583f6fdc22c9b4ca9521b401210afb83cf8978aa
In-Reply-To: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
References: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNTk0Mzg4MDAwLkk4ZTAyYjRjZjM5Y2M0MzFmMWYyYzA1OGRiOTU5OTdjODkwNzU1N2MwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f5611a1840ee3c91aa33acc15856e758fc28dfd8-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xScDq-000000001z5-41P9
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tls_crypt: Wipe the
 tls-crypt-v2 client key copies
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
 openvpn-devel@lists.sourceforge.net, steffan@karger.me, hansaemw@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0822636654171920252=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0822636654171920252==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cV6fiiZ+HZU="; charset=UTF-8

--cV6fiiZ+HZU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2079?usp=3Demail )

Change subject: tls_crypt: Wipe the tls-cry=
pt-v2 client key copies
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E

tls_crypt: Wipe the tls-crypt-v2 client key copies

tls_crypt_v2=
_init_client_key() reads the client key into a struct key2
on the stack, co=
pies it to *original_key and returns without clearing
it, so every client s=
tart leaves the tls-crypt-v2 client key on the
stack=2E crypto_read_openvpn=
_key() does the same copy for tls-auth and
tls-crypt keys and clears its st=
ruct key2 afterwards; do the same here=2E

The --genkey tls-crypt-v2-client=
 sanity check in
tls_crypt_v2_write_client_key_file() has two more copies:
=
- keydata, the struct key2 that tls_crypt_v2_init_client_key() fills;
  cle=
ar it after use=2E
- check_wrapped_client_key, the decoded key file buffer:=
 the client key
  is still in front of the wrapped key when it is freed=2E =
Clear it with
  buf_clear() before free_buf(), as do_close_free_key_schedul=
e() does
  for the client's tls_crypt_v2_wkc=2E

Assisted-by: Claude Code:c=
laude-opus-5-5
Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0
Signed-=
off-by: Hansaem Wi <hansaemw@gmail=2Ecom>
Acked-by: Steffan Karger <steffan=
@karger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079
M=
essage-Id: <20261102101437=2E1209-1-gert@greenie=2Emuc=2Ede>
URL: https://w=
ww=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40954=2E=
html
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvp=
n/tls_crypt=2Ec
1 file changed, 3 insertions(+), 0 deletions(-)




diff --=
git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec
index 64db29f=
=2E=2Ed7f69f7 100644
--- a/src/openvpn/tls_crypt=2Ec
+++ b/src/openvpn/tls_=
crypt=2Ec
@@ -332,6 +332,7 @@
 
     tls_crypt_v2_load_client_key(key, &key=
2, false);
     *original_key =3D key2;
+    secure_memzero(&key2, sizeof(k=
ey2));
 
     *wkc_buf =3D client_key;
 }
@@ -794,6 +795,7 @@
     tls_cryp=
t_v2_init_client_key(&check_client_key, &keydata, &check_wrapped_client_key=
, client_file,
                                  client_inline);
     free_=
key_ctx_bi(&check_client_key);
+    secure_memzero(&keydata, sizeof(keydata=
));
 
     /* Sanity check: unwrap and load client key (as "server") */
   =
  struct buffer check_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_L=
EN, &gc);
@@ -804,6 +806,7 @@
     ASSERT(tls_crypt_v2_unwrap_client_key(&c=
heck_client_key2, &check_metadata,
                                        =
   check_wrapped_client_key, &server_key));
     secure_memzero(&check_clie=
nt_key2, sizeof(check_client_key2));
+    buf_clear(&check_wrapped_client_k=
ey);
     free_buf(&check_wrapped_client_key);
 
 cleanup:

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907=
557c0
Gerrit-Change-Number: 2079
Gerrit-PatchSet: 2
Gerrit-Owner: Hansaem W=
i <hansaemw@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--cV6fiiZ+HZU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2079?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">tls_crypt: Wipe the tls-crypt-v2 c=
lient key copies<br><br>tls_crypt_v2_init_client_key() reads the client key=
 into a struct key2<br>on the stack, copies it to *original_key and returns=
 without clearing<br>it, so every client start leaves the tls-crypt-v2 clie=
nt key on the<br>stack=2E crypto_read_openvpn_key() does the same copy for =
tls-auth and<br>tls-crypt keys and clears its struct key2 afterwards; do th=
e same here=2E<br><br>The --genkey tls-crypt-v2-client sanity check in<br>t=
ls_crypt_v2_write_client_key_file() has two more copies:<br>- keydata, the =
struct key2 that tls_crypt_v2_init_client_key() fills;<br>  clear it after =
use=2E<br>- check_wrapped_client_key, the decoded key file buffer: the clie=
nt key<br>  is still in front of the wrapped key when it is freed=2E Clear =
it with<br>  buf_clear() before free_buf(), as do_close_free_key_schedule()=
 does<br>  for the client&#39;s tls_crypt_v2_wkc=2E<br><br>Assisted-by: Cla=
ude Code:claude-opus-5-5<br>Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907=
557c0<br>Signed-off-by: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt;<br>Acked-by=
: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2079<br>Message-Id: &lt;20261102101437=2E1209-=
1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/open=
vpn-devel@lists=2Esourceforge=2Enet/msg40954=2Ehtml<br>Signed-off-by: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/tls_crypt=
=2Ec<br>1 file changed, 3 insertions(+), 0 deletions(-)<br><br></pre>
<pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</span><br>=
<span>index 64db29f=2E=2Ed7f69f7 100644</span><br><span>--- a/src/openvpn/t=
ls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span><br><spa=
n>@@ -332,6 +332,7 @@</span><br><span> </span><br><span>     tls_crypt_v2_l=
oad_client_key(key, &amp;key2, false);</span><br><span>     *original_key =
=3D key2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure=
_memzero(&amp;key2, sizeof(key2));</span><br><span> </span><br><span>     *=
wkc_buf =3D client_key;</span><br><span> }</span><br><span>@@ -794,6 +795,7=
 @@</span><br><span>     tls_crypt_v2_init_client_key(&amp;check_client_key=
, &amp;keydata, &amp;check_wrapped_client_key, client_file,</span><br><span=
>                                  client_inline);</span><br><span>     fre=
e_key_ctx_bi(&amp;check_client_key);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    secure_memzero(&amp;keydata, sizeof(keydata));</span><=
br><span> </span><br><span>     /* Sanity check: unwrap and load client key=
 (as &quot;server&quot;) */</span><br><span>     struct buffer check_metada=
ta =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &amp;gc);</span><br><spa=
n>@@ -804,6 +806,7 @@</span><br><span>     ASSERT(tls_crypt_v2_unwrap_clien=
t_key(&amp;check_client_key2, &amp;check_metadata,</span><br><span>        =
                                   check_wrapped_client_key, &amp;server_ke=
y));</span><br><span>     secure_memzero(&amp;check_client_key2, sizeof(che=
ck_client_key2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  buf_clear(&amp;check_wrapped_client_key);</span><br><span>     free_buf(&=
amp;check_wrapped_client_key);</span><br><span> </span><br><span> cleanup:<=
/span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2079?usp=3Demail">change 2079</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2079?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvp=
n </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907=
557c0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2079 </div>=

<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"displ=
ay:none"> Gerrit-Owner: Hansaem Wi &lt;hansaemw@gmail=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan=
 Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>

</body></html>
--cV6fiiZ+HZU=--


--===============0822636654171920252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0822636654171920252==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0822636654171920252==--

