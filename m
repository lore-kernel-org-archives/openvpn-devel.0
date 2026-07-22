Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7978C44536
	for <openvpn-devel@archiver.kernel.org>; Wed, 22 Jul 2026 14:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tGQ7aWotRZKqcNvbdXEQXoNUGdbF5bJSTZ4OdcqQ5RU=; b=Qr+FYzNj7XR7haxeZWopyh77x3
	KJoLpQCpOUrXnBl39qpdJ7cDKtdudlpbZYMUhy4Ln0ecuNARtJQvQXT1yRQg7EdWZ4yuEZ0m7Exha
	tJkTYZnkFc2GEaoq2CAOpHwTvH9PzVCnDj3Z7Wf3CNc0K3c6iRr6d2VXL7+dBUoCa3Y0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmXmA-0004QZ-Ga;
	Wed, 22 Jul 2026 14:18:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmXm9-0004QT-SL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:18:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=OES7ztT/gUNs+S6K297mPdFBJn3oT58+4EgvP2j9tPs=; b=G3VJVTLfhrLUl6hR0XnzOI486y
 3LNxTKJsgBQfZxRKm5YxUfixrpsKKW8kiDnyCUaUWTaAUjQwRttrrlhzrDH+CC+dQXXIu11fHXkGH
 yDHKosbbgjdsc/sB7ffkLy4AJPR/bs8BqiDXUO8oUczL23JwhYe5nBh2x4PRDUzNdjT0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OES7ztT/gUNs+S6K297mPdFBJn3oT58+4EgvP2j9tPs=; b=k
 lmaBZKEBQgQhjJKcVDzNN4ebCNkJEMqSxX+MmgNW6+YCcpQ8aIudrZGaeyEeLfHsCJh2M2hg+x/BJ
 QsLxMYNdM/uQOVIRYs0fWndSU7pjthtGzHi3qG/f3EInervqiCUjhve4l+YafiF69P0udtIfcJU5b
 yyGTIbVzROdrtisc=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmXm7-0001Ly-6Z for openvpn-devel@lists.sourceforge.net;
 Wed, 22 Jul 2026 14:18:22 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f878135e0so458783f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 22 Jul 2026 07:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784729893; x=1785334693; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OES7ztT/gUNs+S6K297mPdFBJn3oT58+4EgvP2j9tPs=;
 b=RSJnUzV7OoJzhoPwvjO8P/Qq8YW1dgwqeLXzd8FvTw0zQTUolleXiY75s7loLCib+F
 /fpnhokP+yGbt/Oz6weMnF2U2g+doe/Ahg+cf3apWJjj2xVsCdUZL8XBRj8WIEQTtJhs
 CAYIOM24orutER1qyTRl47rxHm8tnz2y8pLRok4ncyrnJy/2QecjsiUon4G/nZzFCCzo
 kmQrMSF4wvh9zPQIcPa0oG8QI4DMMCnGXGgR6gcGotACuZDBcqbBbmXjhvSQwsFo3L/6
 PKEfDhSpF3W67pu6me4E5qBk58aqTVHshw8cJBCT3YA4ItWbInD+1D4cQVTurYblHD/U
 ZIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784729893; x=1785334693;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OES7ztT/gUNs+S6K297mPdFBJn3oT58+4EgvP2j9tPs=;
 b=mxdpTPEYFlJTa7xv+YTfww+SPtDaxEYkqe0BVT6UxzTRFFv3o6wepxwMxpm57lIMxS
 BohUUSo4rCEKUhWPqoWHG+4HdLO1olYQjIZJNhAx35n/hKmNEf1IlKLRo3PzCIC8dYKD
 Bi84a3A1RAQI6F7WI1qTNWOMQK3FpL4xY0Z2i8p+PHHbqmhuu7LTnIFiomGyLpUtOxt5
 DaLyxGBfe4UfLXcL+yxQ4kCGXWEsN8zzSCv3SnTtJGb+aATG/IvcPx9oMvzU+7gbhMFS
 YD9jQhkxJ2zCvIn7quBhDr8dlBO6V/ZcYedofdf5Alezn/N2UYkBa/JVsK7cVzQ/eP4z
 LagA==
X-Gm-Message-State: AOJu0YwniujClf7XI1I7wgDwPqUHqrXGbYg8+9Khe9GE4xZqmBrL/jXT
 MBz0DmXzczG1o8mZa+QrsYBXGjPYOhrQ7dsOVAmOoBh5w6ZHfBXVKy51QGAkBdxr10U3L/5if2H
 En2Dr8wLA8OnxcATyncy6WqkGQZ9b6eApG3EYuj4IHjl0wZDBrqhh2DzKzIt7dmrkLGfRuc8udR
 Ll34aZbQ==
X-Gm-Gg: AR+sD13Gdp97zqg1Mh6Q4ZCYPH1eYik41RE/NMDiUHvCF5e/hev2BLP3VMCWlq6mRYK
 R2XiiEqngO7o9oluU1Tou1zka1cOQtTsmIJbOy5B+JIdHJrdQl9dYgm5J+DnEthAkue53is67le
 erPugazU7KlVTB4bvplCdX8AGvq2oi9byXBbYKKg7lAianRcjab/tbDisiaEtEiKOXuB/oRHud/
 roSRrRU9DxpKw+/HdN+hC+5dQ9dOn2l4/uKA+XA1VTXPmQCdJkRQ7IYti5pzecGIAP7JBxZqKHV
 FPEeuTxNl9XT1uMBNMVG2p1ju2m4KuWFUr6v+8dKx9HT++6qtqVppHRXQgz8NHIHnF+KBlsqoBS
 G1ojhzVK2u/mnSmWu+WnFpOnbET3EEj8LuAhsXJlv3nvjGjZiGKrmJvii5HIzRGma+6osXmT4z9
 WabkwF1LHzM8KOd5qOYmzXtDWkMBYIJj5ipUFv6KvObhVvlWqeeZA1/JCso6xcD9U7vDwwUhimM
 FSV29acUMQRMq8Lr7qsSVY+NHU+/rZ2CKeWI7gAw8BDosVdmPQDu7FmNoKH1OUq8kSj
X-Received: by 2002:a05:6000:310f:b0:47f:83f8:a956 with SMTP id
 ffacd0b85a97d-47f83f8ac9cmr5558089f8f.37.1784729891540; 
 Wed, 22 Jul 2026 07:18:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a5c4sm6136083f8f.8.2026.07.22.07.18.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 07:18:11 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 22 Jul 2026 14:18:09 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: a2901aa47740548f95755da585d8bb26f97ba8ca
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <815444441d63908f79e45ef3c5d9782a0b4398ec-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmXm7-0001Ly-6Z
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Only announce
 support push updates/IV_NCP when actually supporting it
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3055181114660713123=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3055181114660713123==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BnR+dAhcf2A="; charset=UTF-8

--BnR+dAhcf2A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello cro=
n2, flichtenheld, 

I'd like you to reexamine a change=2E Please visit

   =
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail

to look at the=
 new patch set (#8)=2E

The following approvals got outdated and were remov=
ed:
Code-Review+2 by flichtenheld


Change subject: Only announce support p=
ush updates/IV_NCP when actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Only announce support push updates/IV_NC=
P when actually supporting it

Currently even p2p clients that do not accep=
t push message, so announcing
PUSH UPDATE or DNSv2 is not very useful=2E

T=
he change for IV_NCP is more a documentation bugfix as in mode server
we cu=
rrently never have push_peer_info_detail > 0=2E

But change the message to =
indicate that IV_NCP nowadays is more a
legacy variable and replaced by IV_=
CIPHERS=2E

Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Signed-off=
-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M src/openvpn/ssl=2Ec
1 file cha=
nged, 14 insertions(+), 16 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/34/1634/8

diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index 60df7ce=2E=2E98b09cf 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1914,21 +1914,21 @@
         /* s=
upport for P_DATA_V2 */
         int iv_proto =3D IV_PROTO_DATA_V2;
 
-    =
    /* support for the latest --dns option */
-        iv_proto |=3D IV_PRO=
TO_DNS_OPTION_V2;
-
         /* support for exit notify via control channel=
 */
         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;
 
-        /* currently=
 push-update is not supported when DCO is enabled */
-        if (!session-=
>opt->dco_enabled)
-        {
-            /* support push-updates */
-    =
        iv_proto |=3D IV_PROTO_PUSH_UPDATE;
-        }
-
         if (sessi=
on->opt->pull)
         {
+            /* support for the latest --dns opti=
on */
+            iv_proto |=3D IV_PROTO_DNS_OPTION_V2;
+
+            /* =
currently push-update is not supported when DCO is enabled */
+            =
if (!session->opt->dco_enabled)
+            {
+                /* support =
push-updates */
+                iv_proto |=3D IV_PROTO_PUSH_UPDATE;
+     =
       }
+
             /* support for receiving push_reply before sending
=
              * push request, also signal that the client wants
           =
   * to get push-reply messages without requiring a round
@@ -1943,20 +1943=
,18 @@
 
             /* support for tun-mtu as part of the push message */=

             buf_printf(&out, "IV_MTU=3D%d\n", session->opt->frame=2Etun_m=
ax_mtu);
-        }
 
-        /* support for Negotiable Crypto Parameters =
*/
-        if (session->opt->mode =3D=3D MODE_SERVER || session->opt->pull=
)
-        {
+            /* legacy support for Negotiable Crypto Parameter=
s (deprecated in
+             * favour of IV_CIPHERS) */
             if (=
tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
  =
               && tls_item_in_cipher_list("AES-256-GCM", session->opt->conf=
ig_ncp_ciphers))
             {
                 buf_printf(&out, "IV_NCP=
=3D2\n");
             }
         }
-        else
+        else if (session=
->opt->mode !=3D MODE_SERVER)
         {
-            /* We are not using p=
ull or p2mp server, instead do P2P NCP */
+            /* If we are not usi=
ng pull we announce P2P NCP support */
             iv_proto |=3D IV_PROTO_=
NCP_P2P;
         }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1634?usp=3Demail
To unsubscribe, or for help writing mail filters,=
 visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Gerrit-Change-Number: 1634
G=
errit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld =
<frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--BnR+dAhcf2A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>plaisthos <strong>=
uploaded patch set #8</strong> to this change=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><p>Th=
e following approvals got outdated and were removed:
Code-Review+2 by flich=
tenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">Only announce support push updates/IV_NCP when act=
ually supporting it<br><br>Currently even p2p clients that do not accept pu=
sh message, so announcing<br>PUSH UPDATE or DNSv2 is not very useful=2E<br>=
<br>The change for IV_NCP is more a documentation bugfix as in mode server<=
br>we currently never have push_peer_info_detail &gt; 0=2E<br><br>But chang=
e the message to indicate that IV_NCP nowadays is more a<br>legacy variable=
 and replaced by IV_CIPHERS=2E<br><br>Change-Id: I0737b769e78e6d271ec874cad=
b9fbd81bfefdec1<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<b=
r>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 14 insertions(+), 16 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:2=
9418/openvpn refs/changes/34/1634/8</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec</span><br><span>index 60df7ce=2E=2E98b09cf 100644</=
span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/=
ssl=2Ec</span><br><span>@@ -1914,21 +1914,21 @@</span><br><span>         /*=
 support for P_DATA_V2 */</span><br><span>         int iv_proto =3D IV_PROT=
O_DATA_V2;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        /* support for the latest --dns option */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        iv_proto |=3D IV_PROTO_DNS_OPTIO=
N_V2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
>         /* support for exit notify via control channel */</span><br><span=
>         iv_proto |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* currently push-upda=
te is not supported when DCO is enabled */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (!session-&gt;opt-&gt;dco_enabled)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            /* support push-updates */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            iv_proto |=3D=
 IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>         if (session-&gt;opt-&gt;pull)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* support =
for the latest --dns option */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            iv_proto |=3D IV_PROTO_DNS_OPTION_V2;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            /* currently push-update is not supported=
 when DCO is enabled */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!session-&gt;opt-&gt;dco_enabled)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                /* support push-updates */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                iv_proto=
 |=3D IV_PROTO_PUSH_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>             /* support for receiving push_reply before =
sending</span><br><span>              * push request, also signal that the =
client wants</span><br><span>              * to get push-reply messages wit=
hout requiring a round</span><br><span>@@ -1943,20 +1943,18 @@</span><br><s=
pan> </span><br><span>             /* support for tun-mtu as part of the pu=
sh message */</span><br><span>             buf_printf(&amp;out, &quot;IV_MT=
U=3D%d\n&quot;, session-&gt;opt-&gt;frame=2Etun_max_mtu);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        /* support for Negotiable=
 Crypto Parameters */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER || session-&gt;opt-=
&gt;pull)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* legacy =
support for Negotiable Crypto Parameters (deprecated in</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+             * favour of IV_CIPHERS) */=
</span><br><span>             if (tls_item_in_cipher_list(&quot;AES-128-GCM=
&quot;, session-&gt;opt-&gt;config_ncp_ciphers)</span><br><span>           =
      &amp;&amp; tls_item_in_cipher_list(&quot;AES-256-GCM&quot;, session-&=
gt;opt-&gt;config_ncp_ciphers))</span><br><span>             {</span><br><s=
pan>                 buf_printf(&amp;out, &quot;IV_NCP=3D2\n&quot;);</span>=
<br><span>             }</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        else if (session-&gt;opt-&gt;mode !=3D MOD=
E_SERVER)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            /* We are not using pull or p2mp server, instead=
 do P2P NCP */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       /* If we are not using pull we announce P2P NCP support */</span><br=
><span>             iv_proto |=3D IV_PROTO_NCP_P2P;</span><br><span>       =
  }</span><br><span> </span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail">change=
 1634</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1634 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; <=
/div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-dev=
el@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit=
-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--BnR+dAhcf2A=--


--===============3055181114660713123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3055181114660713123==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3055181114660713123==--

