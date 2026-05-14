Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B03D3CD37AC
	for <openvpn-devel@archiver.kernel.org>; Thu, 14 May 2026 19:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hDaQEXDB6ACiVwk6bSzH41KMBRf5g3SkAAsn2TAJUA=; b=G10ras7p5jdE+JtnFJ95QXxDue
	m7+mJWn+4z/MnBkZP0c6m3D/uFcv+haX/KDAXSM3hEXV+9e40AHYYfshA49ALdg0tJ7f0Ee//ORVz
	+HU3MTzR/ub9ilhDbzTbFjRQOrKSzclaXTJOG3tZDUj5AFAj9wkG7CNLiiDmFofyNUmE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNbiM-0002X7-Fj;
	Thu, 14 May 2026 19:27:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNbiL-0002X1-Nc
 for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 19:27:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=keRf9SptA6zJczTEr2VB0tzKCTOy1RHH2LLIPnZmDZQ=; b=lXBCuHWahwyy0MbXUomxB1/Mzp
 1eY9+13jN9gyedgVzInBF65xwxtsl899e39moPovs1kg5GJdFc+ZsJ702GaPraNPTjB5QI38MDCgj
 Yr6QJb0F/5qbflRdmI5yCvL4K+k67RfErU2goiQtJeE6AzrcdHOLI1V4mdv2/aWG1LTk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=keRf9SptA6zJczTEr2VB0tzKCTOy1RHH2LLIPnZmDZQ=; b=g
 FGBx18tJJuEu7bHlsOn5tSdQvitONPs8yJIIA6OAtUwp6wb26N8MQolGnIMELcirpzNe2kQ3hbe4o
 vUKsc+0fs0W9PUP/MsNm0FYF422oyWVYGwtFlHYWxwQGD3XCYeH27G3tfBEdHZ/39Vi+vSv5H7eLK
 Slqr+DMZBQBDcguk=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNbiJ-0006Bn-Nq for openvpn-devel@lists.sourceforge.net;
 Thu, 14 May 2026 19:27:22 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso1461495e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 14 May 2026 12:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778786834; x=1779391634; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=keRf9SptA6zJczTEr2VB0tzKCTOy1RHH2LLIPnZmDZQ=;
 b=IkYFM1nIRkjkV7M7ZCxwNRRATAjs3ofjHnstnmNNDbW89irp/hjM/hZV0dg6ljcUxT
 +6qsm7unolFrOy0btwJlEw/pZKiJ2RiH6kp4bRsdsETBHD+rKbRECl/x0MtC1Ajagi58
 MEAMZQalA+/qLCFyIWXiM6LATi8q3NmmuTwrbJPhlLUhbyecuvRMstCzuuqYM5L1+7KN
 KhTuoFhNpEZQvz+/pZEFsI6JJhyuvp86SNnIufzxkH+Y75wTOAy6AasoaU6rFt1hgX5B
 BZuHosx4TgLgsJARQzslbWWtrWUdrEgQfqkMxQ1ZcMDjkpCgiOYXydSKPJZ4zp2pY0mH
 sbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778786834; x=1779391634;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=keRf9SptA6zJczTEr2VB0tzKCTOy1RHH2LLIPnZmDZQ=;
 b=U2GwwK20Wlhrz+xdwBrY+IiNx1XOYg5jOzFlMdWqVLpFmN5ytA+PQMfXuKZec/uBAM
 idWIsiqI46JQ3j38WfkYs3sB0h0ivu5V/mo7BWB9Gah/l4dalSA21IE3sgl7dil3m7Za
 Qw7QyDHdd9edXHkb0lugtRluSIFrnS9eQrQAk6nFJUKpf7lgnW7lgrIGh40YLzUohkYl
 uSoTUTmjos/chBkWGpuw9mYitnNaZpBCJYISu9JmDMj5f1fAidbgzxs+USMk1jePesvn
 P/tQBypJFynm2VbRR9ChEEqVs+dUpyp0IAK2solSocCclxX5dJGiSxGFZqqX7VSQx3Cy
 c7eA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Wy2jcnBp9uGWqHl85Z3ittS5yFfwQeQOtcNTMVmiKFqr0zvqbp6BWG29DRf035mgoOuWaRl7dtxkRg3mV@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyXHu4RLHtNdMJDqZwpCKH3oeyiR90cEVNBocbDBE2NKE7Lm8am
 pcIi+aasFZ95EiA/sj6ldxZiv4sa0V3SpMn7vDnwo2mJ4LzvTpKWs42lv66VjS8MPSTXdrEMvA+
 ZidkRTXbFHqQyjixyYyZxdXlFbkUnnGF/glox5iUNekTuUNuj3ls06PgtHTRmQPQrQTZWlW/NWN
 fFM8kkmg==
X-Gm-Gg: Acq92OHfmufr+CoaMZjPsD/C4AB9ereiKCYu3bjmRfwbfenwCxY/lJSNnTU4kDjWAC1
 vBzK9mXuLKsEH/GcdudKxbLnXlY6YiUdcwdY787oOyws4z0rQWdhGc4gxfy9RQejdUeKT2pL6TP
 J6+YyTG4wHqBp6Z50E/yQ5xG5/W1kLUM7j2YoxkwP07ZFyuC4YXrmm+Hox/qtWwCIxuwG0o65bz
 ubvY3O/u57IskikPi2oKvIg5LUsjS7ippWHcYKl3RB0ghGm67iXDiAagVnqS0YzPk4H7qu/PTQ2
 3vW+50xXOixDykQT5fEVhbP6c8q1//fbXmFmfYHzKS+I46DnZDgWYvMcHYiPZw5/sCxnImUxWHS
 QxFK5IIgGJaBiNAYIr6e+blY2FtJsgOmFmrmF9fZSCz+ESKVVhm9KmuJdkn9GwyNXGQc5BeqSun
 JZ0WwWkYkPlJuUiyFKCj4SiTdI6LkbUPRIdt/cvRflVkj0nchE2a0wqn2688Af0PvorC0OaBHUC
 9dG8vGWsvXLWt8y1qgHlWQNk9iuS4+jO7GUrHXuXmUw8EjJD8QLCPaonUe0MdaNQxnb3vwFaO3G
 m7H4JIkcpbUJ+A==
X-Received: by 2002:a05:600c:a406:b0:489:32b:ac0b with SMTP id
 5b1f17b1804b1-48fe4fa1902mr9802605e9.6.1778786833299; 
 Thu, 14 May 2026 12:27:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8344asm23108315e9.1.2026.05.14.12.27.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 12:27:12 -0700 (PDT)
From: "cron2 (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 14 May 2026 19:27:11 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316
X-Gerrit-Change-Number: 1155
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1155?usp=email>
X-Gerrit-Commit: 233c768fbf924516315c8488ebfa32b1e88d193f
X-Gerrit-Comment-Date: Thu, 14 May 2026 19:27:11 +0000
In-Reply-To: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@gerrit.openvpn.net>
References: <gerrit.1755879913000.Ic9ac18f730e6035126ccf1cf19799548e5fd9316@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU1ODc5OTEzMDAwLkljOWFjMThmNzMwZTYwMzUxMjZjY2YxY2YxOTc5OTU0OGU1ZmQ5MzE2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1d0450ad4d98a97edebf765a8651876e96c5509b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNbiJ-0006Bn-Nq
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: Move <= 0
 check for keepalive settings earlier
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
Content-Type: multipart/mixed; boundary="===============2516896276117193841=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2516896276117193841==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LSy9okao9q0="; charset=UTF-8

--LSy9okao9q0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

cron2 has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1155?usp=3Demail )

Change subject: options: Move <=3D =
0 check for keepalive settings earlier
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 8: Code-Review+2


-- 
To view, visit =
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: Ic9ac18f730e6035126ccf1cf19799548e5fd9316=

Gerrit-Change-Number: 1155
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Comment-Date: Thu, 14 May 2026 19:27:11 +0000
Gerrit-HasC=
omments: No
Gerrit-Has-Labels: Yes

--LSy9okao9q0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 8:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3Demail">change 1155=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1155?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9ac=
18f730e6035126ccf1cf19799548e5fd9316 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1155 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 8 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 14 May 2026 19:=
27:11 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--LSy9okao9q0=--


--===============2516896276117193841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2516896276117193841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2516896276117193841==--

