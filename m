Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C62D60A2621
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XVrzWOFc;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fqYcWFSU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mPvhPp0C;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hG38nU+k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ag/ZnhBSpSKqQynaoIeVqmKo5hkTrVTBnbXHTdTVj3A=; b=XVrzWOFc2aRHyQt6JWp04Yabru
	DUwPnFQILikBASFOJWxdZSlTxSukcRB2TSweRvzYCyPcqQVUA5bS6dvY6+oO9Yc76dO6OPR8dHO5o
	yd5YgFjH5XPwMf0D1rkkDBKvY9RXm93mmKSuypkuzz7MCWj8PeuZcCei9h4xQZ4l9je0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTzTX-0000000050N-1PFL;
	Thu, 19 Nov 2026 10:34:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTzTW-0000000050D-0IK3
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zNi3X4bw4HIYBhHPIW8/S+9mMYI7uuqRPaHl9wkU/O8=; b=fqYcWFSUiIp+8jcOK3WX+X8S62
 SBOSYu6FsoEobvdXarT3yHjwKg9E2fOdnzNibcESas692BBrHjQ9GmlE3IvLUOcoq8ROD6a340SY6
 Vl3hzZP1ZZbluKtxftTAUje4L6ZoYrH36D1k8P0/9cSrdN9Hfq7EU/byzxRPrUc2gTE0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zNi3X4bw4HIYBhHPIW8/S+9mMYI7uuqRPaHl9wkU/O8=; b=mPvhPp0C9JZAxPIZXhCzsRbdxa
 C9S0htnZEtHhdSi9vaj8ZJsgQPG7YX288YagSAl1gYd8JxTJf5q/PdR0O7w3mXZMyxsAXuVJZudJP
 sac+hO0INnmb8EEoV+erg7cl2ej0JakWPC1v9Rv9J4Xcyp944m9WyNdgZX4QbKnt1XSk=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTzTS-000000005Zh-3Zdt for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 10:34:41 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-498f5fa5103so1193356f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 02:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795084472; x=1795689272; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zNi3X4bw4HIYBhHPIW8/S+9mMYI7uuqRPaHl9wkU/O8=;
 b=hG38nU+kwyKJAi5tBVmpAi3oLsjs/fa8ogQ1CtdaNMotXxDpDWaIo5u0MKmBoZl27O
 Zgk1r0ueXZKsDx5HsIYYeic0MxTk4kwYOp9dJ6KptwDydhHyOmOQHvt01avQZYRglhpm
 zoALexOYbVfo2OjTPKsVTUgcuYKAE03GEyw3RZN330rBfjAloPc2tVjC6Eb/CJ2pAHMU
 /PmuAwHRWAqXwoR7fWCGb/Jj2CNuS7R7xTSIJY6IecKzXeOeMRrPoeu9P2gBEfOXbgrW
 wCt34+xMHedzVW9xMptF+4/fqbnB2jD/mehP6BmzdnYaugDpGT5VKPzKP51932VM+tsP
 i/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795084472; x=1795689272;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zNi3X4bw4HIYBhHPIW8/S+9mMYI7uuqRPaHl9wkU/O8=;
 b=KVrF26MkJFvgRZ9c03Bdvbzcku+mToP2u1j+8udSGMIBAyxGrZVEv3AKQVFa+6dvss
 YHVX2slEjG0zu3C41Z0ZJFG+USjodEuAMimnUh5k5IlWgzOjFkvH1J6eLuEGbGk+i3Lo
 EDKni5O61KWGxZsKouGA6c3mIF04gvyvprIRhXD9gLGfSZL4sAqazmNsm9TqS87jPXJF
 51cmV1ejM9l+hZjyNFSDvZ8DJae/J1J3sBajzjCj5LKqBnJcsb2Sprh1DzLirYpiHozb
 O7tpBRvjjshWQgcKb8eyKmmoQUMT07aFM11BcwH/oxWiH58z9GuNx30w2Ds8/dgLLlKX
 3Zvw==
X-Forwarded-Encrypted: i=1;
 AL+hErEHtYhDZ0B/FmujHlnZFxjhGRhOgrB37KjFDW+OSHiRW5Ea2/L4wUwxHPM3qHKA0lS/PB4O0j2ZADCa8uoY@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+5a9SInlTKKVenoggjEauwKOXTNdRJhJ1Rd1Lzzv7lRagxezCp
 ZdlKLOluJUPSda6tosbderrc8IWegHu9cdzx2UVimSx4X9BILz9ahR8K2Mhk7+tA/Mq+emlllWc
 quh1kXEtTYQ9PifaK0IZrLFySCbSYVM2yRhR0u64yZgmY5ODcDFmQVRFmBu/ZT+zzJ4G2P/uksZ
 MW3ghWBA==
X-Gm-Gg: AZFdTZdiYxLsqh0XWqFIbnPRJtIJCjJuO671HdisfmkahYyrzAXI9a57R4A/22jvoGx
 BykbVIhrttq30pNNmfb2dYSEuhBgm+uVLIGF1jwxetRb6bPT+EbCJ9+KtgRS4bnnzEU+MmMH9lp
 pZzfK8eZY0cfRfq85yQ4iClXcCrVrD6z3/4UAnlU1jByyEN14Gh9JL0Z/HVt1abCFW2cnwhidNb
 6Yl1nUw4PBUx/RZvkYlS7SJS1GfSeh6yk2jiPhWOzDWJuj32FL9MoxvrSAjj2IQBHOfJR6Mh6j7
 tl/SZOV1e6V4VbCBcSJJk33naNnW2QoeQnYuBKEce5qDypXYAeKefAyNDKMxVW1Ej8F2XZ2GThA
 N8PkrWT0eoQNh+OXmxGgZUCO9Tbf6xC95Aobn5lLiqndJHCWD8aYWpMWRlflbTadhFnjLkNK+Pu
 awnW5el9vceiDL4CYxxjEiY3zdt+YJtnhp8vcUXXkLwFeII3DwQdfuGZS4Ge9RGMC3rxu7/jp8n
 4uZfkGWz1FokfCdGnDPBHKUtk7OxNqcP5PJYgWQwavYpdEinXnGXBoHdO3n7GXuFEeQDlReaW9j
 vs7PVPFMi54x6uYND+GWkF3ekQPMZO0STt7mRzPYgGdgqz8p9eTNtL882zCZd4vlxgu8rAl16EQ
 buc/PFov1xdUG3TAaryJQiaVGg8PVWgfInzJ+JCeF+lLkK8P+uTIrVF8QPBhQosTYNNVrc8haJi
 mxGX1DjSYC3C6jin0ZGLPu/sxBaxellZXUmYwy
X-Received: by 2002:a5d:5888:0:b0:4a3:d1d0:a38a with SMTP id
 ffacd0b85a97d-4a638bd699fmr10179867f8f.14.1795084472039; 
 Thu, 19 Nov 2026 02:34:32 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a65541f3f7sm10539964f8f.24.2026.11.19.02.34.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 02:34:31 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 10:34:30 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf
X-Gerrit-Change-Number: 2222
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2222?usp=email>
X-Gerrit-Commit: 7f5ea0ff8000103d044c1a4f174dc84ef34a60e6
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 10:34:30 +0000
In-Reply-To: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
References: <gerrit.1795074834000.If803050d06e59ec067ef5bd8bb32787ec2b7cfdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDc0ODM0MDAwLklmODAzMDUwZDA2ZTU5ZWMwNjdlZjViZDhiYjMyNzg3ZWMyYjdjZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1e3f72feabdbf2e95a28ae5c1406fcb9e7fdc4ab-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTzTS-000000005Zh-3Zdt
Subject: [Openvpn-devel] [M] Change in openvpn[master]: contrib: drop
 fwmarkroute scripts
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
Content-Type: multipart/mixed; boundary="===============0043078243519428356=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0043078243519428356==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OBkyl9x6hVg="; charset=UTF-8

--OBkyl9x6hVg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=3Demail )

Change=
 subject: contrib: drop fwmarkroute scripts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, =
visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=3Demail
To unsubs=
cribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787e=
c2b7cfdf
Gerrit-Change-Number: 2222
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=
=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=
=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
G=
errit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 19=
 Nov 2026 10:34:30 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--OBkyl9x6hVg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2222?usp=
=3Demail">change 2222</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2222?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: If803050d06e59ec067ef5bd8bb32787ec2b7cfdf </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2222 </div>
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
lay:none"> Gerrit-Comment-Date: Thu, 19 Nov 2026 10:34:30 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--OBkyl9x6hVg=--


--===============0043078243519428356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0043078243519428356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0043078243519428356==--

