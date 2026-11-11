Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC58606A327
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bdd1ybaw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Wf1TfJcv;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dBDgsH92;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=CvtmmueQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=BIrn6lxyAirZI9EsoV9LWrFN6HXLjzr2Bq4ViNWGj3g=; b=bdd1ybawmbgdxIGj29FDCQiKzi
	udMCaSYVAqNM6t5NizKFVg71v+uoYRw5TOUJF7ILl0C0q/O7lvICpx2IE+O26WEOogOzJQ0eK9GeK
	cOV2nnE/PxNHQ/aBX2TV1dqThv3LCvNM4nN49tYExKByBV/NSWJvSn2hxm650XFyF5nc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR9NF-000000005zd-38vv;
	Wed, 11 Nov 2026 14:32:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR9N8-000000005zR-0xqE
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z/h6s+akUBwVHxMqoV+mTwCazT2+jDVkU6NJvcj96hM=; b=Wf1TfJcvPfgCBhrLSHZmf00PoP
 e85i3vI+HUFTzy9i3b8KX9m4v5HEXbMjaAz8oDK7DxGmkb4pP1LMoT7dzmSxCe5+FbnqlsxzV1ekg
 Oj4d3ngkXjoxGAoRF51y2PDbWRPwr++0WA/31zodxnnmnz+s6OQJZ49/3d46YqqiLvR8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z/h6s+akUBwVHxMqoV+mTwCazT2+jDVkU6NJvcj96hM=; b=dBDgsH92RwlTvNBIEKy/bPTlyv
 RktSemLfGsT534QXkD65F2z7Hkg8fkB/WzuuP6OU8U+KfuUcklJn1W67UUHsO5i+DtyeYWUerx5PO
 zTe/7DXdDqwcO8+eum6/iPvZ7TtI/9AaCqk18bNiuEnV/EHz7y5EWDnsjtQn/sMTcppA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR9N6-000000007uM-3P2W for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 14:32:22 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4ba013938d7so19683515e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 06:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794407534; x=1795012334; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Z/h6s+akUBwVHxMqoV+mTwCazT2+jDVkU6NJvcj96hM=;
 b=CvtmmueQqKbW+Mvq9i1P4URJmZoJgaTz0vzHuW8WBezIYZgBTaOgqcpzRm5e+6z/TU
 8Kfhu6/O+AnwQ8rZegfXQEfFS+EiLtWnUGJ4q6EgFPi32p0gVMPkZCMbmelAIAhSKbEI
 wpWhbneLqkcAhMP7jTJTiRGrp6YDC+36LhmJezKQcAqJUodCp9QRhyGce5PhNzXoR71E
 NRU5eWqDXnACedhXbzMjvH7RAKm1EtbgpYl+xnB0OpVQo8Hf/lJ66tMLoB1YRNwCwIfv
 tD23OZLhzsGkeUxkOcSXr2RcANHqx8J/xXRIQHrRGedXLOvW6nZaZzjcJPGCD1OOIG6j
 VziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794407534; x=1795012334;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Z/h6s+akUBwVHxMqoV+mTwCazT2+jDVkU6NJvcj96hM=;
 b=V22RYhK1hynnMj1P8XOwWM60lqXI9s6AVW7iQsBTrpIEBM0GG1lrWUPiH2c1ONkZN/
 5nz96kqwBjiFwyKc2F/oH0XbOFqnZ6Mla6R8sfEwHCufTLLZdB0uKY8z6LQcgd7upQ2v
 Supj8pT3kiQtkH2k4bpKGK+gQg5Jf1HB7Eb62GiWFxE9WD3tDKa+7MG0jih3eGrHK7IF
 jjj3Ika1mVg+eM5z4a9UVr0gmmApf2ls1ZyyIqeJ4ny3ROyhc9yKfB/Y30x/kBBf5dL8
 HmMMzQdxYbTDZHPKI7Xefnh/CIX66s23tgk5/i05w0cWpjrCVeLC011jodNyrpvV7q4M
 JKng==
X-Gm-Message-State: APuU4Z9QmLdn+hoSOXAVJ5VMdotzn5amJptpzlmqZU8WscloKETC0XhA
 nHZpPAXEuYyqEPL5f6STBtI0iOQnAUHLOdJddC6gRQapQkf3BhNWsO84Gdx5JOidjibyJYIk6HU
 jvfy+XaZmXyzJSmNa6hrG9miotoGO3uXoFnNxD4OuL4SGhX2Cq5SnxjdjXBJxIl8zma0Oz+/uoR
 BfcgRfaA==
X-Gm-Gg: AYBFou2neFnUGEUktpVjdkbmNNDBE7KvH+7oonr3ejHC8oMl+2QreOn154VkhjCPYlX
 vG5+idTdZTUXCU5EOhwVKi85HWjTk4P5f0BbK8Sy3kXg5yzHTkbhYXWJIGr7ofX/+miLcGbn/ux
 3dxjDO9Li9BsMh4Fnq58A4WBIntFKa7EVrhAWxjP0iLOK2l5q3UcIMlngD6I3FVB6EeCf3YsJW/
 Mpm7YAsNDTldu9vNqFf0/2umu+4dYI7GhV61XWyMR0D3aw3zg+98fljiFw8n/N3ipWKspWkRyKE
 cL6CkSWgqxwZY3Z1SKD6ZQDKRqJuoA20mgRtm/Sw0Desy6OSbN0XKu5QY3YJUDV9VPedm4lATJk
 sz3hedGgvi+yn2UKK+Ay+3RQivY4GDwZbU8QmipwiC2PRhMdR6bX6Pk8ZHe5UgQddxbj2GepZ3h
 +2himu16l4v4O6JT84FDxweDmxfaYT98EnaXufc7H/e978BJc00EkyuhQqV+UFpDRUYHNJ6Lwsv
 qVTH3JG2AQdSs6p4BPEA4vnH8foH5aTgIgyaogFSSFHzHLo9r43CP5mF93at6XL+1LwSKP/Ydnq
 t6EMH1TtyhhAkUtnzsyYDAp8J8CdEJAGS3dTmYqBZqXuzGb99YPngLf5/NS8gf5cWWQspET3HYg
 m1wlJlELkfuNN6EwN0W0Bves5XWmoMnVJHmQKVwTFl5jVOriATiikJ7cqmXp7FQCt9CJsGkNPz3
 6y9170We4NTks6/KY=
X-Received: by 2002:a05:600c:4f84:b0:4a1:e92b:ae4a with SMTP id
 5b1f17b1804b1-4ba093b9a3cmr45283355e9.21.1794407533995; 
 Wed, 11 Nov 2026 06:32:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498366c30b1sm11406688f8f.46.2026.11.11.06.32.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 06:32:13 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 14:32:11 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0
X-Gerrit-Change-Number: 2175
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2175?usp=email>
X-Gerrit-Commit: 0ec30f1a1fd63034dc8d2fda869c97e1efbfa474
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 14:32:11 +0000
In-Reply-To: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
References: <gerrit.1794395186000.I230b3b2483e15477b179b277dc8f7c91c53fa0c0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzk1MTg2MDAwLkkyMzBiM2IyNDgzZTE1NDc3YjE3OWIyNzdkYzhmN2M5MWM1M2ZhMGMwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <397172b7368a131aeac71933c24cc39f70de0718-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR9N6-000000007uM-3P2W
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_extract_session_id and pre_decrypt_find_session
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6487024362929490110=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6487024362929490110==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l1ky2twmcTc="; charset=UTF-8

--l1ky2twmcTc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2175?usp=3Demail )

Change subject: Extract tls_pr=
e_decrypt_extract_session_id and pre_decrypt_find_session
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 4: Code-Review+2
=

(2 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2175/comment/827d22e0_0bde8127?usp=3Demail :
PS4, Line 7: Extract tls_pre_d=
ecrypt_extract_session_id and pre_decrypt_find_session
The subject of the c=
ommit now no longer matches the renamed `tls_pre_decrypt_find_session`=2E

=

File src/openvpn/ssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175=
/comment/6d8fa34b_b3169334?usp=3Demail :
PS4, Line 3769:  * Read the sessio=
n form the packet buffer buf and puts it into the
Typo: "from"=2E



-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I230b3b2483e15477b179b277d=
c8f7c91c53fa0c0
Gerrit-Change-Number: 2175
Gerrit-PatchSet: 4
Gerrit-Owner:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Coj=
ocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 14:32:11 +0000
Gerrit-HasComm=
ents: Yes
Gerrit-Has-Labels: Yes

--l1ky2twmcTc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 4:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175/=
comment/827d22e0_0bde8127?usp=3Demail">Patch Set #4, Line 7:</a> <code styl=
e=3D"font-family:monospace,monospace">Extract tls_pre_decrypt_extract_sessi=
on_id and pre_decrypt_find_session</code></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">The subject of the commit now=
 no longer matches the renamed `tls_pre_decrypt_find_session`=2E</p></li></=
ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2175/comment/6d8fa34b_b3169334?usp=3Demail">Pa=
tch Set #4, Line 3769:</a> <code style=3D"font-family:monospace,monospace">=
 * Read the session form the packet buffer buf and puts it into the</code><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Typo: &quot;from&quot;=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=3Demail">change =
2175</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p=
><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link ite=
mprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2175?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I230b3b2483e15477b179b277dc8f7c91c53fa0c0 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 2175 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 14:32:11 +0000 </div>
<=
div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"di=
splay:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--l1ky2twmcTc=--


--===============6487024362929490110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6487024362929490110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6487024362929490110==--

