Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E115CD8CA8
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 11:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCmHROIl1h+RhBXiE7syypg4uPcWSnWF04/kbCzYxQE=; b=mq+oGWan80+VyqExllRcPHJE9f
	jfhzEJ4VQtGyREWpRIbu6aoBgkaHO+aSMjFhAkdLHp/Tia09/bZ1Bya36O19E/WV/PyOecw6K0ztp
	pI+NRPvfqnjnBSnwbliIA42HCdNtCV9W6AGzOMNV1nC5XLW+BSyALk7XX2hdvhfHLW0o=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY07f-0004Vq-BM;
	Fri, 12 Jun 2026 11:32:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wY07d-0004Vj-AO
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:32:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zX/09/molhvwX+f+MJ14toec0AI3MByNV6vWrSpsCw0=; b=cFeYPeUmnUCYDNOF2esWFWLp10
 V5nHUqKyTEDks4JB621pbSkhuN088RVFDTGprYg8akiVvvkZ+Ug6M0ESHk0FS3De+mkBAnXuczOTM
 6+DXd50xNeCmkpFio8+jSccOWrv0T9GlwFuaBFT+X9bVr2grfQegKMxRc/ifBUklvfic=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zX/09/molhvwX+f+MJ14toec0AI3MByNV6vWrSpsCw0=; b=B
 nj8NmmPnZ/4I4y7N76AdGHxRma8uTnUraHB3jEY9VsBvNPnAwIdku29/OMEXBs3Sc805P7lSjWxyW
 wsnC5c8YnIbwUWhlNJOSO/VddGz4GL9Z7rvlz4eU5EXCNbehj/BLOe+Zfsiw/N76ADoTsqvxymTsY
 sXb7nNMwEfPTGglo=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wY07b-0000U1-TT for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 11:32:25 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so5875285e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 12 Jun 2026 04:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781263938; x=1781868738; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zX/09/molhvwX+f+MJ14toec0AI3MByNV6vWrSpsCw0=;
 b=XdkAg/vixtlTh8UX2GXhxfZZXRyFov9aCxtFccMAw7Qp7k9wmi4secVJhg+UlWR0BH
 1bP26FBkVSX+T4z9DR3NHL7BPwxcqSPrpBdBb4meFAxubrUUNG8+zIC/YoVMhBqYVWfj
 y+YrcF06jdG5QkdW9Aj3/fPzq7URAnntRLyqZk0MHb2nR6xvHc/Tw+ZDbRE4gVwBmhkA
 g6EJLWPYL6G+t4YAd1gXzKRgVA/lAGQQdIsSisiSXWnGDPip55L4nYf0KisRUS2/Z6GU
 PaMFInj7eWdBRpBQmt9YKqd5vXlhUeSbTb9ebCnHApXZ6u8rswBnXX4QRqoNfzto0iLe
 ichg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781263938; x=1781868738;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zX/09/molhvwX+f+MJ14toec0AI3MByNV6vWrSpsCw0=;
 b=Uh90yRBnUDn8QNsuRVj6FEWKiRH4dWIvVoBSkW/BrzFyIguhLnShXwkX9p8lsszJK1
 yDFjmLwv73zuZAjqDqXqkqiksbQc596rnluO0PaM0XdJLOwe1k62/D9WedrwOY8oCpg3
 1dXiLMYmPTDn+VgpJT9o5hlMjJFAzWfQHAVgL9zC2j+7ku494JAWcjt2zQXnhEnkJ0/J
 s5IoN1v8Z2WLnPAUr3MjFHbppYIYuFvEttFD11ZNHGyBNhA7ps0Nqs9QHb4TkQzPyQk+
 UpMtAounDOEecrSNpX7H64o7zFlPc13VlmUgVuZ9VKOBAZfwz0ROXaoAXUgWL/TrRz8I
 0DfQ==
X-Gm-Message-State: AOJu0YwbJA0pLHzm9FE5nCOmV4FMTAsL/7OGxLCwT79JWWQfqLig9499
 AsxSbInrEbr6jmzs1vE+dmeAiCZzkETYcFih1rS2fkMD78aVxzA3WIBLT9fzwHBev60aurHfEnb
 dGLuJqIJcvT286GUEhGRZH9fUgp1wrsRG3YfsLU2T3/gh169gRp3FJVxIfKzrbXbLQubKN07R6X
 3GorQ3jw==
X-Gm-Gg: Acq92OEzIFX0IFanofmgbt/nBzT009zsALWhog4fwo5EfBjjZvuICyhej0Utgo+CVFN
 VZ1dGcy2EKik5N8hP6Pvgu5mXd0+wmpNDCvDoMjpvGVz9AXb2s1wsofARI60FeQLj+jpga7CexX
 Kso61IRmdauUjNIZx5k1WCKLOhmwN3Mua0rW69rDXmwh2zP48NDdv/+jbBbTu0WBcqQ0OeDBsLN
 f7cpwSIGb2KhKxXBdx/yWhXvdWbHDPFxCnBrG4rgN+WuWymxjS8LyNDgJ4tab/Yk2TTGx1tovh4
 jcCq9RNfDkKwwEq8RpZUk318UJp0U1nlSR0X7Qmbk73mW/qyV6FOPPigQHj8Gmjkc77h9agiE5B
 JVTa/PUEF0eU+0+7tXLq+sXcsQfDi1C00ntrWHfVWyV03foYvdH/2+EoAnvXEFEmiOzXXMf9vJb
 1KgWp2UPTXB77mIo4TXCZ78a8GhmNP8ao+4EWICSg6uLY0JxFZIDVPPLh3kiHq40s7eAOS8Y1kT
 2RIkbKE8IfLif38/CGqK+1+1ANwwUd/Emv46soxB9X+gr3dYodoxxP/6LJ6c8wZ/GsejrcFhU1/
 rcM3gr0gktg1tw==
X-Received: by 2002:a05:600c:a09:b0:492:834:24a2 with SMTP id
 5b1f17b1804b1-492083425a4mr3193275e9.16.1781263937645; 
 Fri, 12 Jun 2026 04:32:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f263945sm5195469f8f.8.2026.06.12.04.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 04:32:17 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 12 Jun 2026 11:32:15 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: Icc31b7fa0da86220df45552aecc15dc6c769cd54
X-Gerrit-Change-Number: 1293
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1293?usp=email>
X-Gerrit-Commit: 7949db0a820ba50e21c2a301a687ecf0c40f99a0
X-Gerrit-Comment-Date: Fri, 12 Jun 2026 11:32:15 +0000
In-Reply-To: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
References: <gerrit.1761063820000.Icc31b7fa0da86220df45552aecc15dc6c769cd54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzYxMDYzODIwMDAwLkljYzMxYjdmYTBkYTg2MjIwZGY0NTU1MmFlY2MxNWRjNmM3NjljZDU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d8a286ede0c961c460305d75194e32142c677323-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wY07b-0000U1-TT
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push: Fix conversion
 issues related to timeout in send_auth_pending_m...
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
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2856539566655940799=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2856539566655940799==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="67Lbvj8pnSo="; charset=UTF-8

--67Lbvj8pnSo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

plaisthos has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1293?usp=3Demail )

Change subject: push: Fix conversio=
n issues related to timeout in send_auth_pending_messages
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 12: Code-Review+2=



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icc31b7fa0da86220df=
45552aecc15dc6c769cd54
Gerrit-Change-Number: 1293
Gerrit-PatchSet: 12
Gerri=
t-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <ger=
t@greenie=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: flichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 12 Jun 2026 11:32:15 +=
0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--67Lbvj8pnSo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p>Patch set 12:<span sty=
le=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4p=
x;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail">View Change</a></p><u=
l style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail">change 1293</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1293?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icc31b=
7fa0da86220df45552aecc15dc6c769cd54 </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 1293 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 12 </div>
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
on: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Fri, 12 Jun 2026 11:32:15 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--67Lbvj8pnSo=--


--===============2856539566655940799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2856539566655940799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2856539566655940799==--

