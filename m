Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36C97C982CD
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 23:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y5EmG6O6Y2ReaOp4H3n6CWnp+01HSXNfevywI1EOxf8=; b=mo9TlZzrqXv0R4zzfKxYAERzwo
	zsw38vQe9Z+xxRJtlsx5en89xciDQosZ5iaYuEuT3O8kaXbz8w3CNGPZ4kssHFdeh3zynseaOdwhr
	CIAUpMDIwAQ3AoYR9xW0tHP7yyBKW/sf+2neERrAD4JyL81fS2Q5aRXj6qr4bTzFePDQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6zEJ-0001MN-81;
	Wed, 16 Sep 2026 23:39:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6zE1-0001Kj-TD
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 23:39:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vzJ8ZJwTEmueBTxAh2rM1qOL82yJvc7q4ILcakhwsko=; b=C1jdy3k7G5YTXHUh7NKxGcenSV
 0JO9VlVmwKiR/gGOCekB91yJZ6X5zv/kzCaXNtrs1JZJdKTyznLeUWR/1o5rI8H4U+EwEgOZG9a0d
 KtWsQ+ltvFeh86HuMhNyUnN2kY0g4+qttVfNR8MZP4QuwB52HFKZI+UOCJ5GIa43hwTc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vzJ8ZJwTEmueBTxAh2rM1qOL82yJvc7q4ILcakhwsko=; b=S
 xFNnnkG0qfyI9hmXazFz2B3JBte5Yal1Y/Y7X+QkdcMLS/ONzQoucToc0uEgPpVzx2NKLmhnEATGV
 b8muluxV55MkGhpC4BPgk6bNkSySSZDiqI90VfUjmzgzM8iA3Vhu+H1zYcPT3IaqbD3Tf2QdMV2Ic
 HQa1SARXMyZgbrOU=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6zDx-0003xE-Mt for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 23:39:34 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e71cdb22bso1764895e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789601967; x=1790206767; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vzJ8ZJwTEmueBTxAh2rM1qOL82yJvc7q4ILcakhwsko=;
 b=TtLd4Cqj24Xk4aGN/ToLeY55jKZD+Zk0YyPNuKLAELXRoIW02AMy+IRoDLIYZtMpZu
 gvu4Wu2dgM5uRVX/m25hrJi7ohQOyZbzYwBT/Vfhoht/uisZ2SUYuh8aPTI7+y1Ln4VE
 otm3VKqF9f0Eg0w5EsjUJ6x4i9D65g+qNujOgbmQ2Fa4fLJCLM1Y9LpkR9v/xCXIQc8W
 4ZzGQi2x0fB1J1J4PRC65KS0vxpTynV5nDA/fLLCFHEkbttTCJ2jX0zO2x/Olg21kdV3
 N5o3ZgYV/H1Pht/+JREBPhyuyg/vpXdgIAqyS5zYERNaYqh9OG8dwywxq093M8Yjyd7o
 kezw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789601967; x=1790206767;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vzJ8ZJwTEmueBTxAh2rM1qOL82yJvc7q4ILcakhwsko=;
 b=wmAg/jYxYwfxMYo0KesAKf0c6aAGX2m9CuEqC9r9DM6fNsSgbuAR7Gewrxk8VvB2f0
 hKnUHDTSczNMXttA1K0hdAYK2uJXYFvNvfOkfkAzsgGG0cKwf9vX8Sl5fuSrxb1Jny2C
 3RZwGYAQyCXrBTrONEWtrcLRlpzG9ly9Ol6eGXleTsga30R9CRLc/q6diDJwkGD9BcIx
 N29E3dp+t7MQcb/UtB5rvTDdV8m6oJJdzmWqIDNesfiKKhwlBSkzPGIoUOvXxLLWhfL4
 yhhvMJLml0ncgLgZsiSvmj4SbaX7Dt5NbLc09PVnEvdFQbrP88gAwZ2EjH9Y1r9WcLhY
 /1OA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxAjAIy2QAVzNq+ID5ODhQjGzvrWUZdugEar98LJ+deuh/Sejnk8y/jIu2ceoIlWCmB8F0iLp3P+J+Oc6N7@lists.sourceforge.net
X-Gm-Message-State: AFuF++mtUb5hfI26BgV9SzDOaA86JUsuAx5kss73FOAAmq9/SeODt3gI
 fQKSry3dpldFPpCLSS1XWLIceONujL4Vym9OWxzuwC2Cw+ZH8YhFNwzzMTFwK6Nbqub+Y0Dmj1d
 HW9euliIl3aFWq0kVkZ1pabY8iPCTYrnymnBXC8OzDx1BITY3mFw/9IwLcqBh8jDYjjwvDY0NHX
 We065aRQ==
X-Gm-Gg: AYBFou37j+nBs2K1XYSsyC1bJyR//j+1aq9zSXuBjvDwNWy7vojRpfzs3PQTyITjIqm
 fwSoVZ7BKjw84+pBOmNLQO1O6/vfnCSxLdeMlHwMqsrbEKhMXMavfXvEN9Y26sMoLIGsXusmaSu
 Wcpg1+0N93ZgEWmmIVpM2PvMydERZkEyugeWbux6O9kU5fWB1nnUOoz1SuoGWrohGBDcQ/ByXFR
 vzA85NIDFI8J2fB5fpll/BSlehyLYbCkIdBbXVfgqrEb/Z/KNNmjlM3s1DzanHXDEH22q9tERhk
 ugFweqvS3QTDzVFqbKXjURCpcyr316Tw1GSDaw1hZV/pWhwOugLLxBV2YlMXKleX4UynCm6yTvF
 BQzJnc5aGHQRM3O47pjH38DmABjSAYrnHQTQtwA57ib5e9alrSMuc7gG/RNnLxxgVsr8KJnlwqP
 i/qjJ5433dv0lC2IavSv28olqK5LTIjaelYbYlm7jOwoZTnF0fhh89X2CzNs3mcFdL+C1E7HdVK
 gHFqH7ExgXEU0YWvyBPyjGfTF/5yztktoZoRsmLcNzIixB0yPxspVNSCHE4SdJ/BbK5sps054Pm
 WzpMUiyMMS1NgHoRbwK1Wqd/yY9xZ6w79rC2HBUBaWhrqFofM2HswTnQEvoUueI=
X-Received: by 2002:a05:600c:1d25:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-49fbd1ddf87mr19096965e9.22.1789601967129; 
 Wed, 16 Sep 2026 16:39:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e847f176asm74551345e9.3.2026.09.16.16.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 16:39:26 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 23:39:24 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 3f8217314124701400cb9ce525071943a373e780
X-Gerrit-Comment-Date: Wed, 16 Sep 2026 23:39:24 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e85b59c1d3e7bffe10c1781138cfc0160796c42e-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6zDx-0003xE-Mt
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com, frank@lichtenheld.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7034668653384210647=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7034668653384210647==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uxvIYbxsmT4="; charset=UTF-8

--uxvIYbxsmT4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ralf_lici, stipa=2E

pl=
aisthos has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 15:

(2 comments)

File src/openvpn=
/control_msg=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/7=
0013775_fb1d4853?usp=3Demail :
PS15, Line 77:             /* bytes remain b=
ut too few for a header: truncated */
Which bytes remain here? Didn't ctrl_=
msg_tlv_read_header read all of the availabe ones?


http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1741/comment/9e684786_029ba13d?usp=3Demail :
PS15, Line=
 97:         {
So this API design forces us to rewrite the parsing once we =
have a message that has two TLV and one of them is mandatory as this functi=
on is only useful to parse messages that contain exactly one TLV=2E

Either=
 we should not pretend to support/implment multiple TLV with this method or=
 update the doxygen to explain that this method/API currently only works fo=
r the scenario with one TLV of expected payload while ignoring optional one=
s=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit http://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Ger=
rit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5=
603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 15
=
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=
=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date=
: Wed, 16 Sep 2026 23:39:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: No

--uxvIYbxsmT4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ralf_lici, stipa=2E </p>
<p><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a>=
</p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Ec:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741/comment/70013775_fb1d4853?usp=3Demail">Patch Set #1=
5, Line 77:</a> <code style=3D"font-family:monospace,monospace">           =
 /* bytes remain but too few for a header: truncated */</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Which b=
ytes remain here? Didn&#39;t ctrl_msg_tlv_read_header read all of the avail=
abe ones?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1741/comment/9e684786_029ba13d?usp=3Demail">Patch Set #15, Line 97:</a> <co=
de style=3D"font-family:monospace,monospace">        {</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">So this=
 API design forces us to rewrite the parsing once we have a message that ha=
s two TLV and one of them is mandatory as this function is only useful to p=
arse messages that contain exactly one TLV=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Either we should not pre=
tend to support/implment multiple TLV with this method or update the doxyge=
n to explain that this method/API currently only works for the scenario wit=
h one TLV of expected payload while ignoring optional ones=2E</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"=
> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 16 Sep 2026 23:39:24 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--uxvIYbxsmT4=--


--===============7034668653384210647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7034668653384210647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7034668653384210647==--

