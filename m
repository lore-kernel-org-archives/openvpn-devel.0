Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F94CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6w/11UugtH3Gh583/0+L576bzahfMsTeLMkLaBpjmIQ=; b=nTwhvXYy2nZTyTb167l1XijyqZ
	zvgGtikLzLE9n5wB8Ahg8Zlaz3kDUr88VnOIdzcScfPiWJKn+lw+QHECsf1YSZfnnoVohewSLcx7P
	VvLqG2qKha7srHl0lytuqyL76uT2BRvtOem2hLi8La8UmzceWLJe/2xSHuy9mJJSS2Iw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIA75-0004fb-RG;
	Sat, 17 Oct 2026 19:30:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIA75-0004fV-6d
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:30:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3twt+t/RM7CKJ4AebdN5rlCByDRUi1T5MZDWWwGHwiU=; b=T1w3bS7CQHMnFXEg96UyPbql91
 eaMDBgTa78LtHna6TdXvWTVbaprj4AclZQlFYbClQUMMx2YZlhcxtpmEu30hK2EsUk6sx+DkuqdS1
 AqibHKMQ6XZ74w23lT0ppqcDzcNrcphbDttLBkPd6vKUr79wRJ1ozCDlpgT5dCsXE13s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3twt+t/RM7CKJ4AebdN5rlCByDRUi1T5MZDWWwGHwiU=; b=k
 LCdnC8pspWxpKoxNzdDk2tTAKu68Snz1rzuikwE2HR0OhH5HhueT611hkzQbkDRB80BrKHR5kooyn
 +0Aqkf2HBK+qn4v65h4poB+Eyf2cg+5x/XLZy5AN6ZzJjQ86aVXKtukxyQG+bUSLbd9Yn4wDL0j93
 A1J6w7Y5+F4XbN/8=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIA75-00024l-An for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 19:30:39 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48c5358fc28so678180f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 12:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792265433; x=1792870233; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3twt+t/RM7CKJ4AebdN5rlCByDRUi1T5MZDWWwGHwiU=;
 b=Sk/KGJjz76t4ciH7Dm+yrceof7JDrfHQaTGVjJgGSXf1t9nk+jfnTPqq4LxQr2Jcpv
 9ZfLclJU7NJJzS1xxqAboPzgYIidiLOGJENLTLur60m3fBvRnpc+80RFPf2vzxUOdvzv
 L+jZCpaiaaq9Ov3mKthCtYaUR7Zh3ArA1FeQq1tchEm97e/LL84yBL7Bczf8uJIZeHTp
 b9C2aeKyk8W40HMviGmcnC9IMUtf0RHs7YDL1NMS8myu8UX2bzG5oDlwSIdk/BMy31BG
 yDHlxb0/1PHtb3nKQ1MhIvlbwNc8Y2We2DRzdqupbYmqNRuyMKJUn6Ezy1hdpvGi+mYf
 nw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792265433; x=1792870233;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3twt+t/RM7CKJ4AebdN5rlCByDRUi1T5MZDWWwGHwiU=;
 b=0vgyUbyMvLCxD+OBrflJP/dgvsnxcGi1yNYVBbrZ3fyPNM43/BvWI/P80XRDPHILIV
 s+iprBBZ2S0BEr0azsgFJUajV0YTHcRhKZoKSUzpQbgAxLxS7ECFxuIKTuCHIf2SFA86
 1+aklkdi1TU3k8HCz4Kl0o3xyb7k0jyJFcVHCzUMTQIik6cVEY9pgEYi/l0Gh4S5oh17
 9oYyGudposTsvwrnhFmMV1+BDkoe2S2HjrRQqzlFGVNwcWhWEcpP0y6RrcHbUtxppEmS
 2GEDpR3w9697x2Z+66UVlKe1GVoiv/b5YdtK9UWInGapspcYC5qS9oJbZ0VFoEEYn2HR
 yObA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcE5lOdDFFGnRa7P+vdmhWoYLpohX7K6tjYHZXnUvRwCzmssK2+q3UoLIuUiqaZwZkZnjFpX/jQjL8AOAh@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLhIfEO1euEGm1I1TVPsRfGh2+qEOvcRB6v0gGeyTYdkqrCDAkf
 bA7PmpX/cg0XWm5DF57clvuIZP/++ms9CccLqsYhT3QmQz20VOyfdkCx0Dkuq9E3Oyxe2jxmb0/
 5zZVzu4j1TmGhAK+nNnP0aHi0qaWus7vgYfkrWC2yIZ0Q3KnflzQpEjvUbqWDto0QyiPb
X-Gm-Gg: AYBFou3O7mRFECaEpTSODQ6zP+qXK0nxtIpNxWfEKkMI0WLXKcPYI25dA+sGK0rHEtQ
 oa63JTC/eSIk8izh2tHlqOeCqcy6ZewkgPbjQLdCb8ZBIuvrLRYHANrLpj+gytJDaMv+LdVQSAz
 jzatmuLvta9rvA2HGRkiQuzFb+8pZSMcrTZ7mlCLiCbNPOVL1HFkQVVQask1RHjWBBOVfOrgTRz
 wlfSPEHgVQwbd62re/aVUJlGPZlEY7fvNYQk9jjQein+9f+98sV3GdapV3PNUHC7J/Xk2XK05Ea
 1s2nS5Dp7mwCWpkgIwbRN8XHAdjRb0xDc1/qk9o3CjeoBx7gCu9E39VGwt+lYvzgI6fBPol1914
 vDpJPp1ygqGOPbE3Ib/F0OuxSvjNQNRuOeEbM3zstngoHBopYuD9AXgUxwnCd5odoIbnoY/TS5i
 3mxuAVpG1Zmc6rh8iJN9RRpAKF8Br2JNc5a0iwFddC6HlKjxwqtI/2gyiRN5/CFMTUUEuUfOKR6
 BueyypANW2hLUP+908DTRF2Li4yIMnxbe4oKSFD7k21MMrA1acZidZ9ZVvonjRd5145FVcGj9Pm
 dL5q+tQxmJZNf3Bcyilr/ZrGDKNulqe34nv3lw+jeych4jrRD958l4D3q/Gh
X-Received: by 2002:a05:6000:26cd:b0:48d:facb:5937 with SMTP id
 ffacd0b85a97d-48e079888d1mr5173331f8f.7.1792265432644; 
 Sat, 17 Oct 2026 12:30:32 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5957sm12444596f8f.9.2026.10.17.12.30.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 12:30:32 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 19:30:31 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4
X-Gerrit-Change-Number: 2003
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2003?usp=email>
X-Gerrit-Commit: 38bdb3b3a99bb3a0322a7812c9422543a4200759
X-Gerrit-Comment-Date: Sat, 17 Oct 2026 19:30:31 +0000
In-Reply-To: <gerrit.1792255622000.Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4@gerrit.openvpn.net>
References: <gerrit.1792255622000.Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMjU1NjIyMDAwLklhNTdjNTM5ZWRlNzNjYTRkMGZlMDhiN2IwM2Y4YmY4NjUyYjg5Y2E0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f234a38956a22395aa6164badebc225dba712021-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIA75-00024l-An
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 crypto_mbedtls_legacy: Sync code with crypto_mbedtls to remove warnings
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9035748718616161606=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============9035748718616161606==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lImU08sDSC0="; charset=UTF-8

--lImU08sDSC0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2003?usp=3Demail )

Change=
 subject: crypto_mbedtls_legacy: Sync code with crypto_mbedtls to remove wa=
rnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 1: Code-Review+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2003?usp=3Demail
To unsubscribe, or for help writing mail filt=
ers, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mess=
ageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chang=
e-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4
Gerrit-Change-Number: 2003
=
Gerrit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <o=
penvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Comment-Date: Sat, 17 Oct 2026 19:30:31 +0000
Gerrit-Has=
Comments: No
Gerrit-Has-Labels: Yes

--lImU08sDSC0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2003?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2003?usp=
=3Demail">change 2003</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2003?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ia57c539ede73ca4d0fe08b7b03f8bf8652b89ca4 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2003 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Sat, 17 Oct 2026 19:30:31 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--lImU08sDSC0=--


--===============9035748718616161606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9035748718616161606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9035748718616161606==--

