Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD4C5B572
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4ai7G2aka5bkskNYmE4X/i3z54ymSikfTQ/mkG6uH4=; b=l0VDVQjKjGQjsSWU4x8myMNalY
	vcAIWHr+8azzN33UAVy5miYBCz7EyzYmHfNAn0FRqLuGmCEtbgezZWA18OdGev66G4mYagQ+AEW4U
	gN0VxY01AN7LrZKXVSRNS2tc0rUSKVA9At3+k7PFPe0quMwqNYIYB9YBoIcbmEl1kWys=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvwll-00034G-Lp;
	Mon, 17 Aug 2026 12:48:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvwlj-000348-Qj
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:48:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3BYYnBl0WBXevDCcrN/ySjXIXLvCCie+YIjRSXPzzkg=; b=Vj9PTcXlIFzEWmrIqYZiugdkj7
 ZOvo5Nj8kcwBb2TGhyNUtoFqwu76gVhLCIjxup0im2MPbB2d3ctiAM1+O/ZTd81i1zRbqzTGaf3K6
 iuv4T91voyymVALa3f66KOQln9XjuWhuaEPHUuXEfT+q+9ayX8tetwcfKSMrtivgfBuY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3BYYnBl0WBXevDCcrN/ySjXIXLvCCie+YIjRSXPzzkg=; b=k
 3lK1oZhdm2AgkIwtYJN+PhWOI2eU3DW3w9IUkRHxaylZQ+HwP01PSiH3m+TImnMl/1dhgPi5+EpAR
 hXHqF67rlBPpSeuRlKZrwdkEKNdMdm+egjpXt/rfXlRsQARDi1yY5+GEkWsmEASnw+N+wLJJ/2Tam
 p8YXAJspVAYFAC+w=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvwlf-0007Ae-UT for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 12:48:45 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49556f97a9dso22986645e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 05:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786970917; x=1787575717; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3BYYnBl0WBXevDCcrN/ySjXIXLvCCie+YIjRSXPzzkg=;
 b=CLXPa0iLOyKYLdR9Y3EZLcPdf4IGCs23cfnDZrO3x5K8L1IjKZ41jEn9tdvvvsLYHk
 s8o7/CfJIKWcyGP7s6IUcpLCJmUoiPdAbMqarnjGX7bes5hE+UTltb5Uwkk62hTNmiXY
 DNUsLS5GPmZCNeWqZEmrMNj17t/RsIR6PHnSvymjBsSLy2WvpA6HK66iFf0c/VmklOgZ
 h4+PYupQUzqOu9ePvyAmMZz1OByjumbDU+KMkyUXxHQB8W35DlExO7JBOZtMqGQ64XCm
 ozOWfDexNphGXrlFYeQ+/0uPP+3yLJhKoHlJPF0YcOhvtWfMdQWksnS9N/tBXrXsct4M
 yHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786970917; x=1787575717;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=3BYYnBl0WBXevDCcrN/ySjXIXLvCCie+YIjRSXPzzkg=;
 b=YQlRgAnQwRvcGuJVzvfM0KR3Hi40d6McTTMfb1dzMGpssyRTEVinBxgMJGWBZLdII6
 IG3rrWnei1ZnRMoqaiccUE9cqftdngU/QNovv5boAMn7ZOShGnRxTktM/P+T1yEu1Hci
 A4yG3/oGOqsAAJSl3wfgA09oL4SVpFQQZiJhYX952P3l2qv7t7UI1aHSfaRxpIEwKsfV
 V31AoOSeFQEhChNETy0/c4rymvXgXfEGbi9Itmz8wcKbOoznCrMaPie2Hr/FhWoRfGdR
 TE2ynxBK0pyNbZuPoFK+PpnzILjpRAzbRstygd8TXgILSBkarN57okv4i0fNoOnqmp0m
 KvLw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSC3dhIftIhrvoMueXz1hnzXrwquvM8pUatxMIPeDB1fx7whiHO5/3PmXTUg+Vr/Jq6FfCzkM2F6J44Uj2@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyaxHbtmKIXGmJF6swXsgYSdkqwPxZg2cu6NmAQ3JyrDi4J3l/g
 +XX0FAkyw7RoFWIxHQEgy/qN3rNnI1QNHEhs5cR1l1hpL54fOnCY4Jd0ZzINZiICsseY32EQgv4
 GksnJ4QD1zzaMlAgYg0hm/Np/y7SgtzMxIjMxAZ6J/AG0WLKlVHx+WRaO93P2/bc8ZdBo
X-Gm-Gg: AR+sD10BRyBoVnMBXtwXr+P4h3QMnHOlr9fuQc+jWtOb8Sjh1AhhiuE0yUvNC8+G5tU
 rLsrwDdKl6GP6iTo7sCTB4taRZ0q4sIN9BrSJweqfurW+1pF2NucT0R8K4jno3QlnILLgzJWCzj
 5mzYZwXYxLHfRn8O/VsqePLB/3h7p7JL4FFw/ZUjSO9UfHQl5sgMbDYc8a5W1Xb2zTo2wAxFZ/s
 ukHlax1NBgzqtUuQR5nYQYHcrvWXq7SrKjF67awOEyGgw4NhDN+3w79AxHBcHiL0k2ISZ5gKq/v
 8bwFRCutGj++9RQjFTWJTR7O9Vt7V+OplJ1ac6+O+rP+F538KbMKXwA2pPSg5p0/ri1YeobbG7T
 clhxrljQCGpdIxA6gOwGV+Qa6fzy0QyMXr0c1p3YugdYHx9EdZM446kvNwRQw7Tx5ghilrZhPdN
 LPjYB6Ot2h6QPvmZkB3llYZH+jXUmgb4L52iVJN/9+ZayqXpD5pE9OLwQghm/gml1/F1p8uZ0cJ
 GFqUiSgzcScw7HzVvBNI6zLE9HTEw80atqvCVoFd18mucV0qJiF7eIEBHRh91StVAyR3wEOgPpG
 9Y4q1qdF+9o2OMjb0Sxkp8jHPMMakyHXmr9jKfu4fLOseT2UzmU=
X-Received: by 2002:a05:600c:468e:b0:495:6a50:3fb8 with SMTP id
 5b1f17b1804b1-49987944202mr352204535e9.1.1786970916297; 
 Mon, 17 Aug 2026 05:48:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d11f073sm45267635e9.15.2026.08.17.05.48.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 05:48:35 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 12:48:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
X-Gerrit-Change-Number: 1772
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1772?usp=email>
X-Gerrit-Commit: 16f746e22115b096bb1e6f1723cb4f63f0f6885c
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 12:48:33 +0000
In-Reply-To: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
References: <gerrit.1783600902000.I61762374c141662d596bbf88b64ca7f7472b5149@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2MTc2MjM3NGMxNDE2NjJkNTk2YmJmODhiNjRjYTdmNzQ3MmI1MTQ5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <273ba43d43c9b0c71036d2215860c6315375fad9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvwlf-0007Ae-UT
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: options: Factor out
 options display code from options.c
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
Content-Type: multipart/mixed; boundary="===============4499764241946951253=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4499764241946951253==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3fIyZL2afyQ="; charset=UTF-8

--3fIyZL2afyQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail )

Change subject: options: Factor o=
ut options display code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/o=
ptions_show=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772/comment/10=
76440b_9cbcbfa7?usp=3Demail :
PS3, Line 29: #include "syshead=2Eh"
> Lookin=
g at src/openvpn/lzo=2Ec, it unconditionally includes this header=2E comp-l=
z4=2Ec does too=2E [=E2=80=A6]
```
$ git grep --files-without-match syshead=
=2Eh src/openvpn/*=2Ec
src/openvpn/crypto_epoch=2Ec
src/openvpn/options_par=
se=2Ec
src/openvpn/push_util=2Ec
src/openvpn/siphash_reference=2Ec
```

The=
 tradition is definitely to just include it=2E Only some very reason files =
dropped it when not necessary=2E



-- 
To view, visit http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1772?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ger=
rit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: I61762374c141662d596bbf88b64ca7f7472b5149
Gerrit-Change-Numbe=
r: 1772
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: M=
on, 17 Aug 2026 12:48:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: N=
o
Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--3fIyZL2afyQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/options_show=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1772/comment/1076440b_9cbcbfa7?usp=3Demail">Patch Set #3, Line 29:</=
a> <code style=3D"font-family:monospace,monospace">#include &quot;syshead=
=2Eh&quot;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">Looking at src/openvpn/lzo=2Ec, it uncondi=
tionally includes this header=2E comp-lz4=2Ec does too=2E [=E2=80=A6]</bloc=
kquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">```<br>$ git grep --files-without-match syshead=2Eh src/openvpn=
/*=2Ec<br>src/openvpn/crypto_epoch=2Ec<br>src/openvpn/options_parse=2Ec<br>=
src/openvpn/push_util=2Ec<br>src/openvpn/siphash_reference=2Ec<br>```</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">T=
he tradition is definitely to just include it=2E Only some very reason file=
s dropped it when not necessary=2E</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=3Demail">cha=
nge 1772</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1772?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I61762374c141662d596bbf88b64ca7f7472b5149 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1772 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 17 Aug 2026 12:48:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"disp=
lay:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div=
>

</body></html>
--3fIyZL2afyQ=--


--===============4499764241946951253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4499764241946951253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4499764241946951253==--

