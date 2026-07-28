Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFB3C53219
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 12:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PgbcYVqD9LYGCqJXFLmr8JxfYMaPvoHX8KoNVuCwx2k=; b=c908vJtZYJTB7NyiW6WpCArMz0
	y/CdDYTHt6X4mPuGao8LuFFv0iWWuMqG4I0oss4ofstGD2SRLAu0CYc06hIxo/Y/XVJkyfhfc+p6w
	J85DMOOtvvg5OV7ijGgaT+4DbwBgUyFt9DFfSuCtZAAibyNXwMc7hvoU8FPy2wpuK2ZE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wogbW-0006W7-RJ;
	Tue, 28 Jul 2026 12:08:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wogbV-0006W0-J1
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:08:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xrFN60p7F2pK6DKkpAuUn9PqykImV/lpHtWe2/cQTIo=; b=kOqJf54jyuH1j6owaY7BND7FoQ
 Jlt/hA/Uk3sZM7Yo3qv+n4nhwJsXmQUABlzAcrxl3rFnQgxckGcNroJcaqfrRPb01yXcARaliJ5cb
 MpEiSWI9nKyuyplfCYGwZ2IfmwDSUNSiJNXgdj9gxZxPZesz8cHKsrIpKaCt5piwDCeI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xrFN60p7F2pK6DKkpAuUn9PqykImV/lpHtWe2/cQTIo=; b=h
 ycOMoTvpe6VexsXFKQcc/TCdMfA+KpVc1bhe4Z63hU81DlenwCBOZXCxTeqT7PcrEMEh8Z3xvK5qw
 P67Z8iXL+9F9i4Mx/mw7BATJQPgbLwwTRiYFbx0zKOD9mDOrMj7Pb163B6WdKX8ugVEsvMI08pXzp
 XkkMRuolSy2TWfVY=;
Received: from mail-ej1-f46.google.com ([209.85.218.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wogbU-0003Z7-TU for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 12:08:14 +0000
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so150017266b.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 28 Jul 2026 05:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785240486; x=1785845286; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xrFN60p7F2pK6DKkpAuUn9PqykImV/lpHtWe2/cQTIo=;
 b=b5RvIj3wufyS7bWfLl/iRt4wJm1i388F9Gr+JGe+IIbKinRFn0j2W6EXdcOAfVsbTA
 zkrIKGbYL8r2waHMnJxnCv3OlKSSPX/G9GDwhCFxM09r48kWWMjrCtcq6Cb8xKoNIlrc
 H+EjFT008difxK55LHJCpBqfjNrw5E2kp3Ksq4t881YsqruP207fldxeP5EkowJpx17Z
 mQHl5QxB1mF9lfKhmHjg8IuglFmZqmgRxvG7pVcXrWRpu0SW1NhRlx5F4ib4TNZ3T9/5
 clvjvuCoKTMwmIyfvqiqARXgP1vhaYTb7fbsmL1BVXXI2XD5ydRsOzOjUe7RdHJO3gU9
 9Eug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240486; x=1785845286;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xrFN60p7F2pK6DKkpAuUn9PqykImV/lpHtWe2/cQTIo=;
 b=tMp5RcIRGOnry2HA6Nlx1OLZT3u2O2W1D4zMsmRHPDyl6z+Lt633J7txySxDCmxd9n
 rScFqzG5fzraMjKIzZNhirWsE0N6RWlHMUnSO/8KIMM3+37WqdB4CELRaeIoSHVzid2z
 RR2N2wOGgp3d54AdX1S3GbRjzgKI4ngFog0e0pSPVcY8+TTXlwlN/Dnuv5hD67ln1hFK
 S25BC5++wNVpkxKpJz4Pw6vmIz3VxJzAS+leDpqg4eNgOWR4wv7F7PGCzjWZ86rWDTZt
 ApAF2NONaNMA5oOQqshSpWysaJayNtq3FMs+JtYH85La5FATf0/x/y1tdIQo9l3mAHPD
 i3xw==
X-Gm-Message-State: AOJu0YwhYjmX/yi43La/WgxSeAbFJOQJB8vhfRXcmvstBql4KwxuntHO
 Kl8n+3eTDdZd4A0PMSJnnvPzQnZHcDgoyMrUdGjhmQgB5O0cGX7+74+d9UsQqn+f9TMHizjM55L
 ABcegScwlB2vksrk5N8ctPEQ7oHR7bjndjHg9oQIE5CGlNjrVBzV+SAiGCISbTF2Gu2+oV5nLde
 S5XGR4cg==
X-Gm-Gg: AR+sD11rN/TgjFOP1xiPhNJDWG7HGBXAtrxuKtgoeUAFTm6nfjNBemfABJOlUNCOArl
 L/Hay3umZXKkmRWEgxl0htIx9k7JKKDEPO3GzjHyheiZJdelHqpXbft5V+BtqKlmS1+2BeCTkvT
 Frs3uOEJcFnx++yflJQ7dBr38Zg0/MoLYFY+PdcDRE+nbxS6Q1l0th3K+VdL+Cwx8/838FDTYQO
 AdJRD5eV23FrjwDIHepvc408TcEDfEZcC0VeRB3ttnKcgc3zAfTcph02olHetgmiCco9eBW7adG
 aXReNrkNjAN+pV4sHpIL7NzA68vXte72Gh5Evy13wnV1owuu+c44mLxnryVc0r9EuRCi7xbA+m9
 gLcDJU8Vq5rM2+CtobQ5f6LXHVBaezAQwQr9TGeHvdxQOhx/3DcVEnF6LG3f/zqKLfhtCaBLHY4
 3eNIEYkIRlv/+vLdPjzgsZF/MGN7+kQTNbzax6+WDXQYxG73AL5VJOpLWLkLq/NfuK+qWkN01pN
 YJLWejjxtFc3MvsUW1zpb/LM5rGjE+PEXF3jLHyrgTm2QKqpFw5kQcTI7VVK30IoUfGAUMnXoTV
 rLs=
X-Received: by 2002:a05:600c:3103:b0:495:6934:4146 with SMTP id
 5b1f17b1804b1-496c6575ad5mr20855095e9.11.1785240064247; 
 Tue, 28 Jul 2026 05:01:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c45cb960sm67370115e9.9.2026.07.28.05.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:01:03 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 28 Jul 2026 12:01:00 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8
X-Gerrit-Change-Number: 1828
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1828?usp=email>
X-Gerrit-Commit: 7601d26b4b32d6caaabf806b1a027f82c947a9ad
X-Gerrit-Comment-Date: Tue, 28 Jul 2026 12:01:00 +0000
In-Reply-To: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
References: <gerrit.1785239387000.Ie33aea26026e07c860da7d79880cef6b27b7b0e8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1MjM5Mzg3MDAwLkllMzNhZWEyNjAyNmUwN2M4NjBkYTdkNzk4ODBjZWY2YjI3YjdiMGU4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c4fc9a16e1b2f772b5d6d7bd8addcb196038e6a7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wogbU-0003Z7-TU
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Move schedule test
 to a unit test
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3040807751584998149=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3040807751584998149==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hL7CTqfo3eY="; charset=UTF-8

--hL7CTqfo3eY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1828?usp=3Demail )

Change subject: Move schedule test to a unit =
test
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 1: Code-Review-1

(1 comment)

File tests/unit_tests/openvpn/test_misc=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828/comment/bf184d19_1d7d=
5c8d?usp=3Demail :
PS1, Line 493: <<<<<<< HEAD
conflict resolution damage

=


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1828?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit http://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie33aea26026e07c860=
da7d79880cef6b27b7b0e8
Gerrit-Change-Number: 1828
Gerrit-PatchSet: 1
Gerrit=
-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenhel=
d <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Tue, 28 Jul 2026 12:01:00 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--hL7CTqfo3eY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>Patch set 1:<span style=3D"borde=
r-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgroun=
d-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1828?usp=3Demail">View Change</a></p><p>1 comment:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0;"><p>File tests/unit_tests/openvpn/test_misc=2Ec:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1828/comment/bf184d19_1d7d5c8d?usp=3Demail">Patch Set #1, Line =
493:</a> <code style=3D"font-family:monospace,monospace">&lt;&lt;&lt;&lt;&l=
t;&lt;&lt; HEAD</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">conflict resolution damage</p></li></ul></li></u=
l><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
28?usp=3Demail">change 1828</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1828?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: Ie33aea26026e07c860da7d79880cef6b27b7b0e8 </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1828 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-=
Owner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-de=
vel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerri=
t-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jul 2026 12:01:00 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--hL7CTqfo3eY=--


--===============3040807751584998149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3040807751584998149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3040807751584998149==--

