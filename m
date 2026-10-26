Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8B7606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 04:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ei4CgOdI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MfKvkEM9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CuNqHfRn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=V7Ix2auL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=zm8Kv6CAQBElJLF/PlMrPsbCSUqZep6fOBvKBJy0dC0=; b=Ei4CgOdIkCpea/acatKISqBt7J
	RVtsU62ROM+LRwV6Yt1tFXXDw3kA76SxQW1G6BZuN1rIaZnYhydTVxoPCetxUk/H8UDvNumm8Ha1q
	bSKlo8LRIWNb7NTs8He1cy1S2IP7PsC8K9RSGolXu8EVZEbtlX2LleHruZYN0eqGnOco=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLCDp-0000000087Y-2WqL;
	Mon, 26 Oct 2026 04:22:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLCDo-0000000087S-2i0R
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 04:22:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y5Avg6MUnfEFNO0yAKwxONZjP5edaRxKWTxNTbcmF7s=; b=MfKvkEM9Xtp5X4eXDHVDBCoy/G
 dQY4vfdcXI1QEj5o68Rw0V00qBR9ysr7E0xGi8ceV9CpjycOeMgWEln80YtCQ8vYKoxwj6/diJOSi
 Mpdth/WXV17426IA8zHwzQie97AmcD/u7xhKjg+r5AbLcVPya2VATbnmlxQ56YBMz9I8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y5Avg6MUnfEFNO0yAKwxONZjP5edaRxKWTxNTbcmF7s=; b=CuNqHfRnhALU6NV31B6e5ERTr3
 wLalJ6RATOW/N2Txg0OAi6qsOy07x6TFHbZ/ABxO47F5W2GLI0unvmHcro3FQ0FqKFW6U7VUHvHwY
 PpyP3dDFARDli2QSEy8YfMo0SCj9oqMJj8fFRslb/GxTPv8N9MWlAgUBPeeCpjRY8IbE=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLCDn-000000003Vs-1l5A for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 04:22:08 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so19961475e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 21:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792988521; x=1793593321; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y5Avg6MUnfEFNO0yAKwxONZjP5edaRxKWTxNTbcmF7s=;
 b=V7Ix2auLlwcQoz+ovpmdABaJVQy25ePSPOopY+nKkJWddcA2dIid1TqLU1k5BY7ARE
 2GpUEw8z8Y5G+8Ze2EjaPwPtktHTF+XzjyI05MemmqyPdrnDqrVcC96FJS2AzATrZUq6
 6RM1vCws+PIUf2qoQUB3DlOWdirhfFtIkQ83MegArbCsAf8TxkGphmi4Xpur49w7/eJ5
 IyGJ/DXT5o/u0/NkJhcQx9gWFKlXNKUN5q+U291ZzU6fKmI0360GWtUPD1EWClkMBclp
 d28V7ZA4NsDfJ4A3r0ROBvPnWU3vChi/IuCrb85c/NiECtKl95oEMpq00CqVs+N24vrZ
 jcYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792988521; x=1793593321;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y5Avg6MUnfEFNO0yAKwxONZjP5edaRxKWTxNTbcmF7s=;
 b=JLtbq9N/0Ci0k2ZFET2AKcP9P5GsNQsqe1mjYqPaaL/K+nuQJYvDlB67hyVqQ60MJH
 q44em1bAJheuWOPVvvp4mCJ+Hi7MddcwKW6QM/jvfg7VH7toUmodyqsMTmoj50EKndOG
 ihD92kdyLJ1NUD5XcFL9oEhYIq+KsyVNsS+wEqD2eTcimkqSoi/5CUUxw4LNweBC3iv4
 FtEPnzaIeRDNBKWOmq4YmRsrKcJUONdd4XCNUMGFvhCN0jP5c2VkT5q9mC2pP0ZI9rGY
 HrYSNEZ7GaoLoDSul9OlAtz32KUvruccihWYKFoFGLK0QFkLmQtJkhX59IxFz8Hf0EBG
 pVOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVHJ+q/Zf0TeYrYanp7fesv6dSKNdQ+eca/P4n+pm7O/i/InfXUjVibLcl1Eyd78PpYaWUb8bcZvi2jdrV@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJix4M4TlB6cVedPLMRZI0s52IyEwmuKdfFJhLbJAnPhmanHzLx
 8IX58Ihymobov8ZFEcdFCamLOeEmbFDXMPqDHmZH/PCNg1EAPaIMHXvQFERPDIUqMzu29403ALG
 bxN9SRvzl5NNMBaeEqdAhNbmBLI9Xhocflv4xmv+E97iKC72RaJpWG5wkyQF3QPUqGg3k
X-Gm-Gg: AYBFou3cgMQNbxT3+Yt43rmKxbExXK4Xt+hT1NrygwAtbXfTWd76cOBTV4fqsgL2jBu
 rMri0n06m/2+xtcVvw24lLoAkzs3Jn6FM17SgU3i+ppSHEMSDhjAozIX+pwQAioPFF1AyC/ix0l
 Ek6/yP+1UZUbCafkFJ5RqDgeuBe9KYknODbYguNvH6NAooynHGKuPClAXW6U7WQPypyvEcE5l4F
 nHJ3pV98OKCL77X7SGY8yCBILIu00+BXuaF+MZOZ+LRZkWJpMV5D9+n5NvxwieqHM+pwvRm+d4g
 B9qo1OhZhddqHd0UP3nxnFzYQKWcKNmU6qqDdjkJzluoJ3AmWWEmBJqYT6XPqGa0SCS3S4wpL4P
 YNcib8SdmZpwy9zleSY63FgOhYnvAnyL1w0QIeV9myZhQedP1L28pVkfXoOVyd52WZ/zS8cBzNA
 0BhFKHikd5+LGZTexPlw/60opBlUdRTLA8TBXpQkvZ8dVJ/9sR2sG/egW0/kaBgUdTkgcuWQOQz
 EwxSr3dNqphh3iU/b33l6KYOayjxSysWAzD29tcscoDGQhIv0dME/Q+k0kDaTVrP/KTJ3RFINrC
 /LbUAGDs+Wf5hHO/1kbvRZoNZV3bDe2oLgqAp2l5tbaWAwKXOl577KySw2pXIRCNPBIR6yTaa0i
 jN6hnqthmNC55SKCb0nzxpfjkPPKAjbWHFwNdnp99BA==
X-Received: by 2002:a05:600c:8183:b0:4a1:cef3:fb3a with SMTP id
 5b1f17b1804b1-4a35ac99b77mr87716435e9.9.1792988520705; 
 Sun, 25 Oct 2026 21:22:00 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a359fb08d5sm260326715e9.1.2026.10.25.21.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 21:22:00 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 04:21:54 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 1ba9599657b52d3f96357d3972ba3edf9fea1cec
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 04:21:54 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d33f09da874ec758c7921ef4b867d0e98c078721-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLCDn-000000003Vs-1l5A
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8579025268287293780=="
X-Spam-Status: No, score=-2.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8579025268287293780==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4fPq2Q0QS+8="; charset=UTF-8

--4fPq2Q0QS+8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, R=C4=
=83zvan Cojocaru=2E

chugly has posted comments on this change by Arne Schw=
abe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Cha=
nge subject: Implement sending/receiving app custom control protocol messag=
es
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set=
 12:

Builds and unit tests pass, but `make` fails in doc/: client-options=
=2Erst:451 is missing the closing backtick on the :code:`IV_ACC=3D=2E=2E=2E=
` line, and rst2man --strict errors out on it=2E

In do_deferred_options() =
the ACC_PROTOCOLS block is gated on `found & OPT_P_NCP`, so it fires whenev=
er the server pushes cipher, even with no --app-custom-control set, and pri=
nts protocols=3D(null)=2E Should that be OPT_P_ACC?

Smaller things: the IN=
FO ACC: path on the client doesn't check the list against our own acc_proto=
cols, which the comment in acc=2Eh says it should=2E management-notes=2Etxt=
 "to facilitate the pending authentication" looks copied from the CR sectio=
n=2E "will announced" in management-options=2Erst, which also lacks a trail=
ing newline=2E


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters, visi=
t https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: =
comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4a=
6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerrit-Pa=
tchSet: 12
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evigue=
@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: F=
rank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mon, 26 Oct=
 2026 04:21:54 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--4fPq2Q0QS+8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, R=C4=83zvan Cojocaru=
=2E </p>
<p>chugly has posted comments on this change by Arne Schwabe=2E</p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Builds and unit tests pass, but `make` fails in doc/: client-options=2Ers=
t:451 is missing the closing backtick on the :code:`IV_ACC=3D=2E=2E=2E` lin=
e, and rst2man --strict errors out on it=2E</p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">In do_deferred_options() th=
e ACC_PROTOCOLS block is gated on `found &amp; OPT_P_NCP`, so it fires when=
ever the server pushes cipher, even with no --app-custom-control set, and p=
rints protocols=3D(null)=2E Should that be OPT_P_ACC?</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Smaller things: t=
he INFO ACC: path on the client doesn&#39;t check the list against our own =
acc_protocols, which the comment in acc=2Eh says it should=2E management-no=
tes=2Etxt &quot;to facilitate the pending authentication&quot; looks copied=
 from the CR section=2E &quot;will announced&quot; in management-options=2E=
rst, which also lacks a trailing newline=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsco=
pe itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url"=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"di=
splay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"=
> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch=
: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e1=
5896b8b79d795b2a6de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Number: 1858 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 <=
/div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evig=
ue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn=
-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D=
"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Mon, 26 Oct 2026 04:21:54 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--4fPq2Q0QS+8=--


--===============8579025268287293780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8579025268287293780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8579025268287293780==--

