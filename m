Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20601C43458
	for <openvpn-devel@archiver.kernel.org>; Fri, 26 Jun 2026 19:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=VZObyxOwAei5K3qw7N01AfDyc3uZPjPqGORlmEhZuGE=; b=Md0/z5P3ilWmh/
	C+LfUT1m0Q+1ZHQvgolNy2T7vMqBHXvxS7BsSg87ObETHLMmmR0FxErwfUA2p73PycjVTWCgqxno7
	iK9tBdL3jYr/4kpdtlFSn/cSB8aMfu/p1lruFe6p0ec2ymzecmwf8ecw5jNe3AtyJTinbKBJ+j0aT
	MkY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wdBnR-0004H7-P4;
	Fri, 26 Jun 2026 19:00:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wdBn8-0004Cf-7U
 for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 19:00:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rKj0CoG8RRbTIZV05rGVK6uuSh9/Hb+/v+L/D1ojFZY=; b=R0a3QNopUz+7Y6jri8W3aE0HJc
 T7HbLLGURzJ9oM9j4+59YGhB+8jrjrFNOZD1Ug3O9qTMC5RF6OMV5jHxVfJa6ExSCyygUtGFHVQC2
 wPaCMWs7HsRvZUEMyNjxf/jVnh0MRhN+cT39kVWjWh2u+8MuzbmJZ4eLIUuHIObFbrug=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rKj0CoG8RRbTIZV05rGVK6uuSh9/Hb+/v+L/D1ojFZY=; b=W
 HolW9Up7eyTp3Wo04miwoLXJtOKSPGQQWkWev4wlvzvDB+8p/stndQlLewcZLhEFyeK9LwgbuQ3tm
 0MDCXdB6uxj5/sbOzomyifALgCDLKJyvlhSj3a1R305ynnbYmxPsVFfy16uvWr409wfC/v7PGxRbx
 OzoGAZMzgXL8FGUo=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wdBmt-0000oS-Nm for openvpn-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 19:00:31 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4923fb1f095so12857675e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 26 Jun 2026 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782500417; x=1783105217; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rKj0CoG8RRbTIZV05rGVK6uuSh9/Hb+/v+L/D1ojFZY=;
 b=B8XwJuFsVl98Kl6gAjY2w6lAJ5HnLgXTH4I/PW2tfcy/L3EMyGDPEk7eVUrd6BMp1x
 OiTQUFESUEERHUqtCx2ynPLYWR6MKxm9IclAY7eZTg6y5if1K0gQdPGUojzBnRFlLFNE
 6m/sfzZ3aadbWKlfDu852eumtFbNGfHl//rLhi+GFxJ5+znFFrNpSas68aNzNkSDn8tP
 Z8tXVjd60ffCandj5L/Gwm1esqD6+rWZkl9UWoxtyyYElZSpkbWtZwLFDFrO8CYZhQDa
 +vJQi6a6kI3wwGXFzdnmEy8ChPGogrBGp4qFwJ9xnXntRqR47cZzzp2DsxSjMzPWKY8k
 qAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782500417; x=1783105217;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rKj0CoG8RRbTIZV05rGVK6uuSh9/Hb+/v+L/D1ojFZY=;
 b=RUhZGA8eU0d1BjcwL0fUTUgmxx4lE0v49j8RKMqOXxvWHCs4v7hk3u6H3AEBje3cgY
 vS0fJdpUW/4hZ3AF6oIuXIE4xSJOCMAoTDia9cSYLpkPM/DS7F/n43k61bqQVZ+p1oE8
 Tmauhn0GBJ2J/U7MBLx6f9N1k3rn21avcvMr2/hMsobwt+u3DD56cSvB3pd68UGbMJNU
 IK6KYGpm/exfUO0pmBZlr7WRbzhH2LCvEHqgRO0ZcrFRFsGgG/Y2onYCQ/FYDEDdFes0
 /2inGGhRGFMkNH1ZJRG2XmsHC5JViUQqdi6vW14PAW7Lt4qfYX4l+C7toLow5MCy3bN+
 eICw==
X-Gm-Message-State: AOJu0YwQ6JMFBupI9ZB2LLQJOHn9/W4SaeSeH5jVa0P5nRHnSHIcaGZL
 TLNDK0KCDE00h23SFPpGovuo0jLOqKuO/EnF+hgKXb3EatO7GnrW6dezW2HJ5ROhovLILOe6+Bo
 WFHwmefibFymnUKsbrR5b+NhN6k6N2nhQjAfuszCmgYBNUOg7J2EzdsqnGIgrg5d01z3feBm7GW
 mIbZxeBQ==
X-Gm-Gg: AfdE7cmEtQvgNWz4el5WUQbFG8DK2eZONb4O7oNi4UKhFATfbfxM+T6xrnGxvdxN5dd
 hq7UgjSgXwJMXPJgwYSXeeF4m05Ow4E7jphtNpiym5ZTsmsxccURFwdeb80c/q8he1PMJpzFj81
 QomnMXAOu79Dmb2ZOQU7jc05iN6SWRVncViPcnufbNtR2/hkrCQ9qLWIwo0c7CyjVeNd/p5nG59
 4ZstkWiW7xhFRWaHPS0YHBOXWmKbcs7ojaxb80+lYX6DOKoRsEiEAvcsRQ7loe/KOBu6FuETXQc
 Esk8WoH/pKKVghEfQxpNi90vBRFjctk5t6nNZU3w/FQlhLNcqZ0M+8JKalgU8knAf3EJkU7Om46
 eo5UQmgFk4YyN3zPZAhmTKMG8E779SWLy1NbZdjDXPr2uYRTqyY9PhVQoJlUDfyE8j+CaQah0D0
 IPbwc3ohTFoOsVyZvo8OMuo9KgA2bbjQnnxu8yYotgfDZC+hZLvjOGakjbKuUGqOV3y6VbXVNI2
 roD94mmJt/Krak0n0C3gjTUaChvM4CQ9PoxVvRq9aTDSj3eGbgJbREkgtTS1lsQz/Y4fzbMI9s6
 kZQ=
X-Received: by 2002:a05:600c:620a:b0:492:8cd6:c7b2 with SMTP id
 5b1f17b1804b1-4928cd6c8aemr434215e9.16.1782500416488; 
 Fri, 26 Jun 2026 12:00:16 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926f94f213sm40192175e9.12.2026.06.26.12.00.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 12:00:15 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 26 Jun 2026 19:00:15 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a
X-Gerrit-Change-Number: 1733
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1733?usp=email>
X-Gerrit-Commit: 598ef6d9a287492e03ddfa9f6507d99443fa6265
References: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNTAwNDExMDAwLkk2NTk1Njk1YWI2NDAxMDQ3ZDQ5OGQ1MzBmODczOTY4Njg4MGJlYTNhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7746a00578e39cfeaec1c01bf4a3eb102bab2c97-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wdBmt-0000oS-Nm
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1963762364173111471=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1963762364173111471==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Nsi0inbli6I="; charset=UTF-8

--Nsi0inbli6I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1733?usp=3Demail

to review the following change=2E


Chang=
e subject: mingw: avoid C99 "hh" scanf length modifier
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

mingw: avoid C99 "hh" scanf len=
gth modifier

read_key_file() and parse_hexstring() parse hex bytes with ss=
canf()
using the C99 "hh" length modifier, storing directly into an octet=
=2E

This is not portable to the legacy MSVCRT runtime that Ubuntu
resolute=
's (26=2E04) mingw toolchain links against=2E

Scan into an unsigned int an=
d cast to the octet instead=2E The field width
caps the value at 0xFF, so t=
he narrowing cast cannot lose data=2E

Change-Id: I6595695ab6401047d498d530=
f8739686880bea3a
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
-=
--
M src/openvpn/crypto=2Ec
M src/openvpn/cryptoapi=2Ec
2 files changed, 6 =
insertions(+), 4 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29=
418/openvpn refs/changes/33/1733/1

diff --git a/src/openvpn/crypto=2Ec b/s=
rc/openvpn/crypto=2Ec
index 7954e8a=2E=2Edb84a33 100644
--- a/src/openvpn/c=
rypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -1473,9 +1473,9 @@
              =
       hex_byte[hb_index++] =3D c;
                     if (hb_index =3D=3D=
 2)
                     {
-                        uint8_t u;
-           =
             ASSERT(sscanf((const char *)hex_byte, "%" SCNx8, &u) =3D=3D 1)=
;
-                        *out++ =3D u;
+                        unsigned =
int u;
+                        ASSERT(sscanf((const char *)hex_byte, "%2x"=
, &u) =3D=3D 1);
+                        *out++ =3D (uint8_t)u;
          =
               hb_index =3D 0;
                         if (++count =3D=3D =
keylen)
                         {
diff --git a/src/openvpn/cryptoapi=2Ec b=
/src/openvpn/cryptoapi=2Ec
index bf80bbd=2E=2E0f95ab7 100644
--- a/src/open=
vpn/cryptoapi=2Ec
+++ b/src/openvpn/cryptoapi=2Ec
@@ -169,10 +169,12 @@
   =
          break;
         }
 
-        if (!isxdigit(p[0]) || !isxdigit(p[1=
]) || sscanf(p, "%2hhx", &arr[i++]) !=3D 1)
+        unsigned int b;
+     =
   if (!isxdigit(p[0]) || !isxdigit(p[1]) || sscanf(p, "%2x", &b) !=3D 1)
 =
        {
             return 0;
         }
+        arr[i++] =3D (unsigned=
 char)b;
     }
     return i;
 }

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1733?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I6595695ab6401047d498d530f8739686880bea3a
Gerrit-Change-Numb=
er: 1733
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerri=
t-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel=
 <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>

--Nsi0inbli6I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>d12fk would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1733?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">mi=
ngw: avoid C99 &quot;hh&quot; scanf length modifier<br><br>read_key_file() =
and parse_hexstring() parse hex bytes with sscanf()<br>using the C99 &quot;=
hh&quot; length modifier, storing directly into an octet=2E<br><br>This is =
not portable to the legacy MSVCRT runtime that Ubuntu<br>resolute&#39;s (26=
=2E04) mingw toolchain links against=2E<br><br>Scan into an unsigned int an=
d cast to the octet instead=2E The field width<br>caps the value at 0xFF, s=
o the narrowing cast cannot lose data=2E<br><br>Change-Id: I6595695ab640104=
7d498d530f8739686880bea3a<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeige=
ntlich=2Enet&gt;<br>---<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/crypto=
api=2Ec<br>2 files changed, 6 insertions(+), 4 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/change=
s/33/1733/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/crypto=2Ec b/src/openvpn/crypt=
o=2Ec</span><br><span>index 7954e8a=2E=2Edb84a33 100644</span><br><span>---=
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
e=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65=
95695ab6401047d498d530f8739686880bea3a </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1733 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@op=
envpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>

</body></html>
--Nsi0inbli6I=--


--===============1963762364173111471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1963762364173111471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1963762364173111471==--

