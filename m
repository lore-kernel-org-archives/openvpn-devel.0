Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C42606A325
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HcOAteR6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MQckNx6Y;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KqX7fSMh;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=NcZBl/cT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=XB5anm1cVYh9UuPR4Zd4/FRgoeCuUp3AoOKl2nVNwyM=; b=HcOAteR6gJEGATpnDKR4xev4WT
	U59NNBSjGFDYDjvaklVT0YBKucjJ+F8LKyq4m9NgZVxVX5Me++8DOqXXQtoKAJU+A0086jXckG47K
	/UZatJ0TiQY7tw25jvCah1ZiglxBEJPUsvOgqbCiDE7m2qtvW3bjQ/ZDqoGPJPKaQBMw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUJB2-000000005JL-2lh1;
	Fri, 20 Nov 2026 07:36:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUJB1-000000005JB-0vhl
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:36:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5y5v0GkBiXdkNRriZLd60TFp7dCwHlTp53A3uBP3Sj4=; b=MQckNx6YfO9bMX0x1210ZP6Q/H
 /4MVbNd5btmUjYW6GNt9uwYvbEUknuNi6DzjPUaLpQcjBsi+4SEq0xiKAdodUDZox12sMlNN0qq67
 Qnddk+rIKk0u9//BHL6/rGXLOevDraXvEwtazLGSB/HnvlkVRAkuCBsV06CCzMMepIQ4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5y5v0GkBiXdkNRriZLd60TFp7dCwHlTp53A3uBP3Sj4=; b=KqX7fSMhs/AGHThM8abK7yuC7E
 W5Q6yjze9E4Z8LHLy+QTyrkQgei7DGp3XnOKcI8eaR/ezMU7T+WrlhtZMtS4BNzXVsx36Q9l4JOR3
 bRm0R2sVwl1M6RardSfn4OZbKqYC5ULzgc1NvjE+Vmk2Zdpvpm1K7chMnPja30RbX5OA=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUJAz-000000005XJ-2TmT for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 07:36:55 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so256972f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 23:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795160207; x=1795765007; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5y5v0GkBiXdkNRriZLd60TFp7dCwHlTp53A3uBP3Sj4=;
 b=NcZBl/cTqs1IkeKJAb+Kh2B6NLSv5dK8eS1p8cSi/OkVeEo7YJY8TFhMp+DzGGOpnY
 PIZ/88c+eVtpybj+a5QIY2U1on0DX9hFFlHzELtqchPhIu5RunXqe8PtTScgVhzqmCKX
 CBxnhIb9WxUUfBJMi0+equ1DLZ8SvkNr4XswY8fqkxiIL7MizOivVc4kwOaprQViUQ64
 BlSJd2VGYevolkeKkZoyFDmc/sj7xckbL6jOJnH9G41HGzrgz7CxkzurlQEulZbBLdzo
 nGl11vydRw3WkSsuOxQACb+uMrxBZKxQtfBgFasamQu8ffYZSHHbZEuTvlfsX/N5mGV+
 9N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160207; x=1795765007;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5y5v0GkBiXdkNRriZLd60TFp7dCwHlTp53A3uBP3Sj4=;
 b=EF6RH2RcNH6zCAdlN16VmLtJk1JRcOFcs2H44/0Mnwa9VEnGexHuy4GWGv2/l3WjEz
 7Wm5Xx0rU0qe/4MJV2s12TWE9qMUYUw/N2aLPtcJzyBff58Du5ig0eImv2lth3V2UJHd
 2+9Rtyi5g1x05hlyeMMms9bdMJz0ivm9ciU8fobepZvGrnutw8WPPMV+CnkBAgtYeu3p
 evbwbPmVfbT32PjlDre3IIDF5f7ddMzIo0UQQzioPmfF4O2/GVjUt4OZqbGpQtZl1mkH
 W+9t9gY/yE9VOgB8c1Lcm6ipbeveuHJH1/gZEyVx5X0D7Yd0XH/gtR3fSOtEx7jEQqq+
 6I9w==
X-Forwarded-Encrypted: i=1;
 AL+hErH/sQ+oMuFWa7sAD6vsopPOOlVEC1xwaTREIeH34WrAv4PcnRm2fu63Le01DU7OenqFHOKoKycSBuBjB//W@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/qzlJ4MELZeNmhx2Qw8WV+GIOX+hBx4UXYR/s7b7WBxl6YShoA
 yECyYGlADkBx5VRYL5+eDOD3lDAc8hD1RS/W08q6mBU/KqmpHQZBXMTDswqktvca5QJcUxsjItm
 Y9M6yRVZsvQX4odAkQL0gEbMFL3kyFP1SNZhthgoLUcfmilML8cRlkfMOg8s+bJamAPeW
X-Gm-Gg: AYBFou0A+PF9pPkAbmf9NPbEYaE2gPPMx13cKExQ15opItOZ25E+8on9j/gFwGiadLW
 2+e8FBNxDK2YVs0PLyYWOuqt58Mgq9MvFGZsyEH/vMG2inVqL8ApNs++ajNmKoR3FlU05KC6dZl
 g8QYc9ytDic7OkeGQgxIPAENOcwJH0SrbCBXFQ9TxTjJpBp3OmsyBGlv1rJRrw/bLK4WSUqSGpb
 QuuenhtoFCvov8vjIjBR4ZUmbyhJ5tGPlu4Ycna6EOYBNrSIsdcBmmM0DAeF6BbSJOF2T+nZq59
 MJVRaSWw2d77t74w/Y3t06SugQ6xWmUHzrhTDsFbJd7BwTMovBHRhF9UJnoiToPbnEuyamPcJHN
 mL+BQuvtKT893/7kWQ+Q0xkLRCSYe4eZ4kndNoN8Yy4qlFFvG2n9s32zrhgJokFXF6xpSNRcin2
 /e0RwIKKuDUgDpraiNpE2Gzn10B8tmfrytSEei2ZRLQWaNmjG4y0LeqeujtAfH9pikxo1TaeTaT
 OSWOKlzNjiJSdiWuRF9FWSNafB8SiRpaslY2/jtxxOlSC7IYFc2X2RVN+E0HxSHQAFwARIBGnnE
 6jFDQI3LFPCAg49pJ4wyElyxMhJtEgXwrRZaBb1k3G84RBhFrEWMshr5269AGs/hvoEfTxGkEEk
 +79EHA+n1btJ6MYnVCVwGGX19n2zFev3JSNVE3OaVJpht4hMQsjFc/QsBYWs2Cg5cbrCXML5/fQ
 HJU/0l9/HieoxIjwI=
X-Received: by 2002:a05:600c:4f16:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4bb8882a66emr49443885e9.32.1795160206865; 
 Thu, 19 Nov 2026 23:36:46 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm54344405e9.10.2026.11.19.23.36.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:36:46 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 07:36:45 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
X-Gerrit-Change-Number: 2224
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2224?usp=email>
X-Gerrit-Commit: a6fa3565e5d5aab43dd9e074e57fafd25ac96d70
X-Gerrit-Comment-Date: Fri, 20 Nov 2026 07:36:45 +0000
In-Reply-To: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTU2MzAxMDAwLkljYmZjNmI2NGJlZWE1ZTcwZjMyNDQ5YzVhNjNhMDhhZDg2MjU5N2I5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72f3343082cce63328f871ab76cc37c6b465fb37-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUJAz-000000005XJ-2TmT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking: use -1
 for "no route table"
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2812897234829812860=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2812897234829812860==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yMLGPxVxqFQ="; charset=UTF-8

--yMLGPxVxqFQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail )

Change=
 subject: networking: use -1 for "no route table"
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a6=
3a08ad862597b9
Gerrit-Change-Number: 2224
Gerrit-PatchSet: 2
Gerrit-Owner: =
R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2E=
muc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri,=
 20 Nov 2026 07:36:45 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--yMLGPxVxqFQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 2:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=
=3Demail">change 2224</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2224?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2224 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Fri, 20 Nov 2026 07:36:45 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--yMLGPxVxqFQ=--


--===============2812897234829812860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2812897234829812860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2812897234829812860==--

