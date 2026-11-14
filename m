Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465E8606A885
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hZYk5Cz3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WwA/fV7T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HLTeEsdX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=KtC2quHB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=vr/Ik77939h4IoamLnPBS9YZPs0kVGryWplg9z2WX/0=; b=hZYk5Cz3HW7GHpvlFUK1HonpGA
	lX7JMYkSzNYi0YaeRaPQTOF8Hr9TAQjS6+tiru4SncJXkoptmM6DRsom1HcnTFd9vg4JRR9WaF+SI
	8/z3okN3Vl3AReDikPjwR6q8/y8QOvdsehHD66MaHNYSdsWBwlVTnLi+T4tCMFDe4o1k=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGGK-000000006b7-47kL;
	Sat, 14 Nov 2026 16:05:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGGJ-000000006az-1STp
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:05:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YMSD5oCmhk9Y9QyeZsFqXipkZphij5VxU4SL95YXUkk=; b=WwA/fV7TDLbmSt1MawgGUyiO/x
 Ktif+VXCRpDF4k3FIDWcGkMK4xO9ttzRv6WmeisrAS4AZom9YVTviy7tJT54fVJ2klYymTLGzJu4T
 exqO/0gFyUf0d5ZOqGae2ZMPbBX+s3FGmWr3Rj+6BjydKPALgBSQx2EgU6739dLmJDpI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YMSD5oCmhk9Y9QyeZsFqXipkZphij5VxU4SL95YXUkk=; b=HLTeEsdX4UvXLmaLxh+9SMKwY/
 u2yRA0k916T7U9jjDBAJOIPp1u5+8j1NtONPW12t/Tdqy7p/S4Zxvod9mRSqtfFh1CpLIziCgRSLr
 ltqzimRA3X6QxrFN3Y6+pE33fr8Zc+doryJbACQoFsu38/wE1WaABkFMd2xfw/tqZHco=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGGI-000000001UK-2WAu for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:05:55 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso13409245e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794672348; x=1795277148; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YMSD5oCmhk9Y9QyeZsFqXipkZphij5VxU4SL95YXUkk=;
 b=KtC2quHBfuYq4qtjoIEeNQWWPybCpZS8jd4CaFY5EuO/yS6JJZFlLv8dNS3ZNaf1gg
 ZyolL7BV+gDKiQawJYqh5/CLC7GGlG9RKVh8Uj3GESn9phrmVMHhJXUBfdAoGwpk782Z
 /QI1IQVHa39LbkYTS/pbcz7mENQMlprK4tOuL2uw9+11r0brE/QqA8rzbZBwXUdJ8Y5u
 43igTyL9twjR8Aur4X9QCmMoNBWxcz1hxTueT/jyQR3Y1mLKsOsGu5aMpXO6URxXoqtC
 oNYKIM6cmfSS6j1SmVZ+IJOmqKx+CjIgNbP6/1ZsWOYjewmlEfZGARRPLjWz0JyQKQSt
 4UFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672348; x=1795277148;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YMSD5oCmhk9Y9QyeZsFqXipkZphij5VxU4SL95YXUkk=;
 b=gf43GriJvea440RwrjXZzX2mIBbUxj2zr1oOLZ/CUZogDBiQBo0rmEOenf0qCJJu2+
 LhF/DdiUoeWfrzBVmDfwQttLTTAhR5QSWJ2jm1w78faV/cqB9pqbd17VgF/sZ7P+pl6m
 HSH9tmFJkWRWUmmeu2IZQsy+f6EtoAgnnGDihq8sRy8UkTZqzQLa9yIiPFgQoOWMwU/L
 z2dUoeM1ZyqJ5UJ9iW5Hi9iD/aCg1LFcxAVo4A4U8zIe+jf9RITWUxw6R6ORyz/pm4Ry
 o/8e95kC82HwO6yvoGm2g46xkqpG3krrK2+2obk0Ak0uTuSIscjiRbATp4J91/oqUpyg
 JzdA==
X-Forwarded-Encrypted: i=1;
 AL+hErEwmdcIITk7rBxmIbZ8da7/X6vh+O1Be1qOZT/Rgo6ack0qX9TDT+5SLzNvIkDcBR1DtIQhZrpm6hqQbnBs@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8X9MXEfRjKd0bY5T7Ge7aDEV2UxHgYhsjwJ1n8SgYiFVNlADdK
 jL2rRr2y30I0rGtLR/oTBs7bQvyW2gjp66EWB5pZM2Cn1OVCRMmEKlc9tCPlNQGofNLIflJszsL
 KBxuP2EvNtFhOSR20w08t9RCZYQQCiGlBttPXRoLL4TXv9szc/4VHHgb20eyuz0VOkmIV
X-Gm-Gg: AYBFou30r1E5/8I0krkVnjnEVBNSRjBC+xQjlspZMyn8h6u8PUfN2dkHGqHAH8v/cRt
 QKVu6mEDmXBBpvD0bXaRrt1SFdw/9OVffjgi8DSeANqMZmqKjWcd0EHqMKvqi9IlnZhfKtg55Ry
 g4TLKmMPazZu6rtdxWaEIz/pYTOg+2qR6qRJwBcPrFOsI+9DW14a7DSnC/2GKSG+u1ecfON4Ypq
 lmv1jRDFpRZczDZT0NFFYB7xoA6rqxcGJuNaVB/unxEU4QyfFx+jhZ41UN3WPUS6PYwiKKQEmDd
 Vk/E/Yq3bs/zxhjTrdG/T/7Q7wSHazy+JsH9W1Nmn4FFXTepXxmS6F63fwramCs5zYYhfZcThzu
 J+lNHkTDnQMQWF5RIeJthwVzViq5HISv/1s6/1L9YEKoxotR9/yLS3iPprBRolBPJQuDjaS5Zo/
 ueiYFHnYDbvXAQV1Ch1vPMje4c3kHasQCvjpDaeNAGyydJNdApWvIkWnGi0RN4XLmdyNzmfW8+A
 +P6xSCUY+YYwxC8+yotdvT9SRon8SZHuV4JlyeMKsnU7PQC9YUZL/3C4zKtIZdLrDKz+wiWrFdP
 3QgIfah3aePEforYwHkCOMsi/ZRY/AMIyW17o0NgcNQTe41B9TXluYx579weFspW7MpbZp22EcN
 fVYRKrQs+f/WS0Pn2lIoJBXtgl2VJ4cyCTnl0Nl1nuLy1CSTCkurezMb3ka9jWiQKoxC7kNrLO6
 25plj7jCKIA6t+RQc=
X-Received: by 2002:a05:600c:8906:b0:4bb:5f07:10dc with SMTP id
 5b1f17b1804b1-4bb5f071358mr63056465e9.22.1794672347784; 
 Sat, 14 Nov 2026 08:05:47 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb56f8d054sm96897725e9.3.2026.11.14.08.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:05:47 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:05:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
X-Gerrit-Change-Number: 2123
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2123?usp=email>
X-Gerrit-Commit: ab8f651b98261d61ecfe4dcf194fec348d4beee0
In-Reply-To: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
References: <gerrit.1793779380000.I879cd0fe9b1fabb350e1c4558863480064d45903@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc5MzgwMDAwLkk4NzljZDBmZTliMWZhYmIzNTBlMWM0NTU4ODYzNDgwMDY0ZDQ1OTAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9107022fa988c856f56a6df74d00238ab21e6880-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGGI-000000001UK-2WAu
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: remove
 unused max() and gc from BSD get_default_gateway()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8431096106608107425=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8431096106608107425==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="y2v3GFa1rlI="; charset=UTF-8

--y2v3GFa1rlI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2123?usp=3Demail )

Change subject: route: remove unused max() =
and gc from BSD get_default_gateway()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

route: remove unused max() and gc from BSD get_de=
fault_gateway()

Both lost their last users when 76d11614 ("get_default_gat=
eway()
HWADDR overhaul") replaced the SIOCGIFCONF loop with getifaddrs()=2E=


Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
Signed-off-by: Razva=
n Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Em=
uc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123
Messag=
e-Id: <20261104105431=2E7011-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40674=2Ehtml
=
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/rou=
te=2Ec
1 file changed, 0 insertions(+), 6 deletions(-)




diff --git a/src=
/openvpn/route=2Ec b/src/openvpn/route=2Ec
index fa569fa=2E=2Ec812dac 10064=
4
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -3329,12 +3329=
,9 @@
 #define ADVANCE(x, n) (x +=3D ROUNDUP((n)->sa_len))
 #endif
 
-#defi=
ne max(a, b) ((a) > (b) ? (a) : (b))
-
 void
 get_default_gateway(struct ro=
ute_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
-    stru=
ct gc_arena gc =3D gc_new();
     struct rtmsg m_rtmsg;
     int sockfd =3D=
 -1;
     int rtm_addrs;
@@ -3536,7 +3533,6 @@
     {
         close(sockfd=
);
     }
-    gc_free(&gc);
 }
 
 /* BSD implementation using routing sock=
et (as does IPv4)
@@ -3705,8 +3701,6 @@
     }
 }
 
-#undef max
-
 #elif de=
fined(TARGET_HAIKU)
 
 void

-- 
To view, visit https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2123?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-M=
essageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: I879cd0fe9b1fabb350e1c4558863480064d45903
Gerrit-Change-Number: 212=
3
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>

--y2v3GFa1rlI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2123?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">route: remove unused max() and gc =
from BSD get_default_gateway()<br><br>Both lost their last users when 76d11=
614 (&quot;get_default_gateway()<br>HWADDR overhaul&quot;) replaced the SIO=
CGIFCONF loop with getifaddrs()=2E<br><br>Change-Id: I879cd0fe9b1fabb350e1c=
4558863480064d45903<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Ger=
rit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2123<br>Message-Id: &lt=
;20261104105431=2E7011-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2E=
mail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40674=2Ehtml<=
br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M =
src/openvpn/route=2Ec<br>1 file changed, 0 insertions(+), 6 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec</=
span><br><span>index fa569fa=2E=2Ec812dac 100644</span><br><span>--- a/src/=
openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><br><sp=
an>@@ -3329,12 +3329,9 @@</span><br><span> #define ADVANCE(x, n) (x +=3D RO=
UNDUP((n)-&gt;sa_len))</span><br><span> #endif</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define max(a, b) ((a) &gt; (b) =
? (a) : (b))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> void</span><br><span> get_default_gateway(struct route_gateway_inf=
o *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_=
new();</span><br><span>     struct rtmsg m_rtmsg;</span><br><span>     int =
sockfd =3D -1;</span><br><span>     int rtm_addrs;</span><br><span>@@ -3536=
,7 +3533,6 @@</span><br><span>     {</span><br><span>         close(sockfd)=
;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><sp=
an> /* BSD implementation using routing socket (as does IPv4)</span><br><sp=
an>@@ -3705,8 +3701,6 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef max</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #elif=
 defined(TARGET_HAIKU)</span><br><span> </span><br><span> void</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2123?usp=3Demail">change 2123</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2123?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: I879cd0fe9b1fabb350e1c4558863480064d45903 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 2123 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> =
Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert D=
oering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--y2v3GFa1rlI=--


--===============8431096106608107425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8431096106608107425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8431096106608107425==--

