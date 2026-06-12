Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 696ADCD98CE
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MnBlv1fyFcVRWip5d+NL5+52TczjP0wJ5nrZfx0ZImY=; b=PF+lJr1sD7h7LtBC6NAuWOhpve
	pOgW0UvZDTnzHS9GnH9Uz0haz0MU83VlbpdR3xGMn3IV4z2JKv0xVt/eZStyt7P7ykBVdBlEaHEyN
	tZEMOGBF+T1/4UpFhp1ZT0bSVcGo/IYlSbvfkstuSjbwZRjOFoFCAbhMSSP7AT6SXRHw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY2Gv-0007Xj-Qy;
	Fri, 12 Jun 2026 13:50:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wY2Gu-0007Xd-S7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 13:50:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xUgE8bilFPBlRrJs85ZhqVtmH8VA5yoKT6WWG1WHsMc=; b=lcNQhC2wH1ZABhldJGYq74zPot
 Nq3kUWPoW2xBUebH8eXX16KIHvVSkuhL1o59ozlFp8QWfuEUasKB7BD00AVNYG/+BLcnY7fwH9yop
 1m2VHBDdpK55Ipqdo1oXMwMWmM1wjaZ5Cv7BJmeuY8ReVbg/36focsz33kuyDSfwptAw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xUgE8bilFPBlRrJs85ZhqVtmH8VA5yoKT6WWG1WHsMc=; b=e
 LBjW5iMuO0FnTfzewqDEhGyWe4HZ6aJ2SnvONWjGXUhMNBr1Szoj3wZIYd5wG8X/JkA5QtYeXvTh7
 nn9K277G8LZ1G/J2Ns0GmFY/nxJTfaLA46TpDwXGB2rLGehZyOE5Rs3cve0nGY3cQ0H/cX/zPqT3d
 cQiBS/LqdsHyxxzc=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY2Gq-00007G-Me for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 13:50:09 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so10720775e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 06:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781272194; x=1781876994; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xUgE8bilFPBlRrJs85ZhqVtmH8VA5yoKT6WWG1WHsMc=;
 b=QT03osI5ST2X+clOZwmXP0YUvZdOpOwYpYBAbwL3QixvjyK//XOoPM9OFbJ1o+fiJu
 fII4q+z+9QFqV7/4MwBhWhbijrbdNCdVl9pw1efV585w7YQB7oROblmOLym94s+7m5Hm
 O2IYgZBc9sPKik9D+tzZTor6oGJTzfqDQ7d4fJ8lVhNl4q6qZ8VDLMu5Y7mu8+1gPip9
 dErVgFE2DMEUJg0cOAbrnNI29E2hUfLdT9Y7rYswOVsVgxvsXFICTGUx6rv0BOfQCCbW
 ASTBFLSs0uVBdB6a48rlF9ZbsnIxC3aYIarFOPclEC/5y0QoMHTIxgRT8vj4GCmouz6n
 GapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781272194; x=1781876994;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xUgE8bilFPBlRrJs85ZhqVtmH8VA5yoKT6WWG1WHsMc=;
 b=oiYnWvx7fYlkn1Z9qPPQA0AngOx9lUvWpXUdQujmTlKlZ3Wpu+Ek2HdTrSGtTHYid4
 zopWLPHRnEWN0yHkb7iueuL6UXpgwpU4yOYgjjaW6+YM7jxHj7WxqM2Co+b/6pHR67Ue
 tlXa138CzxfMcHB0nOS/0A5ovXQpdtmb+VkLvT9A7yK7l0MYSoLF1Q8auQlrnOiubCYd
 gfvH5eq0F9Jb4DwcGp+LHx+5MQWwFUurb8pUy8ZJztlwg9H+EMIvyL5RmUU/MYa2stwO
 LZrOhSG0jo73h7EhXeWGPaPKUbgHNQRIwrqP8UbKB+WSydGlXUgeJWujPyneCVJ/mRuy
 IVIg==
X-Gm-Message-State: AOJu0YztNSLEeLIw7rtT05UiIQ9kDN5ZYufRCk636tk20Iw067R/WUBg
 OP3u1F142AJKilietLviOPxrX/dd4ae6xIa9n6N4DL9mzar+MOmR5YkeSH9JQOgCPFuhDstTuFd
 P2dcsyWFn4iq1vRC97EeUKwr+4WIbgpj3RdB3oY1rVMh63pD+7KyzR9OttcY7UJU7gkSW
X-Gm-Gg: Acq92OHLRfQRbn8RXa5QXMMlciFjnlCkSoS7Zln/Ep/xE2OcZCJBDVaV7av0Izb1y3s
 79YYrprGgmyI5Q7OuCCoyfiM4Z/4PJ0dxTIN2aucU+IVNYaImly1UvIavY6OQm9eYwG2XOqrcdL
 1GyvinQqUhcvXY4WYSLy1rcYwHkAxZ0zCFV6qEIpt6EmgJTS1W9SXJ4Xo5snmtScVywfYTFJObv
 khhY/0EFCVfWyLG14PwXy6aFNgYlIeElH8Ki/nAGvfS4TksYeH5MlIWpTSK3UpphPHZ1+TsTJeB
 +pQ+qjQDy1wGNlWZqGDqGzzfCN4TCVcmK4OKgQgaCRVYYncVCmbPev81snYFsBMyLPTX/yplQxX
 G+U5quSPi8UKfT+cP3FK8hjTo2RTAyA/4J1n8wAIufr0k5OV1/IuPdHMgMu973FPjpXTdypSEKn
 M/5TC7NpcwSD5jOK9/cSSgOZ7Yy05YXy5yJ9C7jrtO0sOIO0fCeGTk5gi3zALvxQptrhR2nbfW6
 vOa+8DfMk5n2vOdErG21DD4HQhG7UcUEBXqBSF2bkZoaCUvT3l8tfdx8BBNbAKAXTBsUICATAUu
 8krGnS61CiS89Q==
X-Received: by 2002:a05:600c:c3dc:20b0:490:adb6:793d with SMTP id
 5b1f17b1804b1-490ec4fbd85mr30301955e9.26.1781272193314; 
 Fri, 12 Jun 2026 06:49:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2d0475asm241600915e9.12.2026.06.12.06.49.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 06:49:52 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 13:49:51 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
X-Gerrit-Change-Number: 1433
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1433?usp=email>
X-Gerrit-Commit: 334938d4aba45bf4dde063f8f8d2c6022edf2a13
In-Reply-To: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
References: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY1MzgzODQxMDAwLkkxZDRlMDIzM2NmMWNiMDk3MjVkYmQyY2FhMTIxYWNkYmY2MmYwNDUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8cdece99ae84ba5d984337077fe95dcbf2d67f6b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wY2Gq-00007G-Me
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbuf: Fix conversion
 warnings in mbuf and related code
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1954035483739431164=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1954035483739431164==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oBkopZNmC44="; charset=UTF-8

--oBkopZNmC44=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: mbuf: Fix conversion warnings in mbuf and relate=
d code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mbuf=
: Fix conversion warnings in mbuf and related code

Mostly these were actua=
lly hidden by casts, but fix
them as well by using more fitting types=2E

C=
hange-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Signed-off-by: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <gert@greenie=2E=
muc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433
Messa=
ge-Id: <20260612110424=2E27033-1-gert@greenie=2Emuc=2Ede>
URL: https://www=
=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37182=2Eht=
ml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/=
buffer=2Ec
M src/openvpn/mbuf=2Ec
2 files changed, 5 insertions(+), 17 dele=
tions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chang=
es/33/1433/7

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec
=
index 1e19137=2E=2E5f2b233 100644
--- a/src/openvpn/buffer=2Ec
+++ b/src/op=
envpn/buffer=2Ec
@@ -43,7 +43,7 @@
     unsigned long long res =3D
        =
 (unsigned long long)m1 * (unsigned long long)m2 + (unsigned long long)extr=
a;
     if (unlikely(m1 > limit) || unlikely(m2 > limit) || unlikely(extra =
> limit)
-        || unlikely(res > (unsigned long long)limit))
+        ||=
 unlikely(res > limit))
     {
         msg(M_FATAL, "attempted allocation =
of excessively large array");
     }
diff --git a/src/openvpn/mbuf=2Ec b/sr=
c/openvpn/mbuf=2Ec
index 5e1b585=2E=2E7b790ed 100644
--- a/src/openvpn/mbuf=
=2Ec
+++ b/src/openvpn/mbuf=2Ec
@@ -34,11 +34,6 @@
 
 #include "memdbg=2Eh"=

 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pus=
h
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 struct mbuf_set=
 *
 mbuf_init(unsigned int size)
 {
@@ -46,22 +41,17 @@
 
     struct mbuf_=
set *ret;
     ALLOC_OBJ_CLEAR(ret, struct mbuf_set);
-    ret->capacity =
=3D adjust_power_of_2(size);
+    ret->capacity =3D (unsigned int)adjust_po=
wer_of_2(size);
     ALLOC_ARRAY(ret->array, struct mbuf_item, ret->capacit=
y);
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pr=
agma GCC diagnostic pop
-#endif
-
 void
 mbuf_free(struct mbuf_set *ms)
 {
=
     if (ms)
     {
-        int i;
-        for (i =3D 0; i < (int)ms->len=
; ++i)
+        for (unsigned int i =3D 0; i < ms->len; ++i)
         {
   =
          struct mbuf_item *item =3D &ms->array[MBUF_INDEX(ms->head, i, ms-=
>capacity)];
             mbuf_free_buf(item->buffer);
@@ -145,8 +135,7 @@
=
     struct multi_instance *ret =3D NULL;
     if (ms)
     {
-        int =
i;
-        for (i =3D 0; i < (int)ms->len; ++i)
+        for (unsigned int=
 i =3D 0; i < ms->len; ++i)
         {
             struct mbuf_item *item =
=3D &ms->array[MBUF_INDEX(ms->head, i, ms->capacity)];
             if (ite=
m->instance)
@@ -164,8 +153,7 @@
 {
     if (ms)
     {
-        int i;
-  =
      for (i =3D 0; i < (int)ms->len; ++i)
+        for (unsigned int i =3D=
 0; i < ms->len; ++i)
         {
             struct mbuf_item *item =3D &m=
s->array[MBUF_INDEX(ms->head, i, ms->capacity)];
             if (item->ins=
tance =3D=3D mi)

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1433?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: n=
ewpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Gerrit-Change-Number: 1433
Gerrit=
-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>

--oBkopZNmC44=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #7</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">mbuf: Fix conversion warni=
ngs in mbuf and related code<br><br>Mostly these were actually hidden by ca=
sts, but fix<br>them as well by using more fitting types=2E<br><br>Change-I=
d: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452<br>Signed-off-by: Frank Lichte=
nheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@gr=
eenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1433<br>Message-Id: &lt;20260612110424=2E27033-1-gert@greenie=2Emuc=2Ed=
e&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esource=
forge=2Enet/msg37182=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=
=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/buffer=2Ec<br>M src/openvpn/mbuf=2E=
c<br>2 files changed, 5 insertions(+), 17 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/=
1433/7</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buffer=2Ec=
</span><br><span>index 1e19137=2E=2E5f2b233 100644</span><br><span>--- a/sr=
c/openvpn/buffer=2Ec</span><br><span>+++ b/src/openvpn/buffer=2Ec</span><br=
><span>@@ -43,7 +43,7 @@</span><br><span>     unsigned long long res =3D</s=
pan><br><span>         (unsigned long long)m1 * (unsigned long long)m2 + (u=
nsigned long long)extra;</span><br><span>     if (unlikely(m1 &gt; limit) |=
| unlikely(m2 &gt; limit) || unlikely(extra &gt; limit)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        || unlikely(res &gt; (unsigned lo=
ng long)limit))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    || unlikely(res &gt; limit))</span><br><span>     {</span><br><span>   =
      msg(M_FATAL, &quot;attempted allocation of excessively large array&qu=
ot;);</span><br><span>     }</span><br><span>diff --git a/src/openvpn/mbuf=
=2Ec b/src/openvpn/mbuf=2Ec</span><br><span>index 5e1b585=2E=2E7b790ed 1006=
44</span><br><span>--- a/src/openvpn/mbuf=2Ec</span><br><span>+++ b/src/ope=
nvpn/mbuf=2Ec</span><br><span>@@ -34,11 +34,6 @@</span><br><span> </span><b=
r><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> struct mbuf_set *</span><br><span> mbuf_init(uns=
igned int size)</span><br><span> {</span><br><span>@@ -46,22 +41,17 @@</spa=
n><br><span> </span><br><span>     struct mbuf_set *ret;</span><br><span>  =
   ALLOC_OBJ_CLEAR(ret, struct mbuf_set);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ret-&gt;capacity =3D adjust_power_of_2(size);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;capacity =3D =
(unsigned int)adjust_power_of_2(size);</span><br><span>     ALLOC_ARRAY(ret=
-&gt;array, struct mbuf_item, ret-&gt;capacity);</span><br><span>     retur=
n ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> m=
buf_free(struct mbuf_set *ms)</span><br><span> {</span><br><span>     if (m=
s)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     for (i =3D 0; i &lt; (int)ms-&gt;len; ++i)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        for (unsigned int i =3D 0; i &lt; ms-&g=
t;len; ++i)</span><br><span>         {</span><br><span>             struct =
mbuf_item *item =3D &amp;ms-&gt;array[MBUF_INDEX(ms-&gt;head, i, ms-&gt;cap=
acity)];</span><br><span>             mbuf_free_buf(item-&gt;buffer);</span=
><br><span>@@ -145,8 +135,7 @@</span><br><span>     struct multi_instance *=
ret =3D NULL;</span><br><span>     if (ms)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; (int)ms-&=
gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (unsigned int i =3D 0; i &lt; ms-&gt;len; ++i)</span><br><span>       =
  {</span><br><span>             struct mbuf_item *item =3D &amp;ms-&gt;arr=
ay[MBUF_INDEX(ms-&gt;head, i, ms-&gt;capacity)];</span><br><span>          =
   if (item-&gt;instance)</span><br><span>@@ -164,8 +153,7 @@</span><br><sp=
an> {</span><br><span>     if (ms)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; (int)ms-&gt;len; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (un=
signed int i =3D 0; i &lt; ms-&gt;len; ++i)</span><br><span>         {</spa=
n><br><span>             struct mbuf_item *item =3D &amp;ms-&gt;array[MBUF_=
INDEX(ms-&gt;head, i, ms-&gt;capacity)];</span><br><span>             if (i=
tem-&gt;instance =3D=3D mi)</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?usp=3Demail">=
change 1433</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1433?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1433 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flich=
tenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--oBkopZNmC44=--


--===============1954035483739431164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1954035483739431164==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1954035483739431164==--

