Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFDDC88E75
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p8Q2vr2eXRTvdC1eaZ/3AHA/F8//8zRhfoqDAmEbRTM=; b=biw/xfw3s1Xj+cOC7LlVri7Xf/
	HZWcsIxg7hpmOuPBm+TxPFv64iKe7GjfU3HkbXHle4/0QVhRCBcyd5g3gN/CSikmT5j37CAoplqZK
	Uw0aGGGTFVJELZyD1nhqanmaW2NCX7Hh5kH8MSOnn679JuCn7Xt+lS2hVPF+JtS9rZXM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6WRo-0006Oi-Lc;
	Tue, 15 Sep 2026 16:55:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6WRm-0006OX-VY
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:55:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=mcld1YNmZ3MvA002/kjH/8WlqK28JmtkwL553eT/LIo=; b=gITj5xB3WgTmyBjgnnP/pV8U8Y
 /72RFKyyYHZxHctWQnoi2+CuPc6FlSBGAZBIG7wYJW2WVRJaCycbkx+j1S/G7xGdbuUc41h0uaTDa
 OZ9RF4B7GL0B8PVSd9z30D6HrbZEkvCL0W3T4N0hZuQVqsfnF/QpdihUFd5TguPTQahU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mcld1YNmZ3MvA002/kjH/8WlqK28JmtkwL553eT/LIo=; b=l
 /rRzNFN6iCTLO+4KsMwVEwoNXlwUR4Xcxi0M0WBRBRPJwJYsIymU0cMS59eDoFNmKsGZgLF3jaFG6
 1SLOrR0IoIcBi9ZNyDJYlVvguN9L/B0Ajpnq5arokUet/SUo0jS51TFeeos35R0HOiIbb3RpLxfUk
 Vdd/sSkdFzqlHGfw=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6WRj-0001VB-Go for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 16:55:52 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485984ebf5cso2789443f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 09:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789491345; x=1790096145; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=mcld1YNmZ3MvA002/kjH/8WlqK28JmtkwL553eT/LIo=;
 b=d8pfqUIJ5ip/WIimNW9Ecq575IWJ3GC0jM5LmbuxCw8xCQMPsvmXp99SQ175EO6vdQ
 3VIEBzl984lF9Kea/4VxqyoI8mhVOG+CnN+RKidS0rgjFCuuoVvBcuIqOek2eKczmSyt
 7GQfeTe7hOEUPS74U4QoXxPX5VPnxUOucsTR+DYKJM4wb8Uz6wRUf668xRg8QjMXmjVj
 X3kVLuse0K+LdqWRmEIzlhHXr8VYhOzqC1yDmFV4BbKGAa18SvUKrzeWyhMRn8mmPV03
 62DLRy8/g7//wYMNPI3WJLAzOrdMGkDWQ3vEFFTThyqOBM5s0gbd7UqbmJmn5sxD4dlW
 I1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789491345; x=1790096145;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mcld1YNmZ3MvA002/kjH/8WlqK28JmtkwL553eT/LIo=;
 b=S2t8ilucATj8y6E55vYJoiH+V5scD7Qq34L6DckBOA2Ih9iRYc1lyR5p19PmEdRZ/W
 kQnL9wwLdxf0ezzdMU3EpW0SZTPjWlI2uBknRd5kAAAXqqFHiB92w9dbVDtouRMHMFQA
 k9s68lV+P8oEFv9ajjiQ7Ulx0fErfElza+6i9lVHrqUC4NB1lvb/gm2eBt1Bz79ox9Xy
 s4/Qy58Nqb9wagz8zNAnVKqUTSy4ziMc4l7Myz43i4q3S7ShxYXNG434ukmEU83g/mZH
 kCBJMd5kHSqDoQjhLOgGC6YO2iyUGYcGwHyOwcDC89ggrM3u94vbNg4b/yFxvQSkdjst
 /64w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXp67Q3NEXrMja/drX2CVOiPnl2AIZUVOJv1Jl4Yl/O9aCHqpEc03mJpvmrAdY+Rt/1fPQxzQ409hn0EiP@lists.sourceforge.net
X-Gm-Message-State: AFuF++kdPLyoshJ29+Bw9TNLa88bSncc5nUQCykHn1+tW9lmJ6T3p0VC
 S5CRZpxBzctYXb31gRnauS6iWcgkiqwGX2T2P/w49YemVImPYHRrQ9bU6cJ/XCohNI3eV2kdAVD
 bhJ3jElzXbT6j+MvDJ24lrylaFCnewQMa268oy4YiEI1V3+expVF7OYi3OZlg8cl9Zw0oIItyf8
 ogqaF1YQ==
X-Gm-Gg: AYBFou3ma/W1+PIDWItmmZFoBeJYZGNTC5Pj8RU0bjcunJhq/NukTuC1iKCa4ooIyuF
 ffQKTZ3yZUbW/Ed/jjCZEz2RtVxN8cZw7WYmVFYjYj1a+Q00BGrMlxG+NpCON3nBSobLr95FMdv
 9QWNaJJkBhR4AvNrmoJwT09gJN5GKZix2/HiIxdkf7iMW5fzzaeefw/BxCkBBDJk1nkq2Jk2+/d
 tP86gIU6MTQk4GHogxhucN6Uixvd7Z9O8h7rlYCINVQp8MXBaMBMjzBuJeqdIZJ0GlVamaQoFo8
 zRLonkX5Ijf+JcYfz+uFY07a9GNR0Dd9na+XX004xlhacYVh6/SbZCeG0spiX4Q19NkzN8IXhbY
 6x7DQ4nxXUSWYkU1A/LMtiyQEBaP60BsVxKgfvVIEAIjvUuFTzkaWy9qezRdCChKQEzEP1CCHJ0
 bNIxLw3L38Mm4a1lkgSszcJTcGQeZVGjx5hHzr8vofkDAgNrrzeZJJSjIkSkNz8wRpf+xQlwTzF
 xm6Mku4uBtmG+novKAhwzH2QbDRSA6MwerBFxKc3aXLobux7pi102nVcTngJe1vzA75ifFLpJVv
 lQiPkpbi/KfA237g22px8GOsRIne+TOizxr5tYi0i8iEjx5kXM/vzlgeJtm1dA==
X-Received: by 2002:a05:6000:230d:b0:487:981:4dfc with SMTP id
 ffacd0b85a97d-487098154b9mr3462181f8f.54.1789491344817; 
 Tue, 15 Sep 2026 09:55:44 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf1f7cesm301701f8f.10.2026.09.15.09.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:55:44 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 16:55:43 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
X-Gerrit-Change-Number: 1727
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1727?usp=email>
X-Gerrit-Commit: 2bcda4dcca45f2ff779b0aa30ae989696ccd01d3
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 16:55:43 +0000
In-Reply-To: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
References: <gerrit.1782134588000.Idb59ecd119331b198792ad1379bec8600211651b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyMTM0NTg4MDAwLklkYjU5ZWNkMTE5MzMxYjE5ODc5MmFkMTM3OWJlYzg2MDAyMTE2NTFiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ecc5e82adacd714139a1f454367badf9559afb3f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6WRj-0001VB-Go
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add lookup of multi
 session by session id
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
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3582673299163838095=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3582673299163838095==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K7nYgr7qMQw="; charset=UTF-8

--K7nYgr7qMQw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1727?usp=3Demail )

Change subject: Add lookup of multi session b=
y session id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 31:

(1 comment)

File src/openvpn/sid_hash=2Eh:

http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1727/comment/6c2ad03d_31f35e3c?usp=3Demail :
=
PS26, Line 23:  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA=2E
> Not done
Should be done now!



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1727?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Idb59ecd119331b198792ad1379bec8600211651b
Gerrit-Change-N=
umber: 1727
Gerrit-PatchSet: 31
Gerrit-Owner: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC=
: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention:=
 flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 15 Sep 20=
26 16:55:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-=
Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: flich=
tenheld <frank@lichtenheld=2Ecom>

--K7nYgr7qMQw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1727?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/sid_hash=2Eh:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/172=
7/comment/6c2ad03d_31f35e3c?usp=3Demail">Patch Set #26, Line 23:</a> <code =
style=3D"font-family:monospace,monospace"> *  51 Franklin Street, Fifth Flo=
or, Boston, MA 02110-1301 USA=2E</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Not done</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Should be done now!</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail">change 1727=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1727?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Idb59=
ecd119331b198792ad1379bec8600211651b </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1727 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 31 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Tue, 15 Sep 2026 16:55:43 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--K7nYgr7qMQw=--


--===============3582673299163838095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3582673299163838095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3582673299163838095==--

