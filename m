Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2516C61DD3
	for <openvpn-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g7gdjY8nIP+wS/GGzwS0y86dpINrXqrdp+etpJjCD94=; b=S9p3oGixPvPmPqKY4/vziPWJ4v
	w5FCWaV2ozdyVShsTZ06zELD26SIW2lucy8uBPMn+GoyiAaf6VN3LB+OPAbpc0kFB3Wtb5RQ3mhCI
	YUQqMFkbz9O/qSJvdPQOAxAHdwCUXpgelhXo794mcrl7l0hj8gVJX/pua1ZdKbnV1K4M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x256h-0004Qd-31;
	Thu, 03 Sep 2026 10:55:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x256f-0004QV-EV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 10:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+j0fxomGogJmaxSXiWAALtZWTgmTwvWrG0TriW1/GUc=; b=DCqB8G1sfeWI8eq8e1Wmwm2Zp3
 fEXRLLMp7LfclqGdtH6V7kdLCsHvLp/DhVjsygKt0l8AGDYrAlL2bN7botz/wyQtTyJQAjdfSzJxM
 5fNo1ACaoYO8bKXET8oW3hurNC0/DSbYkJC+8Fs35g/OOc+wOekyWdUinJYUfL2CwWU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+j0fxomGogJmaxSXiWAALtZWTgmTwvWrG0TriW1/GUc=; b=j
 D0o+5Mn/zxO789XzpIvYIaoMpNmYfLgGOQvZTwuPZ4DyjWjl1E2ZB5m6SpG/VR3vXzlm+LWzSGPwN
 rpApWTX0fmbbR94oQWhQFMbYjx3UwRxyXqOguvPyEaQ7oawK6CamgifVrYvtWhbNIWWhj+9HeiUKQ
 eowIn638UjbF7NyY=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x256e-0008HT-ND for openvpn-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 10:55:45 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-482f9309813so2100318f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 03 Sep 2026 03:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788432938; x=1789037738; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+j0fxomGogJmaxSXiWAALtZWTgmTwvWrG0TriW1/GUc=;
 b=Q9zoAhL2HCpMnF5omYsujqI5oGOpPmvewp/tH482VSsMqzHn66/NCpMcpKIrjlRS59
 xsMFv2Hhn7D9RWys2XlhBPKTOk8qlY8vJ2ZW4lq4bdQHEfFEI73jBYyUWa+hRkCixXO6
 P5GEjV3oP/W2NiAjDqVnG1toXmRWB80CQd0d7bGiaOPJSSA5Lb3oEgIzkZwuphztRLXH
 ovAAeY/ScA4QFDeuPq2O3OPmcBYQvj0mi2i4T7F79Pgm1U++7qOlEoMyMheRm1BOaBuF
 QPs6DO+18hdQJJkX7wiXb/9qIGIdzJzGp4EVVGq1yUr7u6D5iBqP0XPp5PAuPpu+A5nS
 PNZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788432938; x=1789037738;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=+j0fxomGogJmaxSXiWAALtZWTgmTwvWrG0TriW1/GUc=;
 b=jD78CldkBR94SNZTAGqUwZxH7K+dkchmzdH+p2ETOpjK82dG3oL57DMURoIuNJ6yll
 naDyjT26/JXxenYUfmzQU8temhJcqAOf4pZ+jXWjTSmV9nRLTePzFEJQUiqCJQ8wSUK5
 HcLlOXNLkBoRDsBwWQ0mSN1SZrjtCD4MnsYiW9w/H5c926L2iQSZARYY69cowXFItBcH
 /gGXdWEU6hhnWmL5pyeOLq+Pg4F9lGxJngSLZufGTtFH/BHcxCzMV5spTyTX3KvTZ5y3
 DcBmPQVHKfoCsY6mX7wbsAkZYzGicomYxD/9p6EoC/svl50cWHlUm2yHmvFzdapQomLT
 sahQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7l/UCmpPAgG33BYlvbJayeb1T03GNNoEw6mHXOIFaq1qRQiYBOp1xzYvMlnU9p0bde1VccREyppZFlgaH@lists.sourceforge.net
X-Gm-Message-State: AFuF++mEwsjP70ofjNIGEXsuQbXRZgxxBbZkALEZPu7Vhu/HykoEcINu
 hR8vG/t+oUxpTGeIVNeN6CWwKzRGzPKg7i3e8xIBQfnS3l+f07GdaZSyi3OF6M4n/Bu15xcKi9C
 ThpqbqrHfRTgUwkirVc4EF32C3DhAwKqMopJuyVAfyT1uSkoZZoCpqt3NJ69rJYevsFdJ
X-Gm-Gg: AYBFou11acgAYswWuzQjx21zhpt1AR4kEc+DN+sr+eFy8hVt7+rVvmGkxwsitmPgTCy
 gRHrVLyNcl4CsYZFazZPgQPmDtBschjcD064V+9FAoCmSuxx5+46CTETwRWV1+TnyGKwHbiIjJ0
 WvrxipFP7fLMEIryvU9sUhEShfKNMpSI4m+ZGMw7h5pN90YUkFLDhxyic8t9+xMHif0MYU0Dzta
 45GKLL9p0QADOgHvBU3MKCCoGYKQtrbgu3YtBKrMPGQiKZa4LVL/dhld/DgRYI/mmSww1ekXmAL
 wviJLnxRBwy1EhHvCX3M1e99f/uNo6ixyOw1H/hO/nUi6yf5ZXYKNKktbVtX0anpsFgcDTJunaR
 kTSqjrPgAktYrkCX+kRc96IHuZMe+mhJjr4pj9i9S5uyVUt8m+hYP2DX2Rqo1b45F9S2nhYcDur
 X0uqDZ2ZZZuR4P0mJPDY7Ovgkz3/DT+Yq1utiye5FAvsd3HT5bvxmQ6pdSUNCktpnymYIBhOrIK
 VPuxVIcykA1oZtc31PLNUa5immGAeIvBYQ6Ws9uJbtu5lnj7E2NZommrbmFLW+uSWVtzH+oky7N
 3+IyQWPvrOPW7+KMDdzSYXCqJAAKDL1Evhw4hm06XPvl3hDSOJQ=
X-Received: by 2002:adf:e008:0:20b0:485:847f:fd8e with SMTP id
 ffacd0b85a97d-485848000f0mr2304072f8f.2.1788432938114; 
 Thu, 03 Sep 2026 03:55:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80388sm14613357f8f.14.2026.09.03.03.55.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 03:55:37 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 3 Sep 2026 10:55:36 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76
X-Gerrit-Change-Number: 1895
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1895?usp=email>
X-Gerrit-Commit: a7ec3039f051c7664d7d004a1fea2a301d4b639f
X-Gerrit-Comment-Date: Thu, 3 Sep 2026 10:55:36 +0000
In-Reply-To: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
References: <gerrit.1788431406000.I70dfdc70778458b78f80b8d0b0b786f18fe4fc76@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NDMxNDA2MDAwLkk3MGRmZGM3MDc3ODQ1OGI3OGY4MGI4ZDBiMGI3ODZmMThmZTRmYzc2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <dd1b9e2dcaf374e05ee269eb23bbe6e1f7416d7d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x256e-0008HT-ND
Subject: [Openvpn-devel] [M] Change in openvpn[master]: win32: stop cmd.exe
 from expanding variables in quoted arguments
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
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1257933567240570290=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1257933567240570290==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6OY9occueR4="; charset=UTF-8

--6OY9occueR4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa=2E

razvanc has post=
ed comments on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1895?usp=3Demail )

Change subject: win32: stop cmd=2Eexe from expa=
nding variables in quoted arguments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I70dfdc70778458b78f80b8d0b0b786f18fe4fc76
Ge=
rrit-Change-Number: 1895
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@=
gmail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Com=
ment-Date: Thu, 03 Sep 2026 10:55:36 +0000
Gerrit-HasComments: No
Gerrit-Ha=
s-Labels: Yes

--6OY9occueR4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, stipa=2E </p>
<p>Patch set 1:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail">View Change</a></p><ul =
style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail">change 1895</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1895?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I70dfdc70=
778458b78f80b8d0b0b786f18fe4fc76 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1895 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Thu, 03 Sep 2026 10:55:36 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--6OY9occueR4=--


--===============1257933567240570290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1257933567240570290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1257933567240570290==--

