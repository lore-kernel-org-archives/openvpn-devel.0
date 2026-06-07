Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398F2CD8C8C
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QEVy9im0Ju59pDuZCl6VF/BHCceVdcQy7dIXmS4YcU=; b=fxkrM6+6bJL6hoYXXL67mOokG1
	3hYXxhX5CI6kOJ/2YmVpJnjQNpVv9+SS/cQl4JFl8MDNQnGbGdKZ/y0s+L+q9N0FhoDRVuRNqZBrM
	h8UGSv01NuDLlkq9n00OnAkWf1nfs4uLMriRBqvVv7UAgTeDZxmp3qSXPJG1cwZ8vVmw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWGxw-0004dE-1i;
	Sun, 07 Jun 2026 17:07:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWGxu-0004d7-Jl
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:07:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cgNUEcd/hMKeS539ZyG5yKAwUy4wqXaShwKukMOdV5E=; b=AoUwrwnv6dC/qquF17H2AHvCKE
 mXcoUKXmYVWRWg+w0uXhVPqcNYS0IbRPIis2Tw24+W+//MSaJVUsE/pYdKAZVct5ZUVHAhwJzQqgv
 a9k1HYmDlOKxL7z3d+OkoGW0ArQVUK233DSC+Gxu1pyNPkBceH0cumoN3GS76ocQH1S8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cgNUEcd/hMKeS539ZyG5yKAwUy4wqXaShwKukMOdV5E=; b=T
 G7A84ekas5vpgxCNwtAbxz5d/ZyKk3Aqr70kahZfE+qRk3udxJTlSm0/blsybWK/u41WBBCbQGz03
 zD3+8NtGZlUHbp74EYOuvj9NOyPDxXBCcaAawF29vtAmbZqtMpkiKLRkhXIYIbKwl2Byoa38RsqsN
 9uEspEPh+4v9xDaw=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWGxs-0000zT-Co for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 17:07:14 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45e9f4a3510so1576103f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 07 Jun 2026 10:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780852021; x=1781456821; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cgNUEcd/hMKeS539ZyG5yKAwUy4wqXaShwKukMOdV5E=;
 b=X8ktwVWyD2OQjlm0k+PLEUA5XdUe4KMiC/vPUr0HXCyonATp+P0xXK24WBK22x52WX
 zY1Emuv7BL2MGpY/puwMNsk8dBX1G34EpD5pcd+EDoaPwl5IpFiqWhicprAmIk/o6E2o
 5cZPhH+di3ZwXJ9attjWLTS0Vl/qrSUnmyk4MW30YHFYsSXkItsY+0ya0609ncDODHAE
 Vluq3lcgJp8qawBa8wGbF9uiVkcs2zTNNOrFync6ghT/ZKZF2h0Na2UFCpN6Ne+iVUrj
 reA9B7PQjoT7VOnw0LSIPfma4HRp6FUR2xZWYeh6PBoxZ8SuCTL9OVwahQmu9AkwTgu8
 GkBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780852021; x=1781456821;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cgNUEcd/hMKeS539ZyG5yKAwUy4wqXaShwKukMOdV5E=;
 b=bZsr/TX/BmjB/8Yu3gH43k68KGdN95lokO7RKBtUmN94/obAqmf46j9wVNAOfIenVN
 JqejRAf8BDUtN9uPTElNLlPnkdQy8fEsPTb7P4FqDmm/sTM0YpdhbWjha1yUhd+XdL6b
 paAUU/W0Rcc7PFKWCPY9UI+/rNkbbhsQ7Bo61p1sI/yj+cQfjfsPMKLTlaTgfOVeur+o
 3pXtTd1RtQT3W1FjK8tpaV2guB0TB/qN5/O7q84TzTX7d0hWk2d3rP0EreltStkPjgyT
 rM3+R02btaDqpT9XiPx+7NnVFdTrZpYkHfQdlhmK9EC/Fmmq7vkRnfS7BGnrPFY0g0Wu
 bSDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+h/VLEzrV0t9AkI7hAlZYr8CKEqVnAGiOM0qvl5cXNvlftr5KrCAzS736cTDGjoHQhiEG1bJciMeDrxE8V@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwCa3AOUTA/M2opMmuoNuvldI8YwFa4UvfF6J/v/dYoCUvNRE7E
 W2oKXYvMBnIwPZ2q1KNVcQ5mC1dmDCoo3R6QsvAhnNreHgRrNzWuTa6CuxWTksVEHh6XOBp+sK3
 RJPzzCnNjb16xAxShVUeZ64oRv2Ky5PHvJNcaimHpSCz8GR8YczNOf0vZuBt9VAG/8natmCh6y1
 HRJ/J+2w==
X-Gm-Gg: Acq92OHMttu8oG3ewLwmjdiSzYhEQCRUacmwvzeq1sQuMrDmEFYKbqkk3+KaTCh78gk
 a4HuXIEgaeyDsOURabZGeLZKgHPN4rRnvWT0Na29JnFFIPeXNvhg6hnvrZuhh1h2Ma3JM4flOGy
 maZft4rW2QPTOo9LbAXPAecAGIz65T2gNEFhCfnAayH+SEjoZmJJ24eTUKzLEzi0de83txXPsBL
 8xUhPxkYegOvOEHIENqUvqcaTjMSN+yWdW8yNm1yEG3W0ssP+NDiT/foWutVR1qfU9pCjJz4Q3Y
 4vfv2eHKhLR1JTqjflfnn/1OUUHRpIoOV3uU9UvAUah7ZsuioE13byiUwyoCIjHPocBj6xEsOjb
 MF0URS2ty6QJ9GQvhaGvJ6nU1Rw28XSU4Wl/u2um5EuMBMc0d2+LgHJngGYtuWVzEZZVMa8n3FC
 gGF+6Qs4161pu59XSIi1tNXC5s3H3m4y053r2MpY8i6kAT03/TkqBqdyrslz/7LcUEx+lhW8YJw
 g4wBPGY+NAQZgJhMaWb9sjOICmNYywPi+6bQ6AyC+B/o2UoeBFNlLRnllDD0TZZkGUGcu8pCwVl
 9uYykLMYUOAZBVC2uMlIzTvD
X-Received: by 2002:adf:e00e:0:10b0:45e:93b2:37bb with SMTP id
 ffacd0b85a97d-460302e4070mr13080926f8f.6.1780852021170; 
 Sun, 07 Jun 2026 10:07:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f345209sm45537158f8f.17.2026.06.07.10.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 10:07:00 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 7 Jun 2026 17:06:58 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56
X-Gerrit-Change-Number: 1665
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1665?usp=email>
X-Gerrit-Commit: 5dfe1bf826454f2f5e13e10c97bbfd8089d46f53
X-Gerrit-Comment-Date: Sun, 7 Jun 2026 17:06:58 +0000
In-Reply-To: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@gerrit.openvpn.net>
References: <gerrit.1778102459000.I05720ccc3bcf706bbe62254afb74562580f5de56@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MTAyNDU5MDAwLkkwNTcyMGNjYzNiY2Y3MDZiYmU2MjI1NGFmYjc0NTYyNTgwZjVkZTU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5015fb18dc7d8aa6f09e502a9654efd33ebdbfd1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWGxs-0000zT-Co
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dev-tools: Fix
 run-cppcheck to cover more code
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3397066934528159217=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3397066934528159217==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1K8WHhcD4PI="; charset=UTF-8

--1K8WHhcD4PI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1665?usp=3Demail )

Change subject: dev-tools: Fix run-=
cppcheck to cover more code
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1665?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I05720ccc3bcf706bbe62254afb74562580f5de56
Gerrit=
-Change-Number: 1665
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Sun, 07 Jun 2026 17:06:58 +0000
Gerrit-HasComments=
: No
Gerrit-Has-Labels: Yes

--1K8WHhcD4PI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 4:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1665?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1665?usp=3Demail">change 1665=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1665?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0572=
0ccc3bcf706bbe62254afb74562580f5de56 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1665 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 07 Jun 2026 17:=
06:58 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--1K8WHhcD4PI=--


--===============3397066934528159217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3397066934528159217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3397066934528159217==--

