Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C0606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hvtlqoz8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YxOfWPW7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=AoT57S6g;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D3IbBbF+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=JZCSU5vT1JvmCTEVR9b7xqQHRuvCpkZubs/PX7AX7jk=; b=hvtlqoz8T3BlDOXur7Yojf0KIl
	MSKdbjHT+lcxiUHkiYQkh/FR0jVItLfmYpVHPxuABzV0seL7ivA/YKRjGwQMr/RIdkVukJFrZvrHA
	mw/g6a21GCb2j0Y1eytT/hssKiRQm8h9gGoSQuaLaE6ggr0/h6ktLpwGDx9Ue+GrZk+o=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLeKI-000000005tG-3VfY;
	Tue, 27 Oct 2026 10:22:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLeK6-000000005t3-2XSx
 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:22:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J24Pu6IPOW12cRHNAV7LJwnatnAI0vORdA3b5bOf4Vw=; b=YxOfWPW7cAUWD7drq4QSGq7TAY
 +Jo/+jLaNCQTFC+l4X2lZk2pvEqyXVapItkUJMk7jialyiykk+5jXxa6WqpEccY6Knp/uDG1Ef4/O
 VPjg8PK2pp6UBxp8Ke1ZBYrMCjSGfRa0Wh4e5OBwJ3RYDmwC2NHHcomAIPgnjMlwcVfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J24Pu6IPOW12cRHNAV7LJwnatnAI0vORdA3b5bOf4Vw=; b=AoT57S6g1MclNn5bX40YOBcbOs
 fEjvSjgKUkhPHvyrk916mPKHQoVetDl8g5Jafgapt2a4be1divyp4Hg8BU5xY9i5+uvTgbTjgTuTG
 K8HkzyMrMyHozmPPtSpquhb5SiW/BRvNgM/6JjPMUbbPz9qcsmBuS/FgMx3nqV66GItY=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLeK4-000000002t8-1GH4 for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 10:22:30 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e00eee27dso2507389f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 27 Oct 2026 03:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793096542; x=1793701342; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=J24Pu6IPOW12cRHNAV7LJwnatnAI0vORdA3b5bOf4Vw=;
 b=D3IbBbF+9V2Rd9xfEF3vWEgvYwhOiYq162w4OR7RMOQ2U9ooYemfaqON5yExiG+gUl
 ttNzfxc/dKw6+W26q9kfhwQdUpWBSWp4QfWOui4I60DegU4Rw7MlFU2HISLzHW5xZW/s
 fLRrHz8QMgsQ/tfkIdJj+ArxMpTlo3qirGtlnjDZGwG62t/DZ9U1d7cdPPxEBZZgpJvC
 /G4g/T+WFGrfRfq9n4+Ok+KM9dVKDfVQGB1+QjKe0t+NM2K39t466qbXAy08mQJeSoZt
 vtJ5nVXbxO8/OpyJNGbbyL9pX3puxstDV/A9kmJqgqY4u3U9Fz0bkaG+fDqOC1tvr3rg
 yUxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793096542; x=1793701342;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=J24Pu6IPOW12cRHNAV7LJwnatnAI0vORdA3b5bOf4Vw=;
 b=ZRfB/t2LvIc5ylJv7rW/4AWk7x6YblikBjX1FxpgIQJzmWxDMsLdoVhbtn0LcRXC30
 QedEatc9C/wdByNMpMRjDwtZZuHuE3RBuEkeBryJkMQbg3LQFYsnaBfNANjTwGQX9+7C
 SM/vxActLynDU2S4yaXZqeaes9fsce7fGP42LHyZJ/ukEAz4froNblYDCiyZP4HiK7bH
 2MHhTFS2AX9UtS8YuTNK2sak0VS2dELJHp3UgGGinCpX+fBdWHCTw5y4W8FKdln0pZkY
 n6T8dQDZiwyy0hZoilZW2cfEvG0yoHRFoLROenEIAs416E8dVZ2e4fdIz2QBfzKtbc4Z
 aPow==
X-Forwarded-Encrypted: i=1;
 AKwUvBxU2+7EsmStB1e4E6jcp/5Dgthff6REGCFLX4D6S1ITiCVXA41Sf28R/J4q4Iev4QMfMTFEpmdGqXteByEo@lists.sourceforge.net
X-Gm-Message-State: AFq9FYK6n67cHPRNAxyIhgua2KQnuWJK+RnMLeaXnrmqxW22dRXZ5YkR
 m3CYDaEkpqk5K6LDVUO5hshfu+euxu5kWorxke6kLM6yWEEp59zsvbihe5ytcqa3SlfqgGcQr4b
 ZdHSSNGmDxOXzziGg9mr9viESKC1nGOiOCg201Ux64iOg66sOjyB3WL3x5FwPBCfCgKhu
X-Gm-Gg: AYBFou1fTOIDxcuws0keWq4gBi6gJiZ+6r6TeSkGsfQ4mpKF6iH0Y3EEuzY9vo1thVG
 pGsfD49xopfU2CxcZ5+fJNv8HS3UklL+MffDmvxmbYCEb/O1oMoVrSaSyxUkcdhFKwBZZeoRtwY
 S3f7goTzHKiyPu1Ryq9HJ/J8Hg7Z7Ruhn7RvNX8hxDEKSlDpqkwlXSZwGrOl9KVdCF4IE6UthSQ
 dxPvEHy5kpNKxLaHdZBqc2qGQmVzdV0iUqhDqcxNENJwxDu1gTqCKR3zKYg8JlyAQjK2E0Kj87E
 tALoIkO3Arbc7JFco9Mt928KgcX/QsPoWMUqoyE7Z4YDy11GqD6XpLuea0nEixBcTax/lvA1nea
 AhhHkyQczcGXnCRH9DnGyY44uGS67phhFW9MfkFVsndnbw5Iu6LmX9gNil2VU07pT5c4anBo7VS
 g1Mi5iT6tY3HlmI5JFhQwp9C0lR9nKi/qRIlRTeNmoIcIvdbeoQuwr7ptdsUK1ZCJ0H+M5hNHpE
 mF8P2HvM6BCqv4/RiOP/m9+zV6ZyAZBCm5JbmXKrozFRzAICV1OptR8xu9icQtVq02QHSX7Pr21
 MVh7XjTmHIdCxqqPtQO6CIeRlddV7XylC2rf8QdXzP458vjJSzcTV8xuxwFI27g78T2D5aETta/
 4tfig59RHGzS0gL2vuZ+ZuwYM12YH+TnEvw2NcUV5XQ==
X-Received: by 2002:a05:6000:25ee:b0:48e:5444:a1d3 with SMTP id
 ffacd0b85a97d-48e5444a203mr7330282f8f.11.1793096541504; 
 Tue, 27 Oct 2026 03:22:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3a1csm22201797f8f.16.2026.10.27.03.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 03:22:21 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 27 Oct 2026 10:22:17 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437
X-Gerrit-Change-Number: 2042
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2042?usp=email>
X-Gerrit-Commit: 4d2c93730319150472232bc261bff896f4e3b340
X-Gerrit-Comment-Date: Tue, 27 Oct 2026 10:22:17 +0000
In-Reply-To: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
References: <gerrit.1793094393000.I89303975dd559d7cc06484a99f15c7062d3a3437@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkk4OTMwMzk3NWRkNTU5ZDdjYzA2NDg0YTk5ZjE1YzcwNjJkM2EzNDM3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <afce9eb75e3c1e784757cb9f5c4f40fbd549e59d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLeK4-000000002t8-1GH4
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multi_io: move the
 tun write functions to multi_io.c
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
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6226240037015861160=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6226240037015861160==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="szC5nop1hhk="; charset=UTF-8

--szC5nop1hhk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori=2E=


R=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De G=
regori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042?usp=3Demail )

=
Change subject: multi_io: move the tun write functions to multi_io=2Ec
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2042?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89303=
975dd559d7cc06484a99f15c7062d3a3437
Gerrit-Change-Number: 2042
Gerrit-Patch=
Set: 1
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerri=
t-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Gianmarco De Gregori <gianmarco@mandelb=
it=2Ecom>
Gerrit-Comment-Date: Tue, 27 Oct 2026 10:22:17 +0000
Gerrit-HasCo=
mments: No
Gerrit-Has-Labels: Yes

--szC5nop1hhk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori=2E </p>
<p>R=C4=83=
zvan Cojocaru has posted comments on this change by Gianmarco De Gregori=2E=
</p><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block=
; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</s=
pan></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2042?usp=
=3Demail">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></=
ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2042?usp=3Demail">change 2042</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2042?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comm=
ent </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div=
 style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display=
:none"> Gerrit-Change-Id: I89303975dd559d7cc06484a99f15c7062d3a3437 </div>
=
<div style=3D"display:none"> Gerrit-Change-Number: 2042 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 27 Oct 2026 10:2=
2:17 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div=
>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html=
>
--szC5nop1hhk=--


--===============6226240037015861160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6226240037015861160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6226240037015861160==--

