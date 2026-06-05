Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57AFCD6E7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QVbs9shJlNGMPasFJNcxzstW6mtqIdQGhurujbx9b5w=; b=DN2oFptRc3axLECBUZlyH7yE9c
	kBsn0pw0XAuUbZ144dohbV2+0abojdeMbJ2wi+FV+UBhJ0bO8Z+PjVASj3GwCmDtYLc6ejfcUuSPG
	rFlgCLj6KVPPFuStb0ML4p9I4hVdPkhFGxpyFChZ0PQbMxqxgEzEvSqgAB2RkYNBRhJA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVYyQ-0005Kz-1V;
	Fri, 05 Jun 2026 18:08:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wVYyF-0005Km-IB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:08:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=rZ0BwV+ANXAP7rfzC1FobaB0tO/dDDoddJrLFYGbhK4=; b=S9dShXPplHnp07uLPvUyTNPzMB
 RNIo7XjKQQeHerMHJpUSfaoqLYIJPR81VqE+JE7yHJCEjL54mIkywaBzyJIF6uvBoCJaD5fUALyIb
 jVJ98H+ShCXCWsglc4UZLh5PjVYaCRmOq8hq2d+HxhGgNi9akT1H907Hm3PUacj5G7+k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rZ0BwV+ANXAP7rfzC1FobaB0tO/dDDoddJrLFYGbhK4=; b=W
 Q7cGyr00LSy6Lpu9f83MnRkpdtjKIGxXE96PRAO3a0rZHeJNTdFIxGXc0pWCURkm/yjiBAaCEUtDn
 U9YLgXhJCZMMjLkJHmgFbxIO/YlN82F93e8ynGYU8pnfaKoRIyg9rIBqVTYuTkIfvOzkTvdShdzsO
 YulLMHKusuyBkDhY=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wVYyB-000269-1P for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:08:37 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-460166910e6so1203968f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 05 Jun 2026 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780682904; x=1781287704; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rZ0BwV+ANXAP7rfzC1FobaB0tO/dDDoddJrLFYGbhK4=;
 b=B17q1inCfmo9hQzW/QcrsWV4uJYVYaXwNL2uvjs+vr/zMMeqDxexg5VsWX6CoXIr8o
 TogKRZ5FaqcOAKnVmGiL7APpFfjvm5PAfR/qbHwCWYQrqWdGJ48f5QI9ZZLgs8UFSxAh
 iG13UU5LghUDW+7bSPojEEFsYDtCh7x8H3AKhXmicHB4T1IdPFnu0qrrN9vCBIKUPIGZ
 oynRtN8AiNQf6f/Ckqne24HeN3bcKKYMAJGZhUBlKqW7mPsllnTSLDr6jzbJv1kykTHb
 ixiovzbgG5qZKFHh9l4dVdiV1K5xtIznoSLYTTXvls1Jn/I6G3JNU3uZzTN77oJFJH02
 p9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780682904; x=1781287704;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rZ0BwV+ANXAP7rfzC1FobaB0tO/dDDoddJrLFYGbhK4=;
 b=qQnK7dmprsWLbw+/Wrkd6TmUEsBFvpFzXFgxXwDQwU9AnSsPOPsqCI2w00UTT50lk7
 61NyyNHa52e8DqFPIVuj1JoPxDYnP1sI9EeTXboX0EEYubbnjrDP3XClDDgZ/CjbNG7b
 IMWJyne2jyPkaeSw/j4R6iJvU9wnwnKxqOaLqcfW5TBRWyNkyN7TPiW8M+qOM+TzBrgo
 P+c6egXpjwwJrD5DdBRFXKViLne7ljbpLqDpYXUsF/xnkSrg6Nk9tOhMTVIUkpr+n5tV
 bYgEGHOIv+oJm4EhMhOMPdgORoAEU2W4DUT5Kas6+tdBwlvjodS8IkrjLOIK4GZpngk2
 9pvQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Nrn6oENURaMxzteU6gV7sicKP5jOnz6q7JZBt4xdKZNz6gkquju8oiZ91xUYTb1YZoDEJGCCWlO08Etbb@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzhUGpkQ1ghHopUSBMOrTNMrbtUhcmwr5ZRW3v+0BGRlskL2C1o
 ZDL/UMgca6jpli80TKONNai8pINJuyDOY/8kygUVI+jqh2U+OMuY3Bu7yV75EHe5e4085hWmdLX
 ks+vBE1MNhIPQQZnY3cklIcyXYTjsbujhWKHsqd9pXw355XBVnBbJr+FbwWc4v7FxMbdn0QX6dp
 KuKqaUqA==
X-Gm-Gg: Acq92OGL9ltmc0XbGwGPbrPBYTmn6psnahVK3y2HKtEqImjlUjs+yzBer/5X9KE/aYg
 ofGYMlWs3paVu8FGhUqOVRnHy/0DBFmm8cUEDk4W6qxapxcv9y6Mwfwhy6I9JYX/efT6C+sF/5G
 NoOLXVE46FIDm4Ar9IHqartmJiBlv3iqxALwjaiEAhE/fXmaWOScggn5ILCudQiDgMmirJVVpYe
 DDVjLmaw1YCkIjDfg6CiDW09y+yDF+x0tChMdhaemPr2w+WryYx++MQRYsD3QobJaszt44FX9J6
 Y5FERE/ntQ8M29Mij0acyb2+ZdnXoKORmOpvduZj0VIcsJ9UEnwzZVNBPrfpMRQyc4MUqqq59d9
 Stn6TW/bMukXB2+psoOccoy0J4hqiJMUFqdfqRRlY+XCg6KlRqDoCt9oFUCJAOXBldEwuZZlMJE
 I6cBW4ERBJJi1DZS6CIkruaDpp/BaEJgeE4aA5kagqZ+kObBO/CNBkkGJel/ZTd4/0yEwg+g5Gx
 FcmWLppPU+GkrORVGKiwFDDIRxmN3xK7F5MaCuu2+N2IdtMBQGqA70leZO9NwFOc0fq55Y8gsz5
 895y9EJoj5AklWbUqCBE74f0
X-Received: by 2002:adf:e107:0:b0:45e:f31a:7ae6 with SMTP id
 ffacd0b85a97d-4603061c0f5mr5387239f8f.30.1780682903855; 
 Fri, 05 Jun 2026 11:08:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dce6sm19872982f8f.30.2026.06.05.11.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 11:08:23 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 5 Jun 2026 18:08:23 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f
X-Gerrit-Change-Number: 1706
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1706?usp=email>
X-Gerrit-Commit: 71b271d9a168b7c43f3b78bdc4768edadfa25e86
In-Reply-To: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
References: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwNDA0NzIxMDAwLkkyY2U5NTRhYTViNzQwMDJiZTVlMzhkNTM3ODM0MzU3MzY2MjViYjJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a81728627545494db58070bac30017a693210d1b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wVYyB-000269-1P
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: assert
 buffer length before reading prepended sockaddr family
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7708169318929946039=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7708169318929946039==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qVEy0HwBh8M="; charset=UTF-8

--qVEy0HwBh8M=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1706?usp=3Demail )

Change subject: socket: assert buffer length before=
 reading prepended sockaddr family
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

socket: assert buffer length before reading prepende=
d sockaddr family

read_sockaddr_from_packet() inspected sa->sa_family befo=
re any check
on buf->len, so a short delivery from the dco-win driver would=
 have
produced a garbage peer address from uninitialized buffer memory=2E
T=
he driver always prepends a full sockaddr and validates the family
before w=
riting, so reaching any of the size/family checks would mean
something is s=
everely wrong on the driver side - assert the three
preconditions instead o=
f M_FATAL'ing on them=2E

GitHub: https://github=2Ecom/OpenVPN/openvpn-priv=
ate-issues/issues/105

Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f=

Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1706
Message-Id: <20260605141808=2E14028-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg37065=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
src/openvpn/socket=2Ec
1 file changed, 11 insertions(+), 18 deletions(-)


=


diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 624ce4=
f=2E=2Edf2cc9e 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=
=2Ec
@@ -2813,38 +2813,31 @@
 {
     int sa_len =3D 0;
 
+    /* In dco-win=
 multipeer mode the kernel driver always prepends a full
+     * sockaddr_i=
n or sockaddr_in6 in front of the control-packet payload,
+     * so the bu=
ffer must hold at least sizeof(struct sockaddr_in) bytes
+     * before we =
may inspect sa_family=2E */
+    ASSERT(buf_len(buf) >=3D (int)sizeof(struc=
t sockaddr_in));
+
     const struct sockaddr *sa =3D (const struct sockadd=
r *)BPTR(buf);
     switch (sa->sa_family)
     {
         case AF_INET:
  =
           sa_len =3D sizeof(struct sockaddr_in);
-            if (buf_len(=
buf) < sa_len)
-            {
-                msg(M_FATAL,
-              =
      "ERROR: received incoming packet with too short length of %d -- must =
be at least %d=2E",
-                    buf_len(buf), sa_len);
-          =
  }
-            memcpy(dst, sa, sa_len);
-            buf_advance(buf, sa_=
len);
             break;
 
         case AF_INET6:
             sa_len =3D=
 sizeof(struct sockaddr_in6);
-            if (buf_len(buf) < sa_len)
-    =
        {
-                msg(M_FATAL,
-                    "ERROR: receiv=
ed incoming packet with too short length of %d -- must be at least %d=2E",
=
-                    buf_len(buf), sa_len);
-            }
-            mem=
cpy(dst, sa, sa_len);
-            buf_advance(buf, sa_len);
+            A=
SSERT(buf_len(buf) >=3D sa_len);
             break;
 
         default:
- =
           msg(M_FATAL, "ERROR: received incoming packet with invalid addre=
ss family %d=2E",
-                sa->sa_family);
+            ASSERT(0); =
/* driver validates the family before writing */
     }
 
+    memcpy(dst, =
sa, sa_len);
+    buf_advance(buf, sa_len);
+
     return sa_len;
 }
 

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2ce954aa5b74002be5e38d537=
83435736625bb2f
Gerrit-Change-Number: 1706
Gerrit-PatchSet: 2
Gerrit-Owner:=
 stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--qVEy0HwBh8M=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1706?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">socket: assert buffer length before readin=
g prepended sockaddr family<br><br>read_sockaddr_from_packet() inspected sa=
-&gt;sa_family before any check<br>on buf-&gt;len, so a short delivery from=
 the dco-win driver would have<br>produced a garbage peer address from unin=
itialized buffer memory=2E<br>The driver always prepends a full sockaddr an=
d validates the family<br>before writing, so reaching any of the size/famil=
y checks would mean<br>something is severely wrong on the driver side - ass=
ert the three<br>preconditions instead of M_FATAL&#39;ing on them=2E<br><br=
>GitHub: https://github=2Ecom/OpenVPN/openvpn-private-issues/issues/105<br>=
<br>Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f<br>Signed-off-by: =
Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Gert Doering &lt;gert@g=
reenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1706<br>Message-Id: &lt;20260605141808=2E14028-1-gert@greenie=2Emuc=2E=
de&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourc=
eforge=2Enet/msg37065=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greeni=
e=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/socket=2Ec<br>1 file changed, 11 i=
nsertions(+), 18 deletions(-)<br><br></pre>
<pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/soc=
ket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 624ce4f=2E=2Edf2cc9e=
 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/=
src/openvpn/socket=2Ec</span><br><span>@@ -2813,38 +2813,31 @@</span><br><s=
pan> {</span><br><span>     int sa_len =3D 0;</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* In dco-win multipeer mod=
e the kernel driver always prepends a full</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * sockaddr_in or sockaddr_in6 in front of the c=
ontrol-packet payload,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * so the buffer must hold at least sizeof(struct sockaddr_in) bytes=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * before we ma=
y inspect sa_family=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    ASSERT(buf_len(buf) &gt;=3D (int)sizeof(struct sockaddr_in));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     c=
onst struct sockaddr *sa =3D (const struct sockaddr *)BPTR(buf);</span><br>=
<span>     switch (sa-&gt;sa_family)</span><br><span>     {</span><br><span=
>         case AF_INET:</span><br><span>             sa_len =3D sizeof(stru=
ct sockaddr_in);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (buf_len(buf) &lt; sa_len)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                msg(M_FATAL,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    &quot;ERROR: received incoming packet wit=
h too short length of %d -- must be at least %d=2E&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                    buf_len(buf), sa_le=
n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            memcpy(dst, sa=
, sa_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 buf_advance(buf, sa_len);</span><br><span>             break;</span><br><s=
pan> </span><br><span>         case AF_INET6:</span><br><span>             =
sa_len =3D sizeof(struct sockaddr_in6);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (buf_len(buf) &lt; sa_len)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(M_FATAL,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    &quot;ERROR: rec=
eived incoming packet with too short length of %d -- must be at least %d=2E=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      buf_len(buf), sa_len);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           memcpy(dst, sa, sa_len);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            buf_advance(buf, sa_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ASSERT(buf_len(buf) &gt;=3D s=
a_len);</span><br><span>             break;</span><br><span> </span><br><sp=
an>         default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(M_FATAL, &quot;ERROR: received incoming packet with invalid =
address family %d=2E&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                sa-&gt;sa_family);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            ASSERT(0); /* driver validates the family =
before writing */</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    memcpy(dst, sa, sa_len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf, sa_len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     return sa_len;</span><br><span> }</span><br><span> </span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1706?usp=3Demail">change 1706</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1706?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </=
div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I2ce954aa5b74002be5e38d53783435736625b=
b2f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1706 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--qVEy0HwBh8M=--


--===============7708169318929946039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7708169318929946039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7708169318929946039==--

