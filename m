Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BE8606A32E
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DoG1FRvi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=QEBxUQX1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QcQkMKpw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Qfa9ejTY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6tVSR2FvcnCNEwqO4R2v33UWKJqSjpciwx4uwfAnlc4=; b=DoG1FRvi4jvPl9nzdcfqn7PyE2
	hpVk83PD04BqxAHHXr6fuEcJMpKBJNQKh34yQ6HVEZWI9A5WVTQeI8Gyc384dJuJOXhtRMOby4aNw
	wrOvMXE7qkrsnYukAiVrqh1I6fGfWoz7RykoUo3NkYolMwMToY11Pn44FCZ9XnDPN68I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrSB-000000005Ef-2xyJ;
	Mon, 02 Nov 2026 12:47:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrSA-000000005EY-0LfP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:47:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qI0AXRTjkFz8iV/CkV+GxzkoqPSFzvnFbEojzy98XNE=; b=QEBxUQX1P8m7L94jiMybKQ/40s
 AwJITXhDw05QcV58B1p8IAfS7zU6lzxTC06cE3xnP/Oy3Gw6/Qundz+/nD8zWV6owiq66fMSLKytS
 VqbgBU0VNEI9D731/j2NMhNs43YJI7M+BdKSV/GTbf0/fdGQkYnRZMC2NVmdCMeY3CQo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qI0AXRTjkFz8iV/CkV+GxzkoqPSFzvnFbEojzy98XNE=; b=QcQkMKpwe2eyMIqOdLlS6snPYv
 cMjkMFzYp8hH+NcADW4sbwUQRSQkRZYV3GCyRmCePEsTUBxIovIASbYjMb04spCYbXB+JsWBB36MB
 zywZiY7SalM2XZ//BN58qVRI4GWAfNI7c5PqwInE5UbTyJJ3yoO+6m3vhzbyAuN2qWEc=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrS7-000000007Hr-1ER6 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:47:58 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so26282355e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793623669; x=1794228469; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qI0AXRTjkFz8iV/CkV+GxzkoqPSFzvnFbEojzy98XNE=;
 b=Qfa9ejTYHCJZ0zUAdX8duLrLxv+yF1+1uVNq0R4R71LFXPrTHqqvwKH0Dqxv4rqDza
 jx6Y/iLNJIdx8kYi/VAPppTWFXY4GzTXwow7WagliVq2wD22OrjOGVFCUuooevxUhdYw
 nIdrhHDUkcOYuSQjfoqXE+fY5VJbmWOgBLlXXbpmnkJ/8eXK8cXYk9UMNKGSZ6To1rUb
 gjvZAJJXDzzPT+QV6GIsTxDD9tLcSLWWyPLhN+ESELaUxvp4ZkFVT9zUM8V/qi2vpSML
 6cudvu2SKy9qxNTXOINhEoSG4mLU7uDxANrFFzXRUmpXTmPquHDUYk8rxhNQkyv1fCme
 4AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793623669; x=1794228469;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qI0AXRTjkFz8iV/CkV+GxzkoqPSFzvnFbEojzy98XNE=;
 b=bVmanUNIVSvpWjUehEuQXeyr9Iqy6jwqyuIhVHCyakdelpZZzRYpkYM6uVD1nSaPDR
 SbIO14LqOT5aScMkhBbkDCxhZLVUJ79tAxjtAvg6fOWRDkrVaPt4zS0IagfBmqDrbMIv
 qbnkI68m+LT1K12d/DKTpn6UMXcQZ0xWeiOUzAjETC5ob2a2q0JGTnT5f05y/5jyNrc+
 75kE+jwmqqLw5N/cVyOFdk1rEnn5g3WPmyiNT7uiiXirb/pQctzC8JW19WiIAx3uFRUs
 nwyuaBRyiMzZpWC7XBAf5RdwE4L+Rf0NUj1hJKYa0GhB8H1dmC9NuByZtoUrvSn9MAPR
 CsOw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzN2dPLqCSIagZk8si44LE8oweccHpatp/Nto5rCEJQA3fjyePeqWUIbTOyzheZV8nCYqiPQPQjTiddMpzY@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIpwXzyfl0qwzWxz4j0n2J3Fh+jrJssSzRYWACpmiYuBjmb+6b7
 FKPnFErqgTSqvirNGAkR8CzhGnXnk5WM3PtHk9sXgKPw1H70ZasyX8OWeDcB6903GIiK07X8EYa
 E0vA0FEgnHK3G5T24fPt8lhTMBjsqO2jLZ4Euthf0poiI7o9sBG+3OG47053PCaZfSzRt
X-Gm-Gg: AYBFou3w66DVkm3dIBxlDKT+TOL3PtsM67cNdnWaH6VqyVwmdPcFc90SJSIpcjOPSnv
 IqOfVbkd9iS6D3xWLflxQ8wS9BHELtGLAaOqKzkZglGtz26N7twgrkdueoKxZFyBs1/Dqax3Uj0
 YvL/dqbIG0oj6kLix6BX4Dn8Y8/NuHtfzRMRr9oEuJg0HRaTVAilNWqzknfMjHZN6LN+ndGUnLE
 j6pWPjR/L+jVfO03n30oh4SS324jp3ioWrVD7Vg41evitOlW3zW5ihmui3pv6SPEjI1MIp4tFCT
 GN/4A6jUiC8n6XUt50/4ojvsyS6ufWkZ6MYoYxOEt1b+MtDzLhwWx6LFRqKFH9E3fWo6c4wl0MO
 lKHMrhC31h6p7CI/R08EQPZ9r1TIPc7YXweQ0nEYaSC1uXl5m/ul8krCuLInqOcvCCCEpT8iIup
 j/lCrD/293XQl+iBHjOuS9tb8uM/A5EPUHomJJOOPHUcjyLUEAxbbREi2kjRWF03iFvRWNlq+Ma
 yJ744fZg3z62BssIwihjeJh5JsDh5YbLN4ivOUWgpF+o8AkE3OepT4tnmhnnd1Z7w0K48oUtoLw
 eiUC6JX7XF7FB9fU/mQ8RgtpxHtCp9zpwX9GMvBqJYhaEXPswYY01Ep0a+FudBZHiwxxiheaZ6B
 kZbBzEl0QZpraThv1/3OHaRddTeYOUPUEj+buoy1NVQxn7w+1hoE4uDi2Ar4/dqHcv5j2xscSVq
 HNIiEKWE2dUJzzJw==
X-Received: by 2002:a05:600c:3554:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4ac14ec66d9mr242979605e9.2.1793623668678; 
 Mon, 02 Nov 2026 04:47:48 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7c5063e3sm335103115e9.0.2026.11.02.04.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:47:48 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:47:47 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a
X-Gerrit-Change-Number: 2089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2089?usp=email>
X-Gerrit-Commit: ca739b2af0d0df61b9940e08c82052a5035582e6
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:47:47 +0000
In-Reply-To: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
References: <gerrit.1793623141000.Id6587b3d44d3326cae83c460cd85e8570ee8666a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjIzMTQxMDAwLklkNjU4N2IzZDQ0ZDMzMjZjYWU4M2M0NjBjZDg1ZTg1NzBlZTg2NjZhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <345567f734276adc7b3435d56ee4f621ebc1c8cd-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrS7-000000007Hr-1ER6
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: crypto: assert opt
 before first use in openvpn_decrypt_aead()
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3356095922803655983=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3356095922803655983==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="++59KoIjQwo="; charset=UTF-8

--++59KoIjQwo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Steffan Karger has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089?usp=3Demail )

Change=
 subject: crypto: assert opt before first use in openvpn_decrypt_aead()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit h=
ttps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id6587=
b3d44d3326cae83c460cd85e8570ee8666a
Gerrit-Change-Number: 2089
Gerrit-Patch=
Set: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Steffan =
Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailb=
ox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Comment-Date: Mon, 02 Nov 2026 12:47:47 +0000
Gerrit-HasComments: No
Gerr=
it-Has-Labels: Yes

--++59KoIjQwo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Steffan=
 Karger has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2089?usp=
=3Demail">change 2089</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id6587b3d44d3326cae83c460cd85e8570ee8666a </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2089 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Kar=
ger &lt;steffan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Mon, 02 Nov 2026 12:47:47 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:=
none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--++59KoIjQwo=--


--===============3356095922803655983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3356095922803655983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3356095922803655983==--

