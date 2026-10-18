Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D246CCF2D3
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54jqpnDOdVLaMEQ5KpVug4TaxQ4YxJ6SEi8zk/ln670=; b=jqWOecNF1VNoi7Qf7rKzw69yKp
	AVn1I/EiYMo4x01qTo3xQG0BXNObZm/e2U5cVmNpw7/0B8kPose51nQJNci2reiXSPXgYeKRBYJ1Q
	aQ3CUtyZSioTiq/Zeq55M221GIRVLORvaNDOY7Pm0saUuDl9SeYefdGcG6a9/FQIFJ5o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIS90-0007l4-EA;
	Sun, 18 Oct 2026 14:45:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIS8z-0007kq-0E
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:45:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=4T8Tm40Gh7o2sB89/V5+4DkPUlWC92C/EXAJelAqI+o=; b=Ah9t3MG3mzNeM6AdmehPTNDTLf
 6MosR3jemeWNwScuWFg5pPm+D+/6/iIMouTUmAiLszWGKWOCltC+qioEzHl2LYJY9qDIu38rMHNSn
 Hm/kIBeS97SBbfEOKlIF1bMIEH/6+T+svWUkH1xLf8b2FhouYaMuppcGJ+2x/4VREG0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=4T8Tm40Gh7o2sB89/V5+4DkPUlWC92C/EXAJelAqI+o=; b=D
 2t8lPVbzpuwCmDppArOQheCA50XFsMaKDk83eURTI1I+C/denChJ8yhd/yjc6E3pu8MPqgrruKxlQ
 E9e4uPCJNp2hs/H+F8/0t5jQN/Fkuk2/U01jFnOwb7gMFI1+XH5juRZESp9AOjRAY2e1pLvUcc665
 Q15Wx7hBeWIvzImc=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIS8z-0006ZT-0d for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:45:49 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso14657015e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 18 Oct 2026 07:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792334742; x=1792939542; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4T8Tm40Gh7o2sB89/V5+4DkPUlWC92C/EXAJelAqI+o=;
 b=M1TjvK0//3qXjg+xwT8X5K/NdYdSd8PlnE6G/1tpqQrMN39WhaOwU1D0c7pdGFX1gn
 Vp/pBYqaQTOZIT+T/O+3mlSR4bD2ptIZBrXhvYZj82woaHIzg1r8ucEzSlwt1T24tWbQ
 J164kYvCRYy+EAm9TyabU7R9nThU+0Jll9vbRCeGHzR75buwqXA/DtnqVzZXEF5mOlRe
 e6vBW6N3MOxyYp2OEVaoNA1WKnJC02r4VlQrXVHdxPxcHaEsPw7y5bbGXAkFWzcySrA/
 jMb3KO4I9fdnUAw7d8f+F1Ymt1zg88jCJVJMkdUCF09WNQNtWlBPe0IYXVEJgnZWnxiT
 inVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792334742; x=1792939542;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4T8Tm40Gh7o2sB89/V5+4DkPUlWC92C/EXAJelAqI+o=;
 b=QtFAjJp4Sido8lKgdiEi96RKJ/s/X7eDNE95fxb34HwrURl6kqqBN9GSEUwBVBzSOT
 Q6/7U7/Ho+KG0ohd5Vpl668npFagaJ/9W6vkKo8O86/fbdbTmi6a4Uazv7YLtP0TCQx8
 uM8uLQ9ohv7k4XVmJkVsJCMNsHNEnvmzhHLxzfb3C8DooLpvnEiZpN5j72DSAtXxpjl+
 S8o6U46d7AJkPhTlsrSAU63AhHIftoqsn52qt6+w6zY4jdA34Gq6pPo23l2zFRaxd+2D
 EKxp+eJUNsGW5P+8YY9mHAE8onAnpHRuW9kHsLcXjMskREPiJr7Exuf0pS4+43Dq6QX7
 8iuA==
X-Gm-Message-State: AFq9FYI6+sBxC0jxP9bBtv/wKyF6WNKaKFdsGVCnSrd/x3Y0Oqy/Lg83
 V0z9vSWb7NGiyqt/xXt1pAYmZWzR/BHleh1nVQEr7MsqmDANniLjhW/CmqObM45SekXfVkkU/7r
 i61OBWe43bEMI7VE4QsaEgQ1siEQvS5NivePOdcHp5xa1NMBqIztoiG/NCrTNVr7R0x+VYXDcCj
 9flA4krQ==
X-Gm-Gg: AYBFou1oSyhRP3NreLzPliNGmOx5EQnfLuG2QtdhUHqx1fLjxKc3ai3eVpj0b8SuiCj
 JUp0t4mNauVocEZWlKneo3Zb89NXY9E4tHbDRUXxgqLl0wyayG4WorW3YiouQQdsSLAhb6RZLjh
 PcnPgxE/Uxg+9lsreFAVEHsR99zFBhBCLi4yu2K+j5nxDrw2RD8Kq+i6i3/3stzSqHovLHAOepr
 dA2uYoU6yPciFt/yNfHdnscydWbGcG/Os6RWc1/tolyfdPfhfB4UJHpTHi+57Xla50ITvUXWLBY
 a3U8TuJdAR9EVOIlbPBIJa+UuwPBtZPvVXBbKNkmqiOvV1VCrWwng0boTrhBQCo/z4S2b7Yhrjg
 PT/bawTunZtazFzBhUAr5UR972y2UfISPy0QB94MXDpi9DXB3t3SWwVdJEJuFWFVJALpx41AM+E
 Ed4LAJ3xspV4Zpc3t1euOgh53nlyndzVDB5JwPNIxo0kpYcPUnDP73pw32PqmUZqdCEUQZswEb7
 j+zGIGCWE4q7Mt6HiQggBZbEyG6rNd0+XtpmyvAUP8pcJ921PQRHLVNZL94TWDuhsqYvjK4WW2F
 CaVZi5ppLa0xDNTPVzLxRiJIyxxKRgkbydBOUIoPcO1JFt9P4U8H0g4EmTIf5Q==
X-Received: by 2002:a05:600c:c8d:b0:49e:63cc:6324 with SMTP id
 5b1f17b1804b1-4a1d75f2bacmr120598155e9.6.1792334742331; 
 Sun, 18 Oct 2026 07:45:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8ae6d2esm205785075e9.6.2026.10.18.07.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 07:45:42 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 18 Oct 2026 14:45:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
X-Gerrit-Change-Number: 2014
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2014?usp=email>
X-Gerrit-Commit: 262d36962c98a8ba3e5b6f4029bd9a21dca7389b
X-Gerrit-Comment-Date: Sun, 18 Oct 2026 14:45:40 +0000
In-Reply-To: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
References: <gerrit.1792325770000.I10ebb5821829bf738e58fec23f9f9dd65d4626d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMzI1NzcwMDAwLkkxMGViYjU4MjE4MjliZjczOGU1OGZlYzIzZjlmOWRkNjVkNDYyNmQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <71e4ff4ee8f08143d18a0cf594b5cf8001b19dab-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIS8z-0006ZT-0d
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix cppcheck
 warnings on macOS
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 gert@greenie.muc.de
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2056150831335407590=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2056150831335407590==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PsYpast2Nt4="; charset=UTF-8

--PsYpast2Nt4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gert Doering=2E

Arne Schwabe has pos=
ted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2014?usp=3Demail )

Change subject: Fix cppcheck warning=
s on macOS
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2:

(1 comment)

File src/openvpn/route=2Ec:

https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2014/comment/24eecc4e_7f0a9ddd?usp=3Demail :
PS1, L=
ine 3354:     bzero(&rtm, sizeof(struct rt_msghdr));
> =2E=2E=2E but i do n=
ot insist on that=2E=2E=2E
Done



-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2014?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3
Gerrit-Change-Numb=
er: 2014
Gerrit-PatchSet: 2
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Sun, 18 Oct 202=
6 14:45:40 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-R=
eply-To: Gert Doering <gert@greenie=2Emuc=2Ede>

--PsYpast2Nt4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gert Doering=2E </p>
<p>Arne Schwabe has posted comme=
nts on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2014?usp=3Demail">View Change</a></p><p>1 comment:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/route=2Ec:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014/c=
omment/24eecc4e_7f0a9ddd?usp=3Demail">Patch Set #1, Line 3354:</a> <code st=
yle=3D"font-family:monospace,monospace">    bzero(&amp;rtm, sizeof(struct r=
t_msghdr));</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">=2E=2E=2E but i do not insist on that=2E=
=2E=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=3Demail">change 2=
014</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2014?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I10ebb5821829bf738e58fec23f9f9dd65d4626d3 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2014 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Sun, 18 Oct 2026 14:45:40 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Re=
ply-To: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--PsYpast2Nt4=--


--===============2056150831335407590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2056150831335407590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2056150831335407590==--

