Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7516C44515
	for <openvpn-devel@archiver.kernel.org>; Fri, 17 Jul 2026 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pFO45AHePYVUQX6zX00ufeE5oA73qvtvF5j6/VPCsz4=; b=jviZIkTye1gpW5ZHymze6KV+MR
	UtHYqsnJjuFxUurvUJZKtcoeq8X2Uf8S2KXMRJCCb+zCvrhDO7dKyJ3ZLsx58f4hn9ZgjQQouMMNb
	ASBIT2f5daDyMwo4SowEi24io8ntoOKBHNnuE8xG57r0GmW/VoG5iI4Oo8MiXN5BX/qM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wkpy7-0000vz-Cr;
	Fri, 17 Jul 2026 21:19:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wkpy5-0000vr-IJ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 21:19:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4tHUkoaWDZm8JpBLwlVUpvk+ndKF/AO7Jyd3StBo8rk=; b=abfYatMvL2f1pyzZx3uTas8Vwt
 oJnREozIT/OsZwWSZ+U2sfhDcm18SNNjpBc4y491urixhVyq1oYlJMrkm9KQOGYejeVB3OiDaxRPV
 1Q5ZSTt6dUOi9uoqSRkT7eQ9Nv7oDWLcVyK6GBpuJ5uuKd55UGvGoCgJ591FR4dsOQwE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4tHUkoaWDZm8JpBLwlVUpvk+ndKF/AO7Jyd3StBo8rk=; b=S
 AmUzWvS1TJp4HaF0cVwA+6rCdmCu2aMsy0FCo+g4+PlVKrVASZJ7Q7nGe/9dh1Vlk7l+/+liJ2MIx
 sFfPKxdy4BlKeOxFc7GOkPhE/zC6DvGVcQTXsQKn5fc5mjCtTKz0ItoIUFFysHTwxWXhKHK+m1g8T
 6aqwbu4dHcu1WiU4=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wkpy1-0007ES-Ex for openvpn-devel@lists.sourceforge.net;
 Fri, 17 Jul 2026 21:19:35 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4953ddae026so24083845e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 17 Jul 2026 14:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784323167; x=1784927967; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4tHUkoaWDZm8JpBLwlVUpvk+ndKF/AO7Jyd3StBo8rk=;
 b=D1qE/esiD/A7w0RH62ib7R7VR3ObCwz2wHElQXTKtEewJdt5vmavXGWQKdNUwCU/YB
 s2uTIIN2gCbXW6Zz5Jm4fcMC2y8I4tCeU5Y40e04LkoQTHWo8lAQiLAyy6bEQE7RZuxo
 Mp4Sbw/GcfIVcr80gNrdwrsVcmZOzfCZOB5+DhjRS8QyF7uDxm5aG/5YQS9xRcrc+mnO
 f1eASdkuFXqWFEbm5V++mb0JIbKBqJQuyr777gMqCIhDFFZKmUAXzwBPjdT+4UEHbbzF
 7JzoPUnx61r176xcBAKJLJOVjkbQ5EHah96S4AE5HHnIZQhra6O5lmuRtC9gaHtyHlEM
 YhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784323167; x=1784927967;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4tHUkoaWDZm8JpBLwlVUpvk+ndKF/AO7Jyd3StBo8rk=;
 b=NmG+jGiWIDJBhDELyh2qMj7LI1s80c/SMStoPlYupw/dpsEy4dsgi9Vk0Np38XJQDr
 6X7OAaF95nSS0Ua91WdN6pt3+F2rX0zbiGDNIVPAfQ/Gvma/ZC86zo+UeGrfG9xQtC6w
 6Agc4DC8/mAVWp50qIX6bpMwB5JDmOV35dL8OVajWig8diOxviRU0gcfu8cgZvO0+AAq
 dtygjyflbURPBBsYTMC3WxXmUBQnBeeT7QZWhFoLGn93rrvJOp1mIWy+gGoQTva3Qu1K
 moRjXxC2A1X252PR7juU7h+s8BNzJa74xG4foihTGtH5YN5moai370gWhXyov/qh9qAm
 c8Ew==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSHXt7zhwGB5oo+EdkDti/jaadfZ66gLmTfGpqdeMo/+7TVspIHZmtsmZ16bsYyTVj19KYQVjEyPDqTi+w@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwO60Nxw2hc3inEZIdQFOhIJNg/XZ8YT7WM34tUCz385SSdfYj1
 aGO+GOuq6b9UukrNwoq1qoKFJ8cMMeTP3Jl348lNN6FeGFnSlkR9Z3tuovMQOrB92SbeSSkRWXJ
 r9MSPZV084ny7O7gqPDDKLgn2da4NM+p+VHSPUSJDS5u1jkD76DoHaM0Hbbij24pA3+Ep
X-Gm-Gg: AfdE7cmksqA6WJuIQ1tDUw7DJjdBcL7NdfMITrUeHjx/c3tS0zrsU16JTbWF/wBN9L/
 DiM+C4O6MjCIMwx28rywLcrB/9+6IwJr5uBLa86qwFkDHlCRv9UpDas6H72R/pQgCzlL7KgJGEV
 CSHmZC5spcyNwo6W7Btn6UaoEwfny/06jrPv6lAmuS9Pbp6xCCvTkXV2lKBVHYUcI9nrmeI4FSf
 EjNyk+MC8jQN3oWMyISVWwmakvRXfVRsIEuLNVigCdhknKhIHjvsTQ+crnG9Q/BrQKVpf+goFcn
 BtxcSxexuhCjWIvvheGDEBXBuzLS/VDqZ+c/e1bnowy0+7snvgTXDrBuHP7eMPJaPHimXjhyRzl
 KrzYfShpVCvxZgkM6csNg9g/McVW9Xo0A7QQiL6JHbH+vpen82Ot3QAv8uJzo6RlsUR87aKCjye
 FGlPP62fvHY+4WbBtz3e//FD2oWMT0fO4g+qgZRqZoaXTslmunaSA0LwTeL9O+shRv6AdgdcLUb
 vqW3qSddXpemHLnMAPwssXYwBa5L+pSMbZKCD2ugXtJw6ejNUBQDAXoFNZ/Yv68lAva
X-Received: by 2002:a05:600c:6a0c:b0:493:a5d0:d1a1 with SMTP id
 5b1f17b1804b1-4954a40bd0fmr36619055e9.31.1784323166783; 
 Fri, 17 Jul 2026 14:19:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3f07esm73977445e9.6.2026.07.17.14.19.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 14:19:26 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 17 Jul 2026 21:19:24 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 18
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 71a6b89896a36a08adac3b61bcccd949bcf149c1
X-Gerrit-Comment-Date: Fri, 17 Jul 2026 21:19:24 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e94ef3038bb4bdd6dbcade446d02fdd045acdcb4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wkpy1-0007ES-Ex
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0652116424420294853=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0652116424420294853==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NScspypyNsg="; charset=UTF-8

--NScspypyNsg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan=2E

cron2 has=
 posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce=
 asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 18: Code-Review-2

(1 comment)

File src/openvpn/multi=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/213f695b_c130=
6824?usp=3Demail :
PS18, Line 3144:         print_link_socket_actual(&m->to=
p=2Ec2=2Efrom, &gc));
this change looks like a rebase artefact - the `rx_pe=
er_id` is clear, but the `mroute_addr_print` parts have nothing to do whats=
oever with the peer-id change, and I assume this is older code reappearing =
due to rebasing context=2E  Can you double-check please?



-- 
To view, vi=
sit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ge=
rrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff63=
9bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 18
Gerrit-Owner: its_Giaan=
 <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ed=
e>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: its_Giaan <gianmarco@mand=
elbit=2Ecom>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Fri, 17 Jul 2026 21:19:24 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes

--NScspypyNsg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan=2E </p>
<p>Patch set 18:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></=
p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1089/comment/213f695b_c1306824?usp=3Demail">Patch Set #18, Line 3=
144:</a> <code style=3D"font-family:monospace,monospace">        print_link=
_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc));</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">this chang=
e looks like a rebase artefact - the `rx_peer_id` is clear, but the `mroute=
_addr_print` parts have nothing to do whatsoever with the peer-id change, a=
nd I assume this is older code reappearing due to rebasing context=2E  Can =
you double-check please?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13=
ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 18 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianm=
arco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc254=
9=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lich=
tenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: =
Fri, 17 Jul 2026 21:19:24 +0000 </div>
<div style=3D"display:none"> Gerrit-=
HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes=
 </div>

</body></html>
--NScspypyNsg=--


--===============0652116424420294853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0652116424420294853==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0652116424420294853==--

