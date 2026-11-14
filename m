Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B85606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DuNrtO1B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EMoZ2YAy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IIbdXby5;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SUq/e0+p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W81ce7hzHGhGaNd98Q8C1ogSrwY6k8SJ1DouOe6T1dk=; b=DuNrtO1BCsIxk2UImBu98+mJDX
	aHmupFhaOcnAKXqlKV8lp60PhgowQvT8AUZenscUL3kMLBP7ogIrchYPql7nhZpcinoH5qPcnJpci
	JAX82YFG2sR2+MVhxISUecEABeGKu5+FQxJTnm0JDjtZXHMuk+1GDLPDasavACBMK0Ao=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSGBL-000000003JE-2ee5;
	Sat, 14 Nov 2026 16:00:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSGBJ-000000003J7-3xbz
 for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:00:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gK/VtfglU6DOA4ow09XmVvnqxNqVzGwM4hw9UdleQfU=; b=EMoZ2YAydSghXaiyaziram0ELr
 4HwyXQr6zU8EiNAxh+2q3RPG/NlCleohgXUx/xpr6iKjCEejrczZqczAYmbe7UqgDbTAyKYbn8qKv
 RlUMrtiuuTRbwzMQcoXcsjq0aYeRP7F+o9cBhkP4d3IrS9TH/5gaNYUe+5mHo4+GCb/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gK/VtfglU6DOA4ow09XmVvnqxNqVzGwM4hw9UdleQfU=; b=IIbdXby5qoCcCT4P+8E/YNz0V2
 Xa0XQxvlbr3qSU3Q9TeB4Bh6lBNn1r5cOYiNXz6CrlYl+BySHn9CXilx1Ze1OKh3eqaoXaUaxf8Yu
 JZ4KG9qX7aUEt/G0p1QYhMSeS7BPiplCoWSMhgqdNWDSP0O3kORkltAgqZg8+NTLqrBY=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSGBI-000000001KU-2B5A for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:00:45 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4910b863b84so1751247f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 14 Nov 2026 08:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794672038; x=1795276838; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gK/VtfglU6DOA4ow09XmVvnqxNqVzGwM4hw9UdleQfU=;
 b=SUq/e0+plfoyrZigqSQKW8uyE210LLMYWNqIWWEBOz+UuoeZS8XTtgkwUVxR3yhOlK
 Odys0SnRSuwRSSciaKjPYnf0sZ3AXM6Ll3AmbkdyR3NIXMBgARcvsH+Q4Mhlc3pfsLZG
 Mj+NiM1NTk4/Vxq/9UbCfMEW26SlfJiKOzsQc9otL1P1oIKz9d2owDUuSZlOF+HvIG99
 Wf4LNtxxVpb/6PybeK7vlntXWkuxFdmiOv0c9Q/M982gYdmR18slg6BKCZYGrQ3KO01n
 X3Ic5usxj5YDNLTPpQAErlxCLoVgRj6Axe0xg3zWGB/xAXlm599o2052fFlQNUboggW/
 iDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794672038; x=1795276838;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gK/VtfglU6DOA4ow09XmVvnqxNqVzGwM4hw9UdleQfU=;
 b=fmc9ogw/Bw+sCFqM6V/P/wHxNhjWFtVeaY/NdKU6NMgfB73yN2eG5lG69rEfCL9+bW
 1b3bfAoWtPlu3iJ8CuAZjsw2T0O4SFyXyCkmNfvpFUAxQ4PBD1R5b8uYueFz66q2woB1
 3sFwNsFLmZXPaIwe34hlYNggCv7FFyUiGzdfgoJanHeeZyBz9k59gra0Yl66eVwyLrCR
 xR8ImEr+MLPCrxyCax7KnMbEtcHABatEPtLYXrkN2d6F578gzARH8+cfPJIdzFc2GqfP
 WRg9zBMV1oTnkbGZcnmHf9Re3DuPAzSbWjBtRRyGGTqWXuavjrnsIqD60qxpPt+KrAaN
 bIkw==
X-Forwarded-Encrypted: i=1;
 AL+hErF9fHRqjRcg9wQRk4S4ovLFbz7ICZtuQg8Jy+tVzku7Q0I0ZGfnLs4bSLekFMPti6DktVmUvnmAb581jJ8t@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+J27XEYJbTdpusB2pZbfHWXkTyFmzwE06Z8CHBHGHrofxLsIEw
 W2tPodfjGYNQYcAi243XsnK2Rf1GO+4siPyf/xcuWTzPLK7XAN06GW4Ijq8gTUcP2IWFh/1Z22o
 gtIy4k1+AMHCsZ07xv0aB9JUcw7Giz7HMX/Q71RSaTzZVZy1R+JdKH2Qezt37JA4bsnb7
X-Gm-Gg: AYBFou1mHzFrjMYHnAhvSaX0lRoQ/rXWYiCwoSpFHi2R7aLeeu/fw7Wys6EbmrJwY8n
 snezwNqU0z3QWrWnm8Hd9fU+IOC4R0gBJVx/aAmK9EIYO067LG5xqy3z5lNuml+pw2HorAHV874
 LNM3Bu/3mk8GdEK2EdJMXriZtt4hTB/sBfX5dF/HYw5WNpkEsbUsKNTWJhUpqM9XZzBHD71OQVu
 dd2JjrF2GUtTtqTq4mvAotR88z68Dxp5Tg5RzlNjGhQdfYp1jB4XeGPnurVRx7P1GKncN+NFo1S
 /q75jAnz8gfEX8o0JyFSGyfzO06KmrimvaOpdVsUQ5Wm0LGbSig6RT+wG2Xeii3BWMud/G5Zk1s
 3ZwV3MpqDsHBv1yPVXedBCu/SLBBwcVKMsr33x+VZ5ArmfDPPIzdAiePhRacVSSNqLu2gBXph5K
 oRcyFENP03xgq+aCYGp1doZ4zdZhPXaY5RQ5eWsvXvQ6zxgvfFdYjFqv9awNhppO5bbkGy0/zN0
 0s4iWmQwbKn0G2rQieZOSeRkpsMup1XgtfJ5lpY29Kurnwyma3o4LMV76dZyLm1EY4xEwqrhTqg
 0tG/ZvGh4mbWW9OoceS3IOy8NmVl8pX40C4H8jjwaHMHA291ww4J2Ib4dVcUVrcrkLOg0u5cdEN
 nVHeJx5dQDNQxRRxUjnu52g+5GnNQu/c3Rjx0pFvrRTWODtQxhoo8/dH5ICNnCPHf3T+aAdkwfU
 MvfvqSyc/7Ic/nQmk5VfV46WIynd/CeXj3Kda6
X-Received: by 2002:a05:6000:1866:b0:492:2b36:a149 with SMTP id
 ffacd0b85a97d-49b02d4c9b1mr21255686f8f.25.1794672037711; 
 Sat, 14 Nov 2026 08:00:37 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c69406640sm11208387f8f.12.2026.11.14.08.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 08:00:37 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 14 Nov 2026 16:00:35 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
X-Gerrit-Change-Number: 2121
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2121?usp=email>
X-Gerrit-Commit: 74227ff93033712f8613053e29e1442a1a49bb9a
X-Gerrit-Comment-Date: Sat, 14 Nov 2026 16:00:35 +0000
In-Reply-To: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
References: <gerrit.1793777926000.Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc3OTI2MDAwLklhOWYzMjhiMWMwZWEyOWFkZjgxMWE5MzNkMWZkMjJjYjMyZTM1ZTZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d09fdc9d3d4f4cff135f95504d0b35e5ca0c7df8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSGBI-000000001KU-2B5A
Subject: [Openvpn-devel] [S] Change in openvpn[master]: pkcs11: bound
 certificate size in pkcs11_management_id_get()
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
Content-Type: multipart/mixed; boundary="===============8373517094675036206=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8373517094675036206==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PB9NdRWodEA="; charset=UTF-8

--PB9NdRWodEA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Gert Doering has posted comments on this change by R=C4=83zvan Cojocaru=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail )

Change=
 subject: pkcs11: bound certificate size in pkcs11_management_id_get()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Co=
de-Review-1

(1 comment)

File src/openvpn/pkcs11_backend=2Eh:

https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2121/comment/43c0f860_1b3c9041?usp=3Demail =
:
PS1, Line 49:  */
can you please rewrap this so we stay under 80 characte=
rs line length for the comment?  (Our rules are a bit fuzzy on line length,=
 and this is intentional - sometimes a long line is less ugly than wrapping=
, but for block comments it's easier ;-) )



-- 
To view, visit https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d
Gerrit=
-Change-Number: 2121
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Sat, 14 Nov 2026 16:00:35=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--PB9NdRWodEA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Gert Do=
ering has posted comments on this change by R=C4=83zvan Cojocaru=2E</p><p>P=
atch set 1:<span style=3D"border-radius: 3px; display: inline-block; margin=
: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/pkcs11_backen=
d=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121/comment/43c0f860_1b3c9041?usp=3De=
mail">Patch Set #1, Line 49:</a> <code style=3D"font-family:monospace,monos=
pace"> */</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">can you please rewrap this so we stay under 80 charact=
ers line length for the comment?  (Our rules are a bit fuzzy on line length=
, and this is intentional - sometimes a long line is less ugly than wrappin=
g, but for block comments it&#39;s easier ;-) )</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2121?us=
p=3Demail">change 2121</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2121?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </d=
iv>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Ia9f328b1c0ea29adf811a933d1fd22cb32e35e6d </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2121 </div>
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
lay:none"> Gerrit-Comment-Date: Sat, 14 Nov 2026 16:00:35 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displ=
ay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--PB9NdRWodEA=--


--===============8373517094675036206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8373517094675036206==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8373517094675036206==--

