Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54202606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 13:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j1ouRanC;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WlqJ/rDl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gnK020jf;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D9Rdm9mf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=2NIkBNgYcSyttkXw84n/ZAiK5JIaI0kOcxJbmHvoT8o=; b=j1ouRanC14KvNIiMWm8BOfVWQ2
	vsxgjEDs6fQSedhxO1J/TjN6dtDECMyi14GUDpQAGh/pUAhBlcTVL4iA4yFZfIbDuGpAmmgaDOyEB
	mb1wl6WqacUjCDYbCH6vjwpdsJfaeKcOOdM8RrKrnWxpzXB+9FP9aH7G5iuq1GVhB4xw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWvhc-00000000272-1f9H;
	Fri, 27 Nov 2026 13:09:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWvha-0000000026j-0PzD
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:09:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3nXSYphqz2v4eL7HpBauvehJuBtuYcPhxBpJa2zFIKM=; b=WlqJ/rDlMruhWROLpNdFvlxUGU
 dcbxoy7vOLnTfFOqM4sy2PtVAO6frfcdz2WSZss5TRaW/Lpg3waI9qVBCM3kgcSWNUDv7AJjQ7aX4
 Lqkffw5l4WFgbhAxBnhGulaT7GH9UBNvlNojrpPBdlw0JXOJWrzl5V8WWOKCwbMkoq3w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3nXSYphqz2v4eL7HpBauvehJuBtuYcPhxBpJa2zFIKM=; b=gnK020jfKuXwWc7A1AIJYIxRp8
 nZcvOs3aSJ2jpNMd2711inpJNyw//jO+54a+36BoVb7SCmTeb96cwxpaCRng6aGz3TDqpdi0mFARr
 D0DSj4EXKFcu4JPWYibExaFggfWr2ryU/QSbfJ+4yuav1Zek1Fw9T5jp+KCpf2Dfsz24=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWvhX-000000004M2-2Rro for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 13:09:22 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4bb6adaf0f1so70439465e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 05:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795784953; x=1796389753; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3nXSYphqz2v4eL7HpBauvehJuBtuYcPhxBpJa2zFIKM=;
 b=D9Rdm9mfgW2xLVZJ5nzGuPONqnjNI0ZuY5lhm0FJN2Ul96buqUShYWu+4F/UeA45cs
 3nvo9ZJ+SXChr4oTXx5xYEY31q4O1MuhmK/EoBeeeaEm76JrRtVWqN5wQy8u2Xz5U3CX
 zNtG1LDRGAgbstJP4xJvfkp70fMam9fv1G5qlE9h5nJmUe2T1ZzV31Oruev7mM4fhIaj
 jOvGt87WhC588oYXA+p/cYi+igjbIVxu1kiS48HBgp0dY0/E/y5LKwAehHEoa6dCBUsO
 d9qS6SAdN5V9hWQYZQZIRENrjV6NtyHJtm1P5aWTU50Jbi3G0pxBwqEnhR4pEhowat4A
 atNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795784953; x=1796389753;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3nXSYphqz2v4eL7HpBauvehJuBtuYcPhxBpJa2zFIKM=;
 b=CZH8N6ZQbDRiaIc/TUuvTe8Thmlobl/a/FtSN0KJzNk0bZp/UXWb35VviFbnZ4Y0fD
 Zvj+DoStFKrxkvAj8huMz1OQUQdbSOI5iIdcBY8fu75hFwdiEV1QxHo0DJn1vkjHil2n
 OijmP0Mv2Jq49sP/Ucg51QbPLaOv7gbQDz8tcP9fZV0z7kvwFjaD/VgMEnbF2D0Yi+UD
 +FOiWnS0oA3b120r5iqjY6rceq1xgjJsJ7qDU+EYPAWbBEM4LZ50PwHRXncY2AA+NnTJ
 LCnvUsLzwKDPe93x+KKFJ+Ntx5/dwbkdTgBVmSNzcwS5VLzSp6BT/2n3kTo8ix9vrZup
 zZwA==
X-Forwarded-Encrypted: i=1;
 AL+hErFl/6BS5xrNG+qqEleJ3OhTpPQSmavJr/1xS9p7iXMA6+RVwqv0z373vxv5IzFQ8EG6cZj9Elm0C2GatJCk@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8+YbTnZQRO6e7HXSMFmDiiPagDaAeTW2ETduETTA9hnNM2SS9H
 EkqbouGePTm1DpUovVMXfC/MpbdYoXrcUqbyHSC8K1X5LAVjqTKOVRKkIzWO5eMYqzZzfuZ04L1
 TpNqv9vZYBbjyFJ60cG+kW0wGgXAYbXHk3H8gYe93O3zW9rcfn1EFyrZCUxerNUPU8BFYPexZn+
 w81dKwQQ==
X-Gm-Gg: AZFdTZcjfH8zcB/qVBpGonHlqQzKjLXMLiH8bJpEALphY5LSAi8RV2xj/keH0W9oMKp
 MMkdkCzRxlKlTac4um0lgo1ERDcXMIMhXjI9Enp5tV/FqzxcV7qm0rJIAWIvicpjWLohjdN5wKR
 qyU7qJowt0yArgyueYg8S2F42ybAqwiIHEdb/VizQTT7u5d0C8ZFQV57pV7I0yTtww7S+AkRZem
 0jvjyODg/Kgo+V5lHOhqrD20ct72SIn/BzCmSzzDUXBdvQ2psOndYKrCpP9BuBzFYpr1OazJ6RM
 PLrqWw7JI6gLGgOtjbi5n3btelRooGcJS6dT6kh4nBOPLXLXBwSca8ssik6//itL2wpIxFsFG9y
 JlTNFnCj1u+K3/3LfKDooTGk1UxWdgPby2AlemF0O9C7S+u71f2RBNlJwB6jg0+1yG2+6rTWCVn
 4w38MjFnhIS6lAouZ8XzurlGGm567VgxoNPtggh66FP68z2DvIag2ljuGEmqC5piHuHpq9FmDdJ
 6J9cCobSNSBk6yxW1FmYpW6XDWVZ5rxJkQHQjUHH2V9L4PRo5xnVSJ5a36X6gNw4ekzArdz2GNs
 kIoh1akU7z6/2RSZXHNL0w3J43S3vhob8OykHaw0U2mV7yGEbOaSonYshsUDNfyLW5IBJ5WfO8T
 Jg3v4Lxt7/qxQUWw5l4EwYuAgOLKk+ZbNu22PuDRbLLk7DqljQuPta+70uNZu/5H/vZS2uNNWFP
 k0dfr+VM9QI/2hqaNV
X-Received: by 2002:a05:600c:46d3:b0:4bb:5c92:ce12 with SMTP id
 5b1f17b1804b1-4bb88812200mr527302915e9.17.1795784952718; 
 Fri, 27 Nov 2026 05:09:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab65cb41f4sm45577157f8f.7.2026.11.27.05.09.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 05:09:12 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 13:09:09 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408
X-Gerrit-Change-Number: 2360
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2360?usp=email>
X-Gerrit-Commit: b0f799c435a2d85b25f3453c4da825ee8f64ac87
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 13:09:09 +0000
In-Reply-To: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
References: <gerrit.1795779011000.Ib20f4965f25472f47b98981d54eaf4e2269d7408@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Nzc5MDExMDAwLkliMjBmNDk2NWYyNTQ3MmY0N2I5ODk4MWQ1NGVhZjRlMjI2OWQ3NDA4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9720755cb86b914e3e5048528299fb029a2289bc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWvhX-000000004M2-2Rro
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: preserve
 --dns-updown across PUSH_UPDATE
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1957504774351382113=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1957504774351382113==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hyISk6SLLRk="; charset=UTF-8

--hyISk6SLLRk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail )

Change subject: op=
tions: preserve --dns-updown across PUSH_UPDATE
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib20f4965f25472f47b98981d54ea=
f4e2269d7408
Gerrit-Change-Number: 2360
Gerrit-PatchSet: 2
Gerrit-Owner: Ma=
rco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 27 Nov 2026 1=
3:09:09 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--hyISk6SLLRk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 2=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360?usp=3Demail">ch=
ange 2360</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2360=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: Ib20f4965f25472f47b98981d54eaf4e2269d7408 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2360 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Ba=
ffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Fri, 27 Nov 2026 13:09:09 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--hyISk6SLLRk=--


--===============1957504774351382113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1957504774351382113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1957504774351382113==--

