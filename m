Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50026C54F51
	for <openvpn-devel@archiver.kernel.org>; Wed, 29 Jul 2026 14:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nT6VlWN9/59NfFZ1nG8E6BTEUxGvAXyBB8nMLDRUps=; b=k7mLKV+zoh3F62UUxxvoWJI+tl
	Dg9lxKXuM0Ry2NAEjWurvLxtwo+P3zf+PCCJ1dGZXbxL4DLupl7sxJuEGzEQKWt16A4VL2r5qI0/i
	x5iq9FmXj23Hv8d1es6h/1MI6UbGTdVrm2QH1puFpz99IyiMoXweOBQZ+rez0kg23Br8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wp4uH-0002wG-QY;
	Wed, 29 Jul 2026 14:05:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wp4uG-0002w7-JJ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 14:05:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3U21tPLh0RD/DURCye9METT8yV4Gjn2qgCQisTU7cOs=; b=dOs75u/AJsYJm4e06w3Ffy1Xgo
 vwbIL3Hwklx/cfiHETPjvEbANx4lfdernr1eaGcz0/A/C/nDVkWLGYnhjZgADGEeiBryFVGjl64FA
 h6c1JKOaWdhpJV8tc7NmerORtSVnCDJzFOT5a/a4BjfnDrz8m43kuFbOd74HRftkJgW0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3U21tPLh0RD/DURCye9METT8yV4Gjn2qgCQisTU7cOs=; b=U
 LDBt/R9mQcQwjAtFGFJAj76/o5FbJz4cwYter8kgZiTRkIhyP0djPYxrlCncZ4+c70ykp0CtOOE+c
 atLm/341BttzNyqQiYh5XX3YcS91TksEaIgAT/ixauLQNWxY059K8qt6NNj7t3DBRIgRt0Yv+jpP9
 uzYkg4bomk4MlDNs=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wp4uB-0000E0-Vo for openvpn-devel@lists.sourceforge.net;
 Wed, 29 Jul 2026 14:05:10 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso11213575e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 29 Jul 2026 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785333901; x=1785938701; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3U21tPLh0RD/DURCye9METT8yV4Gjn2qgCQisTU7cOs=;
 b=fSapGzlydgUWlTgOXqh5meF7/vv8goSf5ryTHyADNhJoHXGBQnP8+qt4SgnhKqRVJ8
 BGiYNTcdVg9Z5MBk6GHEO38UCoDdOmkUDnBOXmE+YyW3s0RCmr0NAgd9OIvZHo4xYQm3
 iBsD5Rn/g+n38mXmgWOz+vzUhHX3iTUOdE7ewUvArJdcouLRF62cSrNU2VN2wrVDFWii
 MGfoIcIWAEW+PD3yERd9mvv61px8wL1zSkxcUunWUbpOCZpgguG8r7o7ITBzlwBYY7Iq
 V22g7pI+nRpImO+yHjUqvNxuwQE4B7OYkHDftRIEOQl9bmD6qK6bsn5r9UPgyMAEt4z6
 rTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785333901; x=1785938701;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3U21tPLh0RD/DURCye9METT8yV4Gjn2qgCQisTU7cOs=;
 b=J2EuXlPFGknVewxuJHILCimVDTPHQin+gYPfhJ5bXo48AwThxldrNwMuMI/ny9AnIB
 mMA+qIZPUfmA1j9awpqdBMBWv1IuW/tlSK/4O/PW/GCp5qYC1IXdZy5MmjoRnj6KVPaJ
 VzqiHk9UrXFVCUHumcwOJPEiI2G0tpjwvL4AC3Ny1peO1TUhaGQsBcfQo9jsTJWDY52Z
 1QKvFPqT0Cc+rja9YVh39P0bazqnVrkqAfNzyNRlAHkWCO0wusFIxX55jSCSjmL/+OPH
 m52PQcNVJ10mpKrkFpEHaEdAjtLIw/b56tDco+/7SOaJrkN9hRTeod3kzkGBzqw4Dhjn
 +kkg==
X-Gm-Message-State: AOJu0YzdvWeL8qbHVKXx6QJJHThFf7eZtvQ6xPXh17rcfWUD5AcgR6uK
 Slf6igmziww5nBTHlyr5XyUeYDq8JJt2Mrchg90oK2Kv9OR33fn0iMzp70/SEP0BAVNlX4nvrZj
 rWLyUkzWgi6I3nReD+v+/EGeIyanG01qusV956GkES9E3wh46yre4JZ1OJkk717RH5h9M
X-Gm-Gg: AR+sD12mkSNhujONwgFO0kFJwhWbgVrQxOil9kK29hwL0u/pJy5GmhSY5/lmTMVOXwQ
 NCi0KdQoxE4aA4NMHm/NNxfNVRpFgvQKr4l4iwdcM1PWlfmSSxb/3XxqDGqkDKZVMJlQfSE/KB5
 qJgNyQMSybHIIszIS+zCuSK4p79LkVPWuvieFFhh2l879p5aq4BPY32A23w1Gw+KLR3AMM8jd16
 FETvetOrnWGxRRpMOBIGj9o8dAPJUSAl2VxWyrBieos0+ylgz7KbCacAHqZBtGZkS+MdQ6juSNJ
 0f20QYpfqQZ8YUoYg5bahzf2iRMqBLUdvVL8AqlCYbTMUuAfP012N4YV3y1Ybpm36+IG1QGC8LI
 WvIEMeE4K69igHfr52k+RM9xZ4Sg6Z8YO44KdJM81+tKZRfB7VO8mbwoAQ6gArwrgDSgBL0xWT2
 KZfnuoiy6cGYbOhjTbpHiUHbrMiuHGiUrsphXwpW+YjWT35wlTopqdi1ap+fnNI9HkFq2wnOZHg
 rWZXlrBBvwgI6NqUwO/3JelZcSDYdXzesZYgy/LyyOA0PFqItYo86ZooyzakEMuSRvRBAvQExb5
 g757FlZ5cukdDLgwxAOIEoftsW7NEAmclC3iEi4XIjPEDfL8MtA=
X-Received: by 2002:a05:600c:3586:b0:497:fee2:f54f with SMTP id
 5b1f17b1804b1-497fee2f555mr12621005e9.28.1785333901233; 
 Wed, 29 Jul 2026 07:05:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c4632263sm171124765e9.15.2026.07.29.07.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:05:00 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 29 Jul 2026 14:04:56 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d
X-Gerrit-Change-Number: 1571
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1571?usp=email>
X-Gerrit-Commit: 856ed1b248f7eaaa70f87ab69bbdc1f2cbec09cd
X-Gerrit-Comment-Date: Wed, 29 Jul 2026 14:04:56 +0000
In-Reply-To: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
References: <gerrit.1773251317000.If47c7d920b2fa4047b7db03fcde821899839324d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczMjUxMzE3MDAwLklmNDdjN2Q5MjBiMmZhNDA0N2I3ZGIwM2ZjZGU4MjE4OTk4MzkzMjRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4bb907161fe50d288d4bcb3c81cced612018f598-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wp4uB-0000E0-Vo
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Change hash iv to a
 be a fixed sized array
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
Content-Type: multipart/mixed; boundary="===============7638951066330066000=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7638951066330066000==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TqAMgG62J1A="; charset=UTF-8

--TqAMgG62J1A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1571?usp=3Demail )

Change subject: Change hash iv to a be a fixe=
d sized array
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 19: Code-Review-1

(2 comments)

File src/openvpn/list=2Ec:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/1a426261_45a9bafa?usp=
=3Demail :
PS19, Line 425: hash_func_new_ctx(void)
forgot to remove?


File=
 src/openvpn/multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/com=
ment/1b99989b_137b6581?usp=3Demail :
PS19, Line 313:      * value and funct=
ion for the context parameters=2E
comment is obsolete



-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: If47c7d920b2fa4047b7db03fcde821899839324=
d
Gerrit-Change-Number: 1571
Gerrit-PatchSet: 19
Gerrit-Owner: plaisthos <a=
rne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Dat=
e: Wed, 29 Jul 2026 14:04:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Label=
s: Yes

--TqAMgG62J1A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 19:<span style=3D"bord=
er-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgrou=
nd-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1571?usp=3Demail">View Change</a></p><p>2 comment=
s:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/list=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571=
/comment/1a426261_45a9bafa?usp=3Demail">Patch Set #19, Line 425:</a> <code =
style=3D"font-family:monospace,monospace">hash_func_new_ctx(void)</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">forgot to remove?</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571/comment/1b=
99989b_137b6581?usp=3Demail">Patch Set #19, Line 313:</a> <code style=3D"fo=
nt-family:monospace,monospace">     * value and function for the context pa=
rameters=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">comment is obsolete</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1571?usp=3Dem=
ail">change 1571</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1571?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: If47c7d920b2fa4047b7db03fcde821899839324d </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1571 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Wed, 29 Jul 2026 14:04:56 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--TqAMgG62J1A=--


--===============7638951066330066000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7638951066330066000==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7638951066330066000==--

