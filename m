Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45EDCD4F3C
	for <openvpn-devel@archiver.kernel.org>; Tue, 19 May 2026 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=wxUGkbenIfo/Wt8WxaZ82LHuZWcC/tkNK+IOjjMyz9I=; b=gZa8PvWn5WTpdo
	QyA0cm4i62qxX5lFpCwFIkht8+tUJPTZ6f79QAlgmK/4IruZyyR3gx8JtLMf2QroNJ/tSuDctQFNE
	K/3/TLm/FtU6Q0qqsIN4gNlWS66rJBYH6VCVLMFreK/zh4iofXM36SCGbhHU13UoX0GVZ0/G/5dWi
	XsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wPKcH-00069u-Oo;
	Tue, 19 May 2026 13:36:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wPKcH-00069o-2o
 for openvpn-devel@lists.sourceforge.net;
 Tue, 19 May 2026 13:36:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KGVb4R0hF/pYQKT2IMQx+5LDo+tedVmrN8jw0lvCB14=; b=Plote6zhW1U9rZnkcWrE19+UVM
 bOXVmW1qAsjL+jFHoyfnQg9u1atoZmCwd8LGBaPg4asTjMDk4VR809lWgofGnNVOdanr/QGAEyOki
 LZWi5idNYCitVbt0ZRvWLOIqXecU2GVLEqFylZPgA8vTT6qA92HjEdt+8orGM+NuN75g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KGVb4R0hF/pYQKT2IMQx+5LDo+tedVmrN8jw0lvCB14=; b=k
 qT3w/fkiUKYoPaVlwnibiyLWUdg7nl3ADdXctYu4Oliofje1aU9B0WMiB83e8ij+uYjo1LJbMK89H
 Hn0TU1gHzyj8AWeLJZNVLQDTrHsaeXmfBRd6natY7T0ehPdmBTi/ih0MicX4mc70v0zTyoNcbCqD1
 662eQ+9YiVmKTrxE=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPKcC-0006cp-6k for openvpn-devel@lists.sourceforge.net;
 Tue, 19 May 2026 13:36:10 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so42473385e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 19 May 2026 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1779197757; x=1779802557; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KGVb4R0hF/pYQKT2IMQx+5LDo+tedVmrN8jw0lvCB14=;
 b=RwYd4jm58pJiJiU3jWQM/dd96ju/3jC+hQ3Yu54rVuu514O/Ca1aNSi5McRV5a3dzi
 tghb8jzD2kktO8dSylekPgV+rhCjMqAxwzmraWCY+ZtMJ4351aL+gMCja/7TTbyHdTl5
 dzjIojUu80O525rbwBqWqlRdXrKfKjeOebYJtvkPYBGKRWBaHkTd0GWrXZQLsdXYzjE/
 uWx5aGGohsx4r8rVmRkV3TE6b2CYvjxiTHgAaCPKsxdwSgeWnWioicGXfskfB1abLmxw
 JzZw5Kt6c7ycH3X9EA12Y6xljy/YGBsyOnO3pwNwispv7m/skxtYKx5TDNWf0TT7KCGQ
 9yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779197757; x=1779802557;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KGVb4R0hF/pYQKT2IMQx+5LDo+tedVmrN8jw0lvCB14=;
 b=QMQI6hYl/nP1ELAlwUNS0ki8FtuDnEUdeApIvgwJXpYFnR7LTjL/e5Ok2xNgfp90qF
 28nepbD/GVFWjeFeGLggbhDD4BO8FWg6QD9TEtLY5OInHrrP2XADOAJC2gTlS3MvKPs0
 jzcoIDlp6+5jUDyTfrAYJ6V2dVD4riO/go69f3KwDzH8fxcfHnDeJ5hOu37+JMaGI7y0
 h03GDO0AtGIcja2zDi7+GQ0FKNbE51xM/EPdX+Je3AEEYnjzg1AHlT2G+Wkp3qpppAgu
 D7cCJgMwFw5RURoaJy38rcJYMb4c8zqXZ/66ALRUWx0jsmRqJjEnZv5rRepVKGCkqiS9
 rgBA==
X-Gm-Message-State: AOJu0YyHgHFEtbaaesGxAefl+9ojaE1TTevAj/m1TfTJqVlRKTSfWPfU
 Jow/x0yKbfoT1oDDQ8iPVJWtdY9Af1cJpctEpVBQyRqReZ8lDV95bBuVVyNDYJXFNz3bpmPJuRN
 1MdN2cdChmxzFZuFMYxoQUlCwjvVpKnyjhLCrsqDSHCWcSBtz/KwbcIK4W4KPxhY9rmVQk/SL7q
 +Dzscb/w==
X-Gm-Gg: Acq92OHJXJY4g1vhpunrhUz8v9VA3Nbg6QaHhExOH0R99o9yVH+/WvQznYYmqygBYn2
 DaDRvrALlmh7W0RkHNOO1prQxbNznemYGEa54mY4ZIO5kAKHwr5G2BKXNL6hAS0IoPOZTJVpU1m
 D/HWdR4VCR71PR17RRKRoCjNViTZiA8E8UnyjyK1uJsTZ3+8lFxR9RKXSvMXJMu8DAAjCLOyewg
 SKbISuhgMxFTsHgkoF7fGEN3NzW+xHmWDwnC0emtXK9VLVcnywHgwQNhw09llnko23szGdOwMJb
 CdTZ7UqFVSd5DEdLKOcFFAnvMxyIt3ON7iOxUVM3/IlZ+vboVCnO0OscSBE+5Wdrq5bq/HLbCRt
 Q3HSyXluJQhcYH0SjNwGPrHJs9M9csUaPfE+nqoqo9vD76+5dSXbHd2M6lI5JWhH7B6uUYKruvf
 gwYpORInkliM/O3Pol1jXJJXOlzt8rXVX3zbERGFMoqIXKtxu7oDUK6eu9RAhkuaxAaiy3y4uba
 yZPTMPwGcaOH+ju6h5R6hbYh0KKMK3wel6yRKxvziAC37L+FNvCtuqJVVGvr9/BEEMQ5r6dsGoW
 /mWUb0eTBahK4g==
X-Received: by 2002:a05:600c:8905:b0:48e:5d91:cffb with SMTP id
 5b1f17b1804b1-48fe60e7d6emr251143705e9.10.1779197756939; 
 Tue, 19 May 2026 06:35:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe6faeasm107627795e9.26.2026.05.19.06.35.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 06:35:56 -0700 (PDT)
From: "ordex (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 19 May 2026 13:35:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I4068bf8175c23151298d142dc920ab89f861a411
X-Gerrit-Change-Number: 1681
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1681?usp=email>
X-Gerrit-Commit: 23e9873e15a43ad7673628a6f7d9dadfa906b931
References: <gerrit.1779197752000.I4068bf8175c23151298d142dc920ab89f861a411@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MTk3NzUyMDAwLkk0MDY4YmY4MTc1YzIzMTUxMjk4ZDE0MmRjOTIwYWI4OWY4NjFhNDExQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <690174471a070dba7646eca76ad8637e0a3bfb44-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wPKcC-0006cp-6k
Subject: [Openvpn-devel] [S] Change in openvpn[master]: clinat: do not
 adjust UDP checksum if zero
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5076652731129730050=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5076652731129730050==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="05pcZfQBw3U="; charset=UTF-8

--05pcZfQBw3U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1681?usp=3Demail

to review the following change=2E


Chang=
e subject: clinat: do not adjust UDP checksum if zero
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

clinat: do not adjust UDP checksum=
 if zero

As per RFC768, when the UDP checksum is zero, it means
it was not=
 computed by the source, therefore any NAT
processing along the way should =
leave the checksum alone
and not update it=2E
Failing to do so would result=
 in computing a bogus value=2E

At the same time, if the result of updating=
 a non-zero
checksum ends up being zero, as per the same RFC, we must
store=
 its one-complement (0xFFFF) as zero is reserved
for "checksum not computed=
", as mentioned above=2E

Ensure our Client NAT code follows both rules=2E
=

Github: closes OpenVPN/openvpn#1037
Reported-by: Jeff Salee <jeff@samjacks=
on=2Ecom>
Change-Id: I4068bf8175c23151298d142dc920ab89f861a411
Signed-off-b=
y: Antonio Quartulli <antonio@mandelbit=2Ecom>
---
M src/openvpn/clinat=2Ec=

1 file changed, 17 insertions(+), 1 deletion(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/81/1681/1

diff --git a/src/ope=
nvpn/clinat=2Ec b/src/openvpn/clinat=2Ec
index 32c1325=2E=2E3724022 100644
=
--- a/src/openvpn/clinat=2Ec
+++ b/src/openvpn/clinat=2Ec
@@ -258,7 +258,23=
 @@
         {
             if (BLENZ(ipbuf) >=3D sizeof(struct openvpn_iph=
dr) + sizeof(struct openvpn_udphdr))
             {
-                ADJUST=
_CHECKSUM(accumulate, h->u=2Eudp=2Echeck);
+                /* RFC 768: a U=
DP checksum of 0 means "no checksum computed"=2E
+                 * Do not=
 run the incremental adjustment over a non-checksum,
+                 * or=
 we will write a bogus non-zero value into the field=2E
+                 *=
/
+                if (h->u=2Eudp=2Echeck)
+                {
+            =
        ADJUST_CHECKSUM(accumulate, h->u=2Eudp=2Echeck);
+
+               =
     if (!h->u=2Eudp=2Echeck)
+                    {
+                     =
   /* RFC 768: a computed checksum of 0 must be transmitted
+              =
           * as 0xFFFF (one-complement), because 0 is reserved for
+       =
                  * "no checksum computed"
+                         */
+  =
                      h->u=2Eudp=2Echeck =3D 0xFFFF;
+                    }=

+                }
             }
         }
     }

-- 
To view, visit ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail
To unsubscribe, or=
 for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I4068bf8175c23151298d142dc920ab89f861a411=

Gerrit-Change-Number: 1681
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <antonio=
@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--05pcZfQBw3U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>ordex would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1681?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">cl=
inat: do not adjust UDP checksum if zero<br><br>As per RFC768, when the UDP=
 checksum is zero, it means<br>it was not computed by the source, therefore=
 any NAT<br>processing along the way should leave the checksum alone<br>and=
 not update it=2E<br>Failing to do so would result in computing a bogus val=
ue=2E<br><br>At the same time, if the result of updating a non-zero<br>chec=
ksum ends up being zero, as per the same RFC, we must<br>store its one-comp=
lement (0xFFFF) as zero is reserved<br>for &quot;checksum not computed&quot=
;, as mentioned above=2E<br><br>Ensure our Client NAT code follows both rul=
es=2E<br><br>Github: closes OpenVPN/openvpn#1037<br>Reported-by: Jeff Salee=
 &lt;jeff@samjackson=2Ecom&gt;<br>Change-Id: I4068bf8175c23151298d142dc920a=
b89f861a411<br>Signed-off-by: Antonio Quartulli &lt;antonio@mandelbit=2Ecom=
&gt;<br>---<br>M src/openvpn/clinat=2Ec<br>1 file changed, 17 insertions(+)=
, 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/81/1681/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/clinat=2Ec b/src/openvpn/clinat=2Ec</span><br><span>index 32c1325=2E=2E37=
24022 100644</span><br><span>--- a/src/openvpn/clinat=2Ec</span><br><span>+=
++ b/src/openvpn/clinat=2Ec</span><br><span>@@ -258,7 +258,23 @@</span><br>=
<span>         {</span><br><span>             if (BLENZ(ipbuf) &gt;=3D size=
of(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))</span><br><span> =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        ADJUST_CHECKSUM(accumulate, h-&gt;u=2Eudp=2Echeck);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                /* RFC 768: a UDP c=
hecksum of 0 means &quot;no checksum computed&quot;=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 * Do not run the increm=
ental adjustment over a non-checksum,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                 * or we will write a bogus non-zero valu=
e into the field=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if (h-&gt;u=2Eudp=2Echeck)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    ADJUST_CHECKSUM(accumulate, h-&gt;=
u=2Eudp=2Echeck);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    i=
f (!h-&gt;u=2Eudp=2Echeck)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        /* RFC 768: a computed checksum of 0 must =
be transmitted</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                    * as 0xFFFF (one-complement), because 0 is reserved for=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
      * &quot;no checksum computed&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                         */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        h-&gt;u=2Eudp=2Echeck =
=3D 0xFFFF;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          }</span><br><span>             }</span><br><span>         }</span=
><br><span>     }</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demail">change 168=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1681?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4=
068bf8175c23151298d142dc920ab89f861a411 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 1681 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio=
@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--05pcZfQBw3U=--


--===============5076652731129730050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5076652731129730050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5076652731129730050==--

