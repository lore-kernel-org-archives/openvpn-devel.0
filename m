Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C26606A31C
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bouSaUXO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i+s4HXVW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jn0jrb7B;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Rlw83Ape
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/rIW2YAWx62saZ6hPC8O0cbnBIXnj1l70u80zTbkgzI=; b=bouSaUXO/f+yE/dK2bT4M90kJh
	ArajK2zu1m5g93HBe61A2BRv67dYBRQjamOi3VVYlvag62K8YomRgj3m3XDLeaIv5BfD507Rn7Ur7
	VMfI0tz8ZWNCSwjVUwWzjOagC/PY/Fu2Fr5SrvvWy0fr4mRImH04uVzlONBj9nk0MwKU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNBi8-000000006c8-0DL8;
	Sat, 31 Oct 2026 16:13:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNBi6-000000006c2-1Yl3
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sj412B+WwLOfSYgYUHUnYRFxHjliD/nKrk7Pozs/eLs=; b=i+s4HXVWB+k4ABR8U6zXBJO+pT
 5RGDSatPb6Pr7JLMbxIFqfRSsYHT5vgEH6vymDTpsrh4gEE9Si9/4V8aMl+Nz0E9Gw/fBRuQfJ/cx
 79YCWCJkTN2nOsdd/x/X6tHcq4z+c3TGXDC/7f9h5wcz0gVqsCybKhi2VeG2UmI2XTVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sj412B+WwLOfSYgYUHUnYRFxHjliD/nKrk7Pozs/eLs=; b=jn0jrb7Br5TpmUnaKH6p1w8xJB
 OkC5bIsAynCG56MdCbo6UdCao0XGO/+6GefMRm8qkUJK81E3OcoHw9wM213DR6aW757zvQMDC8sj/
 att92ya9LCIeMB0ioExIKyCIzeIo939SBXDc1QJRv00FjN+/FOUVeOYdwhLX3+iBzW1g=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNBi5-000000006bs-2kfq for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:13:38 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so18165135e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793463211; x=1794068011; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sj412B+WwLOfSYgYUHUnYRFxHjliD/nKrk7Pozs/eLs=;
 b=Rlw83ApeR0taRBevi6QPC90+Gy3S3Lrt8oWzEiY82Lacv9l/QtAm7hRA4IBCycG2Jl
 Lb4uDoJBo3zftJ3n9Owy/8LZ5eIrWWjYTu/hp42FlfOa9YbosVwxw5s1d2WZ+BNYnl6F
 Jpbpc37zdXpWU5ysVsYzkgfMtnKu/BZrTN/9VIS7QIlwyxkEmimRRhUPv0Mb2FbwTmLu
 0Xk6k+kzfcUhbrYace7UFuWq1l5XCM7t0MuWEbmG8yOmvbaT3rD+lNz4queQUqgoxJhE
 O3eMQvSLXxVW1Ct5eR9lqlJw7MRrx8eK1hiU2fYvjUySSS+nMFwPml0BDEB3EBeEeXai
 Hg2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463211; x=1794068011;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sj412B+WwLOfSYgYUHUnYRFxHjliD/nKrk7Pozs/eLs=;
 b=zf1ArLhrmT84UmUwNLLsk1/ry+OW80LBotm83l3NmD0y+gyFwuNHzleIyZc2HIIe2s
 oSX/JnqO/oPsj5rQ9W1naq9TTioK5uRmhBvW60pv5IMTtC2CHryBc1WT0aEdeVhF582t
 +cf6h1NJqItMYul7WcjE6b5VIkhhoXXoKSEZdLSNL09JopdyacAflz0OeGk35yQP8Zsl
 ZCZSVLnBlAChkVGVqb3He//UD1ssPBQ2vHD4x2Awm3qBzG538fP0TsL4tN/MQQtq7sbP
 LJbXDSIDa2mkyrQVgTLFuDOMSSUbPF9nDjzZRd6p5U7wMo7ODUjOgOrvLCMik4iVqDVa
 a/fQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwEeJMtIiiIpCmKXcrS6UM2WkivG8QL+LgVtd035T8ycsWFE90sU0KFhqggPfGo4Kuwjdus7B8yqNA+azTr@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJuElvD7uB3SFGZo3qAYdwWjGQaiGq31LdRJzBroRjj4NAYaiqn
 kDeA2Y79BMqTQOnicIzmQiV0R/EeJ6kh4/ty8oCT4n7NhYyLYALAQsOWuA4yGLvopZzg7nMlUJB
 QwXl2lDbyEaWTa5CHpUOU544TEw4HUR1Urqhq+ri8mPVyFSA2Q2BfSuSm3PVHlAg04EqL
X-Gm-Gg: AYBFou1aNW6WFOqvWQ9T+zyCsiaAnBI7rlBZWlYQ72gYOaHKeFBtOnqatr7teTnbOhz
 DaKRXC5bk4laJWnPaKUsC2DtnehYg2fEBHbZ+UgD1mcPkDwOy+cIIXPK93RmvKxCH7lfVSIGuW4
 30IA5YXoXfEeAzr+1I2N8gwrK+LVcjETndEFD5rVeY8oNlnHQYuuaItZFjhYkrKg28jC/3aOIKG
 XG6Mo4cmcyvp1HeV/f7U1sgU8spKhORZ2U+JV/dQnvYACt4bbmLXTLOTu8DHlAK91nq9uSq7hMC
 nlsXlUnqWvo8W0tnoU8ltzv2MnYN+YVNX3Lcu22xAVAgx0GBie1mSmsXI7oJEY9Q2s/cOXwKreD
 qPNphblY5y2eQ/BtL0P+w+LBxlhIhq+mk1cVq9J5e5xkhKAUw8dVNmobxmZOOW5ldfWxDBEb3Gi
 y3vvWWx4WLDmXM461SBk+FXk6Nd8biLvKEkWEZbd2CCZMYNoawELMGmgIldYlZRASmlhtGdc0Zd
 tpsuKN03itlsJfaGxaZDdLwOOGfTFy9PVnE1mclNuDOiWVMYDMYIl3RW5dmHKfacbkc0+3f9trq
 7nouwbh7eKATXThTIGFgVVztfgyTVR+4woAcHlcnO5QsNcP6wqzWafRuUFIpmJHai5SqkAQNmOE
 7cAWmhus24VWqU3vQq1wBq4CbDc3C5NDWsLetfCtCptm1m2c7m32LVTFJUY6vbnS/e4v1vxSpK7
 baiEbEwE6O8nEnFJE=
X-Received: by 2002:a05:600c:4f0f:b0:4a1:e00b:a10b with SMTP id
 5b1f17b1804b1-4ac17b2cde9mr142332675e9.7.1793463210954; 
 Sat, 31 Oct 2026 09:13:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa81a896fesm239321225e9.10.2026.10.31.09.13.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:13:30 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 16:13:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4
X-Gerrit-Change-Number: 2058
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2058?usp=email>
X-Gerrit-Commit: ba6967b7f023651c42e32b0d4f4b5279692e0778
In-Reply-To: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
References: <gerrit.1793187249000.Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTg3MjQ5MDAwLklkZTVhMzA2NGU1MWQ0YTIyZjkxNGU3NmMxZDgxNjVmZGQ0ZDAwNWY0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c1ee402ad44b35156ac2650d24bd805482fa14b5-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNBi5-000000006bs-2kfq
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Mark buffer invalid
 with username mismatch in server side float
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3768158644629601893=="
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3768158644629601893==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jk3HD5wfV+c="; charset=UTF-8

--Jk3HD5wfV+c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2058?usp=3Demail )

Change subject: Mark buffer invalid with us=
ername mismatch in server side float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Mark buffer invalid with username mismatch in ser=
ver side float

Commit d42a9912c1 introduced a check to ensure that also th=
e username
is identical for floats and not only the certificate=2E This che=
ck did
not mark the buffer as invalid in those cases like the certificate
c=
heck=2E

Reported-by: QiuYiati on https://github=2Ecom/OpenVPN/openvpn/issu=
es/1137

GitHub: closes OpenVPN/openvpn#1137
Change-Id: Ide5a3064e51d4a22f9=
14e76c1d8165fdd4d005f4
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
Ack=
ed-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2058
Message-Id: <20261028122226=2E3006-1-gert=
@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@li=
sts=2Esourceforge=2Enet/msg40227=2Ehtml
Signed-off-by: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
---
M src/openvpn/multi=2Ec
1 file changed, 1 insertion(=
+), 0 deletions(-)




diff --git a/src/openvpn/multi=2Ec b/src/openvpn/mul=
ti=2Ec
index 2e804ff=2E=2Ef211ef3 100644
--- a/src/openvpn/multi=2Ec
+++ b/=
src/openvpn/multi=2Ec
@@ -3172,6 +3172,7 @@
         {
             msg(D_M=
ULTI_LOW, "Disallow float/connect to an address taken by another client %s"=
,
                 multi_instance_string(ex_mi, false, &gc));
+            =
mi->context=2Ec2=2Ebuf=2Elen =3D 0;
             goto done;
         }
    =
 }

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide5a3064e51d4a2=
2f914e76c1d8165fdd4d005f4
Gerrit-Change-Number: 2058
Gerrit-PatchSet: 5
Ger=
rit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>

--Jk3HD5wfV+c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2058?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Mark buffer invalid with username =
mismatch in server side float<br><br>Commit d42a9912c1 introduced a check t=
o ensure that also the username<br>is identical for floats and not only the=
 certificate=2E This check did<br>not mark the buffer as invalid in those c=
ases like the certificate<br>check=2E<br><br>Reported-by: QiuYiati on https=
://github=2Ecom/OpenVPN/openvpn/issues/1137<br><br>GitHub: closes OpenVPN/o=
penvpn#1137<br>Change-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4<br>Sign=
ed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>Acked-by: Razvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2058<br>Message-Id: &lt;20261028122226=2E3006-1-gert@gre=
enie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@=
lists=2Esourceforge=2Enet/msg40227=2Ehtml<br>Signed-off-by: Gert Doering &l=
t;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/multi=2Ec<br>1 file c=
hanged, 1 insertion(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 2e804ff=2E=2E=
f211ef3 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>=
+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -3172,6 +3172,7 @@</span><br=
><span>         {</span><br><span>             msg(D_MULTI_LOW, &quot;Disal=
low float/connect to an address taken by another client %s&quot;,</span><br=
><span>                 multi_instance_string(ex_mi, false, &amp;gc));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;conte=
xt=2Ec2=2Ebuf=2Elen =3D 0;</span><br><span>             goto done;</span><b=
r><span>         }</span><br><span>     }</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058?usp=3Demail">ch=
ange 2058</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2058=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Ide5a3064e51d4a22f914e76c1d8165fdd4d005f4 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 2058 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--Jk3HD5wfV+c=--


--===============3768158644629601893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3768158644629601893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3768158644629601893==--

