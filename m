Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E54FC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEWElRyB54GtmZm7X9yoEUE7JU18L7xbC/kHhjXaz1A=; b=NATzhJztGYUwvPD3wQZSkFj4IL
	Tuz4mFUVWDAyJQibzzYBT8oc5yBSBPxyb/kCwPNJgmEwAxRMJUhHZzW68Tq5n2sZw3AOOi9Q/d9IT
	wOs/SKM4lrMMKm0lU/yAgPkVRezRs4kJlXwHMVzZ5IHY6m1hhq+aiPQhlclv/jS+Bj1U=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvzXP-0002B2-4M;
	Mon, 17 Aug 2026 15:46:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvzXN-0002Aq-KQ
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 15:46:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=j8Nd4GDcD/3SkLZ2OJGlgofan1zm4dSFKsxS0qnuIUM=; b=X/ughdgG7VXzS7VpZ6TVrMo9E7
 uyTgCiYaLc1umES1binB3Sryls3EMFvqWflZviA7YNK8rbukRfeuN8qGVTxGx2OdRuN88/klreXCs
 gGj0nszIETOeYjg9cnne7PKwao7NiVReGdZt0qH6LccKM5rsNIHNOQMHWqSsMXKO/a3E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=j8Nd4GDcD/3SkLZ2OJGlgofan1zm4dSFKsxS0qnuIUM=; b=L
 XnOsIRPXfg5EoznfSINLukEgE7ygRvu65PEW2cGnY68hGCTXp/fL+awhOCpVediLs3WNR6suUVQ3u
 0C2uniPcVaku3ASkAm2lvoDGQ9Gm9P8ULURBmPkOW6EbC0r9BRhD0lUUNCf4WdQ/B99hbhgxsWTlV
 JwBxRHK8mQnJcHDE=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvzXL-0007hp-JN for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 15:46:10 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso1967461f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 08:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786981561; x=1787586361; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j8Nd4GDcD/3SkLZ2OJGlgofan1zm4dSFKsxS0qnuIUM=;
 b=YamdASyVyJdYWLWSqZofGZUmNl8NrIWRcb7kpBQM5Pb7y1ZDFV4ecbN1c8yAtjXPUD
 Feh3j5dFOY+mGwtyptageAXlQ3FzHDmUJJJR4Ortj92JCDQCHQn7e7uFQuTvqv3zMuYb
 TqU2cVbl6dTwvCMUNMNOdQupMSzXhIh8DKiCvVniMPUBbPzTEK9bTzLnVGniRpPqwmDZ
 oXF31vNhlyxd1z5HyiQb2avTIufO6czwX1yYcnBUaumjG9cg1j+OXEMkyCf/wtI/x3YL
 R9iSpktRnaokam8V4pThYFCpNpbDLzawKWmlJ8kZLGGXutN46zKpr27WAURkDFfVwBtU
 yYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981561; x=1787586361;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=j8Nd4GDcD/3SkLZ2OJGlgofan1zm4dSFKsxS0qnuIUM=;
 b=NMTGXUOxNZCaGrQguBFFTx8ktyCOQnVroa2lhZ/PtBjgSRjo1BZ4jMGroi3mJfP9aA
 BA1ctYcwtOGhZwQIRwVigpZ79GLO0aNUtqJgtyja5hTrOyUGNAxf0IWu7TOE9cpimxA/
 tcsha3+u6Ba53Ixqnh5daAdCRxiTfrwPh1c/oaRmsjT8Pshy4XbwFbKa2FYI0eJ5w3tJ
 QS5qPImIw8COcFPo9oXbda2qjHN9qrF6pRmXsRRQLdFVVCH6OAxB0tGf1BmH2IuTDEAX
 khl6Oy+tYB+44s5H9zIpPzSQU0Q+WhZMvaQeAs8deyY2flAGbj3HFTm+VZb55oQQjsfP
 zyUw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/+P0TBWq40kZnKYMLXyr3yHYn6VFV0EmCXKHBjLidb+OC5duobUSwOt6p9CU4Pymd5BH+qhdz2RukapVY@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yya8QNVJU/An5UAyvG1T9vdpIlgrlRcfqydzoKZ/5wKbdLX/21h
 hY1/ab5D/g4r6FB8Hz4k09ZAtjNHaxYEv1woXa2ZPqbB4/hvf4+UauwuFlav+lpiBe5Q8pAwOU7
 HRIrKCgkeRSXYbTXkiueJ4qHkdd8neqeJwU3MGwMOYRwR6iz1CwvfJIhLl/NbipIj/eHQEcJ8bY
 IpLPV1Cw==
X-Gm-Gg: AR+sD10u/3ksnmWLh86nz5buzC3VXHRptUHbPNwFVzp4Fihb7RMrtEVyzbmIC0UtQS/
 EWAX1XSxFa+c1qtRUtQ0Ybl8ldE+LF0eGNmsJil78qzas6RFeNd3Kz/IXGKdUctU5nU6TFY+9qG
 Ia+YGt+eC63h54rG4E5oKqcduibuq26sy953BTPUgnOZs1Nxk+3vK8jmGjQe+QRoX0ucr01HVOz
 sf3BWTgqxRkDbPNP0lDzWTZNxngvUkcigW9JvoNjJao5tFhgiwy/jo9IKx1l90pLSiUw2quV5cb
 PPUT61gEsquq9NMVIr+4g0XDeResA48Pqen2VvTyRieWbxGUu44SLnvOkG7SW2R1b7KxlREaMNu
 plB0ebWwlNu0iadkLFISJUOcRaGTKFEolBzFFrwLxrhKCSdDNnB0LvJzsW+iKWLqIRaxZvykRBr
 sj07lmRpD/Q6gmgQtfbs40Y2mud/a+EzMNzdfZXAA+rXSRO9cdWGpITYsqCQpqs0p51byETDpY2
 HubcZBJgcW2jQrJISMdT41uKWgb4bh1DF19U0HpGZdw0EISBSRAx3GppqI2URrquqeU+vxm0uca
 4WGLw9I9N6CKq70rDBNXpDFhaLtH/hzTtyef/hS0vZw6fo3A0IOeMxyx444JcbQ=
X-Received: by 2002:adf:e193:0:b0:47f:25db:8161 with SMTP id
 ffacd0b85a97d-48160763c02mr42481490f8f.28.1786981560784; 
 Mon, 17 Aug 2026 08:46:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b487sm4688504f8f.10.2026.08.17.08.46.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:46:00 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 15:45:59 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
X-Gerrit-Change-Number: 1776
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1776?usp=email>
X-Gerrit-Commit: eb5de4531a82503632d5090558a5844c2fa41ac5
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 15:45:59 +0000
In-Reply-To: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
References: <gerrit.1783613384000.Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjEzMzg0MDAwLkliMTIzYjdiZjU4MzE3YTFiZTVhZjFhMWQ0NWRlY2I4ZjMxZjJlYzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <29135f689ceea7f679a492c02f30e3c74b9ec687-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvzXL-0007hp-JN
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Start a new document
 CODE_CHECKLIST
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, ralf@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5225812265592879863=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5225812265592879863==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ccx+zFqNhCU="; charset=UTF-8

--ccx+zFqNhCU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


razvanc has posted comments on this change by flichtenheld=2E ( http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail )

Change subject: Start =
a new document CODE_CHECKLIST
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68
Gerrit=
-Change-Number: 1776
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: ralf_lici <ralf@mandelbi=
t=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-At=
tention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici=
 <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 17 Aug 2026 15:45:59 +000=
0
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--ccx+zFqNhCU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p>Patch s=
et 3:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2p=
x; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a =
href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">View Ch=
ange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?usp=3Demail">=
change 1776</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1776?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>=


<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div styl=
e=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:no=
ne"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Id: Ib123b7bf58317a1be5af1a1d45decb8f31f2ec68 </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Number: 1776 </div>
<div style=3D"display:none"> Ger=
rit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ral=
f_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Mon, 17 Aug 2026 15:45:59 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--ccx+zFqNhCU=--


--===============5225812265592879863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5225812265592879863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5225812265592879863==--

