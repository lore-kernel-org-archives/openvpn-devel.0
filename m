Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEDDCD4F24
	for <openvpn-devel@archiver.kernel.org>; Tue, 12 May 2026 13:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YarXS5pEuRGEWlDA8O50G7Ypm5pzguaZE7NIsHIS5u8=; b=XfrZdoB+JmxruCVlNExpFUmHHV
	PVVStSIT+8YTpvFcI4AWMWUOy2Zua4onh1c7Btg+L5ZaVf/qSTfox32Xjzri0gCSRztX4dmWPNaiM
	/fzUwsmn2D8LgqYh17Eo6nRCsHbTbwHY1HNQ+tcl5OLeFC/uY/khuB9WOC26tYDWBgUs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wMnW0-0005sG-81;
	Tue, 12 May 2026 13:51:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wMnVy-0005s9-8p
 for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 13:51:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cH5svqLx8ERi/nA7K1g7OCUpMZuRu42G8nS5JFJiGkQ=; b=kVUECk+ag5jLQe4cYGlFJ4FY+v
 Ylbg/MiQQgEZlMZDg3T59dVb3mp82UIT4SUefRR8/9t38vWd0FcVD+PJMNxKPIB+0GYisRNd1ZQwE
 G81nEwWygYaaxC59d6g+lfyAQF/cd/DJy9wXbJLffWRTxNDnyCG/+TFldSeeFozRUMZw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cH5svqLx8ERi/nA7K1g7OCUpMZuRu42G8nS5JFJiGkQ=; b=P
 hpXYXb2bWHG/nGX6unWd9YXOEskdgaI5JJfj6JTJbKdn6btQgBJIg6Wzz694dyLYDClTtYU7KyMjr
 72QlkDr2esuTNv6Sx/0Fe7iajdg7D98kYnUNmQ3XDXYsfzRNpjeQ3RWC76lER4WDX62Fe3vGfp3+W
 GJJssKQvPH42ed/o=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wMnVv-0003F2-Kf for openvpn-devel@lists.sourceforge.net;
 Tue, 12 May 2026 13:51:14 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-44b052142e1so3120143f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 12 May 2026 06:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778593860; x=1779198660; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cH5svqLx8ERi/nA7K1g7OCUpMZuRu42G8nS5JFJiGkQ=;
 b=WGnavg4C4znCYJKATmr3u9coUmiyEAPax5CXgGH+ZFmc8Z0/UOrdGzDMzb5oloRyHg
 WqPWTS/vymJ/dYK8K0bjo6GFYZSPBWAlvsHopXqpZgJ68Ve871UjpMEJRtIO7nUgzPOQ
 Ext7MpAfP7a48wOxHPzyPtiLwHQYkLMb9dPl9UoLylCjdkJVkK87vtlpK2Nci6BBLofW
 A05AwBQRlMgW44KnT5GXci3Jc+4+kXhIVcHnXXjV73CDWyZDaZWYQjeWfXpx9Mv1PPAU
 HtBXd9s1ifMElumWbnhqVsmKdVTrqE0w+qnNiQaDNRroMP/MioPt94FTGppI63cNCELQ
 9UsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778593860; x=1779198660;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cH5svqLx8ERi/nA7K1g7OCUpMZuRu42G8nS5JFJiGkQ=;
 b=lGo56IzThgT9tD9GhM5ayVmUu5uj2tPJBNXcd1o1GsOz3/koNyVYpxARg9vCwFho+I
 n/3UQacO18pmq2rxDUqjlvLtrxNMYlsJ+bMt5J6NLp2+x9V5GUGkyVtWws/8dbPUqc+2
 oKLwCuzSMlnCKTwuVzYwUeV9nLYCYi8OPXwVVUFse9txu4UWk6+nL0c8iNu1hEQIcCwH
 4K/dtKc+/+s33TNR2Bv0RzIMzYNcKncJ5mpcIp4kwIlTROJ4AAYy2ajxDLIqvFaus1gI
 q+dQPvEaAsQFEN9zqpbr0NM9Aa8T06ycLhUZ9cQ0fZFQ27MDPH0kv+WzgBewEg2iL7KT
 T7SQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eUovfB2eheTvXmku7YBDBhtKIlFkxYNz7uHxVyzpq05GQ4MlpmIge8UmdyKtsDaF7nKBGpTuhVE/PMKwo@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwVxp2HNEHm9MxSlbmyC9sCwd0x954sdykoRTt/BZn8p2W+stjl
 CHQn5mD+9Vi7eqAy4wG+7QUwdQ3BTqOk71i/r70oUwnDXO3gzs7Kh9I4Bw73Zf8Gf8eK51O7OEv
 FZiHV41snbwRmxqrLzK/1Ky0CjXfFxac0zK0iaAGXPsP0+cR9VXp5+Lolnw6lbwl0QLP2F6ueQd
 FaROLdXQ==
X-Gm-Gg: Acq92OH4z8fZdf/oxSco9sODyyXow2U2lKyYvK70RHhNpf/m4QbBDANb4vv8K/p29CC
 7IgMfWIhZJqDdXsdN00zMHXkE9vQlGkjKaNI0fJqo4M6O0hRxri/d3b1b1gN8ozUCYhlTmKVlqL
 L8WDdjv/iimwjUVaZ5LOdBy1XiV2hAyurMK2GUzKID9rhOqUk9Pg7LCRyM0vgCVqgxgpA27zKZX
 VMv9j7GBmsrL9oSqk7fNKDFW4p9BH5ce+MqCqYBVBzIoZEocVM28dB7VVPX7fBQJgX5cdERmDB3
 o0uKULnu/8CYchXB0oiH2IIvvdwgZn9lVmSzo9QbXYbyqSM8je9OwH9wbp1N+0MCTrSO0RJu0tu
 DxINsGh7xAwxlUe/Z7Coy6LaO90H4Sjs2VgFEZCwL7Hug3DeI9lwxsTyXDGLQjLymmL7X6DQn6a
 dRaAOTm1dWLA/lomhKXsszmGY+4AWMIsDgBW26+xM9b7DOf4QS8lBDNMAIDKbPmAeulPmcjlGUG
 Xh3BMMdatID452Xfy5TFH0D1oENWwTD9POU4TgGpbxEEEo9e/t5EBj1ip6KIUtbFYv3jlQS23jy
 J5pZsmp54U7LorcYWG0Li/l+
X-Received: by 2002:a05:600c:4e01:b0:489:a4:e578 with SMTP id
 5b1f17b1804b1-48e706b1f5bmr256138275e9.14.1778593860462; 
 Tue, 12 May 2026 06:51:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e90536e18sm46331185e9.5.2026.05.12.06.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:50:59 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 12 May 2026 13:50:59 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8
X-Gerrit-Change-Number: 1668
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1668?usp=email>
X-Gerrit-Commit: 9beebd0a80663550b187c6e2f54d8b2f6bfaaf25
In-Reply-To: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@gerrit.openvpn.net>
References: <gerrit.1778102459000.I5c9b54dca0a14688a3bb7798cb086f5bde7311b8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLkk1YzliNTRkY2EwYTE0Njg4YTNiYjc3OThjYjA4NmY1YmRlNzMxMWI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8338887be90a753eceb33f448a38f6ed413d105-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wMnVv-0003F2-Kf
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: route: Clarify
 operator precedence in a & b ? c : d
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7840512294241807212=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7840512294241807212==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kOlq6rPWeoQ="; charset=UTF-8

--kOlq6rPWeoQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1668?usp=3Demail )

Change subject: route: Clarify operator precedence =
in a & b ? c : d
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

route: Clarify operator precedence in a & b ? c : d

As suggested by c=
ppcheck=2E

Change-Id: I5c9b54dca0a14688a3bb7798cb086f5bde7311b8
Signed-off=
-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Acked-by: Gert Doering <ge=
rt@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1668
Message-Id: <20260511200645=2E24711-1-gert@greenie=2Emuc=2Ede>
URL:=
 https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/m=
sg36880=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M =
src/openvpn/route=2Ec
1 file changed, 2 insertions(+), 2 deletions(-)




d=
iff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 3b18f74=2E=
=2E81ce867 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@=
@ -2884,7 +2884,7 @@
                             =2Eprefix=2Eipv4=2Es_addr=
 =3D htonl(r->network),
                             =2Egateway=2Eipv4=2Es_=
addr =3D htonl(r->gateway),
                             =2Eiface =3D { =2E=
index =3D if_index, =2Ename =3D "" },
-                            =2Emetri=
c =3D (r->flags & RT_METRIC_DEFINED ? r->metric : -1) };
+                 =
           =2Emetric =3D (r->flags & RT_METRIC_DEFINED) ? r->metric : -1 };=

 
     netmask_to_netbits(r->network, r->netmask, &msg=2Eprefix_len);
    =
 if (msg=2Eprefix_len =3D=3D -1)
@@ -2986,7 +2986,7 @@
                    =
         =2Eprefix_len =3D r->netbits,
                             =2Egate=
way=2Eipv6 =3D r->gateway,
                             =2Eiface =3D { =2Ei=
ndex =3D tt->adapter_index, =2Ename =3D "" },
-                            =
=2Emetric =3D ((r->flags & RT_METRIC_DEFINED) ? r->metric : -1) };
+       =
                     =2Emetric =3D (r->flags & RT_METRIC_DEFINED) ? r->metr=
ic : -1 };
 
     if (r->adapter_index) /* vpn server special route */
    =
 {

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1668?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit=
-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5c9b54dca0a14688=
a3bb7798cb086f5bde7311b8
Gerrit-Change-Number: 1668
Gerrit-PatchSet: 4
Gerr=
it-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <ge=
rt@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--kOlq6rPWeoQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1668?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">route: Clarify operator precedence in a &a=
mp; b ? c : d<br><br>As suggested by cppcheck=2E<br><br>Change-Id: I5c9b54d=
ca0a14688a3bb7798cb086f5bde7311b8<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1668<br=
>Message-Id: &lt;20260511200645=2E24711-1-gert@greenie=2Emuc=2Ede&gt;<br>UR=
L: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet=
/msg36880=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>M src/openvpn/route=2Ec<br>1 file changed, 2 insertions(+), =
2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route=2Ec b/src/op=
envpn/route=2Ec</span><br><span>index 3b18f74=2E=2E81ce867 100644</span><br=
><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -2884,7 +2884,7 @@</span><br><span>                =
             =2Eprefix=2Eipv4=2Es_addr =3D htonl(r-&gt;network),</span><br>=
<span>                             =2Egateway=2Eipv4=2Es_addr =3D htonl(r-&=
gt;gateway),</span><br><span>                             =2Eiface =3D { =
=2Eindex =3D if_index, =2Ename =3D &quot;&quot; },</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                            =2Emetric =3D (r-&=
gt;flags &amp; RT_METRIC_DEFINED ? r-&gt;metric : -1) };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            =2Emetric =
=3D (r-&gt;flags &amp; RT_METRIC_DEFINED) ? r-&gt;metric : -1 };</span><br>=
<span> </span><br><span>     netmask_to_netbits(r-&gt;network, r-&gt;netmas=
k, &amp;msg=2Eprefix_len);</span><br><span>     if (msg=2Eprefix_len =3D=3D=
 -1)</span><br><span>@@ -2986,7 +2986,7 @@</span><br><span>                =
             =2Eprefix_len =3D r-&gt;netbits,</span><br><span>             =
                =2Egateway=2Eipv6 =3D r-&gt;gateway,</span><br><span>      =
                       =2Eiface =3D { =2Eindex =3D tt-&gt;adapter_index, =
=2Ename =3D &quot;&quot; },</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                            =2Emetric =3D ((r-&gt;flags &amp; RT_METR=
IC_DEFINED) ? r-&gt;metric : -1) };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            =2Emetric =3D (r-&gt;flags &amp=
; RT_METRIC_DEFINED) ? r-&gt;metric : -1 };</span><br><span> </span><br><sp=
an>     if (r-&gt;adapter_index) /* vpn server special route */</span><br><=
span>     {</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1668?usp=3Demail">change 1668</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1668?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c9b54dca=
0a14688a3bb7798cb086f5bde7311b8 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1668 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 =
</div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cr=
on2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>

</body></html>
--kOlq6rPWeoQ=--


--===============7840512294241807212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7840512294241807212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7840512294241807212==--

