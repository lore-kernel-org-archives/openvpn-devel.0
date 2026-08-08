Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9B2C5AC67
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 13:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=026R3ofmT2aLzczwlZ3121j9f+m1UE2c/vHl99bnpWo=; b=FYFBa4dCGCGH5P+t8ktFRmwC0x
	XO3plrQ0P9waawhXG/nPDubLnYX1JTSwxgr5NUw44pA7HAZ3TpH74EXZjCzlzES8eKa/YXkhsZmg+
	w/vzNpJL1UXsmw2iU4qvzdYjFLOsrWQS6DtKios13rIemmw9SKeBUZNWKfifnRCMgWGI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsgyq-0005n7-8Q;
	Sat, 08 Aug 2026 13:20:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsgyL-0005mi-7T
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:20:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=5Ef9gJzO5bUOjVuIqDZCm3TcT3o+3vYZZSRRLP8bBCQ=; b=ABug8v1aB+WHwufZwapMAuET1j
 5tbPkLD3MhXHbUa6cZj2055kZ5xx+FKt7tPF9PfCNLdMW8YLwk9lkrSfWOmCP2A0buMPhyIpafWb9
 HVlJBPhmPdQKz5B86BYlNm1wpb3JAgvhTuP7Mn+ejPBr5z+Fx9vVwdR9KScWXaPg7zQk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=5Ef9gJzO5bUOjVuIqDZCm3TcT3o+3vYZZSRRLP8bBCQ=; b=c
 mtNKcSMR9YZo0QoPNdBNDcczzKbJJ81f6ntgnTQXzJIU3JcW9j/vcpHdtdyzRgh6U7N6is9vyxM9x
 sHHCaELvEtqyM6TesI02ohvhhr9+V5MeiNsGmw9Q/l2Ly3L2iPFtY8PXxLOsMyG74HOCCvCd/6f/T
 m9DGaXR+vyqTioo8=;
Received: from mail-wr1-f47.google.com ([209.85.221.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsgyI-0000cw-3O for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 13:20:18 +0000
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-47f703a9d05so242268f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786195211; x=1786800011; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5Ef9gJzO5bUOjVuIqDZCm3TcT3o+3vYZZSRRLP8bBCQ=;
 b=Jb3mkdCtAADo+OaSS8Js4RvJM+TNnhkQ/HxcZLGkxuv9nHfXfgbhXB8M8bS3zhxQFZ
 PQrMbLKw8BgTeOW9RbajI3L9GPFEtwucolMAFipBKCcEH84+7oAyQx377xQc+wyAI+Yv
 a8gwDZwt51m0D6DEhTct5zf6L4wl/vcI/b7y0xAxGEMbT48bwFVlhihZdtbdFiQGiQaf
 5sb/vzJIPyy1VdaqRTlDQsMAroGIsmL4t8z2d0d4suHAnEgnLsFcQlUQBx4c42YdOak6
 8si0T5uMiO67X3xUJkG1luaOVabHgfhscz4dBPsiafWNxafBiLc7rrOJq72SL1HTkpgM
 5Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786195211; x=1786800011;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=5Ef9gJzO5bUOjVuIqDZCm3TcT3o+3vYZZSRRLP8bBCQ=;
 b=TLt5dN5vupsUZZR4wOTpSUw+I7c2uylPgwk+bcGKvF2Gj/4qlJptMlLSYskvwd8rHM
 2nZz9zHwK93Ea+5Tbrnpa2EcV6kv/6X3EOjKIpEPzpPZ6t4PAosFB+1Dnbc4bfRBbgKl
 w34IzHwuXZ/NgzOMVag/fge8QJtWfxNvC9mTdQGOi8N7c8GfJL3WbZuZQ+4LJGmoOVaq
 F11ezrgR9ykrvrn0WHjv4PUriDNaFPv+sI1wwQYu1vWyOjDmQiMpHgXy3eG6HzSylWnf
 GqloSa1R0KN88uDxRJdP5GdJ4Azs6sVKdE1UFOttmjS6ZZ2yncltYB/CjI29+XFZ1FSS
 cdPA==
X-Gm-Message-State: AOJu0YywYmwOrKsoKZFehFWpDJHs8zTyONruPPS26ewh3p0DJYndlaxy
 DzQI3RlExWU0CSO4jlwEqaoiD/xzO+tFd6PFJcN/A8O9Ci+k9SyHCfqKXYaPllvNNJ9FcKYcZ77
 9tOYQowYyfI6p14wuCHhbJ8d+8fLNo87BCxOYT6VrsLFl65sW+Y9kPIsNyQ3ZEa7/RTJ9eLlHc6
 F1v8MY6w==
X-Gm-Gg: AR+sD11j7yeV0WugsiO13QJV53JdYRBUNuQn5gOXGzTJPtvJdThB96guTeNUvae7J9D
 RMeEWOH6HVABZ3IFNrXmFbvD9zx40W02TKcAvdsk34xihpHwvl1AFfIUH0BMm8NvaTmhL3kilW7
 GpAAP85A6BWSAUJVSPq84szHvzHxFngFHGDgyE6W/dNh/tNdTc/vAzG/9crux58HmExuczrxeOG
 v+JZnaM+BwBftp+cNDDrNiJZ4oC1J1KVIsa4ONQN4js1QFJTWDRb6WUXv+UxMvCHWiAww3QKLJK
 xHr7oHa6a3yb+CRFiYnL8Xwsysj4Oz2knZnSzIswijDsrhp3Wi3Yk3IhAHVw4WhLPuDuV63gtTj
 aQ2NmdWX8U2PVJpbp+eRQt29mMktabf/l+CuTePw9woJ3xQv03mnx4LQUMgG5VrtTgfqlOy2wtN
 Gndm2pENQEhMV1f1DUuw0si+Ah/JSysIlxH+dH+DZVvNkvS+vYXrZbVoE3xvYteK25aJMNV00Jt
 msMd7rHv9rOEzV2S2JjiFcrv8oSbfRQPgoNroTa2J61v50XAwqFL9TPPRAszqW4FcuUwwtNZerb
 jVPVH9TZMPU7ky3TJOOweEG2Y/sQ4Qg67FI+veVQt3SlL585qeY=
X-Received: by 2002:a05:600c:8b4b:b0:495:5fdf:2075 with SMTP id
 5b1f17b1804b1-4995e0254cemr140968405e9.0.1786195211243; 
 Sat, 08 Aug 2026 06:20:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995c7a54f2sm111588575e9.2.2026.08.08.06.20.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 06:20:10 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 13:20:08 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f
X-Gerrit-Change-Number: 1526
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1526?usp=email>
X-Gerrit-Commit: e468f87961d3cd09d0dac64d97974426339e2931
X-Gerrit-Comment-Date: Sat, 8 Aug 2026 13:20:08 +0000
In-Reply-To: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@gerrit.openvpn.net>
References: <gerrit.1771008284000.I701452496bb47c58b9728b08104dd5cb7823a94f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzcxMDA4Mjg0MDAwLkk3MDE0NTI0OTZiYjQ3YzU4Yjk3MjhiMDgxMDRkZDVjYjc4MjNhOTRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <614b6842bb15f9fc863b26beede4318715dfd6bc-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsgyI-0000cw-3O
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Change all
 users of positive_atoll to uint64_t
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
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0168834983939807113=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0168834983939807113==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dSnhmrB5Xb0="; charset=UTF-8

--dSnhmrB5Xb0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld=2E

plaisthos has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1526?usp=3Demail )

Change subject: options: Change all=
 users of positive_atoll to uint64_t
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 9:

(1 comment)

File src/openvpn/opti=
ons=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1526/comment/f34cf083_c=
78178c3?usp=3Demail :
PS9, Line 869:     o->renegotiate_seconds_min =3D 0;
=
Setting this to 0 is now a noop as it is already set to 0 through the CLEAR=
(*o)=2E Since a lot of other options rely on being implicitly set to 0 I wo=
uld remove the assignments here=2E



-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1526?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f
Gerrit-Change-Num=
ber: 1526
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=
=2Ede>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comm=
ent-Date: Sat, 08 Aug 2026 13:20:08 +0000
Gerrit-HasComments: Yes
Gerrit-Ha=
s-Labels: No

--dSnhmrB5Xb0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld=2E </p>
<p><a href=3D"http://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1526?usp=3Demail">View Change</a></p><p>1 co=
mment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1526/comment/f34cf083_c78178c3?usp=3Demail">Patch Set #9, Line 869:</a> =
<code style=3D"font-family:monospace,monospace">    o-&gt;renegotiate_secon=
ds_min =3D 0;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Setting this to 0 is now a noop as it is already s=
et to 0 through the CLEAR(*o)=2E Since a lot of other options rely on being=
 implicitly set to 0 I would remove the assignments here=2E</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1526?usp=3Demail">change 1526</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1526?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I701452496bb47c58b9728b08104dd5cb7823a94f </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 1526 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none">=
 Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: open=
vpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-=
Date: Sat, 08 Aug 2026 13:20:08 +0000 </div>
<div style=3D"display:none"> G=
errit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Label=
s: No </div>

</body></html>
--dSnhmrB5Xb0=--


--===============0168834983939807113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0168834983939807113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0168834983939807113==--

