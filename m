Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66FC606A31A
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A23n4+I6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bXgH4Npv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Vwp/ETFk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FKuIREbb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=89me4MM2uav7/iDY+96nU+yKv2JTfDFqRaBUDSW/ycM=; b=A23n4+I680jhShjKPY4j9vHFGb
	YXSVb310SrLTq/N9lMQKJRRtkym6r+TzKcbbOECVFI5oVfaFRvdEg0vDO3mRDLeeykfXvGkjkcHIr
	mv+DXHGH6HsN/UXAF5MTQKBWznoMvppdOISb9Ulf+A7kPovy/dWqDj1Epa0HvibiYlbA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8PX-000000006WP-134M;
	Wed, 28 Oct 2026 18:30:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8PV-000000006WJ-3gTI
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:30:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nOQrSjZyO7wCPlAXwcrmgvYuz5Xf117g93fEM/7UyOE=; b=bXgH4NpvsBWcrqjeJderCSwHxc
 7wWgCsJn+15ml2NUoFCbhen79+jjjCSsl9lns39GpdgaGmt8sLW1cRky2hmu03R0asus7jJRjjFqb
 hS1xB+fOaE1zT03BE8RySLvydvTWhoKMu7LIG4pdhqSbE8eBwMfYVgRpzf4Uby11cZsQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nOQrSjZyO7wCPlAXwcrmgvYuz5Xf117g93fEM/7UyOE=; b=Vwp/ETFkcMlUSAUxSfkd0joG6c
 4qCow19Kg8pAOQXyobX69j0RNZK+8FzLSW6D0MedG/Aw9uiUvvj4X/s+IcGmmsOLffNmixotX/6DF
 WsPsoRL6TkWJA7l3GCUbRiWmIaG0nTBgMQDLzb/wgIfyx3afr3L0/oChiuECekO4TLUc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8PT-000000007fM-3OD5 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:30:05 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so12366375e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793212197; x=1793816997; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nOQrSjZyO7wCPlAXwcrmgvYuz5Xf117g93fEM/7UyOE=;
 b=FKuIREbbZ3I5yY66H3OcMmAiro7WfjhLUPv6nYTA1GJqiDyZWn0Z22hO1+ek1j5LHf
 haIJ9Y+MrqadPlH1jc9d2HoYPN5w0gxeQMUltcEhN9UQtiVKjGgGUBDOgWhaecmyk8aW
 E7IcHP+BN9QPaXLM/deLU5gzrg5tCAJ8GrjucRPQkyIrJHfjdSCflV/HpB0Hx46SZIse
 IKGcq6owseFG36vMcmEIdSWr4AJCHbsk08vJHI/MVV3a/btRmmtyhLEiDGp2iVNZNI8F
 5EyZieFSQsA9RwvAg/oPo6l73hLdqj7iJM7glx/JF5/PHqOs6e8T4lcLg1O7XfIfZVio
 55xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212197; x=1793816997;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nOQrSjZyO7wCPlAXwcrmgvYuz5Xf117g93fEM/7UyOE=;
 b=Z8HrLoRA8lQd1TwpMrq3Z3RZiiS1eVQRmgAZCbIiINktaJX5Sy1LvT4F6aterUecq9
 jPNlZtCmVpIOdde6w0L2tF8/h1X30/iRJie6WYW6ho7yJ60MycLB69M/EXl51cgazu7W
 MPESdB+krWubkZR4PD5rKQuUAdJwwXaeZviZuDPitRxPa0YPK7tSaSNfW4IZKyfjIMSp
 jlWPiK4jLR75qZOt/SxSDkoHh0zLu5jreXmssbpzHWtJESqRRCbgUOi8MW0R/lruhwEN
 OunHLtCax2II4lRC/Rf2YjvduRvRSrNGwszgJa1ocC5uRhWuro3cz5USFOTdHdCZh3pj
 uTxQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx71aarYl/Xc1Ro4jnN5Wp1xzxmqmEXunhyASiIY7Ll3eoNIDiQocqoZxT+NinUShLoWcvH9n+6oP9l/lvC@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJqhG8+2G5EiJr/ukNtVSFwiPc27CTmYuyGbb2NV2XeyNBoh1Lh
 lUm3g+QsGBwaiOZGhteJRKbZ88DWmSMrTVZBzoyZ0KckTZx/gQcPyv9JwkB2TZwuwjlkWuEsIdI
 xqtCDqJxuZA7QLYxrjJhd/i5+nUV/Cbixuuy9JZp9WBdWyavMI7ieubOKv3mKAwY6pUK5
X-Gm-Gg: AYBFou13NgyGp73Undf+AGYM0uEs7TbAsE3leDU9LrRtNm+5sITqxJss/F42y6ej8zF
 O18x9aRoH55xHfK5+UucLgkWVnlHJ9qT2/FRbFPtEZlgHkR7hukjLfaXTIwmY4OMb0nxmhYpMsJ
 up7gGiTVKY7gPrTUmkOwP87NCEeBsJE4xiOCTIbxL+RmjVXKWmqOfkrWuJfzBI+zDoBrjoD6Urw
 NVNp24YKKsAtOER1c8pLqnkaO/YRFaWOrFZsGZ4/Et5eGNh2GV+OEwUqSAtSzN0fD72xvOjurmX
 /md6j6FsXyrb3k74oYgFqeeQnIMVPwOkH46WW+o55SFYAZhIYJ8vV4BuDolg2BXRowswOSJ2wqB
 uy5pI5uys08c0RiWpLZ9QQGM25Jov/FrstciS0k1CevGfmakGp7bvSg6d5K7jksEzJhCEIOo9N8
 3sWvnSLXb7dKo7qtllCkoXS63GmapBoDbHWMgOJvhAdIvKNefvJp2osWAiqBSHRGVNB0QZJ2lLL
 7Atc+j1fjGvuZYqJp25gFbJYYdpe0GtasOfICGUXyKhYpsNSkoi/DvWt6uMzGdtRIVBR0oad+7W
 +O01z/8IL0KebjKvtetphkFykeVRICKCORIREXhTVgAPnOnu8MU2qefCwlM1JITKd2wUMNXUrLx
 RHIQWEnB8inxXsQBilDTsxwQEg6Mh78JypDLlsPgJM8s/aJeP7cUMtOyT3++7AhBNtfpxqw4nOE
 yxFfI1Egji/cPrU/A=
X-Received: by 2002:a05:600c:4445:b0:4a2:526b:d40f with SMTP id
 5b1f17b1804b1-4aa83e0adefmr11114075e9.0.1793212197023; 
 Wed, 28 Oct 2026 11:29:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a96989ab11sm39859715e9.1.2026.10.28.11.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:29:56 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:29:55 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iad51b2f31e4215c58e160cc6239836015ea4d3cf
X-Gerrit-Change-Number: 2064
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2064?usp=email>
X-Gerrit-Commit: f332dfdec52be14670fd45c63c66ea0d9f1e19c0
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 18:29:55 +0000
In-Reply-To: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
References: <gerrit.1793203931000.Iad51b2f31e4215c58e160cc6239836015ea4d3cf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjAzOTMxMDAwLklhZDUxYjJmMzFlNDIxNWM1OGUxNjBjYzYyMzk4MzYwMTVlYTRkM2NmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0ff81c43346ed25bfb4fee1a3027e4c8734e9abd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xM8PT-000000007fM-3OD5
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Track number of
 assigned peer ids and use it for max-clients check
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
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2871405121643955825=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2871405121643955825==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ntLUgsu2cIA="; charset=UTF-8

--ntLUgsu2cIA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Arne Schwabe has posted comments on this change by Arne Schwabe=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail )

Change subject: Tr=
ack number of assigned peer ids and use it for max-clients check
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(2 comm=
ents)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064/com=
ment/81f6b14a_86f73559?usp=3Demail :
PS1, Line 12: UDP connections only rea=
lly this later in the connection establishment
> Typo: "only really this la=
ter"=2E Not sure what the correct phrasing would be=2E
Acknowledged


https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064/comment/f07ab456_d363c273?usp=3D=
email :
PS1, Line 13: and then only for peers that are of capable of DATA_V=
2=2E
> Typo: "peers that are capable of DATA_V2"=2E
Acknowledged



-- 
To =
view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: =
openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad51b2f31e4215c58e160cc623=
9836015ea4d3cf
Gerrit-Change-Number: 2064
Gerrit-PatchSet: 1
Gerrit-Owner: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Comment-Date: Wed, 28 Oct 2026 18:29:55 +0000
=
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>

--ntLUgsu2cIA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Arne Schwabe has =
posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064/=
comment/81f6b14a_86f73559?usp=3Demail">Patch Set #1, Line 12:</a> <code sty=
le=3D"font-family:monospace,monospace">UDP connections only really this lat=
er in the connection establishment</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;only r=
eally this later&quot;=2E Not sure what the correct phrasing would be=2E</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2064/comment/f07ab456_d363c273?usp=3Demail">Patch Set #1=
, Line 13:</a> <code style=3D"font-family:monospace,monospace">and then onl=
y for peers that are of capable of DATA_V2=2E</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &=
quot;peers that are capable of DATA_V2&quot;=2E</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledg=
ed</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2064?usp=3Demail">change 2064</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2064?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Proje=
ct: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div=
>
<div style=3D"display:none"> Gerrit-Change-Id: Iad51b2f31e4215c58e160cc62=
39836015ea4d3cf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2=
064 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div styl=
e=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 28 Oct 2026 18:29:=
55 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>=

<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"di=
splay:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--ntLUgsu2cIA=--


--===============2871405121643955825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2871405121643955825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2871405121643955825==--

