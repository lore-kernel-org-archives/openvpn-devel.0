Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F323C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 01:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:
	From:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y3mLTn8uvgpkyFDscb0wBF9gFc25X6z7sufhrcecWQc=; b=Kh4CXfM/WgzrjpWsSvsu4MNGbW
	11pQlu4Ja70lh1nb0FC36aJikXYjdMoY0M2PXROe2PlMpwRcNhQ3h7qbTvt8M6TRgs6jP2LWnry1v
	57s6LXx+BLiaJAAIPNrnckUvxpYDfW41w2VaZqT7EJ3RbLSdG1Gt2TyK0+bb/71hpBqY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wejjq-0002VG-Kw;
	Wed, 01 Jul 2026 01:27:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gaikshudhanva@gmail.com>) id 1wejjo-0002V8-UP
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 01:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cPHHJgxmdFaznTbcvNUUwB6aWjSejL4XHqS+1guveMc=; b=lsUerpaJD3dC81Kf9nSUT58efc
 Bjtz6FAoTvDka5Zf8e61+UnIj/xqqwA9vMoqyzbBdsGTgeYPUulqcWnNGGFuPcZzmHMeNTZRaOlhV
 1/qNNTuL5li73VQiYiCYeAGtklIBXGJ71WCjzKk2+PO1W3aeXsMqAbMDxblXfWpnZch4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cPHHJgxmdFaznTbcvNUUwB6aWjSejL4XHqS+1guveMc=; b=c
 Diez1BjOIInJ4gS6RiDjsICwf5DlDzFWvH8R10yzrGKTwJvcTpbsloNQ0j3IeMfNnyGFAHKC/PoPO
 hFRXHdtaj0DrJJ1YILGrkph2OUswZ3qZiZA870R27YcITKGpa6eIQc4aO43BWqELTcIvzAHYJFNeE
 ELwjVviRFWgDuk0E=;
Received: from mail-yw1-f179.google.com ([209.85.128.179])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wejjj-0006vJ-Li for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 01:27:41 +0000
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-80a123ef90aso1674827b3.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 18:27:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782869223; cv=none;
 d=google.com; s=arc-20260327;
 b=aSxYcAUJR4U1kp3tIm461newzHHojvw9TWTLPWVcMk7pmJ+eCYL06TBukjCSIMD+QN
 8pgG4NtThBNdqGp+f5mJVbO1ppl+QdCMnFq1+vQB3+EelZxI6HfOv8VHonnU4Avgd9cK
 zb59PyzzQ/BUGms9NefVakq65gob5NV99WyWr7mNNLysDRWTdodYLkCHvK9qFxwd4N1p
 2nRjDBmaFt3r7oZ/t/X6hwfAoX/DCH0uUB4WMDz4Wcmr0Uw4U9eNivvWJTS8HWSE3CtQ
 ti8ZkaPPdZr5EXc6XjFqoNSKvkMDaCWX2a12RA8FIQoSHbYCJweWp4hULkv9tiPWjo5X
 E1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=cPHHJgxmdFaznTbcvNUUwB6aWjSejL4XHqS+1guveMc=;
 fh=4NbAC/LsuMLI0S0hprUlLSLCiHwg6SCAifhH718Jh0Q=;
 b=mMkuYxbNrN4qbBRPTRWxK9+qX7VM1qErF3FVG5yU1dhYT+n7DRUXAFvsV1SmGGr2+V
 tZororGee2099kv5X5uKGP0RZwVIybArhH8XDun2/U1QjHHVNdlrk/4+hL0jcYAfKPwk
 GhHr/+iA3rZejLbjqxESk52U8iYIUqZ3X1/JiqjglqxpP+AXamSJRYlQjiJY/TSHK7nc
 UWnLUeqSrScNnqOq4amTspg0Pwda5gu2jviwuY4DWE/GT07sbA0rW0U17WrMMQUlS3yc
 kjDcosx5+Ax0CelM89RabjC5vQgXp3k+/rAtZ12Wfr3ykINad/H2WzIrPBjdm94Smy8z
 eTbA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782869223; x=1783474023; darn=lists.sourceforge.net;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=cPHHJgxmdFaznTbcvNUUwB6aWjSejL4XHqS+1guveMc=;
 b=UhfY+XkgyY3XVgF3ABjfmJzilPPlW2jyEqUqVRM6mbByXwZUXURcwXToPkbqHTybFb
 xs9eiexbU+EnR0Uz+ogrKVKe27Ggc06hX+JflDQoCCddCxe8NNHhNd45iNsiVogkmIgz
 uvmp63hT/qAv6KxYXVNJ8qZR/K7xuHwkpLXEZaFpN9wFviw/9+R3cScxWvsnE6GNoC1u
 9AXW3e8c4xvoqtha910JKPTIYFQihAO/bXJQ1y4X+dfqzFF0sB53DOD5JhPocj2rCFRd
 llXaB2BZYGF1xJMMe3FfwlT+AqC+b9WI0z/cXU0M6Q5a7akm9zwzYi7mO5z6zS36h/6t
 DGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782869223; x=1783474023;
 h=to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cPHHJgxmdFaznTbcvNUUwB6aWjSejL4XHqS+1guveMc=;
 b=YE7sNlyKU+NuzdrWeiIHXV9oTRUyuDsqSQb/xkSFTkSyTdfvYPBvC6rgWaKfdDY+u5
 vkdj+Ysc0stN/lBAdORZLVCcY/LK0kHBY594C5bspVppH+qOsFoVJDBzxgZIrsBKlJPN
 XFd1MDl1FSsAL/3SRHXtMieaB/sdDFPNb1OmjL1+t2sriNB3MfJlGOYH0dNml3t/Z7eZ
 Gve92a+3wAYQ4kX1gcDJ2E0r2MKjoGdn2YBiwZs5wLXD6dpn8Plm97Mww4fr9KKeTe83
 d9kG5Udk5GVbihhourWar3dcznvQIjkwEydgT6YPYJKvUJgjKYinyb48jCyRSP0H83Cn
 O2cg==
X-Gm-Message-State: AOJu0YyyiW+nKYQOp7kuyqayYuyJzFf1tkL1A7NPVmDYqfb9lU+tHTfx
 +5wJCRUHP26MaJaC7MpCNeNlfO2HAG3uMhvslujDESukIjxbsJFXeanOkTX/imvGKL36+mhVCex
 Cuog/AWKg5JKsHjVP6olckyGiax8j2RT3EuG8s+I=
X-Gm-Gg: AfdE7ckYvDWBviVAXLAGJrDkeI9jDAurp4qU9rncbFrPc/cnYyrfkS/jnJ9IlsaNqHR
 ZZN7c4YYlLN5KJg/ltyb7sJMlDF39+zXOKFkCu40kiyf8zb7uW0DcrzaYYlWoH2TafDc85yo7zW
 YkC5AC3EKSWR3+udQF3SGGILUrFBcSKSk6+kIgHLiFyPNf21S4lSozUNGTbBY2eudU7PsM8xhBI
 5aMuN7a+5DiMgEjjOb5oxAQ744M6SeQe1HpJTV8wmNHpSuJYMWyOYBi/eKHuZxZuDcGtJ8=
X-Received: by 2002:a05:690c:3482:b0:802:2e2b:c644 with SMTP id
 00721157ae682-8117e2dd62dmr36664637b3.6.1782869223408; Tue, 30 Jun 2026
 18:27:03 -0700 (PDT)
MIME-Version: 1.0
From: Ikshudhanva G A <gaikshudhanva@gmail.com>
Date: Tue, 30 Jun 2026 18:26:52 -0700
X-Gm-Features: AVVi8CcdAm9P5JZFHs8G9AQWvz66NnpwLn-bOE8OjTXrk3zur4-0JSCB7sSUK48
Message-ID: <CAA8pc=TJhLQ66pGGA_3Qw_OWSYsyMN=Ai6zwXvTtKy_kwhxRaA@mail.gmail.com>
To: openvpn-devel@lists.sourceforge.net
X-Headers-End: 1wejjj-0006vJ-Li
Subject: [Openvpn-devel] ACC (App Control Channel) support in OpenVPN 2.x
 server
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
Content-Type: multipart/mixed; boundary="===============8079950624106356194=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8079950624106356194==
Content-Type: multipart/alternative; boundary="000000000000be097106558296d2"

--000000000000be097106558296d2
Content-Type: text/plain; charset="UTF-8"

Hi,

I see that ACC (Section 8.11
<https://openvpn.github.io/openvpn-rfc/openvpn-wire-protocol.html#name-acc>
of the wire protocol RFC) has been implemented in the OpenVPN 3 client
library. Are there plans to implement ACC support on the OpenVPN 2.X server
side?

My use case involves collecting device posture signals from connected
clients via a custom control channel message. ACC would let me do this over
the existing control channel without needing a separate connection.

Regards,
Ikshudhanva

--000000000000be097106558296d2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I see that ACC (<a href=3D"https://=
openvpn.github.io/openvpn-rfc/openvpn-wire-protocol.html#name-acc">Section =
8.11</a> of the wire protocol RFC) has been implemented in the OpenVPN 3 cl=
ient library.=C2=A0Are there plans to implement ACC support on the OpenVPN =
2.X server side?</div><div><br></div><div>My use case involves collecting d=
evice posture signals from connected clients via a custom control channel m=
essage. ACC would let me do this over the existing control channel without =
needing a separate connection.<br></div><div><br></div><div>Regards,</div><=
div>Ikshudhanva</div></div>

--000000000000be097106558296d2--


--===============8079950624106356194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8079950624106356194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8079950624106356194==--

