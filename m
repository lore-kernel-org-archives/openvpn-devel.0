Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89DCACD4F39
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 10:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I8tGPWZ3jZsccTt1uc5xboCVHEhyAyM58RwQvVqizPQ=; b=Or48NVGm0Z4bpBNJ3vE0v9pN8Z
	pX67LDaWkPItEmhLXdL8tODO6jufoHvtKT2sq9/fVQi/UTlEysYQJ1j4wuvFgm5YcKauAgLWC4rWz
	sYXCINM4XiWU274335EArqQBW4ZIkzAXkoBULTIPPLOHK2HyOS7WgSnv/ftV95/WgVvY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNTST-0007BQ-D9;
	Thu, 14 May 2026 10:38:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNTSR-0007BJ-Vu
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:38:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=EHs+eeCbwdEcqL2dw8hQkQ5uxyJcbCbgsKeQRZ5Wdis=; b=C1lij5glhvK4et8nwj46PC0h4T
 +RqAj9BOyTX5iX+bkVrG6fZPeGQnOjOnzCU28nUdft4AYp1tL6kKYKM3maulQrLt7y7ASqRRrgO2g
 v6rzdkuQPSYeBFi/WRv4JAtixZ2XsjidNEoj2hEVcBk8TzX0CaFHh3gILEIY9NpJENAU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EHs+eeCbwdEcqL2dw8hQkQ5uxyJcbCbgsKeQRZ5Wdis=; b=Z
 8LOil+JbH3LP8RPtKEOCIrbxWsatK0VhQIInW7KiXpYaVpheTTx6tvMBuOO2eBA3RdknIyihkLo32
 aoqTB5koHzOYFISS9IShSwSsX/dmfFcyfwW5TH3b4oaSqA2PIzWSD+SPOmLpTdwAj2G9XXJu2MFP1
 /BViKQmZiH9nj3i0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNTSQ-00072g-Ka for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 10:38:24 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48e82c23840so39106425e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 03:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778755092; x=1779359892; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EHs+eeCbwdEcqL2dw8hQkQ5uxyJcbCbgsKeQRZ5Wdis=;
 b=gunk/R/Nym2jDNlEHgXJGiJwoIm+cN+geJcX/bTTHs7bugiCG7nBufiMddleY/MSdT
 DS7tWEau4PWmJD0X4ARgnUzWvrQ5t9I7zdOF6Q9gFYX2mwkFwJm8OL3H2+gMqP+vPEhU
 D0TH7BH60jQiJykV26kgORsFTaXzQ35UI0PkEIsKR0uQbHgInvS8GsCSQshl+ST+o1kJ
 Ay939Fub9MRlacs2xmDiAGL/4XKdEReqAghN9zKpE603DCaZ85JazD1KIaAl7op2eIf3
 snSW9o3UTE6GoLQrnSjO9vnJRDQLV0J2Wz5CnGSC50mm4pZUWg1T7Kh33IeMgHAFEGjj
 3zvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778755092; x=1779359892;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EHs+eeCbwdEcqL2dw8hQkQ5uxyJcbCbgsKeQRZ5Wdis=;
 b=KKBYGgM0lVBQlBp3bRAhWLS6hFk8/ZpyFrgMhEBfMP0i94lA+zP89TDSV5QgbzhF41
 bm3QY3DvBxzK4BQ7jIWrTO5ulGcurY47iUatT+izEDJ7NRsoFZsJZi3qSkHeibLz/nTF
 +VLnBYaWMkae/Ndi7M7JeYl3/wR0+qbVzU2/R58Rnu4DO2eQLgbj039uATeYk0zvRz5E
 h3Y28GGn96z4g1ftZYKFOH4JPtk6uBuQAT+VjNF78eGtgbjbJcSjgfjwkIkHcZzixcqP
 68jDI6Yku6heFpWmIlONOJEwy8agdffxH4tUpD7OrkCh8/xYHKh1s6QMkK+LtqOgRWp8
 hMZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ACq6rGspBSwQTGUUKoPw1U273Ap5jcDjWkK0kw/bPXjx3WBQsAISwZY/ayHLuwhpIE6LRkzVqzKOw2dD7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyelYkET+5l7omBe1Yx3uUFFI+benNEnxNcX8dNp4tQ29LnM84S
 deF+Tcofm225OSTwUnzwnu4SsyxagBm2CHbP/Cc9aEi6/jhmpySUJCxhVdtd0RN6hvEqo+cPQWc
 PQeeHr3qMz1if7qfizQhbTcPWIwHYrIs5JncMCwUD07sl5Kkxw8jkiM9Lbcuy1DRE5Yg6
X-Gm-Gg: Acq92OEmcOu2pI0ALk5X22TqTuxoWPz/GMdXt2MUoYjhnEKyM9dE+gQWNJbmsYycxRM
 0EB8pRDSk8rxgpzOTJYkvBLoSI1UwSVJUtkuEG4MIV+3QOh7A6URsTcflbbk8e+JSvhp+SvrhzR
 9vu09NwoiYYlPwuHtvabgrV5HwjfS/WsydJ+Kn7zZ+Ng5bJJYF4RxQ11xGLQdxk5RVxrKixhTuB
 zMmdgNGyJ6aBvGpcUsNoDsEVka+mfiFeeGFouGfmunEKjdcb6E5qWff048ad4ThphnrNd675AUc
 AiAoJju8xKS90DSqh0B2KbuaVp47lmCSBQZnG1/s2CmkhNDdViTbxY0nxMOeXJurVEUMWQkeGGZ
 H2TWkFk+Ln8hkQXuESvhDMjlAqIVeFhbDb/Blz4M0Ee3lIiCg8/gLrlXLbZPw1fsNHNc0pXOpkn
 iC91Q951brQGAwz+8ts3uKaym6r7NpedfIMPnMD+L3/I9NqQuswzx6FXjXNI9uhczwVr6tiC3ZA
 z+OQhJ2CCeQwgavwYITNuTwYC066hrEYRsIAk5cP26UAjMlBdzugL8p48NRdVZxu0Tep6oXXXYF
 yrN+OcUkXla7nQ==
X-Received: by 2002:a05:600c:4453:b0:48e:526e:1011 with SMTP id
 5b1f17b1804b1-48fc9a434cbmr115458085e9.25.1778755091550; 
 Thu, 14 May 2026 03:38:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fdb26ad1asm43156955e9.1.2026.05.14.03.38.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 03:38:11 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 10:38:10 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f
X-Gerrit-Change-Number: 1674
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1674?usp=email>
X-Gerrit-Commit: 50bcb9206b1dc3100a6b20cf569c4caf9c9105e3
In-Reply-To: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@gerrit.openvpn.net>
References: <gerrit.1778239616000.Ida6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLklkYTZkNGZhOGM1YzVmZmJkNzkwOWQ2YWZkNTFiMWI2ZjMyY2EyZDlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <24c3eb539a21dcd7db8d3f889c06d66e9d1a3d13-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNTSQ-00072g-Ka
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: Address
 some uninitVariable warnings from cppcheck
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 d12fk <heiko@openvpn.net>, plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2623940280956236833=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2623940280956236833==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sJmWxqChaAI="; charset=UTF-8

--sJmWxqChaAI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1674?usp=3Demail )

Change subject: openvpnserv: Address some uninitVar=
iable warnings from cppcheck
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

openvpnserv: Address some uninitVariable warnings from cpp=
check

In the first case this is about helping cppcheck
remember that msg->=
addr_len and addr_len are the same
thing, but we use them in confusing ways=
=2E

In the second case there is indeed a theoretical
code path where we us=
e an uninitialized buffer=2E So
make the code safer=2E

Change-Id: Ida6d4fa=
8c5c5ffbd7909d6afd51b1b6f32ca2d9f
Signed-off-by: Frank Lichtenheld <frank@l=
ichtenheld=2Ecom>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674
Message-Id: <20260513150902=
=2E27447-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg36908=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 f=
ile changed, 19 insertions(+), 16 deletions(-)




diff --git a/src/openvpn=
serv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index 473a8d3=2E=2E1=
64f1bf 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/i=
nteractive=2Ec
@@ -1868,7 +1868,7 @@
         return err; /* job done */
  =
   }
 
-    if (msg->addr_len > 0)
+    if (addr_len > 0)
     {
         /=
* prepare the comma separated address list */
         /* cannot use max_ad=
drs here as that is not considered compile
@@ -2639,25 +2639,28 @@
        =
 free(wide_search_domains);
     }
 
-    /* Create address string list */
=
-    CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE];
-    PSTR pos =3D addr=
_list;
-    for (int i =3D 0; i < NRPT_ADDR_NUM && addresses[i][0]; ++i)
+ =
   if (addresses[0][0])
     {
-        if (i !=3D 0)
+        /* Create ad=
dress string list */
+        CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SIZE=
];
+        PSTR pos =3D addr_list;
+        for (int i =3D 0; i < NRPT_ADD=
R_NUM && addresses[i][0]; ++i)
         {
-            *pos++ =3D ';';
+   =
         if (i !=3D 0)
+            {
+                *pos++ =3D ';';
+   =
         }
+            strcpy(pos, addresses[i]);
+            pos +=3D st=
rlen(pos);
         }
-        strcpy(pos, addresses[i]);
-        pos +=3D=
 strlen(pos);
-    }
 
-    WCHAR subkey[MAX_PATH];
-    swprintf(subkey, _=
countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
-    err =3D SetNrptR=
ule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dnssec);
-    if (=
err)
-    {
-        MsgToEventLog(M_ERR, L"%S: failed to set rule %s (%lu)=
", __func__, subkey, err);
+        WCHAR subkey[MAX_PATH];
+        swprin=
tf(subkey, _countof(subkey), L"OpenVPNDNSRouting-%lu", ovpn_pid);
+        =
err =3D SetNrptRule(nrpt_key, subkey, addr_list, wide_domains, dom_size, dn=
ssec);
+        if (err)
+        {
+            MsgToEventLog(M_ERR, L"%S:=
 failed to set rule %s (%lu)", __func__, subkey, err);
+        }
     }
 
=
     if (domains[0])

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1674?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I=
da6d4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f
Gerrit-Change-Number: 1674
Gerrit-=
PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Rev=
iewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--sJmWxqChaAI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1674?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: Address some uninitVariable w=
arnings from cppcheck<br><br>In the first case this is about helping cppche=
ck<br>remember that msg-&gt;addr_len and addr_len are the same<br>thing, bu=
t we use them in confusing ways=2E<br><br>In the second case there is indee=
d a theoretical<br>code path where we use an uninitialized buffer=2E So<br>=
make the code safer=2E<br><br>Change-Id: Ida6d4fa8c5c5ffbd7909d6afd51b1b6f3=
2ca2d9f<br>Signed-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;=
<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&gt;<br>Gerrit URL: https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674<br>Message-Id: &lt;20260513150902=
=2E27447-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg36908=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpns=
erv/interactive=2Ec<br>1 file changed, 19 insertions(+), 16 deletions(-)<br=
><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnse=
rv/interactive=2Ec</span><br><span>index 473a8d3=2E=2E164f1bf 100644</span>=
<br><span>--- a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/o=
penvpnserv/interactive=2Ec</span><br><span>@@ -1868,7 +1868,7 @@</span><br>=
<span>         return err; /* job done */</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (msg-&g=
t;addr_len &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (addr_len &gt; 0)</span><br><span>     {</span><br><span>         /* =
prepare the comma separated address list */</span><br><span>         /* can=
not use max_addrs here as that is not considered compile</span><br><span>@@=
 -2639,25 +2639,28 @@</span><br><span>         free(wide_search_domains);</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    /* Create address string list */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    CHAR addr_list[NRPT_ADDR_NUM * NRPT_AD=
DR_SIZE];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    PSTR pos=
 =3D addr_list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    fo=
r (int i =3D 0; i &lt; NRPT_ADDR_NUM &amp;&amp; addresses[i][0]; ++i)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (addresses[0][0])<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (i !=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* Create address string list */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        CHAR addr_list[NRPT_ADDR_NUM * NRPT_ADDR_SI=
ZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PSTR po=
s =3D addr_list;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     for (int i =3D 0; i &lt; NRPT_ADDR_NUM &amp;&amp; addresses[i][0]; ++i=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            *pos++ =3D &#39;;&#39;;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if (i !=3D 0)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                *pos++ =3D &#39;;&#39;;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            strcpy(pos, addresses[i]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            pos +=
=3D strlen(pos);</span><br><span>         }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        strcpy(pos, addresses[i]);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        pos +=3D strlen(pos);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    WCHAR subkey[MAX_PATH];</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    swprintf(subkey, _co=
untof(subkey), L&quot;OpenVPNDNSRouting-%lu&quot;, ovpn_pid);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    err =3D SetNrptRule(nrpt_key, s=
ubkey, addr_list, wide_domains, dom_size, dnssec);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (err)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        MsgToEventLog(M_ERR, L&quot;%S: failed to set rule %s (%lu)&quo=
t;, __func__, subkey, err);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        WCHAR subkey[MAX_PATH];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        swprintf(subkey, _countof(subkey), L&quot;OpenV=
PNDNSRouting-%lu&quot;, ovpn_pid);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        err =3D SetNrptRule(nrpt_key, subkey, addr_list, wid=
e_domains, dom_size, dnssec);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (err)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         MsgToEventLog(M_ERR, L&quot;%S: failed to set rule %s (%lu)&quot;,=
 __func__, subkey, err);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span>     }</span><br><span> </span><br><span>   =
  if (domains[0])</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674?usp=3Demail">change 167=
4</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><di=
v itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1674?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ida6d=
4fa8c5c5ffbd7909d6afd51b1b6f32ca2d9f </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1674 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>

</body></html>
--sJmWxqChaAI=--


--===============2623940280956236833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2623940280956236833==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2623940280956236833==--

