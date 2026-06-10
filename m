Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5C4CD8CB9
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 17:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UZo2V9zVlPjpeBgsMTkIjX7pS+EYNWCWRWzK26OhO2Q=; b=ahR4BW38JMFBIOSPL6EoydVAVu
	TIbSfkT/Yf4DgPRpo0GL5h38ecC+/1q7sE081hO4P68bAeKnKCG2OsfjGiA+9FOMyriTQPrN1NYOq
	aC+Y4evUBiKdYUFr8WTSNSFoJ5EUol2FP15K6cZJPMrQN02ZNx/NxadZHmtiWtJyzftc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXMQE-0006ng-BZ;
	Wed, 10 Jun 2026 17:08:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wXMQC-0006nZ-A4
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:08:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=GZ+SOHW4J7axka6PiRqMl+VyN20ufY+LKAXYz/EqUAA=; b=HcLj6RmM3U1CCkLv8OK5zC70P6
 gcpJ1UwA1FHzt/Z1MLhIHuc7GupleOVhx3yB9OBZZ/ffJV0PEjpVQn6Vt0hlDGk4gHAyAUJtPciD8
 qGq3jlhjTg8FwirwMd0E5wyoOwvwkVavbWivWX0+e5vA2pdukHAoz6FvRJ7bcfntiag4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GZ+SOHW4J7axka6PiRqMl+VyN20ufY+LKAXYz/EqUAA=; b=A
 2P3uPXDSdOV+371rm02/a/EcKpEE1/tS0HB5Vh/VLeGzYqeUwIvlbwrxVFZpFzhNApC6fHY6iEy6z
 afCY59gyN4vB4qnZXeS+T/0J4hK20bnMq04JubEdzMj68IO9Qen1CgfjIZckCSRDs6vJgG0gt/7+X
 w8BVHf7asMX1lADY=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXMQ7-0006gO-Fh for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 17:08:53 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45eee266c6cso5700354f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 10 Jun 2026 10:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781111320; x=1781716120; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GZ+SOHW4J7axka6PiRqMl+VyN20ufY+LKAXYz/EqUAA=;
 b=aIo7O02NqnSpk3y9mENA03voEx4XTRhRJQZmZhEBAykGA7kyDkgZvtrk5qXtM3Nhj9
 vUEbOmuC5gvIFIdlzQ0uMhdOLU4Z3+TcfN/V3lLFwFpFr+UH9bcS4moCjhKFKhy4TgR7
 dQ3wQy8CY/CyjECuabon7h7eHC6kosHnzCTRllEmXFbjjf5kMp1gwVgAIvjuQm26MpLa
 iVtMrq1wSSl6hBwl+hr1C4zIXf5py3vlHMH7Dz9vgCNHDE1oYkEhRL4X8fnwKzaM8tu6
 2meRDZhZ+IIkpv8mcis8uMD5NvylUJiwKS7a3CnPtCT/wc4UlK+vxK78bUkxhg8SjRhR
 4OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781111320; x=1781716120;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GZ+SOHW4J7axka6PiRqMl+VyN20ufY+LKAXYz/EqUAA=;
 b=hq+YlD4/SlASL8EPqxR7KhxJDiriigWAE9+ivkUiklNmnnvBx7iUWAmtDexhz4sq0R
 a6ivOJkkMYDqDPKyvQZK6lo3tnikPwIErs25j/iIm+Fzvt+tuPNgPjeoTRCBnA6WD5Kf
 HTKAkYLLtNnDtmPnBf0cTuJZUSUi3qtH+YccLPDtq/VihXU/DvK+StWUDXLuno4laU2J
 mBy6EjPMOiqnDTEYBf5I7oufgSyylfonPduQ6RqxO37O/KsxvMm8aPgrpRLZwEmpToEY
 m951Vd+SysYSPIHAXqMYp1BRtr77qLJFrW1mbE6o5lO5ERlXaY3SjEphRVOIORZQXK7o
 T2mQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ91ZuarXiVxkpdAtFyBCehHlZoN4+jaBSGIe7hd1zhsPlqEn+LR5d3ma1HJU1/2Xyk0T5sDSqzALhTemydw@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwDyFaTV1tfwX7asEjnCY3LvwIaONVQHY9xLi8fdg4vdYdw88HU
 B9LU4dlfjqspWgskb6OB7bEGsz9fFrTUkdeSypiqUuK2SYsHPaH25ToxKlJZGy77eGrMXDDUojR
 +mM9R6k71Z6fIPx+f273PHaWA4LF8HEdkl1UrB4uRz6EzNCXDbAEdc7Z3IaCpu91e2bxX4IhwDG
 A0juJodw==
X-Gm-Gg: Acq92OGsGOHt6frZ4biTBnX+iyGBEpJFsemOWLtLmAFAhooxijUatragl4mVVzZCcZf
 HqaNJpc0ODYfPSELOvH6XJq/17yzC8nw88hMMsR8vj7YtUvFVqyduX8dEjDMYr2vgILkOj6xt9j
 NaNH5ydCjJb5HxrPe7d9CY8mETCzrFIN8itOVUFfLc9jH4cvPBiGzE3eER9eTtKVOhL+NP8h2a0
 ZXqdy9pWt+kfezZEF6lvOlxs5dWC4eYHgkerE6wcHT6ka7zpild/9yYTv6ib3F5PDUzUAOJd5/T
 ykHxIMUXjTnCBPHuVdDVbL5KqP9e+e4t8ZnlRL8n+50tsMGJkzOb1jbC8SvNRUws7hHSAYWZl7P
 yGj+NmWlDnnEib5DVHNEYmafn2EVnFcyqEDybmJT5JfKfkYZHJbFpwvBYjNzRb10RW2RS6gAYdC
 FXJmHJwrc5lmJvlUWGoPidjlVQsXVKpa2bmgJBmm+e1xPPrg1+nKXRWBCBuN8YjTcrkD8+VpmT2
 vX/ZUYMhOcL/c7cXKvVw2y7DJ7om7X+4sEEtrdv3pVOZ0oTDafw7CS4gom31atSoQlHm5ulaAuJ
 uf/p1Pz8O75GW91KqAtsT5kp
X-Received: by 2002:a05:6000:4697:b0:45e:739b:3e43 with SMTP id
 ffacd0b85a97d-46030186d90mr26240772f8f.0.1781111320464; 
 Wed, 10 Jun 2026 10:08:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcae2sm78452276f8f.6.2026.06.10.10.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 10:08:40 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 10 Jun 2026 17:08:39 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
X-Gerrit-Change-Number: 1701
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1701?usp=email>
X-Gerrit-Commit: b2dcffba0820a1a77472658623b5964e88cbb732
In-Reply-To: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
References: <gerrit.1779381787000.I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MzgxNzg3MDAwLkkyY2E4YmY5MGE3OTZmMmI3NTdjMmZkZTBhZTI0NDY4ZWYzYWJjM2I1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5d4aa593e938efdfbec75b421f725b7f6e404e6a-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wXMQ7-0006gO-Fh
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Null-terminate
 tls-crypt client keys when testing
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
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4969051418074602193=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4969051418074602193==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Fdsc8joW7hE="; charset=UTF-8

--Fdsc8joW7hE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1701?usp=3Demail )

Change subject: Null-terminate tls-crypt client key=
s when testing
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=


Null-terminate tls-crypt client keys when testing

After generating a tls=
-crypt-v2 client key, OpenVPN will try to load the
generated key to verify =
that it was generated correctly=2E If the client
key is not written to disk=
 but printed out on the command line, the PEM
encoded key is stored in memo=
ry and read_pem_key_file is called with
key_file_inline =3D true=2E However=
, this key is not a null-terminated
string, so we end up calling strlen on =
a buffer that isn't
null-terminated=2E

This commit adds a null-byte at the=
 end of the key=2E

Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5
Si=
gned-off-by: Max Fillinger <maximilian=2Efillinger@sentyron=2Ecom>
Acked-by=
: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1701
Message-Id: <20260609102407=2E32590-1-gert@greeni=
e=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Es=
ourceforge=2Enet/msg37116=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/tls_crypt=2Ec
1 file changed, 2 insertions(+=
), 1 deletion(-)




diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/t=
ls_crypt=2Ec
index e91f80c=2E=2E8c3d722 100644
--- a/src/openvpn/tls_crypt=
=2Ec
+++ b/src/openvpn/tls_crypt=2Ec
@@ -758,9 +758,10 @@
 
     if (!filen=
ame || streq(filename, ""))
     {
-        printf("%=2E*s\n", BLEN(&client=
_key_pem), BPTR(&client_key_pem));
+        buf_null_terminate(&client_key_=
pem);
         client_file =3D (const char *)BPTR(&client_key_pem);
       =
  client_inline =3D true;
+        printf("%s\n", client_file);
     }
    =
 else if (!buffer_write_file(filename, &client_key_pem))
     {

-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I2ca8bf90a796f2b757c2fde0ae24468e=
f3abc3b5
Gerrit-Change-Number: 1701
Gerrit-PatchSet: 2
Gerrit-Owner: MaxF <=
max@max-fillinger=2Enet>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>

--Fdsc8joW7hE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1701?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">Null-terminate tls-crypt client keys when =
testing<br><br>After generating a tls-crypt-v2 client key, OpenVPN will try=
 to load the<br>generated key to verify that it was generated correctly=2E =
If the client<br>key is not written to disk but printed out on the command =
line, the PEM<br>encoded key is stored in memory and read_pem_key_file is c=
alled with<br>key_file_inline =3D true=2E However, this key is not a null-t=
erminated<br>string, so we end up calling strlen on a buffer that isn&#39;t=
<br>null-terminated=2E<br><br>This commit adds a null-byte at the end of th=
e key=2E<br><br>Change-Id: I2ca8bf90a796f2b757c2fde0ae24468ef3abc3b5<br>Sig=
ned-off-by: Max Fillinger &lt;maximilian=2Efillinger@sentyron=2Ecom&gt;<br>=
Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>Gerrit URL: https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701<br>Message-Id: &lt;2026060910240=
7=2E32590-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37116=2Ehtml<br>Signed-of=
f-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/=
tls_crypt=2Ec<br>1 file changed, 2 insertions(+), 1 deletion(-)<br><br></pr=
e>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/tls_crypt=2Ec b/src/openvpn/tls_crypt=2Ec</s=
pan><br><span>index e91f80c=2E=2E8c3d722 100644</span><br><span>--- a/src/o=
penvpn/tls_crypt=2Ec</span><br><span>+++ b/src/openvpn/tls_crypt=2Ec</span>=
<br><span>@@ -758,9 +758,10 @@</span><br><span> </span><br><span>     if (!=
filename || streq(filename, &quot;&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        printf(&quot;%=2E*s\n&q=
uot;, BLEN(&amp;client_key_pem), BPTR(&amp;client_key_pem));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        buf_null_terminate(&amp;cl=
ient_key_pem);</span><br><span>         client_file =3D (const char *)BPTR(=
&amp;client_key_pem);</span><br><span>         client_inline =3D true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        printf(&quot;%s\=
n&quot;, client_file);</span><br><span>     }</span><br><span>     else if =
(!buffer_write_file(filename, &amp;client_key_pem))</span><br><span>     {<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail">change 1701</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1701?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Pr=
oject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </=
div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ca8bf90a796f2b757c2fd=
e0ae24468ef3abc3b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number=
: 1701 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div s=
tyle=3D"display:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaist=
hos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>

</body></html>
--Fdsc8joW7hE=--


--===============4969051418074602193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4969051418074602193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4969051418074602193==--

