Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5077CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 15:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BM98HUkooBNoGKYbb4ZCLbn6uQ3xfNkHDt35+0y4upU=; b=HzJFrCVODLjzqQ+R6lQzqm4VAT
	oxEYbnOtPYGui7lj976jymFJwAC10Sfu7NP0OkUeUraSI1KrTHrHIIHsYRQoXCFzTQOe4asYR8R+D
	n7xnieGdOPzklC1B3bf7NxwujVeZTd/RuEhLh9AqeasJPsMewPu6Eiw20+YuRAC9bElg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIT3E-00081T-7A;
	Sun, 18 Oct 2026 15:43:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIT3D-00081N-Aa
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:43:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nyQ9G1znaAEJj/Be6Fny37f2WwHGihR/hyGqpCzoDKA=; b=FCm7DU9HNYsXFVxZJvX60xh9/o
 0ad3Hkf3GW24jPU8v4JsRGOdsEz4o1RU++kbGpmr+c5RGx2RzTrm+LN0HNi/E28JGe85Lb7Kw8ss8
 W7B7FMsWdA4042ikZ9c18zJ4KJGGV+vNEUPBmKKZnUtSOiN05Qpj/INNP20W+Z4Roi1c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nyQ9G1znaAEJj/Be6Fny37f2WwHGihR/hyGqpCzoDKA=; b=S
 L1LzsZbJrZjaog1qfvsejqjUCby41fWyVWJSGKNhWNjyILcEyLuvoAp380fp37iHY6lT1vCeANnGy
 wPcvU0musJePtTn4r9WH3vxbvLZ8cu0Hu7AsWcVE7/3atM8Fmkf8a/Td3aMYqDGzGnPUMwfiITnox
 5ds4FgaSSYP9maR4=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIT3A-0007xe-7j for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 15:43:52 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1dede3c2cso11945475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792338226; x=1792943026; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nyQ9G1znaAEJj/Be6Fny37f2WwHGihR/hyGqpCzoDKA=;
 b=KQR2c2bEZUF5MXJe+FHaQScNsAsUdRO2/NQJlPCPUzGhiNdDCAmyrvEnYakqsVy55t
 xIQfMeiEEqqe0DExK8fUGCgf+4Sqh+s6wKeQgPgNN4pwU1LWxTqumVXCqXKA5ntc1yf5
 lvOUOqO2aEvbsWwODmIkGoSEJkXdjXcD3PwgTUInTvOB2fErHF1R4Z4Q/klBfcG4t+KV
 Ny13DuH2g1ktnzGsB+Lsze9ITmtmG+tWnTS1f310X56j547as8wLTWlffO0+kS6n5c+k
 Qq4Kltte/Es6KV3dlrKfQ2iFRiNrRE7vCy5ii40zdD7ykgpQp16OBem4KPkTektflCvw
 ckog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792338226; x=1792943026;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=nyQ9G1znaAEJj/Be6Fny37f2WwHGihR/hyGqpCzoDKA=;
 b=gjgJiF/3fPA9nzrIB8/1+6UDi9gcFJHiVnFvi1Jso5yF5DbSX3xXAIk8wE7y+fjjBF
 YTEZ7e4fx3XDSDHe5q+wy+pYY94JlwIkzNHJBANBY9/8IjvODPg4x7mh3k19gWDBlA30
 uefBDFxD3ifqtOVz+8zRt25Ds8+mNMjRoo1Ky/hra+z4oGliG8sYj0kbCYmeedfyrXJl
 Lvt9Kjqx9Xz0nR3/6Six3M1eDSpVm8QSRmLGgyjDOq75f+/gN93N6/E1JVXGiVdOBpjZ
 dI2zjmcPtm/6nbi7++dkTOVBMA9R6/X5ASt5CjkGjn8NcQ0Sqn8MtrlrRkCRz4ucGogV
 vsPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIwLq19Cw/rWWbLXr1kPPkdPRDVMGGC7A4deMr6cM0Jn37UgFaC0eJRFH0ifarkLUdtw8AogvMsp+He3RH@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIpiPTnE/QEh8V/cRYSDyznsVcAKjDAUSyTktYRK3vP6Lk+acuQ
 rOcZ5S5QU40fLrSmg42/ZFVEwpsAwdbgatk7iRUmeuuMZ/5fYWwYaIVwWJu5mmO9fYehILzh9fy
 1950A8OergIRmKp1MdzSZ8iK2q7O8kq/Hf2ftLr4uqbkbBkLOa+fYkQkMj0/NuPYgXusq
X-Gm-Gg: AYBFou3j5YL9rghvZ5lCrqs0uc98NrifqhJmThSGhhxSS7IfeyFzvm30kDmB3IN+4JG
 /cc0hxs+EWh+z/YPKAPujDjunI6eogS9EGdjeekpWq7K+FG4BH13OBJgRcF1Hfc57Qg+q5gWSFd
 YImVgPhoZYWcVw9lbmAWr5bbFOIymT1V41Jaawz5UQsFYL8WYks0B9n7lao6VTyma570pJDDoLt
 v8K4ZnlRqjq3KiR2pa7R4ESnnrIknoTzXf/CLLGIlKpzPUaI4G0yXOe3/p4MVUn2+yhvPSqEgX6
 mi3Vl7Tgg0q87bhzQwf01JDD2Zw9jWu18eE6KNpi5dkdiObqlvkGF+bm4pN+O8NUn8ufjrGnqMs
 ty+Aq4+JrEvoZUBmUabVD4IYpxrXzdbLRRPyj4DTKaGhrC4Co5vb5WQTT84IrtZZ1oZIutZTFyg
 brlNXAn2sfCiQuNGlVZzFnkKfa1Xvw8avHR77FAgurLkBgG89f04ido1waFqY/1GX329WGmQWKS
 g9JXjz0e0kWv+O2OE3Ogbj1oNA1MxCK6nAM+3zVJSRyeYitxWn+m0K5KNHJD3ifRp6qb0/uUQml
 DZAu12KQLexTgzA9+Lpvmr+1fpov256mg8iZuO1F1GhVSpsa8uPIPeY5jXzQ
X-Received: by 2002:a05:600c:8519:b0:4a1:722a:d2a3 with SMTP id
 5b1f17b1804b1-4a1d760d830mr141835055e9.23.1792338225549; 
 Sun, 18 Oct 2026 08:43:45 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b303csm293121315e9.8.2026.10.18.08.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 08:43:45 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 15:43:43 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1
X-Gerrit-Change-Number: 2006
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2006?usp=email>
X-Gerrit-Commit: 57d2a152f6e2206e41471deb040580e6f27fe1d3
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 15:43:43 +0000
In-Reply-To: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
References: <gerrit.1792255622000.I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLkk3YzU0YWJhNWNlNzcxZmM0YTEwZTRlZmRlN2QxNDcyMWNiY2Q3YmMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1f57f2e5676bfd2d9f49335b701f02bfd2f25fac-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIT3A-0007xe-7j
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_openssl:
 Avoid conversion warning in hmac_ctx_size (1.1.1 vari...
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3510073030079861950=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3510073030079861950==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="01lASfjkooA="; charset=UTF-8

--01lASfjkooA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

G=
ert Doering has posted comments on this change by Frank Lichtenheld=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail )

Change subject=
: crypto_openssl: Avoid conversion warning in hmac_ctx_size (1=2E1=2E1 vari=
ant)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2006?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1
Gerrit-Change-Number: 2006
Ger=
rit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: =
Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Sun, 18 Oct 2026 15:43:43 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--01lASfjkooA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Gert Doeri=
ng has posted comments on this change by Frank Lichtenheld=2E</p><p>Patch s=
et 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail">View C=
hange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2006?usp=3Demail=
">change 2006</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
006?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I7c54aba5ce771fc4a10e4efde7d14721cbcd7bc1 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 2006 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;gert@gree=
nie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Sun, 18 Oct 2026 15:43:43 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--01lASfjkooA=--


--===============3510073030079861950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3510073030079861950==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3510073030079861950==--

