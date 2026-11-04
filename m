Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E75E60A260B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aS8uPRja;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RL6fRtJF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=LZgHXJkJ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fa/VcpCA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=7G3aH0RBl4UdxlB7UU53kzGRlc5JqeiIM6lEkUNdYcE=; b=aS8uPRjala8mjAbs6zS+IsQAjH
	WGLAuYZQPrX/xjZMiNMrQwdOqFNmPvHY5HDhF/WiP/rxT6JP70GEaEb6GXV/ZTydEwl2CEAIsb5FC
	niCrRJvFnyQ7SV3pirKPsQ5UVOEbWus7a366qRIf0a/J5VD376BdA68wnAP/9+ZzxgDk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeCA-000000004QE-18at;
	Wed, 04 Nov 2026 16:50:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOeBp-000000004Pt-1tPF
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:50:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AfRcyKQZxcAB1yW3MtMzVK+TfTm3cTGgHBhI7Itrrx4=; b=RL6fRtJFDNnGqXg8UCSC1PhBqg
 8siJWQjppPgd8b8LU4gS2uUjf7OqjvWrqoMWumiSiGVcycGpx1g4l0FDDcXZz5d3xGEyhLuU9prr6
 967fOpWuAEnPe8DvgwLdYOIqqB3ShFLYCTvtdsQGhdOKSaXXM5Ed5y1406NP3Ig9Apfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AfRcyKQZxcAB1yW3MtMzVK+TfTm3cTGgHBhI7Itrrx4=; b=LZgHXJkJj4vGcSrgEKoY6CQroF
 OS8AYzj7Flf1wKbowK+0U8bB21fcItNYZMDmS65cqHO3WruexdZ97UGFec9siNvQpmMKVbtPd/cID
 QJhoYXYosMpLB/asr5rKqszXY9g6UY7z1f0Q674asb0Kw5ASvcEH5n7o1rr3xi+roHJY=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOeBg-000000001Ck-1r6Z for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:50:13 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so6108775e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793811006; x=1794415806; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AfRcyKQZxcAB1yW3MtMzVK+TfTm3cTGgHBhI7Itrrx4=;
 b=fa/VcpCAgv9pAkSBZRvv56tk2qvdB4fkFd5MIPOVlKkkJwrROZ9FaGT4XltMe1BY/J
 1oZ88Y9ZHd9TI9DVjkQo1Je0kL3Do1y3crnAkCvyUKVEG82Gye4W77kheQGKfC4ofVKr
 AhxupPawMJEMl63+S/94ZwiyzezLy7hch98nB53/tm1NIZa+nHbqTKNHuv2ft/KX3KQn
 QzhSVYY6DPdj53YjTe9a9scj+ZrfWqD6Zr5sn8KBKo7ac9zHTTCUv/dwC805PRHvn/fH
 nT1tMZ8psh84PzAJpndavuZ2NObyd4s2zc1sTdVhUgEyuzJC7jFChJLWtGIePVPfsTgF
 7xqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793811006; x=1794415806;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AfRcyKQZxcAB1yW3MtMzVK+TfTm3cTGgHBhI7Itrrx4=;
 b=FBJozzSIErcdLkUxvYIHgZtBGfMmTNbjCTfi65eQ5yeiipU1I83o9xbY5VY5UG384/
 4+KGWwRImZM8Pg1bkwZPEjOM7hFtEb5rMgpS1p5cRpfG37Gy2Gho50eVzX6ycA3m/eP3
 bpf4oK7k56HYHQodRya/2cVvQPMGI4Wiy+bY+WSKZZqPMXqq0ZxrGYfe2OpVyIjS89E7
 ahfKfZm9yLkIk+Euc6xr3wCd+Mkfl2Kio2iQMp+lIdPx/QaG7x2uOlaOedvf28v717pR
 hF1qM4zxBTkdn8sCDGCHCDu0ZpuIOTCnnHF1HK8CfGViERNhZUFpDqVpiD2w0CBRXxZA
 sTDA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwtHfQA+oxYorO3f4jUuiXCKAUWyPz5audVbzpsxHSefHActpyV2NAYl0a84VDkBR2dsQBiHAWUUkMQUC+l@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/Ya/WpVqCau9rwfBQT7x9A+tx16ZGwIDedJTeEubb/Ka9/0Tru
 dXJsj5zxJFnAnmLTpFg0SbEAQLZANdHNsHuIIn/bcJJcStxzdgwmxEno6Z7NBLDiHMjXIL22OCt
 GMt5jTbG05mCvVPcTrBoppQtKnzuJEUqD1q39kAXxT/jaq7W3MTppCZ3eccPEccxQPKNl
X-Gm-Gg: AYBFou3KrbIgBgHsniOBH8oadp+vwZjbaDDTsKxZUugLzJ/4XYaEQ0EnwPHEacSk+Dh
 M0XiAxfxvxybUj8oYIo7N7ipmWfnYGrfgCxUwtZDjeKHjt0rgYV+coLhncATA1uE8jMJRQsNfd7
 h5azjsACMjWnFCD8RjfFYdxDv/jbcxBGEYcaCVcnB3cqTmJEoMfnD0fHZcSgXGUh+ksoXccNpXc
 Ofd9xfBkcmEEPx0xTI/+zKHvAWjOr4JyxQ8ITmNWJMYSw+QXVoPGWtePi6EAyoIB2lfLK7QSMvh
 dSrskYGxR39g7azujpy/wDyB4gxRFa7zfCu78cmffrx8XzUyDk5JuwniqYAbGc2VZv9JUc1CVtS
 eyR5Fm3QP73qbWUDBTapMVfrAMc3e+aRra3/mNhNUt8dwuyrI0fvEBdeI418HP9lueVBEre4Yta
 GGnyH5kQsa/2yAB6cQtHoMO4FiuokFiy04WkRPwaVB15PF9lawHf6SEwdxysbLtDocZj2o9RXls
 HLGCtW8r67WxObaBk84KFC03B07CoL3NvFGUd2bNRqaT2bLBgOWhBQ67dGG7BavKq9lXn8+Xbdd
 AtZPIi6RRCNgLnB+ZbTxLJO670VUzTtCJNwZd/YDTCfCuVDazlK4XfAVqByEF8r/tSUWQWKRvc7
 nmm43HNmUq/BdWN52IK0gKwfC+xxKAEq8R4ienmqtgOIi2QfERxFl49FBG7zMK3HLmdHZvCVo2A
 QM4KcMevfA1goK+A==
X-Received: by 2002:a05:600c:c4b8:b0:4a0:1b14:e283 with SMTP id
 5b1f17b1804b1-4ac150b38dbmr391785215e9.1.1793811005609; 
 Wed, 04 Nov 2026 08:50:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b43c17ed95sm63932645e9.4.2026.11.04.08.50.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:50:04 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:50:04 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0
X-Gerrit-Change-Number: 2128
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2128?usp=email>
X-Gerrit-Commit: 21efe909a89fd6eb13b04849505301312a22c35a
In-Reply-To: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
References: <gerrit.1793782065000.I5542520825112dfd64aab332bd76333b74d7fec0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzgyMDY1MDAwLkk1NTQyNTIwODI1MTEyZGZkNjRhYWIzMzJiZDc2MzMzYjc0ZDdmZWMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fbe67afd2ea7340ce6e50ba3059e2479483be874-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOeBg-000000001Ck-1r6Z
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: don't
 return freed token groups from GetTokenGroups()
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
Content-Type: multipart/mixed; boundary="===============5537399389633956450=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5537399389633956450==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r6hijmNxm2s="; charset=UTF-8

--r6hijmNxm2s=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2128?usp=3Demail )

Change subject: openvpnserv: don't return f=
reed token groups from GetTokenGroups()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: don't return freed token groups f=
rom GetTokenGroups()

When the second GetTokenInformation() call failed, th=
e freed buffer was
returned=2E IsUserInGroup() then read it and IsAuthorize=
dUser() freed it
again=2E Return NULL, which IsUserInGroup() already handle=
s by skipping
the token group check=2E

Broken since e82733a1 ("Fix user's =
group membership check in
interactive service to work with domains")=2E

Ch=
ange-Id: I5542520825112dfd64aab332bd76333b74d7fec0
Signed-off-by: Razvan Co=
jocaru <razvanc@mailbox=2Eorg>
Acked-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128
Message-=
Id: <20261104105737=2E7333-1-gert@greenie=2Emuc=2Ede>
URL: https://lore=2Ek=
ernel=2Eorg/openvpn-devel/20261104105737=2E7333-1-gert@greenie=2Emuc=2Ede
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/=
validate=2Ec
1 file changed, 1 insertion(+), 0 deletions(-)




diff --git =
a/src/openvpnserv/validate=2Ec b/src/openvpnserv/validate=2Ec
index 6a13a06=
=2E=2E2858f62 100644
--- a/src/openvpnserv/validate=2Ec
+++ b/src/openvpnse=
rv/validate=2Ec
@@ -227,6 +227,7 @@
     {
         MsgToEventLog(M_SYSERR,=
 L"GetTokenInformation");
         free(groups);
+        groups =3D NULL;
=
     }
     return groups;
 }

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2128?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-=
Change-Id: I5542520825112dfd64aab332bd76333b74d7fec0
Gerrit-Change-Number: =
2128
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>

--r6hijmNxm2s=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2128?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">openvpnserv: don&#39;t return free=
d token groups from GetTokenGroups()<br><br>When the second GetTokenInforma=
tion() call failed, the freed buffer was<br>returned=2E IsUserInGroup() the=
n read it and IsAuthorizedUser() freed it<br>again=2E Return NULL, which Is=
UserInGroup() already handles by skipping<br>the token group check=2E<br><b=
r>Broken since e82733a1 (&quot;Fix user&#39;s group membership check in<br>=
interactive service to work with domains&quot;)=2E<br><br>Change-Id: I55425=
20825112dfd64aab332bd76333b74d7fec0<br>Signed-off-by: Razvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=
=2Ede&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2128<br=
>Message-Id: &lt;20261104105737=2E7333-1-gert@greenie=2Emuc=2Ede&gt;<br>URL=
: https://lore=2Ekernel=2Eorg/openvpn-devel/20261104105737=2E7333-1-gert@gr=
eenie=2Emuc=2Ede<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede=
&gt;<br>---<br>M src/openvpnserv/validate=2Ec<br>1 file changed, 1 insertio=
n(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/validate=
=2Ec b/src/openvpnserv/validate=2Ec</span><br><span>index 6a13a06=2E=2E2858=
f62 100644</span><br><span>--- a/src/openvpnserv/validate=2Ec</span><br><sp=
an>+++ b/src/openvpnserv/validate=2Ec</span><br><span>@@ -227,6 +227,7 @@</=
span><br><span>     {</span><br><span>         MsgToEventLog(M_SYSERR, L&qu=
ot;GetTokenInformation&quot;);</span><br><span>         free(groups);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        groups =3D NULL;<=
/span><br><span>     }</span><br><span>     return groups;</span><br><span>=
 }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2128?usp=3Demail">change 2128</a>=2E To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http:/=
/schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2128?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-M=
essageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I5542520825112dfd64aab332bd76333b7=
4d7fec0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2128 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arn=
e-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--r6hijmNxm2s=--


--===============5537399389633956450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5537399389633956450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5537399389633956450==--

