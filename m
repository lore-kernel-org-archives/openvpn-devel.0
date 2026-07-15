Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 651A6C44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=hRbgmBc9f5Fj2VciLABk+iwRgkRVdydniWkGBDCKaAk=; b=NElEsXljHW58If
	Y6WLEVLkg6gdYWCVWLi7ueIe6xzK9OwIgbYbxdrHVUvZPmX5UjebsypI7qKdICnJ86A+xFJ3aruOz
	teecAhJV9MuWSrNg0l2CkR02CXfGKSVsnccPcmlP0skvlG+f+Ym+dSr/D12Ytf0FNRycR+KLw16fG
	u4w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1Ft-00054X-NS;
	Wed, 15 Jul 2026 15:10:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wk1Fs-00054N-SL
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:10:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=09I3L3dZK7jYGZbVwrb4jzXGqBPIfUGrDf04PZrPkCQ=; b=XdT7tGVJbSP06uYUC+SUTeFYxa
 6//1pxTU5Lla+VLIwKVLlr6j921/Bjv4gKoLyJmqK4P2nNLppinyCVLARajwTL84AaQMZLsP/5vo8
 rxwyHrelaVeFe1WUplQgVRdBjYfUktvsmIB1mexiGIl690eTJKJzJFrXvkLqVJouxfBY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=09I3L3dZK7jYGZbVwrb4jzXGqBPIfUGrDf04PZrPkCQ=; b=j
 9tQ3xvw98hhjGl5/S3uWhhK/GJn+zIvvd13FgsIKohz95Qme2G5zGd5YuFbupzYK36cFdfGYph7oB
 zzIM3ZNPVx7iaLT66v8iDNQUlQeVdWuiQpxqHaLReGDnfeBZikYRjaioCKdYDGi0VUFJH9ewF5wnl
 /xywQIZqQw2h/KvE=;
Received: from mail-ed1-f42.google.com ([209.85.208.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wk1Fr-0007Mj-5n for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:10:37 +0000
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-698ab9aae16so1132770a12.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 08:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784128224; x=1784733024; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=09I3L3dZK7jYGZbVwrb4jzXGqBPIfUGrDf04PZrPkCQ=;
 b=BCc1sVpQz4wkINhG0XfvSPgaLwl8xR1edj1Db61m6B3PWHuynmOgAVWBQ2trbCMx67
 VsfmkpQLMrqo41yBJSqJo+EuSpS8/qmPQoLMXzCi4oiGkUBz6whtqBdVJAqcT3bqySLc
 XXYgyu7/A4OTZnUaJAJ5yeJTLM/ydyqXLZPTG7Zq5cV5akWrkyiTvzOBTHPL+gWo/mh5
 t5APVHjCmcK5m6OJMvZymBf6vt85Us8XYwXxfrktkr1JRlY7JABlhlUrqXK+7zUm7+J3
 0aqfYPL+eMAeqphYIpijZMUeA/25DT8RGWN+CoYPOB74nuibWuu7msBc/ejDrARPaEWJ
 pn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784128224; x=1784733024;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=09I3L3dZK7jYGZbVwrb4jzXGqBPIfUGrDf04PZrPkCQ=;
 b=ctTu02rwIkZ/ptLpXnKviSp2FsdQfHsfXBIb5qeiAOLY+9ha7foGbbttfFNaIcMgv1
 Zo1b47Zo0D8ufJcDur6i7uqN+4jQmrCxDVrsGJkRVJmTOlHdWWZF2Ecl1Yji8yi4WFbj
 ZAtDfSuYgiVu4uj0k1yp62FHSvAS+do+w77aAx7x0syrF2AroaLzAlqC0Ruroi8FSlt2
 ULrhVRkKK2keW9XfE56IGvRNMri3Wezaj1DdmgwWWvp+8x10nDeZeKS+opkkh147EK4O
 IltBjnBS7m3Mp7Vy1oty6yrPM7f0RCRBVmHAeLCtUJy9WhrqHrEHgFpfRwHW+MiQisCR
 +6uA==
X-Gm-Message-State: AOJu0YzbH0K2+u3pMbT2OlFmF6KVlEr3NANO95rOHoXO8ECGzHXw55ZO
 IN4nDjUoEQHSz+xat2BoSyU/BlO1D+DHeSwA3CVGYrSFY8k2GH68Xc9PM2jWch8Zs2UJpmV8tdT
 nq8zXAMd4KV5oTDV2kd47nwjbiUpGClci5G6T9FdPtoPHEFndtkP22jZJ3i448ED8HUZjlLmAC1
 GDekr3mQ==
X-Gm-Gg: AfdE7clOu8f/ZTnVCy1mgUyKY2xyPYL3H2+oeeJ7FY8uVP62LlITv8yUVUEvk1U7wTT
 /6hjuXOduFR0wWcij50dUu9CDllrswE0hJ2LTrwkmsjQqNxYqTEPamYxrZ70OYq4rTBynaxTzgr
 mnn9SPmZR4YSJvGwfqaK7FaaW2x/4Hpe8aUk0//DtmjO/4GpH1oDolN/0I1za1Bj3nkD9UUDGcJ
 CKzmK+ZOG3Z3Azy2YL1OdnpA5xJPkvMXRIiCggEvn5UlVp5B2E1tI85wp/mP/l1LJrV9gP1vY9P
 dE2XFNdPl5ns1a6F05h3A3wFyKjFrSoO6TP7bJuHxkQ4noYcjaYCg083BEECQ7eeG/3pxZeDi8y
 u3sERGup9Cc99snzIOXgey4sUAibcSfbmbxrXvUTCSRg0J8v5GBytmAYz++knDwBTBmfsW5TBO5
 +JU1iB8QbyUs6adP0T4q3Spe+2ztqrpYMo/pdu3s2gd4zVGj2yO8MKhg9b0xCyJ17RQePOlQeTH
 FshwUjCkXRT1yczFQnixoQ9/Z/+b2qI7c3dzLHmWf6iWusJ4HAl0CIHItstKOvrLdblLiPbs3Kl
 bXnVcRyxC7X5JQ==
X-Received: by 2002:a05:600c:a010:b0:493:c337:db19 with SMTP id
 5b1f17b1804b1-493f87f1469mr190626525e9.17.1784126526742; 
 Wed, 15 Jul 2026 07:42:06 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4950a322c86sm145092995e9.11.2026.07.15.07.42.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 07:42:06 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 15 Jul 2026 14:42:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
X-Gerrit-Change-Number: 1789
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1789?usp=email>
X-Gerrit-Commit: a20d76761ca008d4f9485b46d59fbd2fde0a348d
References: <gerrit.1784126523000.I8219c6295acf28ff10ddb2fcc285f813c42fa8fe@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MTI2NTIzMDAwLkk4MjE5YzYyOTVhY2YyOGZmMTBkZGIyZmNjMjg1ZjgxM2M0MmZhOGZlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7b1a849bdef14093d93a8617a3db9d237c6fedef-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wk1Fr-0007Mj-5n
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: proto: correct
 802.1Q length check in is_ipv_X
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
Content-Type: multipart/mixed; boundary="===============7312644207111120298=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7312644207111120298==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Oo0unOQtFm0="; charset=UTF-8

--Oo0unOQtFm0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1789?usp=3Demail

to review the following change=2E


Chang=
e subject: proto: correct 802=2E1Q length check in is_ipv_X
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

proto: correct 802=2E1Q leng=
th check in is_ipv_X

Github: OpenVPN/openvpn#1044
Signed-off-by: rootvecto=
r2 <dxbnaveed=2Ek@gmail=2Ecom>

This has also been reported twice as a secu=
rity relevant bug, but
only later than the original finding - and it isn't=
=2E

While --client-nat would modify a 32bit integer "after the packet"
(th=
e place where an IPv4 address would be, in a well-formed packet),
the under=
lying buffer is always max-frame sized, and we never look
at the "modified =
integer" afterwards, so there are no consequences
warranting allocation of =
a CVE ID=2E

Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5 (www=2Eaipyaipy=2Ecom=
)
Reported-By: Yu Zhang Wong <wongyuzhang45@gmail=2Ecom>
Change-Id: I8219c6=
295acf28ff10ddb2fcc285f813c42fa8fe
---
M src/openvpn/proto=2Ec
1 file chang=
ed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/89/1789/1

diff --git a/src/openvpn/proto=2Ec =
b/src/openvpn/proto=2Ec
index 13fe0a5=2E=2E785c021 100644
--- a/src/openvpn=
/proto=2Ec
+++ b/src/openvpn/proto=2Ec
@@ -70,7 +70,7 @@
         if (proto=
 =3D=3D htons(OPENVPN_ETH_P_8021Q))
         {
             const struct op=
envpn_8021qhdr *evh;
-            if (BLENZ(buf) < sizeof(struct openvpn_et=
hhdr) + sizeof(struct openvpn_iphdr))
+            if (BLENZ(buf) < sizeof(=
struct openvpn_8021qhdr) + sizeof(struct openvpn_iphdr))
             {
   =
              return false;
             }

-- 
To view, visit http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail
To unsubscribe, or for help =
writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe
Gerrit-Ch=
ange-Number: 1789
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@greenie=2Emu=
c=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: p=
laisthos <arne-openvpn@rfc2549=2Eorg>

--Oo0unOQtFm0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>cron2 would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1789?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">pr=
oto: correct 802=2E1Q length check in is_ipv_X<br><br>Github: OpenVPN/openv=
pn#1044<br>Signed-off-by: rootvector2 &lt;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>=
<br>This has also been reported twice as a security relevant bug, but<br>on=
ly later than the original finding - and it isn&#39;t=2E<br><br>While --cli=
ent-nat would modify a 32bit integer &quot;after the packet&quot;<br>(the p=
lace where an IPv4 address would be, in a well-formed packet),<br>the under=
lying buffer is always max-frame sized, and we never look<br>at the &quot;m=
odified integer&quot; afterwards, so there are no consequences<br>warrantin=
g allocation of a CVE ID=2E<br><br>Reported-By: =E7=AB=A0=E9=B1=BC=E5=93=A5=
 (www=2Eaipyaipy=2Ecom)<br>Reported-By: Yu Zhang Wong &lt;wongyuzhang45@gma=
il=2Ecom&gt;<br>Change-Id: I8219c6295acf28ff10ddb2fcc285f813c42fa8fe<br>---=
<br>M src/openvpn/proto=2Ec<br>1 file changed, 1 insertion(+), 1 deletion(-=
)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/89/1789/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/proto=2Ec b/s=
rc/openvpn/proto=2Ec</span><br><span>index 13fe0a5=2E=2E785c021 100644</spa=
n><br><span>--- a/src/openvpn/proto=2Ec</span><br><span>+++ b/src/openvpn/p=
roto=2Ec</span><br><span>@@ -70,7 +70,7 @@</span><br><span>         if (pro=
to =3D=3D htons(OPENVPN_ETH_P_8021Q))</span><br><span>         {</span><br>=
<span>             const struct openvpn_8021qhdr *evh;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            if (BLENZ(buf) &lt; sizeof(str=
uct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(buf) &lt; sizeof(st=
ruct openvpn_8021qhdr) + sizeof(struct openvpn_iphdr))</span><br><span>    =
         {</span><br><span>                 return false;</span><br><span> =
            }</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail">change 1789</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1789?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I821=
9c6295acf28ff10ddb2fcc285f813c42fa8fe </div>
<div style=3D"display:none"> G=
errit-Change-Number: 1789 </div>
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
--Oo0unOQtFm0=--


--===============7312644207111120298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7312644207111120298==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7312644207111120298==--

