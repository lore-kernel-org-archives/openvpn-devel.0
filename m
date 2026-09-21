Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB1DC982ED
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pCM8GtIDTa+kkl1QrWx3ARRWRB46Tbu+FYRGD2gQbAI=; b=a56GzZ8GulGox0vjjEf7DHXPWq
	YBJZrDw00iVh3lXNWgyHdYkP8NJA7pwo9Fk8mLjfso62oclL9QMZ6UoNyQjUMcmryBxj7o+zGjg6M
	EbzUs1TKIlA1Phg1jylIETiNCFgCeJOe/FIHgFKBvY80Z4LV7oKQbZ1oZFGv1gqBQnko=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8hE0-00020N-Ji;
	Mon, 21 Sep 2026 16:50:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x8hDz-00020F-HY
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 16:50:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=9SFC8or9oMirg6SeV2zFNc9v6FRvgGKbFCU8TfsUgac=; b=QbOBpfeqYB7c7AFBq06c2wABnm
 GUMv6D+7S2c06+NPbAabs/gPr3YE+zcGFb8cklNR4UnZ1HvpP+56TsE6+D143oF5FoZjY/gnGfecS
 0s0CMXIvHNaFRhEfbFPv/EFuFj7ORpnDQ3sB8ADVqwRYrVGqPOGhoYNkpw3DSsqgmDfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9SFC8or9oMirg6SeV2zFNc9v6FRvgGKbFCU8TfsUgac=; b=P
 a9k/68z1qzf3hdMm9dL7BVumkrOsTAQCj5KzsKpQM+KxEkmh+XKjhRNhn2+7cJnSmLXoHtsw6DynV
 5NOtXtJjd9ac/ZP+zKlvR74Rrl3WpNSFkTiUj498s7ncSGJC3rgk/ZGYOMfb2PPxnT1S16KBn4kYo
 NeHriRU1xejArWSE=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x8hDy-0003lw-Id for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 16:50:39 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so44709535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 21 Sep 2026 09:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790009432; x=1790614232; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9SFC8or9oMirg6SeV2zFNc9v6FRvgGKbFCU8TfsUgac=;
 b=dej0Ahfl6FFnZAfupZaqrvj+hyBuiQv+RS8Jd9ppQdXrokgxDyG0y+IrvWRPOTfs3g
 /6i3ZFNx8PJaQOHzSjtWAPGF2+yIegjmA1TVouanE680qZpfUPU5e3e/gktyk2KzvbeT
 NtH+coOBCL6PWGK5h5P06y41PmQ+nGRzyO3oyMjTRHbSBr9N3vD6sshgniBi1ucXsBES
 KevYmhRoJyDxYPbV0GKDxQH4Eq2mpotuud1pUv/FNSXwbybmjv1PUuJPKe5Jw3sz55zq
 sXaU4rzLpjWFsRNkXTa21eHK8yRhVTN2Zy5MZt+Ya3auiDl/OfkpemHDrCHmS84AdEnh
 0bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790009432; x=1790614232;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=9SFC8or9oMirg6SeV2zFNc9v6FRvgGKbFCU8TfsUgac=;
 b=xE11HxS+RNVUd2dAldF0m209Sh+vnNeS82OxYonJdHzClwIg6qaTmH1kxhegCHdyOb
 g9r4DKNFiAqHM/z8HvBSrN/02a5I9Oc3ZTg7ELw8EJZaRr6TFuvF7G7sh5SMhhEKXtew
 Rq65mNMA3WGhqBcL68Y/76C0c8PvFtQHSMwt1lei8iJYLDG52GZN7SkiQF4Mua8wA5P5
 Zc6JturKNmSocI7FliJv3jzbCsz0G8zW/lx5HLhdkjzjhd5iMESsMpLgqZR0m3jt2f6a
 Mjmiyo5kuPTzxY2/Zv13qDar9XBIEZB7L2ghzrgYphP+MaUjjn/oGvCf6HNolFkaftbU
 r32g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwyCl/r7SGolvap/4XIg22UxQA3HgK1dlXikUIEXwq0YjJF6nowcaGp38FkgOWNMrYp/zUoRH5jpzp5djCZ@lists.sourceforge.net
X-Gm-Message-State: AFuF++nNH5ARZR8EXNgpyJZwT9dLX6riTxXDTjzgqFDYfSKcZRJDFgst
 EDTBJruNyqdDFBDHiA8j2zSFeQZeO4wtzQaBxN3JwrqSr7K3ML+w4RxlJHHjJTRXcOMupWA1QfQ
 SPXrfDpjzJb2AEeNm+KIaHDB+Zn8T270cCqnEivWnDP6ayvbjwVB9DoTzwTQs0ONfUBsb
X-Gm-Gg: AYBFou0e4qtLC5CNEOfLhyWGRANhlcy+/MaNRagqNlbY9HHNfAnRf5Z3OGujBDkRL+l
 OOCpD1FLZuy+bn4Igvn+d09k0u/22YI88FokFmk0SJoRd9PaiJxiE4mojsrXvLvU8oXPB2l11+L
 wKTTklVLXIW8lTXXNZ3ew+JQn+gw8WttHuopA6FcCPQKv0eJe91jIGiy/r0MUtCQ+fNya5sE8TA
 Da+hRD5sgmv+lLd6TThX0JsHvx//Cgm0JafGe8MgKHB5ayRiLBr7gbXc7ADObqDj6AMxkpBbpM0
 U+iLNQiLFxn2q0o1bvTR+HQqHD36SmeRhREasvE+E5cjK7v60YgKf6nuqowKdV7bEPXL3BYJrj4
 4kgRR/3SlNrpPwuPTMG5kHekAJxfzzCNX8N9itTYOwL0TyKaOV0+NFYVJRe1cfkehxSIUB0j+O3
 rwpXjI9cGdSaxu/99U3mJHnIU94I7PN4S5naYOPRt9KtW7MKCsdAPzbl/ixn6aDseN89Olh3MsP
 M567S3CmKvCLoBPSMmmiuMZTV9zxulKP3v0u4qjerUz9s+KJhpw3SpYQayXcWlmnWmcy5/13j2Z
 42Sxidusu3ftvgvXB7dIgj+CTkhqL9lEBeNEpmjHinUrefBTCsIjpDM9gN8h
X-Received: by 2002:a05:600c:4e89:b0:49d:10d6:fd55 with SMTP id
 5b1f17b1804b1-49fc5681267mr158346235e9.1.1790009431859; 
 Mon, 21 Sep 2026 09:50:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fd8b96cefsm3664055e9.1.2026.09.21.09.50.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 09:50:31 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 21 Sep 2026 16:50:29 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
X-Gerrit-Change-Number: 1921
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1921?usp=email>
X-Gerrit-Commit: 91f143fc1c880bac765972d9d04924e124d9e84a
X-Gerrit-Comment-Date: Mon, 21 Sep 2026 16:50:29 +0000
In-Reply-To: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
References: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMDA2MzgxMDAwLkljYWE3NmEyMGVmNDFlMjYwNDRmYTY4NGQ1Mjk3ZjQwZDhkNWRkYzhkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <78505a54e7ac74068d8844e125f1e41da09ef5df-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x8hDy-0003lw-Id
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Explicitly set
 PKG_CONFIG_PATH in Android build
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4909307934108150542=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4909307934108150542==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jZY0uAY8jEA="; charset=UTF-8

--jZY0uAY8jEA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1921?usp=3Demail )

Change subject: GHA: Explicitly s=
et PKG_CONFIG_PATH in Android build
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Demail
To unsubscribe, or =
for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
Ge=
rrit-Change-Number: 1921
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <fra=
nk@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Mon, 21 Sep 2026 16:50:29 +0000
Gerrit-HasComm=
ents: No
Gerrit-Has-Labels: Yes

--jZY0uAY8jEA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Demail">change 1921=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1921?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icaa7=
6a20ef41e26044fa684d5297f40d8d5ddc8d </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1921 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </=
div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 21 Sep 2026 16:=
50:29 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></htm=
l>
--jZY0uAY8jEA=--


--===============4909307934108150542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4909307934108150542==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4909307934108150542==--

