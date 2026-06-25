Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF54CDB479
	for <openvpn-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bQVBCqb7GngsswEUy1prP54Hyuavl6xeaK8M8tOOBTE=; b=Sf/VlkYfLmGM8gzzLRgE0sTjMf
	yHCXjYOX/kL0nNKpLrKsPSG9x7MOq1QEUTAfmvdTuLbLM8zyyjIKAbRUNlC/n1g7U8e4+/iG8lhLe
	Ik0D6er9Iq4bn27uZo+JFkNGoKYIVaLmw8URIa+3SOYMZnU2002jF6KPhAYzRg7HUecw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wcl3g-0002s1-Sq;
	Thu, 25 Jun 2026 14:27:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wcl3e-0002ru-QY
 for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 14:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=WnbPc5ida5sziaXBg+4pZlEyg8deuptg3j4J4wdz0Jw=; b=EBA+pBbAZ/tjsklSyiGO0lt1h6
 yrg7fVJUeStrvEbji4zq0oG1aDzxehi4yOdJQsuvdo+DVz6pNbnJKxKrZwv9jj+mVSW+xHoqSQ1c5
 mDUEpTQlZcatf0tuXl+JhKo5SU7pSCXaf8VqTyF1O/kgqJxvUTjBzWYjWkH7Zy5etjuk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WnbPc5ida5sziaXBg+4pZlEyg8deuptg3j4J4wdz0Jw=; b=P
 SVrajssehALNiKQyVPUvZ5B+saDOSGT+VEQyQlf/WkB7pcFGOPstosQ+9nZF65dNGF6e2K4MeLTuK
 9WfbsILAuNjlKQUrmM9lJwWRP05q2b+yaXbNk6HnkcdxCd31UyXcGl/s51Vx22OOHHIwY5X+qI4ug
 zPU86OsgXmIBKgy0=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wcl3X-0003wE-UF for openvpn-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 14:27:56 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so23024145e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 25 Jun 2026 07:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782397661; x=1783002461; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WnbPc5ida5sziaXBg+4pZlEyg8deuptg3j4J4wdz0Jw=;
 b=QJiGAlQ82ovVL+wDp5s+14wSHg2U1w9ZKYI6+Ol85NC7hczFErznixTMtzJSdu6AH1
 kMS7z3sES/BGg/JKESULE2wFwYJ18vGMphNFTrIxQOv1w/QAKCwy2P+PwgCfgLsk/WU2
 qUVyyEsziiqltZ9OraK4Eav3UeswLi4wypcMMgN6viAQMBsZps9B8OYpAr3F0PJWRRZN
 fsbqMD/2hUmaQ2HQkX81QJa9l/Sc1g6eEp8YitTkBNxSiP3W74oWmbH+hQCFtZjHSiay
 a7nqtExhpjo4CNiibazq9d+CS7eNCjKrREe1TkcfnpSNtznZY5yUqJvXIt7RKV5npJnD
 jj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782397661; x=1783002461;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnbPc5ida5sziaXBg+4pZlEyg8deuptg3j4J4wdz0Jw=;
 b=Wh7ZRNYknDkLbqRRroPuhAQd4iWtbYwtA2hw8iN8JFC565v7IH3Mkot8rMqTTS+zFW
 6zX+KnoRZ8LrbnqHncHxTPE84OVbzBqTLfYR+xzaVorLOVUgkE40uGl8VyaIlb3d1/UL
 YfT7sUeexr0dQYDtqRV5z/ZHmskgPn2eMeNZ7Y49svSBrdGxjlUSNMblTpBpKLOW2j+o
 +h5G+R2XYxrQAD6jQYiC7DlKL++fQT0AnjLUQ5Mz8VKxFwUIdS0LeLuen6RQY9wyDPjX
 En/gtcgY1oKXyAXNWWSDE3G7jPHw2ncH1EI7ebO6pCOJ4LWZSlzopXvbd/LmkVisU0PW
 rbNA==
X-Gm-Message-State: AOJu0YwgzLJy0/JVQq5shI+t8htSWE0i0NI9g04lk6A2ITOjCPrP6ILV
 hTbCnM0+pf2wHAh73y8TuaclK47jeIMo9JC4OFCC/feQx9LecV5W94SoVaQK06bujwrsRQP/Jq6
 JBz20rcXrZJWajJmUmCLRdZofT8AU9qsA8QD20vJENFsgL/qctv3KRej/eHISEexKcSgL
X-Gm-Gg: AfdE7cnmVX7wwzepZ0tPAuQ1XPH9QYqJZdPc+aThF8+I4Kpiw2N9mNw5bk/YNXIqYrW
 s5gbni5/IWee5zvj6VAIxUQP3ocrimha7cxrggIy9nwHmR1sZ6A9tkL7RGhIAntUhDAETXseYTU
 0HMWk6565qQORXo6lYjDZt66jQhoGes5Y/jAuXke/7H5iGsQN9RG+rqqAaKlys/PBu5PzfJGGf5
 ECGDl/IVFkIUlQ0zSt6cQ2bvHnrmaUbrT3rPB++R+Uj/nO9JB1tIbelWbdPMsCxn/VTsCjuNcMG
 YS3IYW+75F/dhW9kEC334G/3zLmVgtDuhXz6zivUd0lnk6fGYzSqy1i6Lh+FExSFu62PqZuhArM
 lRQ4pFM6o2gbf4eSDvzluN0qRFamQbPOk9v/YsMqEusIyasPfaanJWydLH0jFh22asZmOFhIFZU
 PTi9VnLddY8hHC1zgZbNm6oJEOTkOlLZOj49jvyaq740Baexo2dI8cywIaY2PgMH7zKYE4Opszb
 PfmRgWFxruWA4LTcC2VNe1SRN4zhQ4+ELIHu+JOJdWHsArvQUQCF21BWBx1mwZTiJMJdt07bgrj
 /mg=
X-Received: by 2002:a05:600c:4e4b:b0:490:b724:5085 with SMTP id
 5b1f17b1804b1-4926689ab05mr39181155e9.33.1782397660682; 
 Thu, 25 Jun 2026 07:27:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c22c68239sm19418372f8f.36.2026.06.25.07.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:27:38 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 25 Jun 2026 14:27:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I6a032465e66b49ab0ce8b1a84ead8d9acef918de
X-Gerrit-Change-Number: 1720
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1720?usp=email>
X-Gerrit-Commit: 078c63a08ef283601bd9d8b4a7171b47b6ca89a5
X-Gerrit-Comment-Date: Thu, 25 Jun 2026 14:27:35 +0000
In-Reply-To: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
References: <gerrit.1782134588000.I6a032465e66b49ab0ce8b1a84ead8d9acef918de@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkk2YTAzMjQ2NWU2NmI0OWFiMGNlOGIxYTg0ZWFkOGQ5YWNlZjkxOGRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3df5318595f278b1f7156aa846de4f0646e7812c-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wcl3X-0003wE-UF
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 handle_connection_attempt from multi_get_create_instance_udp
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
Content-Type: multipart/mixed; boundary="===============3543034252604069319=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3543034252604069319==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="73VEWZ5eKxo="; charset=UTF-8

--73VEWZ5eKxo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1720?usp=3Demail )

Change subject: Extract handle_connection_att=
empt from multi_get_create_instance_udp
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2

(1 comment)

File=
 src/openvpn/mudp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/comm=
ent/15cab41e_6800b85f?usp=3Demail :
PS3, Line 200:  * It will either to sen=
d a reply with a hmac cookie if this is the first
"either to" -> "either"

=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6a032465e66b49ab0c=
e8b1a84ead8d9acef918de
Gerrit-Change-Number: 1720
Gerrit-PatchSet: 3
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Thu, 25 Jun 2026 14:27:35 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--73VEWZ5eKxo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1720?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/mudp=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720/c=
omment/15cab41e_6800b85f?usp=3Demail">Patch Set #3, Line 200:</a> <code sty=
le=3D"font-family:monospace,monospace"> * It will either to send a reply wi=
th a hmac cookie if this is the first</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;either to&quot; -&=
gt; &quot;either&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail">change 1720</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1720?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6a032465=
e66b49ab0ce8b1a84ead8d9acef918de </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1720 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3=
 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&g=
t; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comme=
nt-Date: Thu, 25 Jun 2026 14:27:35 +0000 </div>
<div style=3D"display:none"=
> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-La=
bels: Yes </div>

</body></html>
--73VEWZ5eKxo=--


--===============3543034252604069319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3543034252604069319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3543034252604069319==--

