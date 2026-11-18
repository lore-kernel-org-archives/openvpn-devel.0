Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A56606A32A
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q5dh3aUr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Pbwo5lhs;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PQhSM7y0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Q9xrG3JC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ht+MDZ06GC+H08wldC2aL44n+inch0ue9ty7eopl+9U=; b=Q5dh3aUrcjZNVtOm+Myx6fbnF2
	N2wluGXkUqlZtw0zyRCyU3LHh8QEDGvmSvfEcmiFXQPSzgjfp84/OH1Q5jN9phXbtdcP8QYPugeoS
	8xI+iqw8EsruAasXLA44ADe2aKs/V2IRTH1k9NViEBgC85/NFH2d8exd2oUV4i//PsXg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThCV-000000005eM-1Wnh;
	Wed, 18 Nov 2026 15:03:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xThCT-000000005eE-3qQw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:03:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjnJUCfUtKGoxfOVgSbyQGeK/3edD7fGUfQNrMyxou4=; b=Pbwo5lhsrMnB7Dh2LC1e+KQPLU
 LEFvgfTkHRKQhueUqhjOzrLrvdAeXrrck/yjPog3i9oSDlrNrNlnptrhopPEHqzrREZx+3vWS70yD
 beaxW6D4/SnFxXCwZFGA9xogkyCOnt8dJffy3cd5oAKbBpHa5LKtInKO5GWaTptNZ96o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kjnJUCfUtKGoxfOVgSbyQGeK/3edD7fGUfQNrMyxou4=; b=PQhSM7y067aS2A8O8Z1OlGAROP
 HSJhgz3/WgMrN9dP8kyshH/gQ0c9zGErgm/K3G1trog2dpR5fFpHTUEOj3jCbfI4hSb0+aKGYDa25
 cD+e5AShb+V4qmcsK00z1YBX/U0B6NDOaBZV71oJxuR3Ru8d+MIgLalUuIo4EZDqzO+g=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xThCS-000000003nX-3UWB for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:03:53 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so12146835e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795014226; x=1795619026; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kjnJUCfUtKGoxfOVgSbyQGeK/3edD7fGUfQNrMyxou4=;
 b=Q9xrG3JCFsfdq18Mvj9UB34mv6uyk7kuxXcBjMncVW3UAxTyxTf5iv8mpg52L4OZnn
 eG8zvHehyDbt7G5TE1Od3Kt3YsOHPVTVhoXtZzjJg8GUq+oTOniWQ49UcFuVNMhPW7/D
 NA6Rf51i8vUC9o4bsPHKrbzuihi85FFnpB/5tWnjsUFkIgLtnQP/Rkv233ZBbReBQODS
 +oai0WBz9458+IyaL/Asxv7E1R9v6fVQIU5yjffPT2SZHnEHNhOkoy05qnQ30tIsVTMS
 JtKXTNG8/+r42WS1dQiy0uwjnkSwhUhtkmcWQ1DKHuLTyTQ3Ekq4weun/DmU48guEYES
 Wnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795014226; x=1795619026;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=kjnJUCfUtKGoxfOVgSbyQGeK/3edD7fGUfQNrMyxou4=;
 b=yly2wTzAkfZaQxejvys88bwtoMJJW7gFmWuxGjdSP0b+ANCHz0rQlNoZwXrtDZ1OfM
 b8MhLbZhht08c3+tO9zKoQErLVYntlJ0ZAfEKfqb5/um2Rp6Z36VfZl+klatcCo0AdwO
 OsmPYLi8HCR4G6GbJM0WlyPNrW2+wKScZzlACY8pyGMhVaazBPInfpzz1xIGyLhDp5QF
 VVp/yd/bpurvBX2EDSSBB28t5ZpDy39DSY3XQzWl/y+zeL4t8US5H0AUswf/7i7CPp22
 h5aj+Ca1r6+hEv9jTTCxjHLzD9b0EUaxqp5Bt6Loi04YuUqO0uxyNxocX5j5nRh2OZ7r
 ZAiw==
X-Forwarded-Encrypted: i=1;
 AL+hErF43oaH9+O6CISeqAiXhxoYLVJZzFmzSh4gPvTWoJvgeHXgWf2oPfjJn3OI1qEAxLBICedXnrrkRk8iwofL@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8QnTEDDhgLbuW5XxR6Y4mRLBPhimmJWs+qWZ2I6qDW82SVwXec
 335+s7msapGCQVenHH9X8fv8JmOXQ7ORA1m+69VOpgBEnn/ooB5sZGhwvaIZpOyxbI99WuVPIvF
 z0N75JWNpzBf/xD8MPqHjKoshAW6Uk33AGI8CrZ12AO8iFWo8FSqTDz5WDf57FKb0s0e15x1j7U
 Z079xHBQ==
X-Gm-Gg: AYBFou3g5S4cicjQGKNvwGbkQXdFtT/RjwKL+KxJUx2l7saVijpv7yqGyaD0leb685w
 dcXEhwBTnbqMfYwRsOz/E5nAYVIwLXQR3KFcbAxdT9idB99L/AjqKHNg2NdDZJBozc8r+T2uW8A
 mhwz3gjPCd5QPZwHwqGadbkEpb/XEJTv++WPPvFF7Mwxvwpbb7XKPAHadFRG9vv50KC7Ol77XB7
 Zqx139GLxVRroEyqTozOF4Jz6NwIavqzDqN1NEkyMQhBobVbXWbwB5avcGX3xtrcw5RzYqbZr/3
 6lpbNWD6791ylZDUohpClhvkmlvGTYfKibTGy7ADvjVkstrrS2T6Z6P9CnCoeZ4gFQStqMoJpDI
 73nfdAXkDqDuB5XyptTohCoNKBsy6KoWjqsOsNWHyo21YJmRroCLV/jlLJjI0rJdCIXyQ5XlKoI
 fjETKhsbkp0BnX7YplrYH7xyguxOAigmz+SxhGuWq+CCs7Pgg3Yx7rny0qQaY7Fd7yYVY3rVhX4
 5bsg8yAwZSKY1IDJ/KJuXz9H3QjdsM+MZl7CE7bBLY19+CLxSFiBH8o/wXuTxx7X0yaB94j+WlN
 d45Xkkjo5rwK3rqxf3lEM5TNkSJXOvH/KpQscCp//pfdywfrpIqzYBWzDrGh/x+T+jcOGXRWkMg
 SfcC2jBOTyJhWkKQpo8qxvopXC3YZTdxJVc210VRlDmgoUgKSaFP6DzOLrfZQonBvWi94Cql9rX
 evdy6aqkeko5tVPD1ab/APbVOQ06j+/ur+5jrw
X-Received: by 2002:a05:600c:4e11:b0:4bb:6a2d:b438 with SMTP id
 5b1f17b1804b1-4bb7d578be5mr62349935e9.0.1795014225864; 
 Wed, 18 Nov 2026 07:03:45 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7e50e992sm36334955e9.0.2026.11.18.07.03.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:03:45 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 15:03:44 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad
X-Gerrit-Change-Number: 2217
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2217?usp=email>
X-Gerrit-Commit: 86b4a70d6fe72b7bfdde90600c8601f0a4b76b3d
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 15:03:44 +0000
In-Reply-To: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
References: <gerrit.1794991626000.Ia48c1efc9a687383a1dc87edd49d8ba3eb5a87ad@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkxNjI2MDAwLklhNDhjMWVmYzlhNjg3MzgzYTFkYzg3ZWRkNDlkOGJhM2ViNWE4N2FkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2b98c2bebe60b0aefa935d25f068fa3568bbe28f-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xThCS-000000003nX-3UWB
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify: use
 check_for_client_reason() in tls_authentication_status()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============1265598566432024754=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1265598566432024754==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HtFw21SkGz8="; charset=UTF-8

--HtFw21SkGz8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail )

Cha=
nge subject: ssl_verify: use check_for_client_reason() in tls_authenticatio=
n_status()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 1: Code-Review-1

(1 comment)

File src/openvpn/ssl_verify=2Ec:

=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217/comment/0609b7c4_71a4f3e9?u=
sp=3Demail :
PS1, Line 1167:     struct gc_arena gc =3D gc_new();
I would m=
ove this gc into `key_state_check_auth_failed_message_file`=2E No use in it=
 here=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
217?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia48c1ef=
c9a687383a1dc87edd49d8ba3eb5a87ad
Gerrit-Change-Number: 2217
Gerrit-PatchSe=
t: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Revi=
ewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lich=
tenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@l=
ists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@m=
ailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
G=
errit-Comment-Date: Wed, 18 Nov 2026 15:03:44 +0000
Gerrit-HasComments: Yes=

Gerrit-Has-Labels: Yes

--HtFw21SkGz8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_veri=
fy=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217/comment/0609b7c4_71a4f3e9?usp=3D=
email">Patch Set #1, Line 1167:</a> <code style=3D"font-family:monospace,mo=
nospace">    struct gc_arena gc =3D gc_new();</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">I would move this =
gc into `key_state_check_auth_failed_message_file`=2E No use in it here=2E<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2217?usp=3Demail">change 2217</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2217?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: Ia48c1efc9a687383a1dc87edd4=
9d8ba3eb5a87ad </div>
<div style=3D"display:none"> Gerrit-Change-Number: 22=
17 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Nov=
 2026 15:03:44 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</=
body></html>
--HtFw21SkGz8=--


--===============1265598566432024754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1265598566432024754==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1265598566432024754==--

