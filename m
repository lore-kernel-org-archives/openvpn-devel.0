Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF31C9833F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T7Z2fuZ9YlN576nNWEo9B3QIXKz8RWfXzaPfbapDB5M=; b=avK9NWEQD5ve1dI4IrmVH8jgTm
	SFEoTE7VagTtwoqZZVF/G7Wk+MZeDkgbmfzjb1sk010qgR7z3X3sgea0Qn3jtD+wvb6LK48fLuV+Z
	BRzGIJmksMiP7TRJ1cz6/EtCkwUce5SMsQei8FpW82GjlWRc6yIn8AFT0UeMujdeLohY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB8R0-0001UK-9F;
	Mon, 28 Sep 2026 10:18:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xB8Qz-0001U9-2U
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 10:18:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Zr05hM4WhyuDYJ7Ys7zFOK0nvI8Y/OUtMqiwhHoyyYA=; b=MwtVqyezir2xCsteTDweJqNRnj
 lNQvwpef6L6+FDoRXWPH3am17o+B/RFY+hq6g6RqO/9n2jt+5AntCF1ORUUU9uGUM7U9ObVSizUmK
 pqxsQJy70uhoXj9HkV19aew2UNXCnobWz6no85FAOFOVgMUS7zSDaDZO9Yi/whuZlW+Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Zr05hM4WhyuDYJ7Ys7zFOK0nvI8Y/OUtMqiwhHoyyYA=; b=G
 5rj8U5ghSfD6QOPtU+DJ311962rsHhAh6NuSzqlBvkTxSu+egNdpDTL7hbn5Wlsiq/3dQFw0BjpAM
 6Qs6AQaaxjxGN/j5sl5LkCq7opV+g6yjufs3Ug2P/qqpNZ1eEquqe4OIcht1e/cFJLn3qwa/HGIax
 ebPubTweYQoeNPmk=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB8Qz-0001nj-1C for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 10:18:09 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48884b0219bso1148942f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 03:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790590682; x=1791195482; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Zr05hM4WhyuDYJ7Ys7zFOK0nvI8Y/OUtMqiwhHoyyYA=;
 b=FnSlHIdQDLSv6k8y9WQ6W6bGuBWr5f44iFNcDxsiy7elh6JOCw6gQRXptFw/XIFP4V
 WWe6EXjBxcMUtiM/IGHiEI/VJE9iH9gpqxP4VQnLnCkLKNjwb5j1ppPCVw1GGU+CC4tZ
 nQ8XSs8qWb8P2snoB3lVt4X8ov8anU1vuSjfadCXcLiBisRmYbPAHFqt5C9BVVudPy1y
 Mds+BJ+tKnmLlzFAHUJksVfhTYUUEbp9I18zCZKb4jlNPSSSd4amrdeySEutPCGpktbM
 IRauIg28EXWlqd/YtRloklQugkxyGBtulKzC9qrMS9IEjMxYus8RNhen7DWGvsQRHj3v
 bIGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790590682; x=1791195482;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Zr05hM4WhyuDYJ7Ys7zFOK0nvI8Y/OUtMqiwhHoyyYA=;
 b=oCS05Dm13nN0TEGrJ7tGFlTq95itHBpL7i2K8azaAK3km9vCR/SNdNkP2V4JXOIXC/
 oUXPGVg9jrl1FuLEeXTHQfAUan+L7Lq5wkP/yzLaxUdOVCMiAaQoDWTI0sO3HOPpZRhI
 OXaPkolDyXzMwD4RHvkj1xP1o7w8QHj5FAh0H0cyE2/+uF14CFW0ygycywarOX5JynAM
 8l6B6Y5Ll5yy6J7qOhaDU049e6u1+DLxZ04ULzS5iTUHzCwJk9tKY6ZbQhzs1mvcuf9u
 eqqr8CQ2KaxoogMvuu1oZmiYmyvdmSYB3FmcuIbK2qEPAyiPGyk7BSQlFIW24Qekvw85
 lzFA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzlfPthyN+rpuH5X47/gfZ4poodRgE7LFGp3ob7fLLMEzB58aPAKldOU+a91A67wtQ/TP49YfBLnFBbH+oj@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLxnrn796I3TdrYtB0bJwi4ry2ZLfRmnISxUbz3y470vIxnVvUB
 RMpNZ1zo+3434+m3RJ0rnQ5CzP1aZ+gd9857gEPAdl8Ic7ANgLPqoK9tvdMTrQHHufyERmp6AcR
 hASCGekT5ePs5JH+iGRt+tY6j+eNrMYiaiiigyp4yr0bqSsFvoNIxjnIKUSsp/aDPQHJL
X-Gm-Gg: AYBFou3HXiYbiRwDgGl63kWz/JliO+ftmtqzGCKRKSD6oaNn+COIFOuB9za5DBg8DCZ
 ZNhurg7XdfPlSnX5sYmSMTGiC3aWYCPLN4x9YdE0H2i8B9wO35vCpAXiko/KnzNWbG33N6mwGfr
 coIL5ViT50An6r1DN461vgpHxUHCLPc6q+i+jLQtVPxD8f1Crw2RGhtoVPgu4jhVRb54ajoBTV/
 ORykxg76KWO+QGF5pONMi2LkLEu8JXK/HcTBf4QWKfDzRgpmhY4mIR0E3WWjO9URggCZC8FpFRV
 If0L1nxE2VowEx2E5XZhEU/55kmsB3h2uWhrlNZa4Qm9GJOqChHTnNbhwNNh1hcRiXg2Bfs6GLC
 lgc6SLOudJjVP6QysrghibMRDkHFNkxWU2SbLj3Uuvx8V3QaMuqWZ67aqLH0iJTCn5s04Bq08dP
 pdwWUivAB6ZjYUHksagi0+6zcHdL6VAHfsYcdNeV9+YxdQQXQwZM1iNTZZLHhaJQuL40xKSe9eN
 BrbomMt84bYTCnulmUsNBiRT5KEptwu6qCyeYrvsoXY8eCY+JhrbKE3qG7bQlUNfQXh5KbMIyXm
 qSKBf5PvRcosGoS+nsiE8LB+7ZVEMV/Kyci077AMGGjomGMOX5nP/wVKdJGk
X-Received: by 2002:a5d:59c4:0:b0:488:6da0:b83d with SMTP id
 ffacd0b85a97d-4887db39e6cmr19592380f8f.44.1790590682286; 
 Mon, 28 Sep 2026 03:18:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349fa1sm38306006f8f.8.2026.09.28.03.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 03:18:01 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 10:17:59 +0000
To: chugly <charlie.vigue@openvpn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f085574dde
X-Gerrit-Change-Number: 1946
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1946?usp=email>
X-Gerrit-Commit: 90dac0ff74b5023b593c7903d89f7c9210fbd403
X-Gerrit-Comment-Date: Mon, 28 Sep 2026 10:17:59 +0000
In-Reply-To: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
References: <gerrit.1790212215000.I9085c55a7efefd31839b00ec8ec9a6f085574dde@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5MDg1YzU1YTdlZmVmZDMxODM5YjAwZWM4ZWM5YTZmMDg1NTc0ZGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <19b74e82524a2eec7d3ec9f62560bb339c7eee6a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xB8Qz-0001nj-1C
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add unit
 tests for route.c
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, charlie.vigue@openvpn.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4708295414967631258=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4708295414967631258==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gfXaO3k3e9k="; charset=UTF-8

--gfXaO3k3e9k=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, plaisthos, razvanc=2E

flicht=
enheld has posted comments on this change by chugly=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1946?usp=3Demail )

Change subject: tests: add unit=
 tests for route=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: Code-Review-1

(3 comments)

Patchset:

PS3: 
Please =
fix the builds


File CMakeLists=2Etxt:

http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1946/comment/f9b10e32_c8cea815?usp=3Demail :
PS3, Line 947:        =
     tests/unit_tests/openvpn/mock_get_random=2Ec
breaks the windows builds=



http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/7d4a99eb_c9821be4=
?usp=3Demail :
PS3, Line 1007:             tests/unit_tests/openvpn/mock_ge=
t_random=2Ec
Why was this removed? It broke the build=2E



-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I9085c55a7efefd31839b00ec8ec9a6f08557=
4dde
Gerrit-Change-Number: 1946
Gerrit-PatchSet: 3
Gerrit-Owner: chugly <ch=
arlie=2Evigue@openvpn=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evigue@o=
penvpn=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Atte=
ntion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 28 =
Sep 2026 10:17:59 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--gfXaO3k3e9k=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, plaisthos, razvanc=2E </p>
<p>flichtenheld ha=
s posted comments on this change by chugly=2E</p><p>Patch set 3:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">View Change</a></p><p>3=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?tab=3Dco=
mments&amp;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Please fix the builds</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File CMakeLists=2Etxt:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1946/comment/f9b10e32_c8cea815?usp=3Demail">Pa=
tch Set #3, Line 947:</a> <code style=3D"font-family:monospace,monospace"> =
           tests/unit_tests/openvpn/mock_get_random=2Ec</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">breaks =
the windows builds</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1946/comment/7d4a99eb_c9821be4?usp=3Demail">Patch Set #3, Line 100=
7:</a> <code style=3D"font-family:monospace,monospace">            tests/un=
it_tests/openvpn/mock_get_random=2Ec</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Why was this removed? It br=
oke the build=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail">change 1946</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1946?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9085c55a7efefd=
31839b00ec8ec9a6f085574dde </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1946 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div=
>
<div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@ope=
nvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-=
devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Mon, 28 Sep 2026 10:17:59 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: Yes </div>

</body></html>
--gfXaO3k3e9k=--


--===============4708295414967631258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4708295414967631258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4708295414967631258==--

