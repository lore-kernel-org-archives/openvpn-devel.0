Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625E8C88E53
	for <openvpn-devel@archiver.kernel.org>; Tue, 15 Sep 2026 12:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dVyqT/5HLnDfp+Cm2RvFXS6K/UKZNfu8qI1M6v0TpBs=; b=ZPyYwkEa4/G71WyR+iQXUyKnnd
	vsw7il9FDXXImxkBBMNoKm22aGRkNXzXDjGiqyBgyMpsIIYDXUQnTx3DFwAxQrWSEYYxRCAYTKflq
	GaIfVR7ZWc/heWEPOzUgzSuVdwAO0Bt/8WS3aNA02+eKvkriScsJujRsZsS99aVjobPo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6SIX-0002FJ-Va;
	Tue, 15 Sep 2026 12:30:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6SIJ-0002E0-IQ
 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:29:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=gXgYlYWL5itLuxysxcX6b4x9kRPx/rb+Tr7jeDpp1+s=; b=W+DdIq+2WeYRXjfWejiikTNL3O
 1AivLOFUL26znqfER0EL1HZ3LJjxWxM5Z2BcekZ0I/nchZnq92NHJh7R/gbCU3qTfayoyHWdxwxCG
 KTxWmXShsSVjLb39V+S/Hx4N3ZTCow4txY+KfQmTznLUmgJHq6k3D5bd7iXjeYHceArc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=gXgYlYWL5itLuxysxcX6b4x9kRPx/rb+Tr7jeDpp1+s=; b=Q
 pZSGVbhd/9Vtp21Qf9EVeBuLY8L8R9mWOeR3RocYAcLJRIoiFqg/BQueqBrjnLHM9nGgFQ4i+VSnI
 JV6V8o0bJCAUcHT7jteDuOTFnZaDFJ60GJ0rjs7/eT6HgtjgamhTdHvZ3KxLWrNgwBPCQ4FOujxqS
 PdZzkwpi4+PbeNV0=;
Received: from mail-lf2-f12.google.com ([74.125.229.204])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6SIB-0006m7-O4 for openvpn-devel@lists.sourceforge.net;
 Tue, 15 Sep 2026 12:29:44 +0000
Received: by mail-lf2-f12.google.com with SMTP id
 2adb3069b0e04-5b5e4f18010so3255307e87.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 15 Sep 2026 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789475377; x=1790080177; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gXgYlYWL5itLuxysxcX6b4x9kRPx/rb+Tr7jeDpp1+s=;
 b=MqWH1lKvKEVKqK8EdYkmGc/NOZANYOFGUPqZr/KO5MRSYxKntLxfjrabmuORuCAL1O
 NyUNsFkYQZuuMfB5XkpSX8UQHE4Vps18xMCzWczUFavbiJMRTcIvFTNPvNBra65eyPEW
 VFHr3fwjS1qm8pybfuH7rwHjoTW6tTN7tOfC5CthcCKJUUNbDReoZq7uKiDpOFWGwI29
 Yu+bPZpolUTeX6NCTYCe6+lzW/oYxMgIjFze5ZN+Hqkfar59WhJkxLhyyFuPEUO8O2h/
 czemtIHVXc/6h/hWG5zLtgIBTHYFJzaTEjZwu9CF4XcqjjB+xv2+y824iPklG4FdnCjO
 najw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789475377; x=1790080177;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gXgYlYWL5itLuxysxcX6b4x9kRPx/rb+Tr7jeDpp1+s=;
 b=NNoqOlC2vf4TkjJEb5F2HIIzyNeDYV37AjM23NUedXSUcqCXWx60egANtKxZcfuIkg
 hU2J2+jrTGyLqRkvEBlCkKLoWuinFlD14nCLvByNLvYojGG0QaBOpWAl2NQfU9km9ilN
 Q7uKeRjULtiYb9VSm9ROZcop8joPW2n9Z0OD3YvS/axAkJPZLmpUwockdWerF155PAfF
 YXPOu8w36xFooxHPUmBJv9PBDBxXL3fHo8tUzaexgxwH4FQ7LXnGRtRl6oi/bLx54z8T
 3f4KPDWe2XQ82/aZKwFFISV6+u8BYFmOgOuG/wKnVARFb9m4wuyfRsAUE0PAr+Vw5X+i
 xLSQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw+qKYrZko+eQBpz+tSlz9duXNED1Ful3G6msA7yB73wESdoSkc1c/eveXJ2rgrtU+APD0KW1o8f5SO8ZZv@lists.sourceforge.net
X-Gm-Message-State: AFuF++kaB5q36hqhHw5m4wEj+znQcuPrahXWz+xnisFeuRIjkzaKOyh1
 d6STTMtZyyySNwz0mR8J2vfe115qUQsqnjxKzWQVde5kuwQvQGckVJd7SeX4VjtlIh6hrBOao0c
 khfN1tzEJ0HsCiWcAtLxUpuFHGUrRSkkgCUQXIKdjCoOSJpOAp8XnBlCQ9ibO3uNpaBJWHUcB3a
 F23N5liA==
X-Gm-Gg: AYBFou2L0nD5ljjXYZkXcojINOck2d33C2g7Sj3VXKIeejgvRkBSrAxrKxSvG3GK4c1
 icy9TuEYnQrBs+On6wsV+OLzIjVAdCE1Taan1wl0rLkRs2RL22h9d6//rt5suzZ7k+AF20h2rRT
 /nN/aJxnWM7WddP9d+mrgVYj8ETxxGOlUFXXOIEFTdsshCsPooCQ8vxm7imWZv/OUUkLl8FB4YD
 9l88XcpZTBkUpm23oS734AW+geGoJ8JvTiNoX9MtRkpB7KFxjRJb2ebIkzgoUXuYjoKwtiqxJAf
 z6egEiuf4PHP0qrEozolJTHmRMJWFE+ALowV08GnunW1QEAtihRRBttHwDVzC3xsbuXkVyK/Vb3
 /nHwZK+3KhP63mhqLsX0mQnIoORIcSpFBBEz9ZI8V7yiyvhCnSH08s1DfXRElmi+2aiBZ6pH9Kf
 VdC2YtbT96CNlItwel17oax1T5CePtJ4mGYpbHtGZi6f9D3F+m28VaHKhz8twPPo+0TJw9smE8K
 +QH0zo7QtG3c5DlUTqLoIVvQHFueGeOt3QQPpkXf7p7IpzT9ev1PEXPkliaXAxCetBRLHmeTQEj
 IbgyC6pyJIcHHaMPlG+85AbJpyW+ntt7Bgr3jHLPYxLuiGeCItYp25hs5ugQOg==
X-Received: by 2002:a05:600c:3ba7:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49e7a68698bmr102934895e9.16.1789473658839; 
 Tue, 15 Sep 2026 05:00:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7ef88754sm63461375e9.13.2026.09.15.05.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 05:00:58 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 15 Sep 2026 12:00:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 10
X-Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
X-Gerrit-Change-Number: 30
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/30?usp=email>
X-Gerrit-Commit: 8f25090ead49b0c71eb783623d1309738e9a7b12
X-Gerrit-Comment-Date: Tue, 15 Sep 2026 12:00:56 +0000
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwYTkyNzRjYWI3ZmVmY2UzYjEzYzA1MDUyZmI5YTA3MmUwYmZhNmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b57e2fb504e76aaad8e9920a3bd06001aa8eb8e3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6SIB-0006m7-O4
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 MaxF <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============0390317412054735162=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0390317412054735162==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uxuDtwfDqEk="; charset=UTF-8

--uxuDtwfDqEk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, razvanc=2E

plais=
thos has posted comments on this change by plaisthos=2E ( http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/30?usp=3Demail )

Change subject: Implement initia=
l packet reflection protection using bloom filter
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 10:

(15 comments)

Commit=
 Message:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/51354ed6_da=
206fb0?usp=3Demail :
PS10, Line 9: When an OpenVPN server is used/tried to =
be usedc in a reflection attack
> "usedc" -> "used"
Done


http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/30/comment/c4176285_f52d1eb2?usp=3Demail :
PS10, =
Line 10: the protection with the simple --connect-freq-initial also block l=
egimitate
> "block" -> "blocks" [=E2=80=A6]
Done


http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/30/comment/31a33a1b_dd251071?usp=3Demail :
PS10, Line 11=
: client from other networks that are not attacked by a reflection attack=
=2E
> "clients"?
Acknowledged


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/3=
0/comment/1064e1d2_8fd9df9d?usp=3Demail :
PS10, Line 18: As compromoise we =
use a bloom filter to store the information=2E This data
> "compromoise" ->=
 "compromise" (maybe "a compromise"?)=2E
Done


http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/30/comment/0644e666_87c13371?usp=3Demail :
PS10, Line 26: ea=
sily be exchangable by another data structure=2E
> "exchangeable"
Done


ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/2eb11839_38014551?usp=3D=
email :
PS10, Line 28: As hash funtion SIPHASH has been chosen since it was=
 designed for this kind
> "funtion" -> "function"
Done


File src/openvpn/M=
akefile=2Eam:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/232c129=
e_bea81336?usp=3Demail :
PS8, Line 46:     b
> tabs vs spaces
Done


File s=
rc/openvpn/bloom=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment=
/70f7a256_3942ad54?usp=3Demail :
PS8, Line 8:  2022 
> Shouldn't this be 20=
24?
Done


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/0dc7e94f_62=
f4e08b?usp=3Demail :
PS8, Line 32: BLOOM_FILTER_BIT_COUNT
> BITS
Done


Fil=
e src/openvpn/bloom=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comm=
ent/83cdb58d_bc8545dd?usp=3Demail :
PS8, Line 101: /**
             :  * Ca=
lculates the number of bytes we need for storing a bloom filter of size
   =
          :  * size=2E We add + 1 to avoid rounding problems and too small =
allocation */
             : static inline
             : size_t
          =
   : bloom_get_filter_byte_count(size_t size)
             : {
            =
 :     static_assert(sizeof(bloom_counter_t) * 8 % BLOOM_FILTER_BITS_COUNT =
=3D=3D 0,
             :                   "bloom_counter_t must be a multi=
ple of BLOOM_FILTER_BIT_COUNT");
             : 
             :     return =
size * sizeof(bloom_counter_t)/BLOOM_FILTER_BITS_COUNT + 1;
             : =
}
> I'm really confused by what size means here=2E [=E2=80=A6]
Yeah=2E I al=
so think that the calculation was wrong I fixed that=2E


http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/30/comment/29bc0ff4_0b65c478?usp=3Demail :
PS8, Li=
ne 115: static inline
             : size_t
             : bloom_get_filter=
_bit_offset(size_t bucket)
             : {
             :     return (buck=
et * BLOOM_FILTER_BITS_COUNT) % sizeof(bloom_counter_t);
             : }
>=
 If this is a bit offset, don't we need 8 * sizeof(bloom_counter_t) here?
D=
one


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/030c812c_7f88cbb=
c?usp=3Demail :
PS8, Line 122: static inline
             : size_t
        =
     : bloom_get_filter_array_index(size_t bucket)
             : {
       =
      :     return (bucket * BLOOM_FILTER_BITS_COUNT) / sizeof(bloom_counte=
r_t);
             : }
> This seems wrong to me=2E Every bucket is 2 bits w=
ide=2E [=E2=80=A6]
You are correct=2E I forgot the translation  of bloom_co=
unter_t to bytes=2E


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/=
08ce5d7d_01f2f7e0?usp=3Demail :
PS8, Line 172:     
> whitespace
Done


Fil=
e src/openvpn/reflect_filter=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/30/comment/6fa0024d_0c16878c?usp=3Demail :
PS8, Line 43: static bool
    =
        : reflect_filter_rate_l
> Remove empty line
Done


http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/30/comment/4f9db450_35e4dab3?usp=3Demail :
PS8, L=
ine 116:    /* we keep the count in the key instead of in the bloom filter =
table as
             :      * can then keep the counter in the bloom filte=
r itself small (2 bits)
> =2E=2E=2Eas we can then=2E=2E=2E
Done



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a07=
2e0bfa6b9
Gerrit-Change-Number: 30
Gerrit-PatchSet: 10
Gerrit-Owner: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: MaxF <max@max-fillinger=
=2Enet>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc =
<razvanc@mailbox=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention:=
 MaxF <max@max-fillinger=2Enet>
Gerrit-Comment-Date: Tue, 15 Sep 2026 12:00=
:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To=
: razvanc <razvanc@mailbox=2Eorg>
Comment-In-Reply-To: MaxF <max@max-fillin=
ger=2Enet>

--uxuDtwfDqEk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: MaxF, flichtenheld, razvanc=2E </p>
<p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail">View Change</a></p><=
p>15 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none=
; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/=
comment/51354ed6_da206fb0?usp=3Demail">Patch Set #10, Line 9:</a> <code sty=
le=3D"font-family:monospace,monospace">When an OpenVPN server is used/tried=
 to be usedc in a reflection attack</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;usedc&quot;=
 -&gt; &quot;used&quot;</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/c4176285_f52d1eb2?usp=3Demai=
l">Patch Set #10, Line 10:</a> <code style=3D"font-family:monospace,monospa=
ce">the protection with the simple --connect-freq-initial also block legimi=
tate</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin:=
 10px 0; padding: 0 10px;">&quot;block&quot; -&gt; &quot;blocks&quot; [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/30/comment/31a33a1b_dd251071?usp=3Demail">Patch Set #10=
, Line 11:</a> <code style=3D"font-family:monospace,monospace">client from =
other networks that are not attacked by a reflection attack=2E</code></p><p=
><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;">&quot;clients&quot;?</blockquote></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/1064e1d2_8fd9=
df9d?usp=3Demail">Patch Set #10, Line 18:</a> <code style=3D"font-family:mo=
nospace,monospace">As compromoise we use a bloom filter to store the inform=
ation=2E This data</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">&quot;compromoise&quot; -&gt; &quo=
t;compromise&quot; (maybe &quot;a compromise&quot;?)=2E</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comm=
ent/0644e666_87c13371?usp=3Demail">Patch Set #10, Line 26:</a> <code style=
=3D"font-family:monospace,monospace">easily be exchangable by another data =
structure=2E</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">&quot;exchangeable&quot;</blockquote></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/=
comment/2eb11839_38014551?usp=3Demail">Patch Set #10, Line 28:</a> <code st=
yle=3D"font-family:monospace,monospace">As hash funtion SIPHASH has been ch=
osen since it was designed for this kind</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;funtio=
n&quot; -&gt; &quot;function&quot;</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li>=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/Makefile=2Eam:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/30/comment/232c129e_bea81336?usp=3Demail">Patch S=
et #8, Line 46:</a> <code style=3D"font-family:monospace,monospace">    b</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">tabs vs spaces</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/bloom=2Eh:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/30/comment/70f7a256_3942ad54?usp=3Demail">Patch Set =
#8, Line 8:</a> <code style=3D"font-family:monospace,monospace"> 2022 </cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">Shouldn&#39;t this be 2024?</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/0dc7e9=
4f_62f4e08b?usp=3Demail">Patch Set #8, Line 32:</a> <code style=3D"font-fam=
ily:monospace,monospace">BLOOM_FILTER_BIT_COUNT</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">BITS<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/bloom=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/83=
cdb58d_bc8545dd?usp=3Demail">Patch Set #8, Line 101:</a> </p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">/**<br> * Calculates the number of bytes we need for storing a =
bloom filter of size<br> * size=2E We add + 1 to avoid rounding problems an=
d too small allocation */<br>static inline<br>size_t<br>bloom_get_filter_by=
te_count(size_t size)<br>{<br>    static_assert(sizeof(bloom_counter_t) * 8=
 % BLOOM_FILTER_BITS_COUNT =3D=3D 0,<br>                  &quot;bloom_count=
er_t must be a multiple of BLOOM_FILTER_BIT_COUNT&quot;);<br><br>    return=
 size * sizeof(bloom_counter_t)/BLOOM_FILTER_BITS_COUNT + 1;<br>}<br></pre>=
</blockquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margi=
n: 10px 0; padding: 0 10px;">I&#39;m really confused by what size means her=
e=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Yeah=2E I also think that the calculation=
 was wrong I fixed that=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/30/comment/29bc0ff4_0b65c478?usp=3Demail">Patch Set #8, =
Line 115:</a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;"><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">static inline<br>size_t<br>bloo=
m_get_filter_bit_offset(size_t bucket)<br>{<br>    return (bucket * BLOOM_F=
ILTER_BITS_COUNT) % sizeof(bloom_counter_t);<br>}<br></pre></blockquote></p=
><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddi=
ng: 0 10px;">If this is a bit offset, don&#39;t we need 8 * sizeof(bloom_co=
unter_t) here?</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/30/comment/030c812c_7f88cbbc?usp=3Demail">Patc=
h Set #8, Line 122:</a> </p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;"><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">static inline<br>size=
_t<br>bloom_get_filter_array_index(size_t bucket)<br>{<br>    return (bucke=
t * BLOOM_FILTER_BITS_COUNT) / sizeof(bloom_counter_t);<br>}<br></pre></blo=
ckquote></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10=
px 0; padding: 0 10px;">This seems wrong to me=2E Every bucket is 2 bits wi=
de=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">You are correct=2E I forgot the translat=
ion  of bloom_counter_t to bytes=2E</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/30/comment/08ce5d7d_01f2f7e0?usp=3Demail">Patch S=
et #8, Line 172:</a> <code style=3D"font-family:monospace,monospace">    </=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">whitespace</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/reflect_filter=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/30/comment/6fa0024d_0c16878c?usp=3Demail">Pat=
ch Set #8, Line 43:</a> </p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;"><pre class=3D"blocks" style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">static bool<br>reflec=
t_filter_rate_l<br></pre></blockquote></p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Remove empty line</bl=
ockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/30/comment/4f9db450_35e4dab3?usp=3Demail">Patch Set #8, Line 116:<=
/a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;"><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">   /* we keep the count in the key instea=
d of in the bloom filter table as<br>     * can then keep the counter in th=
e bloom filter itself small (2 bits)<br></pre></blockquote></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
=2E=2E=2Eas we can then=2E=2E=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
/ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
30?usp=3Demail">change 30</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail=
">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/30?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 30 </div>
<div style=3D"displa=
y:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Own=
er: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: razvanc &lt;ra=
zvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: MaxF &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Tue, 15 Sep 2026 12:00:56 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-=
To: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Comment-In-Reply-To: MaxF &lt;max@max-fillinger=2Enet&gt; </div>

</body=
></html>
--uxuDtwfDqEk=--


--===============0390317412054735162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0390317412054735162==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0390317412054735162==--

