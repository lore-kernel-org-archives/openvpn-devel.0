Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7472CC5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HCo/vPAbPYGC80Uw88qp5F9MUHW6ZKpG5XRcNqmOBTo=; b=fdJuZjYBBlSeOAAYrTeqOjhWru
	OvI3cyr24MR3hePac1f3DlwEzUczBIoBaUGlJi52BzOIuqH/3LRPaythZfVWp2xfVPNYjl+VDUaBz
	pt2QJLKFaGRz06HFQROLaNJqQrY3NyIgcyDx0cFXisR0aMXnFxHAR4vmvd2nDRKRLF4w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wumVV-0007kk-7S;
	Fri, 14 Aug 2026 07:39:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wumV6-0007k9-JS
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=UD5kitizXD998KwGMp/TKzajNen5DQUDTpwwsFucrBo=; b=LyvZiXAGl1xnSlshFyIoDsIgqM
 Uxh3g1BnW/f3L5dwVsE2jxSFlbFWb/qDzeWAhXQV1Y34eljoz70ZZwsFn6LKlh6gi2Q6QGixyR/rf
 L4ODBpG2IU32gpUFuTVZoZPPwya0TEa3V3tcii15En5IjzIkdvUFExAzSc1HZgZVmLrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UD5kitizXD998KwGMp/TKzajNen5DQUDTpwwsFucrBo=; b=P
 fDcfFEAB1Rwr3M5/Rl6duyW5uUSBpFzfnL+0lsL0FrUZXYBDTUeVTvvVU2vpTcmitWMSiwq1GKayf
 3nS/pVhIDZQ88w274lJ/ajV/lwqTx3rh+SE+xSb26UK4v0CH+xKwrH82fKVDGysuVEZypzPmzxSfq
 MI55agW5WHHekp8M=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wumV5-0001Y0-ST for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 07:38:49 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso5245065e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786693121; x=1787297921; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=UD5kitizXD998KwGMp/TKzajNen5DQUDTpwwsFucrBo=;
 b=fdcfGsT40E7HWMHGG3nLvHp6iOGkxcbDC9XH5YNpE8fJZdZ194zUaLi7p/LMKkCriG
 SoqhacRz9Z2+NU+Yj9GF/98OkGwhMIPk8u1WaJm+dy0VUGeymVIMocW3xmm5U3pAmsGf
 4wPFhdQwKmuMKASKguSY7rqhp5X7VuD5gUbV2wv3sNc2VUaHO0ly6oTBDc3UQA4p397r
 pEkIu3tE4Q8zACyhGvE6mdQcZau3Azx6H7qkepoi3tmJrcfg6XaXWFBJHMuIWmYjzbz0
 8Ipq7kCEd23R+HUIz+U6ZG1wYwjsstXtrqs0HPSrkWgXta4YEd1dAEb5Vxpy7M0rXxCm
 OEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786693121; x=1787297921;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=UD5kitizXD998KwGMp/TKzajNen5DQUDTpwwsFucrBo=;
 b=Pu3PuVDkvB04KSdPBq3zjA21cGkDsEkiEcQnqgwK5UCFPooXIOQIo9aAonmLeKTTtj
 uuIYQIQgHp+K2yeRBt+I/q4FT9qHoNRgbCoQ6dRaqR9POwKzs+p51O0MSk/qg1fahwfF
 nWe4z5och8E6BkW+++fe/LVuOMpM/C6MocFXB1mDWjnAxdqkW0AHR/v4Hp1F9RTuuTdo
 SgODG25Wl2P4RroCRijhaIOT6f0ciFOR8FGAdf8MwacAkiIBED5HP3VYwwh3QsxxYXR1
 EAaGh62heuoZJEqGlEJdMi48q4BkJvJ7g3ky0uwDMacgbONTBlzJ31hpA/AjwBk8h4ZU
 3cpQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoL9TNFOlzHePYME/89e0XCzNdf1/IA7iO3VT+RXeo9cE0rL7JoVQIrKzMUzfDurER7Y3xxDqgc8V12bxNU@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxvYDL+AkWM9acJU28lM2OuEyX8x5m1AT/keiuwQ6JSzr3ht3RT
 HXZXfFtuH8ZT/v9CoObj1Sjpi5Wk7hKhp602M/opbjpKmtAcF9874yS1jdfTmHGJ/hkggOB3xev
 rgtAyazjmCfkHbJdLpwa/IoZd1XXJ1onCaw4LEZRmjCIXGMuTbl2RuZvHvNR8/i2TeLIg
X-Gm-Gg: AR+sD12Xyf/NMHM53vNlw6KMRyXODor2mDlf3fDL/Sr+QNDTyMjRoRw5V6aoJ9sgwmK
 2zdSWX8rAxHO1gkxTlHJG6n/Kt2EPRZ+22b2PnKaLn/Hs1MEQ8MOC4bIB1WWVbL+TTIXNizA5qt
 Kz5ojr8vFpkDLrS/j1dYXZwz0ctyjNE5EpplTIHCKViUkJdMjIk8EsOoj+iX9GY4AvHm+rFYoFy
 cav1r3xvPdcBP366ZnGIgDyiHneZiR2h0A5u3Co/s8EtqK6UaA94QoaSAkqpWjraIhHsUgxqi/j
 uFc3vFjrIuGgdyN1oy5XlJr25i2ci72jgc7Fh35Kh2rvAkvNK0J41AoRlU3ZGyeDf3TfYAUpZmz
 ZXLDOIBvNdw59MUDwp1l4GNVxbWaxMBbleiKwDOqi6da8iSBrq8NNixTETZnZIIb/3pANf0I1vf
 wXXm+EXc1gQ5KVd9+ONkiBvEPdzVcfIZpDC4Vcupe3i039f3Z7mcP/iE8X+F1fYU11Ru58TTilF
 VwMn8TyHAbnwTmwS5qzQD4vmR6fCtm8iqxyfEjKPuqZrCtB8pgVojXMbzu/rTfqIFM/m3un14DZ
 QmkS4W9i7zxmcbY2+fjlYxQs81IpTDkZ+ENOIQSez2XkNMYxO8WQ8SJJ
X-Received: by 2002:a05:600c:4688:b0:499:8807:345f with SMTP id
 5b1f17b1804b1-49988073627mr32231325e9.13.1786693121296; 
 Fri, 14 Aug 2026 00:38:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899b5ad0sm7904365e9.4.2026.08.14.00.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 00:38:41 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 07:38:40 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I2ca40d0d86599896b38ea1467313b6a6cdc8339c
X-Gerrit-Change-Number: 1527
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1527?usp=email>
X-Gerrit-Commit: 8f2c2fac6cebe453166666fd73c0f58fac1f4a29
In-Reply-To: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@gerrit.openvpn.net>
References: <gerrit.1771008896000.I2ca40d0d86599896b38ea1467313b6a6cdc8339c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMDA4ODk2MDAwLkkyY2E0MGQwZDg2NTk5ODk2YjM4ZWExNDY3MzEzYjZhNmNkYzgzMzljQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f4aac44ad8166b1b5ad1adb5339eb35a21016254-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wumV5-0001Y0-ST
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: Avoid
 sign-compare warning in header_modify_read_write_return
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4348354607168201720=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4348354607168201720==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JxeqACkOSuY="; charset=UTF-8

--JxeqACkOSuY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1527?usp=3Demail )

Change subject: tun: Avoid sign-compare warning in =
header_modify_read_write_return
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

tun: Avoid sign-compare warning in header_modify_read_w=
rite_return

Since we already check that the value is positive
just make th=
e implicit cast explicit=2E

Change-Id: I2ca40d0d86599896b38ea1467313b6a6cd=
c8339c
Signed-off-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by:=
 Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1527
Message-Id: <20260813180835=2E3160-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg38330=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M src/openvpn/tun=2Ec
1 file changed, 1 insertion(+), 10 d=
eletions(-)




diff --git a/src/openvpn/tun=2Ec b/src/openvpn/tun=2Ec
inde=
x e7193d8=2E=2Ef2a4394 100644
--- a/src/openvpn/tun=2Ec
+++ b/src/openvpn/t=
un=2Ec
@@ -1706,17 +1706,12 @@
 #include <netinet/ip=2Eh>
 #include <sys/ui=
o=2Eh>
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnost=
ic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static =
inline ssize_t
 header_modify_read_write_return(ssize_t len)
 {
     if (le=
n > 0)
     {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int3=
2_t) : 0;
+        return (size_t)len > sizeof(u_int32_t) ? len - sizeof(u_=
int32_t) : 0;
     }
     else
     {
@@ -1724,10 +1719,6 @@
     }
 }
 
-#=
if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#en=
dif
-
 static ssize_t
 write_tun_header(struct tuntap *tt, uint8_t *buf, in=
t len)
 {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/152=
7?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2ca40d0d865=
99896b38ea1467313b6a6cdc8339c
Gerrit-Change-Number: 1527
Gerrit-PatchSet: 1=
0
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailb=
ox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>

--JxeqACkOSuY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1527?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">tun: Avoid sign-compare warning in header_=
modify_read_write_return<br><br>Since we already check that the value is po=
sitive<br>just make the implicit cast explicit=2E<br><br>Change-Id: I2ca40d=
0d86599896b38ea1467313b6a6cdc8339c<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527<=
br>Message-Id: &lt;20260813180835=2E3160-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg38330=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M src/openvpn/tun=2Ec<br>1 file changed, 1 insertion(+), 10=
 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun=2Ec b/src/openv=
pn/tun=2Ec</span><br><span>index e7193d8=2E=2Ef2a4394 100644</span><br><spa=
n>--- a/src/openvpn/tun=2Ec</span><br><span>+++ b/src/openvpn/tun=2Ec</span=
><br><span>@@ -1706,17 +1706,12 @@</span><br><span> #include &lt;netinet/ip=
=2Eh&gt;</span><br><span> #include &lt;sys/uio=2Eh&gt;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> static inline ssize_t</span><br>=
<span> header_modify_read_write_return(ssize_t len)</span><br><span> {</spa=
n><br><span>     if (len &gt; 0)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        return len &gt; sizeof(u_int32_t)=
 ? len - sizeof(u_int32_t) : 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return (size_t)len &gt; sizeof(u_int32_t) ? len - sizeo=
f(u_int32_t) : 0;</span><br><span>     }</span><br><span>     else</span><b=
r><span>     {</span><br><span>@@ -1724,10 +1719,6 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> static ssize_t</span><br><sp=
an> write_tun_header(struct tuntap *tt, uint8_t *buf, int len)</span><br><s=
pan> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=3Demail">change 1527</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1527?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2ca40d0d8659989=
6b38ea1467313b6a6cdc8339c </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1527 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"=
display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefor=
ge=2Enet&gt; </div>

</body></html>
--JxeqACkOSuY=--


--===============4348354607168201720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4348354607168201720==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4348354607168201720==--

