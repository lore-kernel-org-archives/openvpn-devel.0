Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F0C8C531CC
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVPZD+C6qZWq5qp34FH6PCDDSe6gn1e8ZvcnDV3Zwz8=; b=cFf3t/0uAHyzjOmgaW5l4IWNV2
	H0R//JfcIkaEBrt9q62iihylFRTKFSVT9Fan5CfuKKfO/82Cx7o3Z4riUuZVrAwIoGC3yxMhy9bQb
	aTTWnp/mMzTDzVus1Me8K+8xAhMOs9jHvcKlmHzrdDRA7bAHvtv+DxhrYq1iOv3mnDvs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wn0Gv-00064S-7a;
	Thu, 23 Jul 2026 20:44:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wn0Gt-00064C-Is
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 20:44:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vpBSU2MHOiufdjQIyKyHNaZPiicH+yscxmDrtHscEsc=; b=Jjwil+7k2RG53tjtqM5RSo1G5T
 gvXwlvbCqfWFwsZMV37htBSaIAFZ24S/f+TREtySkRJ63sd6ooK9ym8z4yBAtbE/S8NRwEjfoeEyo
 B3ldGcOH8+53OfRvs227qKRLUtyyq8Dcnn7jqKPuw3Bqr4a2Br10C1I/nEJcGG/C5Tww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vpBSU2MHOiufdjQIyKyHNaZPiicH+yscxmDrtHscEsc=; b=X
 PXdNJFQGCtKQKPxtkIR1CVXncUEp9K51xIivXdsL70eHmGVPC09NvHGOZ1apcFoHH7KOYoHCxcz74
 8rpREft+03j84tI48UgmoUReP6CaDUJKsmH4v9MZJm1RS0zhTVav3dzl9QUbeAkINKdBbFJcwQMGu
 Vu2uNQFX3ye5ZykA=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wn0Gs-0003yQ-Nv for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 20:44:00 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49550ec592cso5960955e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 13:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784839432; x=1785444232; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vpBSU2MHOiufdjQIyKyHNaZPiicH+yscxmDrtHscEsc=;
 b=OPlashViUExqXStowrGmbdNeXyNUgnGRtWT4iar1vtwRkokAmDZH+5DFIHPtw3e7nK
 sBDi4Yc+6bhkBdKZTHbwdMH8eg69ClS4ieQ0SIo9AY5zK33pS5lE1/5hEWF6AoOdhV9O
 JfFYxi5SVbxB0T8GPRXNXIQRWB2JVlRKFCJ/nmFh9m2vZAdnoW7zW7jzQVCGLVBIFRxa
 0r/8cRRTU6j6RRf8FnYIYFuJ9b92B/31I+RQH/k/kHUUNcOGmma4/pP+fKv2Dl3OkUoS
 l25L0HM5xlz4bWmMR8ZD/zM873U3PhSnpCca1WER3XYdLxGU3Ogpf0oks4HmvfHeRV+S
 rHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784839432; x=1785444232;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vpBSU2MHOiufdjQIyKyHNaZPiicH+yscxmDrtHscEsc=;
 b=PD07+vi2DhPuBZ0ajNbiNtBGzkRF4jRihif0Bz7aUO/l4ElRua2e88IKK3eoB11NDO
 INvTJvfJWArSto9yS03Wk3T668yMSQsTfH+2CWEae6WGtWtOcEzgA8poQKH6HauSQLQ8
 SgONaWkzEAqHkyjwrgHDK/LvXonrYO7dH3UW/ys6op1+gkDM15Q67qYKKZOKoVOqd1lg
 4IRHzRnysPUHReXXYdm1JgWMqn4NBUC5x0cEsRxdexkccVX5rcS9evMKXH8h4T5qQr29
 jLMTvsp44g2E/AUq+WAS4ZU9gbu33O9oUEraJqb/df/VqQ3klGDOuPK3fx4/8a/F5JOm
 pGFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqhCBPhHoBkr8xa5SDlDlrt2NPGQ2+ESFX9gPCRqK6B7s1A86TytkLKWMtgpZJjFbuJEgeIGWfP5jyOXWLC@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxB6exv34O0M1H+PCgHH88Hf6LVyb2TkfY7Jy1baPEMrwk17rqK
 TJ5MrKufQcRSGyv2y6tBUtakE0g5YIynhS2CC4EoZWFWk4xYsniFefLsE60DbTZEwQQV+HsrUR3
 uYi8/22zuf+/RLxMGzzKG5Js5ozdUvN+uEEHb6GRbU2oR0TBPOPHccN1NtpSTrdpx1RsBXKHqIp
 F0pW0daA==
X-Gm-Gg: AR+sD13A9fN4PEvLAqiSBHWzQkuBYVN+YU8z/zsHt5YTbEm2kaOpJLn4Cl/svVA3Ls5
 4MQAO0ccSnm05Hsp3FmU5kNVjLSgjW2N+1KiSZMEK8aTLbR+mtitoUgQevWCoP+adCw1sW6gRFp
 iBe2H0RRd+4HP82H+xS9ZUPUtZDtQiKM0Ecjnhk014pUVnFi9WMt0ZpEDxDfVz7XiA7wZbxENzX
 SQWR1W5x26rW3GW9SZHO0dsZWBy5z6EGgFiA6AoDZurQOrtKRneIsxBdo2CaSqje3/uN0CvvXIN
 GEgExcMU28h81Lb2jX44/6b9dwbGZQ65o2AJwMo5ZbumKvD8dK9NYjMSZpEG4TnBacFO6iQdquK
 yKxNeHkNl1EuQ63McoV0hCASDjhBrbLwJlKPqsOLoiXkagl27zsQJgfhheL4QDXXiCS0qT4/LV6
 S80nkzaL2rC650ORQBIjSADNTCO1QLc2j1ZvbjDHNGOBI7g53oaXCu5JJPkscCX470nzUJuuF/E
 34tETHtzj3ov02WvycWacYNwCwTFIpYLrtW7feiKsLLWveneRUInHrbfAWfs3t0TkocYDW857HL
 nFg=
X-Received: by 2002:a5d:5e03:0:b0:47f:8f3b:89a6 with SMTP id
 ffacd0b85a97d-47f90253e98mr4423841f8f.12.1784839432001; 
 Thu, 23 Jul 2026 13:43:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85bb81dcsm17985461f8f.12.2026.07.23.13.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:43:51 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 20:43:51 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a
X-Gerrit-Change-Number: 1733
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1733?usp=email>
X-Gerrit-Commit: 035a88f97b1ffdc88497faeaa0aeb8a72e1eaf4f
In-Reply-To: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
References: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTAwNDExMDAwLkk2NTk1Njk1YWI2NDAxMDQ3ZDQ5OGQ1MzBmODczOTY4Njg4MGJlYTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <22b6a3eafa1241f08e633056676fc9dd9c98fb7a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wn0Gs-0003yQ-Nv
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mingw: avoid C99
 "hh" scanf length modifier
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2689065295717910731=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2689065295717910731==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LDpCg6Wu65I="; charset=UTF-8

--LDpCg6Wu65I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1733?usp=3Demail )

Change subject: mingw: avoid C99 "hh" scanf length =
modifier
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ming=
w: avoid C99 "hh" scanf length modifier

read_key_file() and parse_hexstrin=
g() parse hex bytes with sscanf()
using the C99 "hh" length modifier, stori=
ng directly into an octet=2E

This is not portable to the legacy MSVCRT run=
time that Ubuntu
resolute's (26=2E04) mingw toolchain links against=2E

Sca=
n into an unsigned int and cast to the octet instead=2E The field width
cap=
s the value at 0xFF, so the narrowing cast cannot lose data=2E

Change-Id: =
I6595695ab6401047d498d530f8739686880bea3a
Signed-off-by: Heiko Hund <heiko@=
ist=2Eeigentlich=2Enet>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733
Message-Id: =
<20260708185659=2E10219-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-=
archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37544=2Ehtml
Signe=
d-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto=
=2Ec
M src/openvpn/cryptoapi=2Ec
2 files changed, 6 insertions(+), 4 deleti=
ons(-)




diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
ind=
ex 3d79fe5=2E=2Eee43d65 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openv=
pn/crypto=2Ec
@@ -1473,9 +1473,9 @@
                     hex_byte[hb_index+=
+] =3D c;
                     if (hb_index =3D=3D 2)
                     =
{
-                        uint8_t u;
-                        ASSERT(sscan=
f((const char *)hex_byte, "%" SCNx8, &u) =3D=3D 1);
-                      =
  *out++ =3D u;
+                        unsigned int u;
+                 =
       ASSERT(sscanf((const char *)hex_byte, "%2x", &u) =3D=3D 1);
+       =
                 *out++ =3D (uint8_t)u;
                         hb_index =
=3D 0;
                         if (++count =3D=3D keylen)
                =
         {
diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=
=2Ec
index bf80bbd=2E=2E0f95ab7 100644
--- a/src/openvpn/cryptoapi=2Ec
+++ =
b/src/openvpn/cryptoapi=2Ec
@@ -169,10 +169,12 @@
             break;
     =
    }
 
-        if (!isxdigit(p[0]) || !isxdigit(p[1]) || sscanf(p, "%2hhx=
", &arr[i++]) !=3D 1)
+        unsigned int b;
+        if (!isxdigit(p[0])=
 || !isxdigit(p[1]) || sscanf(p, "%2x", &b) !=3D 1)
         {
            =
 return 0;
         }
+        arr[i++] =3D (unsigned char)b;
     }
     r=
eturn i;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
733?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged=

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6595695ab=
6401047d498d530f8739686880bea3a
Gerrit-Change-Number: 1733
Gerrit-PatchSet:=
 3
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--LDpCg6Wu65I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1733?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">mingw: avoid C99 &quot;hh&quot; scanf leng=
th modifier<br><br>read_key_file() and parse_hexstring() parse hex bytes wi=
th sscanf()<br>using the C99 &quot;hh&quot; length modifier, storing direct=
ly into an octet=2E<br><br>This is not portable to the legacy MSVCRT runtim=
e that Ubuntu<br>resolute&#39;s (26=2E04) mingw toolchain links against=2E<=
br><br>Scan into an unsigned int and cast to the octet instead=2E The field=
 width<br>caps the value at 0xFF, so the narrowing cast cannot lose data=2E=
<br><br>Change-Id: I6595695ab6401047d498d530f8739686880bea3a<br>Signed-off-=
by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Frank Lich=
tenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1733<br>Message-Id: &lt;20260708185659=2E10219-1-ger=
t@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-d=
evel@lists=2Esourceforge=2Enet/msg37544=2Ehtml<br>Signed-off-by: Gert Doeri=
ng &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>M =
src/openvpn/cryptoapi=2Ec<br>2 files changed, 6 insertions(+), 4 deletions(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypt=
o=2Ec</span><br><span>index 3d79fe5=2E=2Eee43d65 100644</span><br><span>---=
 a/src/openvpn/crypto=2Ec</span><br><span>+++ b/src/openvpn/crypto=2Ec</spa=
n><br><span>@@ -1473,9 +1473,9 @@</span><br><span>                     hex_=
byte[hb_index++] =3D c;</span><br><span>                     if (hb_index =
=3D=3D 2)</span><br><span>                     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        uint8_t u;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                        ASSERT(ssca=
nf((const char *)hex_byte, &quot;%&quot; SCNx8, &amp;u) =3D=3D 1);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        *out++=
 =3D u;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            unsigned int u;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        ASSERT(sscanf((const char *)hex_byte, &quot=
;%2x&quot;, &amp;u) =3D=3D 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        *out++ =3D (uint8_t)u;</span><br><span> =
                        hb_index =3D 0;</span><br><span>                   =
      if (++count =3D=3D keylen)</span><br><span>                         {=
</span><br><span>diff --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/crypt=
oapi=2Ec</span><br><span>index bf80bbd=2E=2E0f95ab7 100644</span><br><span>=
--- a/src/openvpn/cryptoapi=2Ec</span><br><span>+++ b/src/openvpn/cryptoapi=
=2Ec</span><br><span>@@ -169,10 +169,12 @@</span><br><span>             bre=
ak;</span><br><span>         }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (!isxdigit(p[0]) || !isxdigit(p[1]) |=
| sscanf(p, &quot;%2hhx&quot;, &amp;arr[i++]) !=3D 1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        unsigned int b;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!isxdigit(p[0]) || !isxdi=
git(p[1]) || sscanf(p, &quot;%2x&quot;, &amp;b) !=3D 1)</span><br><span>   =
      {</span><br><span>             return 0;</span><br><span>         }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        arr[i++] =3D =
(unsigned char)b;</span><br><span>     }</span><br><span>     return i;</sp=
an><br><span> }</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail">change 1733=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65956=
95ab6401047d498d530f8739686880bea3a </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1733 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@openv=
pn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--LDpCg6Wu65I=--


--===============2689065295717910731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2689065295717910731==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2689065295717910731==--

