Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F4C5C61DBD
	for <openvpn-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B+2QV9w8GqPNn1w3o+InjbUrtD/y3eux0kHVRvoOlRw=; b=dGXKkiniqSTM0/UlFr/K8ksQAz
	oyfTudjPfCOfW2VT2qgf+RwCXjFl6ZRfdusAXD++nKGu5AJCI2scmosVRSrAFIqPitoWBASRyLTVN
	YOPXZELMvT4XOqpt4VhV5DsMJ0GlVJRr6s3kOpPMUfEPh9TqLGct21rhmNpoORZ45GAg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzGPT-0005Jw-29;
	Wed, 26 Aug 2026 16:23:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wzGPS-0005Jn-Gb
 for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:23:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=kY7GVvfjKwu9PfwWP+9bF/URqnhsUYjAEhcnjGcKqYM=; b=TzQuyZiOA/x2K3kvWKh2qAl6uY
 IqVaK8hbweHIVVTGV592GebZ4OMuD9a2dRdjU54GyOf/SE6FzLHhP26iZ77AOV1p5WDNGy1e+jcKn
 K/kYcYYFr13HWTGJMQAsWL/MVVZQVgv0rqmkP6+PK571hhmTNrMKpQsgiQsyDvjM9Ii4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kY7GVvfjKwu9PfwWP+9bF/URqnhsUYjAEhcnjGcKqYM=; b=O
 FIR8r/RRfqQF5XBZ5pg7xcO6sFnnV8HITfAbbJfkfaJg36g9THOw48JNP6Y6fG1RQxSmp4iniX6L2
 ZhAU7kJrBzBU78T8+uMb+hbqMXVi4O+2ifzH0whuy0ynHeCmk66u6+EpdjmcJK+Y1f53ZmmwDWk1D
 HcBMYDFPgzTDoBkI=;
Received: from mail-ej1-f50.google.com ([209.85.218.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzGPS-0000eY-CK for openvpn-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 16:23:31 +0000
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c15cf78d1a2so147496966b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787761404; x=1788366204; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kY7GVvfjKwu9PfwWP+9bF/URqnhsUYjAEhcnjGcKqYM=;
 b=D2I8GYe/bVBXB7r6/xcSgWfyEi8CVOnlq0VXZ/Yvbou8Y05rAiSA7Pc89bODK0zl0e
 8i/idLdgNOkV7y7ZRkb/bh6FazsxBSicT6cgutJtFVZeEgIyW7p216wgYx11416Tybk4
 Xl0uRIkByPOVcvX7BSTto9ChdcfGCIe8efWAjH7uYJlYDAnskv6mViSeMeGJ9BJBYo4i
 3JiAh6i06yxLeZWxqHOb2nF6DhWrbs+WIvwtIAvYd4GxQnhC1OJEaJ76pGvfYWvjHHZG
 uj3weYBr+OFaNmNjxEKJwedlH8MiaJFDoDzotFdZtauBs0Y1RBgqECGb2CkwTlCx7BOd
 SP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787761404; x=1788366204;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=kY7GVvfjKwu9PfwWP+9bF/URqnhsUYjAEhcnjGcKqYM=;
 b=m3PDgAtRQEk1E0JcZuIA1VpHzOpTlrXBOt9XfrUyyRW1jUUQOe6pkpDA2C+oYZs/uC
 96VaQ4rxx24LZ41oMbLaK3fcsuyE6LQCx0lglS5db31acsl7Ak+MxXlziR1CSzlQ1Yry
 mzuTC6iDWgiNTlaA4+ZIYW+7r/3bUF6Bq10IHaiX8Uxt2p88gS6QcpZix19NiqZdDw9o
 +HUFSouU+4mt+CLs5GMoeIj39Vo6Tec+z9MVaD9Ti3sgkB7TZxwVphTjRqaWSOpx85/0
 r/ZRuyuhOfA8X2RBMNKpvOtFcsvUoPQ963rF6ZZURRLttrV60llmh9807IKPZdR84lIc
 qC8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHbTQnax8nDbJtfKco1RL69z7N8Tj36f/Q6BdV3/LkfCLw4r2bknKFYKyBzqW4Iu/Yp0fP15lb04f1Dlf8@lists.sourceforge.net
X-Gm-Message-State: AFuF++lm07ciQ/VPOvg60rAd8VADIEEXwh+R7SgEqAn+U0oy8dpRi1PS
 QXUvQeaMJCUAuzrvDQEDmecGeaMC/jz8biq5RYVe5ir8FSai9nuT12CGjbFJIWa2diWVxPQUMTU
 75raXbXNUidW8JOeY5mSXMBREPMQ8RhD+K4vkREayJ5MB8y1lAZsta8f41WbNrFoOJzne66YhFq
 lFdBZDMg==
X-Gm-Gg: AR+sD11TmXnuCX7z4E1YO7bzeZTZ4q3XdieV+2CMfnHBwLnhaHLxRsjxKdurGacbv+e
 EZuF/ViN+gq3sd2H2VQO4Ch62LbBng1Hk1xIODok6U59c7tmCpO+yoaLZmYJB9NUdydkaq3ryw1
 c24eKPPfgAuLkJmUeW9hLr5qcVBZw72d5DBw2BUVrrjawY0UXQebumZbwOH4E5bkfX+KA/e1WPP
 QRiQWmfDbqnI9TqZpXd0taUQaJqk4uOFlA6VR7inUu8VqXEciokkJ+Iea+nKJBpOU1sx6+LdoqF
 dTy2a7vByOg9wbe0qyrXzqZojO1o1tP4335Z5Hxif4n3Iiwe7kInj2o2aNU9YIdUWkIgDPkHK3Z
 gLkEzcoLHYgR+i/zoV6+gvG4Fy23cps2EdiRqS4o75WRm7Vb2M2fBo0JzL13VwIcC2I7zNG5CeV
 +h2cZ9W1BkLk3XwLprPxPIlTV5/RHiWfBv1OO8Aiit42ts6esJj5OGDQRLU7BzfkQnwr4MoxP+F
 dQKKBceempAZrWBEmo1OXsVV9SiI2+XuOpa8w+o5s4mEqjvhrTjHQi2YlBLcOH14KiGAhYjzsG4
 kjYwMfpWOJgMwWYQev/mOjiT31xS8ZPLWIZJXgARVD+rwsgkPw8QZDsyo6o68w==
X-Received: by 2002:a17:906:4fc6:b0:c21:9870:c4f7 with SMTP id
 a640c23a62f3a-c250c32b599mr976004666b.20.1787761402130; 
 Wed, 26 Aug 2026 09:23:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a6fda4fsm648655466b.16.2026.08.26.09.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:23:21 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 26 Aug 2026 16:23:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
X-Gerrit-Change-Number: 1856
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1856?usp=email>
X-Gerrit-Commit: 1e7ef53850e82f41b9691003c30f1f125e2a60fb
X-Gerrit-Comment-Date: Wed, 26 Aug 2026 16:23:20 +0000
In-Reply-To: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
References: <gerrit.1787327336000.I42d8785959c24bf688190965e58b9b98251b8557@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0MmQ4Nzg1OTU5YzI0YmY2ODgxOTA5NjVlNThiOWI5ODI1MWI4NTU3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <571cd685b87db4f97b8d34da33ff8df1342c6cf8-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wzGPS-0000eY-CK
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 get_key_by_management_key_id helper function
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
Content-Type: multipart/mixed; boundary="===============4000567835253186614=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4000567835253186614==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9o6nTIS2NkY="; charset=UTF-8

--9o6nTIS2NkY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1856?usp=3Demail )

Change subject: Introduce get_key_by_manageme=
nt_key_id helper function
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 6:

(1 comment)

File src/openvpn/ssl_common=2Eh:
=

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1856/comment/af028c42_ec4c2b57?u=
sp=3Demail :
PS6, Line 775:             return ks;
> The old code did not a=
bort on first match but always checked all three key states=2E [=E2=80=A6]
=
So each key_state has its own unique mda_key_id so there is only one valid =
key_state with mda_key_id, so the code does the same=2E But valid does a bi=
t of heavy lifting here:

If state is S_UNDEF, mda_key_id is 0 and 0 is als=
o a valid key id for the very first client=2E So we need to check for S_UND=
EF to determine if the client actually the one with key-id 0 or just not in=
itialised=2E 

As alternative we can change the initialisation of context_2=
  or assignment of mda_key_id_counter to start with 1 instead of 0=2E

E=2E=
g=2E

session->opt->mda_context->mda_key_id_counter++;
    ks->mda_key_id =
=3D 

E=2Eg=2E something like:

    index de9303b30=2E=2E478e4d314 100644
 =
   --- a/src/openvpn/manage=2Eh
    +++ b/src/openvpn/manage=2Eh
    @@ -69=
,6 +69,8 @@ struct man_def_auth_context
     #define DAF_INITIAL_AUTH      =
     (1u << 2)
         unsigned int flags;
     
    +    /** Identify the=
 key id in the management interface, always 1 or
    +     * or greater if =
valid */
         unsigned int mda_key_id_counter;
     };
     
    diff -=
-git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
    index 82d7daeb2=2E=2E3=
495f9dd7 100644
    --- a/src/openvpn/ssl=2Ec
    +++ b/src/openvpn/ssl=2Ec=

    @@ -870,7 +870,10 @@ key_state_init(struct tls_session *session, struc=
t key_state *ks)
         ks->crypto_options=2Epid_persist =3D NULL;
     
=
     #ifdef ENABLE_MANAGEMENT
    -    ks->mda_key_id =3D session->opt->mda=
_context->mda_key_id_counter++;
    +    /* Increment key ID before assigni=
ng to always have a key id >=3D 1 to
    +     * make 0 signify an invalid =
key id */
    +    session->opt->mda_context->mda_key_id_counter++;
    +  =
  ks->mda_key_id =3D session->opt->mda_context->mda_key_id_counter;
     #e=
ndif
     
         /*
    diff --git a/src/openvpn/ssl_common=2Eh b/src/op=
envpn/ssl_common=2Eh
    index 3b326a7c1=2E=2E0270c23f2 100644
    --- a/sr=
c/openvpn/ssl_common=2Eh
    +++ b/src/openvpn/ssl_common=2Eh
    @@ -764,7=
 +764,7 @@ get_primary_key(const struct tls_multi *multi)
     
     #ifdef=
 ENABLE_MANAGEMENT
     /**
    - * Gets the \c key_state  object that belo=
ng to the management key id or
    + * Gets the \c key_state object that be=
longs to the management key id or
      * return NULL if not found=2E
     =
 */
     static inline struct key_state *
 
 But that is a much bigger/more=
 invasive change but I change the commit to do that as well to avoid this c=
heck here=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1856?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I42d87=
85959c24bf688190965e58b9b98251b8557
Gerrit-Change-Number: 1856
Gerrit-Patch=
Set: 6
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: flichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Comment-Date: Wed, 26 Aug 2026 16:23:20 +0000
Gerrit-=
HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <f=
rank@lichtenheld=2Ecom>

--9o6nTIS2NkY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1856?usp=3Demail">View Change</a></p><p>1 comment:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/ssl_common=2Eh:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
856/comment/af028c42_ec4c2b57?usp=3Demail">Patch Set #6, Line 775:</a> <cod=
e style=3D"font-family:monospace,monospace">            return ks;</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">The old code did not abort on first match but always checked =
all three key states=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">So each key_state has =
its own unique mda_key_id so there is only one valid key_state with mda_key=
_id, so the code does the same=2E But valid does a bit of heavy lifting her=
e:</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">If state is S_UNDEF, mda_key_id is 0 and 0 is also a valid key id fo=
r the very first client=2E So we need to check for S_UNDEF to determine if =
the client actually the one with key-id 0 or just not initialised=2E </p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A=
s alternative we can change the initialisation of context_2  or assignment =
of mda_key_id_counter to start with 1 instead of 0=2E</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">E=2Eg=2E</p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">session-&gt;opt-&gt;mda_context-&gt;mda_key_id_counter++;<br>    k=
s-&gt;mda_key_id =3D </pre><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">E=2Eg=2E something like:</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">    i=
ndex de9303b30=2E=2E478e4d314 100644<br>    --- a/src/openvpn/manage=2Eh<br=
>    +++ b/src/openvpn/manage=2Eh<br>    @@ -69,6 +69,8 @@ struct man_def_a=
uth_context<br>     #define DAF_INITIAL_AUTH           (1u &lt;&lt; 2)<br> =
        unsigned int flags;<br>     <br>    +    /** Identify the key id in=
 the management interface, always 1 or<br>    +     * or greater if valid *=
/<br>         unsigned int mda_key_id_counter;<br>     };<br>     <br>    d=
iff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec<br>    index 82d7daeb=
2=2E=2E3495f9dd7 100644<br>    --- a/src/openvpn/ssl=2Ec<br>    +++ b/src/o=
penvpn/ssl=2Ec<br>    @@ -870,7 +870,10 @@ key_state_init(struct tls_sessio=
n *session, struct key_state *ks)<br>         ks-&gt;crypto_options=2Epid_p=
ersist =3D NULL;<br>     <br>     #ifdef ENABLE_MANAGEMENT<br>    -    ks-&=
gt;mda_key_id =3D session-&gt;opt-&gt;mda_context-&gt;mda_key_id_counter++;=
<br>    +    /* Increment key ID before assigning to always have a key id &=
gt;=3D 1 to<br>    +     * make 0 signify an invalid key id */<br>    +    =
session-&gt;opt-&gt;mda_context-&gt;mda_key_id_counter++;<br>    +    ks-&g=
t;mda_key_id =3D session-&gt;opt-&gt;mda_context-&gt;mda_key_id_counter;<br=
>     #endif<br>     <br>         /*<br>    diff --git a/src/openvpn/ssl_co=
mmon=2Eh b/src/openvpn/ssl_common=2Eh<br>    index 3b326a7c1=2E=2E0270c23f2=
 100644<br>    --- a/src/openvpn/ssl_common=2Eh<br>    +++ b/src/openvpn/ss=
l_common=2Eh<br>    @@ -764,7 +764,7 @@ get_primary_key(const struct tls_mu=
lti *multi)<br>     <br>     #ifdef ENABLE_MANAGEMENT<br>     /**<br>    - =
* Gets the \c key_state  object that belong to the management key id or<br>=
    + * Gets the \c key_state object that belongs to the management key id =
or<br>      * return NULL if not found=2E<br>      */<br>     static inline=
 struct key_state *<br> <br> But that is a much bigger/more invasive change=
 but I change the commit to do that as well to avoid this check here=2E</pr=
e></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1856?usp=3Demail">change 1856</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1856?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: =
openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Id: I42d8785959c24bf688190965e58b9=
b98251b8557 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1856 =
</div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D=
"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 26 Aug=
 2026 16:23:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>

</body></html>
--9o6nTIS2NkY=--


--===============4000567835253186614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4000567835253186614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4000567835253186614==--

