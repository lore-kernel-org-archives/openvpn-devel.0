Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3EC606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fePrDQ0R;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E4Jhwnzx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HDl12ozC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=E37ri5D0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=o3H45/gXWUpRQk7X2As0b4oJjdWoBubZA5RvT2Uu35U=; b=fePrDQ0RpbyFCIOacGNG/2XRL3
	kRNLwBN4rf9x13d88KMSD0y+y+F7psVMwZdNnty064Qo6qwIyplqlG0FpyYYWZ7bnYhj0PFQmR1Yo
	LDN5wEEohtxoX51QfE1MBjDvBh129wD6zYVUdFcyZHJoIUyPM+StTYkjKvdR6Jzwhwsk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOxpQ-000000002VH-2YwH;
	Thu, 05 Nov 2026 13:48:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOxpH-000000002V4-44fS
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vChe2RZ33M/VGqLrlTyDqvys1ORJHduTfv36jMIgIpY=; b=E4JhwnzxJTbHpBKD7C1Okaxy/T
 hcJfY65IPPyfrl3YWgxiW4HLj+a22U8OuL5xHcmCk60eJYJwFM8csd5GkJ1bgOB57LEJeMwwxWO5l
 rZ/dBy5D2/qUIp0R/PKsyiVA6WJ/x2WudAc7oFB2GStt+ct8e/YaA0msrXIVp8/qdsXc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vChe2RZ33M/VGqLrlTyDqvys1ORJHduTfv36jMIgIpY=; b=HDl12ozCIe5r46vfCs18raxtxs
 EYEi2pvqgchKko8IWWhpdp2Yt0JxDuY5HsLUs5wehaLFshQtayaCJXRCT9Rnzk2SKXWO8eZ6DbM5O
 1xUrdB79FV+VVTTRt7O1ydhsnukpVwGuFsYqbd7E8c7mtiQCZFNs5+bdrrHYC2wRndZU=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOxpG-000000002Mo-0bFO for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:48:23 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso16962535e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 05:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793886495; x=1794491295; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vChe2RZ33M/VGqLrlTyDqvys1ORJHduTfv36jMIgIpY=;
 b=E37ri5D0dPvteKAZfAQuRxkgj+AerAUws2GBpuo7INCvxvFOnUPrpZdfA/c5/gsMxY
 oFjBzHMxbq2eyhH3ZaMQ59bgFEsQfbUJ10e1HmtLpIzZquJ7ZF6tBB/9KSWmo7+yJ5dw
 uQngLeUzY4qh+cVoI4as75lGRlxjxUvJZt1A6tF8YF762rBFsZ7zeWyPGUvmHNbzghkG
 7Hj9CYdk7IlIXHBLsbBO1ewvyeus+lfP0iSwYH8NZH1OzAdFirwVibp05R8lDyNAk9SR
 41RSJmaLg0OW1Xff4cxrDVE7Um8ahdOrOidYdviF268jtdQxJa4Z0it4okBC7kGGJ0UC
 4H/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793886495; x=1794491295;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vChe2RZ33M/VGqLrlTyDqvys1ORJHduTfv36jMIgIpY=;
 b=n28TS5lXy2S5yj0WjYbM8YNNPEScKpviOeKqO10NE3LvcK6nkLAd291ZZOKfz1eVE6
 yEzlcF8FKxskNyB9NtK1IuFD4sApm3uKfWNr9wjGyZjZwx/bVUu+1pL1TVYWnXvnGUE/
 /thqGEUyFGn6j910WYf4SGpOmfvBlTgl/lmKyr8fy44XxFcF6ZLib+2bDbfCibvAUJsS
 TbdSf+VkqKUc/sop/7bxBWZG5QwSuvd3yf+EB8dbmIq6b6FNw9Atk5+s1he41ZS+AY5f
 8ctJy0v3H10vWozQ2EmJye9+Mlz0jvZsWW+fw7aPXfahWB4Q1kolStUUYhtjC2HoBy8A
 vrtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfHLk5+ATd/U/3NCXemwmvwJSWSMx8obOl/nBldbRt9MXS12Xqho/JyrtBjWandLAy8QGrcZkPLndN8Xkw@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8If9BEXG7/JC+pjZTy/nlPcMwE41TFI/yvVoSOfN+vqhscM9Y3
 5Wph6Jj0vNp7Fx5OokNFiLUVipkpxxYcKH5GSj5YXjTnTEnZETOj/zYg+tnh6k39ohN0z1uD/xH
 KuqEG5IKwF5fHLggZZUHPzKNFQG6rfKCqeGWuMpBZox61k7xMmYKXnUJdtMI0ed7KKDy+
X-Gm-Gg: AYBFou38msg1R6bAvWR7MpLgS9su7PZYCF1DlOqabOYuXMlA/MfS5kiWdm+C/zvPKlG
 U2DGkRndY2qeKG6a9FZ0mLG/pihk/VjpmBYCu2e5rCcDIiOQwYR8ZryFnRQLMyDt75fqfb5JKLp
 Nf46aGD8h/wg9iKs/q4u97HZg9WRsklJuOvjwfyb0bJHmFvY8967IdN3RtRCH5T6d37I2urq8k/
 awNtrMdo7cJa8Ke0VjzTfUDhdRvnuAOXzZORhB6oNj6dQ7M0OuM/xNvUlnwPA0lsQ/CYD7OD7eI
 uROj7oJ/SHhc6OQHxSrO1RhE8zFGUw6xD0/95djXuKn5K9PcC6Q/WcxNK9R8tsnjZ8CPUN/2qx2
 cSWzT0yU32YL1IjrZuyfn+E4dko//WYQmZduZFygsi8U8lHA8rHhZD8XQtBWGAttyZMlKHWcoNZ
 v+RUg18tONhSURrINn3F6txpW0ucHB+79rFdw5D2C6iBMJ8arix9lOsrpK4qQEwg+Bl+Teg/c9q
 gsBc0drjMHfzBRSleP6WHTt5yzJs6AK5Dkl5U09N05gTaUjQDjikwQN8cMfhkoE9UBwhaAfiHu2
 mxltN8GiIjZZ7RKZq9L+GXNX1dRGF4YmvJ5ooHyl7RMNUS7x5jL9upA6DnyqQfoi43AxNss7FiZ
 1/5UQOLhZBpp7e3IoVvL/8KPf4Dz/00611Z5M5+wsMskpthXmOZ7x+8ebFOoGF0+9jsBR44BSCU
 ndYjoTdgJg3FVZVXo=
X-Received: by 2002:a05:600c:8b0a:b0:4a1:742e:3 with SMTP id
 5b1f17b1804b1-4ac185bc4a1mr424482335e9.27.1793886495408; 
 Thu, 05 Nov 2026 05:48:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b40ff10f88sm101782175e9.0.2026.11.05.05.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 05:48:14 -0800 (PST)
X-Google-Original-From: "Max Fillinger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 13:48:14 +0000
To: Heiko Hund <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: abandon
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
X-Gerrit-Change-Number: 1906
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1906?usp=email>
X-Gerrit-Commit: c1013297930bac77f5d3c4e1ec1ff184870d8804
In-Reply-To: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
References: <gerrit.1788885207000.I371aafba18d336bcfd3912e92c18301e39bf6087@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4ODg1MjA3MDAwLkkzNzFhYWZiYTE4ZDMzNmJjZmQzOTEyZTkyYzE4MzAxZTM5YmY2MDg3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9f040df5acff90f244892a6a23a919bf06b77ea2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOxpG-000000002Mo-0bFO
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: openvpnserv:
 don't allow '/' in config paths
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Max Fillinger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: max@max-fillinger.net, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, razvanc@mailbox.org, gert@greenie.muc.de
Cc: "Max Fillinger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3113640075953883940=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3113640075953883940==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qaIGE2UMKgg="; charset=UTF-8

--qaIGE2UMKgg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Max Fillinger has abandoned this change=2E ( https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1906?usp=3Demail )

Change subject: openvpnserv: don't allow '=
/' in config paths
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Abandoned
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1906?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: abandon
Gerrit-Project: openvpn
Gerrit-Branch: release/2=2E6
Gerrit-Chang=
e-Id: I371aafba18d336bcfd3912e92c18301e39bf6087
Gerrit-Change-Number: 1906
=
Gerrit-PatchSet: 3
Gerrit-Owner: Max Fillinger <max@max-fillinger=2Enet>
Ge=
rrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: G=
ert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Heiko Hund <heiko@op=
envpn=2Enet>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--qaIGE2UMKgg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Max Fillinger <st=
rong>abandoned</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1906?usp=3Demail">View Change</a></p><div style=3D"=
white-space:pre-wrap">Abandoned</div><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail">change 1906</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1906?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: abandon </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: r=
elease/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I371aafb=
a18d336bcfd3912e92c18301e39bf6087 </div>
<div style=3D"display:none"> Gerri=
t-Change-Number: 1906 </div>
<div style=3D"display:none"> Gerrit-PatchSet: =
3 </div>
<div style=3D"display:none"> Gerrit-Owner: Max Fillinger &lt;max@m=
ax-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@open=
vpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83z=
van Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt=
; </div>

</body></html>
--qaIGE2UMKgg=--


--===============3113640075953883940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3113640075953883940==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3113640075953883940==--

