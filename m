Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1167C531D0
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UJy9kYwnHynw4OzTdyc3GckWA/YnHqv90TZDgvWxkg4=; b=In9pvNVMNk3ewTGpfbag2mU8ye
	XaTI36fDceVZQyDE89qAdMlPQW55TPK9F7gD9/+sXo9kyUNjl90jiux75osuZLA4D8jHn7mPfAUWi
	d3UEuhA/IMJzFAEekb46n8D6zk8Erd0B2Qhtlv6Ol3uINNlMvPJnrFTVjDE46XY0VinM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wn0Gw-0004d2-EU;
	Thu, 23 Jul 2026 20:43:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wn0Gv-0004cw-Bb
 for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 20:43:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ADsy9oWCwqFC2XK6ijHBsPV/aSSDV3o8/UrmJhgcS3M=; b=hxjK/WEsOW1aPEvnKZfo82+H3w
 5VMHSEieXrQTrhELGi9tMN9K3NgGeiYqh4rKk8RJY5O+i/k4VbXmAS+NCXkw24FqbIfXXDVaAsNa9
 WyCuViu0HRWDgjtIyy1Y+RIn1oFUDMeUnOP6CnlnSSqJzd8eAwavq6L/oPqnJ8e7dHB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ADsy9oWCwqFC2XK6ijHBsPV/aSSDV3o8/UrmJhgcS3M=; b=Q
 rbV7qO9dRQu/ZUzEgnVyNZg5uowSW1xpOgW9d6Mzl3I+BDE+WIk4fWZFRp0FKAO7Q3lrfhan2Hlkm
 NZrSrpWeagIn+sVWb1i027hQiJFrq5usIa31GFN3uhgWG5Ls+G1DWoFvmwYCm6FoKR6XGQL2fXadf
 RAPXagzQUH69WZF8=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wn0Gr-0003yP-Uj for openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 20:43:58 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso591315f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 13:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784839431; x=1785444231; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ADsy9oWCwqFC2XK6ijHBsPV/aSSDV3o8/UrmJhgcS3M=;
 b=cNH2eEaaNiiQlYset+AUKH3+NfOBhpaCHevxWIJhLxsuHoMvTQFV0CszCbhIbVjpkB
 1LtqFV1+E3uYEjgI06L0CyQXYfDtv79naC8bN/xTK3bKprLhBSLpy1fRZC5cYp86yFSC
 N1z81k6FQ48oxbclAOujoxhMhcD+fXEDw0BzzCtEe9RuTy4hbDE9Jd3QbIRNTDLsZGbj
 /7CNcjh1LDoysb1zyAoDW3Ap9oTnzhtNHJVgN2Pn83psoW0VzH6YHjeA7ISBE7xr9/pS
 QPHAsZn5TjKYAldWRqilAyEjqBC9sE3dmcuVdB8c5fCaHol9AE5DDWTnWEv7fEAwC9YX
 KJZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784839431; x=1785444231;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ADsy9oWCwqFC2XK6ijHBsPV/aSSDV3o8/UrmJhgcS3M=;
 b=OO7F1bemqYYcSf/rAW6d5dcuz93KpLQ2Ufu3DjRZeyvYm1QpXe1ht3KuGgHfU5xEdo
 +oxoUzBjdEi8IVl8h+cv04dmg6dzjvJmJolGJjUwg/QyRp8Fz2ii7ZSyMmpMLFBmEBd4
 j8V8EUWBWRAPVBjRETxBPlAjtbVR+c3p0HDvo+ZtX2IM/d7arhLl3xXJZ6nGUceAXFyV
 5FI1hjKqmJDK8TUAN9a1XPijT9BOlhSGuJTj6ZOWczP4FspVDVacL0w+cCPJkgxPJrF4
 aCIEnGZAjFW9o5uEW+lxfCBYcGHIjNvalqN616fYIjkalExdeCqeAsnNw0go1LiSwEYb
 O47Q==
X-Gm-Message-State: AOJu0YyZ97z/vlPwXQmRwkDYaz9TbbslwPLhZDE74h7jIN9fMTtZFHnv
 p+ukC9lEJ+g68J+4Wv+7DHkt81WKhAB282gwmcUilSGHD+eE7++00/BThn2qicTvr7whxzXra3+
 ChgkVbeXsM11TWJQ3WYf8cOXZbzJqNXjeGQ5lKwAWIywJ77aoeefFRFiY+daxoRksUUDdF2spjl
 tFR6up7w==
X-Gm-Gg: AR+sD13SlUs8tdLUWXBumcq3M9liUEUlND3EW2JmXTA8fQEsjnyM3nvDLJQ21f1NQoE
 4bI2W7mXwy2y19iamLPoQkVC/KCMA4YCwBQYNNqEqIhRs2tlsUqKKnH0u86EqWyLsV317O7k+vA
 /lQS7GkXPFS7TtuBHg0IX7XyJIAJIvUm89a0CgROoT8GHeKAzUAiNvz3YXfuga6tjJ12iMCZDD7
 6+O30izrEdE8A7L1TxKIwgnocv1/KkQMd0rJ5YG0IMvfE2q6cTtiKUX8AH02n2x5lmUAX+PIlZ/
 qgl2yFNf1iX3qgudy1M1ElUUkvFkmlqc3FeTydtd64NWqzyJI99+jhH75dnCGvC7ba02WhJtH32
 OkvqiiI7cgI5vJO7utcDhqw/nVWzUTKHiWcLy8aIKuXQGwgvvYx1UXUKcJNH94Q5oXp8rjJlApv
 b5Pts6SOCp846Gisfpy13nMmjVrvIPa2BQO43Y460ltaPANJxPybD5zwegkVd1PqRVMvNIb8lij
 P/TrEvh0rSh42MTJ4on3nr1Pz9De+RBTfGj9A4BY5BvE3X0Bud1Zf3IIyD5Zs4WJIx6
X-Received: by 2002:a05:600c:1f92:b0:495:4c62:9d43 with SMTP id
 5b1f17b1804b1-49573d1ff7bmr51244795e9.34.1784839431183; 
 Thu, 23 Jul 2026 13:43:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957af89be2sm21284645e9.12.2026.07.23.13.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 13:43:50 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 23 Jul 2026 20:43:49 +0000
To: d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a
X-Gerrit-Change-Number: 1733
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1733?usp=email>
X-Gerrit-Commit: 035a88f97b1ffdc88497faeaa0aeb8a72e1eaf4f
In-Reply-To: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
References: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTAwNDExMDAwLkk2NTk1Njk1YWI2NDAxMDQ3ZDQ5OGQ1MzBmODczOTY4Njg4MGJlYTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <22b6a3eafa1241f08e633056676fc9dd9c98fb7a-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wn0Gr-0003yP-Uj
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2694363223044142021=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2694363223044142021==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GYJPadlpaEw="; charset=UTF-8

--GYJPadlpaEw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail )

T=
he following approvals got outdated and were removed:
Code-Review+2 by flic=
htenheld


Change subject: mingw: avoid C99 "hh" scanf length modifier
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mingw: avoid C99=
 "hh" scanf length modifier

read_key_file() and parse_hexstring() parse he=
x bytes with sscanf()
using the C99 "hh" length modifier, storing directly =
into an octet=2E

This is not portable to the legacy MSVCRT runtime that Ub=
untu
resolute's (26=2E04) mingw toolchain links against=2E

Scan into an un=
signed int and cast to the octet instead=2E The field width
caps the value =
at 0xFF, so the narrowing cast cannot lose data=2E

Change-Id: I6595695ab64=
01047d498d530f8739686880bea3a
Signed-off-by: Heiko Hund <heiko@ist=2Eeigent=
lich=2Enet>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733
Message-Id: <20260708185=
659=2E10219-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg37544=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/crypto=2Ec
M src/ope=
nvpn/cryptoapi=2Ec
2 files changed, 6 insertions(+), 4 deletions(-)


  git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/33/1733/3

di=
ff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index 3d79fe5=2E=
=2Eee43d65 100644
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec=

@@ -1473,9 +1473,9 @@
                     hex_byte[hb_index++] =3D c;
   =
                  if (hb_index =3D=3D 2)
                     {
-          =
              uint8_t u;
-                        ASSERT(sscanf((const char=
 *)hex_byte, "%" SCNx8, &u) =3D=3D 1);
-                        *out++ =3D =
u;
+                        unsigned int u;
+                        ASSERT=
(sscanf((const char *)hex_byte, "%2x", &u) =3D=3D 1);
+                    =
    *out++ =3D (uint8_t)u;
                         hb_index =3D 0;
       =
                  if (++count =3D=3D keylen)
                         {
dif=
f --git a/src/openvpn/cryptoapi=2Ec b/src/openvpn/cryptoapi=2Ec
index bf80b=
bd=2E=2E0f95ab7 100644
--- a/src/openvpn/cryptoapi=2Ec
+++ b/src/openvpn/cr=
yptoapi=2Ec
@@ -169,10 +169,12 @@
             break;
         }
 
-       =
 if (!isxdigit(p[0]) || !isxdigit(p[1]) || sscanf(p, "%2hhx", &arr[i++]) !=
=3D 1)
+        unsigned int b;
+        if (!isxdigit(p[0]) || !isxdigit(p=
[1]) || sscanf(p, "%2x", &b) !=3D 1)
         {
             return 0;
    =
     }
+        arr[i++] =3D (unsigned char)b;
     }
     return i;
 }

--=
 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6595695ab6401047d49=
8d530f8739686880bea3a
Gerrit-Change-Number: 1733
Gerrit-PatchSet: 3
Gerrit-=
Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: flichtenheld <frank@lic=
htenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--GYJPadlpaEw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by d12fk=2E</p=
><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733?usp=3Demail">=
View Change</a></p><p>The following approvals got outdated and were removed=
:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">mingw: avoid C99 &quot;hh&=
quot; scanf length modifier<br><br>read_key_file() and parse_hexstring() pa=
rse hex bytes with sscanf()<br>using the C99 &quot;hh&quot; length modifier=
, storing directly into an octet=2E<br><br>This is not portable to the lega=
cy MSVCRT runtime that Ubuntu<br>resolute&#39;s (26=2E04) mingw toolchain l=
inks against=2E<br><br>Scan into an unsigned int and cast to the octet inst=
ead=2E The field width<br>caps the value at 0xFF, so the narrowing cast can=
not lose data=2E<br><br>Change-Id: I6595695ab6401047d498d530f8739686880bea3=
a<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acke=
d-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1733<br>Message-Id: &lt;202607081856=
59=2E10219-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37544=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
crypto=2Ec<br>M src/openvpn/cryptoapi=2Ec<br>2 files changed, 6 insertions(=
+), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/33/1733/3</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 3d79fe5=2E=2E=
ee43d65 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span=
>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -1473,9 +1473,9 @@</span><=
br><span>                     hex_byte[hb_index++] =3D c;</span><br><span> =
                    if (hb_index =3D=3D 2)</span><br><span>                =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
         uint8_t u;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                      ASSERT(sscanf((const char *)hex_byte, &quot;%&quot; S=
CNx8, &amp;u) =3D=3D 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        *out++ =3D u;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        unsigned int u;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        ASSERT(ssc=
anf((const char *)hex_byte, &quot;%2x&quot;, &amp;u) =3D=3D 1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        *out++ =
=3D (uint8_t)u;</span><br><span>                         hb_index =3D 0;</s=
pan><br><span>                         if (++count =3D=3D keylen)</span><br=
><span>                         {</span><br><span>diff --git a/src/openvpn/=
cryptoapi=2Ec b/src/openvpn/cryptoapi=2Ec</span><br><span>index bf80bbd=2E=
=2E0f95ab7 100644</span><br><span>--- a/src/openvpn/cryptoapi=2Ec</span><br=
><span>+++ b/src/openvpn/cryptoapi=2Ec</span><br><span>@@ -169,10 +169,12 @=
@</span><br><span>             break;</span><br><span>         }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!i=
sxdigit(p[0]) || !isxdigit(p[1]) || sscanf(p, &quot;%2hhx&quot;, &amp;arr[i=
++]) !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 unsigned int b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (!isxdigit(p[0]) || !isxdigit(p[1]) || sscanf(p, &quot;%2x&quot;, &=
amp;b) !=3D 1)</span><br><span>         {</span><br><span>             retu=
rn 0;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        arr[i++] =3D (unsigned char)b;</span><br><span>     }<=
/span><br><span>     return i;</span><br><span> }</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1733?usp=3Demail">change 1733</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1733?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1733 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:no=
ne"> Gerrit-Owner: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></=
html>
--GYJPadlpaEw=--


--===============2694363223044142021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2694363223044142021==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2694363223044142021==--

