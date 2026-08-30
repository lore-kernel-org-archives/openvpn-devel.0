Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B89C61DB9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 19:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YSubD+CdmHzAEbg9f03b6pyZ2NrOZuWPMvqh5y5SdtU=; b=ZerGms1qJRKKpqc+M0Vf/B4COt
	qDnIe9Wkd3Hp0X1/q0PmMaipLr51/XERe/xEEhNwSVMZRkLcHImrQdeqR4ACvJirHm4kwHDdIoUIz
	o8f/quki5GJlMzK1xaCqhmtZc3dvHVmLyvzAOyNNfDtsK7x9dys/q/XvtexYYJ/N49Fc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0kn7-0007Dp-3j;
	Sun, 30 Aug 2026 19:02:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0kmm-0007DL-FS
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 19:01:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zld1LYbNHTLHeHMCpVQgXVwwdPHTzMAQb19wPjPnAHg=; b=Yi1w+UnLSXbDqG36dcXNBm/heE
 c4QEF6BuP/FC4UQuDFDyZ9yFunfaqIUQdpZk14KnqXAUmKiH5GxjBrSgvLREWf/4B2nakL62VxpXk
 M7x79NU8eoROuNVP7yM5iSAXyADisbKfBpkF46DHO0FPeN5PuUgtBNNa7k3XxxgLKW68=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zld1LYbNHTLHeHMCpVQgXVwwdPHTzMAQb19wPjPnAHg=; b=O
 i+QrDMqQpRYCUMrqmxqhiNCtmgKPlmznspVJ58fklAN8x/kSjIXl8L113a+elDRhtDrJU698wFhPO
 Na7Uevvo61j2EV5c5NJwJTO/ATdi1zAxAh/lHnWTVsykUH1AwnQl8QguoLxTVy8oQTbjmn4dUIM/g
 49OG9e+C8FfZuwh4=;
Received: from mail-wm1-f47.google.com ([209.85.128.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0kmh-0006Ma-Oz for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 19:01:41 +0000
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-49b392ccaacso37186295e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788116493; x=1788721293; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zld1LYbNHTLHeHMCpVQgXVwwdPHTzMAQb19wPjPnAHg=;
 b=IvLbHRYf0DdGR1sTeYL2uTz/nDHlL+c+mfhpLb0vMVh6ZJCt8QpZR8I0nPO9g0Wrzk
 deqDsT0swPzmAWMROBbXGWdEj+GBA2YrHtANjA3+IzNV8TGLWZ3LVpBYCDP9EOqbL7qg
 DrF42TT4tMjFAr95kGVES6IuNG78mm7O19wB08UIcnudZgip2WgVBzyuSoIbndzFL13H
 pTj2VpYff9V9zcxAz2WFt9Xx2luuHDI5mEQHZORMz41f+WHhM3G3lcoiYaGMto2rnzxA
 ic/i7mVliRTgnbssWRSADpEqnhmSfxLLDWEqWQNIOfBpWAjkX01A+ZXVz1U/K7sZzMbG
 MB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788116493; x=1788721293;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zld1LYbNHTLHeHMCpVQgXVwwdPHTzMAQb19wPjPnAHg=;
 b=IuuLLZjb+aYVfs4sywIU6qKVDCVmueDXkWIDLmFWc5GrQlMybG5mkgBFzY+0GPiQek
 3Io0gj50a59vGFvqSY84NCqb9MiS/NCIvb/Rp2pBsXtcCLkqpnZmtPeGglQlp7FW1v6y
 XyS3hA9aO6Q1sVRz7/RsZXfSNGG6ZRVzn6XFeWXK0xIF+In+BZLyAEgBTqThxTacoeOr
 b18hu4JIq3DtATkHCkPHkbmEmGyvTv1Ve91azHS9aOMf/b6unTstdPp28N6DrAy4G75c
 8W0dAH7OQtCdX+l7YHtzFs3AimmrvOn6BFo1q3FL7Likw/1mAMDYp2q2+sqtIRqu/6hD
 brzg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrxkESIF6f+UXfUxMvatCdYK5JW1nBlJrTfQQ1ClRSnOCinkskKEE7OP8QBhtrbNk0Y5OIg4QnmadECCcFf@lists.sourceforge.net
X-Gm-Message-State: AFuF++lOQWJ/loIIoIxgFmDoz7RJ6vNVPLmLPWBAuw7TWxszShph/bCN
 aPOYMNppB2UBRpS+HIcbIuG4iXA1y3oEskcCEqU9/CB8w/WEIcswTDLEUOn7s3ZVGXPMen4cOnV
 TPJdkK/lpgwB/fn70R2nuzle4MW2eoE3Fa4Mg+mJO/f7Dji/oUNLq+cN2rSQdros4xkdG
X-Gm-Gg: AR+sD11/jSDRBgE8G1aln9PJx350BlHODEtXxc9Y8pVzL8jaIRGuLzIVPx5Qh5uUzTC
 k9lzVYUyD7JumrX9JE9q/YuYvFTaoh07iFz8XM8mQxi8xyh9g9uc5OUCkdCbXJ+Ol4Yvzs7TkOU
 6c+2xeNR0R4JVywXoOpbthyvV+nzZwisqfNaOvQbW3obx/WPBUeYh7KYy+EdLFqr4qMGq7omwVl
 ahIm8xjU3az78ahrv3G1zIaEYQrIjI+0YMU5vY4YoH3L6YjWARM44Q4Kvp+HRExXowS274r1WnR
 3DaLPu1q5pSIgv7pyqI6ymouzwWRdhND6HgF9gxk7kwipv9cRPD6JMqFI12QlTM44iR8S4vrGw8
 +gDqAkx8RVdlDBjnCvNXZ1xctwoA00eJRiBbZYPDQypq1CnWUzPLa1KjBPzqxlajNg392v/ZEsp
 1quErfmp3uOhNds5XH+AHe4a96IAjKSGcRLLAAYaQak8p4miK/J4md3PQSlSyAV/8BfvbUbwpj6
 aaxgLvBnx0+bBerdlrnRNm+LERjVwEbPLeDtF6L3FDQP136XZWdEwte48qvcflLqL09p2bOvTFG
 3T1D2UO3IKUKFscCHKCKl+Lz3f+ovKjOzBcsoABz6LV1wkPBGUY=
X-Received: by 2002:a05:600c:3f10:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-49cd01972c9mr134279705e9.0.1788116492996; 
 Sun, 30 Aug 2026 12:01:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9500c7cfsm243672925e9.11.2026.08.30.12.01.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 12:01:32 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 19:01:30 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 17
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: 0866f76a03f9284abd418b91ca1933a513d4cbc6
X-Gerrit-Comment-Date: Sun, 30 Aug 2026 19:01:30 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6e684ed85caf68ad5c224ba593a396a695e17025-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0kmh-0006Ma-Oz
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
Content-Type: multipart/mixed; boundary="===============4784626185773563811=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4784626185773563811==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v2BD2W7waA4="; charset=UTF-8

--v2BD2W7waA4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change subject: Remove instances =
of constParameterPointer cppcheck warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 17:

(3 comments)

File src/open=
vpn/mss=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/9baf02=
66_4a84e46c?usp=3Demail :
PS17, Line 150:     struct openvpn_tcphdr *tc =3D=
 (struct openvpn_tcphdr *)BPTR(buf);
For this function and a few others doi=
ng this sort of thing to the parameter it might not be ideal to constify th=
e argument, because now we're pretending it's const when we're casting and =
writing to it inside the function=2E


File src/openvpn/tun=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/4907d4e9_173ee7aa?usp=3Demail=
 :
PS17, Line 3253: read_tun(struct tuntap *tt, uint8_t *buf, int len)
Shou=
ldn't this (and the function above) have been constified as well? Do we no =
longer build for AIX? If not, should we just remove all the AIX code?


htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/1c2639ef_8a51a659?usp=
=3Demail :
PS17, Line 6310: read_tun(struct tuntap *tt, uint8_t *buf, int l=
en)
Here too, this function and the one above have not been constified=2E

=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I56248cf6d199c2da77=
0774b8fd1e5daf2b116f58
Gerrit-Change-Number: 1663
Gerrit-PatchSet: 17
Gerri=
t-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenhe=
ld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Sun, 30 Aug 2026 19:01:30=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--v2BD2W7waA4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">View Change</a></p><p>=
3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/mss=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1663/comment/9baf0266_4a84e46c?usp=3Demail">Patch Set #17, Line 150:</a=
> <code style=3D"font-family:monospace,monospace">    struct openvpn_tcphdr=
 *tc =3D (struct openvpn_tcphdr *)BPTR(buf);</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">For this function a=
nd a few others doing this sort of thing to the parameter it might not be i=
deal to constify the argument, because now we&#39;re pretending it&#39;s co=
nst when we&#39;re casting and writing to it inside the function=2E</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/4907d4e9_173ee7aa?usp=3Demail">=
Patch Set #17, Line 3253:</a> <code style=3D"font-family:monospace,monospac=
e">read_tun(struct tuntap *tt, uint8_t *buf, int len)</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Shouldn&#3=
9;t this (and the function above) have been constified as well? Do we no lo=
nger build for AIX? If not, should we just remove all the AIX code?</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/1c26=
39ef_8a51a659?usp=3Demail">Patch Set #17, Line 6310:</a> <code style=3D"fon=
t-family:monospace,monospace">read_tun(struct tuntap *tt, uint8_t *buf, int=
 len)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Here too, this function and the one above have not been co=
nstified=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">change 1663</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail"/><meta item=
prop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:=
none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I56248cf6d199c2da7=
70774b8fd1e5daf2b116f58 </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 17 </div>
=
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Sun, 30 Aug 2026 19:01:30 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: No </div>

</body></html>
--v2BD2W7waA4=--


--===============4784626185773563811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4784626185773563811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4784626185773563811==--

