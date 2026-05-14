Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D9ACD4851
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2IeoK41iJcbGruGFrxq4BI6m/2Sk1NCZDyoQWywEelo=; b=Qxl/0EAJGV7iaoIupfw7FrktoA
	Y9RQRdMoQiK6FLrNDiDagwVEzmetbgG05tlE/F4WGQqsZ/671uyT0QfpMc92guXxDKFrQpOaRr8BT
	xTdhp3tV0WJCGOKwFOaDIFhrxcq+n+S3Rgjox+vHy19NGxvn77mMdBuCsp5Tud9HtpQk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTVj-0007Hd-FC;
	Thu, 14 May 2026 10:41:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNTVi-0007HX-0W
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=HmDqXAd1/HSYWlik8NkidM/xFCAwsP8AjoE9uuDfNvM=; b=cvYiqFWq7siPUF4VjgKW6JIAYR
 +rJTuz4A5KjH9tvY/j9vfiuf2IL/L08RVix+VskRsbtNqV2TDUH93zcJXD9r0CwhGUhkZ3sCdHcU5
 qFLoaoGhQyabPCmA9oYv5cMvBVwOgRclBMajh5eTSFzIYOXdv2IogX9S+uyxMFm+MXvQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HmDqXAd1/HSYWlik8NkidM/xFCAwsP8AjoE9uuDfNvM=; b=g
 VLLw8M5upQg1jgzs9EOnSBl9veNxVan+EsXQjPhDIHAT+A8VmYggoZNoiXg59+EdwXZ3o9iZg/YRc
 8xOKRdsvvgh9+CR6vYV6rmLj7LOsDvnPNQz53sDDx8I+P1GsE+KVXDlXkKeCuPFgFAAz3H1QRud2S
 3I/dXK7K0snJr7Pk=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNTVg-0007Ke-Ll for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:41:46 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso71168105e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778755294; x=1779360094; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HmDqXAd1/HSYWlik8NkidM/xFCAwsP8AjoE9uuDfNvM=;
 b=KbuAnZpGPiU2shBGKCpxLztEKvEt37fcAnKwOVA7gDX+ue9j4xDFD2vfiVBWqxI73D
 3vv6+4XjQzNBY+ieewEL9WkfzGGBc33n219/CO6oQHHy++6pD6rJTd02PaYbC3oPXK+J
 o42mRWZpl0FQr3AZ50eDgCrqIG7CBuphBblFs8nWMsBVVRssktUVFrplBoLmSmGJQfNM
 F75vSHJYAmHVxzJgALSyaBKxi4Ay+Y9FpoIxUdiwV3aQOmlpXJwaU1hzYueuCUIeR5V2
 6iKltdha/UWb+ZznEW9TRf49CmkjqzlJBX8wqTlnGVBlGinSlK85fM8ENvbclYCj65KC
 RcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755294; x=1779360094;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HmDqXAd1/HSYWlik8NkidM/xFCAwsP8AjoE9uuDfNvM=;
 b=dBa944nixRU1OZMZ8i03a32RMK+YMp0AWkUCHlIFHuqTE/Nc83CGShJgTaEJYJm+Y1
 7Nufx52OHb8QC5uev+FeWJpGbRxwxYaynstLOZk+stD1QjPXdAESgpBd/l+2ftc2EHCO
 zfNjxYh3Vqv3l1+1DvxpSRoB70aw2WFRpK8/Ofl6HV6fpmZEuf7gVWgCUhNeOwr3gnyP
 MhBVgEt02pHr439/lHuYg6wlTGYSIn5uOhrLJmhiSRryXnwRpu8sU4AbC8bTB66eXrmt
 W01kPuHdoty8FplEC4vlq4YaEzF8m+t+qRwQ5D0IrfNPfDZQKXs8w/xLQscyR0mySrlU
 VIlA==
X-Gm-Message-State: AOJu0YyfkKtmqDjP0/fnFH85utX/AESnAR8/aDjO525Nij06Lei1+g7m
 OZNteIrXzQsN4DvYcpAPIlCCZAeix7FJc7+jdJifnIr0ckFTSB3LSpS4HPImkRPlBiZPODNUP96
 Q6Wu2GN1lbQAy5/S/MbsdYViOt0s8/kcPDh6V5ynYrHfRMqJL3qZXWo4SHagBW1GSUiOsrPMhTJ
 J2ft/FlA==
X-Gm-Gg: Acq92OFdNTI1b4wUlkk6B4+1m3B7dm/ASE+N449/D20IVsGMx2F2oCVLoNzkqQOtfSp
 c7tUIxJuNtCJ/gCiZoXHiHLAnU5kr+EVPuyKBkBPiC7VjBEkjI8Py+fOP5N8zJPAmiqzfFd2H/n
 epaRab9jfZIwPPwgzYRNjZobTtnc68tkfZTTA0aLNxUBPgwSVu79RqJDxKo/+g+khWBXcqBESCb
 Rx3a+fEPusOWgRT+mSRf8zfakxYvKr+VmmQXV95lfzeoZqRhRDOj350gW5g1wbgTdGXxjvbqVnP
 OVbmRA+DkO2dGCieRsTf2UmIga0C2pLTRniLfXOhzP5VHLSRtjCNSGqB+1KpWhKwuculieJyzHL
 nr/n65O3tWc+Pj9aOx/hwoqa+wginGS2plV1rTMSn72ZAyqf+YJBwubsLDOyHEvWk95Zif6TNNS
 I2gDxCGAcnY34UVTHMBUhrbPELb0Jnr/F6X1WCivvIZxGs9Rli8aUyl07zISQnqva8X1ov0Zkvg
 yDFvjYEWTCivbHJji2ifQj34vcME4M4iRa+p2/EldDMF0kN32O3yRDoY+34GKdbKEcaRhyAMp09
 Y/DdSz1VAqbLG+MoFy2sVkSA
X-Received: by 2002:a05:600c:6305:b0:48a:5301:bb5c with SMTP id
 5b1f17b1804b1-48fc9a32aeamr108454305e9.16.1778755293587; 
 Thu, 14 May 2026 03:41:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fd7695d6dsm15058195e9.35.2026.05.14.03.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:41:33 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 10:41:31 +0000
To: flichtenheld <frank@lichtenheld.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
X-Gerrit-Change-Number: 1666
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1666?usp=email>
X-Gerrit-Commit: b6f09d015191eef75607653f47333c770d74db61
In-Reply-To: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@gerrit.openvpn.net>
References: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLkkzZWNiNzZkOTAyMmRjZDdkYWU5MmViNWU5ZDYyZTVmMDE4NzQ0ODgzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ff68376923c27e155fe2fe7f95a5f652f28c250-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNTVg-0007Ke-Ll
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Fix some
 issues with -DVERIFY_ALIGNMENT
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6876291405721110608=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6876291405721110608==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="P8h9vA4a9SU="; charset=UTF-8

--P8h9vA4a9SU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3Dema=
il )

The following approvals got outdated and were removed:
Code-Review+2 =
by cron2


Change subject: buffer: Fix some issues with -DVERIFY_ALIGNMENT
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

buffer: Fix s=
ome issues with -DVERIFY_ALIGNMENT

- Fix some uninitalised fields due to B=
UF_INIT_TRACKING
  (found by cppcheck and the original reason for this
   c=
hange)=2E
- Fix "unused functions" if only BUF_INIT_TRACKING is
  defined=
=2E
- Fix conversion error

Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f0187=
44883
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1666
Message-Id: <20260513092251=2E28857-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg36901=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/buffer=2Ec
1 file changed, 10 insertions(+),=
 5 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/66/1666/4

diff --git a/src/openvpn/buffer=2Ec b/src/openvpn/buff=
er=2Ec
index 71f3769=2E=2E1e19137 100644
--- a/src/openvpn/buffer=2Ec
+++ b=
/src/openvpn/buffer=2Ec
@@ -64,14 +64,13 @@
 #endif
 {
     struct buffer b=
uf;
+    CLEAR(buf);
 
     if (!buf_size_valid(size))
     {
         buf_=
size_error(size);
     }
     buf=2Ecapacity =3D (int)size;
-    buf=2Eoffs=
et =3D 0;
-    buf=2Elen =3D 0;
 #ifdef DMALLOC
     buf=2Edata =3D openvpn=
_dmalloc(file, line, size);
 #else
@@ -90,13 +89,13 @@
 #endif
 {
     stru=
ct buffer buf;
+    CLEAR(buf);
+
     if (!buf_size_valid(size))
     {
  =
       buf_size_error(size);
     }
     buf=2Ecapacity =3D (int)size;
-   =
 buf=2Eoffset =3D 0;
-    buf=2Elen =3D 0;
 #ifdef DMALLOC
     buf=2Edata =
=3D (uint8_t *)gc_malloc_debug(size, false, gc, file, line);
 #else
@@ -120=
,6 +119,10 @@
     ret=2Ecapacity =3D buf->capacity;
     ret=2Eoffset =3D =
buf->offset;
     ret=2Elen =3D buf->len;
+#ifdef BUF_INIT_TRACKING
+    re=
t=2Edebug_file =3D buf->debug_file;
+    ret=2Edebug_line =3D buf->debug_li=
ne;
+#endif
 #ifdef DMALLOC
     ret=2Edata =3D (uint8_t *)openvpn_dmalloc(=
file, line, buf->capacity);
 #else
@@ -140,6 +143,7 @@
     return buf_init=
_dowork(buf, offset);
 }
 
+#ifdef VERIFY_ALIGNMENT
 static inline int
 buf=
_debug_line(const struct buffer *buf)
 {
@@ -151,6 +155,7 @@
 {
     return=
 buf->debug_file;
 }
+#endif
 
 #else /* ifdef BUF_INIT_TRACKING */
 
@@ -1=
152,7 +1157,7 @@
     if (buf && buf->len)
     {
         msglvl_t msgleve=
l =3D D_ALIGN_DEBUG;
-        const unsigned int u =3D (unsigned int)BPTR(b=
uf);
+        const uintptr_t u =3D (uintptr_t)BPTR(buf);
 
         if (u =
& (PAYLOAD_ALIGN - 1))
         {

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1666?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
Gerrit-Change-Nu=
mber: 1666
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>

--P8h9vA4a9SU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3D=
email">View Change</a></p><p>The following approvals got outdated and were =
removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">buffer: Fix some issues wi=
th -DVERIFY_ALIGNMENT<br><br>- Fix some uninitalised fields due to BUF_INIT=
_TRACKING<br>  (found by cppcheck and the original reason for this<br>   ch=
ange)=2E<br>- Fix &quot;unused functions&quot; if only BUF_INIT_TRACKING is=
<br>  defined=2E<br>- Fix conversion error<br><br>Change-Id: I3ecb76d9022dc=
d7dae92eb5e9d62e5f018744883<br>Signed-off-by: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666<br>Messa=
ge-Id: &lt;20260513092251=2E28857-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36=
901=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>---<br>M src/openvpn/buffer=2Ec<br>1 file changed, 10 insertions(+), 5 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet=
:29418/openvpn refs/changes/66/1666/4</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buff=
er=2Ec b/src/openvpn/buffer=2Ec</span><br><span>index 71f3769=2E=2E1e19137 =
100644</span><br><span>--- a/src/openvpn/buffer=2Ec</span><br><span>+++ b/s=
rc/openvpn/buffer=2Ec</span><br><span>@@ -64,14 +64,13 @@</span><br><span> =
#endif</span><br><span> {</span><br><span>     struct buffer buf;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(buf);</span><br><sp=
an> </span><br><span>     if (!buf_size_valid(size))</span><br><span>     {=
</span><br><span>         buf_size_error(size);</span><br><span>     }</spa=
n><br><span>     buf=2Ecapacity =3D (int)size;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    buf=2Eoffset =3D 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    buf=2Elen =3D 0;</span><br><span> #ifdef DMA=
LLOC</span><br><span>     buf=2Edata =3D openvpn_dmalloc(file, line, size);=
</span><br><span> #else</span><br><span>@@ -90,13 +89,13 @@</span><br><span=
> #endif</span><br><span> {</span><br><span>     struct buffer buf;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (!buf_=
size_valid(size))</span><br><span>     {</span><br><span>         buf_size_=
error(size);</span><br><span>     }</span><br><span>     buf=2Ecapacity =3D=
 (int)size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=2E=
offset =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=
=2Elen =3D 0;</span><br><span> #ifdef DMALLOC</span><br><span>     buf=2Eda=
ta =3D (uint8_t *)gc_malloc_debug(size, false, gc, file, line);</span><br><=
span> #else</span><br><span>@@ -120,6 +119,10 @@</span><br><span>     ret=
=2Ecapacity =3D buf-&gt;capacity;</span><br><span>     ret=2Eoffset =3D buf=
-&gt;offset;</span><br><span>     ret=2Elen =3D buf-&gt;len;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef BUF_INIT_TRACKING</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ret=2Edebug_file =3D buf-=
&gt;debug_file;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ret=2Edebug_line =3D buf-&gt;debug_line;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> #ifdef DMALLOC</span><br><span=
>     ret=2Edata =3D (uint8_t *)openvpn_dmalloc(file, line, buf-&gt;capacit=
y);</span><br><span> #else</span><br><span>@@ -140,6 +143,7 @@</span><br><s=
pan>     return buf_init_dowork(buf, offset);</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef VERIF=
Y_ALIGNMENT</span><br><span> static inline int</span><br><span> buf_debug_l=
ine(const struct buffer *buf)</span><br><span> {</span><br><span>@@ -151,6 =
+155,7 @@</span><br><span> {</span><br><span>     return buf-&gt;debug_file=
;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span> </span><br><span> #else /* ifdef BUF_INIT_TRACKING=
 */</span><br><span> </span><br><span>@@ -1152,7 +1157,7 @@</span><br><span=
>     if (buf &amp;&amp; buf-&gt;len)</span><br><span>     {</span><br><spa=
n>         msglvl_t msglevel =3D D_ALIGN_DEBUG;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        const unsigned int u =3D (unsigned int)BP=
TR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        con=
st uintptr_t u =3D (uintptr_t)BPTR(buf);</span><br><span> </span><br><span>=
         if (u &amp; (PAYLOAD_ALIGN - 1))</span><br><span>         {</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1666?usp=3Demail">change 1666</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1666?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Pro=
ject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Id: I3ecb76d9022dcd7dae92eb5=
e9d62e5f018744883 </div>
<div style=3D"display:none"> Gerrit-Change-Number:=
 1666 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div st=
yle=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@g=
reenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>

</body></html>
--P8h9vA4a9SU=--


--===============6876291405721110608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6876291405721110608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6876291405721110608==--

