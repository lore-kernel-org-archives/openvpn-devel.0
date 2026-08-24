Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2204C5DF9D
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZPxv/VDO8ZKgekQqoDvbEZ75z96iX0vH0orkhRkY3LU=; b=jRTfGGTA7FObTu1H/SjNqKBJ4F
	oBL5KdXO/uJOqSVzWUFGhDljt6L2TCiBmeokASAh2YOJmjG7vryTHuu294A6eSKx/E1NS4c+o9PuL
	FHMK0jY/QZeibEsbxFYIYcryElMPq6Xxit4zI1kJFecKpTqzn9QaXiIoItDUoNV7SiFA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyWjL-0002Ga-NZ;
	Mon, 24 Aug 2026 15:37:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyWjK-0002GU-RB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:36:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=SyKnyRvrcHlfH8GnjTCNkQn/KITSJc5JvIJtlgkAS1E=; b=ASJ17jTwRD+ZtfaxNlqQcQ2gJn
 wsxiw3FrW2Rw3ldC3TJ4dL856Zzp0WOwTVMa0UlXel8dd+/T3Z4d55BiJdfVQJ/GgRl/a9aU3g5ne
 M9x2D22/j8z3ABxr11ZuACE7REP+U7Jnli8ILJL/e+kRzMlwd65rspX/3CrsevK+lDpo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SyKnyRvrcHlfH8GnjTCNkQn/KITSJc5JvIJtlgkAS1E=; b=Z
 vrx9gvGHoIqhkLUeClM7PeAy1vllDLw7U5t9PsDOak2JasVsQe/DW39DeeXXWxND76+LITcDjtIuN
 squfFJ4sVAJhtpGWQ11egIztJVXdTCSDjVOX55z49Wo09bWmXm9T0xvaAPmt7WbAX/+dHd3v4rOaZ
 D0lTGRq8O9KzrMvM=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyWjK-0005tk-4u for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 15:36:59 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15d111ca99so436169366b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787585811; x=1788190611; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SyKnyRvrcHlfH8GnjTCNkQn/KITSJc5JvIJtlgkAS1E=;
 b=BmrSrHnOtLv7eN9Hj1ZtQ4H9puFmtF0dBx+htWQ2X7g/sILXSlHdYIFLjtnunUPfzk
 jxKheBeXie22u9QdAkvTY8mohy/XTZoLv4wbnz2TeLc+f9BeDpG/GfpYp+PaPMitco7S
 0O4BJ2DNorLzh9bYGk7dpCxnbN4vxnR3P54Pr2+CTnkAEwOMCZN4Fbp1L7wzRzIc6T+d
 HJ/lzk4OlfKqcYIqfVBVgr4QIe4L/46lmwJOo0MBmEPDpWLb22/QbeNx9W2W7kDE3U5t
 BshudL5XQY3okVmxu9OyrlnA72niN+nV8PA3FmokA3d3hvfSVGhhZiNqaNPJh0DolR0C
 BJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787585811; x=1788190611;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SyKnyRvrcHlfH8GnjTCNkQn/KITSJc5JvIJtlgkAS1E=;
 b=Aqr7RH7jwyTmAxeA3IqeEwBDl5xPW8ZBOCpzMwfVZlDArUrqZq3Xjbmzv2IReB9UC8
 yUt+e7UGAxTWP7GipJD0jqfgKdQjFaBAs3kwqJysqOifv3mAh/U5r4YywXm7XlRUA139
 gfwk0kQfmuFeZs2f9fnCNCYkvL4QiEK2ZZEvf2MGoGrSPpgc45XS0nwNyXu3kPUeuCXS
 Fcei+s+3S3aO3IUNsAEbVb3/U4gANO2oQYW56txL8/ZIG0aSz9vsCplww46Q3omExQWj
 bmOtkdCuLjq8Z3KxcrIloCGBrnkk3Loy2dWUV1A9TN3XgJ5GsgdTx3rg7b4t1+HPVpk9
 82hA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpW8JhFWhnZcEB/Oi40pAJSJT1xiD4h6KC2gOzGaQYj2uBbgfsj/7J0kMtlBkGLtnd1QSXiA1j9i+RPLHow@lists.sourceforge.net
X-Gm-Message-State: AFuF++kH95bnhXQ0GK6SlRJoatdo2WfV6v6BryA8CFX1kVB9hWRJfoEb
 YaBxpo6O9jGVWDa7Gh6p9WF581rXz0p3wYAWAkoHsC4SIfJSxivARJbRgKTw/8yBgYwfchDnlvN
 x3BGeIBEPEX95Z7iAwFWNi7GnWqucMF1q43nU3iGxiYz959bpOpxoLleARjvI0T1D8afUkvYObs
 5t7v6MYw==
X-Gm-Gg: AR+sD1010rI91Lnvp1Vt2EZQ3gA28gfuSMWtJRJH4SuaG54ZMN0e/9alGz7Wuf2XCK7
 bIpm8rthoSWeYBttxIUAirz+eUk73rWpc1q0WIeBUIrRNkMka2wxobT/G6ygTPmcsCRMl9XPTHM
 InKZ1me7GFfNKnxMa2gCrwzgjFEwsM2vNhDmdOAfojDcGBtWqLO52T3VZMm1ZlUB41LTKW1wwVZ
 CIgLE9lRkkbKw8raHOXQ9Ht+YuE5iBdrTueA9yT55bAzncNJO2KhvhBIV6+6WADKeDfmYUXvUyh
 +E8M4KMaMzCN5yaPKruLPXB0rFhxvglzgZLfGmiCQI3Q8whT5xVDz+4Q22JnZEi/W6ytHEl6YZ4
 sMYtd48Xa5XR09jutdqUFVzBo68G/WwvdiCPs1fDaSyKz6e/8jZxZVU5+FwyqBd6dSEnkX7qECV
 oqgBvGd1FlOu7bTe/KcUO+u2hk4ZBfM/Nc9HuZZ8U/6WDpLMzbgQSIBDsCfJCefG3NnVyqpGI4G
 PCp8aFJHENXW2Pyhov9SsSrt9atqR/T64I3VeAlz+hQwjzxi8R2rdk9Q4qRiSTuOI/8t6HIRc/d
 PxMJW0qxbyK/wZdG58Ja3y4ligqpur0omSgvV1pk9kS+7tw0bII=
X-Received: by 2002:a17:907:3d42:b0:c12:6632:e7f0 with SMTP id
 a640c23a62f3a-c2492797eb0mr2194390266b.24.1787585811277; 
 Mon, 24 Aug 2026 08:36:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c249689fa1dsm1251105866b.56.2026.08.24.08.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:36:50 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 15:36:49 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
X-Gerrit-Change-Number: 1861
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1861?usp=email>
X-Gerrit-Commit: 4cccdf6e27b97d01e33a9b95ddc6ea1f1252dc24
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 15:36:49 +0000
In-Reply-To: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
References: <gerrit.1787438913000.Iec392a47123d618c0dbc3a5241c39da4ac83d880@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NDM4OTEzMDAwLkllYzM5MmE0NzEyM2Q2MThjMGRiYzNhNTI0MWMzOWRhNGFjODNkODgwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7625cd6b828c2ad91990e5870d87a01ca04c2b95-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyWjK-0005tk-4u
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: fix log
 lines format string
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4274528876831485416=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4274528876831485416==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JzNPcTSapk8="; charset=UTF-8

--JzNPcTSapk8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, plaisthos=2E

razvanc has post=
ed comments on this change by d12fk=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1861?usp=3Demail )

Change subject: openvpnserv: fix log lines form=
at string
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1861?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Iec392a47123d618c0dbc3a5241c39da4ac83d880
Gerrit-Change-Number: 1861=

Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@openvpn=2Enet>
Gerrit-Review=
er: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-At=
tention: d12fk <heiko@openvpn=2Enet>
Gerrit-Comment-Date: Mon, 24 Aug 2026 =
15:36:49 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--JzNPcTSapk8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, plaisthos=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail">change 1861</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1861?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iec392a47=
123d618c0dbc3a5241c39da4ac83d880 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1861 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@openvpn=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Mon, 24 Aug 2026 15:36:49 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--JzNPcTSapk8=--


--===============4274528876831485416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4274528876831485416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4274528876831485416==--

