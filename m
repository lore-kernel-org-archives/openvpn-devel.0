Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15FBC88E4D
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U222SIIjz0uxIEz6Ak/J2BTQ7HBnNqmOp1opKSX88wE=; b=FQTdGtczdGwsiEVfVvlGyixkUp
	rQVZHFudMqZy/j0RH2Z4flrpzFyir6IFmPg1qfsqhNFhiy79wMkb+7bHfdKArguQv6U1/RF8BHmjp
	2xWLp4d1E57V6K1FaD2Pt4uaKv/chnDb8/F+3xPBPIYjNxcYn6RMaRzToMWjtNNwsBC4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5178-0003av-Ti;
	Fri, 11 Sep 2026 13:16:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x5177-0003ai-J2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:16:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LFGbaV1V42Z64kJbW8ngVwBgaXw07pGZezWoOdM3zpM=; b=fsJ36V0JIn4eASTRWKE0+mPeX7
 g8wj+0yzCGK2swdmr/pgb9j0eL6kxWBhjCI6PQC/RJs9oSatdWd3wvPsD9bY7TpgtvdEVvQ5VkzCl
 PleR2tOPGkRxX+aOkYxBYN1xUvFlvbo0i4LrZEDAAVADfjjFoARS/wukc74/EVxbm0oc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LFGbaV1V42Z64kJbW8ngVwBgaXw07pGZezWoOdM3zpM=; b=Q
 DrGhM4DVTHDRtU5VDXMEmp9GUqR8A+jNn9rsx9GreFB/6vaXegW52o6mwT6KqCseHLW3psx0X0Emg
 +kLy1dCj8Dw0DUnZ5DrsITysSJAxb3IHowDzjQjDaUh8soycFIxiIOcK6P4Q41d1xNhH4BbUJGLwH
 XEj4ZxFN7cmey650=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x5176-0003SV-7I for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:16:21 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48442ea8f59so678830f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789132574; x=1789737374; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LFGbaV1V42Z64kJbW8ngVwBgaXw07pGZezWoOdM3zpM=;
 b=bHZ7+8J1FKU0C2H584rdpqvf6TZYfNitS98/2wGPznr8q/d/1DLrKjOF8+to0UtkrK
 ebS2a0MmHNIFmB4m2AP5864/EZ3MfVzwepRJBpfooVmCWU21hvXQfM0NwDI95tPw9rVy
 d1iADHwAqP0chZeHjPUMZ6AtZYXIiv7Ms3+zwvKxAC0SzE4bnm6EP3Aym6KMRyb8FMh2
 cqhPKUWN3LFThSOTQPXSDHUadl15PjeUy6SUn1JuE3y4Od0n7X4uzQbxp3tyNR3asOVr
 JRZJ25IlPY3avLKYFZIV9oIDT7Rc+0FcikQn+MaKXryyZ4t2iDDHf1oCxC+10SqMg+JR
 ayGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789132574; x=1789737374;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LFGbaV1V42Z64kJbW8ngVwBgaXw07pGZezWoOdM3zpM=;
 b=bsrbcI8kEBh8OfkJ7umyxE1nCISKf4HeTQJCzfm9qqBOOx5Cf7trLti00YWOT3MH2v
 u/2T6uM+AiZEDi8W7E/CAKn1ytltZSh4GNOvaiEQJbWicVoI6vb3fxlpVQ66PelJK/bX
 PzV6ji1LEz6CXQgRu3fgEfld4PwTUzMKrNAImIBBFTktTKFCt1d/Jl07q8Wb83NlQpNa
 sHGC8zXLlqS+4IZ2f/piv8c9GnOvrK+aSZmqlEYAXHBpm3KaoEHr/N6WzZwwjtaxdW81
 7TSYbDqaO9OTGliOJeNfWAvS3ZHPjS0n+ZzT03ivbEG8yPFQ8hijYkYFe2eqScg6zwKS
 7IkQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxojo446mi9Nw+yV8y5QPWdHfL8XtfqHMkyx8V8b000wEOzF0sHSYTpF2b8e4cEQhO/K0xqr8OxzwvaAhgK@lists.sourceforge.net
X-Gm-Message-State: AFuF++n37gDE6+m/9O9PDNEl4/66o3OueK1DBmU/Rx25FmqSbAdU+2Rz
 8caQph7Kysdp3VV0xbFaEGYW2Ynf5Hz6ipApklLrwMf0NwHjVPoPmyMVc/X2ldWM2o2P69v9jU1
 zrCEw5DNCcdkHzrRP4JQLVdnV54+qfg+kGpgRan5MEXxN6t324qG47jqbU5e5GKCQx3E1
X-Gm-Gg: AYBFou3ffQQuAk1TIEMCmcqaStq7ThTk7amJ5vGjtRAWiWj1XubwHivXwPDOkT9Uhy/
 ZSJMlrBLF6SLX9m73Nscetm9LI1fSrDHRAMgNoX8Zc4j93SznOXVAva22VKosp2AgZQzgVD23B6
 Srp38KG88YD6XCJob3ez+D6i5MmWNfJ8p1ZoZJqoMT8jNAhUuzIjL6G6sPdDTuLhEefpFI2o50n
 IO/jJQvz/dKl9saVLIwnXEtLOwtvLN1YG/zaxNcsjhZA8K2sk+EMujKHywXEMzVP/EpLMy1x9bl
 Rnc1k8VHEwiboRL4DpJGsFWcSY4EOw5+FRcGvGGJES8jfFvd8uhriOQRYZKt/lanGw3ILiXaZff
 WMAKbq/gsvXrgypDAoC8byK9WFLj6AZaKY7NiS0AECVwifu/V8OeTGU7R7n3yEQ/XmePQkyXH2D
 mvST+yqvoT0hfxnEXAuXhKT7vwj5EI/GDs9AY+ezn+n5wZsqETACyfdciq4oEHit+1SdYOkhNDl
 QlWnkNLBNs9e2AH9S2V0Ywygk3qWQp0cPau+CHcyQRJCd5akYZluAqYTkm4gNrGICs9Q6j+pafn
 t5qrh1uxp3msJp/d6KnSqS8HAcbbdeGn7t+VC9E++u8TVMb5Bvi9Lxz0NfNbhFnyXa91/Hi0
X-Received: by 2002:a05:6000:4701:b0:485:8a07:3f0b with SMTP id
 ffacd0b85a97d-486d7309df9mr11989318f8f.0.1789132573459; 
 Fri, 11 Sep 2026 06:16:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb35bed0sm5771932f8f.32.2026.09.11.06.16.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:16:12 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:16:11 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
X-Gerrit-Change-Number: 1904
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1904?usp=email>
X-Gerrit-Commit: 8126032d14b9fbf864424f8c4982da147220beec
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 13:16:11 +0000
In-Reply-To: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
References: <gerrit.1788815035000.Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODE1MDM1MDAwLkliNGFmNzYzOWNkZWJlODFlYmEwNWFiMDRlZmU2ZTg1ZTYzZGUwZjllQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7c893ce880f4a126884d67141b9d60bbb374f926-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x5176-0003SV-7I
Subject: [Openvpn-devel] [L] Change in openvpn[master]: buffer: When
 extracting pointers from buffer, retain const
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2278602606320817022=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2278602606320817022==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Qno1b0yh8Tg="; charset=UTF-8

--Qno1b0yh8Tg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1904?usp=3Demail )

Change subject: buffer: When extr=
acting pointers from buffer, retain const
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4:

(1 comment)

File src/openvpn/m=
anage=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904/comment/738c764b=
_39771bc1?usp=3Demail :
PS2, Line 2524:             sent =3D man_send_with_=
fd(man->connection=2Esd_cli, CBPTR(buf), len, MSG_NOSIGNAL,
> Yeah, seems w=
e do not run the android build with -Werror: http://buildbot=2Ecommunity=2E=
aws=2Eopenvpn=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1904?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: Ib4af7639cdebe81eba05ab04efe6e85e63de0f9e
Gerrit-Change-Numb=
er: 1904
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Da=
te: Fri, 11 Sep 2026 13:16:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>
Comment-=
In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--Qno1b0yh8Tg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1904/comment/738c764b_39771bc1?usp=3Demail">Patch Set #2, Line 2524:</a>=
 <code style=3D"font-family:monospace,monospace">            sent =3D man_s=
end_with_fd(man-&gt;connection=2Esd_cli, CBPTR(buf), len, MSG_NOSIGNAL,</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">Yeah, seems we do not run the android build with -Werror=
: http://buildbot=2Ecommunity=2Eaws=2Eopenvpn=2E [=E2=80=A6]</blockquote></=
p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word=
;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail">change 1904</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1904?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib4af7639cdebe81eba05a=
b04efe6e85e63de0f9e </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Fri, 11 Sep 2026 13:16:11 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div=
>

</body></html>
--Qno1b0yh8Tg=--


--===============2278602606320817022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2278602606320817022==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2278602606320817022==--

