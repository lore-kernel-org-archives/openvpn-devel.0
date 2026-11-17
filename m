Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DEE606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 07:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cHye930/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=aoYcl7fI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MF2OCmPW;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=bzVWinbi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=u8BJLK7nyXLml7XyFgurgP1jLq6+39VCYujVa4JImZQ=; b=cHye930/VG0xsDAGEZxPXY7brX
	f8kpB66UFi3/JGcjTdsVLyGkiHq5GDARsoiWym2KD9+kZr54GVPEaY7bFOef3G+xFF9K8W6G1TxsY
	sUYvLM+sPpm0INj/JkOGrEBJCr5GdMgmSXepQCIyxiQzBqEePuiVbNQgXKsakXoF2r/c=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTDSp-000000000kA-2OH0;
	Tue, 17 Nov 2026 07:18:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTDSo-000000000k3-1mdh
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 07:18:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w12Tg4QsU919/JLb4++vD/XjaVOUJrI0FviqQOXmlNA=; b=aoYcl7fItfamvCK3r1LV9lwk8J
 mm9kRp5Y8qx/coEzdCtefh4cyCPQ5KVPFWeC+tZw2A4sJlXc7Yngi/3PU/7kwsN0ezz8i6bCJHorG
 F0uN8WLLgCPnmgquMbDKDiF1iPEUqP1n8+sHc/wfpaUnH4G6VVivDfFSKc/gUWw9eElo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w12Tg4QsU919/JLb4++vD/XjaVOUJrI0FviqQOXmlNA=; b=MF2OCmPWnsMK3/SFjSGgY9gxYO
 ejGgbTHHks5SHl40aoVhcD5YthUGHUXdsVX+hdg3HxXq3Q43v6431dPBN6ry/97vYMhWhzsg3rDAQ
 oYv0WG09/j2GesN2NNhsTXOBjsjZyN3iTmbhvbU9zpmY7GVcU4voexY3HlRgvH7A6by8=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTDSm-000000007gC-122y for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 07:18:46 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-498f5fa4f70so4452777f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 23:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794899918; x=1795504718; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=w12Tg4QsU919/JLb4++vD/XjaVOUJrI0FviqQOXmlNA=;
 b=bzVWinbicULSdK032TpMVToGaGNdcM8mpcQqH4vi2Dgu2KzXhHcXJruGVUJEFZxnKq
 NPXTCFR1IvAaipspw45h6hS8DY20Nk/9vvGHYO5dbluZDmsEkfjufsb9eWeTgqBmHQWj
 DPZvcyXH4Wh3aFOT/IZGYn3MrS10h3Xp7xEDrLHjcjAwWmUO0+5pF7QtAHOuKeHhlCve
 d0PXzZG0CwZAa2uRJTG7MNYSTEvsv56eeJ8LwgpQzH1ol/BeV3TcLzGM8IOIttR5ziMb
 PlWAbWKOyeMfPvkOQ/l7KBXzPTMkudlQtWI3sy1gnHcCg8tcXy+MvF4i8nxFPzQxoZYs
 rtJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794899918; x=1795504718;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=w12Tg4QsU919/JLb4++vD/XjaVOUJrI0FviqQOXmlNA=;
 b=jwS2TQogAUBt56i1yqUwd1iieSB2/2/MxsZUamTfAuhRYhLRFSFZ7RNEdXxw/odr0a
 GRNzDuB4pBlHdAfrRCuJXnF+EhRzOVPBoCVTrlPL6unNxfa8zg5zd3RcJoVEKCX1NrqN
 HsqdgiyDkxHIa5oxcTzejW6lfbUqfixpU7qBgK9il4+ZYZz3++60276h+uxJixG4wa5r
 JS4UjlpO9/ldFDQoRuRHcMK8diCeLsUOB+Bu2LlMSXrV6GGC1gFrYktSnnNyiFLlknUo
 fB6b6s5kMZl4vOsK3cBRybfsYkc1KupkxkbBTHUOCk9QGcaL4oaP+a88bgJieeKOAMTe
 JZrg==
X-Forwarded-Encrypted: i=1;
 AL+hErHoUFA1y4q3I1Yl0T17uAjR2+dpWjbxjxvnsiTPQEFLt+ZHLGUzbks6r/tcWq9yhWz4XC6in3KmRw70yRpt@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/1zRbvWH7ITuKTxSDGpRyp7SV8AoWjHS6/SZFfXlvVN1szlJy2
 LpAj/YVImcWM1lfAadF8cDDYTQv+qQ3udiUkHnugyDs3MhDznIg0FGtTARpDSnd3pOv1HcrAyaA
 8cDCCtkstOubpEMgFt8BEWBxNLuyXWrkUyUkDs7NIRXMOXFQF2LjuXzANZ9XLJzArczSxcVVQki
 ykz0zDDQ==
X-Gm-Gg: AZFdTZcdxpC339xfFVCnDYVWmW4psx7K/rkVfUmi9QC8xv+QNLI32GAN6txQ6lflJzg
 k+D51tGceO6JQsgIN8Q/3Btf0MUFr+VxRxnapRzD7QCGp1zpJX0raj2HbAhSQzxkK8M8NeRs+0o
 GYOu3S+DWEGodhqB5Ujp2mfatAjMc/5kq6L6kyiP15EtmjuEph1Q0yXunuo5RN2XK4eq2Zw9eHd
 9jbxxyK0Ix4yc7+5XZyvIjWERcDP6I35s72dCWdCh2/ysogGhO75+xWH3jlldBnbfpm1UP7SBeL
 oOF6JS44vTujSWozA9xNRQ87K5yAYmsLsOr8Su0+tDYjULxW5yaO27L+ocdl6e0ITZwvOUYYflP
 5//Y2FLtvNE3AeuwMFwyg6wKGBMti4j+0VVWzffKbsGNaTZ2ZhODrp2JrYJS65AjC4kPP7uZ64+
 bfFGi2HcEnEfP1C9bJhApY+SzACX1NjLAWFDnXiAYVuhTQr5d7LyCqOLRbESqc1Al2wq05qr20h
 CzQ2BCzNF/fKXvL5qCT/grmZ7vbTLdobT+ycuBQHPhRm4pe5sCpIzso5muDoyh5OlAm/i483+N1
 B1wOkhT6kP8JSQMRY/ZTDxhrYq+RBUMaiRoh6MRXQxYx51690vvZDLJxmvy3IOGWimjGmmvr26X
 r1OdZ5mIX7IyJpYmT/mUpOmj4psCm251mFXtAgEhhF6g6O1MLEZtPiBZuOU68RU17XAXMXMKzZo
 EzPe16zukpMJMspt2S9vPCvDC0yUqJ0wdCgvAp
X-Received: by 2002:a05:6000:2513:b0:48e:47e6:fdfb with SMTP id
 ffacd0b85a97d-49c70ed7c9cmr24813536f8f.13.1794899917421; 
 Mon, 16 Nov 2026 23:18:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d03b10fsm29467495f8f.1.2026.11.16.23.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 23:18:36 -0800 (PST)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 07:18:35 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 3a1321674127756e760c096a18b7d8e0cc463112
X-Gerrit-Comment-Date: Tue, 17 Nov 2026 07:18:35 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d502beb6225f66606e4a2b21c2fed8f1dd76a39d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTDSm-000000007gC-122y
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2988111388642524883=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2988111388642524883==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J6wYN9weIfc="; charset=UTF-8

--J6wYN9weIfc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici=2E

chugly has posted comments on this change by Lev St=
ipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail )

=
Change subject: control_msg: Add P_CONTROL_V2 and the probe request and rep=
ly TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Pat=
ch Set 26: Code-Review+1

(2 comments)

My PS21 points are all covered, tha=
nks=2E Builds clean here and pkt_testdriver passes=2E Two small things inli=
ne=2E

File src/openvpn/Makefile=2Eam:

https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1741/comment/31a95048_c6d4823b?usp=3Demail :
PS26, Line 123: 	pool=
=2Ec pool=2Eh 	probe=2Ec probe=2Eh \
probe=2Ec probe=2Eh ended up on the po=
ol=2Ec line with a tab in between=2E Works, but should be its own line=2E S=
ame thing twice in tests/unit_tests/openvpn/Makefile=2Eam (168, 175)=2E


F=
ile tests/unit_tests/openvpn/test_probe=2Ec:

https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1741/comment/86e43bd6_4d359461?usp=3Demail :
PS26, Line 342: =
test_find_tlv_skips_optional_after_wanted(void **state)
Nothing tests the "=
unknown mandatory TLV rejects the message" rule by itself=2E The mandatory =
0x7ff TLV in test_find_tlv_value_truncated fails on the truncation first=2E=
 Maybe add a well-formed unknown mandatory TLV, once before and once after =
the wanted one, and expect false=2E



-- 
To view, visit https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=


Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-=
Number: 1741
Gerrit-PatchSet: 26
Gerrit-Owner: Lev Stipakov <lstipakov@gmai=
l=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf=
 Lici <ralf@mandelbit=2Ecom>
Gerrit-Reviewer: chugly <charlie=2Evigue@openv=
pn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet=
>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev =
Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2E=
com>
Gerrit-Comment-Date: Tue, 17 Nov 2026 07:18:35 +0000
Gerrit-HasComment=
s: Yes
Gerrit-Has-Labels: Yes

--J6wYN9weIfc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici=2E </p>
<p>chugly has posted comments on this change by Lev Stipakov=2E=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">My PS21 points are all covered, thanks=2E Builds clean here and pkt_te=
stdriver passes=2E Two small things inline=2E</p><p>Patch set 26:<span styl=
e=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px=
;background-color: #d4ffd4;">Code-Review +1</span></p><p><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a></p><p=
>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/Makefile=2Eam:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1741/comment/31a95048_c6d4823b?usp=3Demail">Patch Set #26, Line=
 123:</a> <code style=3D"font-family:monospace,monospace">	pool=2Ec pool=2E=
h 	probe=2Ec probe=2Eh \</code></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">probe=2Ec probe=2Eh ended up on the poo=
l=2Ec line with a tab in between=2E Works, but should be its own line=2E Sa=
me thing twice in tests/unit_tests/openvpn/Makefile=2Eam (168, 175)=2E</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests=
/openvpn/test_probe=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/86e43bd=
6_4d359461?usp=3Demail">Patch Set #26, Line 342:</a> <code style=3D"font-fa=
mily:monospace,monospace">test_find_tlv_skips_optional_after_wanted(void **=
state)</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Nothing tests the &quot;unknown mandatory TLV rejects the=
 message&quot; rule by itself=2E The mandatory 0x7ff TLV in test_find_tlv_v=
alue_truncated fails on the truncation first=2E Maybe add a well-formed unk=
nown mandatory TLV, once before and once after the wanted one, and expect f=
alse=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">change 1741</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d62=
2a7be14be369437388268 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1741 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 26 </div>
<d=
iv style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: chugly &lt;char=
lie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Lev Stipakov &=
lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 1=
7 Nov 2026 07:18:35 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div=
>

</body></html>
--J6wYN9weIfc=--


--===============2988111388642524883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2988111388642524883==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2988111388642524883==--

