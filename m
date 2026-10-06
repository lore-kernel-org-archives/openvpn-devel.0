Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68ABBCA5FFF
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 19:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CKC2lGBFeMRWXKAPA8my4TaELEdWuIGS9ZZv24B05JU=; b=VU3J3voE5TRdVBGYf9RtAs02SP
	GQVeENoxcmQXcuNjQwGtSkuLWi20fBCXBNRlbMzNzy1QyuBzL5O4cGlLmPIBtmv+Up+MjDB6/Ukcw
	BMKta1HonkwQjY7Blea+erV7pymLbS1Wc/6JtQ4+QTgbBUrYHpol3c9jwjHV4dBZzSdM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEApI-0003am-JB;
	Tue, 06 Oct 2026 19:27:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEApH-0003ae-Cy
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 19:27:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gHVzy0G5rOpQlQep+O3x3GHYH5FwvBTftYhSpEHaKkA=; b=gGT+G1LfaDX2Vusr2JFIBGvLMb
 ndp2fTWOmUDHgXVL7hO8SVfiYa2ww5hEIf/r30qjgM68L6EJXn0CKvTu4V5ShHdjV0/4TainwOqNZ
 OGx+vZw/An2pKlCWhbehgqmQeLkciQT0B5LD0YbOWNr2y42F6bGB6luxHiFA0HORZJbY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gHVzy0G5rOpQlQep+O3x3GHYH5FwvBTftYhSpEHaKkA=; b=F
 vH7tCJ5/Bk+7P+kJ4r8Pc1X/xSMZVYjve16CvZ7v+zMRgGGoGwmlYSPBWNOOkO9l9uRsc3y7G8i5P
 DYZ7a1ss1kDr13RhNeQM3+pUarSYRWV8xVUcAaac8p0WKZNRlo6QshqROxdQimjkiBo71hQPXUBQf
 J7lPzd8Q4RsARobs=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEApG-0006kp-Hs for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 19:27:48 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a0213948d3so7583845e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 12:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791314860; x=1791919660; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gHVzy0G5rOpQlQep+O3x3GHYH5FwvBTftYhSpEHaKkA=;
 b=GxktYUIAKFdwJmEbC1sbL4guQqZbwbh0yV7zEUxNcVHoQlz134JXoIV1CgLAjEwK4k
 FaeP2Y3K+YRY1Uhx6NGYe+eWWxcLGM9zJXv0/Z/0LMBvIXlHyxEdA69HaqTcHL3qQow1
 urW5Erm+f9tUkKYcFnYjXuIw4FurcM9gQCyVACiv1UConvwX9lmDyYDHwGm07gUIxDzz
 fZe2uPwZ8jJWiCtHh3LfLm3EfLEsaDAYaXyv+2Smr2DtfxgQvMQuPjRt2BsRVXIPqnDQ
 TTEg/gfG+sYylNVbcq8Uk1os8kCglbgR+KYDHqnu1t8rvRaTSu2E5/brHJOU20PvxWfJ
 4vcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791314860; x=1791919660;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gHVzy0G5rOpQlQep+O3x3GHYH5FwvBTftYhSpEHaKkA=;
 b=aS9MqAX9TkAg1mFIGiZx2rZc8uA+fIXrzpDERgqTG3BkZXR8luW16rqzU9rO76FB3E
 CLeD0ExyH4RLhaXJc4HxI9owtzsCKTzglwmNf+cDuadnCWncVl/2jjDqM/6Sw+zMqnYW
 gYuPFZdFp90a9w7ruNgvudfpOZmugRg9srYdbv1o8U1Q6jwvw55X3Vcjginc8ymLnYqp
 QYh59m8JN9RMm9K1Nd2YDVr7C7zpv7JUYVlkQldNdSnCFb6z1yoWqqWPO+RBHA94pjZP
 qPbdo2LF0CJW9BSqj4i2xBDF4E1nuQJEx0cKZoeOJ+RpSQ6MlD4f4w5jC1Vcfd5xSEBS
 76gg==
X-Gm-Message-State: AFuF++nPu7lzhe2XzRzVFpyNW5WCuM8dohTyoJm38BEmxBf1nYNgSdf3
 DPlablNjZ6mNfXLcHTkNKV3pGbVQat427CFxYGJa+rKp7uHAWahoSYwyOhKkRcSl/lPu4Goo+ad
 PPyCeg928KPeq0eYxz7BjoQfp+8gaqe3wM7ojcFMkoq5y4xttkimcn+zTVPaupsj8T59i
X-Gm-Gg: AYBFou1pD8T1UyCJpmDg4etRbuQ4g8ZzoB9wcYaCUz7DL6Sgj6ERF3RZS+DosMTje3U
 PbMSpw91DzX/eZJJ5fumoDzs2dXyw0Zzjdnxuh0GbFa7dZfwzBxF1lysPiASHe4XmBbrOi2VUVe
 7JTaXDQC8Rp3pEP4nC4uLnnkRfvo320dGzfW5mZj/UX+joLqtB3BFB35g5KILsqvGRQskHdubxV
 GKQVtgMNbEbpNeSjXkbwZP5dJIoe0pNi5cgltBc4ULK7xc72pW2iOc4iFYGWbEUO1xFe6E4IxD4
 4Fo2o812s3RMxsbhxkw/3NDO5NsGlcpdPSAjLp+l0faRfww67eBW3MJ+Nnoy4ldVjug/gzSyf42
 YqgClLJmG1LkOHy0v+hBZ0NzJ1d2xv3K1hlmIC3muf3LHu18b24g4c5yavyPM8Yi1FDTnXoRoqJ
 MrwG42kfbVLFAGq/gjyKns6APJNF7TepT70fCtA20M/eG4Q/S8rHGtjyE/Pde+h7oHALo0f4xmo
 FhdkoxI9I5QUVLhk80FPWFN142d9AXE3IBlcC7efrfvWoQCRkV7h9hXIOCV0ptJoRLaj39H1VUE
 qifP+j0pxfT/tKrn2H9PL2bshcqZrZjQQLA47C9i3bl26EgMkErEWZQuq+EH
X-Received: by 2002:a05:600c:348f:b0:49f:ce78:356f with SMTP id
 5b1f17b1804b1-4a17b55b587mr41475175e9.32.1791314858446; 
 Tue, 06 Oct 2026 12:27:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178a175aesm122027875e9.2.2026.10.06.12.27.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 12:27:37 -0700 (PDT)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 19:27:36 +0000
To: MaxF <max@max-fillinger.net>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce7626d
X-Gerrit-Change-Number: 1985
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1985?usp=email>
X-Gerrit-Commit: 839053fc589d76782e799c427b5f9cce59aa2221
X-Gerrit-Comment-Date: Tue, 6 Oct 2026 19:27:36 +0000
In-Reply-To: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
References: <gerrit.1791310661000.I64920ed9f714803604d76c6df6b38cf20ce7626d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMzEwNjYxMDAwLkk2NDkyMGVkOWY3MTQ4MDM2MDRkNzZjNmRmNmIzOGNmMjBjZTc2MjZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3ca45d8f11202f0abb7013aabe18c16bfdb1bc02-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEApG-0006kp-Hs
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.5]: Move
 check_session_buf_not_used method into the method that free the ...
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
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, max@max-fillinger.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7294498100013722274=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7294498100013722274==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1+S7Gglfvjw="; charset=UTF-8

--1+S7Gglfvjw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF=2E

Steffan Karger has posted co=
mments on this change by MaxF=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1985?usp=3Demail )

Change subject: Move check_session_buf_not_used meth=
od into the method that free the buffer
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(5 comments)

Pat=
chset:

PS1: 
A few whitespace nits and one change that looks accidental to=
 check before merging=2E 

Reviewed using git range-diff to check where thi=
s differs from the commit in release/2=2E6 and ran local smoke tests=2E Tha=
t all looks good=2E

Would be good if @arne-openvpn@rfc2549=2Eorg could che=
ck this too, since it's originally his patch=2E


File src/openvpn/ssl=2Ec:=


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/bac2a286_9d1390a6=
?usp=3Demail :
PS1, Line 2276:         if (session->opt->pull)
Whitespace-o=
nly change=2E Not needed, but doesn't hurt either=2E


https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1985/comment/07f8dfa4_6bbb559d?usp=3Demail :
PS1, Li=
ne 2453:                                  || multi->multi_state =3D=3D CAS_=
SUCCEEDED))
Another whitespace-only change=2E


https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1985/comment/56f38879_ef0dee78?usp=3Demail :
PS1, Line 3106=
:             "still in use (tls_wrap=2Ework=2Edata)");
Whitespace-only


h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/10450665_3180dcea?us=
p=3Demail :
PS1, Line 3250:             "session promoted to %strusted",
Th=
is changes the log message and logic around it=2E Is that needed or useful?=
 Or just accidental result of resolving a merge conflict?



-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn=

Gerrit-Branch: release/2=2E5
Gerrit-Change-Id: I64920ed9f714803604d76c6df6=
b38cf20ce7626d
Gerrit-Change-Number: 1985
Gerrit-PatchSet: 1
Gerrit-Owner: =
MaxF <max@max-fillinger=2Enet>
Gerrit-Reviewer: Steffan Karger <steffan@kar=
ger=2Eme>
Gerrit-CC: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ma=
xF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Tue, 06 Oct 2026 19:27:36=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--1+S7Gglfvjw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF=2E </p>
<p>Steffan Karger has posted comments on=
 this change by MaxF=2E</p><p>Patch set 1:<span style=3D"border-radius: 3px=
; display: inline-block; margin: 0 2px; padding: 4px;background-color: #ffd=
4d4;">Code-Review -1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1985?usp=3Demail">View Change</a></p><p>5 comments:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><=
p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985?tab=3Dcomments&amp;usp=3Dema=
il">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">A few whitespace nits and one change that looks =
accidental to check before merging=2E </p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Reviewed using git range-diff to=
 check where this differs from the commit in release/2=2E6 and ran local sm=
oke tests=2E That all looks good=2E</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Would be good if @arne-openvpn@rfc2=
549=2Eorg could check this too, since it&#39;s originally his patch=2E</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=
=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/bac2a286_9d1390a6?usp=3Dem=
ail">Patch Set #1, Line 2276:</a> <code style=3D"font-family:monospace,mono=
space">        if (session-&gt;opt-&gt;pull)</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">Whitespace-only cha=
nge=2E Not needed, but doesn&#39;t hurt either=2E</p></li><li style=3D"marg=
in: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/07f8dfa4_6bbb559d?usp=
=3Demail">Patch Set #1, Line 2453:</a> <code style=3D"font-family:monospace=
,monospace">                                 || multi-&gt;multi_state =3D=
=3D CAS_SUCCEEDED))</code></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Another whitespace-only change=2E</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/56f388=
79_ef0dee78?usp=3Demail">Patch Set #1, Line 3106:</a> <code style=3D"font-f=
amily:monospace,monospace">            &quot;still in use (tls_wrap=2Ework=
=2Edata)&quot;);</code></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Whitespace-only</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1985/comment/10450665_3180dcea?usp=3Dema=
il">Patch Set #1, Line 3250:</a> <code style=3D"font-family:monospace,monos=
pace">            &quot;session promoted to %strusted&quot;,</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Thi=
s changes the log message and logic around it=2E Is that needed or useful? =
Or just accidental result of resolving a merge conflict?</p></li></ul></li>=
</ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1985?usp=3Demail">change 1985</a>=2E To unsubscribe, or for help writing =
mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1985?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: release/2=2E5 </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I64920ed9f714803604d76c6df6b38cf20ce76=
26d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1985 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: MaxF &lt;max@max-fillinger=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 06 Oct 2026 1=
9:27:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes <=
/div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></=
html>
--1+S7Gglfvjw=--


--===============7294498100013722274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7294498100013722274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7294498100013722274==--

