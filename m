Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E082ECA9ED0
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 16:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RMM2hTMewmRK0GKtYAYjXs5pWJS8zl7iXKqyL1Xow/A=; b=eEPZbOVWhSdjaZa1I/7ZP6k8qw
	fQBXjuSASlP+cIWAzummxIHAPzpOF2smvNnkGu4qafJFwcbWyv8ZlNjN5eTRsV3VhjhWOAL/gJ2Dv
	ls1P0koD/yfV9kEmYZBXOZ933/Zfd68F4KVQ5nfMjacboqzj6w6fs5dt5bSGhMqwXw20=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGJ3t-0000Gy-4B;
	Mon, 12 Oct 2026 16:39:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGJ3s-0000Gp-9o
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 16:39:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1FiQVVTG2VMls7rr69NTIZvKD2XtHlslvOvEgxA3JFc=; b=TD4hOia03igJl62jsWdjtu7kLv
 pU6sNl0WOk6UgK2eNmSNaS5Y2ntDjIEQYOcphIhRsDzD93CrJeaqOVOX8vrheEKXn85WW/EMgsHpN
 ja479ChjDWOC5nMcqBldEJ9cpTv8Lv092xDZwV/xynH06DsQQM5QIxKxPl8QsgXlhyCw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1FiQVVTG2VMls7rr69NTIZvKD2XtHlslvOvEgxA3JFc=; b=U
 /JC4SNbC+0NhjSN+qZ81CpYGRMu0nuEAj5RPdTsyicrsaaAPG6dMpnnhkA+2avRPK3QJS5nGEDEOk
 BtUyIxaYbWIa9FhBArZgEreoSYXQMd8+nXRUhCcTVL8g0th7zi/nIt5hHkagMLhm3hNhzS1doMP55
 xJHQrXNLjJOjydBI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGJ3m-0006yn-EJ for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 16:39:37 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49fbb2acc90so16584535e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 09:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791823168; x=1792427968; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1FiQVVTG2VMls7rr69NTIZvKD2XtHlslvOvEgxA3JFc=;
 b=GaqvWlNZN/YeqrAlZkQ21koXGiYsM4yltaStFiWvo4w21Jc3n6mOvrNHmgvQRnF/yz
 M6v/jcGPk+Q6YW+jm2fANFexEWW89h4EtJdTs0AhqKtfj2k+fBOh+igHsaYkR+rxoVNX
 QACF8lB1EBkq/mKMTh3yM43E788PBPW0GMlPbg4tiLQhdVxVMin4lYQa4+56N3F6WA9u
 4s5ubf45oDacNkLSTdqZaIlJh7gwYnjnItPxGQSU9NR6mRNdPWUTPXb416VLmHZQP4ge
 2jDkNG2hdAGpSN8TmoLwygZsgkN3rjuZohWaam2uIL2fi2BF4NiZ6mXxyNBKrTUi/0N2
 piVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791823168; x=1792427968;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1FiQVVTG2VMls7rr69NTIZvKD2XtHlslvOvEgxA3JFc=;
 b=i4YJ8tkY4oCc7tMs9qt2HSX6RUKUpd12NzeniMhGX+pJMnUd3s0Zzs/dOYq11wvOAW
 2Labw50bY/RaiCvTjkH8saLiupsowFtW/A61NmTqlPcX7VThnnBfEjdsEPDR1Ue/yGPS
 xS/fkS6b/56lZZCGME99cB+x48Tk27WkiCJia/TSRVMpp3s9YIX5jJnttL3d2Yn7wGRa
 4O952KAno4ItZeoY8QyFCgfv6CqSEMwG8QyuHfhE8mBhyG9PS9/cnW3pdOuQ3S0lG3ES
 1f5NWVPAL1vlkhPQ7oJkPcK86TrieXcJhylxfmWPFDo5kd3pyqgtjKozNfKFeDrB7i6i
 BURA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrKTcIYlFRGsUkILPAuoXlbunSIhsOAXeQhdPookc7i2wggyqu/YczkmeVT3DN9Vldh8fQ0SbM3D1gVNNO@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKIbo26bO/daBDPCrGN3wvaCKHGTw9P9Sa4rE/eGsyx61/4dRFF
 kgu8nABcKsAzOEimJi1LlsjwoIiQ9vqY+xpJfTs1DDO4I7qz8JROX+eBZuRsfDcOapXHkQzs6Rf
 DFPKWyg18N/nDlZJ7VRUHBWnXm8r9N8bQIrdKjkFW0YHlGhMPgat8gj/Ev7NGlzL5lrE0
X-Gm-Gg: AYBFou1kPYK03K+Z7CgHHDF9PsXsP3hrKA1sggXNJz1JvSzfdIIHW99oaS20xroRnRs
 6zCyi+0XQ3HxNxlqIGTVAeGCRxL4e1q5eetYskDPyQfY3+nE6WNJjuuN1Ru6G448aoXd3DhCBW2
 3PbxcyigUNxPfvNZ8eAKz1ILpqMHBlKNv2837zgzQTE7j6aorFP6GexA7x+8457gwcV5n0Njfl3
 MaUvQTND/DpA+zK6Yro6P8X6r0tFsrPD9L7tLxCGWPLRMKSPR34J1Li0xZvcKYEwECjqsPinp3K
 nRN8OfNNsKrhgfIEin1+2F0wEwHPDo6QRcqpO9JRNbNc1zeWf7AY5WkxeVW+pApUvTinba2OEHG
 Oa9eFAT5qpBJHixJQ/W3IM4Lgeq7yW1ARfqwl3TXIsc66OWBP4I8EMgnj3Dsf3RSktDWjgoTGpQ
 RlH/PCoyav3Y2k4joe1OsXG9TYNhKTJvwotKgOHdZmhBkol8RDN3C6Q75uVsEY5Bqu2HrFrKiWB
 4Bz2T8pC4paOzJmm61u9Kw0N8FlbGPSYofukj7ag+L1JfnOb13aEO6WqPjhiR56RqEzkpbErcvX
 iJ0LIbRyX01EKEa5v/coJYm2OKjQMo1yFNfBVdysA7N3fg0yJdfPsRIwtfWv
X-Received: by 2002:a05:600c:4ecd:b0:4a1:96cd:2f60 with SMTP id
 5b1f17b1804b1-4a19ecf4c20mr70187985e9.3.1791823167542; 
 Mon, 12 Oct 2026 09:39:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18e48db03sm421119185e9.3.2026.10.12.09.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:39:26 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 12 Oct 2026 16:39:23 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351
X-Gerrit-Change-Number: 1988
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1988?usp=email>
X-Gerrit-Commit: 5e1d4ee3901e2b599cd9d5fb7903f496bc50f7e9
X-Gerrit-Comment-Date: Mon, 12 Oct 2026 16:39:23 +0000
In-Reply-To: <gerrit.1791551948000.Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351@gerrit.openvpn.net>
References: <gerrit.1791551948000.Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxNTUxOTQ4MDAwLkljZjAwNGRkZGRiOWIzYTVmYmZhMGY0YzYxNzljMjdiYzFkMzA2MzUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b1de9a7fa029a2cfc8cb28b5758441e852f855f2-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGJ3m-0006yn-EJ
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.7]: Convert
 Changes.rst to Markdown (2.7)
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
Content-Type: multipart/mixed; boundary="===============4005923712040104393=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4005923712040104393==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+6EMifWVPVA="; charset=UTF-8

--+6EMifWVPVA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail )

Change=
 subject: Convert Changes=2Erst to Markdown (2=2E7)
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(2 co=
mments)

File Changes=2Emd:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
8/comment/fb9f28f6_924c69d4?usp=3Demail :
PS1, Line 185:    - fix by introd=
ucing route flags and restraining the check on them)
Might want to move `-`=
 on the line above so it doesn't become a sub-bullet point=2E


https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1988/comment/75b7dd40_f39a3b6d?usp=3Demail =
:
PS1, Line 272:   - this was off by 4, for connections openvpn 2=2E7+ to o=
penvpn 2=2E7+,
I think this will end up being a nested sub-bullet=2E This p=
robably needs the `-` to be moved at the end of the line above it=2E



-- =

To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail=

To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Proje=
ct: openvpn
Gerrit-Branch: release/2=2E7
Gerrit-Change-Id: Icf004ddddb9b3a5=
fbfa0f4c6179c27bc1d306351
Gerrit-Change-Number: 1988
Gerrit-PatchSet: 1
Ger=
rit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arn=
e Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocar=
u <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Es=
ourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eor=
g>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Com=
ment-Date: Mon, 12 Oct 2026 16:39:23 +0000
Gerrit-HasComments: Yes
Gerrit-H=
as-Labels: Yes

--+6EMifWVPVA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail=
">View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>File Changes=2Emd:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1988/comment/fb9f28f6_924c69d4?usp=3Demail">Patch Set=
 #1, Line 185:</a> <code style=3D"font-family:monospace,monospace">   - fix=
 by introducing route flags and restraining the check on them)</code></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">M=
ight want to move `-` on the line above so it doesn&#39;t become a sub-bull=
et point=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1988/comment/75b7dd40_f39a3b6d?usp=3Demail">Patch Set #1, Line 272:</a>=
 <code style=3D"font-family:monospace,monospace">  - this was off by 4, for=
 connections openvpn 2=2E7+ to openvpn 2=2E7+,</code></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think this will=
 end up being a nested sub-bullet=2E This probably needs the `-` to be move=
d at the end of the line above it=2E</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1988?usp=3Demail">=
change 1988</a>=2E To unsubscribe, or for help writing mail filters, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
8?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div st=
yle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:=
none"> Gerrit-Branch: release/2=2E7 </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: Icf004ddddb9b3a5fbfa0f4c6179c27bc1d306351 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1988 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Comment-Date: Mon, 12 Oct 2026 16:39:23 +0000 </div>
<div sty=
le=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:n=
one"> Gerrit-Has-Labels: Yes </div>

</body></html>
--+6EMifWVPVA=--


--===============4005923712040104393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4005923712040104393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4005923712040104393==--

