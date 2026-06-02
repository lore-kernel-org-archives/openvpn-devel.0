Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67F3CD6E4A
	for <openvpn-devel@archiver.kernel.org>; Tue,  2 Jun 2026 12:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=8Wazk/D1oV29a1h7b2d1qGpm4S7lbOaKUkrQt4vYcvY=; b=GLtEmD8MZvZFMR
	JLcfQd9FVJN8bqO/QBKI9+E58ajlJel9A58gs4gX8ocOzdWInQJ2xBYXCbYn8IxfJJAf1kQok8xi/
	EfSR2fM5odW/56IFNES+nx0gedv5/GUU0u970lnFYL7ZPBGycF0LkcO3q6pgg3l3ZeRKBKD+acLby
	Er4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wUObV-0008TV-TR;
	Tue, 02 Jun 2026 12:52:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wUObV-0008TP-9N
 for openvpn-devel@lists.sourceforge.net;
 Tue, 02 Jun 2026 12:52:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oq+hTK5deXFK8PgUdhKnbJbZSDl1nRfTBMwnd4rIgE4=; b=KWd+PJZSLCTQKTEN2HtZmBhLtI
 O+dFN05UHprDOb5dT3aKyPS4Jc15MmD+taDWF8GTnomkq4touTob6YbfMAIqnh9h55Yn9eK2MgS0x
 5r5KlbyTut+5hGynTVsna41rGXh1jeMFJDBbpqhZUXQgrosW/Yj3wIYoIqGFk5/NJ6Ao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oq+hTK5deXFK8PgUdhKnbJbZSDl1nRfTBMwnd4rIgE4=; b=V
 RPDAaJzq+vKxt/eh/W/MwdXlW1sgLqvRU7bzLfQe1NWrpSTckR4AkjQqvmTR50Ouohw0TeRkYSHhj
 pJ2XNvdC3tOAsyKN9XNQk8iXbYWMzLfJIvDEiHbGJbUODVMug1B+ZsxumnEclP8PHT+g7RFKJALpJ
 fHh9KO13916ivkZ8=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wUObS-0007Vi-5v for openvpn-devel@lists.sourceforge.net;
 Tue, 02 Jun 2026 12:52:21 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-490b3e03939so3231745e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 02 Jun 2026 05:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780404727; x=1781009527; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oq+hTK5deXFK8PgUdhKnbJbZSDl1nRfTBMwnd4rIgE4=;
 b=LxS5sIea4ox9lo6gLJj17RY88DoLCB0buourAZPhMgy/GOITbyxwnpCn47rDP8/JZF
 1ZD94JWdhJ0xxkw+ubILLDTRvr3ESiQ6fvX8W0yyLTNDPTIUONGPd9txnRWihu1vqjLP
 YrlAQwIaZomKp2uenikMktqOU8ox9rrIWJ6wMO5yxnDSBRjwqluaJcFcgshLl1pmUCE5
 xMVsraG9ALBbV9KO0QmC8ddEe753adnE48Z8iazwM9UtjZUWtQQubxKtah7ogH1FdMlj
 b5yER9FmkABDmA45xnK++V/1OMpNkDKQu/HEwkFYHb8tst7EJJsF7EHUnYkNXs3upHar
 D6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780404727; x=1781009527;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :list-unsubscribe:list-id:auto-submitted:cc:to:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oq+hTK5deXFK8PgUdhKnbJbZSDl1nRfTBMwnd4rIgE4=;
 b=Qo41Z9Ph61zx5sOPLiqL1P6IQf4m+ViX6o6BwVSmD5MQ3aHg5hEgFRJcoNMwE9rzhF
 HRqof4JgxJ/zmtpcoLfWV/9Tgi0uWClDFVjhird6iYj10qpzGxs930IF27rlnfordcKJ
 Szsf016hdMfAxmb4z0wo4BwUlkM/wa4VcBdcgJc4dvfaSATRQpuCcWCyOFQZUay3RNVz
 JjsDgBFAHkt9BxvnD4P7wWHKNr7TfW0AqL2ZqcRR7psUsESzKacbU+qn16/fopHGY7yg
 6YIJv1QhWUqhtNOntTGovZMG4dUK2gHrJLuVrLjjZ06aYvtYOOwtEYbe/uofWc3Sj3m9
 mfOg==
X-Gm-Message-State: AOJu0Yz4T4D/6C41d8VL1Eq8OhmQ0UzThYeWTg+qlA/NSdUmN5bZ/13N
 +UMrzbQDd77F6js9kXGavBEY9v6PvFKO2PpqQELLY+ovZr1myuxnv0wAMT7fDXNKyG7zdnG0JUY
 SjGuPY1LWrpcggN04616HBExOaYrWzOM2QVhLqC3qZ/0XSPHbRQk30ynYLeACeRdWWyJC9vYGTu
 PcJglAdQ==
X-Gm-Gg: Acq92OG/e4J0w6XIGU40FEYL0KW7zAGb4WIVgBoX0jPFz+D7JfKLdsY4Xg7yoPBG80O
 62iD55+dXqRGazqQdS7VegOjNsSsLRLLRvpU8MOHFyX9EKX6rnbAZ+sbw44Jx7zqML83loqG+U9
 cRWQRus3nGwxZJ6gAbzHBbnh0JPydp7aFIbB54keVwbRPr22kTtqo5jOeSENa7CJ/gAfybUIScD
 dhyI1VbicNOdHAaleX+hLJe4XxYuxr5fDnR9xlPEZ8sCmeQnTu8j4n/VXfK6dDt+lBdNDY07ZJX
 XFTGZaiS47DHAOHA0WlMi3ts7x9LLOXz31Kzb+3khC5PdvIywt8TcycT6P6VELt9F7Wn0HbeE1Q
 gvwVinCQc9J5tdLnOo/mICS4Y5WjCBByppSz++Z7EDDhzkoHudmpD5cJ85Sv8hdrPwy4P0NRKmF
 KgkOpDeonfZlEcHmw9UVxBrq+D4Qz6HlW6ZTTyC6f8HNR2hQvCpUiZZTfm94zbe27hgNXBjCkQu
 B0gnfcc0kTapBGRgn0B0ncaXwwNB9J9btA/IOa4gOUbGoEv234W4fc5+Vm5mk25yf/sHUpq880f
 cgeeuBoQ1bDjHGBADW1nHlkg
X-Received: by 2002:a05:600c:1546:b0:490:7df7:9190 with SMTP id
 5b1f17b1804b1-490b0e70060mr61221535e9.8.1780404726741; 
 Tue, 02 Jun 2026 05:52:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490b27e0ee3sm20581465e9.3.2026.06.02.05.52.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 05:52:05 -0700 (PDT)
From: "stipa (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 2 Jun 2026 12:52:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2ce954aa5b74002be5e38d53783435736625bb2f
X-Gerrit-Change-Number: 1706
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1706?usp=email>
X-Gerrit-Commit: 85c28b13f51ba2d226daacf7e6f9d5dda3cddd07
References: <gerrit.1780404721000.I2ce954aa5b74002be5e38d53783435736625bb2f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgwNDA0NzIxMDAwLkkyY2U5NTRhYTViNzQwMDJiZTVlMzhkNTM3ODM0MzU3MzY2MjViYjJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <204ec4a06a5e5a1c031c16a307700bd6cc48dc46-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wUObS-0007Vi-5v
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: assert
 buffer length before reading prepended sockaddr family
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
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1380207668285001054=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1380207668285001054==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9mx07fS6aBI="; charset=UTF-8

--9mx07fS6aBI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1706?usp=3Demail

to review the following change=2E


Chang=
e subject: socket: assert buffer length before reading prepended sockaddr f=
amily
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

socket:=
 assert buffer length before reading prepended sockaddr family

read_sockad=
dr_from_packet() inspected sa->sa_family before any check
on buf->len, so a=
 short delivery from the dco-win driver would have
produced a garbage peer =
address from uninitialized buffer memory=2E
The driver always prepends a fu=
ll sockaddr and validates the family
before writing, so reaching any of the=
 size/family checks would mean
something is severely wrong on the driver si=
de - assert the three
preconditions instead of M_FATAL'ing on them=2E

GitH=
ub: https://github=2Ecom/OpenVPN/openvpn-private-issues/issues/105

Change-=
Id: I2ce954aa5b74002be5e38d53783435736625bb2f
Signed-off-by: Lev Stipakov <=
lev@openvpn=2Enet>
---
M src/openvpn/socket=2Ec
1 file changed, 11 insertio=
ns(+), 18 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/06/1706/1

diff --git a/src/openvpn/socket=2Ec b/src/open=
vpn/socket=2Ec
index 624ce4f=2E=2Edf2cc9e 100644
--- a/src/openvpn/socket=
=2Ec
+++ b/src/openvpn/socket=2Ec
@@ -2813,38 +2813,31 @@
 {
     int sa_le=
n =3D 0;
 
+    /* In dco-win multipeer mode the kernel driver always prepe=
nds a full
+     * sockaddr_in or sockaddr_in6 in front of the control-pack=
et payload,
+     * so the buffer must hold at least sizeof(struct sockaddr=
_in) bytes
+     * before we may inspect sa_family=2E */
+    ASSERT(buf_le=
n(buf) >=3D (int)sizeof(struct sockaddr_in));
+
     const struct sockaddr =
*sa =3D (const struct sockaddr *)BPTR(buf);
     switch (sa->sa_family)
   =
  {
         case AF_INET:
             sa_len =3D sizeof(struct sockaddr_i=
n);
-            if (buf_len(buf) < sa_len)
-            {
-               =
 msg(M_FATAL,
-                    "ERROR: received incoming packet with to=
o short length of %d -- must be at least %d=2E",
-                    buf_l=
en(buf), sa_len);
-            }
-            memcpy(dst, sa, sa_len);
-   =
         buf_advance(buf, sa_len);
             break;
 
         case AF_I=
NET6:
             sa_len =3D sizeof(struct sockaddr_in6);
-            if =
(buf_len(buf) < sa_len)
-            {
-                msg(M_FATAL,
-     =
               "ERROR: received incoming packet with too short length of %d=
 -- must be at least %d=2E",
-                    buf_len(buf), sa_len);
- =
           }
-            memcpy(dst, sa, sa_len);
-            buf_advance=
(buf, sa_len);
+            ASSERT(buf_len(buf) >=3D sa_len);
             =
break;
 
         default:
-            msg(M_FATAL, "ERROR: received incom=
ing packet with invalid address family %d=2E",
-                sa->sa_fami=
ly);
+            ASSERT(0); /* driver validates the family before writing =
*/
     }
 
+    memcpy(dst, sa, sa_len);
+    buf_advance(buf, sa_len);
+
=
     return sa_len;
 }
 

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1706?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: I2ce954aa5b74002be5e38d53783435736625bb2f
Gerrit-Change-Number: 1706
=
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openv=
pn@rfc2549=2Eorg>

--9mx07fS6aBI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1706?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">so=
cket: assert buffer length before reading prepended sockaddr family<br><br>=
read_sockaddr_from_packet() inspected sa-&gt;sa_family before any check<br>=
on buf-&gt;len, so a short delivery from the dco-win driver would have<br>p=
roduced a garbage peer address from uninitialized buffer memory=2E<br>The d=
river always prepends a full sockaddr and validates the family<br>before wr=
iting, so reaching any of the size/family checks would mean<br>something is=
 severely wrong on the driver side - assert the three<br>preconditions inst=
ead of M_FATAL&#39;ing on them=2E<br><br>GitHub: https://github=2Ecom/OpenV=
PN/openvpn-private-issues/issues/105<br><br>Change-Id: I2ce954aa5b74002be5e=
38d53783435736625bb2f<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&=
gt;<br>---<br>M src/openvpn/socket=2Ec<br>1 file changed, 11 insertions(+),=
 18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/06/1706/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 624ce4f=2E=2Edf=
2cc9e 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+=
++ b/src/openvpn/socket=2Ec</span><br><span>@@ -2813,38 +2813,31 @@</span><=
br><span> {</span><br><span>     int sa_len =3D 0;</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In dco-win multipee=
r mode the kernel driver always prepends a full</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * sockaddr_in or sockaddr_in6 in front of =
the control-packet payload,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * so the buffer must hold at least sizeof(struct sockaddr_in) =
bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * before =
we may inspect sa_family=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASSERT(buf_len(buf) &gt;=3D (int)sizeof(struct sockaddr_in))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    const struct sockaddr *sa =3D (const struct sockaddr *)BPTR(buf);</span=
><br><span>     switch (sa-&gt;sa_family)</span><br><span>     {</span><br>=
<span>         case AF_INET:</span><br><span>             sa_len =3D sizeof=
(struct sockaddr_in);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (buf_len(buf) &lt; sa_len)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                msg(M_FATAL,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    &quot;ERROR: received incoming packe=
t with too short length of %d -- must be at least %d=2E&quot;,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    buf_len(buf), =
sa_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            memcpy(ds=
t, sa, sa_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      buf_advance(buf, sa_len);</span><br><span>             break;</span><=
br><span> </span><br><span>         case AF_INET6:</span><br><span>        =
     sa_len =3D sizeof(struct sockaddr_in6);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            if (buf_len(buf) &lt; sa_len)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                msg(M_FATAL,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;ERROR: =
received incoming packet with too short length of %d -- must be at least %d=
=2E&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         buf_len(buf), sa_len);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            memcpy(dst, sa, sa_len);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            buf_advance(buf, sa_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            ASSERT(buf_len(buf) &gt;=3D =
sa_len);</span><br><span>             break;</span><br><span> </span><br><s=
pan>         default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(M_FATAL, &quot;ERROR: received incoming packet with invalid=
 address family %d=2E&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                sa-&gt;sa_family);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            ASSERT(0); /* driver validates the family=
 before writing */</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    memcpy(dst, sa, sa_len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_advance(buf, sa_le=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     return sa_len;</span><br><span> }</span><br><span> </span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1706?usp=3Demail">change 1706</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1706?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn=
 </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Id: I2ce954aa5b74002be5e38d53783435736625=
bb2f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1706 </div>
=
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</=
body></html>
--9mx07fS6aBI=--


--===============1380207668285001054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1380207668285001054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1380207668285001054==--

