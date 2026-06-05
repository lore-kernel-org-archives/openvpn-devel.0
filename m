Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0578CD6E7C
	for <openvpn-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GStl5vPb1b1nVysBl4xcKpjynFa8AnDEgnwAIirQQDQ=; b=j++nPAHY/uUH7QssfJXEQxd8mf
	GYEOG9hr6yjEA9BZ749H/nq4XsATiyDuVZK9aUnZ4MNKSg9WrFVol0E5BYxXF3gGpIzR13VbOoeui
	TzJrnzqOhyuBOnEPrQadzIvNMTvOQspNuw0aACuFVQD4+PpXhRKyuOxLBZxoK+MDbs9A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wVYyD-0001ST-Ke;
	Fri, 05 Jun 2026 18:08:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wVYyC-0001SN-Su
 for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:08:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=X5EvDSYdTmlvaeQc7ZmfeEKBck51JTVEwBjKTYRyIRU=; b=QfDFFJmSlkjs0HsubsZ0tDiH0H
 4BJtNiybZ1/x0NN8FDvlYJ7llXyZAAhVy44J+TNT0ELM8mAhMPyEd6wpuChkMfbp8RHmfXCVan+/S
 slesXFZIYt42SuTDvCKbDFVyIolwjCE0UX6nB0QK75el8nFw3JtL6Sm+CsucExUIpbqw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=X5EvDSYdTmlvaeQc7ZmfeEKBck51JTVEwBjKTYRyIRU=; b=Q
 uaPirmvQUwyaM1htxKXXxhA6NyO5kHX8M/Jbd2InGMNmRV5LgZNQ9yjaP/VfVR7sd2dUj4yAg8D+8
 YjLuhn56frPUl9aTpNjqYxEHsbMM3P5YQSeiAaEiLSNLsxRlkezfqMnc3MXUFGY67OckpAmB9yMjb
 VkQEkyEWFuoK9GmE=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wVYyA-000265-GJ for openvpn-devel@lists.sourceforge.net;
 Fri, 05 Jun 2026 18:08:36 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso18462025e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 05 Jun 2026 11:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780682903; x=1781287703; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=X5EvDSYdTmlvaeQc7ZmfeEKBck51JTVEwBjKTYRyIRU=;
 b=XlmUvr60cCMNY8YFbCdb8hJvpk+2SdN6E4zJHfk51SOwhZ61ef33gyL1GgkQEOsjic
 MBvwlhE58+oASpUw8i8GSwzUJ2obE7QeBK+/YMTEKMxEhBkGstuygXi3ubJfjJEofbst
 CS2ADHj1q36uz3p0PDX2eHIFGIPxK0GirkLbbB1LFdkeLsgi9v/8xlYyFbb5pH4EN/zE
 shOVGMW49gyec9Ei6Q6eLJx77foQy/XnsDYhSN7A2tS4fVRLUJSKzpcToAEG9FHUKRTT
 7U2a/zdQC5V0dN6Zw5TBLSKl+RNEHjBDh1AUgMVsMkqZhFVvTI2wz+U3Q6ueYMgJX1t6
 9hfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780682903; x=1781287703;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X5EvDSYdTmlvaeQc7ZmfeEKBck51JTVEwBjKTYRyIRU=;
 b=ZtcZQvVmw6PAlIQdPMAKue9ik5pKGTqRqCO15L5lSZjTIB4UuAl5DqJBHtABfkfQ5v
 4qfaoXNTh/fflS8DTI/syrNfsEWxTLxZisgqjjdtiqt7lfwp269uZs08XtwspGx3aI8c
 PIPgFkPIL62lPe8FJ6A9x25bbwGrgYyBe3AS2S5MlWPXhlYoBmUOqPYMSWuTKw6SxDAT
 Jp3sopM9vZk/KN3/OiSkslz/6Nl9xapuz2bcAQsAkzZjYqDBJXUa8GZehvbnQiT5xufx
 8vc2QDayIAZywl2sRmHWMUMtZ8DiF1qf9ERMOtSVkWVgycfzkpxbC/zJAYzEN623u3yv
 YrMw==
X-Gm-Message-State: AOJu0YyNlY1wC7mphzluWC7QB3kcuRIO7OPbBRgeBiT037KvvA8X8P7p
 9G9cZDBCpaQRU4ysFFTfk1hyxpytQ2mUKly9+eqHKf1txs5/rd41tRoXfTH/45/745pL6Fue1UP
 w7qxTsAUOLiEMKFmlVmmtRLBXIhZTxx08qw7Mf/8p04RsSMN3Hbu36VwZKtPXFQ1JgmlM
X-Gm-Gg: Acq92OFbRGlGIPPAAy0VzPOaEsYFciqVudhkdjRqW6dOSCro9X1qjFz1OyL2jT4Z6e6
 0GuWxmSgm7hkPecuNaVc8DSEFaYdsf87lBhR3dhNNntgzUk9pM7KaRKj6b4gMWoeXyaC+sSk2gl
 2bTePtmHnW12faA8mvdZ+Okc5wpmbTpwFtlDCrIzL7FvUCUEIbZL+40835thHFvF+qfZaPxH2nX
 vEflLEDCcygrwPJIb2pFLHiuv/qzlMxOmGSEmpcAAt5jj2u8Vj1sEvt3awQ2z3miT22VlLfF8y6
 /SiCKVNSuA+ScNpM3csphOPTLiTGWgEeJnCoqEXb7LrIaxfk5dUhb6IGn0SDsOqMtJBpjjFfLhb
 DjMgya0i3482ztH547BiZTrnXo9HPk7FAO+RkIcf8XJwE2t4bIe5YGCgz2T17zgluyYCX8K4IS0
 /GYOyZhzTOHN03YS2O8+8/0Bsas0E4wUoROX1MaCBDSxDnaUDFXmOriwwTWd5oXzqwdi2yEaKie
 /BQOqkucUyV1OPnBup6mSG7OW0zBJ0/dBb9TqyQXyVG7m/H4Soi/fzdh48tTEdAgHCmn+Sl87Kb
 aztMUMfk4n4opQQPBZmHPXSU+fvmyfLVGJU=
X-Received: by 2002:a05:600c:c16f:b0:490:bb59:63b7 with SMTP id
 5b1f17b1804b1-490c25ff02emr73932915e9.28.1780682903026; 
 Fri, 05 Jun 2026 11:08:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc413adbsm173279565e9.15.2026.06.05.11.08.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 11:08:22 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 5 Jun 2026 18:08:20 +0000
To: stipa <lstipakov@gmail.com>, plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f
X-Gerrit-Change-Number: 1706
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1706?usp=email>
X-Gerrit-Commit: 71b271d9a168b7c43f3b78bdc4768edadfa25e86
In-Reply-To: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
References: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwNDA0NzIxMDAwLkkyY2U5NTRhYTViNzQwMDJiZTVlMzhkNTM3ODM0MzU3MzY2MjViYjJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a81728627545494db58070bac30017a693210d1b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wVYyA-000265-GJ
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2512957475032891546=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2512957475032891546==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pN/vIjI2rlU="; charset=UTF-8

--pN/vIjI2rlU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by cron=
2


Change subject: socket: assert buffer length before reading prepended s=
ockaddr family
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


socket: assert buffer length before reading prepended sockaddr family

re=
ad_sockaddr_from_packet() inspected sa->sa_family before any check
on buf->=
len, so a short delivery from the dco-win driver would have
produced a garb=
age peer address from uninitialized buffer memory=2E
The driver always prep=
ends a full sockaddr and validates the family
before writing, so reaching a=
ny of the size/family checks would mean
something is severely wrong on the =
driver side - assert the three
preconditions instead of M_FATAL'ing on them=
=2E

GitHub: https://github=2Ecom/OpenVPN/openvpn-private-issues/issues/105=


Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f
Signed-off-by: Lev S=
tipakov <lev@openvpn=2Enet>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706
Message-Id: <=
20260605141808=2E14028-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-a=
rchive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37065=2Ehtml
Signed=
-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/socket=2E=
c
1 file changed, 11 insertions(+), 18 deletions(-)


  git pull ssh://gerr=
it=2Eopenvpn=2Enet:29418/openvpn refs/changes/06/1706/2

diff --git a/src/o=
penvpn/socket=2Ec b/src/openvpn/socket=2Ec
index 624ce4f=2E=2Edf2cc9e 10064=
4
--- a/src/openvpn/socket=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -2813,38 +28=
13,31 @@
 {
     int sa_len =3D 0;
 
+    /* In dco-win multipeer mode the =
kernel driver always prepends a full
+     * sockaddr_in or sockaddr_in6 in=
 front of the control-packet payload,
+     * so the buffer must hold at le=
ast sizeof(struct sockaddr_in) bytes
+     * before we may inspect sa_famil=
y=2E */
+    ASSERT(buf_len(buf) >=3D (int)sizeof(struct sockaddr_in));
+
 =
    const struct sockaddr *sa =3D (const struct sockaddr *)BPTR(buf);
     =
switch (sa->sa_family)
     {
         case AF_INET:
             sa_len =
=3D sizeof(struct sockaddr_in);
-            if (buf_len(buf) < sa_len)
-  =
          {
-                msg(M_FATAL,
-                    "ERROR: rece=
ived incoming packet with too short length of %d -- must be at least %d=2E"=
,
-                    buf_len(buf), sa_len);
-            }
-            m=
emcpy(dst, sa, sa_len);
-            buf_advance(buf, sa_len);
            =
 break;
 
         case AF_INET6:
             sa_len =3D sizeof(struct soc=
kaddr_in6);
-            if (buf_len(buf) < sa_len)
-            {
-       =
         msg(M_FATAL,
-                    "ERROR: received incoming packet=
 with too short length of %d -- must be at least %d=2E",
-                 =
   buf_len(buf), sa_len);
-            }
-            memcpy(dst, sa, sa_le=
n);
-            buf_advance(buf, sa_len);
+            ASSERT(buf_len(buf)=
 >=3D sa_len);
             break;
 
         default:
-            msg(M_F=
ATAL, "ERROR: received incoming packet with invalid address family %d=2E",
=
-                sa->sa_family);
+            ASSERT(0); /* driver validate=
s the family before writing */
     }
 
+    memcpy(dst, sa, sa_len);
+    =
buf_advance(buf, sa_len);
+
     return sa_len;
 }
 

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I2ce954aa5b74002be5e38d53783435736625bb=
2f
Gerrit-Change-Number: 1706
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstip=
akov@gmail=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--pN/vIjI2rlU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by stipa=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">socket: assert buffer length befo=
re reading prepended sockaddr family<br><br>read_sockaddr_from_packet() ins=
pected sa-&gt;sa_family before any check<br>on buf-&gt;len, so a short deli=
very from the dco-win driver would have<br>produced a garbage peer address =
from uninitialized buffer memory=2E<br>The driver always prepends a full so=
ckaddr and validates the family<br>before writing, so reaching any of the s=
ize/family checks would mean<br>something is severely wrong on the driver s=
ide - assert the three<br>preconditions instead of M_FATAL&#39;ing on them=
=2E<br><br>GitHub: https://github=2Ecom/OpenVPN/openvpn-private-issues/issu=
es/105<br><br>Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f<br>Signe=
d-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1706<br>Message-Id: &lt;20260605141808=2E14028-1-gert@greeni=
e=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lis=
ts=2Esourceforge=2Enet/msg37065=2Ehtml<br>Signed-off-by: Gert Doering &lt;g=
ert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/socket=2Ec<br>1 file cha=
nged, 11 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/06/1706/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><spa=
n>index 624ce4f=2E=2Edf2cc9e 100644</span><br><span>--- a/src/openvpn/socke=
t=2Ec</span><br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -2813=
,38 +2813,31 @@</span><br><span> {</span><br><span>     int sa_len =3D 0;</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* In dco-win multipeer mode the kernel driver always prepends a full</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * sockaddr_in or so=
ckaddr_in6 in front of the control-packet payload,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * so the buffer must hold at least size=
of(struct sockaddr_in) bytes</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * before we may inspect sa_family=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_len(buf) &gt;=3D (int)size=
of(struct sockaddr_in));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     const struct sockaddr *sa =3D (const struct sock=
addr *)BPTR(buf);</span><br><span>     switch (sa-&gt;sa_family)</span><br>=
<span>     {</span><br><span>         case AF_INET:</span><br><span>       =
      sa_len =3D sizeof(struct sockaddr_in);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (buf_len(buf) &lt; sa_len)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                msg(M_FATAL,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;ERROR: =
received incoming packet with too short length of %d -- must be at least %d=
=2E&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         buf_len(buf), sa_len);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            memcpy(dst, sa, sa_len);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            buf_advance(buf, sa_len);</span><br><span>    =
         break;</span><br><span> </span><br><span>         case AF_INET6:</=
span><br><span>             sa_len =3D sizeof(struct sockaddr_in6);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (buf_len(buf) =
&lt; sa_len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
sg(M_FATAL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          &quot;ERROR: received incoming packet with too short length of %d=
 -- must be at least %d=2E&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    buf_len(buf), sa_len);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            memcpy(dst, sa, sa_len);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            buf_advance(buf, sa_len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ASSER=
T(buf_len(buf) &gt;=3D sa_len);</span><br><span>             break;</span><=
br><span> </span><br><span>         default:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            msg(M_FATAL, &quot;ERROR: received incom=
ing packet with invalid address family %d=2E&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                sa-&gt;sa_family);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            ASSERT(0); /* dr=
iver validates the family before writing */</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy=
(dst, sa, sa_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_advance(buf, sa_len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     return sa_len;</span><br><span> }</span><br>=
<span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail">change 1706</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1706?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"disp=
lay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ce954aa5=
b74002be5e38d53783435736625bb2f </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1706 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 =
</div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--pN/vIjI2rlU=--


--===============2512957475032891546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2512957475032891546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2512957475032891546==--

