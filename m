Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB42CCDE002
	for <openvpn-devel@archiver.kernel.org>; Wed, 24 Jun 2026 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=djr1GMoMrM58rfQnLBf6oDZA5yxoBqo/biLjQCBR7+0=; b=hJ+NeM3Aci3zMnq6gquNQmBJzC
	OiiyONpinKMdJNJGhqYOiUjgY9qq5O2YuDxIqWBKgo85A6BL/CdZQf1cJaFUl1nBclxtUjzqfY9or
	6qsOZS281WtxhVU/HGmXzq6Ns3KdBmeHdPDpC0Q9dJ5BgCDamysKwmTOyj+lLNe//qaQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcOcl-00010s-R6;
	Wed, 24 Jun 2026 14:30:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcOck-00010k-Cj
 for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 14:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1J0Qmu5cMqVxSOaiRGnDxJBEyPirooWsDgqP70DVNwk=; b=A5EWie5KtBSxReWZSGlWMgP9Kg
 nSudUATnAzsf7vcuuIyXLlG/Qv/wzIDRMHq9Nk1tKyH46SOjh1JW4U3PhFQEKZ/gmuah/sIWTScYF
 rzTcCibj2E8olzIXcJps2vcNIhwga4oxKyTyfXDhv9/IMx1oSlpbFll0IcbBmb6mQdFI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1J0Qmu5cMqVxSOaiRGnDxJBEyPirooWsDgqP70DVNwk=; b=g
 UEHd016/E69VLYb9USW7NM7UHxtcHmzmwICkgqBPbZDrzfZK1bO6uivzQpCIfZpJ844QVylXOg0HS
 82NXZlxex+SOh9DONeMVZlpFx5AKQk5dim4LYHifCHglcHwNVKwmdIE+pv7WFNl033ums45FTW2VA
 uDBe05/RDuDC9v8w=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcOch-0008K3-2c for openvpn-devel@lists.sourceforge.net;
 Wed, 24 Jun 2026 14:30:42 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so8363285e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 24 Jun 2026 07:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782311428; x=1782916228; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1J0Qmu5cMqVxSOaiRGnDxJBEyPirooWsDgqP70DVNwk=;
 b=ZqnGNbZ35pNFHi0A72wp9DLPDFsObpuemfgDiejyWPd1NNYECOKMxcRPIBsU3ISYNQ
 xoUlnfbJs/KtG04MdQmcZEuN3xdzbxo0YF9gOrh8vKRVVMJRzMnAhKgWGRPEj+YPJTHl
 fbif/iwGVrprakL1y3QIJ+kqpY5ehl4xTZKT5jbs9b/smzafOj3Sz4YEndrcXshCDwlL
 XVU7kpeBWRlJg/SJOGq5G7NgMMFC0MqE2xkbe4Mho2kDGd4k93+KeP8HYm6FEVzaXBOs
 E7sXGNjtLmbUjbeG1vfyU8zZxD8oXw3iLXaTDFyvfhkhTNgcBYfVkpH+lgcAVWcVjH++
 uH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782311428; x=1782916228;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1J0Qmu5cMqVxSOaiRGnDxJBEyPirooWsDgqP70DVNwk=;
 b=JSu3N+1IJmy+gQTcvKLYTpcwZBwenO0Y76SRWAxD6I54YOVM1bsMf4i9v+wNetMPSO
 GraXbw292T5oxgFkzmjq4wlOk7T/cQofJrBQc++msxkdlocQ/PRq3fxuq/yUwrDfQUmt
 Dx93u9XeYxvpiIS5pKFbtmuk8SQx1JTrWDHJ4W3xVVeVuAc93COU//xc9QNmqBpkOfPO
 Thgd2fW8jrTZN9R6P2wQkthcLTL+XwlSWtFbDVcQsO6LoJxC6FVKjRDp7/XoPz1BypVE
 uLFgJayaoQ+6eU37eeCaVtSotTbVCeLkPzmn1EFEqsQazlJsmzjz6o7/uwMgI1IMu75S
 L68g==
X-Gm-Message-State: AOJu0YyAsKXDzSBnSjNwmdjNxHTD9Zvy9KhV4AF2yzKGkQdcZvVt0GqC
 +WZXmyA4hgk4NjZTPo7YE2QNjKtv1kaI83cP5vJ7YhczR7EUydwT8dEEZMYdEs1wzUWVBVphpVY
 nV96DgtU1+itC/f5BnRDmjx5xxygRowwZsta3YDDyBEd+H21p1EcGYiDKAjSCkvL9CaQm
X-Gm-Gg: AfdE7cmsgNv+9XMmLYTiLoNnATSqpulZ34pbj7lMXWnn/R/Xa9ZcfPIFW7/sv9x4s+X
 tZ1U1Bt6ThCFLiDSa3u471jm9t+uq/ZRkF7Vacix6bikJUy5yTsFY/5wJPYecjUnGjBXvDn9SRo
 P/02gTJcPss/n8aI+6qbf1FeeEagMAY1CukMRmCplQwoffT+jBqt1TIlOx5ur36gvN4s2gQJ6HP
 yTBgoSXLnSsPPiPU1KD0WdQPJsXPoHtQkrXcUdzT9Qc2WglKsRhgxMwgV+R3aS6SimDdjWppB2B
 9GZtQGb1B65CNnRNnlnynoFR4mnm6BG/+Ahj6Cj02pgtxnbSyT75OxNIjaDrga3dJmrdc6eNw7F
 FG109z9pOtc8reHQQLYDeMw6yHerktHt3HoEIZMqcDPRBE2mTMxkox9gFEpcJzwESaZFfQFhghb
 LT7+YTqWNfu/0t3xpYODfLLvYjNXieYqYqNL242/sfmujshiTieugau6vmW+Z0FZlN0W2FgizB3
 82ehhV9Gz+4dxiIjqN4iSvXEkGXbPkk/rgCn3vD+g1RhVS9ZtrQwQY3USGcgnvZJlqz7gfiuIl7
 oN8=
X-Received: by 2002:a05:600c:3b17:b0:492:62d9:4e57 with SMTP id
 5b1f17b1804b1-49262d94ef2mr21775465e9.2.1782311426775; 
 Wed, 24 Jun 2026 07:30:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1eef84d7sm7678939f8f.16.2026.06.24.07.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 07:30:26 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 24 Jun 2026 14:30:24 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: e2d45132404457d5aec9042793f893d4a28d721c
X-Gerrit-Comment-Date: Wed, 24 Jun 2026 14:30:24 +0000
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2d8fb7141350954da9ab178387273874ae49a690-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcOch-0008K3-2c
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7931234944442379239=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7931234944442379239==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eocTfzLENHg="; charset=UTF-8

--eocTfzLENHg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1723?usp=3Demail )

Change subject: Extract multi_check_dest_addr=
_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-2

(2 comments)

File src/=
openvpn/multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/=
7140175d_e2b8c40f?usp=3Demail :
PS2, Line 3108: multi_check_dest_addr_allow=
ed(struct multi_context *m, struct multi_instance *mi, struct mroute_addr *=
real)
please add documentation for new functions


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723/comment/32ab1e90_2949bcce?usp=3Demail :
PS2, Line 3=
160:     return true;
this return is wrong and leads to memory leak



-- 
=
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d52c6d008502293c3ec57ad2=
2d1c613dcd1a94e
Gerrit-Change-Number: 1723
Gerrit-PatchSet: 2
Gerrit-Owner:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esource=
forge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Wed, 24 Jun 2026 14:30:24 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--eocTfzLENHg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 2:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>2 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723=
/comment/7140175d_e2b8c40f?usp=3Demail">Patch Set #2, Line 3108:</a> <code =
style=3D"font-family:monospace,monospace">multi_check_dest_addr_allowed(str=
uct multi_context *m, struct multi_instance *mi, struct mroute_addr *real)<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">please add documentation for new functions</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/32ab1e90_2949bcc=
e?usp=3Demail">Patch Set #2, Line 3160:</a> <code style=3D"font-family:mono=
space,monospace">    return true;</code></p><p class=3D"blocks" style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">this return is wrong and leads=
 to memory leak</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail">change 1723</a>=2E To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d52c6d00850229=
3c3ec57ad22d1c613dcd1a94e </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1723 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichten=
held &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Wed, 24 Jun 2026 14:30:24 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--eocTfzLENHg=--


--===============7931234944442379239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7931234944442379239==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7931234944442379239==--

