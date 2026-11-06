Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30FC606D805
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eSMCLH1D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jJGOidI7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=FnIjLxOz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IQY4PivQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ok5YXsc1VEUpELCr3TN8etYWsvx2Vu0FSLYdrpeCjPI=; b=eSMCLH1DwEHVUPhghpZSYtuICP
	O7ccvItDyAzPd01kuOtY/gRv4CBaBhRQiySuUxNVywpObDv2kyHaZ1YI1Vn6KBusWwkf8oi3paxfi
	UEclHSu/S03mxAJRfw4kq/IO+qtqmtcBPNncDUCLx50vK10Fho4425lWY1nx7wxQtPAk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPI77-000000003hU-1WG5;
	Fri, 06 Nov 2026 11:28:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPI76-000000003hO-0pAQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:28:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T6mYEglYQbQ2P7OFAGhnr3aXIAGMJEiVEvHFiaLnWIo=; b=jJGOidI7nNij7vK+E8ZjoyqOdw
 zxhZW3McdpuYRc98T4eb9pm2zo2FO6zWoFaQEDLygtZAeydIDxl7aN9e46F7yj6zzHEP+SS0zG08O
 sZ0Al1pgrPYpfGa8kCrZF41gfSoKlSFHaPXl+TvWhMXrfzbwN0OOFFqdXBFuhoZGCie0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T6mYEglYQbQ2P7OFAGhnr3aXIAGMJEiVEvHFiaLnWIo=; b=FnIjLxOzkOu8CxwLOQWlzQu95K
 ACMbl8qFMquXrsRcRS76Bj3u8C2mRZGv7cNF72ftWcHsBiWBI9ZpLbfH30ylWF1W/q/a1fsKqLdPL
 XMELBvVcDOIpK4gv8IyAudK0gfOWjDvOTZ/urTREmrJuaJVssjDLUvgH+BXLl4zwb5eY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPI73-000000000n3-1PKO for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:28:08 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so4935765e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793964479; x=1794569279; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T6mYEglYQbQ2P7OFAGhnr3aXIAGMJEiVEvHFiaLnWIo=;
 b=IQY4PivQ6B/r06NU+lW+9h5pU9IOSxZqSNI+t9pOJIqMHEngLaDRbH5KXLyK0aARFe
 yZcKTmWTOO0sn7MyuDw83wbjDsgipkfVUnvPpN6aE0lokjCZvJXQLaDuHFSv5wroc4GV
 4UJmIWZiaRsD/mFtnPSq6H4SFo21w8A6ejTq0kDe5D5hhLGuPlsSClTInLdVoxhS4h5T
 1kOJjIifqjglSq8D7BrCGXiQ49i1ILqto3kVcsGp0OyjOFzGMPNFt9r+mcgehbMMQ2I3
 NEPhK8dQxHdP09Vy9RZtkeSzsIfKYEKyDWl+E36la3x1jo3ZIHc3PAqj3lR0ieoEGjtS
 BdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793964479; x=1794569279;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T6mYEglYQbQ2P7OFAGhnr3aXIAGMJEiVEvHFiaLnWIo=;
 b=FtxKPE0eYZJAXVjM3G7qPENTiPISlX4T4twnqvuqjgPfYMC4u2FRblLCAbZFbofRus
 BCHe+1qV+6g0aGe+Fn1vteyHyA4SFbmXjc2h43sg7mad4Yy+ybTO86NCpet0AU8r5SKm
 cFI6nboBAsEnxOEsd9uFlBLHs1UqOAD640bIM9h2v2wtEP9fRldr8yTEKao8jqfoa0sy
 sMvpaQ+9KzLw3xOzZCIbJ9xyBlXv66rys/vyi9UFqzje+HXPoD5VOnZd2JixoltZGLOU
 u5S8Pnmme+fpkpSc8kEGzSEGKWOTB5HvjxjfxmHt0QRsSUM7+J+04zHHlIf7ib/mpOI/
 kECg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCMizzC3uFBAaxibFHjF1Liefs47wHtoYcrh9ug4ONJxYQrNCJ6k1CNleHw/plqxBt8o3Em4aWqP+gKyNE@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+Ev3ApHRb2WFHRTiitnbN2eWpCBzqhbGMHeqXWGOCaLOEtKOtg
 QBAMqBh9GMd1AkywquLHczUJgWolOZ5kC3KocvwrCU6EzqMg+akif2mHcZKzw3ABu9ZAM6lAlTg
 84JwluqVEkUN0gbF85g3VEhOeJ+SzLMfl9HGHGEZpoMLquWfrYYZOvYHkYuMsaW5ezj0C
X-Gm-Gg: AYBFou3ow8s03WwXmC72ek+D9y7TFH3AU6oWxqSj8Efo0/P/WvqDKjhC7MChylFNm0t
 BC4m2H98dWxbcemxYuKwTHGqnCdAggnrTaNnN/Uvuo3tS3pjbOydys7FHrOi0aC0f3yrbq16aXQ
 hv02eVMbgdVSYT2lTuqci5c44j+c3TXDLKoLczt2mWkclC1YTIeYFg+hGUh8QOLszikO+/Bkvha
 3ZNV7YVPM128L5DUZnEvjA6q6x44ojIJ+y3LSTF2v/2plQoaCpUan8+lM6DnKK9T8CeVR41Hokh
 nxhgv+Vetq5S7Sib28mN9m5MMIpsB9TrWN/ZGslbjrF9PV6C5wflwvVHiD1i5FItxJMnirTTuWM
 ZSivW276479Nc96U2il4ZnU704Dpp8j3LcpQhSJ6WOa+Jjg3xNuAfYKPlCR9qKiqHYwv3RaagoD
 J/xUqHecuSmCbqiLvAlORgw36JBSKPd9u8kbedMC2TptaI+Es+/m6abrdAZ3wWlsyQ6Qi1OMkbx
 nBXgCkhvEqzadH77eLE4GkDYlnuQKmWroJGldLEhMpk+R2w3TUTvB+HLsrPQ9cTgBR9zxWE9Kdi
 KI9CxOJ6rjZqPlCqmhUS+FCL08scw6/j0VGohh7EmVcqek4t3awtavNXzYlx6vk0tBYDGaRIXxk
 qOSooK+PN2ycEEp3wOJSkcMPTlB74yIH/N+FayYqmqf9qXjQjgdzRf5PPm9seNubkf3hoDjMwSO
 4VYzU+4aByNGACmw596eLMLLR/RFomZK1PnlA=
X-Received: by 2002:a05:600c:1c1c:b0:4a1:ac66:6ac6 with SMTP id
 5b1f17b1804b1-4b6dfbac6eamr38125005e9.26.1793964478560; 
 Fri, 06 Nov 2026 03:27:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56e58fcc6sm241618025e9.2.2026.11.06.03.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:27:58 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:27:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835
X-Gerrit-Change-Number: 2130
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2130?usp=email>
X-Gerrit-Commit: 960b56641b7814262f6a811e7f4338d4224bb741
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 11:27:56 +0000
In-Reply-To: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
References: <gerrit.1793794235000.I3a268fc602e916bf54853c950761977cf3d7f835@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzk0MjM1MDAwLkkzYTI2OGZjNjAyZTkxNmJmNTQ4NTNjOTUwNzYxOTc3Y2YzZDdmODM1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <39d4d662e4811a27a69582c3c90251a5f4d2aae9-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPI73-000000000n3-1PKO
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Adjust
 ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1077803710539356513=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1077803710539356513==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9qHQGisx2G8="; charset=UTF-8

--9qHQGisx2G8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail )

Change subj=
ect: Adjust ACC_MAX_MSG_LEN, fix ACC in p2p mode and improve documentation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 5:=


(1 comment)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2130/comment/5d476727_407cd659?usp=3Demail :
PS3, Line 12: Fix that the man=
agement notification about negotiated protocol is not send
> Typo: "is not =
sent"=2E
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2130?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3a=
268fc602e916bf54853c950761977cf3d7f835
Gerrit-Change-Number: 2130
Gerrit-Pa=
tchSet: 5
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Re=
viewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Comment-Date: Fri, 06 Nov 2026 11:27:56 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojocaru <=
razvanc@mailbox=2Eorg>

--9qHQGisx2G8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2130?usp=3Demail">View Ch=
ange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2130/comment/5d476727_407cd659?usp=3Demail">Patch Set #3, Line 12:=
</a> <code style=3D"font-family:monospace,monospace">Fix that the managemen=
t notification about negotiated protocol is not send</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Typo: &quot;is not sent&quot;=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2130?usp=3Demail">change 2130</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2130?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
=
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Id: I3a268fc602e916bf54853c950761977cf3d7f835 </d=
iv>
<div style=3D"display:none"> Gerrit-Change-Number: 2130 </div>
<div sty=
le=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichte=
nheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Coj=
ocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 11:27:56 +0=
000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display=
:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>

</body></html>
--9qHQGisx2G8=--


--===============1077803710539356513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1077803710539356513==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1077803710539356513==--

