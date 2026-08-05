Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B14C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nnXycIFKuRFdAaL7AD1+DEd1ctsKIX+zHF9fsrj7r/E=; b=K3wfvclr1qJxKT7BG4V58R+jz2
	Kq2KKOza9fVc5KXtKUqPs1pkh39e28VH6r3LaxJXkRk67aNnRVWg7Yx9zi4FmOofh0TZt9RGQmm2l
	uM+FaUnCZilLGC+HJ/tISG29MfhjH9I8afUoQYPpfXJWyyiiFPa7az3k4XOYpc8zOD30=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrVm2-0000Kh-L0;
	Wed, 05 Aug 2026 07:10:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wrVlo-0000KU-Ci
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 07:10:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=DHHDs0P+z0Av3gWmlPv+kPCFWCGVGa64vyyS4MMetlQ=; b=Yay61NPqL24foMT4EA4c4oCsI+
 4jKtF3HUNs7nJNVsA4XvhIMxfim9q34aoY5FKdrmBkx+II9ISFjkX3XHACz0HUXNjxUG/jY/9OtHz
 tyGRm2WlrtFBDB6+hlzhSKSpdFy1LInVlRIVAWxOd93A+2NR4jDUFfpDqaFiOxLMeCMk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DHHDs0P+z0Av3gWmlPv+kPCFWCGVGa64vyyS4MMetlQ=; b=F
 njWWg2ldmI9xFh8l1/KGiEy+pFCdv6+j+n5EF5jHdN7kzKD8ZZuzQt2AcoSc3UpwIdo3RUSLqEdmd
 IBENNkg9+wkq/iEnHr+KQRNKNgW29AIdycPq/5LNWIXe/r6E81VNrLfqlqBm6ck1qro8dhRCgqx2t
 4liUEQhHevbNB780=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrVlq-0004lS-LE for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 07:10:33 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso12735305e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 00:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785913824; x=1786518624; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=DHHDs0P+z0Av3gWmlPv+kPCFWCGVGa64vyyS4MMetlQ=;
 b=gcgIk1785O2U+2Zk3GFwfMHRbFuamHjbOeDCCEn+nfJ1eaXf3WYp4picdXogC3y8qu
 +aX3Vpna4AE5ahpnQpYQKZAoPBAdywSmWZ3Bg20V7YopZyln1wh78ojJjBdswSGzuWVv
 NY6dWUt68tgsKKsESyulrjjgsITAEZN4VwzCKZkx9oSvY4LfqaHuPK3ONRUGNzKGsdjz
 NwPN43UbmaS3He+ucHkMTsU/4Lykwc5jjmrVlIlS3BEuDnlL8ivSZxq8CBJlO1X/tb+s
 yNyda0kAWOqyqC0B79GGvvKVwS7M4rHRd0aAwypJet/XN/8uoicIY3gSmdbIS3hl07T0
 APmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785913824; x=1786518624;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DHHDs0P+z0Av3gWmlPv+kPCFWCGVGa64vyyS4MMetlQ=;
 b=RJhINwlGV05kXcB/aKgNG7Yrz2jQ20U5G70MGJRGobpuY307snC4KWE+2f5vuVb5QX
 z+Yvi48O1HRFDtcDICt/C/l1L2igHtgtLGwlG0/P/myCv3V4yY4aI9Y+a2xg6ofxG39D
 nqE6rGDZN99uqpXitcFMmjvaBNWXMxU+/42khdF2nmYz9O5GoHD2qT9NLguh65ynSCAq
 U5W4L7aqiGvnYJxDy/gLRLc4an24wuIvuZpgd01PrwUDudCthm8jBDSutAmst+3uNavN
 C59aT+Ef3iFO872IKw2uUCCUiStUyodsBlKbUoWrW59S7nSAmG3vk7ZNyge90vz5OeoW
 32Mw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTviddDYiwVr/W6kgBQrCexu0Zg8JBRzwR5jkUPkVMOsisLfG1yOKl4aEUj/VWMCPYe6jiot90Z2E8wIjN@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyeueSHAbfnaJz/crT1eqzfcfXu85pMMeTN65aWDqdSeoGKTr4L
 uhEamjWlmcpGP0DL1isxIQBSoGEEntNLgPeEd5+ilfz77bXCqQOkuEUkLWI8xnJGj+fwPHUGsui
 5ml2OGcMZSd1FnRTq+dUQGRRRiwlVX4+bNWzw+6n1sUVIhpfCIJrSye7/qkDEV6d4uEgCBpT9/k
 iuug2H8Q==
X-Gm-Gg: AR+sD10GJ47v/hLFr+2AvTHvEksI0X+tSR+qu/pzSUc3wY8qgC/hFU1vE+lYXFKXW/D
 yON4sJb8n/e4q+lrfvz2JeTdnu3n7DCu2ZxvAtvqS5ulLznV1OAUnxCBlw/0DQaGgUWRkiyWLz3
 UEhrlkfSs3CzBEqetToSOeLgTNSRW4XTA2AMEadcdU/awI6PmMSi3/j1WY4QJNa/Hwo/N8ShDp0
 Fk68EzTQlGr5mKcaZgSUXB7IRR4P7xEUwP2iXrSgFEc3j+cq4jLQKVJdt2sASu94Lb3ow3WllH4
 +hBNWNefKtuTDYHTtztOu79K7xmgSfJl+tpem2uaMEEE8VTEdliIaV/vBWHmn7HtIy59M0HgRcR
 9bpJ378ROrr30jA2ESiOAe3Gvjl2Dh8EV2as8LpXcMZsJspsVIMz4fMeHoKQD1Mqs9QmH0sru4L
 hjYhQh9Mn7OCouBh8C4KME8Kn3j1okainf9+PORSxAXSjF72DokrN1xym78nRM23rThbekQ0j33
 6FW17JQtA/DAB57IxqUzIEN+gRq1D8HiFxSFZIUpwAUd/UV++uqAuOl9BQPi5ZfJBU7B50Nffxg
 44qMfLos0HlxHYaYcl306AyXFp2Zz5tfpBv/O7ipOjgM/w1WaoovMw4XaBJaLw==
X-Received: by 2002:a05:600c:1c22:b0:495:69eb:27d3 with SMTP id
 5b1f17b1804b1-4994e38b552mr49402915e9.8.1785913824422; 
 Wed, 05 Aug 2026 00:10:24 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a0fca55sm166516415e9.13.2026.08.05.00.10.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 00:10:23 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 07:10:22 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 9f0e71a3741abae86ab67bd74d7530db76e1d604
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 07:10:22 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <58b8e59132fac3ff4d29048de88856a8028ad6c1-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wrVlq-0004lS-LE
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: do not exit the
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3225042630288333182=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3225042630288333182==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6BRF2LnL2a8="; charset=UTF-8

--6BRF2LnL2a8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos=2E

ralf_lici has po=
sted comments on this change by ordex=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exit the process =
when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

Patchset:

PS1: 
The change=
 looks good to me overall, but I wonder whether we could avoid adding the p=
ersistent bool to `tls_multi`=2E

Basically, the error must ultimately prop=
agate from `init_key_contexts` to `check_tls`, where the recovery action ca=
n be dispatched=2E The call graph branches at `tls_session_generate_data_ch=
annel_keys` whose callers are:

- `tls_session_update_crypto_params_do_work=
`, whose failure is already propagated by its callers to paths that emit  `=
SIGUSR1`, and
- `tls_multi_process` where the failed key is moved to `S_ERR=
OR_PRE` but the failure does not currently request a connection restart fro=
m `check_tls`=2E

So, one possible simplification would be to add a `TLSMP_=
RESTART` result and return it from `tls_multi_process` when key generation =
fails with DCO enabled:

```
if (!tls_session_generate_data_channel_keys(mu=
lti, session))
{
    msg(D_TLS_ERRORS, "TLS Error: generate_key_expansion f=
ailed");
    ks->authenticated =3D KS_AUTH_FALSE;
    key_state_ssl_shutdow=
n(&ks->ks_ssl);
    ks->state =3D S_ERROR_PRE;

    if (session->opt->dco_e=
nabled)
    {
        active =3D TLSMP_RESTART;
    }
}
```

`check_tls` co=
uld then emit `SIGUSR1` when it receives `TLSMP_RESTART`=2E

This would avo=
id storing a persistent cross-layer error flag in `tls_multi` and would pro=
pagate the recovery request directly through the existing `tls_multi_proces=
s` result contract=2E

Would this approach make sense?



-- 
To view, visi=
t http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9f=
cd
Gerrit-Change-Number: 1835
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <anton=
io@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
CC: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit=
-Comment-Date: Wed, 05 Aug 2026 07:10:22 +0000
Gerrit-HasComments: Yes
Gerr=
it-Has-Labels: No

--6BRF2LnL2a8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">The change looks good to me overal=
l, but I wonder whether we could avoid adding the persistent bool to `tls_m=
ulti`=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Basically, the error must ultimately propagate from `init_key_=
contexts` to `check_tls`, where the recovery action can be dispatched=2E Th=
e call graph branches at `tls_session_generate_data_channel_keys` whose cal=
lers are:</p><ul class=3D"blocks"><li>`tls_session_update_crypto_params_do_=
work`, whose failure is already propagated by its callers to paths that emi=
t  `SIGUSR1`, and</li><li>`tls_multi_process` where the failed key is moved=
 to `S_ERROR_PRE` but the failure does not currently request a connection r=
estart from `check_tls`=2E</li></ul><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">So, one possible simplification would =
be to add a `TLSMP_RESTART` result and return it from `tls_multi_process` w=
hen key generation fails with DCO enabled:</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">```<br>if (!t=
ls_session_generate_data_channel_keys(multi, session))<br>{<br>    msg(D_TL=
S_ERRORS, &quot;TLS Error: generate_key_expansion failed&quot;);<br>    ks-=
&gt;authenticated =3D KS_AUTH_FALSE;<br>    key_state_ssl_shutdown(&amp;ks-=
&gt;ks_ssl);<br>    ks-&gt;state =3D S_ERROR_PRE;</pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">    if=
 (session-&gt;opt-&gt;dco_enabled)<br>    {<br>        active =3D TLSMP_RES=
TART;<br>    }<br>}<br>```</pre><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">`check_tls` could then emit `SIGUSR1` when=
 it receives `TLSMP_RESTART`=2E</p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">This would avoid storing a persistent c=
ross-layer error flag in `tls_multi` and would propagate the recovery reque=
st directly through the existing `tls_multi_process` result contract=2E</p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Would this approach make sense?</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">chang=
e 1835</a>=2E To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1835 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ralf_lici &lt;ral=
f@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:=
none"> Gerrit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Comment-Date: Wed, 05 Aug 2026 07:10:22 +000=
0 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div s=
tyle=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--6BRF2LnL2a8=--


--===============3225042630288333182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3225042630288333182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3225042630288333182==--

