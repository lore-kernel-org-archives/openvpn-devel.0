Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612F7C5AE49
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Isz0LcEntIxbfz0tCozbxWIqv5c7+kNm1l6Ul5I1Cas=; b=cW87oH87bCCRMmZar0uKt5Npop
	N4SkPmFU3PFEMZ4CDhIAAJAzy7EYijfckGL1Z22NSSSswD86FUzy8EJdv71MVjaZ2Zf1crJRO6ZEY
	sMGFQMdbVSFsoumC0zh3CGJpNdpVCqt0nqdnjoW5YFBhZzVTDFdK1NkHXt7Ay+/Oygng=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtQrR-0003x1-DO;
	Mon, 10 Aug 2026 14:20:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtQrQ-0003wq-Hz
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 14:20:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=wGemTBatCpf36lqWUU5ul3on4EAT5hDlPHRL2oMf148=; b=IIP987Ep92z73vVD0FOATEifZp
 za1lTX9VosNk7omaMD2ji9jfl/bBqIAuddqSAPqYu6KqEK0qTwomTmOOhuHvC9yiPAZEZxvW2rzwM
 vmDZI1Yj4EQK4S8KNgwxrXrcQSF1kN1KiTePdgXJScSNUG4vSCKgcCxfuwksXXRgqkhg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wGemTBatCpf36lqWUU5ul3on4EAT5hDlPHRL2oMf148=; b=F
 xd2nRuYysA5WQctEfx/18SEhjoiyHJz2xcWW3CIWDDkVnyRudE/GktT4HWW5qv5fF/3YNZrHUQWOs
 +gseM8g8B5wHEsy5EE0JA3uGlSKgEwSy96t++jD6E8hIEkTkJGf/PVPR29ENJJN5igOns0mc/s7FJ
 Qz2CgiBiUuBHhqHA=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtQrP-0007ue-O5 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 14:20:17 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f6609c657so1017033f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786371609; x=1786976409; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wGemTBatCpf36lqWUU5ul3on4EAT5hDlPHRL2oMf148=;
 b=Mc9WiBPw/eIG2c26Pl/mKAz9SiRiOsK7vtg8KdT9KNdHssuUGEunUYyZN+MGTSh15f
 hxn7Oxi8zcypzFB6Tq/ElbPfdjFugPj5+sPxL6DQUPQeLBA7ftuzsWI29Uj8WArF0LMG
 Tgctg+day5LIi6lTHggnA5Vi48oURqRM+6ZX1iSjSQdk0mm1wNevajdHcUVu3XgDrdRY
 7RmsNKPjCbwgv0TlGOCJLH1WgD9ScsPgVujuks7qHd8wQeYvqakPOwj6drQojYInmzgt
 iTm0ocL+cLdw9ciXuzH0WkjeYjlVsVuvskav05RSp+9cKejG2Jhk/T56wYaufA60mcGJ
 c0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786371609; x=1786976409;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=wGemTBatCpf36lqWUU5ul3on4EAT5hDlPHRL2oMf148=;
 b=BSrNXuhlsWoaYRLY8/VL7t2nptjIaVvGgjB2NtU/+QpNiXbYeh0gtuyu2FTtVVuVjF
 LhAW6jB5K19V1qjdhYSFs0hKfUpkWMQMnXtIHk5d+0lV5Ieb9MsdIJUgK3seUR4PQwHm
 +o70Q95iksbpTosGVNXsthZ+BXveP0qMjQp7wo7Pxi7T1T1SPFoQid7egN+liKH51xvB
 gbzWO+b7a71EtOEBw44x5fpD+5oo/0ORbTmOgpcIQDIKVejgugHFg+I7/fnr9yAmVsls
 8p31V/3l+uQ9pXR2y2TbjsfD9WqPSqx+cwIp+wRzltobBCXRwYnEd+CSkLLAksFlbiJP
 jGHA==
X-Gm-Message-State: AOJu0YzE8SFpATB1GagnhwtUnAIFXiZw80TMntSmZKPX99JldxYByrcT
 xUAtZs9ufNf7omu2ByEOEsf7awtevFzAxqkjdo90CBgA5jvth+Cea4tD+VPhKc92jyofKqeZ6Rz
 z+0k8he2x6SeKgr3EMKAbkw5+AaAxidjpwljvApnQ+o3cqwLYhHVn6BfHYRXizEI4NgRp
X-Gm-Gg: AR+sD13Oxu7LGLmXDwZg8+JC/J/0h8XJhUQcgJuvquXbHJMSFDyjB2NavuRINCRcMeX
 pygS10QWi6fXHRAObYTOTdEH0Xd128QKzXOP1u+MUOZdM9zo4HzuyUofPA/uA7t+1jVStNeMsfU
 cWPbgalDtdXAUIZtGjKhhyB/07mIqdy2xw5dZQodfdoj8HA09JehY/OtBznfeuGsdKazJ/Nxg3v
 60st79KVKWazNF+i4pMthYzfkmIvc0GJm7vuIMriRKZbwdBXdOP89yWUKZut/PHrdmRKRrEkFD7
 54/6R3DYJt8bgxjNKcwVCw00KoOP593xHWx3IbfcDgSwWUhsV3nGdWbBi6uwljAF8jr9Fzc+SiW
 PFsKrbiAgO1SryCGHBto3gjfdif6QCAQ9zsitZgOsq3RLh3q5VN5g0GkzOWdyKhAfdG9N9uRtRu
 S7pnU5yV4afDLvE2ML4jiKagxNap+IQ8fGjiytAEIxfotMxVmfnW4Ls0ehyDflKlHj7fm/TVaGP
 WtUNcamuHhTnCCO+LHHsbXHwk2PSmCck8aIyjAcqR/UB9nX4/jZ6fxwfvwZg2FKzeufKl8vEqln
 UMrOTcID9tCfU22spJnzhfN0cSjE9ytLW1VJxwZVAeytu/7n4UAeaF82Pee8b6Q=
X-Received: by 2002:a5d:5f46:0:b0:47f:d072:87d7 with SMTP id
 ffacd0b85a97d-48002682be0mr30451893f8f.9.1786371608908; 
 Mon, 10 Aug 2026 07:20:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480020be8f3sm33467815f8f.0.2026.08.10.07.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:20:08 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 14:20:05 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 4ac71e05cf29591662491cfc32df284217abc699
X-Gerrit-Comment-Date: Mon, 10 Aug 2026 14:20:05 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b163739decb32ab68bf17bf1b85531d2ef310b5d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtQrP-0007ue-O5
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
Content-Type: multipart/mixed; boundary="===============8113206894365978967=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8113206894365978967==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8HY/+s1p9NY="; charset=UTF-8

--8HY/+s1p9NY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 27:

(1 comment)

File src/openvpn/sid_hash=2Eh:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/70845c90_d3187834?usp=3Demail :
=
PS26, Line 61:     struct hash_element *he_sid =3D hash_lookup_fast(m->sid_=
hash, sid_bucket, sid, sid_hv);
> It looks like that but that does not actu=
ally work=2E [=E2=80=A6]
Acknowledged



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Chang=
e-Number: 1727
Gerrit-PatchSet: 27
Gerrit-Owner: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 10 Aug=
 2026 14:20:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-=
In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: fl=
ichtenheld <frank@lichtenheld=2Ecom>

--8HY/+s1p9NY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727/c=
omment/70845c90_d3187834?usp=3Demail">Patch Set #26, Line 61:</a> <code sty=
le=3D"font-family:monospace,monospace">    struct hash_element *he_sid =3D =
hash_lookup_fast(m-&gt;sid_hash, sid_bucket, sid, sid_hv);</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">It looks like that but that does not actually work=2E [=E2=80=A6]</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Acknowledged</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59=
ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 27 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Mon, 10 Aug 2026 14:20:05 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--8HY/+s1p9NY=--


--===============8113206894365978967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8113206894365978967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8113206894365978967==--

