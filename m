Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C79F606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=apVWqgRB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h/aqBubm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NSCDvztb;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DJEN5JW+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=skMNcN3UUs67rZqSCUSmwoKLquBdl5mV56cZiF7hJRg=; b=apVWqgRBeiVvvF0vTIocJBwaPg
	TutGDjWPDn85dSfgheunFwG34w2cKlVRFqsYRBg69qMAuJXfKJUAi5e9W83h9A6N4Xw3sxzB5TkUR
	JLIJuz6e9Su/YtYBi/6iPvKhs1e+IvNANv/qROCEwqVV+JwsqC0qKH1QZq9oH5/EVNXI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMsSC-000000001Qx-1sIo;
	Fri, 30 Oct 2026 19:39:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMsSB-000000001Qp-2m9i
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:39:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1caPPVXh9l1ZF8r/AwM1UcsVRDnP5BwFX0JiaXNJlzI=; b=h/aqBubmkX8AwMztEmPvqyE2vJ
 V81nZ8ZEq0t+YIMqzQD/M1zf0NlKFVLNNXgiPwuejS28ojEDg2NX7kHpaz5VtWV5RxPw0DF/PizUv
 YFQfwQ5jtv56CKcARUcFYTxEbVIxDBdYFJUPa3Dy8M/7RoTftDtIjURZ/TMIniKU6GKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1caPPVXh9l1ZF8r/AwM1UcsVRDnP5BwFX0JiaXNJlzI=; b=NSCDvztblHSm1v/S5WtaezecVz
 zwCpb35m6gz64+Ck8PE/lVydyGJ2hiuLjcF76EKVI2E5dGO84LqJDAEh5Z082hpyezwKvI8wT4Fco
 3igIx06Y3UJ/w+Bn4HhNG3F/tqYnXjKf17JAuyjJIK35RwoniEbea7XnZJOYk8wgc1tU=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMsSA-00000000732-2TQn for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 19:39:55 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so6890845e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 12:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793389188; x=1793993988; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1caPPVXh9l1ZF8r/AwM1UcsVRDnP5BwFX0JiaXNJlzI=;
 b=DJEN5JW+Fs2sNwGmVfkqLLqyuumKSb67LhP1AlyROZtEQIIm7nHLcSCBP/iDUpGNe7
 ERswpNmQ37RtukA6ZjYiT5DQbd8oT7z668IKrHsJaeMyvnSAdxY4Ir+/tJH8qEGUyRf8
 ZhPKO0zV7KzQXX/XaLzqK/MLSNr5HWdFr4XJTFeaEYtrLjIaLxXJp2hb1EF9jiENXARi
 bHLcE+1AEXQylSEz+PwAVoZm8VcRCukQfyY/odhIaWmam5TFJ37ovzWsoiYIGc6WrNf3
 VABq+o/7yVkOJFyTZ5TFv8GG9GIOjGRdC7MV5eFmt8rk+wLImU7OttAaFmlpW4QTB/HA
 rouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793389188; x=1793993988;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1caPPVXh9l1ZF8r/AwM1UcsVRDnP5BwFX0JiaXNJlzI=;
 b=xWxp17958QLGpb6kmFGm/qJX8yDF9J1Y+PJofUiJMa+vTjvexnZDSvM3wMA+oINN1U
 qm0bgzj/ZgvsgB4ayTed785kFLDZEfZNotGm64PGi/6jtAYv7l83Aq8dVGdukhTymptV
 /Z8q/14NrDTdV74WygBzXHgldlqSn1cm+4hsO+mCZW4vLPJoamG6xD+TP8duXiYl3HWF
 dGzswR6MAmZ3WIhzrrRWvUhM44BmhS8KJS5mqhnXu98eMsSYX4hcuipyQq4GCYCpY6J9
 vn+Jnn+jPHdkRrebZ7mgamkeHZwFNqfxyvFJR1LTatSjferLl5IU0Mp0GIl9wsSUOPYH
 9naQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2+YWzMvmsxBEAFjHRmLfmLLI83j7vR30tbertGX8ShpxDOnUNPTRomQzM31DPcGXTD7y/yTjJ3yjURLc/@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIB7IT7htP3eSbmoGE+m0joGL4tarFXFFKyjTNyqk3V3kRJ102z
 KkW39/8YOz4sp7WhorRNtNtms1Y7GlxjKRbMyk+aV4eDEBVEv6Z/RBKSZar3eIYvFSTlZAAatnJ
 21Sv1WlAeIoGmXCSqzt4iQJEGHNi46KHPkT6m1AMHQKiKeDA4ohWmzCcrW9O344oAASG/
X-Gm-Gg: AYBFou1kyyimk6Q8xNmxZK1LUB6l1K/oc/0vX+DLhY4KWHkD5mDUF6f2d5VEJkYD5KL
 eVeK5ZnFZvEAkUvdcPAP71ZXogLhoqYM4v43vurdCY/jySJV37lk3uLBsDrTUQBd76bqB2WEDpx
 xrviHCP0TOudyO00rieg1ojFNi6z6aZ7FeAJJ5PEzlyuZWHcXF6Pv3TP+xtd+VcUzvkRsuB2R9L
 X2cvN6NHxfrcKz3qk9467oKFcMFxwanhtz/UIwyP7MS25PwebRAT/KpfhW9lspRaJmc7pNtleLg
 IvwZ37sF3Mc1OrsjgRWEvfvyRLWu6BUoNNtzndR36qNg4LVDSmBevqB5yFTnHSkanszO+nZtmWM
 EkjLd32Xbzk+aq3fw6xObps8HNwYOC4VNyPFf8Ulb4NYLPFSOduMrP7GmkQlpxvX2FIii7M+ssL
 Y3eqVVCYXQuzUZKZxJhwV+k1pFNWPWwONyeq3IsapAJcpXMpzfuQrPADY/vj72iYgKDvasHnuoE
 Phx9fhwOiIBh/Zfhzttj7gVxxlMyAn18tiXjTnoLZn4nWvagBE6UCGg6z8boxt7Miot0ojSCauT
 WnYIcUDit8rF5O7zVeGY/iVGrVBn52ys1tK82rPPNukNFWZ/cDU3lNYK+csHiFSO9ohU/Uy7HDW
 HDNuTrI2W/N2Tsy84CHRsr4RIoJ059Ybb5WNHqw/YwDZyN7gz1N4AhdMOd79fA+updahZWmiEr9
 ODRiF0Qs6fpuVuFFs=
X-Received: by 2002:a05:600c:470d:b0:4a2:191f:7cb8 with SMTP id
 5b1f17b1804b1-4ac1899378bmr73810245e9.17.1793389187850; 
 Fri, 30 Oct 2026 12:39:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ab69b54742sm199247295e9.15.2026.10.30.12.39.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 12:39:47 -0700 (PDT)
X-Google-Original-From: "Selva Nair (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 19:39:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: 971f07290d2686ee2f082a305030d27a782a6dce
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 19:39:45 +0000
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4b7515ac50548b535634205cc8c4e83fe8a4a48d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 1.0 (+)
X-Headers-End: 1xMsSA-00000000732-2TQn
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD 'Auth' prompt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Selva Nair \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: selva.nair@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Selva Nair \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5823151740126618225=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5823151740126618225==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1ZK2Zpk5aYw="; charset=UTF-8

--1ZK2Zpk5aYw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

Selva Nair has posted comments on this change by Selva=
 Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail )

C=
hange subject: Optionally indicate username in >PASSWORD 'Auth' prompt
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3:

(=
2 comments)

File doc/management-notes=2Etxt:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2069/comment/da904184_1ff4832c?usp=3Demail :
PS2, Line 413: =
  as in example 3 or example 8, as applicable=2E
> Example 2?
Done


File s=
rc/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/com=
ment/16d162bd_8d3baccc?usp=3Demail :
PS2, Line 3675:             && (man->c=
onnection=2Eclient_version >=3D MCV_PREFERRED_USERNAME)
> The HTTP proxy pa=
sses `GET_USER_PASS_MANAGEMENT` from `get_user_pass_http()` in proxy=2E [=
=E2=80=A6]
Both 'SOCKS Proxy' and 'HTTP Proxy' username/password request wi=
ll get handled the same way as 'Auth'=2E This looks desirable=2E 

But thes=
e addiitonal types are currently not documented anywhere in management_note=
s=2Etxt -- I will add them to example 2 and make Example 10 & commit messag=
e more generic=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2069?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 Iac23d5141a8c29e239d0f2aeea497d3a002e609b
Gerrit-Change-Number: 2069
Gerri=
t-PatchSet: 3
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Li=
chtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eor=
g>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Atten=
tion: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri,=
 30 Oct 2026 19:39:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
C=
omment-In-Reply-To: Selva Nair <selva=2Enair@gmail=2Ecom>
Comment-In-Reply-=
To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--1ZK2Zpk5aYw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>Selva Nair has posted comments on this change by Selva Nair=2E<=
/p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demai=
l">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/management-notes=
=2Etxt:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069/comment/da904184_1ff4832c?usp=3D=
email">Patch Set #2, Line 413:</a> <code style=3D"font-family:monospace,mon=
ospace">  as in example 3 or example 8, as applicable=2E</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">Example 2?</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin:=
 0; padding: 0;"><p>File src/openvpn/manage=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2069/comment/16d162bd_8d3baccc?usp=3Demail">Patch Set #2, Line 3675:</a=
> <code style=3D"font-family:monospace,monospace">            &amp;&amp; (m=
an-&gt;connection=2Eclient_version &gt;=3D MCV_PREFERRED_USERNAME)</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">The HTTP proxy passes `GET_USER_PASS_MANAGEMENT` from `get_us=
er_pass_http()` in proxy=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Both &#39;SOCKS Pr=
oxy&#39; and &#39;HTTP Proxy&#39; username/password request will get handle=
d the same way as &#39;Auth&#39;=2E This looks desirable=2E </p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">But these =
addiitonal types are currently not documented anywhere in management_notes=
=2Etxt -- I will add them to example 2 and make Example 10 &amp; commit mes=
sage more generic=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail">change 2069</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div it=
emscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D=
"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=
=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display=
:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-=
Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iac23d=
5141a8c29e239d0f2aeea497d3a002e609b </div>
<div style=3D"display:none"> Ger=
rit-Change-Number: 2069 </div>
<div style=3D"display:none"> Gerrit-PatchSet=
: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=
=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 30 Oct 2026=
 19:39:45 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div styl=
e=3D"display:none"> Comment-In-Reply-To: Selva Nair &lt;selva=2Enair@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83=
zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--1ZK2Zpk5aYw=--


--===============5823151740126618225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5823151740126618225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5823151740126618225==--

