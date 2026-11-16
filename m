Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2D1606A889
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZqAsFYq0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=leD2fCeM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FE7GTTz6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dLUaQVjK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/A1K3JED9WRN1b7bvb+uFhaGcjXeb1/n2O5FJmev7Zo=; b=ZqAsFYq0V3k/2ciF8d0z9BYoCP
	pgWzMRk5NlQDf5ZCmqQVj/r5DBf2XMLmCDqklgHt2NoOiV+5BMgIdWZJKd4iIYzlMnU3PDJNC9UA8
	xdYx2dx6SKez0CguTqNrHSRb7rq44hdH6KYHgxNQP1JqmJ+fpfF6JHpQ/kv1aE2CnlO8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSyGA-000000005lk-0Rlq;
	Mon, 16 Nov 2026 15:04:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSyFb-000000005lI-2HJk
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:04:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SGS2eplW8Vk1VSf8+TRhcgJV4rTTKsIVc+NixyIhWeU=; b=leD2fCeM9iIgFxcf+WK9myMZDs
 3Ldqs1ngmK8BIIf2BR0u2AdRwQeOf295OtF6Z0NqRxbOOZWtp35VcPb8esry7zSnBFwFWAdn4f30i
 TIP9jPljFuHLj10Xadu6ZjR/D07D/X+Lo22S0sBkX0RO1oq2ieh2/EsRG4coPSLPFqFM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SGS2eplW8Vk1VSf8+TRhcgJV4rTTKsIVc+NixyIhWeU=; b=FE7GTTz6xTdVl+6lb5pDP49+na
 CKgkHSgQ37AMZ1I+jB8JJYji4K+11vka9Fke7jF/xUWcM5KU5/fOFmBvMY0p+Hx865Fi8LKDheXJI
 BiPVOcXwDtaOc8GgQEX8xHNexNL9nMu+ZkNxeCTqaPjZVxU0/wALlcG/S2Lj1/AerLH8=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSyFY-000000001HR-1iTe for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 15:04:07 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-490c3ae81d3so1946401f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 07:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794841438; x=1795446238; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SGS2eplW8Vk1VSf8+TRhcgJV4rTTKsIVc+NixyIhWeU=;
 b=dLUaQVjKjDZuAY46247LwfqZWU8W/6JMHwZzVpVKZuPIxmX45leWaGvSLsmG6Vf76f
 7VcYHU5R+bHQ55Pz6IfXtyHin9/FznQfNh4EP1Bvr9bJ33jvmtk2GLorTJFkUcpjgbN6
 dL00uUVdLsD8TNDRIzAUDydmFQfHIpHruANtNOG/MPUK2q2Z70bULfD060jhBz34Ehxt
 TDSFphhh3Qd+K+RrHeg+oe6Fi4YYFi+f8kXOPrHCkxq6jB18kJuB4kgQBxqnz0BTQ8i7
 cCnXa8/HQhvHhsPHuctEwU5mDakG+8KV+n9guQ1Zi20LvfWgpV1njV2VTnS1FgRv+4JM
 SYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841438; x=1795446238;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SGS2eplW8Vk1VSf8+TRhcgJV4rTTKsIVc+NixyIhWeU=;
 b=zLMeVM2LZMvq3Vb2M+IR+LKQT9c1LxuTbAiLHYCFxoxfXzs2Xp8dAMBJ8L3+i5WVqA
 Lk1/JwMi/S384hKG63CPbBI4QjXH5Tl6xPH0ZoTFjp4oo9oZEXLttLxe9VxD7/mXu3TP
 kTnz6ZFZRA+W3JBKkLPhZA0k4Ry2oz3UO3zXyy8LMsg0B7wq+AKAvyx1ZPjxBxLWI2Xx
 WewqePJxJ/z3cNUuAyB7jTQ+m6I004ROcnSXvdgALYPBGN+YHOmTyW5WyySD634urxRS
 /RXsJXZEVV6CKgv/IYFGSml7gIDE0On1GuYyqp3pBaHxSDYoW93liTNt/5s5R2oyNCL9
 +lTg==
X-Forwarded-Encrypted: i=1;
 AL+hErHX6AMY50YZkxXxiPZZaQHr/ZHfHOq0c/k3ecrUG/c8pp27AxcAHCjpMzi7ae4D3vci7KD/xtKNNfu8R0Wo@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+5Rpkv2RaT3TeFMo9VgJ0eL6rzql2Zz6urlz4WME9JKu8UCpq5
 PUjM+BB6IqGlewrwYxB2v2M9Tn/AXliWcliUPC98e2NoltMdHw4ujBbw0/+7QqqGeJdlm/fQUAJ
 ZPjFbH0Blv+btuOt7A3W/hfymOKOlFtYjGy8/U0CRFb/I5gu0tsalLJQT+Ea3A9xK0YhiSuKzHf
 1sVZxvhQ==
X-Gm-Gg: AYBFou0vemCo+O2w5dds68PBCAcvMh8/WzQ3ClbqBv3qYB+Z8TaRQ9XOJe9n7nLgQtX
 o3dhfHYGUZIyJLuYKCuj3Y54jYP3LCrq6o9sFnBXIitUOPoUDntcqTSUoSttD5O+X3LUdTSiFdx
 3sRcaGZeYx3ZVYwQDWECyLUosnKycRDGnClUvRw6TeVmdwM+/KEXQvU3UdNAuWJisiwmmF6HXGl
 a4cytbPmHmAs/cHcN+cQw4M9Amnemk4LUc2W3msGmB/WVCXBnjtVFslBJy8wL/VfVLzi8bJpSGW
 S1bkkVWDObbgV9menhwF1hSmgA/kPUySLqX3yI1Jmns+tNnIzFXSK0fkht+ke6zuJpEFu5yU9Ay
 iD+f/ecpiciZ7Od6Px1mQ9xlvghIlmRsreZPzl3BxhP4nXEt0lPZyF0m8gHXKjuQjP+cQ92mphA
 QD5p4D2Y/0pHxPmNBmy81FPBzEO/Be+TNYNaXH3TExs71d2qveFsx4WeV6cEPjfmv0DnGOVB71T
 /u7frsIeklSx5CsEijuRYwVVqr6dmdcj9mX7MLaJdQCI++RU8DrImbN2u6JSqiLaZbFPxuEiqWa
 xwRb0yTE8Ke/eBxt4PyRDqxUvpmLEfdoHk9rh4xnlYOpqOd746KGykDQ/zldeHueh+oN5RSvDJe
 FbYQO/G7qx4xXy8pfycAYQfXAcR8eVi+kaOgT0NnZBFf2kG2IfFz0h++VmCmd2QmCFkZjULzL+I
 tD92i10g/SEZcRm70=
X-Received: by 2002:a05:600c:6091:b0:4bb:6a2d:b426 with SMTP id
 5b1f17b1804b1-4bb6a2db60amr106039655e9.1.1794841437646; 
 Mon, 16 Nov 2026 07:03:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb679b7e1asm294084915e9.6.2026.11.16.07.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:03:57 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 15:03:55 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 9c8fabfb154d8e55b56aef80ed34175a48cf2504
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 15:03:55 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <190d1258dbeff3328cb719c3e04b7ab613ff8d33-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSyFY-000000001HR-1iTe
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me,
 lstipakov@gmail.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5011823411363818074=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5011823411363818074==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KdDU9v5Qmp4="; charset=UTF-8

--KdDU9v5Qmp4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov, Stef=
fan Karger=2E

Arne Schwabe has posted comments on this change by Lev Stipa=
kov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail )

Cha=
nge subject: control_msg: Add a shared TLV codec and use it for early negot=
iation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 8: -Code-Review


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number: 1965
G=
errit-PatchSet: 8
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@karger=
=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Ste=
ffan Karger <steffan@karger=2Eme>
Gerrit-Attention: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 16 Nov 2026 15:03:55 +0000
G=
errit-HasComments: No
Gerrit-Has-Labels: Yes

--KdDU9v5Qmp4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov, Steffan Karger=2E </=
p>
<p>Arne Schwabe has posted comments on this change by Lev Stipakov=2E</p=
><p>Patch set 8:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ddd;">-Code-Review</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=
=3Demail">change 1965</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;f=
rank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvp=
n-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: Steffan Karger &lt;steffan@karger=2E=
me&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Mon, 16 Nov 2026 15:03:55 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--KdDU9v5Qmp4=--


--===============5011823411363818074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5011823411363818074==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5011823411363818074==--

