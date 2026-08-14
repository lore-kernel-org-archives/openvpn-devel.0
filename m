Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 741EEC5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zTShVflZIh7sZI18x8haix8nft0mB5w0EzxTSklS1c4=; b=VsYeep24VP4EKKcSXvZwrwhd4f
	3fNNqiZ9N5rwjBBMbvUJTdIuY1kS5pSI0/aFYNOVf41Lr6oDHFDucNGZAN5ct5aMxkdCmQA4pWv2h
	fk8YBiCW03DTjZAP5lmddCGXeNo9k1s+G+RlIo9eK4oMUdIkW25SIi3eyOczeVz41Cpk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wusou-0004HY-Fg;
	Fri, 14 Aug 2026 14:23:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wusot-0004HR-3o
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 14:23:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=b8Buf8klncsSQuz+lPOYGst8I/DkqSsqf24PLLXKP0g=; b=VhSxTBOZap4bnLz55MCw47BxPt
 1WVvsDhiWuBz9IV6Wo2UlGDBfaF/cF8XgtLuuSA1SW5ugKZXFhE2dhCqyb3YyAFu7045KsHYkMlHe
 uLN0QvMQzije4q4Fog7L0B9zO/mkVWSBXnTi6MDYqaYWISYDP3HETOIOcHJjk/KNGDGQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=b8Buf8klncsSQuz+lPOYGst8I/DkqSsqf24PLLXKP0g=; b=N
 34mH0zep4op1n6MEoDfU9JJ3aRcKE4qYCCuONHxNiFufFKqKI+yTA+TDIAh4LrFRyh3K/zKqfDsSt
 n3HHIfPaNzT70n2Y7C6iHu39Nf3PDnfyInjkRzjZk0IDaV9zNB8/RgMNpuDpi+1SwGGjn3dQI1WY9
 rR8INHRKpRG/Twc0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wusou-00031P-NG for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 14:23:39 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so13514385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786717411; x=1787322211; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=b8Buf8klncsSQuz+lPOYGst8I/DkqSsqf24PLLXKP0g=;
 b=W4Z5SkadclbXo+4fFeyoxlhEMfmCgbo5xqS8QyI5/vFw8N7+B+KL6gb+G9yTFSqwI5
 x43HEmBNe0VX0ldvFA2xh867N69PMuyZuZmCAEcsbvc7BawqPDWmnwz6aunGB/ODGzJ+
 nlrUubVoRqAyAS+9FCmC2mJm6WX1gNfbhW3en2E2w6bGOjAiNRPxlOkdIuMFc2ybKC8W
 rQFwyXzgZAvQCQdB7XINdoedXvX7Jy7wtSR2mJcHFXvSKMXzBpkY+UevRNbhzTtgh7rO
 Q6iV5Ni52Flhzo1iEbqZBaUVNcgrzuMQvNuerYbaFNibFimbK1YapP0psEbmejYf51Rb
 /Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786717411; x=1787322211;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=b8Buf8klncsSQuz+lPOYGst8I/DkqSsqf24PLLXKP0g=;
 b=VSw9kFr64Q+coAwFTHQgeTr2pK7aN9d+SA8EDhHrGmEzfKtcs2ur9aasuJs+V+IHc7
 m9HHx129ikZCaOzWHjOhRyYq1ROSjLrwHQj4qfe5ivm2trbWqvAk4gWy4YVvMVmItkcH
 AkepO5u6wDnot2fK8tO5D7YUN2wd4z9AZ2/m3AF/ogvVnuXClndeyP25Fu2PTJGRO4xC
 1l9y0PT/KQcV1HTBf7AB+JDs5XNlJWoZUIxKlYdbS6sCcbrcFSCh0c+fdLSDMQCsdKQa
 plSsTcnXu7ymV4t4W1AMLzjizK04pS2MXSBBTOamcAZV6PivbMRiFQDPqBNj7TqbB9dG
 FPvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDAz4bQmzGFakcpHg/aIXv4xuOqPMzvGuePvU8nMpqFRExJrK1D/LhQvGrAp3H586vTfI+UmoM4FLNKGMz@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzO16i2x2FHt+XzyCzvbqCoxIKj/X/F2OL1OPrYrtmcTVkrIzvN
 85ewFtps9jNGMkCrurCL4e+0aPZOkjD3nwf+3bdbe9gMOkr98AVRxOygJmeVHYt2cMPHMtBVtvD
 2ApdmVbHpdxvETahdSpO1rqyZ6wLxvJ7Bo7SVsD7xuo8oQwTVJAXT3AWTmkWLtN3CGmxZ
X-Gm-Gg: AR+sD11KF04UVnwjIDeVLAaM+SQ8wl5DQp98/YrZ7tnDtX+cQ82v8vsWjuCF8GfniZL
 ytZ574QzWwDKDntADd5PyrckPv16Sg+EUrH0ERmdCYvutseyMmT6oeEVL2sFsOP8EGFuo2oZMpq
 tJNIQkeVP7FRWSkmkes5k+LIduJSjXRHCAsHzlpkCCR/yByDY7b+tMtDKN9oFDx94t1+a7P/AGr
 t//sbwMGR7qGPIa9XfNJ11X/zmiLewqM7dWHryh7jomMYF0WQ2SyiR6l1P0lRm/B90Ual7XH1rN
 bTnqAULjkCQNm/EKalcjxCosW50wzjHjA431D97XNwnmRJ6I+nzCyb8C9wpecT5NWuAcT0SF0VE
 dxZn/MF+Cnt9CEdGq21kHzpv7lgFbXcutQLfOZPE7/5u5YhbiRVpJV+nxTZjRrHbNHrNkd3mQvr
 0gNDpifXNng4vRvD4XtyKaRzZ0eBJrx0+yrya8fVTiRkcr4WFPZQ+lNlVhE6gs8jJO+qGZmlcUL
 /+2D+yYSJ2uPcoZP21F2Q8Gg7uOJXizFzI5ft5GJsRNAstWMFIAw4raqHDaOjQxTr03LngFbdYz
 ZKnxamNtMu73D0r0FNJjBG2XOr+HkiTNSbNfnzENFVY8sqeCi/ALrdQdcvs7TQ==
X-Received: by 2002:a05:600c:3145:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-49987ab45famr74500075e9.6.1786717410496; 
 Fri, 14 Aug 2026 07:23:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499899c138dsm34875845e9.8.2026.08.14.07.23.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 07:23:29 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 14:23:28 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: d7db979d9a871573dd8a4f14fa9e51358e0ff666
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 14:23:28 +0000
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0fdd239a0c08e075f9b7d3af28c6732f67525424-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wusou-00031P-NG
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Factor out
 file access code from options.c
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
Content-Type: multipart/mixed; boundary="===============0729776398339919588=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0729776398339919588==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LgUxU73e+KQ="; charset=UTF-8

--LgUxU73e+KQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1774?usp=3Demail )

Change subject: options: Factor o=
ut file access code from options=2Ec
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

File src/openvpn/chec=
k_file_access=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774/comment/=
b4866b8c_266b6945?usp=3Demail :
PS2, Line 25: 
Should this header also do:
=

```
#ifdef HAVE_CONFIG_H
#include "config=2Eh"
#endif
```

to pick `ENABLE=
_SMALL` up from?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1774?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6=
dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerrit-Change-Number: 1774
Gerrit-P=
atchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2E=
org>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 14 Au=
g 2026 14:23:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--LgUxU73e+KQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/check_file_access=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1774/comment/b4866b8c_266b6945?usp=3Demail">Patch Set #2=
, Line 25:</a> <code style=3D"font-family:monospace,monospace"></code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Should this header also do:</p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">```<br>#ifdef HAVE_CONFIG_H<br>#include &qu=
ot;config=2Eh&quot;<br>#endif<br>```</p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">to pick `ENABLE_SMALL` up from?</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1774?usp=3Demail">change 1774</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0=
fd5e4b5d81e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1774 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D=
"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Fri, 14 Aug 2026 14:23:28 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>

</body></html>
--LgUxU73e+KQ=--


--===============0729776398339919588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0729776398339919588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0729776398339919588==--

