Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60812CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dSShIFrDpGgWL0hQkIjYi6X9iwRYyfbAsTgDdj50Mxk=; b=Egd66S1HonRekxycpBF4+AuqEq
	Pw9vc4seRYaRM0W9kUYsRHp7RhGp0GXulkzTVXJGWQ7iomPOD0DVmuq0H0RW5KWvQKMmn0dng8ySv
	PkvP8J86UyGj+9MFmgHPfro2IlhU7LSThbwspzuNJFQcvJgv0PqP1U6Wdwd2nPdPdIpk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xETns-0005JT-BJ;
	Wed, 07 Oct 2026 15:43:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xETnq-0005JB-5b
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 15:43:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=o0A98cvXcAfMnOPmv469nS+tcdOMcFKv9Sna9dapsm4=; b=etyy6ibePP9ZpJOeb7pgXTaYsL
 Nm7IlqMYC1ze5KD1UgaeLn7WI9AGI4t54RsI54n5uOijAV3Lw4xGX2jF0t4+tmuzie304Yn3TJCcG
 l7VONVxetqhVMaTX2n84/IpgF7zcMpd+AQfOiDepf1rrsiR1yRJ1nt27HVKa9IeBMIB8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=o0A98cvXcAfMnOPmv469nS+tcdOMcFKv9Sna9dapsm4=; b=A
 0IheY/Tt4ptUfa6q1oOPC3n0pVLQWQOLyooFOqcZ4BNjZUvhXzZxAjgBeXPoQhwTg2rAVYbMVcFjW
 0MfS8rp/z43F+AlsSKeOt9tseltXGEoI+MMQHlpR/vSq8dgwX0ohK69BwAfAD6QW8YJ+9uX2pMx4Y
 FX1D5UcveO0fdklI=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xETnp-0006uo-SQ for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 15:43:34 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a02753c04fso11457565e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791387807; x=1791992607; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=o0A98cvXcAfMnOPmv469nS+tcdOMcFKv9Sna9dapsm4=;
 b=UswPjPcTXJF9mckujiiDUeITOVlY8R59V44tImZkQ81etD3Y8LDFwU6o0ipnAJ0NWL
 k9lH4iH7/QTdoYwL+rxuweBOPDvLyZJJjIweR+NHtRKcwww3DndCKo3Lk0/M3oyjbCeW
 LrogfThnTW8M78a9rfaN7d+lHdMrbexMIaogEPAjUAcGwpDAyjiHtUdRGwSme8/lcuLR
 kyAv5kE4fQMqaYsoInQbrj3haCfGDgjVg25tJvZtb3tV6qhTKxA4E7vgnhlM0O+5eYDg
 0VSSs9RVRsWGQUmRC4U2CusFroCW7HKs+EHVTgMGTkUJVeSQ/rSj8vfJeyz0IPEdAFe5
 EPLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791387807; x=1791992607;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=o0A98cvXcAfMnOPmv469nS+tcdOMcFKv9Sna9dapsm4=;
 b=U+SQ2vMnLKm91wg+nlR7Jbh4lNMo8DNNbQcFlmp4Xi72fY6KADmfducI4VNcdzRY1Y
 OdQy1xvqAWnOL/pxlRAOLac93U3kA1QHxv2cYn+dd/OJA4gvYP2SkXbWqYJzfWjsBzYs
 lM3MZpi9IpDqq8xZ1uSZSH7RdHg625dLwdWnE9Q4HJ4k4jk5MOD9gxSat9+6dk6WSj+p
 qm6NY/xcQmtIvVCJXzKR0QCOht7yiR79Tzpl9tV5JjqBUXMdl68pUzsQu4dobbhR5e/x
 FW6IPEEbj7V6PzScTPM29tVDnusvCz3S2XFkPX1ZKGOCTGkQLEu6eJbWO9ssc02SPKK8
 OBug==
X-Forwarded-Encrypted: i=1;
 AKwUvBy5/+KxJpY9XzMoPxJ/IRv9Xbl4GfKorXyCifZLSy+M2k6O7eoNTOv/PHiEuhOoDCawrZJBLUaZ2cguU6TN@lists.sourceforge.net
X-Gm-Message-State: AFuF++l6uiARUnr/WezKempvLHpIkM7XwCF6+IxkxqYV3FHVBqFEUIzt
 JKIICy0f4X3Kq4JLdp7MSuaGRda4kDLC5aGCX+k/99P8WROVazg0VNEgQzxOsS2GPtmrIgSeRDg
 k9u2jEA61ZTTad3Osy0cl0cgtxN0MYFa1ybwf6i8TmeeZtD+uuWml+TZA4mElzsvLSjeK
X-Gm-Gg: AYBFou2qeRoLZrYm/dHwpOOKqnyRKlNsr1XOl7wXM33tnQAf5NTSRjf2MOtNCRYDyvX
 aOKpOkvALnQUOfe2QICgOmdyhU+0JHxRRJxmv54zApyH+zgme82tZa5PYah7NSyshO8U+g56guQ
 PcYl8gw0JhApj814GRdVG41bDzBNYcAHyg5c4FdqhB1vj2+fsL2UlHnjIfm+S/ZyfoevFYPOt7C
 uaUKaPSYc0B3Mg0E/5oJbIMx4809E1braS9gu0NW5lcgnvNCY421xGOi49tpCDRpeVN7OjAFV9e
 /2K9qEVn9/sPHft0CzQiyBMdK01xnEqzsZK+q9DStVzz4+Gq5+uXkQ6Enr8zFY4y5WZZnHhoCmk
 SMRKD7da0gPV8U96qo4jj6Jf5mn86W+PjttMA3FFK1yYyJ4sJrAx9xA252VE2ZoemEKQcHiRdAq
 +854wJs1vUC6oucNAuycEglYYRcUJAiLrs/8ss3+Rv8MMkKzuER+TD1hPF6jrvTFc2eTUaCxtF0
 dS4ZrU7llmuGFfupXgb3lm0VKKcTbwHunGhbZwDhKeRp82t/b8u4/P2GZa7I/FGacCjXLiB4OmA
 eMQNaADiGNJ33TkuPrfTzSloUjFUzYG222NOaCWQaYw7yNq5YBMRV9hceY19
X-Received: by 2002:a05:600c:8b18:b0:49c:fa21:e749 with SMTP id
 5b1f17b1804b1-4a180455775mr42387545e9.31.1791387806932; 
 Wed, 07 Oct 2026 08:43:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1803040cbsm38968895e9.4.2026.10.07.08.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 08:43:26 -0700 (PDT)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 15:43:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 31
X-Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
X-Gerrit-Change-Number: 1663
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1663?usp=email>
X-Gerrit-Commit: d26fb6d4a2ad7f59269b568c80419bc18bbca028
X-Gerrit-Comment-Date: Wed, 7 Oct 2026 15:43:21 +0000
In-Reply-To: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
References: <gerrit.1778068501000.I56248cf6d199c2da770774b8fd1e5daf2b116f58@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDY4NTAxMDAwLkk1NjI0OGNmNmQxOTljMmRhNzcwNzc0YjhmZDFlNWRhZjJiMTE2ZjU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f0e0e3bf1b9d5abd4e56c563a4fd2ed234d095e4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xETnp-0006uo-SQ
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constParameterPointer cppcheck warnings
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
Content-Type: multipart/mixed; boundary="===============9046375455178192933=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9046375455178192933==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mqZXKHJemnc="; charset=UTF-8

--mqZXKHJemnc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail )

Change=
 subject: Remove instances of constParameterPointer cppcheck warnings
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 31:

=
(4 comments)

File src/openvpn/event=2Eh:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1663/comment/c8b7aa51_0d9350f8?usp=3Demail :
PS30, Line 196: wai=
t_signal(struct event_set *es, void *arg)
> Here the `_WIN32` version of `w=
ait_signal()` no longer matches the signature of the POSIX stub chang [=E2=
=80=A6]
Since this is "static inline" I think that is nicer than adding a s=
uppression=2E It shouldn't break anything?


File src/openvpn/ssl_mbedtls=
=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/b3c2423f_c0e=
95fd8?usp=3Demail :
PS29, Line 272: tls_ctx_restrict_ciphers_tls13(const st=
ruct tls_root_ctx *ctx, const char *ciphers)
> This hasn't changed to non-c=
onst and breaks the mbedTLS build=2E
Done


File src/openvpn/tun=2Eh:

http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/9f69f518_cbb802cb?usp=
=3Demail :
PS30, Line 467: void tun_standby_init(struct tuntap *tt);
> This=
 `_WIN32` version of `tun_standby_init()` now does not match the other (con=
st-ified) POSIX versi [=E2=80=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1663/comment/4a3739bc_74618433?usp=3Demail :
PS30, Line 469: bool =
tun_standby(struct tuntap *tt);
> `_WIN32` version of the stub now stops ma=
tching the POSIX const-ified one=2E
Done



-- 
To view, visit https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail
To unsubscribe, or for help=
 writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58
Gerrit-Ch=
ange-Number: 1663
Gerrit-PatchSet: 31
Gerrit-Owner: Frank Lichtenheld <fran=
k@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwa=
be <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 07 Oct 2026 15:43=
:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--mqZXKHJemnc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demail">Vi=
ew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/event=2Eh:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/c8b7aa51_0d9350f8?usp=3Demail">Pa=
tch Set #30, Line 196:</a> <code style=3D"font-family:monospace,monospace">=
wait_signal(struct event_set *es, void *arg)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Here the=
 `_WIN32` version of `wait_signal()` no longer matches the signature of the=
 POSIX stub chang [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Since this is &quot;static i=
nline&quot; I think that is nicer than adding a suppression=2E It shouldn&#=
39;t break anything?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/ssl_mbedtls=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/co=
mment/b3c2423f_c0e95fd8?usp=3Demail">Patch Set #29, Line 272:</a> <code sty=
le=3D"font-family:monospace,monospace">tls_ctx_restrict_ciphers_tls13(const=
 struct tls_root_ctx *ctx, const char *ciphers)</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This =
hasn&#39;t changed to non-const and breaks the mbedTLS build=2E</blockquote=
></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/tun=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/9f69f518_cbb=
802cb?usp=3Demail">Patch Set #30, Line 467:</a> <code style=3D"font-family:=
monospace,monospace">void tun_standby_init(struct tuntap *tt);</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">This `_WIN32` version of `tun_standby_init()` now does not match =
the other (const-ified) POSIX versi [=E2=80=A6]</blockquote></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663/comment/4=
a3739bc_74618433?usp=3Demail">Patch Set #30, Line 469:</a> <code style=3D"f=
ont-family:monospace,monospace">bool tun_standby(struct tuntap *tt);</code>=
</p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pa=
dding: 0 10px;">`_WIN32` version of the stub now stops matching the POSIX c=
onst-ified one=2E</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1663?usp=3Demai=
l">change 1663</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1663?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I56248cf6d199c2da770774b8fd1e5daf2b116f58 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1663 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 31 </div>
<div style=3D"display:none"> Gerrit-Owner: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: o=
penvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne =
Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Comment-Date: Wed, 07 Oct 2026 15:43:21 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body><=
/html>
--mqZXKHJemnc=--


--===============9046375455178192933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9046375455178192933==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9046375455178192933==--

