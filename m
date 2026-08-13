Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B48E2C5B572
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 18:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3DYzOhHh8T5ELoUVN2klZqC1p0FWvtvbrw2MsRjnYpE=; b=VmeoIGEAiRuoEUL9PPPKR7TUnT
	NEXYQ7typ2NyjvV+DgX9xlWoOm7JOv7WebpqxBmYNxYFpDQ5Ae+lLzJtnJ+4aFjKbkN3ltKm8oC1/
	I/FTaphc7tOzJ27GC0xDCWdWXye0p7NuoijXvd7Zurvj/Uos7KF0L6SqrWdTBjvkiuDo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuaGM-0001Xt-W1;
	Thu, 13 Aug 2026 18:34:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuaGK-0001Xg-J8
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:34:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=jpl52NxkuioSg1H5uKQ6BBYswprIbvowrZzemYzNUYM=; b=m9Z16z6ltLNc7T6hTQgbSCrkhm
 7CjpstYHegppsB/pJCrGhP2NYqQVgAahFw2k4c0Iy2CRJfvqklKGlcXxfwfM/sF0n3sUkgbKoH4Yg
 IFc/44KDdYBW1fq/NV10Zf1FpaD+8tCMKCpKAw3rtjJxRCpzOYOuupyheOqtZEfiB/LM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=jpl52NxkuioSg1H5uKQ6BBYswprIbvowrZzemYzNUYM=; b=A
 ai1+DDBM0kATvC4AeuI6SMpKDhNkydAczuzcwvsHo+//TN0jZFMPxmX3rV6vLMRosXA1disiU0VnJ
 abapA4ZzlP5cB9perAFpkbZ7ABUdclxOm/hvb/5UgL7AaEk4SxILSlwDAsmI72JgK50nj+pb60NjV
 Tyu2DM483Ukn/VBE=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuaGI-0008G0-Od for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 18:34:45 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso3208195e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786646076; x=1787250876; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jpl52NxkuioSg1H5uKQ6BBYswprIbvowrZzemYzNUYM=;
 b=Y68wUZexQ6XdB71g/oxd1/0fdCstuX63CW79yUIBMeRBVmRChw9xq/bNrMVjRb4vVX
 BYJzQrXLg6c0CKQ5DFUZHbneaVC6uiw9WP7RsaokgHy6X/zfeUTkMVnKW2Nop2it2LJN
 btuztQVCNQdqmDiFkdcmyGDHGSavL5MZL38QTvho34Dnb7vDwN7pntKrr3yuSWsnZi2Z
 Zs+dLrtBxeXQiGM6hPQSoVs5L12PHURjoNiUp/sw9cFS5Lyk/3L8Bi8/pkuHuU8rTjQh
 Mt+Rb3QL+xOjDDaDTK0VCHFPPXnzSXNQ7itZm6WRRNPebfhcY7w7F6FT4v2MyDW6jhrB
 AyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786646076; x=1787250876;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jpl52NxkuioSg1H5uKQ6BBYswprIbvowrZzemYzNUYM=;
 b=Btkwx1+fAJXaVXG0Y75ajt+k829v/ZKp54C2PoyL6Z/DT7IbVoFthwNmzb6Z9N61WJ
 U2J/r7PJkaiwrt2TrUDk8qtK76PBl5Vy/YCMkVkcWTNjPEEc5OElZGRsPAkrqlDLgMHh
 Z0tyODtPQdqS4jw3av4StPNR7nR3FD1+S7lwDeWWP9rnG7V0747f9IUROAKV/Te2E9xz
 1BwxXo2ZPRe6a3fjkhSBWAnF7fAhcV8Sk1IeDJJaG7ontEbUvp3LWvw5KE/eO/gGtDPb
 PuXwYn3c+uwNALHd30kXFVHdPMDuq2UvWf4+Lg4bl87vedDrpAx3FlwYstY8DQ6gJJFi
 l/Qg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoPDSCd44HN7Kq/NxyHc+1qrre86PtldHX83bTH1qHen5kZlttS+SRJ2vBmdcE/PmPW3WNl8s5N8/L16ZD7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyIerNdpuEPtJh0OY4SPFE88DgUu/MBJcAco+6zNSIijGBZ+VLz
 yBuhW4bfI3fhPU+b6jXqWxnmx9TaW6S3yv8JnGNCcqG7bN4cTpzs0pjrb1TJx3jPmpominWoMai
 +/kYKX6zTQv7GeXHknMPhIj7pAX0BMz/TgEF4yak3ErdMBM1ZRZWh4wwNCB/+8Mk7nCyE
X-Gm-Gg: AR+sD13p33WDvcg35xEs23J0QPGz9hUvFh1WhtHB3489xsgMx3EosPfdIdffasszB6S
 30nmmhqH8La5SyP0wkCV9mtQshD813vCRtGDsHGef46UZpHRqqqbDTqY+jsf/FVaqg0b0qjpPax
 6eGF0JcRNrtBw6lxbTOdM7hU2egchC6ExNff1BO9kS6amohC4DaiQ4nTf0ThTNxhGcEgPRLZqlR
 0TvLGpQgayDDs2whptfRvqOqwEnPHPhFcT0rZSAL8YYLGibOOlxhto+n4XlTMpcgUhWjMa95cMH
 /sQpthSrhVZXRq7GBQbNA7OBsvSVBeHbE8xwwBhOE6EEeAE5bNqIKZNLF7H+N2d6ByewTFjEINa
 NOJ9d8btBviSvGOBVA8x9DmhbFxXemRbnEL91Mp3U7ZF0H5KfiLgEX5YQeA6J2I+Q5bHdvClPs7
 NU5PCiJpYXkfgROnDL75HmtpmKguxw9ddSe3wEUqAAu/QKmaBx/T063xkotwbCuMqzpMttdTL72
 uG77pcvBI/+jW+5a5I9i3a7L6SbT+9heDjqififWJq4ZM58uB8+Ch0/yfgEsW9Upi7uTxXlMPMo
 HUdlLpkBU4dYBzv3cHeaAwL0F/GNWSOYQw+a1XK9IFEFwVtgFck=
X-Received: by 2002:a05:600c:3acf:b0:499:728c:4704 with SMTP id
 5b1f17b1804b1-49987979c41mr6199865e9.12.1786646076086; 
 Thu, 13 Aug 2026 11:34:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b58700sm77764725e9.9.2026.08.13.11.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 11:34:35 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 18:34:33 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19
X-Gerrit-Change-Number: 1780
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1780?usp=email>
X-Gerrit-Commit: d28dba8619dbfdb15836b6eb8313249eaa681e29
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 18:34:33 +0000
In-Reply-To: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
References: <gerrit.1783961511000.I40f72dc038a38e5ad1d3dd04cb10cb7d5cad5d19@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgzOTYxNTExMDAwLkk0MGY3MmRjMDM4YTM4ZTVhZDFkM2RkMDRjYjEwY2I3ZDVjYWQ1ZDE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <22a396f6e6f92b0172d4e86a4b432da2f2532cbb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuaGI-0008G0-Od
Subject: [Openvpn-devel] [M] Change in openvpn[master]: platform: Add
 function to determine temp directory
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
Content-Type: multipart/mixed; boundary="===============0060155029163624438=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0060155029163624438==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uAb6Mdl9MZM="; charset=UTF-8

--uAb6Mdl9MZM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1780?usp=3Demail )

Change subject: platform: Add fun=
ction to determine temp directory
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

File src/o=
penvpn/platform=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780/commen=
t/4c07c855_2e7d94b8?usp=3Demail :
PS1, Line 614: 
This leaves two newlines =
here where elsewhere the code seems to use one newline between functions=2E=




-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I40f72dc038a38e5=
ad1d3dd04cb10cb7d5cad5d19
Gerrit-Change-Number: 1780
Gerrit-PatchSet: 1
Ger=
rit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: fli=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 13 Aug 2026 1=
8:34:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--uAb6Mdl9MZM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>File src/openvpn/platform=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1780/comment/4c07c855_2e7d94b8?usp=3Demail">Patch Set #1, Line =
614:</a> <code style=3D"font-family:monospace,monospace"></code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This l=
eaves two newlines here where elsewhere the code seems to use one newline b=
etween functions=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail">change 1780</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1780?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I40f72dc03=
8a38e5ad1d3dd04cb10cb7d5cad5d19 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1780 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 =
</div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pla=
isthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 18:34:33 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--uAb6Mdl9MZM=--


--===============0060155029163624438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0060155029163624438==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0060155029163624438==--

