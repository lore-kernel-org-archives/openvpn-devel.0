Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFF6606A31E
	for <openvpn-devel@archiver.kernel.org>; Sat, 28 Nov 2026 01:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cXXUF2v+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JHxN14ne;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gVk0AJUZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=D6p+J2DQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=aA/R7BVdUQQs9OXNPBKeK/MYQLwoTMdApjrPTpN8Kvw=; b=cXXUF2v+jTlTt/n6l02Mq6Kc8x
	SwlZiKndFgSdBaYUkWDhZl1rh5TZQtKFFmywXhYoZiwvvPaRQRDIekeAW9FXjJXjbGY7MKSwPc4Xe
	+LiIsbywDoszyE7uAxmisrNf2yvEkZa3LI25zrlES/OWLhFvTTkBoKZ46g7AnvwDO0qE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xX7C3-000000006Mf-2e5i;
	Sat, 28 Nov 2026 01:25:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xX7C3-000000006MW-137F
 for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 01:25:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yVhqjcIa36ffAqIyrvZeQAQBRKBNbM79TBsGEx3UCao=; b=JHxN14ne3R5OVkoYwVP9zp9gx9
 XfEIObfp9lwlvY9Ten4gC0WvbpnWZTVgFeBGDuGzu9FTM41V4xgMTWHRZE/yGtGaX8BQs5z73TD81
 EAsydrXQFa5GI6R5x92Mx7mxAuaiwj3GanUN1E5t98/l6Q7PX9HBGGl9P2jiy5i+xob0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yVhqjcIa36ffAqIyrvZeQAQBRKBNbM79TBsGEx3UCao=; b=gVk0AJUZnaPiQrhJGGfbmjy/eT
 r1Q8WMR5tcnyeV6gkMEEROIfdK/f+2YWD482cZMt6QViL/T2NpGv3v37hlkhNKt8uLzEVTmN6R7Uu
 n9Z2c97I7O/5KTvEyHhjzplBYtwCGfGUo6DLkkqWlzhDd9rX9BJdmzy3V4ZSROQMxR0A=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xX7C2-000000001tZ-0qXO for openvpn-devel@lists.sourceforge.net;
 Sat, 28 Nov 2026 01:25:35 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so83732455e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 17:25:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795829127; x=1796433927; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yVhqjcIa36ffAqIyrvZeQAQBRKBNbM79TBsGEx3UCao=;
 b=D6p+J2DQD9FC7j4Bg0UVIN8MlLaIzbSvRnZ4AaQJa2WIE8eYO5+fwsqGxf5Zl6kAlV
 iJdEVVW1UYHMIAImj8YCernsof7ij3ASGVtVfauFyi6bOmZICfB7wxw30zGhOiGG+ueG
 OhOCC7bNr+m3AtV5/GxY480NvQsw7uglpIji87V5vzSWYJ69d1hJg8WUBmJYKLNgVHBR
 5BypTCGdcfRpWXsHY+csie3ue3ZT5q79U9pqBogZ0zTlsj2wlWra+UuQwQqZ/ZBMQ6b4
 VQH3J9QHIdkxqs0QEwa5yRi2RPcdG24rgJWyi5E0FoAS9r8dJfAj+77F3zG5+yYZz5pa
 a0Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795829127; x=1796433927;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=yVhqjcIa36ffAqIyrvZeQAQBRKBNbM79TBsGEx3UCao=;
 b=lMY6BP4KYcGhy8KPaOZ+5kpE2ND0iXz36f75Ylmbd6h1DODqaTpHDUxWqGZOND87tb
 O50iWsnsWg/JNWWD/8xlKT4SKa4VuSoiiNqyaVOD711pcnr3WByATCrjyTLt9bhu/cTj
 rMQdDN647XuH50K0W+pFPAnIGyhPx1EjALIfY2uoP3Om7GZvdwYGUM7Jx46p55JvXsFr
 Jfjp2kMX+07RNaYoByW4gAzV5r4VDG2985HLzQrlRrTKEI3y97J3sDsre0bheUYnbvXA
 4XSUjjN5u67l29KxunZQ8CglBuDTj4qvscv2X+GF9Ypqy1G2FE5yWonDsnsU9JwpmZk+
 vnGw==
X-Forwarded-Encrypted: i=1;
 AL+hErEOscGSyUWJQ4omNJwWTrlkK1YIiCeZC1+rPiCTWtI3CmbmdpVhgnqTd+QpM+9ppZ3Km848eYTSIVQcfvV/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/aai4OQ4/4yuCa+p7+m7HIiqBJmAQY5dXoD60VAL3LNGVzzssQ
 j6ZLWQt4zEdvlG0j60+UsATbbMu7nPE49Vt2DRNLgXj3QPOSdh1ghtd8OrzwT5OkF1bnj4rV/QO
 jOwdvRrWIy3W386fBl89Kk4mpYgZAyc8oKhL+sACvGbP6iVYkGwwi/VBbVIXS994ioNVW
X-Gm-Gg: AZFdTZdIQq16tTuM1AQc1KRBbHsvNxe4k3dbzXbFExi9qNysu/14Q6JHwOS7kErlnRZ
 5ZgIW3lT97p1pVcNVmP3s6Rivq9IhCmgZzQY+TnyENJs4OHW8vXBPw9rnGsKagjQ20VRrFZh8j3
 JPoDfZGpvgOpBDALFksu7GuSV/wkTTbq3TnLMy/ZubL/tw7rBgF51I+4o5kG/ShJ0ZLQYcPGgyK
 IDS+sY5wR1u4UMDlaCXR64m5/hG92MvRYNk6pCpTDi6Vqmv+dsh2dnnsTZd27iDX7S2C8w9XUyW
 TXLFOtX0eYIYxadJNIQ/GFBestiE4dd+X6PJawDTB79Sh7B+Fbnq9WIAxUc/WfUMw2biZvBO+XR
 TeUC/DDmNYgXSoJuOZa4ocxThX3rRTugsXdkcL7TILi1O+NmT0MieGipfZlSsLZRemb2edY91P4
 sU4F/1LCv8miyNjpkID0Hcgd1RrC7hdYbZVovjpjm4X6tJVBt5pXx3usGj7Gxj5sUqBrrojvlNE
 jWj4c3H1E9/1gMT0H2Gprzrb7Bbi/uWnNLXY8PhH73QebQyBLVkvsn3BNg8MKZhmM0Wi+99o23L
 tDP+wv8IXvDIyqWslQD5ghP4Mo8YmniqiUXmaz7HVKK4c0EFSzTLjX/+QcO4J04UYGd4rWSoTs9
 E/HPMQ/IEzNbJnUBGC5JJ6oCJoMppAov4iVxBB6VCvo2flGHfehcco0oMtHya51ZyMsoIZ/Ro5m
 cnroFl/iiRxpRcZSkUPAQgixenGv4mnnfJu3USyA==
X-Received: by 2002:a05:600c:638f:b0:4bb:7581:2bb9 with SMTP id
 5b1f17b1804b1-4bb8892692dmr484163735e9.22.1795829127407; 
 Fri, 27 Nov 2026 17:25:27 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853a9687sm820893325e9.10.2026.11.27.17.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 17:25:27 -0800 (PST)
X-Google-Original-From: "Deri Haerudi (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 28 Nov 2026 01:25:26 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968
X-Gerrit-Change-Number: 2349
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2349?usp=email>
X-Gerrit-Commit: b6bc63f13a9294dfbd40fef75b558999a7627a44
X-Gerrit-Comment-Date: Sat, 28 Nov 2026 01:25:26 +0000
In-Reply-To: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
References: <gerrit.1795675637000.I5847d602a024044d9109f521de7885d55d28a968@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njc1NjM3MDAwLkk1ODQ3ZDYwMmEwMjQwNDRkOTEwOWY1MjFkZTc4ODVkNTVkMjhhOTY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3086febd7d10c65776a53d42516bac2654b9e417-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xX7C2-000000001tZ-0qXO
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: restrict dns
 var names and values in the updown runner
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Deri Haerudi \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: abcderyscreenprinting@gmail.com, arne-openvpn@rfc2549.org,
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 heiko@ist.eigentlich.net
Cc: "Deri Haerudi \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6074842034335594344=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6074842034335594344==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L5m0AWyVJC4="; charset=UTF-8

--L5m0AWyVJC4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Heiko Hund, R=C4=83zvan=
 Cojocaru=2E

Deri Haerudi has posted comments on this change by Heiko Hund=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Demail )

Change=
 subject: dns: restrict dns var names and values in the updown runner
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Co=
de-Review+1

Thanks for adding the dns_vars_file rejection=2E PS4 looks goo=
d to me=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2349?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comm=
ent
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5847d6=
02a024044d9109f521de7885d55d28a968
Gerrit-Change-Number: 2349
Gerrit-PatchS=
et: 4
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Deri Haerudi=
 <abcderyscreenprinting@gmail=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esou=
rceforge=2Enet>
Gerrit-Attention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>=

Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, =
28 Nov 2026 01:25:26 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--L5m0AWyVJC4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Heiko Hund, R=C4=83zvan Cojocaru=2E </p=
>
<p>Deri Haerudi has posted comments on this change by Heiko Hund=2E</p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">T=
hanks for adding the dns_vars_file rejection=2E PS4 looks good to me=2E</p>=
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +1</span>=
</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?usp=3Dema=
il">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>=
To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2349?u=
sp=3Demail">change 2349</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail"=
>settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vi=
ewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2349?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I5847d602a024044d9109f521de7885d55d28a968 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2349 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Deri Haerudi &lt;a=
bcderyscreenprinting@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Comment-Date: Sat, 28 Nov 2026 01:25:26 +0000 </div>
<div style=3D"displa=
y:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: Yes </div>

</body></html>
--L5m0AWyVJC4=--


--===============6074842034335594344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6074842034335594344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6074842034335594344==--

