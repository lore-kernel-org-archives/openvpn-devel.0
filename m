Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2720AC61DC7
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 12:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B/D/uBvSGhXZMeKXnZCSzIGljF4AiZXxYklQfZ8WcAc=; b=Wuh+FqwOfnUe9naiiI2p6bdR3c
	LPe/PIWBUzxy98RkMlqFuyx4wovnsN6hvCFnSfhrfSDh1ns4pazPglGj/I4SB07NKqCpZzXoCLQeU
	snV9KKNaEu0Zlr24pLyxI/O/9j8b8IsFKOX/ACO3HB6UH1YqEhZKzcDS+kxYh4KFhnWA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzYxE-0003eA-LG;
	Thu, 27 Aug 2026 12:11:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzYxD-0003e4-95
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:11:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cu5bq4U5lkMs//Y/QNvFLQiu+YCqHXrRBB7xnwa87tU=; b=m1Kf5UHrrmR/Ut0V09pRi2lbkb
 Scc/NJ8Sizt73F8SSHBajxxkzSPSsu6ayZ2sG0nIZKg7s4FTLB4CLQnC5GqQiaPwvUk+xjvaTj4Uw
 M7/qnRQKIugAHCOfmz1mElt8QbtqLdXIKVx5SstxffMt0F9kI3G+25i6watehjW+2G5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cu5bq4U5lkMs//Y/QNvFLQiu+YCqHXrRBB7xnwa87tU=; b=C
 SuJYAMhUbxkRgdztN9mONq38nHN4fkotP+Mz3ADFYS2zqLf3TlZDjd9+nfpyPARjNKJmSV1HP1Efo
 Y3PaVo8Pp59JtFfYTghlsiOjbhfA4dmTNuat0xdYI5QNO1gXqytnXP//6LZgeYNaFNphLOcuRPxhi
 nnpn63bjKezFe9mQ=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzYxB-0002nS-Ru for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 12:11:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so20073015e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 27 Aug 2026 05:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787832687; x=1788437487; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cu5bq4U5lkMs//Y/QNvFLQiu+YCqHXrRBB7xnwa87tU=;
 b=UKYLQDdbF4T3syb9Dfi5wu6kzMS7P5WwFocUHKqRHHhVsxxVLXdYjwVGaEvXO4urWl
 mHqL5NEk0prBmppZz4EFAeVjPie9pvlmTtXEHg2UV3mIkamx48fFdX5B9aighSMRDViK
 LjWcZZ3qN/iwLHpggwHBBYr7Se5diWpTuGwS+S+hm79zLsfXb0DWJhKOiIjBZhshq6kT
 BVKei4dgohJKpZf0CMoJx+gBqv7Cm2OPYDQynxX7jhSZDxvG3gndT+/U0d7EPwqSMXgD
 pFvDre+Hu4AorUrmNqXHViZ049FaGb8OoO3bWU0XUb7UfDXi6dKIfCIx4Ytm/5O6NeQ/
 KdMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787832687; x=1788437487;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cu5bq4U5lkMs//Y/QNvFLQiu+YCqHXrRBB7xnwa87tU=;
 b=YJJAwalKaxt6cWYIv7W3M/kNIC3PhF/+YVOTSn2HqwZvrM6lDzvyiXUC9U8bPGXx4Z
 D2PbAiLZRAZCbHN7ZPbSli2zlx81gXUOwdKxSkVx6fbeMCmNb07DU9RN6efhsnNMVRic
 /APt8nx/3Cd2ErkRsobCmzpdTnfNmmCPC1lC9IFpgiZ4TfpaUTAzUTCDLczCe4mNaEFs
 D+2Y0Fh7RqriOaaQUc929W/BsY3AfwmJ/pOA+2t5Vac9zxFb8CfGACCix2nuJxAWw8iq
 pNbIrAzuMuPPFg6a6e7eQQ9AyjjVx9AHSzqIedwz22EzVDeciz5u9NbC8aPLCX+wEiB+
 4wHg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpWa1N7q4bx2AK5FjElP+VRlo6hhtbzIPJF3oXqFed0ga+tcq+8k8+rZOcHbjEEnoxv2G1TLfWlbI0sITQI@lists.sourceforge.net
X-Gm-Message-State: AFuF++kFZoFbOtroTgmHQLyCmRFaAVOt4iGIZdW8xD06cbUJkTkTvjHu
 yhDFGND1MSEhSbqqTsraIt3FnVxE5j+SZD1EDY/Duu1fdNu9qEMUNK8NCtV6TkgyvRUOv0Nut61
 IgK0z2h17LZrU+i7YLN3eAHEM12kLJM9kjv461QTYCsaTM7TvNDH/YdLCsnP53WsYqqHP
X-Gm-Gg: AR+sD100iB5hguRSyUoIl9ayI1azAb0W8F4IFH2/Q+FSkAQfjPVXtn47mZzN0fRAt1e
 iPUiF1l6+3DjsyCQSc+oHWZ9P4xP/o1nz1y4XAoRDLRpAEaDsN6qNgALs+vMkMqs6DgWRuirFZ6
 uckdVV+7N9WTYg0zKGEme3ErmHFH//1pO9jL5xK207jss7TsLfcoyzFsrGd8ozMwADkbn4sg1f0
 q27LI0isp+zCZzpaRdW7kzaFcwx5cGDYFQWUVS6Gg6vx1azDuVjbxO2hhvqRX8HVPqKVG88tHVY
 DiJ74tT06SR1tchJQlowwU7mnXaO7q1g0PLeP4y2iNfzw+qWXta1ZQpAhlB6wKRlsqk9EAeq62h
 JkQB2dgW76lEkbd/38+RXVHeEjo3JYg0SSS73S8a9ITsNmyqLbaxOGwFt2Cgfeix1gKNax8Gr41
 68z3fHmteS1Sa/ebzKQykAJS/hIGEQTgB6Jn9JnQlo/3ySY64SMfR0uq+dl84lrtGXFgJx6slul
 WEhtjgdMy9qRpoFZZexKnYDcHCVRWHcf3pQt+M9lFroRLbtfnwtJQtbQcs/WIU5CsF4dojwCttg
 JCTs5QVDRcoCHwbQqFGok56yVuITc63fT5A+Ey9Nxy0k9QQf3MbyjbVoNOfXlA==
X-Received: by 2002:a05:600c:468a:b0:499:726b:7375 with SMTP id
 5b1f17b1804b1-499dc8272b1mr149909765e9.14.1787832687153; 
 Thu, 27 Aug 2026 05:11:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4af00fd2sm44077725e9.12.2026.08.27.05.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 05:11:26 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 27 Aug 2026 12:11:25 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 7
X-Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
X-Gerrit-Change-Number: 1777
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1777?usp=email>
X-Gerrit-Commit: 05ca42a73ef9a7584ed10f2077783c4ee287ee37
X-Gerrit-Comment-Date: Thu, 27 Aug 2026 12:11:25 +0000
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTQ1Mzc3MDAwLkk0ZWJlYjhjMWYwZjk0MmRhOWIyZTI1ZjE4Zjg4NTY2ZjgzNzJmYWJmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <65ba22083ba706ace090d3225f8b31ff283e59cb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzYxB-0002nS-Ru
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_client.sh.in: Add
 ability to filter by test group
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7217389748482251931=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7217389748482251931==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MMUlAqVvsZI="; charset=UTF-8

--MMUlAqVvsZI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail )

Change subject: t_client=
=2Esh=2Ein: Add ability to filter by test group
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 7: Code-Review+2

(1 comment)=


File tests/t_client=2Erc-sample:

http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1777/comment/c0eb6d02_f8f57116?usp=3Demail :
PS7, Line 39: # The indivdi=
ual tests should then be indexed by using
Typo: "individual"=2E



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I4ebeb8c1f0f942da9b2e25f18f88=
566f8372fabf
Gerrit-Change-Number: 1777
Gerrit-PatchSet: 7
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=
=2Emuc=2Ede>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvp=
n-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-A=
ttention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, =
27 Aug 2026 12:11:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--MMUlAqVvsZI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos=2E </p>
<p>Patch set 7=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">View Change=
</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0;"><p>File tests/t_client=2Erc-sample:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1777/comment/c0eb6d02_f8f57116?usp=3Demail">Patch Set =
#7, Line 39:</a> <code style=3D"font-family:monospace,monospace"># The indi=
vdiual tests should then be indexed by using</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Typo: &quot;individ=
ual&quot;=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail">change 1777</a>=2E To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1777?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebeb8c1f0f942da9=
b2e25f18f88566f8372fabf </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1777 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<=
div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Th=
u, 27 Aug 2026 12:11:25 +0000 </div>
<div style=3D"display:none"> Gerrit-Ha=
sComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes <=
/div>

</body></html>
--MMUlAqVvsZI=--


--===============7217389748482251931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7217389748482251931==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7217389748482251931==--

