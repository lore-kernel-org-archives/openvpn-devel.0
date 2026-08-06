Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE836C56208
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Itplmc883OyA8W8Rah+DkICc6jLbBhfdyoP5XjM35Z4=; b=lvhigcXs5lT4z+DV5+2J4JxNmk
	4CvEHZkTsEXA6h56x4z6rZj7GVWTJqjOZx8/CGyuQxpd3kC/6dUwO1P44h4yhVX7xm5bypOEajWfx
	LMF2kE7lbQ8LU8+iXmiQa3ZWNP13RdeI+OwSU2fitxdBOf32NQ/MXZirTkv3llqH6HLU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrwDM-0000hT-Rm;
	Thu, 06 Aug 2026 11:24:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrwDK-0000hN-Tt
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:24:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=lbqYnFKbMO2sOCH/TKsrABoqh1V5qmbVjWYom51alio=; b=NJ7VLEKgRNeN4nYTMsXBOLlnAx
 PBWG4YyGuNru6WmD8kIMhKIlya0R4hGiDMSOKjohEOLUd1vYgAwbS0+CuIYczoByD67kdBztMyPhh
 /JFxQMGGWWHlsV5aeMfYJUMkaCjDAEHEfh/M6c6z4IyKvVLPhzdyPP15yOS92kgzq4KA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=lbqYnFKbMO2sOCH/TKsrABoqh1V5qmbVjWYom51alio=; b=O
 lqIq7A5ECkywj/jmBZXm7mMzy0eAgbPa7y6/aCFrJmwZXLJCJg/FBRbGAjalckPZ+l8lASiYJT3hW
 0WjODbAkGHLAzHVUTIsiS3OSIHBQwejQSzsIFHJLqOK69mcFfi4m/b67PnFd0GtzP+P0dW0RFgoWe
 KFfB9YBDZw2WvQbU=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrwDJ-000249-4z for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:24:40 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4994c49f588so8752715e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 06 Aug 2026 04:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786015471; x=1786620271; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lbqYnFKbMO2sOCH/TKsrABoqh1V5qmbVjWYom51alio=;
 b=AnF2OU0MFTo/ZtaWndBERX7KHNValAWWl0MSA//f08Q0qFDkL2Yf6LL0OIXM5PKV7Y
 4Unn154gyB7n0EnST1H7tg/+hZLN54maY1dBqNf1LbWeJQYln2J/xhyjNY689+7vWXnx
 ixEQrWQ4v2c9jDHKAoG7sgXCibmTnGTXIhPCbjjyPWOVIRenoD527Q+bi9uuxBK97p+R
 DTeOZ0QenJq7Pzej8yFfrd0Gb7Dl02fu5VOnT41JxQ8bRB4xAa3xCR1uCmdHCUIJ5Oym
 A9y/h46iZQNcADL2cT7/am7aB1axxyRYXzaR5Clsw8cvkXAzYr2HlfAernl7LOM9sgrO
 H4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786015471; x=1786620271;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=lbqYnFKbMO2sOCH/TKsrABoqh1V5qmbVjWYom51alio=;
 b=SyCMrrJEp3pMf4Ot7s0+6yUUieXR5XmNFizzLjEZQkhLrI+tMapflFitjkX86OkufH
 2DzC84hpWyH5vkRzpX5GtMgO1V5RbTc370WoYXHI6/H06GP3qc3E+lWMsfqczS/8hBta
 7oce7XQwkvL4wmPMqC8DJIvxV+ob+iS2eqj5XtnAiMoH4lRA71thcvVuOo6qyrkG00tj
 1MAxyrXcnPujbeU9QN7x/pZmjyOxW9l8O9R+a7k6/iBYcRLwm1ppwysSsQUko9RCcFEE
 vhFUUa+cgYXCpvyTR5PV9kv7zSkHT07fWyJfV52W0EPHA8GEJzsgs5y5x11xDDPLdu8b
 vqiQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGOKAfLt2ASEmgSjYA3fuSp9TJ/cyYc+JHK5ElAGer4qAoqDEvbsXGgZsbFXq07zQwBaT51t1gJo3jBOwq@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzFZaSFy3c3PAF65NRWezkMK5EABE2DPH92iei7DS3F3U3UWFYG
 OQMA1WIqUPd3xbM4HeMLHfMsSpbaGHFsH4NIPkCVix9eX4JECzSdb2BsFTyZIaOACQJimbKZ4ts
 AI4KDA67bX93Dnr077vxj/9Ydym1KhNjn+OsPtjbZHkdptB2t8G8hih9iHr4NZFnKzLJd
X-Gm-Gg: AR+sD12C1beMPp3x/x6UirKDsMahXrzICI3feXqgSw5wAAwnCvL3tmOEK/nluZmQPDD
 eSUU5TBL0Ve7nSSPR0OoF65b8sob1IIYG4YHVTLBMvbpMiezfNY5lV10SQ+87d3SlgIhphf3WwH
 VVofZNtAchF4rDnLGnZEgvcwjeWC++yG0UfbzUyV3KMZVARiXj2uP1MBOoi7TZcoaLGESDlX3TS
 0eY0YNQuEeAXByonDfkv+Y/2kVmwkn5yFqj2ChWELr94qpF4wA1K98HnKpOW98uYYDr8aqOT6hK
 o1/ocBpqmXExYxPQzWGoWBP1ol9vCfK4AARLgqIUwnOUFmKbnlbVUTqK5Ic++yPZlAoH4teDxWN
 IFST8N/4N0E9UWObB98gVsbT4cZkW+Qo1LFZaGKjgoi13AfsAYrNZsaUZAprIQTRQgVCR+Edzk3
 29/X07GnTGD1QiuTk9FDz8Q0CJMHs4JW2guGTIuCzbujhEvfeL9zgYMwWk5o4S6gc8YZbQROmnL
 ldjpfsgZ0pMLOLaHufU1vVG3efh92HGDNmizBXBKyOwlyZyE/eoSpaJqzajLUpOE+jkL+xH91z8
 E/c+/8Xnyk7c/Swh2+/rGh9yssrVnkVsPHdlydwN90xx8cX6Xug=
X-Received: by 2002:a05:600c:811b:b0:493:f478:4c71 with SMTP id
 5b1f17b1804b1-499553e60d8mr33704665e9.7.1786015470210; 
 Thu, 06 Aug 2026 04:24:30 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995427a244sm52872365e9.10.2026.08.06.04.24.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 04:24:29 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 6 Aug 2026 11:24:28 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 673e321220a104f42914bd04adb1968a7b2d9112
X-Gerrit-Comment-Date: Thu, 6 Aug 2026 11:24:28 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f220343cdf9ca1bfb628cea356c66ac5d2024186-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrwDJ-000249-4z
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2098154745956871343=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2098154745956871343==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+hf3cg/+ciQ="; charset=UTF-8

--+hf3cg/+ciQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

ordex has=
 posted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exit the proce=
ss when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(3 comments)

File src/openvpn/ssl=2E=
h:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835/comment/8ee697bc_484212e=
a?usp=3Demail :
PS2, Line 235: #define TLSMP_RESTART   4
> I just wanted to=
 keep DCO out of this lower level bits where this constant is used=2E [=E2=
=80=A6]
Done


File src/openvpn/ssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1835/comment/1411310a_dfa04e1b?usp=3Demail :
PS2, Line 1402:      =
           "notifying userspace=2E Restarting the session",
> Acknowledged
=
Done


File src/openvpn/ssl_common=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1835/comment/3bf1cf6c_2c5fde6d?usp=3Demail :
PS2, Line 202: };
> Oh=
! [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1835?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTyp=
e: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: =
I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
Gerrit-Change-Number: 1835
Gerrit=
-PatchSet: 2
Gerrit-Owner: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@ma=
ndelbit=2Ecom>
Gerrit-CC: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, 06 Aug 2026 11:24:28 +0000
G=
errit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Comment-In-Reply-To: flichtenheld <frank@lich=
tenheld=2Ecom>
Comment-In-Reply-To: ordex <antonio@mandelbit=2Ecom>

--+hf3cg/+ciQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p><p>=
3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/ssl=2Eh:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1835/comment/8ee697bc_484212ea?usp=3Demail">Patch Set #2, Line 235:</a>=
 <code style=3D"font-family:monospace,monospace">#define TLSMP_RESTART   4<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">I just wanted to keep DCO out of this lower level bit=
s where this constant is used=2E [=E2=80=A6]</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li>=
</ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1835/comment/1411310a_dfa04e1b?usp=3Demail">P=
atch Set #2, Line 1402:</a> <code style=3D"font-family:monospace,monospace"=
>                &quot;notifying userspace=2E Restarting the session&quot;,=
</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10p=
x 0; padding: 0 10px;">Acknowledged</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_common=2Eh:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1835/comment/3bf1cf6c_2c5fde6d?usp=3Demail">Pa=
tch Set #2, Line 202:</a> <code style=3D"font-family:monospace,monospace">}=
;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">Oh! [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1835?usp=3Demail">change 1835</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eo=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1835?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1835 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none">=
 Gerrit-Owner: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@ma=
ndelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@=
rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: fli=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Comment-Date: Thu, 06 Aug 2026 11:24:28 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;ant=
onio@mandelbit=2Ecom&gt; </div>

</body></html>
--+hf3cg/+ciQ=--


--===============2098154745956871343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2098154745956871343==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2098154745956871343==--

