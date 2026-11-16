Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1703F606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 19:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dk2JB61P;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iW4aTf2p;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E2jDB7ak;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=GB0B3x40
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=v3Ga+q5E4P99lR77V6+iU24r/WJ32dy7Ve1BFjBp4lc=; b=dk2JB61Pf6SbN6m0hbCH07oi1Y
	IjgIxENSByDL4tdyfoApE9Q6gQU9WynBsGtKfu4cMTiXBSxpI3BhXOmOYoSbH55pl5Sh5UkHUaXrI
	3OVA0+LM4Ft4hyd2YqBNMiodJf63BNKaQRsDzrYr6YfQPraJbVL0zIlf4oxAcoqN2NVE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT24Y-000000008Fq-3vAq;
	Mon, 16 Nov 2026 19:08:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xT24Y-000000008Fj-0TAh
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:08:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VSXtMJb9R6UZ/a0x7BKDPyFYV7mFAP8WGRTACCzIUco=; b=iW4aTf2pV8Uj4O98FYPsRGgfyK
 87JVj6tmgzdjioDuZQwo2FtpyL1OhnVP15POt7IwmaDnIBpUYFa0lfKySDXp7sP0vIWBYO3e1CTrf
 k92J2bbrXuIpCKRSEnOLYzbM6+gBDhN10JIrz+A53RE+fo3p4TGLVfgJmpapOo1iSsfs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VSXtMJb9R6UZ/a0x7BKDPyFYV7mFAP8WGRTACCzIUco=; b=E2jDB7akZmwG/Fr7z2NCCvRCsE
 A3DdzHIzQ2+RFiYm+Ao7glbpzCsQZ3WyPhXQE3ImnJp9a9dCme1BNr3VVD7xt/KrQxyA+DnKn+K/Q
 kNu1q7Ebf2YW1QkrOfEJ4CAAlZI6rcpupEvTnQM8yIDfM60hsks6vNfXIu3uTfULhrps=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xT24W-0000000040m-2EB5 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 19:08:58 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb64c99d2fso25878755e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 11:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794856130; x=1795460930; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VSXtMJb9R6UZ/a0x7BKDPyFYV7mFAP8WGRTACCzIUco=;
 b=GB0B3x40+iK8ZsDdM0gxLB6/no5Ak8dY/o3k0E8Dq1mcEGtGmhym1WGicwB9/YoI4x
 vmuKLhfEy1832e+TIjhpQQTYEAXh2RsEG1q3ECiMTtRAMpPx0s2msyoWyUIDK9ESrHr/
 uyzLj1zJ6o5eoGeIplzS/vAuOr4B7gyJUc8chCIw0a01u890vBJmg1+SbqFqbVUHDBbD
 VVitu0CY6O0Vx6+GZmsou/WEF5a5L40wyJvbwUdibx5ae8AQ42+LKHD8jxpsOC+oHX6W
 VrDT1GO2ew5MfPbuTpEJpED2JncYn1ephVNPthLxFWCICDaUw+G2EUGAwU9mtetjrx67
 7HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794856130; x=1795460930;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=VSXtMJb9R6UZ/a0x7BKDPyFYV7mFAP8WGRTACCzIUco=;
 b=sDcXhwu8EhXUedRTdZK83+jrMABpKZfP+3rlFP26xJcRi/QZWSbudvCdc0UdVQkSJa
 s6BevbsHefEo2v5uHjtmCiA8iZh2Et+sX6Y/9rFYQPCNwnBBOrTBFJYvcF/PLT5dg2j7
 9f1Gu7mrs0Lk6eWHEfpHBnwFnrHhtgDidvjBaf0D8BPdLXu34FByhGmpcDRsVGu7IsTH
 PkJsHEryyd3WTx+8TLER+uUbgYy0Ot8em1smJS+rpa9y+vCtU8nK8Da294SI3kJHdXNK
 Qc9avr6RjcL5WGD7E4JqIurIDFwGSaIsm5I/WP0cWIdBfhDWfnQaUzNJAN6kV9TV2Sjo
 d5gw==
X-Forwarded-Encrypted: i=1;
 AL+hErFqAdUrTUgbKb4pMiLrI8rqzLrLLJS+lhKxiztAaommiS2r0/l8kzANVh8inJHzVcLh8NvyHRQ2+jg9RO4B@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9icfR2mfm0QCuo7izz3oTAaf3L8ks1Ca8G113x2Ul3froJif8s
 hjRIhfoK2Z7iW1g5ySDpVHpiG4L43+PbuoI3fOI9jwkgEZtiCE6XpE6wvWnkStaBA2gILLi5A4Z
 pBVXCjGwjf68U9dgix5lfHGWNcH2+IOUW4EXKSaBcJTVk4oOCRh6KwVy+36RDkaij6qrEtkhtDk
 NiavTb+g==
X-Gm-Gg: AYBFou36yKbBPmryQ4+jGGJu0yBrhZ/NWrSV2hvflXWCrGhoMewpHPc26W5VPcV4wZF
 blpahqXJRGRODL7jA9C7ch1tqLr4KpFbZDuoe0P4coJBIcZVBzrTXqRdiFV2nJK815tru0yxlGx
 CTE5S/bxPpy0sQJVsidZ90AHmMTYzGKzDIH2Lg/SIw48za+uBc9cVuO+25ga0VOkBCVlgS7FBnt
 4gv8Z5Uy6b/ion8xFIGjg+YhysxhpaXxViJ7dDB9oPthDmCs2qQddECrq1s6TRUO1IQsIsQOOPZ
 nYxUS1VcYsOI08PZiOmDzsusqCA1u0XLFXk277Zz0j0rxrJ1T+Zn6Hp1Xs6Bu3jQ5+XKjSkWtx+
 vDHno7HNl2Tx8pjhVO/t5WW44GJa69cN7PHXWaGYZLRtVHpQhn55V0ykjFXqUHyRuqPst963v8G
 +7jfFM7Rln7FkIx/A0LcLkQv46ymgKi0w5ykIvWUywGVsNj6Tvaqiw/wR5/KF3fyaS82z9SWRJk
 YX6m8X9zV+lkIGm+qBFPQFLDvUcar4PmYkAUAPrrjNms7j3nOmP/zb0d/8U0cHu31Tr25bLYDgA
 rQ42IPRJMCbf7CiVb01wZ3EYU6e6dG7vTb6bq1DiDB3C2je1XHu9zHyQyTOnTTWsQDL7VAe/ODb
 okdBq2nE0lGCM2m8qOOB4O4u6rWCZrM31g5rdEV8iLiOTicsejjW5+KWbTESJNStUEXVyA6KDvv
 MHKwZo1tPyLKlg3br0VPIfZq1m9byMdOjmM3jW
X-Received: by 2002:a05:600c:501f:b0:4bb:76f6:d23a with SMTP id
 5b1f17b1804b1-4bb779f5b93mr27792745e9.21.1794856129857; 
 Mon, 16 Nov 2026 11:08:49 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c8d286480sm42573614f8f.7.2026.11.16.11.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 11:08:49 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 19:08:48 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8
X-Gerrit-Change-Number: 2203
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2203?usp=email>
X-Gerrit-Commit: e4db4882281a7894baa58625880a8b6d8477e579
X-Gerrit-Comment-Date: Mon, 16 Nov 2026 19:08:48 +0000
In-Reply-To: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
References: <gerrit.1794854317000.Ice2151259fcaa256d7aee588bc3d68c835ea9eb8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODU0MzE3MDAwLkljZTIxNTEyNTlmY2FhMjU2ZDdhZWU1ODhiYzNkNjhjODM1ZWE5ZWI4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <98473abdd8d5900422c1783018049da2fb6fc7c8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xT24W-0000000040m-2EB5
Subject: [Openvpn-devel] [M] Change in openvpn[master]: proxy: drop
 always-on PROXY_DIGEST_AUTH guards
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0065610455642424540=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0065610455642424540==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9jS8AFc8Nwk="; charset=UTF-8

--9jS8AFc8Nwk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Demail )

Change=
 subject: proxy: drop always-on PROXY_DIGEST_AUTH guards
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ice2151259fcaa256d7=
aee588bc3d68c835ea9eb8
Gerrit-Change-Number: 2203
Gerrit-PatchSet: 1
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Mon, 16 Nov 2026 19:08:48 +0000
Gerrit-HasComments: No
Gerrit-Has-Label=
s: Yes

--9jS8AFc8Nwk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2203?usp=
=3Demail">change 2203</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2203?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ice2151259fcaa256d7aee588bc3d68c835ea9eb8 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2203 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doerin=
g &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Mon, 16 Nov 2026 19:08:48 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--9jS8AFc8Nwk=--


--===============0065610455642424540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0065610455642424540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0065610455642424540==--

