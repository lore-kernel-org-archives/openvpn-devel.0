Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDCFC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wZFue7SXBDWL31ZPHsSxhG7Q6YMtDLfp6nSeATGsYWM=; b=hoU2qbpPzyBaaYsmYnNwSP2Srp
	VNdKJcm6r9yuHWhC/8o7ts8x4HVE+8sRwtgF7Xay7oIq1TNZgkkimBOxc0lxkbLbO61fGiq5ytR5J
	Ze7jqb7CurWSXMuW4zdbmo+/coeV/KZJqMyrts4PCO5mxQzaJdUHt0KBIL5FauSfhd5E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whUOV-0003Xy-Ph;
	Wed, 08 Jul 2026 15:41:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1whUOU-0003Xs-Ki
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:41:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gSJ3LjKct8IuVJ8KkvLZABQ9Z503XT03hy6y2kNa8LM=; b=P224iuVLVe3O04tUEXFR3G1sto
 36FWmZ6VZRv8DXnqXicEZFF4eJ/7K7Na9Pddb67PlEwUuZdFYV5aQQuDiNCfZ/lznFgRGMuGLVfdc
 d25f3f7Rgn0pem+Xs8Rl9QPXNcBHNNKyKNgBXuMtDHu+BbBVCja4YIfOsfIdPsCQ2WiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gSJ3LjKct8IuVJ8KkvLZABQ9Z503XT03hy6y2kNa8LM=; b=l
 gu1gE3176K6LJwWAR+aczcSIzC29BC7VyKqAh4SZ1QEUXx09GszZyCbb0eKqE14d31RrYPqEYXf37
 tJdrZpfsLRZgjFrwQJeVpsVyyieTfSYPKT1PGlQ0DmkJoq5IIvTCQ6LSFu4Qhx55nzOU8PRuBvgc/
 j41aE1MBUBjOJbvk=;
Received: from mail-wr1-f41.google.com ([209.85.221.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whUOT-0008GC-1A for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:41:02 +0000
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so523702f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 08 Jul 2026 08:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783525249; x=1784130049; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gSJ3LjKct8IuVJ8KkvLZABQ9Z503XT03hy6y2kNa8LM=;
 b=MdGWY9DIGsSqYd+OfB6rDVEYHr7h4eZr9zpVg9SN0sIbYIIom/B4BhfebLbv+Ss0xQ
 yUDtiKL4Mb6VM5EEdueHa0WMAcUEDpUbW/0pslA2qkv5kdvAR6HQ2BHMnRwfGLETWKGw
 i2W2nrCe2hboK3SQzssBFAGrG8slOxd++Apm29ca27vg37ER5tW/Kv+vO7QrGJ7XmNpd
 lmlxmVfEFGl34NmODKdhP0qKkyY0MNjWcxpb/zHk5t6ONVaqsuRcy/Uo5zMR9OKOmvYR
 rNt5XK/azezYqy/AumaSnIGYr9ve7UIGxcP06tGciTsRo+H0Za9gGOKG+VRRWsNho3En
 /wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783525249; x=1784130049;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gSJ3LjKct8IuVJ8KkvLZABQ9Z503XT03hy6y2kNa8LM=;
 b=EUL+Sx3p+exrYzCJ8vT28xq7aVRh9rGDgOtzjgsjOkfx8T8rLhvrytij9qTqnbY79H
 gHveUopVVtHKacFth4nU1L5vw3IDsDS0Wzzo2yVts7gy4bqKyrzHCY/HMlT65CkAh89s
 58hkxdS+Y6Q79s3eUgpVpFGRtRNG4BirGOBn8uSzTxqG9Ui+alVU78gmzkdJ44WXM0zM
 HKhfiEnVWjlCUNN55plnEcfKj6n05J1CPO0JOBCuwTe4fvlqfWq3NRYvAKzTZ3Fq9TxB
 ygRjIgnOy+H9miG/xNdKCXcytAjogkNxqB0ZzpyK8gwTU1S6ZdKRYifizNcRd2ENjSHh
 qHKg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpXO1+fjCQdnTTqLRXa/TLK5krNWVDGKwRjoUPG95d4MXl6cZ7pW5vM5+eEoa+a2LK5PcUP/bTD+MzKEQqA@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwZpWzz+z9973f++6+2ry2OGKTq8fPkjXRp+KSGzVz8Ua72Vqtw
 bA10EY8pKtQM8ZOOX13zN0MtW473rWMl1W5dqnldI96ZeAuXEM7shfDf8uDDhs+6pw63Y1eyyWy
 y5+mSc0TQe1/kFkoDvguc+M+GAMI5VHgi9V4LejqIpO/AhUMIHyZJC2j7z6BbM6NKhXdz
X-Gm-Gg: AfdE7cnFr4qRRb8DbCWs5CqG3rzdhik/KpsVjx46mHkXpGNpcBdcXXN3nIJcnM1xLqV
 QgY4sMqEa/jktJSCSzKiH5zgN9IPOsal1TnimWLhSjLeSRIOqsZYT9gFS2pi85VjwVE/Xq2++PS
 Gd9AZU0p4/G3AAUMxzrAXROaVa7cUCeJInN/eHSo7HzA/1tHM1fEP7KyrqXBCc1pg2TQgaQeQXF
 DCjuOq9UdPDYJlH55EUDsc+ICEJI9gq7bERayFwXI2417cBy0VjOqTVVq68Sl1ByQPDgzKr0vP0
 OaLVh08+PoevR9fb7JKbQtd8WPFg/PRX+Og3P51BVMacJTgezWqyC5N6R3P7/7rQCWHF9B3krRS
 jh8rGtBlbsSaZsyTSaqrSMBVt9QbAtmU0ij7u9ebG1fCJrTGUzNdvIo3PZRbC+o6TClwsbnRMI/
 wZXksJXdk9rzKQeDG5oT+1qXt7FHOo07G1CRYBvIR1MqPN2uFf3Xj0TWrXihZzrrZMkPvPsmM6w
 nc55IiiDoNbVk3VeJ3A7qOr2aL9jWc4faWBThuQzqDoxLUWjMROHPDskP7HqY31Ho5yVOXz2s49
 HlM=
X-Received: by 2002:a05:6000:1a85:b0:460:1223:a044 with SMTP id
 ffacd0b85a97d-47df06c10c9mr3714823f8f.0.1783525249402; 
 Wed, 08 Jul 2026 08:40:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960af0sm39887267f8f.30.2026.07.08.08.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 08:40:49 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 8 Jul 2026 15:40:47 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
X-Gerrit-Change-Number: 1740
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1740?usp=email>
X-Gerrit-Commit: 837260c57e6dee5b2eb106534d12f05f3e7dbbc0
X-Gerrit-Comment-Date: Wed, 8 Jul 2026 15:40:47 +0000
In-Reply-To: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
References: <gerrit.1782719911000.Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkljNjc3ZjQzZmMzZWIwMDUyZjhlODBkOWE3ZjA5OGQzNGFkMDNkZmUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3a0205ffbaeb0cd01807940eaa2cc21fbf41e8d1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1whUOT-0008GC-1A
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Add
 buf_read_u64() and buf_write_u64()
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5586745378714268858=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5586745378714268858==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kSRxarAkgnk="; charset=UTF-8

--kSRxarAkgnk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

flichtenheld has=
 posted comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1740?usp=3Demail )

Change subject: buffer: Add buf_read_u64()=
 and buf_write_u64()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1740?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: Ic677f43fc3eb0052f8e80d9a7f098d34ad03dfe1
Gerrit-Change-Num=
ber: 1740
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Dat=
e: Wed, 08 Jul 2026 15:40:47 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels=
: Yes

--kSRxarAkgnk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail">change 1740</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1740?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic677f43f=
c3eb0052f8e80d9a7f098d34ad03dfe1 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1740 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 08 Jul 2026 15:40:47 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--kSRxarAkgnk=--


--===============5586745378714268858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5586745378714268858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5586745378714268858==--

