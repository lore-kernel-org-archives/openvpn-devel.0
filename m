Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F5B5C79FB7
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 16:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JFWw7l6YWja5Lb3mtGMzILaaWbCENwZcxIUhdSNJKdk=; b=C7TYnPuFYAKHTIN6HWe4MMIpnA
	0tfCIHZGQpdUfH3VfTDi7g7DPGruIU1biyyTerFlvBxYPsQKUMMKmo1M1d0n+GeM8fpcUNeW0HDHg
	XnZF/riwD3OKuLcUXvFgOa7SRQHqsjL7Cy7UW1bmmp11ewlhnTIHtf2I+ePwCuRIAHWc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4LYQ-0006wn-LB;
	Wed, 09 Sep 2026 16:53:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4LYO-0006wh-Ju
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 16:53:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vOl5taFUsxnpkQDOaqC/mWB35S0P4bIxTVmeffeUaAE=; b=Tt08oB2rOAnjMCfdAQa1vPGPAY
 gYaSjZYO2XoNUcYYDhjmSJiZM4tTrUzoIMO7uzRrc74Omh9UkEQsuhaBK9E5Ux+1JaWJ3/j0EWHOK
 KORiyP1a+o3csq/NwSK7Ybr/xMw7NDE01/cdCjq7M2OPBft7k6cVzoJoFKQDxM84Wt/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vOl5taFUsxnpkQDOaqC/mWB35S0P4bIxTVmeffeUaAE=; b=m
 N7bUKdiawmFmMQXqmtaN365deDovQdSeIHkOzjV30wISfe4ysjvX93wX+joyTtonIhmtk7VpL7AE3
 lUCX++KY+ShVkCMBn8JTeN5a4C8Tsdvu0CwefgNBXfRhhRxiG24fXo/ZRm0t4nAsCoXSfpGfHjUVD
 fJCN+34HzED4kbkI=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4LYK-0000pt-NP for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 16:53:42 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f62ccdb1so853042f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 09:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788972814; x=1789577614; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vOl5taFUsxnpkQDOaqC/mWB35S0P4bIxTVmeffeUaAE=;
 b=EUsavd190YQEh9CBHGbRhEv/UnEVyzucvmM9+UobXuFELkIBjozdRA1+XIyC8Bo6fv
 USptRd6ztQEQ5hQ0bJiWUekeU2oHEg5MFsgQOoL8jsANFo2mU7UyFjlnEP95ZL6d+EHW
 lJb7OR4zkiY02vETgTlxWnT74+ZGcSrPZRlBDVcBrjRrhsxZYE6xdVPFEeD6eqleD3ZT
 KgFY4ETNOiDbN1X5lFPCJdCfHaES98y0nqxrMpAECSAwvmpp8wH+AG4Tdvk6e6UQisJ7
 VQymwkAOk/Am4ZN1XkMIxLP2Mu4YmoLZf+Ty6JGKAk4IoPf58t4rZmsYVC3tIapck+6n
 UMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788972814; x=1789577614;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vOl5taFUsxnpkQDOaqC/mWB35S0P4bIxTVmeffeUaAE=;
 b=jncinn1Pd6L5S3I0MlekljQNi+RUCtlSdQFcOinONNkVMqa8iRsJjzOleHTB4IOdzt
 1AmcjQRCanozoemmnUqRBsyPFlHL7YbGLxk1tj4VonFaHzqcrWsI1XhMtL9eYiQbG0Xo
 RIAqKUTX8uIH4jw8Py3RzjODQ2UQu6bTElm0uDDI/gl0tPZ8ReAlHHTxQhX2eI4ZrqXd
 dqltaenOm5Td2pRSD8qK2b3Cw5jvIOwLfvkVVJdBzNg+J4/3PBiqFh1GBYm2abl8DAmu
 6Z4VMn7uUtCsFYdBdlP0lwa7KZKG4NDpTr/V8UIeLq9oUxpY21ujS3vzx5wspvSQq4xl
 Yitg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwVSy6OGB/Oql9BtvNDpJSiD0PyEe5R4nBIgqfB4Et/M2kERYdagaC8Aa1C2F6ofV9sFr6vah1finIZgleL@lists.sourceforge.net
X-Gm-Message-State: AFuF++kfhPE66Kkuv54/Vd1X44KyQm6NAHygbW1G6jMG6sUme8vu/43p
 9VkZJGrFX+yufYTB/dUhP4Le275PfuoychH1KlPm7zINTomDOlaQcM3mveJkD84nz2LzKEfNgiS
 mWS7bRvJSKWKVBi7C5NIk5lnBr92rgc0QW+etsst+ylCV5mIZpVsZWT5wGS50Wj+q+n815xxefW
 zmwLiCFQ==
X-Gm-Gg: AYBFou3Z0RuKtd10b8F0QsM7jmvmNvKg3pv3i3pZXGAJl5o+lhLEcDxt7V56xDKG305
 QVAttNL/uJfzKRkaBkcwZnFm7lz7JR6ypyIOuE+a7hjsPK5DlBi66gNOtRr7PCDRvYPcGrWhbMz
 Um8DiqBEaLs3mjW48DC1zZWW7wPRnWDVww7X+a8nhCx1iWCG1VnLEN9/qF+81llhNdhSq3VlcVE
 1ncmW3tRHWgUyGy17E3M4cxZt1fs0tIoQh0jfjEvBO3lmmP5xf/u/i3SKcJZqLinT5AmF2IpOvi
 Tlf41LH4l7EReLD9ACZrD9qdKvY/Uf2xeRDeziBKkFA3/hQJsaXetFKZW1nw951HBfkj+/Yxga9
 34ULnfj7ySekF4RD4RZZLZkDW78FqgGguC31D1BolqI02E9Tsa7PNlrUgpAoGuoa6gCDGNOXJC8
 UbvKBeWZKYXPWir9b9HpLUedtu3ipkVq1ezzpsHeQKTpk0K6z5H0risHP49H6ArMIdFiw9mabxo
 oqvuSP1Bc+x/F6i9fyuCWLCQHuRyZVuOzmAQEpk6563gIUXLbF8vp2t6MlhiXI5YDDTyDFB02I0
 YQlTULyCUZfi+/ovWRLmFgVss2h+TfsDoIWKazbFJTrdNK9q7O/IBJIy+C1QQw==
X-Received: by 2002:a05:6000:2288:b0:485:8224:1a44 with SMTP id
 ffacd0b85a97d-486e0fa06bfmr217836f8f.21.1788972813949; 
 Wed, 09 Sep 2026 09:53:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858ab73c2bsm43456136f8f.22.2026.09.09.09.53.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 09:53:33 -0700 (PDT)
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 16:53:32 +0000
To: MaxF <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1906
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1906?usp=email>
X-Gerrit-Commit: c1013297930bac77f5d3c4e1ec1ff184870d8804
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 16:53:32 +0000
In-Reply-To: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
References: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjA3MDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7890135920404a210948bfc207f397c83e10d736-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4LYK-0000pt-NP
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: openvpnserv:
 don't allow '/' in config paths
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
From: "d12fk \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org,
 max@max-fillinger.net, gert@greenie.muc.de
Cc: "d12fk \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1727445789833870777=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1727445789833870777==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FPrGMPnoZoM="; charset=UTF-8

--FPrGMPnoZoM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, cron2, plaisthos, razvanc=2E

d=
12fk has posted comments on this change by MaxF=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1906?usp=3Demail )

Change subject: openvpnserv: don't =
allow '/' in config paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 3:

(1 comment)

Patchset:

PS3: 
While it does no=
 harm, it is not strictly needed in 2=2E6=2E The code here checks for "=2E=
=2E" in the path, without using the WIN32 API function that doesn't treat '=
/' as a path separator=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1906?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerr=
it-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Gerrit-Change-Numbe=
r: 1906
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@max-fillinger=2Enet>
Ger=
rit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko=
@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerri=
t-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: MaxF <max@ma=
x-fillinger=2Enet>
Gerrit-Comment-Date: Wed, 09 Sep 2026 16:53:32 +0000
Ger=
rit-HasComments: Yes
Gerrit-Has-Labels: No

--FPrGMPnoZoM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, cron2, plaisthos, razvanc=2E </p>
<p><a href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail">View Change</a=
></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?=
tab=3Dcomments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">While it does no har=
m, it is not strictly needed in 2=2E6=2E The code here checks for &quot;=2E=
=2E&quot; in the path, without using the WIN32 API function that doesn&#39;=
t treat &#39;/&#39; as a path separator=2E</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Dem=
ail">change 1906</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1906?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: release/2=2E6 </div>
<div style=3D"display:none"> =
Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087 </div>
<div sty=
le=3D"display:none"> Gerrit-Change-Number: 1906 </div>
<div style=3D"displa=
y:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owne=
r: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: razv=
anc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron=
2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Wed, 09 Sep 2026 16:53:32 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--FPrGMPnoZoM=--


--===============1727445789833870777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1727445789833870777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1727445789833870777==--

