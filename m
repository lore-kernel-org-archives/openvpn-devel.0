Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31AEC88E72
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 07:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sbte4AN8X2JO+UdbmbO+zc8x9oLDaYn6CHAV6jzSOcM=; b=lXnErdo4wYmIRS37Ec5XthY2wJ
	QrVN+LEU28bH8K5yX8ovSLzD/UUqfG2dJ1s4aDOleHwgZLfSu/KjZlzRChz7KZJuL/s63V+btNbdz
	TmqG2ZaUkPjYkrob62l03Md8BANpOrsznzUSphDpRnGEDLrdaakokLyZhZv+a/SGha9M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x76lS-0006Nf-Kb;
	Thu, 17 Sep 2026 07:42:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x76lR-0006NM-BV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:42:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=74CXxMROK7M43V6urk2b+9h2RsmFArYDxJpKyeb/wOE=; b=m5gtDoWu4I+hiwh3GpCWf3ilj4
 UPiZhOAwVvHaLYDRqZWicqzzHAKO8EVXn5oCW5f2QtkYibOl8FzIwCuVTDANO1PVUqfjKN1hDAgvU
 1GtueBiRUAHmtNZE5sCAIGcm4s7w51exjFmtqu8a0BNLBwfTZQ+SSb3GTEeDk0DvX7d8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=74CXxMROK7M43V6urk2b+9h2RsmFArYDxJpKyeb/wOE=; b=c
 O04ZkQEqSfJb5cAkasG89Al6OYnz03AGTJOdNzaswMuif/ZRdBdTQSSjPEZg/NYFoYPqUaA3+aSnT
 mrbfZM9vxeLmo7boegnt1T7HEVV0Ky3IDT3BeET2dd/fs7GB4FosVjUR5WgzAqwr6a7hpo5eV1i4K
 xXry/yPlm0JBG2Wo=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x76lN-0004hT-Mn for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 07:42:37 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4843c2790ccso292001f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 00:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789630947; x=1790235747; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=74CXxMROK7M43V6urk2b+9h2RsmFArYDxJpKyeb/wOE=;
 b=R25yZVhf3unkKpsUKenvUlQ5wRP3mcFi6xpsVOcMruhSmTKpdtBE5CjML8a9a3RORf
 f7TAqhy33lzF5eauuAzXvAI/h5122rJerNRZ4L/bFenxGv9KgKxDn1GVLvwit2yo3wPJ
 VCd462R1n2mBRvGsGIqSzAnI0BmNCuzN8YhcLTqlDvc3KgQ4P7Dky50SU2iYm5wikNTS
 ZuTNnElY3dwfbLGnQ04B3DWc7fYZG95wC3fAqapcGjqJktJThdhJON+aLLRKZKPELwcr
 c5gsZT8pbR3St1Je8SMYJX2Aa56+2987f9/0bqe5t16FMx2VU0PsBYPQr3LwhGe0tvfZ
 NLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789630947; x=1790235747;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=74CXxMROK7M43V6urk2b+9h2RsmFArYDxJpKyeb/wOE=;
 b=aT+mZaA/doxrwhE5UBttWIGCmqVuc1Pz0tn+orO7/VtV8XLGvC6Da23XLgWucbuvjM
 hARtGiE2DBEqdAeSCrcQ9jMvNYuNdw/9S8LH3xiDPZqSrmoLCDWEitqbSxDYBbTkGy/i
 K3XRlxdTS9NtEfEQ07gzCKLQJYiiKTE3JkS1T83em34vIONG4eB7KK92H1Hzs2ToPh7x
 lFSAXJj1p6qBRtll+zY3df3p4S219Y/t/Gfx4ateZheOTRR4L3iC7TN1keBjRVN7aBO8
 PI60+NUQ7K5W99T2fnYsCr72UW4U8NvYdYV1evupPq1AiSHB/AqfuajoGMHojgtxloJ3
 tULA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzAYINPdhE9lh6hQsIKy/PtmL3l643O5IFv/FVal5BRy6Xw7kHCpHnJbFQuGoEqSYJQIBTBHpkMKQViW4sN@lists.sourceforge.net
X-Gm-Message-State: AFuF++nc/5cS83Fi3XRLXziJhHXX6YE1R3C5k5VXOCLfztalDbpOGq0d
 BlyxUePO5epVJsV9XywRbyCkLS0fpU02Z9ZMEQfKFienHJR2+n6dO5yj9LXpTyrXJXOzz3nMCxb
 ZaPln0fR5FqRAgLefHrnCYWqfGo+vG7Kn+upZg3alyULCAilVDlIwc5/PnckmcQlShjB1
X-Gm-Gg: AYBFou0fiew3Nqt4TzIag5D0+IiKBjw8K/ZxlSJV3Y22f6G8FLZk+S5Gi5Hy6dRW4ry
 OL/OP4Ld1+XBk3FbaxLHWg9+dZ9mLNxmYZiTwpu7IlPRFe3qcIOXpveTdSvQGCjfnzNa92jpIZ0
 od5CZQjGpSGVaEW7LxP5kHZO1EadWXBUa82FZKo5b/JPuzIRv/3clSbnZiOd544eUaK9LZsPlMi
 jpQcJoaw9dKjqQQi42bJ873K9Zq/T6mcQHAC+UjqVjRxmy3yLu+LQhFb7mtIHZE3MxU1xkQtCBd
 lbrhuS9FWVdKW6V9ac0PnkHbg+VnhY3qbFLGZOhsrfPRKEJs6X4xehsg+gz8TdtRWKeZ8o1UGUF
 6Bz6DHtvIt8hJhDVkdHV20vRklUr9VSqVaCTY5vNZgcWnagc7o+zrokIeIIqV5mr8Ca4yo7YR7A
 ox6BH//8/A4AEXSSxeySqymgDmoUlXKob+d15aHB90BB2/6QUTYYoa4LDj0/R6w3Z8ZyuzYYywU
 HCyvGt6dWKQysKMtneCTHBEa4iY+vMqL3Uu6jEmQFY9IC2dF11UQD9+nMhvgTpEmUQxLNSW0w14
 vkddUCFKNP6apts7TG3cvk4140ntUKOpiauPj+WzzH4Gxv9XH90CcoXTUWKuGQ==
X-Received: by 2002:a05:6000:41c7:b0:487:403:84f1 with SMTP id
 ffacd0b85a97d-4870cee9015mr14619348f8f.9.1789630946988; 
 Thu, 17 Sep 2026 00:42:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf2797csm12644326f8f.16.2026.09.17.00.42.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 00:42:26 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 07:42:23 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 5b1e911f450ab09703cf02f50846d58bf66fbaeb
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 07:42:23 +0000
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <20a8915d222d5664290050550a37e3d1bd217e59-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x76lN-0004hT-Mn
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add control
 message TLV encoding (P_CONTROL_OOB_V1)
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8766379567450698174=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8766379567450698174==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CYSBQ2Ll/Dw="; charset=UTF-8

--CYSBQ2Ll/Dw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1741?usp=3Demail )

Change subject: oob: Add contro=
l message TLV encoding (P_CONTROL_OOB_V1)
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 16:

(3 comments)

File src/openvpn=
/control_msg=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/6=
e0dd0ad_3afb4251?usp=3Demail :
PS15, Line 77:             /* bytes remain b=
ut too few for a header: truncated */
> Which bytes remain here? Didn't ctr=
l_msg_tlv_read_header read all of the availabe ones?
The header needs 4 byt=
es, if fewer are left the message is truncated=2E Comment amended=2E


http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/1b53219a_6d3f5abe?usp=3D=
email :
PS15, Line 97:         {
> So this API design forces us to rewrite =
the parsing once we have a message that has two TLV and one  [=E2=80=A6]
Ye=
p, the API only handles messages with one mandatory TLV, which is every OOB=
 message so far=2E Fixed the doxygen to say it clearly=2E Extending the sca=
n can wait until we add a message with more than one=2E


File src/openvpn/=
ssl_pkt=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/382b0d=
88_c0e1ced9?usp=3Demail :
PS8, Line 70: #define P_CONTROL_OOB_V1 12
> You d=
id not really address the comment=2E [=E2=80=A6]
Dropped opcode_valid_in_se=
ssion() and the "session" wording=2E P_LAST_OPCODE is the highest defined o=
pcode again, and the OOB opcodes are excluded by name, || opcode_is_oob(op)=
, not by position in the range=2E So when CONTROL_DATA_V1 arrives, P_LAST_O=
PCODE becomes 14 and nothing else has to change; 12 and 13 stay out of  tls=
_pre_decrypt()=2E

Why they have to stay out: tls_pre_decrypt() starts by p=
arsing the reliability header (ACK array, packet id), and an OOB packet has=
 none, so its TLV bytes would be read as ACKs=2E CLIENT_RESET_V2 does carry=
 that header, which is the difference between the two=2E Nothing on that pa=
th handles an OOB payload either, so there is nothing to gain by letting it=
 in=2E Answering probes on an established connection would need its own dis=
patch before the ACK parsing plus a rate limit, so I would do that as a fol=
low-up=2E write_control_auth(), which writes the header, gets the matching =
ASSERT=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
741?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302a=
c57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet=
: 16
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenh=
eld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: ope=
nvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-=
Comment-Date: Thu, 17 Sep 2026 07:42:23 +0000
Gerrit-HasComments: Yes
Gerri=
t-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@rfc2549=2Eorg=
>
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--CYSBQ2Ll/Dw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change=
</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/control_msg=2Ec:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1741/comment/6e0dd0ad_3afb4251?usp=3Demail">Patch Se=
t #15, Line 77:</a> <code style=3D"font-family:monospace,monospace">       =
     /* bytes remain but too few for a header: truncated */</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">Which bytes remain here? Didn&#39;t ctrl_msg_tlv_read_header read al=
l of the availabe ones?</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">The header needs 4 bytes, if fewer=
 are left the message is truncated=2E Comment amended=2E</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/1b53219a_6d3f5=
abe?usp=3Demail">Patch Set #15, Line 97:</a> <code style=3D"font-family:mon=
ospace,monospace">        {</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">So this API design forces=
 us to rewrite the parsing once we have a message that has two TLV and one =
 [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Yep, the API only handles messages with one m=
andatory TLV, which is every OOB message so far=2E Fixed the doxygen to say=
 it clearly=2E Extending the scan can wait until we add a message with more=
 than one=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/ssl_pkt=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741/comment/382b0d8=
8_c0e1ced9?usp=3Demail">Patch Set #8, Line 70:</a> <code style=3D"font-fami=
ly:monospace,monospace">#define P_CONTROL_OOB_V1 12</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Y=
ou did not really address the comment=2E [=E2=80=A6]</blockquote></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Dropp=
ed opcode_valid_in_session() and the &quot;session&quot; wording=2E P_LAST_=
OPCODE is the highest defined opcode again, and the OOB opcodes are exclude=
d by name, || opcode_is_oob(op), not by position in the range=2E So when CO=
NTROL_DATA_V1 arrives, P_LAST_OPCODE becomes 14 and nothing else has to cha=
nge; 12 and 13 stay out of  tls_pre_decrypt()=2E</p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Why they have to stay =
out: tls_pre_decrypt() starts by parsing the reliability header (ACK array,=
 packet id), and an OOB packet has none, so its TLV bytes would be read as =
ACKs=2E CLIENT_RESET_V2 does carry that header, which is the difference bet=
ween the two=2E Nothing on that path handles an OOB payload either, so ther=
e is nothing to gain by letting it in=2E Answering probes on an established=
 connection would need its own dispatch before the ACK parsing plus a rate =
limit, so I would do that as a follow-up=2E write_control_auth(), which wri=
tes the header, gets the matching ASSERT=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3De=
mail">change 1741</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: st=
ipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eo=
rg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Thu, 17 Sep 2026 07:42:23 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@gmail=2Ecom&gt;=
 </div>

</body></html>
--CYSBQ2Ll/Dw=--


--===============8766379567450698174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8766379567450698174==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8766379567450698174==--

