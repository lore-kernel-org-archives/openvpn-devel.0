Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE61C531D0
	for <openvpn-devel@archiver.kernel.org>; Sun, 26 Jul 2026 02:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huH0E8Y69M6CYxRZLB7K1TWjOypo6RB18pyskSNVobE=; b=ZQLj5M+VGa4vINaV/oBH02AbWG
	LDD3zRs45eDkqiXqqTdLolBV8LZ1Ef5c1ktoENCiVs214EdEs83NrFrxVnziHUuVXxc5Z25h9ajDC
	BJg7ho6yDxapv5ZhUxbyaybdCxpPXH2bDdnSyy7Ks7bAaRXnzTPueI7RLBLmrISvZq9I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnoG7-0005yV-8G;
	Sun, 26 Jul 2026 02:06:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnoG2-0005xw-J8
 for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:06:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4CR2CFDEWBbLvqciFgpQjXd7sOs0MjS4fztTiUEFQUQ=; b=GNc2Xmx6JlY/usThzxAAlLIK2z
 c+w4kkPZ67uuDEBGcPMYTI+XZSfGFVB4QrSpiewTPy2cbNYYmbotay+Bvw/OlUsbwdSK2YVmKp8Mk
 sy3+CGQaingaqWmFwilcWlXw+WEN44tKPPvlkF9YtT1IrTtHJiqhndgtzW0SNj3Q6gA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4CR2CFDEWBbLvqciFgpQjXd7sOs0MjS4fztTiUEFQUQ=; b=X
 jwbaNP3ZpHE3lh/16JJD2Rr5daNkqzWzZow19S+n/CdagrhVryLnNvPFWa+eWWgxN3K9C1fHVxPVI
 kVxppskYO7UcFkcn8ykE8MTomgufdtS2q05flT1QaYMTGPE2xWyypKLUWxoqZVKdCwjkhrIv6SY5R
 1WaVSN9lB1zuPZuQ=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnoG2-00033G-Oc for openvpn-devel@lists.sourceforge.net;
 Sun, 26 Jul 2026 02:06:27 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so1348855e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 25 Jul 2026 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785031580; x=1785636380; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4CR2CFDEWBbLvqciFgpQjXd7sOs0MjS4fztTiUEFQUQ=;
 b=T6YL6RaJPzU11WUy9vBn/gYlavoGfzgzki7uUGD4I+UE1LYvQxZ5psovC4cfBshXzh
 NpVuJ3qrsLYyAgSStYvMSOYsZTJEiuK0ebVIJ1ax94T8fddi6rWOx3p8IJDOY1jJu4wL
 s4Y7X8eH8ph4bsKIgWvPICO0FrK+jBRYHL9Nquz4BTfibACjPch9rss8ho6cOgMeAaun
 CnmfHHbRIaPgSP2ugVN4uz6KhLfzSxeTPBqFM7Xujpdm9iOMs6qiql7ssRSOGvSp7RD/
 2ECdRKC7NzrUHF18XXolUCQW1GxPhcpEsQ7wEh2iQ2rRKMGLUeKWhb5TQxmqmY7gpMK8
 Gg4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785031580; x=1785636380;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4CR2CFDEWBbLvqciFgpQjXd7sOs0MjS4fztTiUEFQUQ=;
 b=AMjv2daHn2fStFL0YNconV5rqr2cs8kC/9QuBwNup1qw+zpM6QMGFurYx5m8B0xlSB
 vPrsUepK4/3002VJKbDX8vuWNNOH4x/PJh/BDYW01s9gO+AGTx+LeCRtF3nlEgX/IMJu
 Slw/yCYOGiJPeokwAtOvwrC2HKikuCa/4J7Sj1AGInj6F4L8DYmj1KFbznvyDTaOoVkV
 WkH0f4OPHN7D9tMm/FqiSHhSqIeCJ/aoaKAU0fKn5OMRLyapk8mnsSLQ4XwwubDgDiSI
 FU45X+Xv/QjYuYSBnZmgGFsKhXZdEEiuK1E1N5u0QrwDzhjvecKx4ERt1Onzs0ISpjii
 tRVw==
X-Gm-Message-State: AOJu0YwepFwwb/278TRl7Bnw6IiYRKELA+BDBjBf2OtGw/YuXSyhpj4H
 WFZRmga35wBW929RlaPTcg/3jxiHx0Z6/CBVH5OQlUKYwma6QzJOyyZcmn5moghkrbfdSe4owlA
 6Y+jb0yjpIxCd50lHDWq5kI3N0acIyfY1cK2dF2519vwnJUuemRIfdogNel5/0erKWyfi2SzChj
 ezSP0IpQ==
X-Gm-Gg: AR+sD10biEbGAAOM0iDfHPTCILd6GM1qcvtslDRDhblER1SkPT/lmnEzSe1jOPH+50p
 34JEa0zfRw+3FFvJC7QrGIi+Ds3qarJoL/UciAdazvzlzY7dllt66TQKGLY3aP1F2FZaSqMbZ4U
 fvf1VMG2ei7SxQKWKxjxKt8UDFZLkDk5MZosFBzKMQmPmiWx0iNy+uTPxxxdqrR2g0KewyYUmRZ
 jr4KMmNklccNu58PtBNXd8WcxgxTIdZp6KPuE9QGRMWLC9QUA//oeTdKKBpW6mBMfFvl13jb57C
 7Dh+3Miuxd8oaOnyG2u1KFDyJW5skhukAyLJmwzWZLheToVE6MsTzFEe98mF5OlRP2AuCsrQuaD
 mPSeX8fvMsW4RYO15zWI1lDNguSUbGNNly01gVFBbyYs7EhLiOKBLCF98zY9B/vZ9yqlIGWKzk1
 dorMaeykg83xXgLl5d5jRHRDc2gERyqI6KY69stFFTeP+EmDT9bKevmBP5I+kQHvT8tMH6biLf0
 RnBmt2kHQbrW6vQH7pIbaXg9kHcX62EbXL7Td2bYeqJ9MQz2GOFY0poqZzY8qsmzXtf
X-Received: by 2002:a05:600c:3113:b0:495:4fd4:619b with SMTP id
 5b1f17b1804b1-496b56bbc22mr43575615e9.1.1785031579984; 
 Sat, 25 Jul 2026 19:06:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957b5f35a1sm134668995e9.0.2026.07.25.19.06.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 19:06:19 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 26 Jul 2026 02:06:18 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
X-Gerrit-Change-Number: 1758
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1758?usp=email>
X-Gerrit-Commit: 445ab65638195ef98941e4f5219a6ced670c1ef7
X-Gerrit-Comment-Date: Sun, 26 Jul 2026 02:06:18 +0000
In-Reply-To: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
References: <gerrit.1782820043000.Idb8c0c660a98de8ec549b69f6692a7b41b092eaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyODIwMDQzMDAwLklkYjhjMGM2NjBhOThkZThlYzU0OWI2OWY2NjkyYTdiNDFiMDkyZWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6eb5d10856ac01b9f554a7f844f921836a2a2b3c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnoG2-00033G-Oc
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Unwrap
 tls-crypt-v2 server probes (P_CONTROL_OOB_WKC_V1)
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3202566991465964281=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3202566991465964281==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SJsDDX1lGCU="; charset=UTF-8

--SJsDDX1lGCU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
758?usp=3Demail )

Change subject: oob: Unwrap tls-crypt-v2 server probes (=
P_CONTROL_OOB_WKC_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 10: Code-Review-1

(2 comments)

File src/openvpn/ssl=
_pkt=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758/comment/b7142585_=
2069b9b1?usp=3Demail :
PS10, Line 79:  * protocol (CONTROL_OOB_WKC_V1)=2E *=
/
This apparently is also not a legal op code since P_LAST_OPCODE was not t=
ouched=2E


File src/openvpn/ssl_pkt=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1758/comment/3ee5b5b2_be65af43?usp=3Demail :
PS10, Line 400:     =
    return VERDICT_VALID_OOB_V1;
Either have VERDICT_VALID_OOB_WKC_V1 or al=
so have categories/consolidate some of the other enums together as well but=
 this way it is very inconsistent=2E That you have to write a long comment =
to justify that inconsistency proves the point=2E



-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Idb8c0c660a98de8ec549b69f6692a7b41b092eaf
Ge=
rrit-Change-Number: 1758
Gerrit-PatchSet: 10
Gerrit-Owner: stipa <lstipakov=
@gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Sun, 26 Jul 2026 02=
:06:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--SJsDDX1lGCU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p>Patch set 10:<span style=3D"border-r=
adius: 3px; display: inline-block; margin: 0 2px; padding: 4px;background-c=
olor: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1758?usp=3Demail">View Change</a></p><p>2 comments:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/ssl_pkt=2Eh:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758/=
comment/b7142585_2069b9b1?usp=3Demail">Patch Set #10, Line 79:</a> <code st=
yle=3D"font-family:monospace,monospace"> * protocol (CONTROL_OOB_WKC_V1)=2E=
 */</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">This apparently is also not a legal op code since P_LAST_OPC=
ODE was not touched=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0=
;"><p>File src/openvpn/ssl_pkt=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758/comme=
nt/3ee5b5b2_be65af43?usp=3Demail">Patch Set #10, Line 400:</a> <code style=
=3D"font-family:monospace,monospace">        return VERDICT_VALID_OOB_V1;</=
code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Either have VERDICT_VALID_OOB_WKC_V1 or also have categories/cons=
olidate some of the other enums together as well but this way it is very in=
consistent=2E That you have to write a long comment to justify that inconsi=
stency proves the point=2E</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail">change 1758=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1758?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb8c=
0c660a98de8ec549b69f6692a7b41b092eaf </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1758 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov=
@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plais=
thos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun,=
 26 Jul 2026 02:06:18 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </d=
iv>

</body></html>
--SJsDDX1lGCU=--


--===============3202566991465964281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3202566991465964281==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3202566991465964281==--

