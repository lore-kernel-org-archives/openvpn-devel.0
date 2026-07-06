Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61303C43458
	for <openvpn-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pTOr91WDwOPAILtkID0r5o6PWGCAoJdbtbPpQWh5FwQ=; b=QFVZrpRJIFaySN2jIqJoMzPk+e
	DZIl0cjdX8Qlbv6MJG57cXSbGafVgwSzUvcL7jZ12jEB3srvpJM1R7DRuGctwpNbzHNxJ2viED6T2
	pPYsyN5/ak7hu34X05SVuXlg9qBwLuxEMR6X+E0ykhXe33at8YAD9jtNv0cnpdqT5JD0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wgiHg-0003Gd-T2;
	Mon, 06 Jul 2026 12:18:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wgiHf-0003GW-GD
 for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:18:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=7kYewONEIUBfWOZoB0LE7soTGx+kVD37YO/F1oFyJlU=; b=hdpvyJugy4fM6YzZfs1prP2oRe
 rgBuJvDnUVcwL5PGjh0p5UxteXTel5iCHI6RzFvA7eRqc+pNpnaK+hYOYzfzZFbUtQVXJCxbcZ8/R
 BjacbAw+OdowV0qnyRgeg/1X5/7OFYdlha17tGlu4S7kaNfL8ldTsLkww9XBLueqOvtI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7kYewONEIUBfWOZoB0LE7soTGx+kVD37YO/F1oFyJlU=; b=T
 QRDxecUP/wXymE6e4wUuz+GcQXobWLLFOPQjyKkEwT0mRdjwiMMGnMROvc04D3wPcuTVcbFkPl7e2
 vg1WXoGG2TzccQ8D6sH2eYb7biLaNf4+6JSi9QMapB32TJvsxuEG5qgH/QZ3V7pWCtgzTC4sMbiFX
 YV69JDeDtt4vFgl8=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wgiHZ-0003c6-Tz for openvpn-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:18:44 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so32614965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 06 Jul 2026 05:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1783340311; x=1783945111; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7kYewONEIUBfWOZoB0LE7soTGx+kVD37YO/F1oFyJlU=;
 b=EES0U4y3ny45hZh41IokUtV0/cX4B3oU//fET7w6Wlgt2rSwLHrqt45iB+SPhn+p7W
 +fJpS8KrAKeDmDMLTzjCa5LGFeT6of6Cnobbsa1mhMB9SoWMER+KB+NES2J8Xt76Sspv
 PMWnlLKNvt6HHWPQ1wmdlE3WXUvvN84XpkxNzaBS0ZwPKdLk6GXffuGg9Vjec5ibxeKH
 yvIuKiwiKMLnrju+l9ui1ozZF+JUc4MHqjtuIb5r7QNofhfHZ9Hhd0rDd/k4tgeW5EQy
 M1wrC/nlNgaZfT4lLQ1kmScvF2OFfDLwRDKLSlk3IqTLbAsvRs69Ilh3H2qdKbDluUzD
 x1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783340311; x=1783945111;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=7kYewONEIUBfWOZoB0LE7soTGx+kVD37YO/F1oFyJlU=;
 b=BmkBs/k2fRE/Jbj4E8Pv+QhZKsbf4CSdjw50GAQPOwjzP9N6R3bea2opPG8lNEdtLH
 0IK/WYVgoXxV5yTvNGdBouOTeAlFA7FJtHMxlmAiZCx/73SJPDkbPfZ4H1S2XBDjIAAP
 Ck4YFMA9RITo8pCiUTcK4OgGFKsCatGx4ho8GVoKwqgJ1QpMNyp1mDePVlpOsVzR6zn5
 ux2sAvLP1GvlMRlgROr5DwiT3t+8PPIu0hG8ozYEAEtLAKU1AT8rrevEhMs4yYrON6Np
 6MsDKDK88CU3two12VFIrMxP4lLZp2CZtkBsACKrqL/1FVLxvefDoi7wiuHW/CHW5IU/
 fpsA==
X-Gm-Message-State: AOJu0YylkRiJp682b7s8mioMFnQCXZmFtmblEXrm1BP/60q6Qen+vAmv
 NLIwKGcgwdrO7BAFMuDPqJVJF6j4DBIPicbWhofBEx1ZL8dJmLevK8tJ9yLR1zxChpna1fimleZ
 3QzA9RY8ho7cuf5Z6+LlYmJ0UIAvMcrYXQwRQ6GgvUbxKJoyYwTSZexXbexA0SAk/h9Hc
X-Gm-Gg: AfdE7cmZITXymvLLtiUHIiAkAmG478GD9ar8/ILHOZPpfG828+S/nZqvdS3YrNMkumt
 BM8FRFdW8tsH4EXDx6pAW9x34oF3sU5xqSOLwY9VDydnWACqMu3f/S+ZCNrO5gdQwgVa3Vi0gBk
 p34WhGLURCEUdWtHBNd47ha4/BfL8eEP2xvGpC6fvQ5PtiwsWD2moJ1JbGwkZcIv3DO4KDUmrFy
 QQztyNjFuh0anVF/LPS1XnOn3rtiBdseAiSQ11S3bIx2BhZ+yHskOa/4/W4fbC2iJiQGhSndy2x
 RjYEr7GGD1lJYpmc+dllcy2CU08LNAiA9qp+ICgHAJYxzfaut6tEDVv5HxeYF94KDYbzMXLibeT
 CEq6tuL3ZxAexzU0Ve1c1eTd0SB341EOOls7//NZ8SWe0m3emlBWSh25z+IIAtZlAq34AgHf3UZ
 Axutlc6tEhmHDYLb5VZo5MblDl/AIkqOMtsebe4HopZzVAkyiVIJNk55h3f1lT1/96OlZX2p2Rg
 NGgXDDicRlCWqMRqshCBRw32rbgUfojYpYmRRgZ+gGrcgrlncr4FHqsZ6qXsnK01j6hadnXcHuE
 h4c=
X-Received: by 2002:a05:600c:5286:b0:493:bd2a:93be with SMTP id
 5b1f17b1804b1-493df038774mr2902355e9.6.1783340310667; 
 Mon, 06 Jul 2026 05:18:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493c63bfba1sm419257695e9.15.2026.07.06.05.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 05:18:30 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 6 Jul 2026 12:18:28 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
X-Gerrit-Change-Number: 1723
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1723?usp=email>
X-Gerrit-Commit: b418167638991954a02dc17e3c4e4b5953a07e88
X-Gerrit-Comment-Date: Mon, 6 Jul 2026 12:18:28 +0000
In-Reply-To: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
References: <gerrit.1782134588000.I3d52c6d008502293c3ec57ad22d1c613dcd1a94e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLkkzZDUyYzZkMDA4NTAyMjkzYzNlYzU3YWQyMmQxYzYxM2RjZDFhOTRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d617adaf36dcaf0fa62d9f2407d0b10970bf664a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wgiHZ-0003c6-Tz
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 multi_check_dest_addr_allowed from multi_process_float
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
Content-Type: multipart/mixed; boundary="===============8664802069018965446=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8664802069018965446==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ndxdOZVw57g="; charset=UTF-8

--ndxdOZVw57g=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1723?usp=3Demail )

Change subject: Extract multi_check_dest_addr=
_allowed from multi_process_float
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(4 comments)

Patchset:=


PS3: 
Code looks good, but comment could use some fixes


File src/openvp=
n/multi=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/a7ac98=
b9_1e5c38cf?usp=3Demail :
PS3, Line 3078:  * Reasons for disallowing a spec=
ific adress are that a client might be
"address"


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1723/comment/46679090_5e10169b?usp=3Demail :
PS3, Line 3=
079:  * already using that address=2E In that case the method need to decid=
e
"needs"


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/9754a51e=
_35cbd68e?usp=3Demail :
PS3, Line 3080:  * if the this instance can kick ou=
t the other instance=2E
"the this" -> "this"



-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e
Gerrit=
-Change-Number: 1723
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-At=
tention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 0=
6 Jul 2026 12:18:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--ndxdOZVw57g=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 3:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1723?usp=3Demail">View Change</a></p><p>4 comments=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?tab=3Dcomments&am=
p;usp=3Demail">Patch Set #3:</a> </p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Code looks good, but comment could us=
e some fixes</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/a7ac98b9_=
1e5c38cf?usp=3Demail">Patch Set #3, Line 3078:</a> <code style=3D"font-fami=
ly:monospace,monospace"> * Reasons for disallowing a specific adress are th=
at a client might be</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">&quot;address&quot;</p></li><li style=3D"ma=
rgin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/46679090_5e10169b?us=
p=3Demail">Patch Set #3, Line 3079:</a> <code style=3D"font-family:monospac=
e,monospace"> * already using that address=2E In that case the method need =
to decide</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">&quot;needs&quot;</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1723/comment/9754a51e_35cbd68e?usp=3Demail">Pa=
tch Set #3, Line 3080:</a> <code style=3D"font-family:monospace,monospace">=
 * if the this instance can kick out the other instance=2E</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot=
;the this&quot; -&gt; &quot;this&quot;</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723?usp=3Demail"=
>change 1723</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1723=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I3d52c6d008502293c3ec57ad22d1c613dcd1a94e </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1723 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Mon, 06 Jul 2026 12:18:28 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--ndxdOZVw57g=--


--===============8664802069018965446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8664802069018965446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8664802069018965446==--

