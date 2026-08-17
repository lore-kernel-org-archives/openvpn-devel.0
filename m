Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DCBC5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eCvdIA2vNZeyJl69T0FKQawfZpRx4DS4hPQq7ca56yg=; b=f5I8POzZhpC3NmMJXUTISHonaq
	G+/2ETSKCa5YV/nfUsX5Y0Z7e7bVNio97J6jnDxHSkxa3ROg+f9buuCgDT+6YOv+egAQ0Ke+fDjxm
	Pz0obEcwAHYnluiujffFcoKeuOmYtPuuTfsXZ6o/H85Oi11h91IVH6PHmt4+vuSM+A+Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvxHQ-00046O-PW;
	Mon, 17 Aug 2026 13:21:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvxHO-00046G-Ux
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:21:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=75occucSEF5DlUKYLiYCHNEPWnGmvGl409KWrxK2ah0=; b=eRTPJIY1KNBDI296XpOsTwjM4h
 b9Wsmcitdc6xfQAmRioMkh9C7srOMXgC9r31KrU/qpXFCJvaRKqLuOTa4LcARvzsvdjOXjZlut2/2
 uJox5/8ybSfIVpARsR5xxoeqO3DUaUPl4zNagKCvjL5rSZ7dUS0tLoRvUIydDBH3a17I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=75occucSEF5DlUKYLiYCHNEPWnGmvGl409KWrxK2ah0=; b=l
 RIOsnWJvQcxVZs+wZIIeUN/BQXfbW7lw3mUH2qNvuLEiJUonFWs7bNEFrtFq+qTJ5JoospbO4u9gM
 3K60ov4Ktt6munCFA6LQ4fpMKP6JK0MrKU2dIHpl+EuWakfcM5YNECrWiStW1xtivt1k0ETBAzBuC
 Kfp85WwprTIIeAC4=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvxHP-0005PE-Cj for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 13:21:28 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so32381245e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786972881; x=1787577681; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=75occucSEF5DlUKYLiYCHNEPWnGmvGl409KWrxK2ah0=;
 b=L2oUpFBNyouncZ3Sfixp4ekEV1gv0nl54Vn7Et3usQm5vaLrt4lSVQUaHxHwsgftNq
 a3QWseDU5r9kbvDQC8B6Ic0aUFBGWVp9KI1+BWHnEZ8i77rkJsaphicfdkCj4FIjtOKq
 muI27Z1mV2fNNuS4rfksUiOsE07XrXJOkeHGVgGxZsK4Q7kBUVAjjTTdXKm9x0FSlYa7
 cZNfiv+qSi4jRIT7kPy7Psav+XX2A3bCz30xNFVScFaMHHgVQ9PSQosd7ucn4OTNIeFo
 xPVVgZuajGQj09Nc8/vdnQv3ToW9DucQd8FE3ZWEXikFOOxBR7A/s4odotu6ZMPlEpAz
 MRAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786972881; x=1787577681;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=75occucSEF5DlUKYLiYCHNEPWnGmvGl409KWrxK2ah0=;
 b=HEfBcQVFxWYdg9NP6P0fumzWdKp1eDwhOkPECHJzG0v2HgitsgRwtNtz+QMGJLXycx
 AOzhpq5RvrTUgCYN70b+z01MEe80uw83r2SE4hLCXNKlIkqRbpa+OZQ+CBkaWOu+5ZIk
 jpo5XeuIcRuFa4lDzGWXJslV7Oos+dPJpdLc8pu6OzTjHPL/JEzIC/1os8bdPkSLma7R
 tF4WeAnAyV/2stemPGqBrE86WG39OoV7cktwFB9hTRN9olhOma2H1rIwLqnFzr+oo10v
 dtUuzD1vH3yw9EUcjM5ZGWSZQuSFdKIXBslGNcvxZVN7wUQT/LrGWoKtiGO8aaFX9fY9
 eA4Q==
X-Gm-Message-State: AOJu0YyrMRJnsdr3NjPePAY3qYYx17hh8m0VhJxtQkmyO0zAz6H2H/Xl
 2tj8cSo5uq9cs8pdbtXKR9amPtzQMjIrXzMb2+Vpdnt8lK9Z+vw2JEBFgUVe5JI24P7986ebEs+
 LnLaziR+ymLBneAX5ek8IKDIt9xqzmrvjKuj2Pw6dXcoGeqH7JjQgZziyq8TT+kGtrJOyzvoMPP
 nwY+ky9w==
X-Gm-Gg: AR+sD12TM53V48ZONKN7nrcLLkcMIkzPp1SwRtmR5vticTNMTBFjbu4r8bYYZCB0PDV
 1GD0W8YfhWboP2ZCe3/7ahEcO0OYI2CNbW1ZeZhJe0pSIFBPrtxUZzY4KE39vChKwWFIeQggA22
 0r6/UOvRXmQZ7mD7rnzL6GJ3Vavq6i4HcMMjC46crRTBzFVCNRUuEH9K3vqJ4emBmi+fTZmZ95G
 LVGlP2DX6GCfYb2O9it4U8YuKIdGX8iCT+HZXfLulM0a7U/cQpSCf9kVuchvddumOaJFlcXH/4+
 gRMDFymfkn+a0njDIGGDLKMPb9ELIwFffzWML1WEcgJcQAtp3v625hl63UWqntCcU25+49IYvyq
 HLSgSZeOrXmEJq1bmGZJaTeObnNkq3ui/NF59b7hgRf9WYzfknH0IlYlI0vAceJqNhj/2gfv+i/
 wagZHWd5dNQQoTi+hZ9Q0BkY/i2e1ss0nQytG+5vqDPA2CxIVXd3t7doGLX7jVCaBm0abXmldWk
 2gPtxgZyLA1zZLEFBvzSZhQMQbTvTUDX6YXgdhG0xTSsncrcTxckJ2kdL2wKm0kaTO+M2EEObu/
 2+4RydaXvUO5CvNWDXetkR133DpBCzhcqD4CNjvuEfbd6cO++gg=
X-Received: by 2002:a05:600c:6088:b0:499:7219:122f with SMTP id
 5b1f17b1804b1-4998792adf6mr455245125e9.4.1786972880034; 
 Mon, 17 Aug 2026 06:21:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4998ca63e5csm105948205e9.2.2026.08.17.06.21.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:21:19 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 13:21:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
X-Gerrit-Change-Number: 1844
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1844?usp=email>
X-Gerrit-Commit: 79f87e8fa83b20485262f5a50497d621febc5e40
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 13:21:18 +0000
In-Reply-To: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
References: <gerrit.1786959771000.Id3c6681b29026c2920a62a0ea570fd098649e197@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2OTU5NzcxMDAwLklkM2M2NjgxYjI5MDI2YzI5MjBhNjJhMGVhNTcwZmQwOTg2NDllMTk3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5f9bc5f740071c4852d0fa1f314c11659b0fa520-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvxHP-0005PE-Cj
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Reduce number of
 future epoch keys from 16 to 4
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
 openvpn-devel@lists.sourceforge.net
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============5404708822558801452=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5404708822558801452==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KAoEFM7vKMM="; charset=UTF-8

--KAoEFM7vKMM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

razvanc has posted comm=
ents on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1844?usp=3Demail )

Change subject: Reduce number of future epoch keys=
 from 16 to 4
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2:

(1 comment)

Patchset:

PS2: 
This now looks good, just a =
couple of more nits:

1=2E I think it's GiB not GB=2E

2=2E I've grepped fo=
r ' 16 ' in the code and we have now-stale references to the old value in c=
rypto_epoch=2Ec (lines 311 and 312)=2E Maybe we want to say something like =
""at most epoch_data_keys_future_count keys" there to avoid future cases wh=
ere this goes out of sync?



-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1844?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Id3c6681b29026c2920a62a0ea570fd098649e197
Gerrit-Change-Number: 184=
4
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC=
: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 17 Aug 2026 13:21:18 +0000
Gerrit=
-HasComments: Yes
Gerrit-Has-Labels: No

--KAoEFM7vKMM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1844?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?tab=3Dcomments&amp;usp=
=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">This now looks good, just a couple of more=
 nits:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">1=2E I think it&#39;s GiB not GB=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">2=2E I&#39;ve grepped fo=
r &#39; 16 &#39; in the code and we have now-stale references to the old va=
lue in crypto_epoch=2Ec (lines 311 and 312)=2E Maybe we want to say somethi=
ng like &quot;&quot;at most epoch_data_keys_future_count keys&quot; there t=
o avoid future cases where this goes out of sync?</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1844?u=
sp=3Demail">change 1844</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1844?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id3c6681b29026c2920a62a0ea570fd098649e197 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1844 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Mon, 17 Aug 2026 13:21:18 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: No </div>

</body></html>
--KAoEFM7vKMM=--


--===============5404708822558801452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5404708822558801452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5404708822558801452==--

