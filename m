Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A807606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=B48c+e0K;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BSvQUsoq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=amcmFzZw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BdXD0+aD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o54KAEz5dSbNsb+psf3QhdzjPK9o1GYqajAqDdeQ2Mw=; b=B48c+e0KwWh6OAS+Wj9gpHCa8v
	J4Ih/VBSNDu+j1K3WXeeiVYp5iJitjrZoPsVPO5TwKFq/X5vvhXuXZ5cNkUeDdVrbuaDYRIu3YGNG
	oAe+JO+ZqegRQ3QEtLk8gsfwm8+LaIRLjT1GCMilsWN1lKAFEFLfBj0Z3olkbP6Y28/I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGKz-000000000BQ-36Rh;
	Tue, 17 Nov 2026 10:22:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTGKz-000000000BK-0J0A
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:22:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bmUyQt985IDxNRowDlK6CVw389xphu5o1tHIKExNtY0=; b=BSvQUsoqb8G6TuU8X+N1H19j4L
 bClR+Dv4LxxHdQVGuT/riCmiJ4bW0tagnDbvXaTNqKgvtkmhRnBvL5LrLEC7068ydxtbuYIs3mF3h
 oAffiRC+Lgay7Qd4b9HD0YDtr24syAG3lajk5Z5P7U81pHP3smAD/gEq4vRwEP02/2N4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bmUyQt985IDxNRowDlK6CVw389xphu5o1tHIKExNtY0=; b=amcmFzZw69BWNR3YiUEzDn4spu
 /TpLHKSblcovGKIB7Y0+V3woWOxKWlwEupIDxcH72IGq5+kFMwBCiS0c+h3whN+5otZKGEoPldE7H
 5ZQ9K2mIhcOPyOmXWT8DBKkoOv7amzPQn10pA0r7d6F9XZhoM8+6+vVutnw9f4kxv5kM=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTGKw-000000001v9-1vfF for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:22:52 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-4a357b1c649so489134f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 02:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794910964; x=1795515764; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bmUyQt985IDxNRowDlK6CVw389xphu5o1tHIKExNtY0=;
 b=BdXD0+aDjmYend8smiAw+/LP/oxzn/P6G6uuUp28S7+eH+gCFo3XsD50x3nDJjD8Lr
 GRdVnroPq0nO4541hC8K3HLf5gXyYCsI0LP+QpF0EL1jq+/veR03kjDuz/xJE3ewOI0x
 AFtS6yBG2gt0yLozdF953LTfDAAa9NpslA+4az28cAkkd9zQVVWboKFWOB+g+bkGNK2X
 4xMI+eprr3dfyagoalSY/dPtFPRSYGVY0C+N9yzFNWBS8dg8SHKafny2D/gWt8HLlJ9Y
 KkQxkBHRJFYPA40vbNBgZlscoDw1uGE6tvpccjJweXvOB8geNtspo/ixHxD5fXBbcTo3
 MJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794910964; x=1795515764;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bmUyQt985IDxNRowDlK6CVw389xphu5o1tHIKExNtY0=;
 b=ZEtap/fICwh557LZwK4U+/RvHN1KaG9flYagSCNBShXzAj1cwoLVgyVwcW7Spw7uxi
 MZpHuloxWjs3S1+X4fiU/Rp+ziChFm1bWWQcoR1jaEHbWH/0cvWM5j6XTw4O6//lSsJj
 0P9GyYcU+6S2/NQ2ReaUpKRY22TenJoiNxIA9lyfLiZjhSO9lzVT0r782apBhD8MUfGb
 GzZuLhnS0Xe1MU7K+bDl8Mxuux8eeL3m5u7vhmYMdhO+rbfOugPwGtcnGEzDA3xCUwtY
 ERj4AxQa0ZQ7qE5yX7+x+ADfORR0ezm5RLZINxIWcPc0MuKuL1226Ir8Hr0pkSkKHKdN
 LooQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFV4vAEccGwPS+0CacpouX2zUyLqmzmjfUPT44811pWQ31+bFvntB0WOI946ebWe6luXRnH5MLpAilbnAeH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/CXWPfNBNMk1rde5aQPsY9x0S6PYM4SPq+6vLEVrm37JhU0Oo5
 VsiNQEpN7pkEe6TpBlMicdouozO83c8ZsIa65O+Sa3Aygn52K4W3WWG/eZqbZ6op26XCE6KVAub
 UlCOAFBOxZEUJ6WtkuOkUseIfON10VLsHb+3CpPz2KYnUSuNbHZY7fbNsov+211hZ6wvxiLz+tz
 +Qe/jREw==
X-Gm-Gg: AZFdTZc7fYVI/RYlwDdGEwymPcju47hvAhat17h6nNeIFY8Iy2FMQPziGwh9X8/p354
 KXsFrcDLGe4UyoRV19mfEwRmL6AY3zKRUbt2LnxYPfogLOIwOQOUmGFVfWf74Ue9N+Frf/BSp7W
 pmS/IP0suGniPTmooKHQEZJrxLWqfADEPBASXZ/z4/YAa2YXOhAjxAz1VCynQEvWDSVSnFLYy06
 dSQyDl55PAVXqF1TItqAjrVnl/c8UPN0y8xUcBqL/9Jdjzqbma/0TDqe27vOcQ05GbftzZE+Vis
 NMQ+UjwzKbC7Wj6Ojolox34WEKOfE+UnBWuqOwHYpxYB+l0wSoLzWQ5mW/BtIYXAaeufZuaWVv8
 0cv+fwyxFolgMHMis3mMPSoAVoamBvFoHlCp+ErpZwe4ZxUMBqSJVW9mmdQCHcAFaA5ikdjs394
 py9K1Q2FsJGZUahu9xVh63mTdUMgRqXMVKq3lMhSrAWH+D865e6IDoCA75KPh+IJz9rdoTMs08d
 WzPcHOPdyEst5VQG0ptGsU0h5ZCQ4OKtnK6txIlFT0OoqKdRpGqbhrnqMLDicLoJMLgOwB/uds2
 we2syXwbhJQWb2DGn8sDUCdxgQrNq0fvcuFAO/YMVs1p3RK9vSwdV10G9pVw4I8AobhjwLvPZI4
 i27t7nDO5s6LkFDtjSso49JBk5mUcY19qFNtzcvpSlEs93NBFW4g+3UqdCpw/mzBLh/OKv/KIjl
 8+rNCxNeLREpEBVdM=
X-Received: by 2002:a05:6000:4b14:b0:4a4:4229:c3a2 with SMTP id
 ffacd0b85a97d-4a44229c582mr2285628f8f.11.1794910963686; 
 Tue, 17 Nov 2026 02:22:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a3ad4ecb62sm3253742f8f.57.2026.11.17.02.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:22:43 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 10:22:42 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c
X-Gerrit-Change-Number: 2200
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2200?usp=email>
X-Gerrit-Commit: 09e8958ce54c0fdf410622342eac228f28733d62
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 10:22:42 +0000
In-Reply-To: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
References: <gerrit.1794840672000.I34dd7d46c9bc15e32f233741c525759715bb847c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODQwNjcyMDAwLkkzNGRkN2Q0NmM5YmMxNWUzMmYyMzM3NDFjNTI1NzU5NzE1YmI4NDdjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c37660046de8c0fd70ed53d95eab1d2207b65e9e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTGKw-000000001v9-1vfF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: manage: Switch all
 sleep methods to unsigned
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8677283809290756381=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8677283809290756381==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Xd7nzlZJ6ls="; charset=UTF-8

--Xd7nzlZJ6ls=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail )

Change=
 subject: manage: Switch all sleep methods to unsigned
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I34dd7d46c9bc15e32f=
233741c525759715bb847c
Gerrit-Change-Number: 2200
Gerrit-PatchSet: 2
Gerrit=
-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Commen=
t-Date: Tue, 17 Nov 2026 10:22:42 +0000
Gerrit-HasComments: No
Gerrit-Has-L=
abels: Yes

--Xd7nzlZJ6ls=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2200?usp=
=3Demail">change 2200</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2200?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I34dd7d46c9bc15e32f233741c525759715bb847c </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2200 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 17 Nov 2026 10:22:42 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Xd7nzlZJ6ls=--


--===============8677283809290756381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8677283809290756381==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8677283809290756381==--

