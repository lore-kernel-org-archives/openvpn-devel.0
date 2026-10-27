Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF710606A31D
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RDY3i42B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=esV3IHpr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BRb4Ac3b;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VqhVes7G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oTJKu5mxbJn6mFdk+3UppDSOf/HKM6hQN4UJau+qzAE=; b=RDY3i42Bok64BYixylR9mbsfQT
	8qA7GZC9jS3SsasUBHLjFd0tnEan8EenATESbh40F1g6EtTdbfrdq2qY6DDqv45Vx2Wezrc7zgkPQ
	AqVsTLGPTfVGGmgE9Ix8g6JtbSueadx+KWQooQq0aZ9cQNZL5k7F2gA0waOpIIgfCSUs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLhJO-000000003eA-3vHu;
	Tue, 27 Oct 2026 13:33:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLhJN-000000003e4-2y0d
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:33:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1GfC4NvdbMMiUsugOP25Pt/zoVlHIFEIxvMeDCydPNo=; b=esV3IHprfXY3sTMYKZK33nX7Hz
 NV65sWGWKCcXDJBkknbFOkXgDIQqyiG4c7qSDcqZkCptGQa3Psw5Vs35cXLrGNpYF7u3x8puTrB3S
 S2QBX4bjNcqzVqJZHuhqL6B1PXghDI8uWdJmqSgdCAWCQS3L2h+zeHqfTlxbW+kligrs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1GfC4NvdbMMiUsugOP25Pt/zoVlHIFEIxvMeDCydPNo=; b=BRb4Ac3bTUu/Z+vd2q1GIHbk0S
 pph5kRIEYEhUS/aDdQU6bjoXCXyq3K7dAyfKcUh2Unyhg75zdxmMZPK1LhyPlddbnTBRMF0zGem9S
 HH84PkazSycKRi+rXgKn0+XALTbm+wH9AwbxezuBmY2JMweX/+Z+c/ndZfHKJK/zsr9o=;
Received: from mail-ej1-f41.google.com ([209.85.218.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLhJM-000000007Ne-0sxO for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:33:57 +0000
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so666085966b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 06:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793108029; x=1793712829; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1GfC4NvdbMMiUsugOP25Pt/zoVlHIFEIxvMeDCydPNo=;
 b=VqhVes7G2psbX/yOZWr3OADBrK7iatI685+HiKSskHlN4iutjR+WQr6AT2O/oib/xv
 grgk3blDmV5eH0/IA4eLsZXrHQad9WVyQi0M6t/agKr2waMxdvun6Cm7NoMwZLLl44Yp
 9AtPIPyilKo62D0HziG/mp+mvBOJsj7a7KWkJMEvxrcIceUfheOmhXt1i0+coiKYwEgb
 CZXGIcvo1H9IXzX4R1tETTRsSsWLNOOevbXcJ33rwjweZ7fhddH2ZIbEvLxWBmMc0p7B
 xpbfBVKF1ir9lu2aEMRA1ctA2Is/40R3h8Ac7vPFVsqV7vMD4IOiRfM5jOnRyFqu7lBA
 2+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793108029; x=1793712829;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1GfC4NvdbMMiUsugOP25Pt/zoVlHIFEIxvMeDCydPNo=;
 b=KxSZx4+mY+EavCEJhNrYplGzlyLOgqjy6NGHaYwUxNYCsiJrPSbBOh2X5o/CpPhz4Z
 VX//I6ZSJKrc6ifhqcvaSbF/Msnhq3QzHETWvdtPcfNoXr+48roiRmcrr61RX5ZowPCr
 QB+lrucB6e467xKouLdjclHjLzWEdq2Oa1wHXNBeVFUhpnQX2zJdgMBHDaVBH361HWgk
 W0R4CGtg85wQSv2y6ZPlIx3xG3EYx+m08/OhKxHOsPqKjgKooc0Jce9X9aj0v4VOauOT
 408PYowkxZQtY1kQ0vnqAVxdhCx6CwQT8GDZ4gaI6gBcH5fW9xPz3mHs4F29Hy0Nf9PE
 LblQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcA3nBA63uILBHYz0o2uOJvmEPk+0xsZ/8cb1MPyT1ovD2uG/Sguf95xpI+AgQuT/r76Y5fXgqcyIzBVge@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK1VLOrxrvcFBF+w3RwsZYt7PvsFkR8qAyxJ/1+V98e6dvrK62U
 jp36jtw5B1N3B3uxU/ejIVQXyyCWsYjMf290ztCK94lcv4e6pSqiGkcyoht80GZtWV9v9JwfeUT
 EoclpKKJthjN13/56K+XvoDiJT7feEUkRTJd3OVNQhSC1GdC8Wh11nNVFz5ImK/xMip1j
X-Gm-Gg: AYBFou17Xu5HtYimEkmh36BE9Mp/HWtLu9hNOvPbwzPy1YTw5U3kL+2nGTd4N3BuqNr
 ESZVexRx20f/KFqMU9BxFPH2iUXgeh76tS1LeqofkE74CIrySxOs6oezQS9zfQnlrTkD4ika3Zj
 dt6+USPWS8ba3rfYSjw/vINXJaydCCMgLch938jRqIEerPX3wAoGXcrNheCHmaC633y5Vs/5KzG
 0RXq9g7ABeRUUQ1afrC/r101GSltMs8lTkbCzyteD03ZCtgZ7oABsg8NLSdLFoYl+lZT1tr8FqR
 rAinZ12ZKz5+U9guZeMCjx3XerjA4Vmk4Txq1DpT1bAxuHnnm3d9UYZJhmx6lgODgknJyRr3T07
 zh5dBr4KS4vZTgWb0IKB8M+1uy0bavEz6MbweRCnL9fqxkQcIAtYOBnd21tU1IxsBZ1UtD00tZi
 10kQUELp8gMzTEjC2CDLI2IycRZDyYNQt51+cyz/uTT2QGdLq79ItIKAK7aJFz+x03nrB2y217F
 U7V01EAsNuqn7W7svxmGK3S39b57GqCHY+6dQT+OwfZVDrjLITI+Kbs/Ff9iDzcmt7oDcHiFNV6
 dUpCIduWKTvbHdfN/YKAZLMZb52RqxbNIqBZtBxMQ+hRMgk6G5xs2SiCQO+j7bT0Yvo118t416y
 KEyFdCQA1mQ6UQ0RhhJbqWqXgB6IK9/1WZPBVoWH7aUg=
X-Received: by 2002:a17:907:d40c:b0:c46:7ec3:fdfb with SMTP id
 a640c23a62f3a-c46bda56ec4mr1042447166b.7.1793108029272; 
 Tue, 27 Oct 2026 06:33:49 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb8d5sm23965616f8f.28.2026.10.27.06.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:33:48 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 13:33:43 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 8747b625499828f3ffebaa38270409a05846e4ac
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 13:33:43 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5a20c595d326dfba3b558e7c196c09718444b130-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLhJM-000000007Ne-0sxO
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============7616848473832023229=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7616848473832023229==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZJCfHtvC5+c="; charset=UTF-8

--ZJCfHtvC5+c=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15: -=
Code-Review

(1 comment)

Patchset:

PS15: 
Sorry, meant the +1 for another=
 patch=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a6a6e=
f41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-PatchS=
et: 15
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revie=
wer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue@open=
vpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atten=
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue,=
 27 Oct 2026 13:33:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ZJCfHtvC5+c=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 15:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ddd;">-Code-Review</span></p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858?tab=3Dcomments&amp;usp=3Demail">Patch Set #15:</a> </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Sorry, mea=
nt the +1 for another patch=2E</p></li></ul></li></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change=
 1858</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: chugly =
&lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 13:33:43 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ZJCfHtvC5+c=--


--===============7616848473832023229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7616848473832023229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7616848473832023229==--

