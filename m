Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C14CA5FC5
	for <openvpn-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qFbK2G74Bis6puq6ms9ojokCnReYzFZ7pdLnumv7h4U=; b=L+RCcYkCqbNBk18ahW/bfr65UK
	/5u2on3GV1qdH1IE9PdGCfwwIlMYH4oVxS6kgXXYe5jOa2qRCsrXuxJJHnGCSlQJVIA00r6Pk/mso
	Evtn27xPz7NZ3J4pwm/v7tBGrC7353UAxPGjFmPH7gh5ZOQbheLJxmpmvQP2bmfQDuwc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCBLn-0005RM-4w;
	Thu, 01 Oct 2026 07:37:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xCBLl-0005RF-JC
 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 07:37:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fpbCbaXmwVCFnxSlrVWohi2ZusXl8Il9St4o+L9cxyA=; b=Pgd8/GLT/QCklBuFZoeaqLXV+9
 HoJGSudxP5PIFjyYdNfc5H/QAIrifRaIdK2REM0VoG+J2W4YhxWWbwjYEywj/Nne0jxpNyxWUIPRJ
 dE9WK0brkG8KDKqrA66wjDkkM1iX9I6xmDvB5PcYbKioZRrPwlRMDZBwyJ4ehnc91uAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fpbCbaXmwVCFnxSlrVWohi2ZusXl8Il9St4o+L9cxyA=; b=L
 AEdD4DeYlbGV9M3HbILH/UMYRFeXkaGa4zupe0FXdy4RAzj5SFtiNC3OQNZULP1AZSrbdVHG5wvwX
 Jxutz3nC/VNKFJHoKbtBzz66ZPZAYg6HS23JuNX+Z228BheCl126sF0RiMOqmckr0CtP8ic1UWhaP
 bmkNhylLGqz0XhIY=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCBLh-00005i-OI for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 07:37:03 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-48b0f4efe31so76543f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 00:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790840214; x=1791445014; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fpbCbaXmwVCFnxSlrVWohi2ZusXl8Il9St4o+L9cxyA=;
 b=AFUmohqA3dF3toBeZvAEBSQqzFVbWI68qqmhOqNOUkkXBJsZP7u1leb3Q9mzJQR0zy
 Al9ttXhw6hKZ1I3Kf9uLyTVW10VWQp9a6EpAKXhryoxsC+Q9rOgOHPNykiNgSCyDnSJI
 /Nt/HaZJ/sVntuRt8MX13MSZ9va9bsOsurMaZMdSSjl1EJ0Q3zF/ZJ8utCpboFJmBt3a
 uEI8ztg2+95SgqvcE7jnjzXjAsj0LIHQTtME2cXFcNFeqvxJBrjcEH+SYCv14D+2cMdh
 YCUW7zmuNv3xumX8qcESE7A6mYyFZMc9kaJL31Vx68bqGzD+cDvQ4hQ/RcdxsyhHspWJ
 jlaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790840214; x=1791445014;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fpbCbaXmwVCFnxSlrVWohi2ZusXl8Il9St4o+L9cxyA=;
 b=TUDw08lApWFp9bfxrLH1eTkmqbtyDEhSGO+C6tVofM2+3egUUjvTdreSvL9xT8Ajsc
 AYR5j59PcXS6NOKhOkYuWu/pLuDGHYLTBYn70GdZriEWPp+3v7N5sKmNX0/QOCqcsA34
 bT+mynpb+X2KuO3yRXHLR8J0o1WakIZnMz79PyELp1OqsqFOqskuwRfwQ6PsZMnGD1B9
 Q+MrFKpNa+l3c3vNjOLAXS/TZ+XXH9gD+aUPBJLj1OCAFNHF0PHe0NE970BeRncqT8zr
 gJsskCyUThe5rWnSO3Mj3++VG9dH0RdlZOGlK+PFZbz8LYH5zrQsJU/9J2OC5GCR4l0h
 BbJA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzI3zYsNI5JAaLIErFzl/Jwll5ISS2vNaE+qkrdz9HL/jNDwvoi3KG/mpNg4Saoljso+ge0i57opssMO5B8@lists.sourceforge.net
X-Gm-Message-State: AFq9FYI8FkmNlGpTEg2Gx4pi0KV64duf8np1LPXrJvnTpj3PH+kR3tOp
 D5zQz23kjoqpcH0UolUMbgveziQTlBmfkE0ZoEddQt7MNZmLaRYM6K0KKMmXiQaAXxreXaBVMF9
 15YPDfNnRzkaDMKz7UGQ8RfWMNUHQ2gE+WMPHHh6x50Y1L087hcmqkJT8z6J10dBEDCYf
X-Gm-Gg: AYBFou3Qf3mZaZMT6FhEIvjXQueK6so1meh0psGPgbc0VXNwGEmEjOs362NIh97YLC/
 uD1+mVKpQr59i8u0lrcQMUErDAyLOhDAQNaFxW/yT5mTXh2JNKgUzynPro8+pb7oH6e3F28ffWj
 pyvFU7bHt+3j8YnidawJ0gnDTd5b5RJhAjEgkvgmZFDaoPmGDHOiCLrPESmrP/avQgDNxgYN/2c
 Q4ELg3COILliXC7kCMAn0BznPwKOlODRwdHnMKGS330SkUd5bqJGopT2H1ZnTALbGMR7xsZDD9n
 Wfh8OV+UPhcPQaAqQY6o0vHSVgtQQJwGLTh8LyZidr+/uCvIgOeTKEYHFNoQZuth2OHumfPqgE1
 Iccijn1iciAL3N8jv0/kvAAEujoXou+Ar9QvWqrXhjv2mCuxvsgfeYT+Dv1odtIvEkVjdWSvfuw
 h37vn/PT3rExhBUCgvc2GGYnvn1pmeDv5jjSA4VrMVfLdti5i6P+/7GA8oVGSkadSBpfQ6kZLVK
 Xb5lz1KFpGkUzxEwukDFUz7V6YeNuUVG2rftsT4ufIss5HRLXVFw8EkCD87eaP9azBYdygUSahd
 uX5ONybf7zUlo2pFzF1n4Gi2t/3aGdsFnJbi4oDfeqAZoeBc/OutBjxOTWSf
X-Received: by 2002:a05:6000:220f:b0:488:79e5:cb2b with SMTP id
 ffacd0b85a97d-48b02553716mr7220786f8f.43.1790840213742; 
 Thu, 01 Oct 2026 00:36:53 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b0692b5d7sm4707602f8f.28.2026.10.01.00.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 00:36:53 -0700 (PDT)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 1 Oct 2026 07:36:51 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 0e38f4a6f61321adac1b61994facdc0129ad92ca
X-Gerrit-Comment-Date: Thu, 1 Oct 2026 07:36:51 +0000
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <af3a402559755941272de0997301beee7a7afc65-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xCBLh-00005i-OI
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add a shared TLV
 codec and use it for early negotiation
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
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1803364459083531811=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1803364459083531811==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZqS2bACabp0="; charset=UTF-8

--ZqS2bACabp0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Lev Stipa=
kov has posted comments on this change by Lev Stipakov=2E ( https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail )

Change subject: Add a shar=
ed TLV codec and use it for early negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(3 comments)

File src/op=
envpn/control_msg=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/com=
ment/5bba6d37_4f3a205c?usp=3Demail :
PS1, Line 34:     uint16_t field =3D t=
ype & CTRL_MSG_TLV_TYPE_MASK;
> Is there a valid reason why type might be d=
ifferent from field here? I wonder whether we should ASSE [=E2=80=A6]
no re=
ason=2E Will add an assert=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1965/comment/2e2643a2_eeb32d45?usp=3Demail :
PS1, Line 76:     uint8_t *v =
=3D buf_read_alloc(buf, hdr->value_len);
> cppcheck says this should be con=
st
added cppcheck to the workflow and added const=2E


File tests/unit_test=
s/openvpn/test_control_msg=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1965/comment/e258e02e_7d50c895?usp=3Demail :
PS1, Line 107:     assert_int=
_equal(BLEN(&value), 4);
> Any specific reason why you do not verify the co=
ntent of the buffer here?
Acknowledged



-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mas=
ter
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Chan=
ge-Number: 1965
Gerrit-PatchSet: 2
Gerrit-Owner: Lev Stipakov <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-R=
eviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Comment-Date: Thu, 01 Oct 2026 07:36:51 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichte=
nheld=2Ecom>

--ZqS2bACabp0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Lev Stipakov has p=
osted comments on this change by Lev Stipakov=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Change</a></p><p>3=
 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/control_msg=2Ec:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1965/comment/5bba6d37_4f3a205c?usp=3Demail">Patch Set #1, Line =
34:</a> <code style=3D"font-family:monospace,monospace">    uint16_t field =
=3D type &amp; CTRL_MSG_TLV_TYPE_MASK;</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Is there a val=
id reason why type might be different from field here? I wonder whether we =
should ASSE [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">no reason=2E Will add an assert=2E=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/com=
ment/2e2643a2_eeb32d45?usp=3Demail">Patch Set #1, Line 76:</a> <code style=
=3D"font-family:monospace,monospace">    uint8_t *v =3D buf_read_alloc(buf,=
 hdr-&gt;value_len);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">cppcheck says this should be con=
st</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">added cppcheck to the workflow and added const=2E</p></=
li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/=
openvpn/test_control_msg=2Ec:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965/comment/e2=
58e02e_7d50c895?usp=3Demail">Patch Set #1, Line 107:</a> <code style=3D"fon=
t-family:monospace,monospace">    assert_int_equal(BLEN(&amp;value), 4);</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Any specific reason why you do not verify the content o=
f the buffer here?</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?u=
sp=3Demail">change 1965</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Commen=
t-Date: Thu, 01 Oct 2026 07:36:51 +0000 </div>
<div style=3D"display:none">=
 Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Lab=
els: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--ZqS2bACabp0=--


--===============1803364459083531811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1803364459083531811==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1803364459083531811==--

