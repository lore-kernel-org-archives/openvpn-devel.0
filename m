Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D0C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 14:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTlpG/VmHysZadx6Z/RTaRxlCeMczcvCMlXfXCEiog0=; b=e477Q5jyyuU2fuKvy8ZMk4lp+Z
	xnmbZOEaY/RaHPVw4pdn5K+t6gyy8SOn5oN/lfjymYbqxL/JtqcmqFiODBcC4n0kbNnrGGk1ULWDw
	3tKIzNK3/9UvHnOHnWQtNq0FNRSQb8q/eMKzfbswlj2FycIPccXK1gK4LGjw+/Cc0wT8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuWYi-0001vJ-2T;
	Thu, 13 Aug 2026 14:37:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuWYg-0001v9-VC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:37:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=2ce2Df1vcfrdnuPyeOQSymG4veGL6JmBHcNOw14wcik=; b=eRP8iHVstNhHJYPkFnuR1/wl7F
 lJOuPhN14/CQFQ0cULt2rB4xcvBw3DmE1ihU05i0iMyYpl+BsNvDsPJ/XBNoZwTCguid7zilVGcDJ
 afuppoHX0eth/kNHMEYpiWsbQHz2C74gEUJ3eXZkjJYqvk+nx7EYUaqONWMFj+/v+5ak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2ce2Df1vcfrdnuPyeOQSymG4veGL6JmBHcNOw14wcik=; b=K
 zfZQTzK8RjreRvDYfDgmzhuo0idCR6s0yGp0NpqoAG/+n1r74PQEUo2jXVsRQV54e5EfaQoINMFzm
 H0EKokcdoUr3OGRQVHtHfA6k/4SExOoYvDCv04a3zOFTP/HBIl3qC+KTCUhEE3H7u7lg+F2z5TLqC
 hBdxlCTDh9uOE0yo=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuWYj-0003dt-QH for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 14:37:27 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47fe89fb333so1280035f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 07:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786631840; x=1787236640; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2ce2Df1vcfrdnuPyeOQSymG4veGL6JmBHcNOw14wcik=;
 b=Evb2Lb4WB4TVwCGaBu5LBKn9FLZ9rXY7/3mGysz1FQG3N5+5YeMHUPUrUZB23l2Ik1
 WJw4JDV2whwgajonIbX6Asurb52Bw0YiBxtOKzxQ8aceSdEY5uT/BSE3ukpgjZ9zbm2w
 FCp5tQ985GjsjX9E9W1DvUUGq5VY7GoFMAdGi2C4+b2p5jsEnnjGaF7OwF5bTs9evjhO
 pk/EZOgxeKllmay871Z9vUIb524D2q0Aw/0x1KH5W3ExCl+oNRXmYYAtgH82Ol4Au9ym
 P6Uh9J8LuSu4pykxJR+hw7SCHTSJ7rTSO07zpvNw2QeQbhPEKIqSsrEw/P1UrkOElBoi
 ZZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786631840; x=1787236640;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=2ce2Df1vcfrdnuPyeOQSymG4veGL6JmBHcNOw14wcik=;
 b=Vbr+NynZg3LeR20h6IN67oEmtke32OEfP55RthGsaywtV5aL65UNezVzGIj8KwEUFi
 mBgHUSSWUYfAdD9EtTwpWF++fxkJkYKXKx8ZG1yIm7vcC9TOwRugHS1xx7cLql12v9X5
 6zutm1e85TLlpMGbMf3OTmi7ltk7yLKf+R9ppUVapBc1X7+i/3X/fFeh5VY+2OK4dxM0
 Y7kDiylOHv0YOnDszt3C6MxlOlT380hw+qIWb2XhKebOW8hDPB7gjQyTi4ct3XZm4RYM
 6C/i+QdHfKwAHCpgWUoR5GQAscDzG1xgOqtdF4lvpSgqSqb5CHfrWd187bFLLpQc2sq4
 9Ucg==
X-Gm-Message-State: AOJu0Yz2vcTlAllpc0iQAgYqWRh5+qVk8kXg1iu9PE53RbHvitkYJM78
 H72lD/R6iIXDxE31CueOFHrf7S0Cm6CyYEJWTq45NfljIWHpeai1+2xihT7eZX4V/mDqu98gouT
 YZQCZMNAauhfK0RyMkQCaOPvRJPyiAHwpaLDzqydVetckeAQUOIEh1YIYSrsHavcfd4tu2qu/tR
 r9M3TqbQ==
X-Gm-Gg: AR+sD12XUDgTHxEdKUnyXHTSkMTufbQLTCFPZihAyZ86nckpp2eAuIsXH01f4bEJWFO
 yirs4m5C5yli9S6MAXflYdG1Ym14wYIZo5PU85doBcLAUELRV/2OUj1c+heg1FUx4sbA46EAIJ9
 MI9sKE+cYqqZG8YasrfsYd1RJ60pvuR1ImsR1KXy9QKawMKxuvs2qm0wuce8QyQGpM4ugDkpXPz
 UJ7e2SmaC7d/ZlARq2WZljaoA2a5kDE46hOSzm6NXJpMWGhAejXDcjMxk6esqvaNejz8SKNgoY9
 7d90CMqNfg0ycuBiJLR1HB0Hqx2DWCJf4Yo4y+RNPEYRDVqG4t60xcy1DrNMZXgIiGTZeHryB38
 dCS1++T9YFLZQo/2RiFU5Pswd2WAVY+ScO0NQvqgJB08AGzw/3kw3C0wccwFBhQj/mH/r8fLqB1
 yLBQcC/dvTo1RAMWf519zU/0D/TbsUXwTLZ48Vw3D53zydfrvgYA8SS1uNUHNZeGbqxSGo7T/GK
 KpP0HLBF43CCrYMNQWOAC02pnWPvhfJFlZ9LdqEZ2gFyN890DEFa5H/wIa1OxW0VxQls24knuHQ
 pR4HkgnqgXZRpC/b/xQ4QFE+ZIvKuEg6f+uBxn1ihlSIO8HWKPaeBFRCj80FQ0c=
X-Received: by 2002:a05:6000:310f:b0:47f:e729:c588 with SMTP id
 ffacd0b85a97d-48159eea056mr8486597f8f.14.1786631839515; 
 Thu, 13 Aug 2026 07:37:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a569325sm7421249f8f.14.2026.08.13.07.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 07:37:18 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 14:37:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5
X-Gerrit-Change-Number: 1842
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1842?usp=email>
X-Gerrit-Commit: 800ba2cfccf2173c466f9b57381bb6244110117f
In-Reply-To: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
References: <gerrit.1786540865000.Ia2e238a41526ebc178c53d3807103d8b9da475a5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NTQwODY1MDAwLklhMmUyMzhhNDE1MjZlYmMxNzhjNTNkMzgwNzEwM2Q4YjlkYTQ3NWE1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0b9ee18c4420a211a924d4052d980433aaf7ad6f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuWYj-0003dt-QH
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix extracting
 IV_MTU
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
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4068002079252351327=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4068002079252351327==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9AXW28VurVE="; charset=UTF-8

--9AXW28VurVE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3Demail =
)

The following approvals got outdated and were removed:
Code-Review+2 by =
cron2


Change subject: Fix extracting IV_MTU
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix extracting IV_MTU

Commit 06ced3fd a=
ccidentally broke extracting the MTU from the peer
info while refactoring t=
he code=2E Before 06ced3fd the code used
iv_mtu as temporary string and ext=
racted the value into client_max_mtu=2E
The new code never set client_max_m=
tu and used iv_mtu as integer instead=2E

Fix this by setting client_max_mt=
u again with the real MTU value from
the peer=2E

Change-Id: Ia2e238a41526e=
bc178c53d3807103d8b9da475a5
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg=
>
Acked-by: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1842
Message-Id: <20260813055836=2E32422-1-g=
ert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel=
@lists=2Esourceforge=2Enet/msg38291=2Ehtml
Signed-off-by: Gert Doering <ger=
t@greenie=2Emuc=2Ede>
---
M src/openvpn/push=2Ec
1 file changed, 2 insertio=
ns(+), 3 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openv=
pn refs/changes/42/1842/2

diff --git a/src/openvpn/push=2Ec b/src/openvpn/=
push=2Ec
index 97f352e=2E=2E5b15f71 100644
--- a/src/openvpn/push=2Ec
+++ b=
/src/openvpn/push=2Ec
@@ -717,10 +717,9 @@
     }
 
     /* Push our mtu to=
 the peer if it supports pushable MTUs */
-    int client_max_mtu =3D 0;
- =
   unsigned int iv_mtu =3D peer_info_extract_uint(tls_multi->peer_info, "IV=
_MTU=3D");
+    int client_max_mtu =3D peer_info_extract_uint(tls_multi->pe=
er_info, "IV_MTU=3D");
 
-    if (iv_mtu !=3D 0)
+    if (client_max_mtu !=
=3D 0)
     {
         push_option_fmt(gc, push_list, M_USAGE, "tun-mtu %d"=
, o->ce=2Etun_mtu);
         if (client_max_mtu < o->ce=2Etun_mtu)

-- 
To =
view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2e238a41526ebc178c53d38=
07103d8b9da475a5
Gerrit-Change-Number: 1842
Gerrit-PatchSet: 2
Gerrit-Owner=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: cron2 <gert@green=
ie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--9AXW28VurVE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by plaisthos=
=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3De=
mail">View Change</a></p><p>The following approvals got outdated and were r=
emoved:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">Fix extracting IV_MTU<br><b=
r>Commit 06ced3fd accidentally broke extracting the MTU from the peer<br>in=
fo while refactoring the code=2E Before 06ced3fd the code used<br>iv_mtu as=
 temporary string and extracted the value into client_max_mtu=2E<br>The new=
 code never set client_max_mtu and used iv_mtu as integer instead=2E<br><br=
>Fix this by setting client_max_mtu again with the real MTU value from<br>t=
he peer=2E<br><br>Change-Id: Ia2e238a41526ebc178c53d3807103d8b9da475a5<br>S=
igned-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1842<br>Message-Id: &lt;20260813055836=2E32422-1-gert@g=
reenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-deve=
l@lists=2Esourceforge=2Enet/msg38291=2Ehtml<br>Signed-off-by: Gert Doering =
&lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/push=2Ec<br>1 file =
changed, 2 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/42/1842/2</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>i=
ndex 97f352e=2E=2E5b15f71 100644</span><br><span>--- a/src/openvpn/push=2Ec=
</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -717,10 +717=
,9 @@</span><br><span>     }</span><br><span> </span><br><span>     /* Push=
 our mtu to the peer if it supports pushable MTUs */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int client_max_mtu =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    unsigned int iv_mtu =3D peer_in=
fo_extract_uint(tls_multi-&gt;peer_info, &quot;IV_MTU=3D&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    int client_max_mtu =3D pee=
r_info_extract_uint(tls_multi-&gt;peer_info, &quot;IV_MTU=3D&quot;);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (iv=
_mtu !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(client_max_mtu !=3D 0)</span><br><span>     {</span><br><span>         pus=
h_option_fmt(gc, push_list, M_USAGE, &quot;tun-mtu %d&quot;, o-&gt;ce=2Etun=
_mtu);</span><br><span>         if (client_max_mtu &lt; o-&gt;ce=2Etun_mtu)=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3Demail">change 1842</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1842?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2e238a41526ebc1=
78c53d3807103d8b9da475a5 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1842 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt=
;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--9AXW28VurVE=--


--===============4068002079252351327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4068002079252351327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4068002079252351327==--

