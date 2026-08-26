Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96F2C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aK+4P++fFO0cvXl6xhLQaIUK3gn5uL1f8Px7Lv7W+Ic=; b=cVvzCkwNsC6BLZLrLpYM32Qupc
	4FvmSsJspOTgQ2WWjIYz3kU62WyRh6P2AvuDhb28oGH4c+JIIIWd45xoDAcBb08WHsH2FDs882THl
	1b2pjNqrsUw2it9Wjvj4flna0Yb0FnKitjebpsSx85LWdUaTqA3mAoARP/IhW3uoq0w8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzFcP-0001TZ-Aj;
	Wed, 26 Aug 2026 15:32:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzFcJ-0001SC-NT
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:32:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=U4++BIvA74NaZP/gUs2zGmQJLscgcd5XW08/slnwILs=; b=Y7SW86b48VQ2WlgrDQos944AVw
 +WHu/M14lrEhzm2QSvfPSli+ln6TguI78yfHx5bW60yZjnCeVPYFPMJ6c8xmtwMR99h4PaVKQy+V8
 j94IsR9r7eRRCJGutp+cUCaRe2zk1/3IEEmp3bv03FTU1wRvdNhRLn4dGVnTxETNLUpo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=U4++BIvA74NaZP/gUs2zGmQJLscgcd5XW08/slnwILs=; b=b
 lD7+bHDO72/dvHSVvJ5KyDCOfx0dqksa6h7BYTUYu9k44bLCWfQ35IT1DZottZoUdUsi/t0rUY6OI
 69jSEpfoDqRGRcTETuaeM3r884V+tt5pfsm/98Ha5NcUF6hxOUeEFveLMcuV3YgD227aHE3DgZz51
 GpEO+DT129XiEQt0=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFc5-0008Fr-HK for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:32:32 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a18840e2abso1788329a12.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787758343; x=1788363143; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=U4++BIvA74NaZP/gUs2zGmQJLscgcd5XW08/slnwILs=;
 b=TtKfnTpGb4NaMUPoIWOP6NRr2a6GikurOiPLWM5MfHGq4c8RhgHebYnnfJd+Tr0c9T
 OoZCruSlEf/6Un1icZz8oDEebYBMhwaUM4CXs/weM5Y4iKxQdBcxdB7LPLGtUyLLtX3N
 g1+mocFAuxb4H9nNlNfswdVvt8B5C4qTgRv5cka74A8bAtZPsY6ti2EK7+pcX2F7qKjj
 89yMWLdLXi2UAh1gn/JEfH6QhJmN/4Nl7FibAqVOeklq5qCECQAmo9hArTiFHyp5croy
 L6j4oEz0kWWb5cr3A695Sd0CTHHF0AUB6uPkl7PIQMFuDeJa+L/0QZAc+R4ELz0AOL5+
 vwlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787758343; x=1788363143;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=U4++BIvA74NaZP/gUs2zGmQJLscgcd5XW08/slnwILs=;
 b=Mqr0RpZ0jspPxCR7dfE5Fr5m+lIflUrP8iJ2Anb2M6405ebL88JwzcO8FmLQEE1E6K
 LG1qbE3b1XtHwvnEz95BlPUcIUCHBQ2r/RX6zeK1mftq6gB+hbZgX9Kc7dS3DU7rCaLP
 VACHAdD7mkLr4Wpora3WgChooGHosJGWGZWxA/h0aUoeLVTl2aVRxFnPN/m8nU/RPswU
 OBIaMLF6fwZbZ0m2WWszI63zrkzAwNiiW3QWzHqY8fOXkur0MxauV8PfeYEEEhGjb8Yw
 uhUumzow6fJrI3PJPOgjW3d+NVDKg6GfDfGvyoTRdlQ9yt38AbNBke2AsN6RDmLBQAdM
 XafQ==
X-Gm-Message-State: AFuF++ndd+emua/wTrFy5mDeQI70XRJY2rRZ0Oe3lXfoIvEUyOuR269F
 clUmmlwk52Yayksy0G1ENU4bWj9F9RA7hLWV9VuT3VH6c6jhTJFLgVNrE2Mx/OPHGxHkzS7LMsm
 4YP6A5L9Eyl/YHIAwrT11x5Dd0xnoHXmYQONDKNisOKGexxl6Agmy8NC6k3rE/l7VHGJ6lIn4LV
 +rTRNhFw==
X-Gm-Gg: AR+sD11h9SlXLvt+odU6izLLsyNiYQ6ndcZHV74/LCOkd05ehXyLgd3epsxQ8eRsOly
 pdbDiBXe5YDFgVFfpMCk61krDCr59O6S4Ao2sjxeXwiJi2dUIuGkSAzKJgFSYYzgk0l42j7wRJt
 H8MEqgrwcexEi9wHhM+yA9iN7tgAbCrbFa14ltzT1/gRtfHs+uvJlUw70u4ro/cEFr2TyeHgnR7
 oYBWfDiBoBY6dR5kckBuubcn3QRCIA+qiZuJmDjNzLFq/py48E9bsz/zFN8VLTqBGc1tVnJ+FmD
 U3DcvFOs4t66ekYbSn1djyn2FTkXpRnKaPNjotJnl4w2MxXT4Wmaweak7nbRabonsLQyiJW25CV
 TM0FKxykGa+bmyQwVLIOHIaXp2xKn2CUFpkMTL2aAiLoElhiROQ3uvBIr6CW0cyOfDeQXRqsZPx
 iGrJHS57vPrt+SXL1Wo2ZRuj1Q0S7fHrB0Rz+rRzrHzXFEuoKmEZxNsD8iyWFqlfRkUGp8ck3Ns
 fnsIqyLf/wlQlVfZ+3rTgbicIFga9D3h1yIVUyomzRU8cNKESUNs6nm5eIH8PJQKkehC42el162
 UrTXoF1uQdIAgn0D2wW0tyhM6Ewawlj6oMQ2kjQIg6I9fR22Z44=
X-Received: by 2002:a17:907:1c86:b0:c20:edda:ef5b with SMTP id
 a640c23a62f3a-c250c595d62mr731377466b.14.1787749147120; 
 Wed, 26 Aug 2026 05:59:07 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fd676sm503217266b.17.2026.08.26.05.59.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 05:59:06 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 12:59:03 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I432df6c69249b49e9b9a3a904803904d134387a0
X-Gerrit-Change-Number: 1857
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1857?usp=email>
X-Gerrit-Commit: 59b7e039262dbbe749fca205b98077c153829284
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 12:59:03 +0000
In-Reply-To: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
References: <gerrit.1787327336000.I432df6c69249b49e9b9a3a904803904d134387a0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MzJkZjZjNjkyNDliNDllOWI5YTNhOTA0ODAzOTA0ZDEzNDM4N2EwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <aba87993c1147f0463e9688326663f7155121746-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzFc5-0008Fr-HK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add mock support for
 management messages
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
Content-Type: multipart/mixed; boundary="===============5605419307812848140=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5605419307812848140==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eq2uUqeRPX4="; charset=UTF-8

--eq2uUqeRPX4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1857?usp=3Demail )

Change subject: Add mock support for manageme=
nt messages
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 6: Code-Review+2


-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1857?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I432df6c69249b49e9b9a3a904803904d134387a0
Gerrit-Change-Number: 1857=

Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-de=
vel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 26 Aug 2026 12:59:03 =
+0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--eq2uUqeRPX4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 6:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1857?usp=3Demail">View Change</a></p><ul style=3D"=
list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=3Demail">change 1857</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1857?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I432df6c69249b49e9=
b9a3a904803904d134387a0 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1857 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<=
div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Wed, 26 Aug 2026 12:59:03 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>

</body></html>
--eq2uUqeRPX4=--


--===============5605419307812848140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5605419307812848140==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5605419307812848140==--

