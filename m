Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4D3606A32A
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b28zOfqp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dTP/hJ03;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RPYKi/vl;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BL25D9vm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V1K/MSojAyep5km3T4LlDnGBE2+PrsMJ6L4H9rqT1g4=; b=b28zOfqppW+cArP6CSoCo4sSWX
	pajlfZKnutE8NsNW+O3CpAislYEOxpuXa/k/WKML3GD9k3a7WywdcJT4HtlCb+E6VVlvtNqkGUEZ4
	lK9h5GPDJMBGeGMtPEfdELG9hkAxxdC+eq0Sjk/EH/eq7rlL6kpWkHDKK1FlbiJL59FU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRYLw-000000005IR-22Si;
	Thu, 12 Nov 2026 17:12:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRYLv-000000005IJ-1Owg
 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aWW4KM4dP4IaLtIY3rvRk+cE6yE7q1wksy33nGJzPPE=; b=dTP/hJ03z+TjU265elpyDeJ/6q
 tp/xC4S7uFkI0DAg9OOezaQQoHWfD3qHkV1xl2eB7ElfJCUVfqG6wBInn2O6q1L/68SdkdTq07crF
 75aGlYt2KAWH2IdHwavYcCtlPP1ZT9ct1wWDXVnTpagVq3DSr9yWAcw+8uieYT/dKVYs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aWW4KM4dP4IaLtIY3rvRk+cE6yE7q1wksy33nGJzPPE=; b=RPYKi/vlqSckDa4hUl2PIVds/5
 BGNNcsmfaa51/k1chAO/q9xO4o+7cMmgMp1YuOqh6myhTLAa+Kl7p/NLp1VXHKQ8ZbYNHEYC3KK8S
 OwNnnk9W5tQfHcMrZkdvkv3k6NbHBhUageJQ7dTaFYDAMZCeFOk6N5FBBhNBhIS+InCE=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRYLt-000000002y4-2wyG for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 17:12:47 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a20a37703bso202825e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 09:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794503559; x=1795108359; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aWW4KM4dP4IaLtIY3rvRk+cE6yE7q1wksy33nGJzPPE=;
 b=BL25D9vmo14BptQNzgk9h3VUpu4ff6P2b+eSZ1skYsb3Bbv7p5jCU1WSXu6CbHDq2G
 vDTXk+DVjUI0bbDVHc1DxEJkPj9RY9e1aCtG6F2FLBvnwIqMmx0rsFgKKg/6OGBFx20t
 UJzZpE92fBJqASVxSzDUto0FlCPf8jgE69X8hRWp7ZcdfFYNggqivWDBSJfaKi1ma5y1
 x2mlACQ6mXn77VId6SEgR3WtFX3jqVhd85QyYIjMiJO82hpJIjHskATA9aXt68HllXrr
 /OCty7JD4pG4y+uumfmMRC+liIHC38Y2mKT3xl91moVHxSeaj/POLnwv1W+et8cA8T2k
 xPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794503559; x=1795108359;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aWW4KM4dP4IaLtIY3rvRk+cE6yE7q1wksy33nGJzPPE=;
 b=GiWacweBhGdt7H6iDpU1H3qHy+5mVUXsyC3xgEjnUGK1F2TnFQ0C6kdFgudhuruHJL
 Gu2BMgx84eNRcusFSyJ08GcfzEUOUshbQX9WV9sI4eL6VctqZdDAisidnTJ5uPWrO/Ob
 6LqyxumbBk0XPWplLaRdMxY6Yos17h6F9Td0E9CQNZEpJWO3Lqdvar+9hqt//W5Dse17
 Rv9vw1P36zRM9TtkSr26tyF7UMXdG4vjb9UzLOLmVlJWin8/9I5FK6NOUmh2Pi6c35JG
 wTfg0ryHeV+foINF0hlVzmpuhw45nwtKpb0SrlatKouES8jVdSc3839FoSgE1bb96UnC
 1kLw==
X-Forwarded-Encrypted: i=1;
 AL+hErFR3c+7RvQUaFHFYVl2Kd3Q1fF6XWzs367YVTEkZZRf9ZAYclvoZgk0o6POja83zAHHen/1ZGucH61SxVg1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/4tq0dhOM/nmhaxczlm0YA28Qjr7mUzxOwhxDq7ZLUBc0YQgs8
 fE6RP6ZHE9MibxW67azUreNDlVIpom7CGtsf1jJAJmJ4RKCmup7/8bEkgabv5Xz2/gRc5YrP2dp
 5K3p+RGhhk5PZ7xLa+/k5M2kznzpg7WKsGC+yrD2h96ns8I2aHM2C8RPdUMp+CpWkAHAEPDewAf
 MIRahOcQ==
X-Gm-Gg: AYBFou12MeM2XOfN4W8AIQe4rwmpCrYElOIZm4sFOs5BG3bG2aLvL7hy5ye7QH0ntGN
 n+L9H6e/uar2e16/zyLytg+TdTCjQrSZcRH/m17T7LnxtOvo43dklzaXKVA81/N864Oz8IKLHjq
 FA+kdHAzqz25zAdquYlOvXN7R40NDNdO976l08+UEppunMl9BCxeTtorWpHNNMGJ44ap8lGci7m
 B/aBBPiZrifeL6Brf3wH3y4qVcIwF5Xjt2bwhk8olP4vuAnH7Qf2/FUX6FfqUq7WJ2npF0PF7T1
 GzGu6Me6jK3b3hpMp8179AN/ih8WjFI/ikAi9BGHOEDWY6YrQ04jRliJB/FMpAr9YACMzKFELb8
 bVS8WX805ZlOAeeZuuTv0hBs4kWbar0n7xBE/wEMYyS/A7R1GBFdjL9ITBFkEGztJJKHvMi0sNV
 NUFLK/Ldm2mTExQV5n24gBopAOHkLYwj+WbGvQ6K+tER1Y9wGoWvu3dlSt2TNAzi8vkw9yw8lcB
 EHeu4bXdz8OrMtWg9VUcHD5+bVt+8so0ANH1GUI8hDzQk3CaD3Zmfg49nUDshJtIoHDsZVxIUm5
 Es9QUeWAozCg8CBjIlO4pd8p75sSWAPZunZjCDxI5SlWBcp+oWI0ekIGEwvEKjwM3umf7QOysNZ
 ty/EsMCk9mNkrS7VMD7rSS8OQY2EW/08JP55MLvnFl+dGUyIZW6SVKzTcJ4wDeM/c8rbjm1MPDS
 ZPEWtpb27eq4JVq6k=
X-Received: by 2002:a05:600c:4e92:b0:4bb:53d5:8263 with SMTP id
 5b1f17b1804b1-4bb53d582b3mr30178275e9.8.1794503558813; 
 Thu, 12 Nov 2026 09:12:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5d03b10fsm450906f8f.1.2026.11.12.09.12.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 09:12:38 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 12 Nov 2026 17:12:36 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
X-Gerrit-Change-Number: 1186
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1186?usp=email>
X-Gerrit-Commit: 08b1138c60a189639ecbb7b4700c5e60c4ce2e2f
X-Gerrit-Comment-Date: Thu, 12 Nov 2026 17:12:36 +0000
In-Reply-To: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
References: <gerrit.1757937905000.Iecf502ec811e99c56647b2d45298fa0fb66960fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzU3OTM3OTA1MDAwLkllY2Y1MDJlYzgxMWU5OWM1NjY0N2IyZDQ1Mjk4ZmEwZmI2Njk2MGZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b6961543b2d90c2e5a27cc38482c4a0ed1f8b739-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRYLt-000000002y4-2wyG
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Enable
 -Wsign-conversion
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7652268677738219013=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7652268677738219013==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wBq/aWJBwlE="; charset=UTF-8

--wBq/aWJBwlE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Frank Lichtenheld has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail )

Change=
 subject: Enable -Wsign-conversion
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 20:

(3 comments)

File src/openvpn/buffe=
r=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186/comment/109b7718_77=
1bb541?usp=3Demail :
PS19, Line 741: #endif
> Is this ever popped? If it is=
, I can't find it=2E
Done


File src/openvpn/ssl_verify=2Ec:

https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1186/comment/321efdb3_e0b6dcd0?usp=3Demail :
=
PS19, Line 899: #endif
> This doesn't appear to be popped anywhere=2E
Done
=


File src/openvpn/tun=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/118=
6/comment/cd6ac4da_bde03fed?usp=3Demail :
PS19, Line 2294: #endif
> This do=
esn't seem to have a corresponding pop=2E
Done



-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb
Ger=
rit-Change-Number: 1186
Gerrit-PatchSet: 20
Gerrit-Owner: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 12 Nov 2026=
 17:12:36 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Re=
ply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>

--wBq/aWJBwlE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Frank L=
ichtenheld has posted comments on this change by Frank Lichtenheld=2E</p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail">Vi=
ew Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/buffer=2Ec:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1186/comment/109b7718_771bb541?usp=3Demail">Pa=
tch Set #19, Line 741:</a> <code style=3D"font-family:monospace,monospace">=
#endif</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">Is this ever popped? If it is, I can&#39;t fin=
d it=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/ssl_verify=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1186/comment/321efdb3_e0b6dcd0?usp=3Demail">Patch Set #19, Line 899:</a> <=
code style=3D"font-family:monospace,monospace">#endif</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>This doesn&#39;t appear to be popped anywhere=2E</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tu=
n=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186/comment/cd6ac4da_bde03fed?usp=3De=
mail">Patch Set #19, Line 2294:</a> <code style=3D"font-family:monospace,mo=
nospace">#endif</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">This doesn&#39;t seem to have a corre=
sponding pop=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1186?usp=3Demail"=
>change 1186</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/11=
86?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div s=
tyle=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display=
:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Ch=
ange-Id: Iecf502ec811e99c56647b2d45298fa0fb66960fb </div>
<div style=3D"dis=
play:none"> Gerrit-Change-Number: 1186 </div>
<div style=3D"display:none"> =
Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;r=
azvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ope=
nvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Thu, 12 Nov 2026 17:12:36 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply=
-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></ht=
ml>
--wBq/aWJBwlE=--


--===============7652268677738219013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7652268677738219013==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7652268677738219013==--

