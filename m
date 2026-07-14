Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94A38C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jO+gD2XNnKQAL9XMef8wI+R0a6JnUaxXCyNp+cR5yS8=; b=btZn9MbjzGYwu9NhRRWVlG+8Ce
	0HlKK0jBETd7ry9cLYSDnNoAcDMmozHEn0QF30gDw5Rd4NgUiO8zglrNrl26Db789GigIf/HnUuNh
	SeAcih+B3a2qNYi6x9IhkN7nDRmCPFi0aYnc8OGwxl2WG/z7Xb5sdDdDsKX/dxDn/4wY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wjclN-0002sR-Ae;
	Tue, 14 Jul 2026 13:01:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wjclL-0002sK-U3
 for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KyQVJAK/H5bOWFNyRSrhdB7dDd9a7+SRWOb7omWDHWc=; b=aXnm+Dc/rYtcXnRIw8EyjAMj42
 sJSlj/6OMZREMTjHM4TOnHo30TN7fVGYA76Lr8xxAcP2+f5Je1kNMaDSu0Vb2LgagJ0yI4xCD+jQg
 /KjYWnwKdX5I/x7Q/oJF63YxOF9//tk6ByguJD9Ob4HoZKk+CyewYlJP60WsUnWyWlEg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KyQVJAK/H5bOWFNyRSrhdB7dDd9a7+SRWOb7omWDHWc=; b=k
 rtrpJk2UZNvSoKCa1WN99yYaEf+UGqyNxw8yv9F7f59CJ9Od+V0E8JP+413qLL+/BWwT3DG8gIEtJ
 gRQx9C9zP9R9xwq6fqhJtV7afMg+IxkjpBGLu2/0wTnu5hXNufptu4z+fOTtLT+z8HcCzbpKgyIEv
 3abBQTxoErVYgf0E=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wjclL-000287-5h for openvpn-devel@lists.sourceforge.net;
 Tue, 14 Jul 2026 13:01:28 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso4362556f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 14 Jul 2026 06:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784034076; x=1784638876; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KyQVJAK/H5bOWFNyRSrhdB7dDd9a7+SRWOb7omWDHWc=;
 b=dOBPG/Thm3WCSZawvXzb9/gxgW7iqfxoDXCT9fw5SxFoBd+iDAspKWaHRmmG9eOEvY
 9q+evgbWsWkYLmrYODWOOVVmF+hV7Bta5PWGhlBCt81jrL/KNCUHaaN2fjY2DzvZUxyz
 fwnDxtivWarSUsWc5VPKfzCjmeidyI3WSg/h+HZkBS/Zn6vo8S40EWfjY692SWKtJf9a
 8Km2ANBLAGSBzrS2FoxQoOQBJ3uKkK7r9gj2AasY3JqlTiipA7z5XeHu+5TBxOrqt0he
 tXWVkgFNKxNxFZPHuGHpCI+Ce9etQckki1YxB2bI8S78rsqnVg4BUv6us/ihXtsFOF0v
 OTYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784034076; x=1784638876;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KyQVJAK/H5bOWFNyRSrhdB7dDd9a7+SRWOb7omWDHWc=;
 b=DG1YjdX0SbzrzrlW75ZJe/iGmqj18391MEkmNEtvwOSk8z21OLuwNYn+Jvv8SdP+/N
 XTOJNfaisDxvHpV3Jdr9Oy2NdPBnh1nNrMbxe7/9I6LAzSyIP9SRDGjzF9YlFc7FHOYG
 IU72NFZK1uZFayk5QL6uSkxR9hollRAarVp7zUuoleU6W4RMJMbz+elfdyZDVzy5P7+U
 +mHX0v7pjaobSUa5ffc1ORXReHCWn+g9uplK/vAG481Yi+G0s4Js/i3fayzTcPjktile
 ZyhAKirYPUAyk9KFqW+Oh4Ju66ozUEbJ7vMrt93P1ym0LgZejHA/hea37qjmlmjXe7UH
 3PDA==
X-Gm-Message-State: AOJu0YyCXWM4lCBZG6Uxh696oKpb3CGRNBHSF7NxFTb48r5azLl7JfSj
 /UMTAbnkL5lEpaY52LvQd8DCBXgIdciQD8wBS97n+MXO8z7j4bwjWfiWr6A+69vT8G7RI0duSRA
 2zkv2AgM/h/PMrZxuCDcLTRfxdf5dw3wwEjI3iHLD35JCBIZ4U2/be3CV07z8K0s8kvXIJ6atvp
 Ki2l/PYw==
X-Gm-Gg: AfdE7cmtzckjl3b5okS7J/6FWaefscyo+hVOm49/RTtmecsOipfGS+f1+xZyWuaMg8L
 ghRhktk5wlQKyeYwYAprQfFP/3+1ReK4VJ7mke8rBHanQjgmGddEQwY83NxI0CRR/7nKxcZet8k
 UcjEakVTmkySOcMv/zKiJo9ISv5kkj8W9mfw590xCxix42uugQtXP/S9QzvKe4pFW2H8ts1i/Tq
 s4LSJfXV4Q//ZH2XrbbDvgCHiuqjAEzuDZjJxtCMs/QMs98mOtlnGJLJQMhrpUU37tA52SrV1RS
 3RX+rI5F3C+89wqlCnZE5ySKQcHZdrfmGeq5TB38QiljKo0N81oJk223uB5B2BOdDpg7UJtuanm
 fGo0F2gWLdoMFv0n8+Mbcqr9kGcUKXh9iciXuv/McJqtLaAiZ/t/JVU82CxXJWNvL/PFmowFO3E
 Qw/mSLgEU5PjaaKiXxRtI/GyqMMV8liHkHcFYpwTWwkOWDAHAH/xfRPldkKA9H9qIOE3g3VGT5e
 3lVfk3KOyeAKzzXl/mUs/5nW6elzHyu02BS+7piP5cHtGBPY7QPQdSQMDP97u/Ky/lbFHq5r22l
 G7gVdzk0JsWeAw==
X-Received: by 2002:a5d:5f48:0:b0:470:3edf:e28e with SMTP id
 ffacd0b85a97d-47f488486f8mr2916493f8f.10.1784034075037; 
 Tue, 14 Jul 2026 06:01:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e029sm8767018f8f.3.2026.07.14.06.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 06:01:13 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 14 Jul 2026 13:01:06 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
X-Gerrit-Change-Number: 1634
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1634?usp=email>
X-Gerrit-Commit: 5b5920448cc00a874e37d9a9d35b2c0d53df4295
In-Reply-To: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
References: <gerrit.1776768003000.I0737b769e78e6d271ec874cadb9fbd81bfefdec1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzY4MDAzMDAwLkkwNzM3Yjc2OWU3OGU2ZDI3MWVjODc0Y2FkYjlmYmQ4MWJmZWZkZWMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ddbd5b3d6ab570e684872bd2afae6b7b33c41ba0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wjclL-000287-5h
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3887713770042795702=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3887713770042795702==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2GiIs90sVxc="; charset=UTF-8

--2GiIs90sVxc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello flichtenheld, 

I=
'd like you to reexamine a change=2E Please visit

    http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1634?usp=3Demail

to look at the new patch set (#7)=
=2E

The change is no longer submittable: checks~ChecksSubmitRule is unsati=
sfied now=2E


Change subject: Only announce support push updates/IV_NCP wh=
en actually supporting it
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

Only announce support push updates/IV_NCP when actually suppo=
rting it

Currently even p2p clients that do not accept push message, so an=
nouncing
PUSH UPDATE or DNSv2 is not very useful=2E

The change for IV_NCP =
is more a documentation bugfix as in mode server
we currently never have pu=
sh_peer_info_detail > 0=2E

But change the message to indicate that IV_NCP =
nowadays is more a
legacy variable and replaced by IV_CIPHERS=2E

Change-Id=
: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Signed-off-by: Arne Schwabe <ar=
ne@rfc2549=2Eorg>
---
M src/openvpn/ssl=2Ec
1 file changed, 13 insertions(+=
), 15 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn =
refs/changes/34/1634/7

diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec
index bd43724=2E=2E2c57a36 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/=
openvpn/ssl=2Ec
@@ -1961,21 +1961,21 @@
         /* support for P_DATA_V2 *=
/
         int iv_proto =3D IV_PROTO_DATA_V2;
 
-        /* support for the=
 latest --dns option */
-        iv_proto |=3D IV_PROTO_DNS_OPTION_V2;
-
  =
       /* support for exit notify via control channel */
         iv_proto =
|=3D IV_PROTO_CC_EXIT_NOTIFY;
 
-        /* currently push-update is not su=
pported when DCO is enabled */
-        if (!session->opt->dco_enabled)
-  =
      {
-            /* support push-updates */
-            iv_proto |=3D =
IV_PROTO_PUSH_UPDATE;
-        }
-
         if (session->opt->pull)
       =
  {
+            /* support for the latest --dns option */
+            iv_=
proto |=3D IV_PROTO_DNS_OPTION_V2;
+
+            /* currently push-update =
is not supported when DCO is enabled */
+            if (!session->opt->dco=
_enabled)
+            {
+                /* support push-updates */
+     =
           iv_proto |=3D IV_PROTO_PUSH_UPDATE;
+            }
+
           =
  /* support for receiving push_reply before sending
              * push r=
equest, also signal that the client wants
              * to get push-reply=
 messages without requiring a round
@@ -1990,11 +1990,9 @@
 
             /=
* support for tun-mtu as part of the push message */
             buf_print=
f(&out, "IV_MTU=3D%d\n", session->opt->frame=2Etun_max_mtu);
-        }
 
-=
        /* support for Negotiable Crypto Parameters */
-        if (session=
->opt->mode =3D=3D MODE_SERVER || session->opt->pull)
-        {
+         =
   /* legacy support for Negotiable Crypto Parameters (deprecated in
+     =
        * favour of IV_CIPHERS) */
             if (tls_item_in_cipher_list=
("AES-128-GCM", session->opt->config_ncp_ciphers)
                 && tls_i=
tem_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
      =
       {
@@ -2003,7 +2001,7 @@
         }
         else
         {
-       =
     /* We are not using pull or p2mp server, instead do P2P NCP */
+      =
      /* If we are not using pull we announce P2P NCP support */
          =
   iv_proto |=3D IV_PROTO_NCP_P2P;
         }
 

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1
Ge=
rrit-Change-Number: 1634
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--2GiIs90sVxc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>plaisthos <strong>uploaded patch=
 set #7</strong> to this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1634?usp=3Demail">View Change</a></p><p>The change is no=
 longer submittable: checks~ChecksSubmitRule is unsatisfied now=2E</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Only announce support push updates/IV_NCP when actually supporting=
 it<br><br>Currently even p2p clients that do not accept push message, so a=
nnouncing<br>PUSH UPDATE or DNSv2 is not very useful=2E<br><br>The change f=
or IV_NCP is more a documentation bugfix as in mode server<br>we currently =
never have push_peer_info_detail &gt; 0=2E<br><br>But change the message to=
 indicate that IV_NCP nowadays is more a<br>legacy variable and replaced by=
 IV_CIPHERS=2E<br><br>Change-Id: I0737b769e78e6d271ec874cadb9fbd81bfefdec1<=
br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M src/o=
penvpn/ssl=2Ec<br>1 file changed, 13 insertions(+), 15 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/34/1634/7</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/=
ssl=2Ec</span><br><span>index bd43724=2E=2E2c57a36 100644</span><br><span>-=
-- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><b=
r><span>@@ -1961,21 +1961,21 @@</span><br><span>         /* support for P_D=
ATA_V2 */</span><br><span>         int iv_proto =3D IV_PROTO_DATA_V2;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* support for the latest --dns option */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        iv_proto |=3D IV_PROTO_DNS_OPTION_V2;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* sup=
port for exit notify via control channel */</span><br><span>         iv_pro=
to |=3D IV_PROTO_CC_EXIT_NOTIFY;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        /* currently push-update is not suppor=
ted when DCO is enabled */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (!session-&gt;opt-&gt;dco_enabled)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            /* support push-updates */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            iv_proto |=3D IV_PROTO_PUSH_U=
PDATE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         i=
f (session-&gt;opt-&gt;pull)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            /* support for the latest -=
-dns option */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       iv_proto |=3D IV_PROTO_DNS_OPTION_V2;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            /* currently push-update is not supported when DCO is ena=
bled */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if (!session-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                /* support push-updates */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                iv_proto |=3D IV_PROTO_P=
USH_UPDATE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>             /* support for receiving push_reply before sending</span><b=
r><span>              * push request, also signal that the client wants</sp=
an><br><span>              * to get push-reply messages without requiring a=
 round</span><br><span>@@ -1990,11 +1990,9 @@</span><br><span> </span><br><=
span>             /* support for tun-mtu as part of the push message */</sp=
an><br><span>             buf_printf(&amp;out, &quot;IV_MTU=3D%d\n&quot;, s=
ession-&gt;opt-&gt;frame=2Etun_max_mtu);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* support for Negotiable Crypto Parameter=
s */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (sessi=
on-&gt;opt-&gt;mode =3D=3D MODE_SERVER || session-&gt;opt-&gt;pull)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            /* legacy support for Negot=
iable Crypto Parameters (deprecated in</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+             * favour of IV_CIPHERS) */</span><br><span>=
             if (tls_item_in_cipher_list(&quot;AES-128-GCM&quot;, session-&=
gt;opt-&gt;config_ncp_ciphers)</span><br><span>                 &amp;&amp; =
tls_item_in_cipher_list(&quot;AES-256-GCM&quot;, session-&gt;opt-&gt;config=
_ncp_ciphers))</span><br><span>             {</span><br><span>@@ -2003,7 +2=
001,7 @@</span><br><span>         }</span><br><span>         else</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* We are not using pull or p2mp server, instead do P2P NCP */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* If we are=
 not using pull we announce P2P NCP support */</span><br><span>            =
 iv_proto |=3D IV_PROTO_NCP_P2P;</span><br><span>         }</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail">change 1634</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1634?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> =
Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: =
master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0737b769e78e6=
d271ec874cadb9fbd81bfefdec1 </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Number: 1634 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </di=
v>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flicht=
enheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>

</body></html>
--2GiIs90sVxc=--


--===============3887713770042795702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3887713770042795702==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3887713770042795702==--

