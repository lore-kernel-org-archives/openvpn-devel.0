Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF1DCC6B1D
	for <openvpn-devel@archiver.kernel.org>; Wed, 14 Oct 2026 12:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0LRCkr89YfwMUhDx9pxktTkNXUzezw08KCIdPhlf+f4=; b=cpJUtWM1+5LToUcLwaku36EZ7i
	KjzdiVTjv1q6B7O/8jjw6YBzrYfR+pAg6EvETKvMRIEDaVWNA+pD79+cR6ZJ1FFjHV+M2cnnSXfXZ
	sGXbivL9jgU/jIbNRi7dckmHcF5FdGb3suiuUUm08ADlb+If8n7D2YZzHjNRz3ViLFIk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGyC6-0005LQ-W1;
	Wed, 14 Oct 2026 12:34:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGyBg-0004PL-9l
 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 12:34:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FELQyf1/rs7VvZnLZKVpvyx3lvLQJbfEpvZR34QoRPc=; b=hV+PvHKDrdHYATPntrBRqqXTfL
 G23uYGui2rWTosWk33OlwKjOGwFUUn+W6YQRN6QlnXQG2u2UWlBmRn6GmZuZCKn5mLMCu/7L8S3LJ
 qg5T3DTqOuQ+PLYkwRVD7w7l4lCu1n+XvlrxGeTJEfJysrIRWiJ1WwtE/di5M0o/EvD8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FELQyf1/rs7VvZnLZKVpvyx3lvLQJbfEpvZR34QoRPc=; b=e
 35W7YNRsehTTViwnUX3r6e1B5RA05x+XqXHhldFqbsYgnUSZ5lML0wEKmkCLB5Ixm6fmEgYHvgQ0P
 mPqxNW3+3iT8LfZL1LNbmctDFOvIrJfRPZUAT7VMd528jRIzuq5LYnqg/Y4gAjTLgwe2KwEPexTAh
 BVlWXqdy1ZwvehnY=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGyBX-000688-S3 for openvpn-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 12:34:25 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48b0ef9c76eso347689f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 05:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791981253; x=1792586053; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FELQyf1/rs7VvZnLZKVpvyx3lvLQJbfEpvZR34QoRPc=;
 b=gMRtb3Mutn+zsXgGxzDdj9030tXLU+VH0592k+RK6jzs7cABiOpeGQcRWKJzAv7SdZ
 elNlCnByLUkDUsgiE2vEhqt9b0voaew9tWyLhYmlnGNmVJj4k1mWg7LXfu4dA6kUcVD6
 Z0P4ZbDQ4NJqW41reHSJLSGGXASJ4bUgdViQVn2sE4O8itctlie3jXXwIj/NF7rnNbIa
 zX8xkKoheeA71NeuRbGY/7evYjKOAa8QLSAPgCOWumnSQ5Gtgiywq6AsWQeU+30x5sg1
 K1j6Lw9gT9du/WwNADVBZ7RLL6TmjQP66Jru2X33M421/QQed7X4Z/kta9zVXoLkeHEP
 LXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791981253; x=1792586053;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FELQyf1/rs7VvZnLZKVpvyx3lvLQJbfEpvZR34QoRPc=;
 b=lluG2EHtjIyajKQW2Rz/gEEbyWhG5GZWQgHofLJOE+A+D88gZV5ZsT8bV3otbbzy67
 KKTln6ONG/O7NL4yH3Habm8TrcteaWVn+sy2/YlvuUoOY6Cir/9/iyAWsoPrWwGvjffH
 OspIev69ZQCKTnxLmqywjD3etbQ58ngoVlBQ039hxDyW587GD6EsPTWbLVfAaeUmALuc
 c7bThmH37bEmC9pqKH7RZ/D2QzPcj1rrRG/f7MZ5UG4Tr8M9XRdmsecw6aGoTHPwqfc+
 DgJcyoTfuO5/MlPI5FRR/Z4r35SaoqHhElK4JPmOK8sXPQXFR+SQN2fSMli73QB/vimR
 mxjg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXsD5Ygob7kj7vosX5kvAY3YqbfmD6hEdYUQSCLBwD79PNXSiQ45IwF62cmuvu3m+Fn/vcbQLxNoNPrFnM@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIfkV0jtLu41HdhnArytV3vNcoZQgr+X3FNcJvTNCeDh2GJPvgo
 zQRW/kpqHmGiZJBjr6nI8DfcUluaagk9BYecTK+F/zh8Qv4A5ggdzMD4UhMaUaHCA5hMEmngS3f
 PXFX0llT1wgmZLeT2UqnTUpfeLcoNg1M2zKh2LuFgnykZpgtajV6M2AS/DJ11i88vJ+4a8Yrwmv
 GAFv0uAQ==
X-Gm-Gg: AYBFou0T2NsgcdaUmh2z1E926Y03D/iZq6HdTyJG3GoE/mGyOqK0i+jyrbNUv0jTLDu
 kBMFY4KiaJaDO6R9TpO77zrqmiyBaFuWM8fD2VCk50Xe4ciNRYcGmEjgeXiHbPPh/7Za6PC3v9q
 Sh21hDymf5fOrtxuxRXRfeUhdIz9LkLdInW4UxXT0n4jlZInLeGqt7kwifXaYFFlpA5zFbsgM5Z
 pDZ6cc0FpDgO3jIKUhssle5ss7cv9N4xrpvEqlHH7dkcMEK0qZrYUIzGVGAAAppuDXrQU8gzRDL
 zFFelgWfxqqve+wLjJUR1pv0loux7nml/EUFCIUfkXlmMH3eLR9DlgPQh3kjPCoclNz7JjlXrkL
 CCDjMEa9dq2EfeMzCIQzcDHgxXKyu5706NIo3dJVDWqw3uJXi2OJxdvu+uKYRs80sOupi3rGn1W
 zJfs18BipObyNTu+L71Ip55SCms4Jy90uBvNX5xT3GhBvFi0OaKehKWbQR6XXpugDbnrcPmzqRB
 reJsZrlyrM0DftuFnHNCK4aLD6UTUugeThgxaydHVvniEuQJxyLIKQCdvqklNdgXOTjpvqPd36k
 3VBopW0YZskhxDUDHnbZd43t54lhzMQh8dMV+X/49gt21t/B4tbfLERIY9dt
X-Received: by 2002:a05:6000:2301:b0:488:8ab9:f74c with SMTP id
 ffacd0b85a97d-48dba77cd61mr31182407f8f.3.1791981252050; 
 Wed, 14 Oct 2026 05:34:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de70079e7sm6618701f8f.11.2026.10.14.05.34.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 05:34:11 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 14 Oct 2026 12:34:10 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e37b335
X-Gerrit-Change-Number: 1996
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1996?usp=email>
X-Gerrit-Commit: f598e350bab4a80bba9d9be162ab11485254c44c
X-Gerrit-Comment-Date: Wed, 14 Oct 2026 12:34:10 +0000
In-Reply-To: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
References: <gerrit.1791901394000.I61e29dd2af9302b240c93735179d43c72e37b335@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxOTAxMzk0MDAwLkk2MWUyOWRkMmFmOTMwMmIyNDBjOTM3MzUxNzlkNDNjNzJlMzdiMzM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <144ea8c651231f84900a854d25122dd13871f34d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGyBX-000688-S3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Replace strncat with
 strlcat
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
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8898383277699688986=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8898383277699688986==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3pEMH5FkVi8="; charset=UTF-8

--3pEMH5FkVi8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Frank Lichtenheld=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail )

Change subject: Replace st=
rncat with strlcat
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3:

(1 comment)

File src/openvpn/xkey_helper=2Ec:

http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996/comment/09a09ce8_eb5283ce?usp=
=3Demail :
PS1, Line 253:         }
> This function says it will return `-1=
` on error, so this is technically correct in that sense=2E [=E2=80=A6]
Don=
e



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I61e29dd2af9302=
b240c93735179d43c72e37b335
Gerrit-Change-Number: 1996
Gerrit-PatchSet: 3
Ge=
rrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Wed, 14 Oct 2026 12:34:10 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razv=
anc@mailbox=2Eorg>

--3pEMH5FkVi8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Frank Lichtenheld=2E</p><p><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail">View Change</a></p><p>1 =
comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/xkey_helper=2Ec:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1996/comment/09a09ce8_eb5283ce?usp=3Demail">Patch Set #1, Line 25=
3:</a> <code style=3D"font-family:monospace,monospace">        }</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">This function says it will return `-1` on error, so this is tec=
hnically correct in that sense=2E [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1996?usp=3Demail">change 1996</a>=2E To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sc=
hema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1996?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Mes=
sageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I61e29dd2af9302b240c93735179d43c72e=
37b335 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1996 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 14 Oct 2026 12:34:10 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></ht=
ml>
--3pEMH5FkVi8=--


--===============8898383277699688986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8898383277699688986==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8898383277699688986==--

