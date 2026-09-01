Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40030C61DD3
	for <openvpn-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FXCLi1TJdxkAM67xofVCO1zzEVj7LUGeoSaJzoR4YHw=; b=kBMn89c8KVOICCmm4phVFrtB/7
	y3U5ClWdlMmJQ+iCb/lJalTr8wzoxtQ9ElFQeJl9RF5BcP66AIMOtjpSlHGZfd70cCmd6q3JQ1jz1
	jVo7v3GtQjrZQz8K3+dAZwB2rrl70LXKBK3Vq+vO2wTtVKLbGbXND7bfHp6xAvEP5L30=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x1NrJ-0006eu-MK;
	Tue, 01 Sep 2026 12:45:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x1NrH-0006dw-LQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:45:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=JQ3k0wb7eXcdiFhwbVaJc8ch2ojo8R7teAHw0BtK/sA=; b=NJA6Ehv3CabKdnWZyscdms9iOQ
 Y6DwSIifRKqTTe/7SXWjU25tno2/wBW3m6awYrWjdWcnH4x6zs6MKyqryGWfi17nEW0J4J6HegAma
 7sbQsnpNKrjhW+R7mmAp8rOcEaHojZaFsGbsQKBXlZFNkz8KsWtlZEqoSzjLp+zEKrBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JQ3k0wb7eXcdiFhwbVaJc8ch2ojo8R7teAHw0BtK/sA=; b=g
 WM2wB10ZuYX7zaAl/0P5TC8MN6OS11BgSRveBMDixSu445/3uWJfK2FSImvjU8MkNjpq45fDmVlRY
 BXvbOahsstIZ/QJMxkoGgMX2v7cWr8Rk8nZJRKoYul1+/baMV/d+IkcKhQsd5N/3/58HgYyffBoHt
 qnUvKCJgPDIZwj8Y=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1NrH-00084I-Mc for openvpn-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 12:45:00 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48441a2ba14so1114350f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 01 Sep 2026 05:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788266693; x=1788871493; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=JQ3k0wb7eXcdiFhwbVaJc8ch2ojo8R7teAHw0BtK/sA=;
 b=PcIJc5+kne0o4j6HrOex3FzYJSvdZWXb4/8erBPIhJAEwkH8E7hR9y1KDQ0npu6lKD
 cQXnaxFFjcDSRvuVq3CXYjqY0awC0sXAoHFqg4j62Cu6+lZOi8ydZ/KCRpoUoQR4cwFW
 VRbJnWbKlMl+/VuIx92YVxtq+JkZsbkaXlASV4fAdPVA9wGPlcHSx7yh2IIEUo0fat/K
 oSEB3V8Og8Yznwdh78AKeteczXCTPE8EJEFCdEi9Kn65nvePqD7/wc/6CStyIxn1pN1c
 ASBHcmv4DVvNkYfNKHd+SceBrFFaACxh5N75X47iDsn95xgXOCOEb1Vp5NhykB3Ghbna
 fpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788266693; x=1788871493;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=JQ3k0wb7eXcdiFhwbVaJc8ch2ojo8R7teAHw0BtK/sA=;
 b=aHNvXGMJjHHPSinwMaCxzYSn09onSNLTpu4SgCnLTKpSqTT5AFoOqYXfU5c/dWXfkZ
 gY1lCU69Qc2LW6P64CtliWn4CSxVHWu/tYj1bagyuKWGNkuWzk0t94wYa8VSnJig8UyE
 ZXJenAPn8Ry/D85P26Gvg45j75TzSCC6mN54n0JaPOazW+9bsZ/9LG3YmPsqQfvKqTI4
 fSTGxhZbt/P84+zzQgBEMoB5AQSH/c3hxAzQetWxGKdojEf5kFEsiF4fAjTOPZzJHkyd
 D/wDOL4vl9WqLXaVZag6o1qYfNww8rnYjH3o5B91DVggyM9aQ37ZMxBGQkBCj4423wd1
 QC1g==
X-Forwarded-Encrypted: i=1;
 AKwUvByKKQu26VeS2v4DLmuw3IfoXLk0nS6gouKdV42HcLgHjY55toqbE6dxYn53CywyucoO7hDyldoqsXYGtVe1@lists.sourceforge.net
X-Gm-Message-State: AFuF++l1aTXzTogBStnc7tkohKyisPsBLAlzff3KBBhjNDGKalSAVfMC
 V6JCF+SVIBTGGLog4dXUNmMC0MXltBV9sXsb/JFm/Ea2uRF5dYhAoLnlsQsNHIhMtbJT0alpoaD
 E5tdwGmKvJNGX5Dt+nBp9jLC2FQ02jYcZSOsKBLIhZ1eUZjJtOKP4P739V3bacgUYoppF
X-Gm-Gg: AYBFou3cpszqaK1QOVhpa2qT52otDn/Y0x3X8gdleDWWoGDXQJwz+Akq46giutunisG
 RPgFP8of1+E4/FHikcZLzvRydW235bHfECiNYJ8bSIQHJXntOxzfbgKv/xnmXHCtgHVazGNmt6v
 URrEiNRm2WXMk36fymlbwqs4w5eRXu9NmxGMUXBF8ZarfFflQzRojvHxU8QTdrIGB2DKk3ODNnb
 cXlukVgU4odchdHeFYpDfn7TwbnHqI4d3cqNFz/IfteIsA8syaOVV1gew2wEzDrh1VzUL4jBRfC
 3PvY0rKYNidNQG3dszKhSaLYb5DKWrjfZg9wRwOQpXjNeKouDBuNUmByTpwT6Pnc6e46DvYBXhT
 1hlH9KiQw0gZWm6FJIoqIVbQpi00OOqm9g8esuyIj3ddPaExTpnMYqCRjU8/WFv5QFYRKL4lJ1Q
 cqcXrlUpR+DDH4wZLjKIDuKCrOgwkTYXgIS6jqH7Gqr+QShtkjR7//ss2BiJQkZRLqNB5ZgAc4q
 Jf1fkpSfP9o/pU3vanxSZPZ8QJ1L7mrLQdYCki+1IHgZ3QqDo9jhgoPpk+WjO5sIc8bqT+f4LkD
 vcxgQVkbW5s/qxeAbjfnfCkj5eXSF75szKIlYxP7YWNB5PRfZFQ=
X-Received: by 2002:a05:6000:40dd:b0:482:e4bc:51b3 with SMTP id
 ffacd0b85a97d-482f799da20mr51269424f8f.1.1788266692902; 
 Tue, 01 Sep 2026 05:44:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d787b8sm4908493f8f.29.2026.09.01.05.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 05:44:52 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 1 Sep 2026 12:44:52 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
X-Gerrit-Change-Number: 1887
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1887?usp=email>
X-Gerrit-Commit: 4654317ddc50c450aa847114f5ab7845b201023b
In-Reply-To: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
References: <gerrit.1788192180000.I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTkyMTgwMDAwLkk5ZWU0YjZkMWMyMWJlYzM4NzNkYzZhNDc0YmQ2NWQwNDNiNTM3MGM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b8923e34f669a975586078357acf515b647ed99-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x1NrH-00084I-Mc
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: pass
 correct NRPT domains size
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7651187196767267040=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7651187196767267040==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EBksC+CJRno="; charset=UTF-8

--EBksC+CJRno=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1887?usp=3Demail )

Change subject: openvpnserv: pass correct NRPT doma=
ins size
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: pass correct NRPT domains size

Previous code assumed that the inp=
ut NRPT domains list consisted of
ASCII characters only=2E When IDNs were p=
assed as UTF-8 the size of the
converted wide character MULTI_SZ list was c=
alculated wrong, leading to
extra data being read and stored in the Registr=
y=2E

Discovered and reported by BreachX Zero Day Labs, using Typhon AI Mil=
 v2=2E
Contributing Researcher: Vivek Parikh=2E

Reported-by: Vivek Parikh =
<vivek=2Eparikh@breachx=2Eai>
Tested-by: Vivek Parikh <vivek=2Eparikh@breac=
hx=2Eai>
CVE: 2026-78221
Github: openvpn/openvpn-private-issues#162
Change-=
Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8
Signed-off-by: Heiko Hund <he=
iko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eor=
g>
Acked-by: Arne Schwabe <arne@rfc2549=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1887
Message-Id: <20260831184721=2E3391-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg38853=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 3 =
insertions(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index 36dfb8e=2E=2E0c6e23f 100644
--=
- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@=
@ -2735,11 +2735,13 @@
         dom_size =3D (DWORD)domains_len + 2; /* len=
 + the trailing NULs */
 
         wide_domains =3D utf8to16_size(domains, =
dom_size);
-        dom_size *=3D sizeof(*wide_domains);
         if (!wide=
_domains)
         {
             return ERROR_OUTOFMEMORY;
         }
+   =
     domains_len =3D wcslen(wide_domains);
+        dom_size =3D (DWORD)(do=
mains_len + 2) * sizeof(*wide_domains);
+
         /* Make a MULTI_SZ from =
a comma separated list */
         for (size_t i =3D 0; i < domains_len; ++=
i)
         {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1887?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merg=
ed
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9ee4b6d=
1c21bec3873dc6a474bd65d043b5370c8
Gerrit-Change-Number: 1887
Gerrit-PatchSe=
t: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-CC: d12fk <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>

--EBksC+CJRno=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1887?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">openvpnserv: pass correct NRPT domains siz=
e<br><br>Previous code assumed that the input NRPT domains list consisted o=
f<br>ASCII characters only=2E When IDNs were passed as UTF-8 the size of th=
e<br>converted wide character MULTI_SZ list was calculated wrong, leading t=
o<br>extra data being read and stored in the Registry=2E<br><br>Discovered =
and reported by BreachX Zero Day Labs, using Typhon AI Mil v2=2E<br>Contrib=
uting Researcher: Vivek Parikh=2E<br><br>Reported-by: Vivek Parikh &lt;vive=
k=2Eparikh@breachx=2Eai&gt;<br>Tested-by: Vivek Parikh &lt;vivek=2Eparikh@b=
reachx=2Eai&gt;<br>CVE: 2026-78221<br>Github: openvpn/openvpn-private-issue=
s#162<br>Change-Id: I9ee4b6d1c21bec3873dc6a474bd65d043b5370c8<br>Signed-off=
-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Co=
jocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Acked-by: Arne Schwabe &lt;arne@rfc=
2549=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
87<br>Message-Id: &lt;20260831184721=2E3391-1-gert@greenie=2Emuc=2Ede&gt;<b=
r>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg38853=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emu=
c=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 3=
 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv=
/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 36=
dfb8e=2E=2E0c6e23f 100644</span><br><span>--- a/src/openvpnserv/interactive=
=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>=
@@ -2735,11 +2735,13 @@</span><br><span>         dom_size =3D (DWORD)domain=
s_len + 2; /* len + the trailing NULs */</span><br><span> </span><br><span>=
         wide_domains =3D utf8to16_size(domains, dom_size);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        dom_size *=3D sizeof(*wide_do=
mains);</span><br><span>         if (!wide_domains)</span><br><span>       =
  {</span><br><span>             return ERROR_OUTOFMEMORY;</span><br><span>=
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
omains_len =3D wcslen(wide_domains);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        dom_size =3D (DWORD)(domains_len + 2) * sizeof(*wi=
de_domains);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>         /* Make a MULTI_SZ from a comma separated list */</span>=
<br><span>         for (size_t i =3D 0; i &lt; domains_len; ++i)</span><br>=
<span>         {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail">change 1887=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1887?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9ee4b=
6d1c21bec3873dc6a474bd65d043b5370c8 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1887 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@greeni=
e=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>

</body></html>
--EBksC+CJRno=--


--===============7651187196767267040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7651187196767267040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7651187196767267040==--

