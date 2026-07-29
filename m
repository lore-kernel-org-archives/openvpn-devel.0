Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05914C53200
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vMyN3ugwfAl7J/9BdjLaneqoV0zwF2ssAPHn1iTP4TI=; b=MJsbnyDV/UXibJTk+jpZUO6dmW
	BMebuYwqPHy1yU52xFblNnWnNmOD0tQg4CpYozHbvycGZ1hKaUPEiKex7/o6MGBp5+b+ELbgU5oHh
	Weas4j2gNP+c8vlxWCosvkA++z64xhbIdQoNjoA93WbyvsDOmVvMfLpxo99FTXSRVk9c=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp3KX-0003d7-Gd;
	Wed, 29 Jul 2026 12:24:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp3Jv-0003Zy-Vi
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3QbYXCPAJyUX6pOr1mrdOxh233U9xmCx9jC6D0E1cDM=; b=D7ilqE7M0g06oLfHuct/L9tH7A
 LsFBLqAJsNsKwN01lgiGp3wv2QSKoha5W5iuZDXcOfGO9w7tCXpgrFszWtUazN9q7YGEx0SfivvE3
 rgZDih6Nzg4/QBiElRRu4GDEd6QDaCoWV5UzJV/a3wZQT2GsHzWNNgwzpCl493Ex5X1Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3QbYXCPAJyUX6pOr1mrdOxh233U9xmCx9jC6D0E1cDM=; b=a
 fBzq3PFYyrEm8ASeiWn8zkW/xKXQfj8TMKjhwSTaL0/2099jDwJ79EGK3zYQBn4vzGOKNz1ap1iYC
 rpHJLJn3VPaJIPMuHakRyXS39NhGudpNwNhtBbH0+A33Aqvb3rEXUL8hGSivK47U4KiH+tj6Etkiy
 iDU/IQX8Gu75rpFg=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp3Js-0006OZ-4e for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 12:23:33 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-495590dde14so9174245e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 05:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785327805; x=1785932605; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3QbYXCPAJyUX6pOr1mrdOxh233U9xmCx9jC6D0E1cDM=;
 b=Y9eomzVofsz4kdLQW+HnxTdPkencb+BDMNkBt+3Px085jhy9+qrEkVPDB3pzhkF/iM
 tv80LeE+iXAPdfeAHuEzIMT5rtvDTiYmpL5PtX1JHbJzNUv+JUanvqNS8yqOzunDR8B1
 I6Yc3pNNWurEcKm63BmH7DOyUQYn92Yo1VCaam8S/QP5V/PQJeRn3st8hQObIxgIijQM
 fVni5EkBHmMV+8Wo2Eub4u73OO3l6FWz6+zHYEwvYcEA0m052rZN4vWaHpS8AadN47DM
 /iUCg8Y+/gG38gOKD5S/CxEfM+fw+SJxNgSb8D4hiPK5yZFyNdODcl0NLpSGLZshSMu9
 wODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785327805; x=1785932605;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3QbYXCPAJyUX6pOr1mrdOxh233U9xmCx9jC6D0E1cDM=;
 b=Rn3gpI/hWhNjogduJcoIkK1YnRM3BRCV+xHUlIwoFMA/OfeXfKut5yX5WVwZmIqZTA
 kA2GIjbvDAqwKGER+8ePyC1d+EjSXXSwcAaLdSP0HecbxoUDVCOhPepb7cQe1rVH3EE8
 e62U4lWIV/nBwcP2PCJjgkSgWgWr/27Hozk5NPeresUdqIBKsgK2QuB/DHnIfv37UvLs
 BUR6WApXhUJCaO80trfT7aXoXJlCE/zHINBYxluHgw9dCG4f3y3sn2R1rEDwICVDoMO8
 W+9yqwbYcRO8Dd3PJWo9cFOMmyl5SX4ctM+iCF2Kw1SWVlzwQWsGUHpnP9g9ZPuCmKW6
 SphA==
X-Gm-Message-State: AOJu0YwPsHymHgYyMgKlkwKVUxL+9zOWxidWbyanMvVLeKA3QqoaXQZD
 GLhOoFN255KHR7jC/1Vxf4TplWP6WzrXieUppyVKn54zO1V2xL9+IvakLVJii0sYzQ+eMKCnIUl
 SP9JAIixMVUpOZwrT5/5L9Ycm4n9HK24QykwXtlnie4kz0qOD+fAAIPupn0lOFey3kgKy
X-Gm-Gg: AR+sD13gUtKtvYkhOCVJlJ2PYmp4WripvMPwuX0HefUUY+ygrugJWE0r1aCqSS8WBW0
 3afjob0w3dzKrI+Gs3ESfV23FJNCYv7wh94d0uB0XZ4F1MADyggGFTwxkiisH3n3QsqottYPCjU
 Yt6w8xI5vzH9FiWA2DTsUGsCECqH5glINhVCl25iHj6ezQAcafn8/6FaNq77Zqg31Ja7GdK87HN
 vnayCUsjVHZtJf0KsJd55oNEEPtMUK2G52xI5SCFB6raluEBoYU+Y6PVezs01y9IR2YdhrFyCJE
 PiU9yE8WaeBZM7nThsOctwdN77ojEDMc1xwtUcespV8Nh92oDIgQXTBGjTtrTYPMb4G4qNWVUTZ
 Qjoatn0yH2a5FvKA0hLcIIiTRn+M6Ec4B4b+O2xazSxfoAyWFgSIbRT5+Uun6AT5yQMuu0xMQ+k
 WRI+EfkcedP9v9TbxVzDVgVudfSi9PgTX/eFrTzArI5uS0XdgTUDqGsmmT2z0dY62cviD7gqGjM
 onq+JPbMSiQTiinYDNcaxDRzPPUyb2wiIocasVq8zvRV1xvEo/bLq6bXO1f4doCnEMMOSykp6Jn
 ToOO/yusDmvN77/9h/RpYoD712Heyd+iGOx1ys97fyqhVmlRXzs=
X-Received: by 2002:a05:600c:c8f:b0:495:6b55:f938 with SMTP id
 5b1f17b1804b1-496c642200emr71801675e9.10.1785327805317; 
 Wed, 29 Jul 2026 05:23:25 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44afaecsm170890685e9.2.2026.07.29.05.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:23:24 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 12:22:54 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
X-Gerrit-Change-Number: 1759
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1759?usp=email>
X-Gerrit-Commit: bc96f8da5ebb9906aa1e6399d80e0b200ec2ab09
In-Reply-To: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
References: <gerrit.1782820043000.I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLkk1Y2MxMDBkZDdkYzgxMGQ3ZDFlNmYyOWJiNTc1ODQ5MDVmYmNmNGEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bfaee867d0eb1ae6d3c5255381572f28d30fbe1b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp3Js-0006OZ-4e
Subject: [Openvpn-devel] [S] Change in openvpn[master]: oob: Send
 tls-crypt-v2 SERVER_PROBE from the client
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2185467459260430791=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2185467459260430791==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Zs0Dez3sOvk="; charset=UTF-8

--Zs0Dez3sOvk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos, 

I'd =
like you to reexamine a change=2E Please visit

    http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1759?usp=3Demail

to look at the new patch set (#12)=2E
=


Change subject: oob: Send tls-crypt-v2 SERVER_PROBE from the client
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Send tls-cr=
ypt-v2 SERVER_PROBE from the client

When tls-crypt-v2 is configured, send =
the probe as P_CONTROL_OOB_WKC_V1
with the wrapped client key (WKc) appende=
d, so the server can recover the
per-client key and unwrap it=2E Without tl=
s-crypt-v2 the probe stays a plain
P_CONTROL_OOB_V1, unchanged=2E

  - drop=
 the "skip probing under tls-crypt-v2" bail-out
  - make the WKc available =
on the probe's wrap context (mirroring
    init_instance()), so tls_wrap_co=
ntrol() appends it
  - choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL=
_OOB_V1) and report
    "tls-crypt-v2" in the wrapping log line

Change-Id:=
 I5cc100dd7dc810d7d1e6f29bb57584905fbcf4a0
Signed-off-by: Lev Stipakov <lev=
@openvpn=2Enet>
---
M doc/man-sections/client-options=2Erst
M src/openvpn/o=
ob_client=2Ec
2 files changed, 26 insertions(+), 20 deletions(-)


  git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/59/1759/12

diff=
 --git a/doc/man-sections/client-options=2Erst b/doc/man-sections/client-op=
tions=2Erst
index 541743f=2E=2E8a31a06 100644
--- a/doc/man-sections/client=
-options=2Erst
+++ b/doc/man-sections/client-options=2Erst
@@ -617,9 +617,8=
 @@
   :code:`10` ms=2E
 
   The probe carries the same control-channel wra=
pping as a normal
-  connection (``--tls-auth`` or ``--tls-crypt``, when co=
nfigured)=2E With
-  ``--tls-crypt-v2`` the remotes are left in their confi=
gured order,
-  because the server cannot unwrap an out-of-band probe yet=
=2E
+  connection (``--tls-auth``, ``--tls-crypt`` or ``--tls-crypt-v2``,
+=
  when configured)=2E
 
   Only UDP remotes are probed; TCP remotes keep th=
eir configured
   position=2E Probing runs once, before the first connectio=
n attempt=2E
diff --git a/src/openvpn/oob_client=2Ec b/src/openvpn/oob_clie=
nt=2Ec
index 1fafbd3=2E=2Ed53e376 100644
--- a/src/openvpn/oob_client=2Ec
+=
++ b/src/openvpn/oob_client=2Ec
@@ -105,19 +105,9 @@
      * supported; the=
 first entry's wrapping is used for all=2E) */
     const struct connection=
_entry *ce =3D c->options=2Econnection_list->array[0];
 
-    /* tls-crypt-=
v2 wraps with a per-client key the server only learns from the
-     * wrap=
ped client key (WKc) carried in the TLS handshake=2E An out-of-band
-     *=
 probe carries no WKc, so the server cannot unwrap it; skip probing rather
=
-     * than send something unverifiable=2E */
-    if (ce->tls_crypt_v2_fi=
le)
-    {
-        msg(D_LOW, "server-probe: not supported with tls-crypt-=
v2; using configured order");
-        return NULL;
-    }
-
-    /* Load t=
he tls-auth/tls-crypt key material into c->c1=2Eks (a no-op if neither
-   =
  * is configured)=2E This is run again per-connection later; calling it ea=
rly
-     * here is harmless=2E */
+    /* Load the tls-auth/tls-crypt(-v2)=
 key material into c->c1=2Eks (a no-op if
+     * none is configured)=2E Th=
is is run again per-connection later; calling it
+     * early here is harm=
less=2E */
     do_init_tls_wrap_key(c, ce);
 
     struct tls_options to;
=
@@ -126,6 +116,15 @@
     to=2Ereplay_window =3D c->options=2Ereplay_window=
;
     to=2Ereplay_time =3D c->options=2Ereplay_time;
 
+    /* tls-crypt-v=
2 wraps with a per-client key the server learns from the
+     * wrapped cl=
ient key (WKc)=2E init_tls_wrap_ctx() loaded the per-client key
+     * int=
o the wrap context; make the WKc available too so the probe can append
+   =
  * it (as a P_CONTROL_OOB_WKC_V1 message), mirroring init_instance()=2E */=

+    if (ce->tls_crypt_v2_file)
+    {
+        to=2Etls_wrap=2Etls_crypt_=
v2_wkc =3D &c->c1=2Eks=2Etls_crypt_v2_wkc;
+    }
+
     struct tls_auth_st=
andalone *tas =3D tls_auth_standalone_init(&to, gc);
 
     /* Control-chan=
nel frame and work buffers, mirroring do_init_frame_tls()=2E */
@@ -493,8 +=
492,15 @@
         return;
     }
 
+    /* With tls-crypt-v2 the probe mus=
t carry the wrapped client key so the
+     * server can recover the per-cl=
ient key; that is a P_CONTROL_OOB_WKC_V1
+     * message=2E Otherwise (tls-=
crypt v1, tls-auth, or plaintext) it is a plain
+     * P_CONTROL_OOB_V1=2E=
 */
+    const bool is_v2 =3D (tas->tls_wrap=2Etls_crypt_v2_wkc !=3D NULL);=

+    const int probe_opcode =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_CONTROL_O=
OB_V1;
+
     struct buffer probe =3D
-        tls_wrap_oob_standalone(&tas=
->tls_wrap, tas, &client_sid, &payload, P_CONTROL_OOB_V1);
+        tls_wra=
p_oob_standalone(&tas->tls_wrap, tas, &client_sid, &payload, probe_opcode);=

     if (!BLEN(&probe))
     {
         msg(D_LOW, "server-probe: could no=
t wrap probe packet; using configured order");
@@ -504,9 +510,10 @@
       =
  return;
     }
 
-    const char *wrap_name =3D (tas->tls_wrap=2Emode =3D=
=3D TLS_WRAP_CRYPT)  ? "tls-crypt"
-                            : (tas->tls=
_wrap=2Emode =3D=3D TLS_WRAP_AUTH) ? "tls-auth"
-                          =
                                          : "none (plaintext)";
+    const =
char *wrap_name =3D is_v2                                    ? "tls-crypt-v=
2"
+                            : (tas->tls_wrap=2Emode =3D=3D TLS_WRAP_CRY=
PT) ? "tls-crypt"
+                            : (tas->tls_wrap=2Emode =3D=
=3D TLS_WRAP_AUTH)  ? "tls-auth"
+                                         =
                            : "none (plaintext)";
     msg(D_LOW, "server-p=
robe: probing %d remote(s) with a %d ms window, control-channel wrapping: %=
s",
         l->len, OOB_PROBE_WINDOW_MS, wrap_name);
 

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1759?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fb=
cf4a0
Gerrit-Change-Number: 1759
Gerrit-PatchSet: 12
Gerrit-Owner: stipa <l=
stipakov@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--Zs0Dez3sOvk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa <strong>uploaded patch set=
 #12</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1759?usp=3Demail">View Change</a></p><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">oob: Sen=
d tls-crypt-v2 SERVER_PROBE from the client<br><br>When tls-crypt-v2 is con=
figured, send the probe as P_CONTROL_OOB_WKC_V1<br>with the wrapped client =
key (WKc) appended, so the server can recover the<br>per-client key and unw=
rap it=2E Without tls-crypt-v2 the probe stays a plain<br>P_CONTROL_OOB_V1,=
 unchanged=2E<br><br>  - drop the &quot;skip probing under tls-crypt-v2&quo=
t; bail-out<br>  - make the WKc available on the probe&#39;s wrap context (=
mirroring<br>    init_instance()), so tls_wrap_control() appends it<br>  - =
choose the opcode (P_CONTROL_OOB_WKC_V1 vs P_CONTROL_OOB_V1) and report<br>=
    &quot;tls-crypt-v2&quot; in the wrapping log line<br><br>Change-Id: I5c=
c100dd7dc810d7d1e6f29bb57584905fbcf4a0<br>Signed-off-by: Lev Stipakov &lt;l=
ev@openvpn=2Enet&gt;<br>---<br>M doc/man-sections/client-options=2Erst<br>M=
 src/openvpn/oob_client=2Ec<br>2 files changed, 26 insertions(+), 20 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/59/1759/12</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/cl=
ient-options=2Erst b/doc/man-sections/client-options=2Erst</span><br><span>=
index 541743f=2E=2E8a31a06 100644</span><br><span>--- a/doc/man-sections/cl=
ient-options=2Erst</span><br><span>+++ b/doc/man-sections/client-options=2E=
rst</span><br><span>@@ -617,9 +617,8 @@</span><br><span>   :code:`10` ms=2E=
</span><br><span> </span><br><span>   The probe carries the same control-ch=
annel wrapping as a normal</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-  connection (``--tls-auth`` or ``--tls-crypt``, when configured)=2E W=
ith</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``--tls-crypt-v2=
`` the remotes are left in their configured order,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  because the server cannot unwrap an out-of-b=
and probe yet=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  c=
onnection (``--tls-auth``, ``--tls-crypt`` or ``--tls-crypt-v2``,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  when configured)=2E</span><=
br><span> </span><br><span>   Only UDP remotes are probed; TCP remotes keep=
 their configured</span><br><span>   position=2E Probing runs once, before =
the first connection attempt=2E</span><br><span>diff --git a/src/openvpn/oo=
b_client=2Ec b/src/openvpn/oob_client=2Ec</span><br><span>index 1fafbd3=2E=
=2Ed53e376 100644</span><br><span>--- a/src/openvpn/oob_client=2Ec</span><b=
r><span>+++ b/src/openvpn/oob_client=2Ec</span><br><span>@@ -105,19 +105,9 =
@@</span><br><span>      * supported; the first entry&#39;s wrapping is use=
d for all=2E) */</span><br><span>     const struct connection_entry *ce =3D=
 c-&gt;options=2Econnection_list-&gt;array[0];</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    /* tls-crypt-v2 wraps with a=
 per-client key the server only learns from the</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-     * wrapped client key (WKc) carried in the TL=
S handshake=2E An out-of-band</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     * probe carries no WKc, so the server cannot unwrap it; skip p=
robing rather</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * t=
han send something unverifiable=2E */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (ce-&gt;tls_crypt_v2_file)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(D_LOW, &quot;server-probe: not supported with tls-c=
rypt-v2; using configured order&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return NULL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Load the tls-=
auth/tls-crypt key material into c-&gt;c1=2Eks (a no-op if neither</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * is configured)=2E This =
is run again per-connection later; calling it early</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * here is harmless=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Load the tls-auth/tls-cryp=
t(-v2) key material into c-&gt;c1=2Eks (a no-op if</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * none is configured)=2E This is run ag=
ain per-connection later; calling it</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * early here is harmless=2E */</span><br><span>     d=
o_init_tls_wrap_key(c, ce);</span><br><span> </span><br><span>     struct t=
ls_options to;</span><br><span>@@ -126,6 +116,15 @@</span><br><span>     to=
=2Ereplay_window =3D c-&gt;options=2Ereplay_window;</span><br><span>     to=
=2Ereplay_time =3D c-&gt;options=2Ereplay_time;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* tls-crypt-v2 wraps wit=
h a per-client key the server learns from the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * wrapped client key (WKc)=2E init_tls_wrap_=
ctx() loaded the per-client key</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * into the wrap context; make the WKc available too so the=
 probe can append</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * it (as a P_CONTROL_OOB_WKC_V1 message), mirroring init_instance()=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ce-&gt;tls=
_crypt_v2_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        to=2Etls_w=
rap=2Etls_crypt_v2_wkc =3D &amp;c-&gt;c1=2Eks=2Etls_crypt_v2_wkc;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct tls_auth_sta=
ndalone *tas =3D tls_auth_standalone_init(&amp;to, gc);</span><br><span> </=
span><br><span>     /* Control-channel frame and work buffers, mirroring do=
_init_frame_tls()=2E */</span><br><span>@@ -493,8 +492,15 @@</span><br><spa=
n>         return;</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* With tls-crypt-v2 the probe =
must carry the wrapped client key so the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * server can recover the per-client key; that is =
a P_CONTROL_OOB_WKC_V1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * message=2E Otherwise (tls-crypt v1, tls-auth, or plaintext) it is=
 a plain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * P_CO=
NTROL_OOB_V1=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const bool is_v2 =3D (tas-&gt;tls_wrap=2Etls_crypt_v2_wkc !=3D NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int probe_op=
code =3D is_v2 ? P_CONTROL_OOB_WKC_V1 : P_CONTROL_OOB_V1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct buffer p=
robe =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tls_w=
rap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_sid, &amp;payloa=
d, P_CONTROL_OOB_V1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        tls_wrap_oob_standalone(&amp;tas-&gt;tls_wrap, tas, &amp;client_s=
id, &amp;payload, probe_opcode);</span><br><span>     if (!BLEN(&amp;probe)=
)</span><br><span>     {</span><br><span>         msg(D_LOW, &quot;server-p=
robe: could not wrap probe packet; using configured order&quot;);</span><br=
><span>@@ -504,9 +510,10 @@</span><br><span>         return;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const char *wrap_name =3D (tas-&gt;tls_wrap=2Emode =3D=3D TLS_WRAP=
_CRYPT)  ? &quot;tls-crypt&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                            : (tas-&gt;tls_wrap=2Emode =3D=3D TL=
S_WRAP_AUTH) ? &quot;tls-auth&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                                                             =
       : &quot;none (plaintext)&quot;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *wrap_name =3D is_v2                     =
               ? &quot;tls-crypt-v2&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            : (tas-&gt;tls_wrap=2Emod=
e =3D=3D TLS_WRAP_CRYPT) ? &quot;tls-crypt&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                            : (tas-&gt;tls_wra=
p=2Emode =3D=3D TLS_WRAP_AUTH)  ? &quot;tls-auth&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
                             : &quot;none (plaintext)&quot;;</span><br><spa=
n>     msg(D_LOW, &quot;server-probe: probing %d remote(s) with a %d ms win=
dow, control-channel wrapping: %s&quot;,</span><br><span>         l-&gt;len=
, OOB_PROBE_WINDOW_MS, wrap_name);</span><br><span> </span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1759?usp=3Demail">change 1759</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1759?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType:=
 newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I5cc100dd7dc810d7d1e6f29bb57584905fbcf=
4a0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1759 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--Zs0Dez3sOvk=--


--===============2185467459260430791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2185467459260430791==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2185467459260430791==--

