Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8580CA6002
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Rykg6zWn+vv/omIwJ45QK7PDNKZCIj4FlhI5l6yZic=; b=Pv6xttoLB6Fv109im7Wby4vnGn
	RRaERDCMQQ9KiltFX86P2/aiYTDsDFHGHGqX7hd5EKTT9n7f+ZTqcAseQCoMBrlOdNeGTEx7+KFAA
	vdfUGPG3c8ooALspxT4KusQGcCUGg4BqOTOQ3srT9V+RwhnAnP0G606lNrfLyRK92Xxw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEVHv-0004jT-Me;
	Wed, 07 Oct 2026 17:18:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEVHu-0004jL-83
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:18:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=IBcNV+c8rSH5IUsjukoyHp6kpxSz7NwnvD94eaYJclg=; b=L5hv/2SVnZKEwckMVOa64VHJCM
 K52xAoitr2CXY/kMODQJnBDrnk0oI2HDGO2VK2kq1cf3lDtpVsQXI6dQYQnv8EpcGvoaa2ZAXWbLe
 fwGW0+wOHarn3i9xfQU63NB4nS70K8paBiJAVCAYFGrCmFauD4whbWZV92IGZWxkBVHU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IBcNV+c8rSH5IUsjukoyHp6kpxSz7NwnvD94eaYJclg=; b=E
 HlvPFXDQrPGmv+ONmRYZiC421HPKmAhQVgl3givYkZKkPNoSCY0W+TT5skvk4K6hoe1fBpOyK0OwL
 HTIHluFAJJDt4R5wiPd7+4VO40xotafEWzO9/DKwFQ7WEx3t5OmV4mXXrb4BmEG/K4IbSjXuHlti3
 hEycCTS+wkCHGgaM=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEVHt-0000ZM-IT for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:18:42 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48c411d6615so1495016f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 10:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791393515; x=1791998315; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IBcNV+c8rSH5IUsjukoyHp6kpxSz7NwnvD94eaYJclg=;
 b=GI0KsyjK/z/KwoZL6nvWPqrG0BsgQfElO/Y71NzfimqjJbItgLW1RFQt2ASxLRvSfj
 Vb/WAT7Pm8JqZWzq06a+OYspenCA7aXYkPefjDZOEDn7xZf2pf5WEvBLkbQcbhdzDbvW
 w7+2Xs4qO8eUhMVAnAhsVVzUZrbsqVrQldU+1CwZ289p/FRcfWzu29OWdV39gdjCIMeI
 aswcxLKbD8sNSaQHKXwAB38RHIKmN7wX3UUljDXjTrcZncxE0YlIZPD2SKHYVAUwwoOu
 4BHAmqSFSnW964bcF8BomIOBi2gW2I8fhQNzhTmOSzU/b7RThZlhoQRzSBrqBldf7WDD
 9OPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393515; x=1791998315;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IBcNV+c8rSH5IUsjukoyHp6kpxSz7NwnvD94eaYJclg=;
 b=EuOxjb+ZpzZo9c57oEznbRCmmDLnhMRIHLNmuol+Y7pmPBOC+OY2zDls4GExWNYIm9
 EphxgZsz7WNZY3OLSIVOV6p9FXpRdHs0NrjJEmLvV/YJScj9UUNRXvYrayU5AXXoGoBx
 i1S9od+kpvlEyRk9MN3yFS9ydDV7nkh8+xbccvwt8e6r0bUnhr73cSnRibTqnQ5LAsa7
 rdN1OesJOXGypUzDqxmmxTG3ubSrEOqY97g0jsfyYvAiJybaOqG0rMciju1mPMfphYcy
 VzTrG/gXEYQeNXhvk2eia42fKt22MkTXc15eo3MN3/JeUXwe1wq52GOxCJDbSjLNr5rI
 Jj3g==
X-Gm-Message-State: AFuF++kacfPUG1XHhrB+LYfhWrZQrx2Bffw+STj5z+8pBfWmvN6d0l4s
 lsN0FlCyF8WR7B29Uag4/8T4r1hlzJDrI7//JjNa8nXx2vv9VWYSuYN5WoylMyjWtC0DItasvN+
 MTZhv/nGoDBA+wIwaT6hbFVrW6edXvRaYivfgIFs5I9FOZ2sdaDcPPS7M1KyrO8o3zIw0iHVyYd
 2xiHnKkA==
X-Gm-Gg: AYBFou2ZoDED9QdgjWOPq5XtkEv5pf0B0uuEOunNS8VN06kV5eebEB6JdkP+1E9k/2+
 tdPVNuZ+6VABgKPXl/joZtCAU/A/O9AsBadh0Nl+3jspiV7MWUZdqI4x26wyZiUAJwYUckiWsi4
 x+kIsUnB5jC1s4u7HRlcQK/7jVTfkI/5rjvjfNZavcNuCRfESWOf/Imkf5AM66/A1wWE10Q6sDz
 5n14ux/E0lcZrMY9Yo4n3CyXz+qimfQVcamSMSPLmRlWlsysrwGP5aMByC3POSoKmn79A4fIJhB
 QIoflQDFT9y+eo3/Bc2bM+1IrvAK0wg5q4NeoDFd6Q3333u09yo90Pj8UEaxmoHdynQmCvw2Ajh
 3vDwM86OH31sEOwgCpI/gs1cgEcC24l/+qiP93yHDqodc0NZoxpqs0WyLfF9HZ+CqsxyP/eJYYy
 7cl8CVVnTl3mVlfFMFz3RFL1fBu7DBb6d1rrXj3sOmZiE2qtl8ld3i7Mj63hLBHoLw6Cfyr+UGG
 6Kbm56NyjGCtGnWD+JhROISR/XA1KxGg2O12q4So/GKN2zL1DKdLJ7OG29sXV6s0abAajlBYDFd
 1A+NCg05Dkl0FdqtPVv2Na9LHjC3DV4TVBRvwkshRLaZQE4YbNGowjd1T6dtgf+5g/DmDEA=
X-Received: by 2002:a05:600c:811a:b0:49d:1fd8:b874 with SMTP id
 5b1f17b1804b1-4a18041b7f4mr46373775e9.19.1791393514877; 
 Wed, 07 Oct 2026 10:18:34 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f493761sm123367395e9.2.2026.10.07.10.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:18:34 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 17:18:33 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03
X-Gerrit-Change-Number: 1899
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1899?usp=email>
X-Gerrit-Commit: ff9790a5c419a1cc6430aac7aec65764b9151485
X-Gerrit-Comment-Date: Wed, 7 Oct 2026 17:18:33 +0000
In-Reply-To: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
References: <gerrit.1788765781000.Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLklhZjY4YWJmMGQyNTc1ZWU0Y2QzMGRjNGYzZWY2MjdmNmIyMmVjYjAzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2b8a6f12a503a7316531c08d071383658b34f305-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEVHt-0000ZM-IT
Subject: [Openvpn-devel] [L] Change in openvpn[master]: reliable:
 characterize the packet id comparisons before rewriting them
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2045277216276785554=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2045277216276785554==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9AuW6qmXPeE="; charset=UTF-8

--9AuW6qmXPeE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail )

Change subject: reliab=
le: characterize the packet id comparisons before rewriting them
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Rev=
iew+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
G=
errit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf68abf0d25=
75ee4cd30dc4f3ef627f6b22ecb03
Gerrit-Change-Number: 1899
Gerrit-PatchSet: 2=

Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer=
: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Wed, 07 Oct 2026 17:18:33 +000=
0
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--9AuW6qmXPeE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 2:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=3Demail">change=
 1899</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1899?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: Iaf68abf0d2575ee4cd30dc4f3ef627f6b22ecb03 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1899 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 07 Oct 2026 17:18:33 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9AuW6qmXPeE=--


--===============2045277216276785554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2045277216276785554==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2045277216276785554==--

