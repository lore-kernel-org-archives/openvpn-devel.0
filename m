Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C00CC88E56
	for <openvpn-devel@archiver.kernel.org>; Sun, 13 Sep 2026 09:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Mtocm++YKcLyy6Pfklr20ZKzpVOBXsIrE82Ap1+o8N0=; b=mEtKKlSfZWMveV
	v0e/Pbwa4gEmeD7TBVi6SfZQSx/Oo2yS2XUo1RvRziYunly2um29pHvc6JcKWpdSckPU04SaW8mQP
	qISH5fEVXW7CElnv9tIxtOqv0DCfbfRk6pI75f2HOO6dviT+i6vLjsEKYmYOh2mSqix1jtloKWxX8
	ZpE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5gUu-0000mm-6k;
	Sun, 13 Sep 2026 09:27:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5gUt-0000mb-0B
 for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:27:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p8l4v+tdfTfwIugdKJvqw/FOYtNsv9RGX98n3R4f5gQ=; b=RnKUP0MFYN+CVbZ6KLLBT+Fhu3
 +OhyPQ32L9y98USra16CL5kPwNL9OOcrMZeFDihmVLs/OXECwGeBD3yKIAv41nfA3YEpLmjKZZ47o
 WiUP0J3oMLAvqj50Hpur5gIP2BUQvixw6L6pHH0itKE2HJ+nUT7MjLBP3yHVlqi3Phjk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=p8l4v+tdfTfwIugdKJvqw/FOYtNsv9RGX98n3R4f5gQ=; b=i
 EPP7pRnv1a9OYhq9ygaX1b6kXXtKSJjyqwlxXhGVkXXWVyi1u9ZN1q2U01hJF5mK5ysyYTy9UpjAD
 jSXUWnDbwrHOr8mEGc0VmtSEbSOWIE7s0dS4asjQpTdUJLXoP7BZUNdXQV2B+5DCBPWa6i/1J6ljR
 CCwPuxsv7rhXFeeA=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5gUs-0001vc-Rc for openvpn-devel@lists.sourceforge.net;
 Sun, 13 Sep 2026 09:27:39 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4858303de5dso2365244f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 13 Sep 2026 02:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789291652; x=1789896452; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p8l4v+tdfTfwIugdKJvqw/FOYtNsv9RGX98n3R4f5gQ=;
 b=EDqrLvPwuR6Co64ij+CDPMxkSfQ3phZbJFeND+Ik6q9/pNg4UPkmLQyyMvSEj51gHo
 wX63zQxdoC7t6TCkh8OHv7KL8vVX6m+GwLuMKAvsM5lqX9OtX9HJsw2xzChqvdoj1lVz
 6QC8jh3P6Y5piJBzwAIijDILYl41+kKb4wTo1I5uNZclb0/bVhwH0+3wWAKs+garwsI4
 oXb5i4biimvJkDTD8Dm+r+ssISGP06znjGmFuHoX3d18dqY0te6lyOf6iVLkX5wFq+dQ
 CTdn0BvRO/OruVDDH14ZP7KWh6+kwAitVN2rw8U5N6fuu6Iwa0Be/CW3GQvNJ9oRJjK5
 fJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789291652; x=1789896452;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=p8l4v+tdfTfwIugdKJvqw/FOYtNsv9RGX98n3R4f5gQ=;
 b=bxx8n/Np2CWT7ozGrR1uLudXjpzH1a/1TL1scs9gp81+CFr0/1fHfk2jK18AgJYR5C
 udPFZ8KIUNi9KYbPBqpKZ1kDN6juXPvY7/7OKENrNMozfQvb/EmmCq5L+d9MrUFEekaH
 n1Vl966M5ag9SqL/CO3EGH2LG0gq/35IANIYM5v3ufv2k6sPT7pqgUxZB3GodF0MJp17
 U36nkukCZaxqgpeJjRK2irURbpRp95FAz8MNF3+rk0njaJbCslH7AbLy08JGnaRDCtiQ
 M5iNjEZzCJaGKa5UpvxMxfPkbCIINetFweFMU1QJVxmf6nI3nBIUbu43s4xyB7gqsg3Q
 JgsA==
X-Gm-Message-State: AFuF++nEpsnvxrE2qzEgL1tSwHu6r9u47GV6CUX4IfgHOz88lMfZDtPk
 SaAXhgCnqGvHVmaqujuVqHvjSi6WM1r/1Z05EJwVyS3RK1f7cqSRCukt1SeiuUMg7WBBrfGYnUs
 6Ole8T0EUhdS5W/rdltr7IoY100+lnydPkJAuJ4wGFtWtFNDSLMpm2ijVOyFTJ2Z+NVCNqbojyF
 7tZP4wpA==
X-Gm-Gg: AYBFou18FEEBceVZsFdpXCkWyMn9jjuGpLkZQ/XZT4kbaON4lxP/3kWMip7pwEL/p1I
 ZOHReqIt9v2xlM/uo6+8PauNCTQSZe8fg85p+6oXQE2lSjGN9xFT5ExAlL8WYo2yDi4NG0UJ4WI
 evGzYvrSn7CpuEF5YTXHhag0Rx019Vi1+pHD5mgo19z1g5DDd6z5zaxMR1Sq4qqtckLr9PE4fCZ
 zn6EjEFb48GaAmJOrBeZDLTlK0ZhhC4ZwhRFQSNcghdOYu1wAYYZZZYJhU8XfNOkc6ayLImmClL
 b+IiVUxj5cJlQ3ku56Ej6aAdBYxp3aA20VB92Q7eIY8eUBp9CMBeEvVnJs2an2J+nyvQKAFBc3x
 +CNcQ6loTrRc/9m6bZEVq5CJJRxDEvH1k5ClbRGxW1od9+nEQCffblqth6fsmJ4vwrPRjrzGnpY
 8LfjR3XmoiSywHNaBEaIvWbSMi0SORZIWpwwpaXNujnUlyEtVorXckDEK5VOBrJF0SsIuBxoaFD
 E5O7ciT8OPlCYUBFZ0XNtVpumaxeMdi1qilrDkNiG9jXRrOFNJ/BIS3bFVKAQ65Ya5/vTg0+eUO
 u7soYE6/uMmwktgc68hh/B8r/zYd56ZZPHT+wjB5scC8cp7CwgGOcg5mPkx07A==
X-Received: by 2002:a05:6000:2f86:b0:486:e73e:abe5 with SMTP id
 ffacd0b85a97d-486eb2e269amr14860396f8f.10.1789291652203; 
 Sun, 13 Sep 2026 02:27:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb359f38sm16950846f8f.30.2026.09.13.02.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 02:27:31 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 13 Sep 2026 09:27:31 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
X-Gerrit-Change-Number: 1914
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1914?usp=email>
X-Gerrit-Commit: 7a0342ba24ad6d46a9afd3bb0e128829450cd455
References: <gerrit.1789291650000.I3724236d4acc3d05d786274d6baf34a21c570594@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MjkxNjUwMDAwLkkzNzI0MjM2ZDRhY2MzZDA1ZDc4NjI3NGQ2YmFmMzRhMjFjNTcwNTk0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <669369c1ed7b5c22e1ddde29d7f0305def316894-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5gUs-0001vc-Rc
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: fix
 unsigned underflow when clearing domain_search_list
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
Content-Type: multipart/mixed; boundary="===============4285427688847473799=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4285427688847473799==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hq5EzzzsxCQ="; charset=UTF-8

--Hq5EzzzsxCQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1914?usp=3Demail

to review the following change=2E


Chang=
e subject: options: fix unsigned underflow when clearing domain_search_list=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

options: f=
ix unsigned underflow when clearing domain_search_list

remove_option() and=
 update_option() clear the domain search list with

    while (o->domain_se=
arch_list_len-- > 0)

domain_search_list_len is unsigned, and the post-decr=
ement runs on the
final test too=2E When the length reaches 0 the condition=
 is false but
the decrement has already wrapped it to SIZE_MAX, so the fiel=
d is left
corrupted=2E The next reset then does

    o->domain_search_list[=
SIZE_MAX] =3D NULL

and walks far out of bounds, writing NULL through each =
slot=2E A server
can drive this reset path against a client with PUSH_UPDAT=
E, so on
Windows and Android this is a remotely reachable out-of-bounds wri=
te=2E

Test the length before decrementing, and decrement as part of the
in=
dex, so it is never taken below 0=2E

Change-Id: I3724236d4acc3d05d786274d6=
baf34a21c570594
Signed-off-by: Cole Munz <Munzzyy1@proton=2Eme>
Github: Ope=
nVPN/openvpn-private-issues#178
CVE: 2026-88964
---
M src/openvpn/options=
=2Ec
1 file changed, 6 insertions(+), 4 deletions(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/14/1914/1

diff --git a/src=
/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 25a3746=2E=2Ed642731 1=
00644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3778,=
12 +3778,14 @@
         memset(o->ntp, 0, sizeof(o->ntp));
         o->nbdd=
_len =3D 0;
         memset(o->nbdd, 0, sizeof(o->nbdd));
-        while (o=
->domain_search_list_len-- > 0)
+        while (o->domain_search_list_len >=
 0)
         {
-            o->domain_search_list[o->domain_search_list_len=
] =3D NULL;
+            o->domain_search_list[--(o->domain_search_list_len=
)] =3D NULL;
         }
         o->disable_nbt =3D 0;
         o->dhcp_opt=
ions =3D 0;
+        CLEAR(options->dns_options=2Efrom_dhcp);
+
 #if define=
d(TARGET_ANDROID)
         o->http_proxy_port =3D 0;
         o->http_proxy=
 =3D NULL;
@@ -4082,9 +4084,9 @@
             CLEAR(o->ntp);
             o=
->nbdd_len =3D 0;
             CLEAR(o->nbdd);
-            while (o->domai=
n_search_list_len-- > 0)
+            while (o->domain_search_list_len > 0)=

             {
-                o->domain_search_list[o->domain_search_lis=
t_len] =3D NULL;
+                o->domain_search_list[--(o->domain_search=
_list_len)] =3D NULL;
             }
             o->disable_nbt =3D 0;
   =
          o->dhcp_options =3D 0;

-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1914?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I3724236d4acc3d05d786274d6baf34a21c570594
Gerrit-Change-Numbe=
r: 1914
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Ge=
rrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>

--Hq5EzzzsxCQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1914?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">op=
tions: fix unsigned underflow when clearing domain_search_list<br><br>remov=
e_option() and update_option() clear the domain search list with<br><br>   =
 while (o-&gt;domain_search_list_len-- &gt; 0)<br><br>domain_search_list_le=
n is unsigned, and the post-decrement runs on the<br>final test too=2E When=
 the length reaches 0 the condition is false but<br>the decrement has alrea=
dy wrapped it to SIZE_MAX, so the field is left<br>corrupted=2E The next re=
set then does<br><br>    o-&gt;domain_search_list[SIZE_MAX] =3D NULL<br><br=
>and walks far out of bounds, writing NULL through each slot=2E A server<br=
>can drive this reset path against a client with PUSH_UPDATE, so on<br>Wind=
ows and Android this is a remotely reachable out-of-bounds write=2E<br><br>=
Test the length before decrementing, and decrement as part of the<br>index,=
 so it is never taken below 0=2E<br><br>Change-Id: I3724236d4acc3d05d786274=
d6baf34a21c570594<br>Signed-off-by: Cole Munz &lt;Munzzyy1@proton=2Eme&gt;<=
br>Github: OpenVPN/openvpn-private-issues#178<br>CVE: 2026-88964<br>---<br>=
M src/openvpn/options=2Ec<br>1 file changed, 6 insertions(+), 4 deletions(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/14/1914/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options=2Ec b=
/src/openvpn/options=2Ec</span><br><span>index 25a3746=2E=2Ed642731 100644<=
/span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/ope=
nvpn/options=2Ec</span><br><span>@@ -3778,12 +3778,14 @@</span><br><span>  =
       memset(o-&gt;ntp, 0, sizeof(o-&gt;ntp));</span><br><span>         o-=
&gt;nbdd_len =3D 0;</span><br><span>         memset(o-&gt;nbdd, 0, sizeof(o=
-&gt;nbdd));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        w=
hile (o-&gt;domain_search_list_len-- &gt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        while (o-&gt;domain_search_list_len &gt; 0=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            o-&gt;domain_search_list[o-&gt;domain_search_list_len] =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  o-&gt;domain_search_list[--(o-&gt;domain_search_list_len)] =3D NULL;</spa=
n><br><span>         }</span><br><span>         o-&gt;disable_nbt =3D 0;</s=
pan><br><span>         o-&gt;dhcp_options =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        CLEAR(options-&gt;dns_options=2Efrom_d=
hcp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> #if defined(TARGET_ANDROID)</span><br><span>         o-&gt;http_proxy_p=
ort =3D 0;</span><br><span>         o-&gt;http_proxy =3D NULL;</span><br><s=
pan>@@ -4082,9 +4084,9 @@</span><br><span>             CLEAR(o-&gt;ntp);</s=
pan><br><span>             o-&gt;nbdd_len =3D 0;</span><br><span>          =
   CLEAR(o-&gt;nbdd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            while (o-&gt;domain_search_list_len-- &gt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            while (o-&gt;domain_searc=
h_list_len &gt; 0)</span><br><span>             {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                o-&gt;domain_search_list[o-&gt;=
domain_search_list_len] =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                o-&gt;domain_search_list[--(o-&gt;domain_sear=
ch_list_len)] =3D NULL;</span><br><span>             }</span><br><span>    =
         o-&gt;disable_nbt =3D 0;</span><br><span>             o-&gt;dhcp_o=
ptions =3D 0;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail">change 1914</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1914?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I372=
4236d4acc3d05d786274d6baf34a21c570594 </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1914 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Hq5EzzzsxCQ=--


--===============4285427688847473799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4285427688847473799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4285427688847473799==--

