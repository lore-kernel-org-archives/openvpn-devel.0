Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7442060A261C
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XBA+MFVS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wi7mCzGY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DvOzHulo;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fPnmMzxs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ub+o0SRreiGgqNJEFFG6lZrioXU6qJzz+UTjdXoGxeQ=; b=XBA+MFVSgxA/WKoSiDdQUiVb8d
	P/Ri+HCTdym6iNPYUkuPbpnpZ+UGEySYJDgRWNKbx13mMNeuKgir0uGOvD61ho0uHap3QYbjCMl8f
	HKmZwedjMBLADQ4XHuE7IGHMGVVd3qWP6jPLxLbXFxndN5FCeDstgSuVE+L3rNT8Fzc8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU4wd-000000007ro-0ICu;
	Thu, 19 Nov 2026 16:25:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU4wb-000000007rh-2cDX
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:25:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y5uu6/5OpqRYuH2LmOtzVpFly7odJVC5yWhbPlBzPhs=; b=Wi7mCzGYVSyLO1//CG/n7pe0VC
 nYH8CMmNYNsbsvUKcIDAVPc4u6rlo8T92DEyVDaebM01hDhxInOi5hmGGWrG9yqhqejk7UEh1hjv4
 coNoIwawSH4xPWnK1zm0Bj+xwE5grg9ALuxOxJ1ThcwcmsQSFzhC2JGzlfIaWc5rHjz0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y5uu6/5OpqRYuH2LmOtzVpFly7odJVC5yWhbPlBzPhs=; b=DvOzHulo5Lj6WX7SCca+v185nL
 t35iGZelZuyR+axeojKT9vT8fT8S22f0gt59OSzPt9K3CfTlOz7lSTD2o6SYb6d/NMtrB+RUHBqKB
 a31+U3dz0Fic2TiQdHxjtOQkY56QmLpSRwhg2yYJOwugrAXCRB4NOU5iaWXf+80z0xvo=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU4wZ-00000000679-3gWb for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:25:05 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c50a4a2132cso342833266b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795105497; x=1795710297; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y5uu6/5OpqRYuH2LmOtzVpFly7odJVC5yWhbPlBzPhs=;
 b=fPnmMzxs0j2bUotxHnwQRkUo8ip46adkJsPpHQYPCSIAwrLDR3cTspuMpu5LFYJKTq
 00N3rhpOt1N/aRp/4op50fKqZFrh7ta9dWyLOcKiFaakDnpfBDkqakgT8h3VrBw6384X
 s2Mas+N+sOZtpJVcdsaCm1J0Sxf+KcHRhw1/WYmJVcEF5W4ciP7QLkkJa842T5H/a8QP
 CJaAPD41kf6ypOVU8GxLzK5sBtrc5nEsfZgJQZwvcQN0MT0QBbuoCVMXlZ/pPTGMxA6f
 /zL8jHvqOV7Keagch6cRIx5DbWTRFXhPaKSYLS7KnX4nuf1E4G5zJgL2FaeImqfhGLCm
 Bgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795105497; x=1795710297;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y5uu6/5OpqRYuH2LmOtzVpFly7odJVC5yWhbPlBzPhs=;
 b=Xt7PvYl2fILANOPSX/m0GIN6v7JdmoAp7BfMbYm1JF6xspWFdIOcZRSrRUL2sG6YKP
 CZQTzeMNQTe5KOtQ58WlowYh5MFsU/T47qzyQGvwkpsFwYqHCQNxMDFn15EDBJeswBac
 kPNKsMCGx6I4XVjahicTfo8JQjqFE56XTuAlsOW19dHnUPDo2/YnLo8Tl4KzVz1MtnKX
 avdC/f5PwslYNGA/VAO2h9IstgjgyPFJ+NjJcgSv0o4lNFZ2TTIEGFjn+n8FTU1s3UY6
 LjiFmmyuy+Gc67Q3+nPGR4pXgfFn7RYb6mOpFpNNtonmUid2TSwapS1kJP3Cf+VDj11T
 563Q==
X-Forwarded-Encrypted: i=1;
 AL+hErH8gasurBZbfNOscsC/ZLDK0TB/8DOs33ZYNHsq/pft0pNg1vYEtozNIxTs4tFQzXtkSUfgNO9BsQH2Xkvx@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8+UCt19OZq9cnGH68goRtGZgP6Li/JgCTUU/eBMzhpRVGW2yXy
 /9tgO3unsJcVUHIGZzGii7JDlzJwhFFqEoDb+R6kZxnuMhipQahFHpQ1ta5cdSESTQd7FBO7K/n
 4NIEyk3oUG34TRnU2TomHG3UkF56XTBIqGpMGItmP3TkU/z9BU3mVxNrn9XOjb/LC/gu3c5m8cL
 5GVflKeA==
X-Gm-Gg: AYBFou09jHAQGA3ovUVfv0yhR6Y8lqRS7G+Kx3x5P/RQc7UAdYTrkQAOzFAnbP7GIGU
 TiDiqPGW6t30Lx2cDUeQBgiGSbEw/yBM/3Fpw+CeP1TUqw+O4hT2r8lV9nwzOG+bRCfh5tUIUFW
 vhANnwltkeAx3xqS2fWe/0yN7cEuH7ALdPui+h2UjEgIACyFh8UYJUUqqpN9px+ZS3h2zyTrCXS
 C7KzS5T1AwnvZj5POmz9GtBbB0yU0ipKc/lEbDTtb/FfOWFxDEelDnoVMNWc1D4I8Ml9+3O3O3E
 FEzJORYtnqFQMCmDJIV4C3LmDCY+Io3BpmAmWs9X6vlLebwbr8J8vRvC7O8Vx3Kq2d25p2I/y26
 cHAPcs8MOeyiV2SC2V4yWmFmTNMXLPPknWdcQtYRV9orGZOjJ+cP7HQSSVIgWyQ9jEyncpj88lY
 X7b5Qvw3DuntfXuh04t2YmbbUj+Pn6oNOc4w5ymoLifZPaTQy26Ei9ZhitFalF3eHG9109G4w40
 iMSw82mrT83RH/wh98HcrllNY9NpvWvaei8QySh68jcX13eBXssZ2u5KZ+sicUGYqYz8ejMlHZH
 7Z1bHc1BqYOLUyMl66TF4zq889q45CB3kfDLynnpi9u4r/t+UyMs4uZwXrmg9u4E0YPOFYeInRH
 vtfm3cv2qyk1Ee1wZRcj0ZElRv0nk9Ux3FCHYTnlp2fhenx4RJaBekuJU9X0pf/c06BWdjki6oX
 VnzroQvaCYofkhiZ0=
X-Received: by 2002:a17:906:b296:b0:c40:4965:72c3 with SMTP id
 a640c23a62f3a-c513aac36eemr32015966b.19.1795105496883; 
 Thu, 19 Nov 2026 08:24:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb98b4dsm498958f8f.53.2026.11.19.08.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:24:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 16:24:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd784153367e4fd
X-Gerrit-Change-Number: 2209
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2209?usp=email>
X-Gerrit-Commit: 36f8ddaeb2cd952fb137a9322d5340b47799c9ea
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 16:24:54 +0000
In-Reply-To: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
References: <gerrit.1794916544000.I3630ac3defbb64e252ac3009fdd784153367e4fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTE2NTQ0MDAwLkkzNjMwYWMzZGVmYmI2NGUyNTJhYzMwMDlmZGQ3ODQxNTMzNjdlNGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <946ea66f4773c9193407ac9b37de4aca72538e13-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xU4wZ-00000000679-3gWb
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dhcp: locate the UDP
 header via the IP header length
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6287658178056614882=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6287658178056614882==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2UrbExHUXr8="; charset=UTF-8

--2UrbExHUXr8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov=2E

R=C4=83zvan Cojocaru has posted comments on this change by R=
=C4=83zvan Cojocaru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?us=
p=3Demail )

Change subject: dhcp: locate the UDP header via the IP header =
length
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 2: Code-Review+2

(1 comment)

File src/openvpn/dhcp=2Ec:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2209/comment/8cdffd0b_3242ad50?usp=3Demai=
l :
PS1, Line 166:     if ((ntohs(ip->frag_off) & (OPENVPN_IP_MF | OPENVPN_=
IP_OFFMASK))
> I would split this IF for the readability - it now has 3 unr=
elated rejection reasons=2E How about: [=E2=80=A6]
Done



-- 
To view, vis=
it https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail
To unsubscri=
be, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
G=
errit-Branch: master
Gerrit-Change-Id: I3630ac3defbb64e252ac3009fdd78415336=
7e4fd
Gerrit-Change-Number: 2209
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-ope=
nvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
G=
errit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Lev Stipakov <lstipakov@=
gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-=
Date: Thu, 19 Nov 2026 16:24:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: Yes
Comment-In-Reply-To: Lev Stipakov <lstipakov@gmail=2Ecom>

--2UrbExHUXr8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov=2E </p>=

<p>R=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan =
Cojocaru=2E</p><p>Patch set 2:<span style=3D"border-radius: 3px; display: i=
nline-block; margin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-R=
eview +2</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2209?usp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-st=
yle: none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/dhcp=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209/comment/8cdffd0b_3242ad=
50?usp=3Demail">Patch Set #1, Line 166:</a> <code style=3D"font-family:mono=
space,monospace">    if ((ntohs(ip-&gt;frag_off) &amp; (OPENVPN_IP_MF | OPE=
NVPN_IP_OFFMASK))</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">I would split this IF for the reada=
bility - it now has 3 unrelated rejection reasons=2E How about: [=E2=80=A6]=
</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demail">change 2209</a=
>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div i=
temscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2209?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div sty=
le=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displ=
ay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerri=
t-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I363=
0ac3defbb64e252ac3009fdd784153367e4fd </div>
<div style=3D"display:none"> G=
errit-Change-Number: 2209 </div>
<div style=3D"display:none"> Gerrit-PatchS=
et: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Lev Stipakov &lt;lstipakov@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Lev Sti=
pakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: T=
hu, 19 Nov 2026 16:24:54 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes =
</div>
<div style=3D"display:none"> Comment-In-Reply-To: Lev Stipakov &lt;l=
stipakov@gmail=2Ecom&gt; </div>

</body></html>
--2UrbExHUXr8=--


--===============6287658178056614882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6287658178056614882==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6287658178056614882==--

