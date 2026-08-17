Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3D31C5DF66
	for <openvpn-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yz2mpBIPQRaAcBjJ+b1h24BvFh0dhhcV1fvTHOhwfoc=; b=WODcvFxxOsTXbcoHk4+Z11E8qs
	pMnW4O4R7pSPK6gEmjdLFrQUeDeLLoK16vF6+khhtoww6c7ycyGcWTnNHlUXQj1HZDvA6pWCVAZif
	lJfRv5op5oS5cTD207hRH2kO0EKWPKJbncJK34jBBmJOtEJyqnKESyogbWXaSAAc2uQE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wvzW7-0006Ot-5s;
	Mon, 17 Aug 2026 15:44:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wvzW5-0006On-UE
 for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 15:44:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ca44/LouTWvSJQObEDO8IIEq1tw52/JHrIKrHgR0gS8=; b=m2cZW7lQ+a8417Bp4tVbzumJ0T
 wm7+8hutzo2oOHyJbsxnf6BYQudmGBn0nXqVH2HeMfQUfAaV4bP4EEvmkFUGiKcl855GUKnTS2FAW
 QQSsRwSFCqoCCqutHvO9MFH6SO6erGNXFxjFJvSjLybMa/OvLfmpzYKK+I2wv+0HemxI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ca44/LouTWvSJQObEDO8IIEq1tw52/JHrIKrHgR0gS8=; b=k
 yCvm65XSWZRp4eEcH3QOrIAaYbUfCY0CiqjMWBWEHhldBLIUm15C/Tlt3DywgMgY+In/tyQfJ+TH9
 a2zFTfM+RPBgurq5SzhkZN9oS/070MYAXOsPQz7Y107dzr8sb84D/nHeX9dz4IESyfn6UbueCAbra
 TFhjyoJgtArTIXCE=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wvzW3-0007dV-Ok for openvpn-devel@lists.sourceforge.net;
 Mon, 17 Aug 2026 15:44:49 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so28945615e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 17 Aug 2026 08:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786981481; x=1787586281; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ca44/LouTWvSJQObEDO8IIEq1tw52/JHrIKrHgR0gS8=;
 b=Lhf6I60Co1HNqOHUfQ/ewyUub+Z/s35xr1QXNfjYzKdpb6yI8qevgiKS+QP8sd5VYK
 paUpf1kmbYsBMK1WyR7DDE/3DgBoMZ0w/HUSJJP843kyOI8DXZL17DFjvigVEInT61t2
 id+4+SEoR6cC4L4SwsFH1EtOqrz8lp3ZRtXx5QEq0KP1dQA+wrAPAVq290rUBsTu4p0X
 wJRKcK5m1GolmuN7hytiL1zshYmp8bDEok4G23ZDA8abqwrj7IcuKVATj+2sZDHQJmOC
 W7SdIRjFVvy+2XAbYT53vAK27J8MUMf/UyxzK4oFOSD2yC+rzviwjCCywLtSA5fEbM1b
 dCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786981481; x=1787586281;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ca44/LouTWvSJQObEDO8IIEq1tw52/JHrIKrHgR0gS8=;
 b=BjC3JhoOJngzGyeb0UQlOmqmgj7hI7hXAzly0I3ocaQy6LsHqUOt1c/2WtSI+4NvxZ
 IWHRq/TjQGw/ifaHzO+1eFZI52wXXQIdRMgjyUDDpT8y5kRruy2h7RT/7s/+4ptFgmkZ
 qD1A23SQdkKGiSSZ/MZzAeGrbLTcIJjN8zlptH2+nlKs67oP9XqxNuf+RCcyAAwwuFOB
 QjD/Xle/N5034WaD5LSH69k7Jl5RP4QIpzJ8JFzntAYjx6PpTlQLqvvlLntrWRkrRBN5
 y/SYkNsBGPPk9z2xHRZBrFpj2GHbriM8AHAFeqPVDiZb+LqC0cTTqnfm3zcxQ/X2+xDp
 Zjaw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8y3lo67hmshGt0FBcvYZJvPJ9HVdaMDY3Q4C7NkfIPLwYq/fXB/tpJPPwPHGUWbm4gF2S482s5ATOpd8B@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz424TaiYXd+oNz93MpncDrlG/0T1kw14ztZtZMn606dCEqXUlg
 U+BLI9zl65JCZFVVHrTRsP6KNeqwehTSe67Dc9P0uZhjfTNI6XcepsZDASX0dIGK6yKraXCpPwJ
 hN6FGF97/nbPwC2TegITNVc24KeQoiKaudqjM6VVSwhmMEa+caJ2d1bnCGgDkR7H6Fyfp
X-Gm-Gg: AR+sD12zxLYpTAZHbvLrpz6e8bFnWCDd/OIOJRWhT14tkfHpHo0lVy+LAF8+ewJdVsm
 3S+cRntha68EHWKyDKX0EejqUESUSAgdLgi2qQn4YhZXAOF9cuacMZ2Wq9Rqy6YkNNRPtIKk7Wv
 0hb9OjJkrWQ2yPEVbMy4NKzXI0iGI8ecd8W9AaaZtkhDnuJzGhgxp3bksXujGtGhEZzo9sq5ZBG
 h3fG2HuN7w3IvnZjx2JBSNRD1lUPsUk+4KG4K4RDEUfH0x2nok6f5jmxIYvxlxf3wetH/vS5oNs
 /jcRujVumekgskHtedqyNsEWD+CEwX1JXHAvQ2DbizAzoAuopn5J6NT/sOkDhBfZ7VM24Q6G8XN
 aHf2J6xRJBQC3hBx/YCvwz2NPnO7NnPN48/TesXPCuJreJdjSjoJ7MvpLrSTYdMyyQ86iXpb7rZ
 0KoNSZV79Pqi0X4QaNSPBlArNUEVHhIxo5o9lbtHEkhywEBUZZbPQUpafw45L4v0wcq0Whc0M2+
 utzgUqEXD9CQjyzta6SFegXd7Z6so3am3ISwtI3iFJhdbJmAlKykagvHRkKCzgoHzHdKbg+vwgQ
 0nO8gxbC7XEZzReVb/ULcbHFC5dttf94qDvxQq/dtjVD+8KJJ1o=
X-Received: by 2002:a05:600c:8714:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-499878ca13bmr466936845e9.0.1786981480144; 
 Mon, 17 Aug 2026 08:44:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100073sm185418555e9.3.2026.08.17.08.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 08:44:39 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 17 Aug 2026 15:44:38 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
X-Gerrit-Change-Number: 1774
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1774?usp=email>
X-Gerrit-Commit: d5d0abe957c657b7bb21aa21e063358af4ba5112
X-Gerrit-Comment-Date: Mon, 17 Aug 2026 15:44:38 +0000
In-Reply-To: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
References: <gerrit.1783600902000.I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzNjAwOTAyMDAwLkk2ZGFmYWI3NGI4MmZiZjc3MGMxNzk4YjQ4NTFhMGZkNWU0YjVkODFlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7dd85a9773a2553b5bf5aa2247d7714e4ed4fe39-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wvzW3-0007dV-Ok
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
Content-Type: multipart/mixed; boundary="===============0420065325318918946=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0420065325318918946==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AR0l5/JgVJ0="; charset=UTF-8

--AR0l5/JgVJ0=
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


Patch Set 4:

(1 comment)

File src/openvpn/chec=
k_file_access=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1774/comment/=
815e5cde_8aa96737?usp=3Demail :
PS4, Line 36: void options_postprocess_file=
checks(struct options *options);
Should we have Doxygen for these functions=
 in the header (or also in the header)?



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1774?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d81e
Gerrit-Chang=
e-Number: 1774
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razv=
anc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc25=
49=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-C=
omment-Date: Mon, 17 Aug 2026 15:44:38 +0000
Gerrit-HasComments: Yes
Gerrit=
-Has-Labels: No

--AR0l5/JgVJ0=
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
=2Enet/c/openvpn/+/1774/comment/815e5cde_8aa96737?usp=3Demail">Patch Set #4=
, Line 36:</a> <code style=3D"font-family:monospace,monospace">void options=
_postprocess_filechecks(struct options *options);</code></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Should we have=
 Doxygen for these functions in the header (or also in the header)?</p></li=
></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1774?usp=3Demail">change 1774</a>=2E To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1774?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I6dafab74b82fbf770c1798b4851a0fd5e4b5d=
81e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1774 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display=
:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc=
2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2E=
org&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Mon, 17 Aug 2026 15:44:38 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>

</body></html>
--AR0l5/JgVJ0=--


--===============0420065325318918946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0420065325318918946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0420065325318918946==--

