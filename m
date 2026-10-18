Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FFBCCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Nwt9FOVnLS6Li+f04QxTM/grkCMQaDflbXPk1pXS6I=; b=NGzobC9b2KSMDgiMYjlVp9gYTX
	KnnP3GiLHnc96W/zr6/yasva3sHUEPYe6axJa+3kpWpwGuw4JsIavbpxLKyyGEJ28XIACjnSstRqH
	ZchDFK/s0mvdiSFEEcC72Lh6iYYIiGMaeHGv0+MzgkoFqUsVlcd3mKSQUOLMjH9zdr5A=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIRDK-0008N4-Ud;
	Sun, 18 Oct 2026 13:46:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIRDI-0008Mt-NA
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5aHsYHqwxfisTuwtKDZMK+7IXzr3CgWfUMQMEEaFaPg=; b=e60h2tjFQ7650jLpU0eiQg6mof
 wgymQOaVD4F2C78TkulPwOArtpgzTrvKc/6R9veKMK5vZTwgc8935bgAUNqAMMuVDIidw9DTdG0at
 vtNQ9a0npGMNyZDsOKu7GUVaWD0gJgx44sfIq8QweRWxXt5P7FQddHvrQKdryFf4mA7s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5aHsYHqwxfisTuwtKDZMK+7IXzr3CgWfUMQMEEaFaPg=; b=B
 ROrDBo+W+cp6gowfjOYGdeKtQQcG42zpahhZlV4XIxy1MRW1XeXJOA+EJuHuL4dnOBi6JazFm9DoT
 ia+gmlO4LnuBfJbciZcEM1Xn0bcYBe2zgTMzG67+A4vYmv/Nao1O6sWtjW+zoMIxKJnQGTtDNcodI
 OnPW6sIdcvudHOuE=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIRDE-0007FJ-HI for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:46:10 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1d75f2f11so8563055e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792331162; x=1792935962; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5aHsYHqwxfisTuwtKDZMK+7IXzr3CgWfUMQMEEaFaPg=;
 b=TLUxl4OBhGRSF+1ieaxtO1e0sE/sZWDsv6ly7NRJ6JaBRIQqhrRIU4SUwyprlHZ0gL
 b7lurpesQWWrbV7qfc3uISQiozHiNUHjNRJ88W2zQh2Lk+8j5XWM8Vb+YFfo1RrGAFzA
 0AepEAelPP4RSHYfQ77COMwls3OEy56as31P+bgbJGgfQgBnWP7uSw4mHNKz9fAMn+gG
 D6UIo2ZrVsUIcsWN2iDqOU4chemLqJFbsIUmLcJlAn1meUeHc5HsxHTcRZTpPAnPflhW
 ciwNKa1tZsLVkKtZIC9Q3vx4M6gsxxl+WOrdyWA0WsoU4Uh56SmLusyOWFQNsZCkhvfB
 NYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792331162; x=1792935962;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5aHsYHqwxfisTuwtKDZMK+7IXzr3CgWfUMQMEEaFaPg=;
 b=mYB8J0wd8yp9mqCHxxeTMpWTxkd0b72cLBSYy8Xm7xCBjKSN5ikPDkI00wWfl5MD7r
 5ewS1+BDailcuS7bBJeDuWsiGBYIElIDem+KyzPxyVt9Z4KwRudz9rVeUMH/VGlPMTC4
 4DcBW434z16TDsDvDKfV8JEr4L4UNmGn++cEe9Zh8uh3vGTn4E/6ba7YZU0Ac48R7Bs9
 MwCpQvwwhj/MA2kmcuCPz/oFBMBEx7gxVapPsrkujpzujvi89oAdjrl1RNGfQy1viGQH
 Xk5dx5oQl5uIOuOVnxAnaJMxcM7JwDeKlq6Jo+Rm/79skfMUhtozaLZayOoyXzKuUx6k
 uhew==
X-Gm-Message-State: AFq9FYJSBjiztupnbFu+PIszAiPG1AZuUV62Cw8BAYhqoL+aq15Rdt5U
 QJC6fRlmX3J5dmDITumZa+2z8nXCB6jNejeolw+FR64PX/U3yG+w5sh1+75HGH7c7zuEkOSpF8U
 sScn+QGz6DIe39x9R4w2tGZ/MJrwSw8jZRYHCL5mwWy03SLNsOTBuLWAM/FRhAMmI86yw
X-Gm-Gg: AYBFou3WFRtVww0sHmWr3JxDNmorEoFTx6IfVKzPefhZMhB9LZfKuwV/QWMpCZbM7N7
 GXC5eTyQqb0icQCTmYIYnQKB9UgvY1l/+4Rd5WG1gfELpDYXAI+nGia+0XQgCd5el2O3sOjkfy7
 P+O81Ymh6XXDnqNtETmJ8zWl/S7qzRnlDDJkpCMkR15uILyO57B2ERMW55xymuQApC55P6Xkydp
 c14jSA/+5Dx/BbJxEUC7Sy9FkrwSzk2wT7gQpJwpOsSr1wVbTf/lj5PP4RfdVMKQ2Csej5IWS2L
 awPE954Xn/yBe6xZl8Pzrnd+16fPpnusVA0Etj8RIxOsA+YM4FqC4rkOmZN7lqWZKDzncj0nON1
 yg6hmkFxO8NliVAZDlydS3pfrqmbdZzam6kieh7OiOCBVcZOp44sulMLnaUTKiI1784wUimGKsp
 A5TpLg1dhewhb0ZSxN95r4hi2egP4Hx1qBFVd8GTcAUUjnVfqKZ4g85WjXoJ2pv0o2n8BFCTiX3
 mn/9Wb/eYlGt2ZqLxC0o7cIJf+IkXaO8M8/BDYwPNHMOm8UVxqURxx8G232eQQru64EgS4EKBFk
 sfDn3ZALfHK5hhuBHWc+PX0MeB1a+COicYEayIELrE8w/SevK1YHJDs+XLNI
X-Received: by 2002:a05:600c:1c0f:b0:4a1:e489:f89f with SMTP id
 5b1f17b1804b1-4a1e489fa4bmr32369545e9.14.1792331161651; 
 Sun, 18 Oct 2026 06:46:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ecac3sm18839679f8f.27.2026.10.18.06.46.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 06:46:01 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 13:46:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
X-Gerrit-Change-Number: 1941
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1941?usp=email>
X-Gerrit-Commit: 43aee864957280d3fd060d477f90cb977708ddf9
In-Reply-To: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
References: <gerrit.1790072398000.Iecffd01567376960c9393770ffe05665073b067a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDcyMzk4MDAwLkllY2ZmZDAxNTY3Mzc2OTYwYzkzOTM3NzBmZmUwNTY2NTA3M2IwNjdhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b326a3b8e4a102fc8357feeca0d0bbf9703960ec-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIRDE-0007FJ-HI
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add
 --debug-aead-usage-limit-override option
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============9007963681093168806=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9007963681093168806==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6RITt4WBK60="; charset=UTF-8

--6RITt4WBK60=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1941?usp=3Demail )

Change subject: Add --debug-aead-usage-limi=
t-override option
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Add --debug-aead-usage-limit-override option

Normal users should not =
touch this option since there is normally
no reason to mess with the number=
 of safely encrypted packets=2E

However, during to check if the epoch key =
rollover works as expected
it is helpful to trigger this mechanism early=2E=
 Since constantly
patching OpenVPN to do this in tests is messy, introduce =
an undocumented
option to allow enabling this behaviour=2E

Change-Id: Iecf=
fd01567376960c9393770ffe05665073b067a
Signed-off-by: Arne Schwabe <arne@rfc=
2549=2Eorg>
Acked-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941
Message-Id: <20261017163=
328=2E12832-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg39949=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/init=2Ec
M src/openv=
pn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/ssl=2Ec
M src/openvp=
n/ssl_common=2Eh
5 files changed, 36 insertions(+), 3 deletions(-)




diff=
 --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index d8fd844=2E=2Eddc=
faf4 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -3286,=
6 +3286,7 @@
     to=2Epacket_timeout =3D options->tls_timeout;
     to=2Er=
enegotiate_bytes =3D options->renegotiate_bytes;
     to=2Erenegotiate_pack=
ets =3D options->renegotiate_packets;
+    to=2Eaead_usage_limit_override =
=3D options->aead_usage_limit_override;
     if (options->renegotiate_secon=
ds_min < 0)
     {
         /* Add 10% jitter to reneg-sec by default (serv=
er side only) */
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=
=2Ec
index 7fc8614=2E=2E1630731 100644
--- a/src/openvpn/options=2Ec
+++ b/=
src/openvpn/options=2Ec
@@ -7609,6 +7609,20 @@
             options->renego=
tiate_seconds_min =3D positive_atoi(p[2], msglevel);
         }
     }
+#if=
def ENABLE_DEBUG
+    else if (streq(p[0], "debug-aead-usage-limit-override=
"))
+    {
+        /* This option is undocumented since it should not be u=
sed by normal
+         * users */
+        VERIFY_PERMISSION(OPT_P_TLS_PAR=
MS);
+        if (!positive_atoll(p[1], &options->aead_usage_limit_override=
, p[0], msglevel))
+        {
+            msg(M_VERB0, "Warning: --debug-a=
ead-usage-limit-override should "
+                         "only be used b=
y developers and in specific tests=2E");
+            goto err;
+        }
=
+    }
+#endif
     else if (streq(p[0], "hand-window") && p[1] && !p[2])
 =
    {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
diff --git a/src/openvpn=
/options=2Eh b/src/openvpn/options=2Eh
index d347830=2E=2E693d9cf 100644
--=
- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -647,6 +647,9 =
@@
     int renegotiate_seconds;
     int renegotiate_seconds_min;
 
+    /=
** Debug override to trigger AEAD usage limit early */
+    int64_t aead_us=
age_limit_override;
+
     /* Data channel key handshake must finalize
    =
  * within n seconds of handshake initiation=2E */
     int handshake_windo=
w;
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 49a9cb6=2E=
=2E086a6fc 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1=
26,11 +126,11 @@
 }
 
 static uint64_t
-tls_get_limit_aead(const char *ciph=
ername)
+tls_get_limit_aead(const char *ciphername, uint64_t override)
 {
 =
    uint64_t limit =3D cipher_get_aead_limits(ciphername);
 
-    if (limit=
 =3D=3D 0)
+    if (limit =3D=3D 0 && override =3D=3D 0)
     {
         re=
turn 0;
     }
@@ -139,6 +139,11 @@
      * we go over the limit */
     li=
mit =3D limit / 8 * 7;
 
+    if (override > 0)
+    {
+        limit =3D o=
verride;
+    }
+
     msg(D_SHOW_KEYS,
         "Note: AEAD cipher %s will=
 trigger a renegotiation"
         " at a sum of %" PRIi64 " blocks and pac=
kets=2E",
@@ -1397,6 +1402,11 @@
      * */
     epoch_init_key_ctx(co, key=
_type, &e1_send, &e1_recv, future_key_count);
 
+    if (multi->opt=2Eaead_=
usage_limit_override)
+    {
+        co->aead_usage_limit =3D multi->opt=
=2Eaead_usage_limit_override;
+    }
+
     secure_memzero(&e1_send, sizeof=
(e1_send));
     secure_memzero(&e1_recv, sizeof(e1_recv));
 }
@@ -1619,7 +=
1629,7 @@
     }
     tls_limit_reneg_bytes(session->opt->key_type=2Ecipher=
, &session->opt->renegotiate_bytes);
 
-    session->opt->aead_usage_limit =
=3D tls_get_limit_aead(session->opt->key_type=2Ecipher);
+    session->opt-=
>aead_usage_limit =3D tls_get_limit_aead(session->opt->key_type=2Ecipher, s=
ession->opt->aead_usage_limit_override);
 
     /* set the state of the key=
s for the session to generated */
     ks->state =3D S_GENERATED_KEYS;
diff=
 --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index f639=
2f9=2E=2E579f46c 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/=
ssl_common=2Eh
@@ -346,6 +346,11 @@
     /** limit for AEAD cipher when not=
 running in epoch data key mode,
      *  this is the sum of packets + bloc=
ks that are allowed to be used */
     uint64_t aead_usage_limit;
+    /**
=
+     * Debug only option that allows overriding the usage limit
+     * Th=
is allows testing key rotation by using very small limits
+     */
+    uin=
t64_t aead_usage_limit_override;
     interval_t renegotiate_seconds;
 
   =
  /* cert verification parms */

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1941?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: Iecffd01567376960c9393770ffe05665073b067a
Gerrit-Change-Number:=
 1941
Gerrit-PatchSet: 6
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--6RITt4WBK60=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1941?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Add --debug-aead-usage-limit-overr=
ide option<br><br>Normal users should not touch this option since there is =
normally<br>no reason to mess with the number of safely encrypted packets=
=2E<br><br>However, during to check if the epoch key rollover works as expe=
cted<br>it is helpful to trigger this mechanism early=2E Since constantly<b=
r>patching OpenVPN to do this in tests is messy, introduce an undocumented<=
br>option to allow enabling this behaviour=2E<br><br>Change-Id: Iecffd01567=
376960c9393770ffe05665073b067a<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2=
549=2Eorg&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941<br>Message=
-Id: &lt;20261017163328=2E12832-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https=
://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg3994=
9=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>=
---<br>M src/openvpn/init=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn=
/options=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>5 =
files changed, 36 insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index d8fd84=
4=2E=2Eddcfaf4 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br>=
<span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -3286,6 +3286,7 @@</spa=
n><br><span>     to=2Epacket_timeout =3D options-&gt;tls_timeout;</span><br=
><span>     to=2Erenegotiate_bytes =3D options-&gt;renegotiate_bytes;</span=
><br><span>     to=2Erenegotiate_packets =3D options-&gt;renegotiate_packet=
s;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    to=2Eaead_usa=
ge_limit_override =3D options-&gt;aead_usage_limit_override;</span><br><spa=
n>     if (options-&gt;renegotiate_seconds_min &lt; 0)</span><br><span>    =
 {</span><br><span>         /* Add 10% jitter to reneg-sec by default (serv=
er side only) */</span><br><span>diff --git a/src/openvpn/options=2Ec b/src=
/openvpn/options=2Ec</span><br><span>index 7fc8614=2E=2E1630731 100644</spa=
n><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn=
/options=2Ec</span><br><span>@@ -7609,6 +7609,20 @@</span><br><span>       =
      options-&gt;renegotiate_seconds_min =3D positive_atoi(p[2], msglevel)=
;</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_DEBUG</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;debug-aead=
-usage-limit-override&quot;))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* This option is undocumented since it should not be used by normal</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+         * users */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISS=
ION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!positive_atoll(p[1], &amp;options-&gt;aead_usage_limit_overr=
ide, p[0], msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(M_VERB0, &quot;Warning: --debug-aead-usage-limit-override should &q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
          &quot;only be used by developers and in specific tests=2E&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     else if (stre=
q(p[0], &quot;hand-window&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><b=
r><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);=
</span><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=
=2Eh</span><br><span>index d347830=2E=2E693d9cf 100644</span><br><span>--- =
a/src/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</sp=
an><br><span>@@ -647,6 +647,9 @@</span><br><span>     int renegotiate_secon=
ds;</span><br><span>     int renegotiate_seconds_min;</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Debug override =
to trigger AEAD usage limit early */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int64_t aead_usage_limit_override;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Data channel k=
ey handshake must finalize</span><br><span>      * within n seconds of hand=
shake initiation=2E */</span><br><span>     int handshake_window;</span><br=
><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><sp=
an>index 49a9cb6=2E=2E086a6fc 100644</span><br><span>--- a/src/openvpn/ssl=
=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -126,11 +=
126,11 @@</span><br><span> }</span><br><span> </span><br><span> static uint=
64_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_get_limit_aea=
d(const char *ciphername)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+tls_get_limit_aead(const char *ciphername, uint64_t override)</span><=
br><span> {</span><br><span>     uint64_t limit =3D cipher_get_aead_limits(=
ciphername);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (limit =3D=3D 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (limit =3D=3D 0 &amp;&amp; override =3D=3D 0)</span><br=
><span>     {</span><br><span>         return 0;</span><br><span>     }</sp=
an><br><span>@@ -139,6 +139,11 @@</span><br><span>      * we go over the li=
mit */</span><br><span>     limit =3D limit / 8 * 7;</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (override &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        limit =3D override;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     msg(D_SHOW_KEYS,<=
/span><br><span>         &quot;Note: AEAD cipher %s will trigger a renegoti=
ation&quot;</span><br><span>         &quot; at a sum of %&quot; PRIi64 &quo=
t; blocks and packets=2E&quot;,</span><br><span>@@ -1397,6 +1402,11 @@</spa=
n><br><span>      * */</span><br><span>     epoch_init_key_ctx(co, key_type=
, &amp;e1_send, &amp;e1_recv, future_key_count);</span><br><span> </span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;opt=2Eaead=
_usage_limit_override)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co-=
&gt;aead_usage_limit =3D multi-&gt;opt=2Eaead_usage_limit_override;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     secure_memzero(&amp=
;e1_send, sizeof(e1_send));</span><br><span>     secure_memzero(&amp;e1_rec=
v, sizeof(e1_recv));</span><br><span> }</span><br><span>@@ -1619,7 +1629,7 =
@@</span><br><span>     }</span><br><span>     tls_limit_reneg_bytes(sessio=
n-&gt;opt-&gt;key_type=2Ecipher, &amp;session-&gt;opt-&gt;renegotiate_bytes=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   session-&gt;opt-&gt;aead_usage_limit =3D tls_get_limit_aead(session-&gt;=
opt-&gt;key_type=2Ecipher);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    session-&gt;opt-&gt;aead_usage_limit =3D tls_get_limit_aead(ses=
sion-&gt;opt-&gt;key_type=2Ecipher, session-&gt;opt-&gt;aead_usage_limit_ov=
erride);</span><br><span> </span><br><span>     /* set the state of the key=
s for the session to generated */</span><br><span>     ks-&gt;state =3D S_G=
ENERATED_KEYS;</span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/sr=
c/openvpn/ssl_common=2Eh</span><br><span>index f6392f9=2E=2E579f46c 100644<=
/span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/=
openvpn/ssl_common=2Eh</span><br><span>@@ -346,6 +346,11 @@</span><br><span=
>     /** limit for AEAD cipher when not running in epoch data key mode,</s=
pan><br><span>      *  this is the sum of packets + blocks that are allowed=
 to be used */</span><br><span>     uint64_t aead_usage_limit;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * Debug only option that allows overrid=
ing the usage limit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * This allows testing key rotation by using very small limits</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint64_t aead_usage_limit_override;<=
/span><br><span>     interval_t renegotiate_seconds;</span><br><span> </spa=
n><br><span>     /* cert verification parms */</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1941?usp=3Demai=
l">change 1941</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1941?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: Iecffd01567376960c9393770ffe05665073b067a </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1941 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@=
lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--6RITt4WBK60=--


--===============9007963681093168806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9007963681093168806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9007963681093168806==--

