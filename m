Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBD1606A32D
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Mnkvegsx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gLbvB+pB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lA5NYJKg;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=BbtncJad
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=49gysk90OeDRzxLShNbaaHvUfmj7W4XTtbFuoK/pPiU=; b=Mnkvegsx/S7IUvRiDkJUq1uiEn
	pbb5msVvASKzYZAA5xCP9pjTN1vkTlBBC1dnkAQ3xW77zPYGxSl4Mj6zM3trL1Cs8BhTnG1DLTV9Z
	6/PldJx/iizBwGUvcOkIU3eHEOotb/HKG4QybkO8/o8Og3dLtXSP26Zi2NEQA8DgwSI4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPHrV-000000005MH-1kDw;
	Fri, 06 Nov 2026 11:12:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPHrU-000000005M5-1axS
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:12:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GERWtUShrF76dqE1c21fcBXT9gnNndvU8LbCkl4h6wQ=; b=gLbvB+pBPeXGgytMT4PWJflnSq
 f2ce/1mtaZxianBpPh8eZI4jiBpjMCRbr84nxdxQfPqAsyIsvlosIYoAR4AYx1QSgVlc/vgXzHrLg
 oQEejbEvAMJ4PaJRoy+gyRDXYXKypPcbUzCbGXpAPBybC/9kjFYnYNVWzLIM+djFyQ/o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GERWtUShrF76dqE1c21fcBXT9gnNndvU8LbCkl4h6wQ=; b=lA5NYJKgzIMGTI1occfi/eoYlI
 zkJtXbfQ0zideVxnA6RYQaCHbintXVW2l6qxU4MkWfhg9MGearlvqQvv3+pQachR+ZsZTQp05iGLA
 NyQHTYxdwJt+bObiil9xTstN+W0y71+MVlw8uR5RjfY9JxaCbNxQ8SD8d/0vaemXOxJo=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPHrS-000000003Z6-27lu for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:12:00 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso214777f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793963512; x=1794568312; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GERWtUShrF76dqE1c21fcBXT9gnNndvU8LbCkl4h6wQ=;
 b=BbtncJad+j3QaQT+QjrQUCkiu1xK79xLicP9ZXuD3kUXfy4kBd4UPmVsNa0w9CHrTD
 fOG+NBZkRUQ2xBq2zL75MgP0Mae+4jBvMtuvxzOHjJdNmcsH8kQAKGMx3RhAn/NYA4Y2
 QRnYC7NBZLPs4iKYyhW1UOferOyQqM5sSIxR/uRQk710baYVke/lAWVLIMMi16leOYYT
 7AGlD5uu9Rg5Mxrnm8B4xn583UDwotJq3RXHJRX5y61sD/l6HhSfM0al0nsXmtehCnoV
 D47ccXsoHZudq7uwGMFLm5AoTjbwttYESAHS7nHIcchkrXGRycQzn7tf+LdI7WQgLcu3
 CJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793963512; x=1794568312;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=GERWtUShrF76dqE1c21fcBXT9gnNndvU8LbCkl4h6wQ=;
 b=YLz6O2WCJBGUD1+8xd2nDwnncwqUNtTBJ5KfXylbbCDeomV6SBMPmk/LavlHsaWIH9
 bYWKh2DKc4ES7LkpPRkChuFhKlX0tb3Mxb7okqqeBSpMGdvD4Ia3N1yRXb2arSa7qVV/
 IRqOzoCDAAiV+hVc/mxi8XgGxwoG7TU9+q94y7X/4rb1cEtizOUNKSjYUwji4ZDtKNYc
 8XHN1VG7eGfoblcGpdQtu0oCSL8J8ZJWYnXCjW+ZSWnGxGq5XsXRcYUWq9JAZ5MIxHI1
 nk02ucYFr/HmFksVitY3Di7/ZzAJXLxf7RoRNlNa0zED1G5K8d4LzuRjcCZvbRcwFOwp
 CorA==
X-Forwarded-Encrypted: i=1;
 AL+hErEmEZZe/RDQDZhj1dcczGu6+gP14mIQKopIhxdpIgmZLLWnx1zhPi6puWSwzbxjZrzd2hVcvfWyb/WRYTg6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9IQbvunpt55cFArt2bvyD/YMZ3xLp48Ro5TgyX6yLpI2wGYqD0
 EF6hvC6a6BEVKFmin8eIOmvKKmf4xJyDQv2yd7sT0UHEMq7CFyigPMNV6oBL6/po5IgA5fXTqwA
 Hu7bASqeKjRDJGLHNtN3lovPuV2qfX+HQViIkqImPa6Tj0erWNcjS2lEiA4eiqWuxzVIIgTY7Ub
 A53oe0sw==
X-Gm-Gg: AYBFou2G1QijBoc5gBFN3Vi62YDn6QwJSDqRwT/76s2SCf9zqW3Pe9sZ50Bl3DiZ2IX
 fqdTcy7ZxyKziOOInHg1aAY3dQOwN/fwkRL2VB2og6pIAnguudQVeeiSDy/zAeBtaqYeum0lFx9
 XA3oMIAkRu2MzjQzoHcYLoEmTuNBhqqNUiNuvUWT2BDwM3fdAwm2mVgwaiamlo+L92hyZSRtjXT
 YJjA0Jsj7XvfheB80B9XbCnCzeI5Wc46oLw2PqbsuUEadF59jQl1RyuJhN19gudcMrMUC767ILB
 MpXKBa6mT8T1HcW8igXK78lTEmwpvKgxbnT13j0oPgHnqujdM15Qaj7MgUJTh4rMOmYhhcd/snA
 RTDhkDugBP0Hylbya/GtPReCu1MoJsM2EZuwcHuCfI2wbmNH8d+GH96z5XZ1UyLMW1yMMtgvsCl
 IJhbxhS+qmgFEi1xqXA3wiMgsbro6idTABWj+L8Fx47ND/6nXpPdER9rUdaCffbVIfGVNm8VlNP
 MKtmOqMgNXEG/FqZ4TtZNI6nsx12q7YfUTyknCsy4dPhrqdXntNDaBytuZ2J5RIGC1NbKQFvQZg
 crm4JGc0C8ulSJEqZAJNfVUBIirHavQMtll0gQnei/0XupPt51VVP+u5ip3nZo4gNjo+t0gcx5h
 aFB4uWOdoGz5rJpOV6a6bJmVkzMPycnVQ0QEgvs2JjvLb/9PIg5yqGR4WwI5Ff0IlUlxnsVGGyO
 9SmKV7xlmZizkEb2r1NxcQb82FcCcu5sqat+c=
X-Received: by 2002:a05:6000:15da:b0:487:40d:af29 with SMTP id
 ffacd0b85a97d-492778d1b34mr3246726f8f.36.1793963510721; 
 Fri, 06 Nov 2026 03:11:50 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-492d7701cf9sm2675960f8f.39.2026.11.06.03.11.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:11:50 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:11:48 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
X-Gerrit-Change-Number: 30
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/30?usp=email>
X-Gerrit-Commit: 041f266f134ebc625810c269c2749f5571cca225
X-Gerrit-Comment-Date: Fri, 6 Nov 2026 11:11:48 +0000
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwYTkyNzRjYWI3ZmVmY2UzYjEzYzA1MDUyZmI5YTA3MmUwYmZhNmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e6068efe62c3c24219c0c43522d5ec54d773f12a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xPHrS-000000003Z6-27lu
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Max Fillinger <max@max-fillinger.net>
Content-Type: multipart/mixed; boundary="===============9160364874455357217=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9160364874455357217==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lQ7qW/JdbDA="; charset=UTF-8

--lQ7qW/JdbDA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Max Fillinger, R=
=C4=83zvan Cojocaru=2E

Arne Schwabe has posted comments on this change by =
Arne Schwabe=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail=
 )

Change subject: Implement initial packet reflection protection using bl=
oom filter
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 11: Code-Review-1

(17 comments)

Patchset:

PS11: 
I addressed t=
he comments but did not test this again=2E We have to see when we to pick t=
his up again=2E


File Changes=2Emd:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/30/comment/b4f46a05_d33ed53a?usp=3Demail :
PS11, Line 28:   To avoid =
the limitation of ``--connect-freq-initial`` to block legimitate
> Typo: "l=
egitimate"=2E
Done


File doc/man-sections/server-options=2Erst:

https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/4d26a598_49ed3fed?usp=3Demail =
:
PS11, Line 260:    ``--conect-freq-initial``=2E
> Typo: "connect"=2E
Done=



https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/ab9a2127_83a32c6c?=
usp=3Demail :
PS11, Line 292:    Every limit configured with this option wi=
ll put more more entries into
> Typo: "more more"=2E
Done


File src/openvp=
n/bloom=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/1477428=
1_484af281?usp=3Demail :
PS11, Line 82:  * increase the buckets (bit counte=
rs) at the the index positions 77, 323,
> Typo: "the the"=2E
Done


File sr=
c/openvpn/bloom=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment=
/8900b86b_97a33224?usp=3Demail :
PS11, Line 240:     return bloom_add_test(=
bf, item, len, -1);
> `bloom_add_test()` takes a `bloom_counter_t` for its =
last parameter (`-1` here)=2E [=E2=80=A6]
Acknowledged


https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/30/comment/53eaf1d5_c8132eef?usp=3Demail :
PS11, L=
ine 240:     return bloom_add_test(bf, item, len, -1);
> `bloom_add_test()`=
 takes a `bloom_counter_t` for its last parameter (`-1` here)=2E [=E2=80=A6=
]
Done


File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/30/comment/390e281f_1be91ea7?usp=3Demail :
PS11, Line 337:           =
                                            &t->options=2Einitial_cf_bloom_=
config);
> `&t->options=2E [=E2=80=A6]
Done


File src/openvpn/options=2Ec:=


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/670bf33d_ba9953d4?u=
sp=3Demail :
PS11, Line 2646:         if (ft->limit < limit)
> Is this chec=
k inverted? The message below reads like it expects `>` here=2E
Done


http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/d2ad967e_de239558?usp=3De=
mail :
PS11, Line 2650:                         "limit (%d)=2E",
> I can't =
find `connect-freq-limit-initial` anywhere=2E It doesn't appear to be a val=
id option=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/b=
fe20ad5_d974ebcf?usp=3Demail :
PS11, Line 6037:             int num_hash =
=3D atoi(p[1]);
> This should be `p[2]`=2E
Done


File src/openvpn/ovpn_dco=
_linux=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/62ae13a1=
_87aa34c2?usp=3Demail :
PS11, Line 18:     OVPN_CIPHER_ALG_CHACHA20_POLY130=
5,
> This whole file seems to be in this changeset only because it has been=
 automatically reformatted=2E [=E2=80=A6]
Done


File src/openvpn/reflect_f=
ilter=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/290380ee_=
c83ca2ff?usp=3Demail :
PS11, Line 119:      * can then keep the counter in =
the bloom filter itself small (2 bits)
> 2 bits? Aren't the counters 4 bits=
 (as mentioned in comments elsewhere)?
Done


https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/30/comment/849404b7_04a02627?usp=3Demail :
PS11, Line 221:   =
  }
> The `if (low =3D=3D 4)` check here is unnecessary, since just `return=
 low;` instead of the whole branch  [=E2=80=A6]
Done


https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/30/comment/b01c6a66_5345a722?usp=3Demail :
PS11, Lin=
e 290:         gc_free(&gc);
> These `gc_new()`/`gc_free()` calls appear to=
 be dead code=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comme=
nt/a7c98148_5726531a?usp=3Demail :
PS11, Line 340:         bloom_clear(irl-=
>bf);
> `bloom_filter_check_reset()` already calls `bloom_clear()`, no need=
 to call it again explicitly=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/30/comment/9908e153_1fb91c03?usp=3Demail :
PS11, Line 451:     irl =
=3D NULL;
> This is dead code, as it sets the stack pointer parameter to `N=
ULL` with no effects inside the funct [=E2=80=A6]
Done



-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerr=
it-Branch: master
Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6=
b9
Gerrit-Change-Number: 30
Gerrit-PatchSet: 11
Gerrit-Owner: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
G=
errit-Reviewer: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Max Fillinger <max@ma=
x-fillinger=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-Comment-Date: Fri, 06 Nov 2026 11:11:48 +0000
Gerrit-HasComments: Yes
Ger=
rit-Has-Labels: Yes
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>

--lQ7qW/JdbDA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Max Fillinger, R=C4=83zvan Cojocar=
u=2E </p>
<p>Arne Schwabe has posted comments on this change by Arne Schwab=
e=2E</p><p>Patch set 11:<span style=3D"border-radius: 3px; display: inline-=
block; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review =
-1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?us=
p=3Demail">View Change</a></p><p>17 comments:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/30?tab=3Dcomments&amp;usp=3Demail">Patch Set #11:</a=
> </p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">I addressed the comments but did not test this again=2E We have to s=
ee when we to pick this up again=2E</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File Changes=2Emd:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comm=
ent/b4f46a05_d33ed53a?usp=3Demail">Patch Set #11, Line 28:</a> <code style=
=3D"font-family:monospace,monospace">  To avoid the limitation of ``--conne=
ct-freq-initial`` to block legimitate</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;leg=
itimate&quot;=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margi=
n: 0; padding: 0;"><p>File doc/man-sections/server-options=2Erst:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/30/comment/4d26a598_49ed3fed?usp=3Demail">Patch Set #1=
1, Line 260:</a> <code style=3D"font-family:monospace,monospace">   ``--con=
ect-freq-initial``=2E</code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">Typo: &quot;connect&quot;=2E</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/30/comment/ab9a2127_83a32c6c?usp=3Demail">Patch Set #11, Line 29=
2:</a> <code style=3D"font-family:monospace,monospace">   Every limit confi=
gured with this option will put more more entries into</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Typo: &quot;more more&quot;=2E</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/bloom=2Eh:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/30/comment/14774281_484af281?usp=3Demail">Patch Set #=
11, Line 82:</a> <code style=3D"font-family:monospace,monospace"> * increas=
e the buckets (bit counters) at the the index positions 77, 323,</code></p>=
<p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; paddin=
g: 0 10px;">Typo: &quot;the the&quot;=2E</blockquote></p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/bloom=2Ec:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/30/comment/8900b86b_97a33224?usp=3Demail">Patc=
h Set #11, Line 240:</a> <code style=3D"font-family:monospace,monospace">  =
  return bloom_add_test(bf, item, len, -1);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`bloom_a=
dd_test()` takes a `bloom_counter_t` for its last parameter (`-1` here)=2E =
[=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; p=
adding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/53eaf1d5_c8132eef?usp=3Demail">=
Patch Set #11, Line 240:</a> <code style=3D"font-family:monospace,monospace=
">    return bloom_add_test(bf, item, len, -1);</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`bloo=
m_add_test()` takes a `bloom_counter_t` for its last parameter (`-1` here)=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/30/comment/390e281f_1be91ea7?usp=3Demail">Patch Set #11, Line 337:</a> =
<code style=3D"font-family:monospace,monospace">                           =
                           &amp;t-&gt;options=2Einitial_cf_bloom_config);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">`&amp;t-&gt;options=2E [=E2=80=A6]</blockquote></p><p =
class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Do=
ne</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openv=
pn/options=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/670bf33d_ba9953d4=
?usp=3Demail">Patch Set #11, Line 2646:</a> <code style=3D"font-family:mono=
space,monospace">        if (ft-&gt;limit &lt; limit)</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>Is this check inverted? The message below reads like it expects `&gt;` her=
e=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/30/comment/d2ad967e_de239558?usp=3Demail">Patch Set #11,=
 Line 2650:</a> <code style=3D"font-family:monospace,monospace">           =
             &quot;limit (%d)=2E&quot;,</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I can&#39;t f=
ind `connect-freq-limit-initial` anywhere=2E It doesn&#39;t appear to be a =
valid option=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/30/comment/bfe20ad5_d974ebcf?usp=3Demail">Patc=
h Set #11, Line 6037:</a> <code style=3D"font-family:monospace,monospace"> =
           int num_hash =3D atoi(p[1]);</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This should b=
e `p[2]`=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/ovpn_dco_linux=2Eh:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/30/comment/62ae13a1_87aa34c2?usp=3Demail">Patch Set #11, Line 18:<=
/a> <code style=3D"font-family:monospace,monospace">    OVPN_CIPHER_ALG_CHA=
CHA20_POLY1305,</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">This whole file seems to be in this c=
hangeset only because it has been automatically reformatted=2E [=E2=80=A6]<=
/blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;=
"><p>File src/openvpn/reflect_filter=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/=
comment/290380ee_c83ca2ff?usp=3Demail">Patch Set #11, Line 119:</a> <code s=
tyle=3D"font-family:monospace,monospace">     * can then keep the counter i=
n the bloom filter itself small (2 bits)</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">2 bits? Aren=
&#39;t the counters 4 bits (as mentioned in comments elsewhere)?</blockquot=
e></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-=
word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/30/comment/849404b7_04a02627?usp=3Demail">Patch Set #11, Line 221:</a> =
<code style=3D"font-family:monospace,monospace">    }</code></p><p><blockqu=
ote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;"=
>The `if (low =3D=3D 4)` check here is unnecessary, since just `return low;=
` instead of the whole branch  [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/b01c6a66=
_5345a722?usp=3Demail">Patch Set #11, Line 290:</a> <code style=3D"font-fam=
ily:monospace,monospace">        gc_free(&amp;gc);</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Th=
ese `gc_new()`/`gc_free()` calls appear to be dead code=2E</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/=
comment/a7c98148_5726531a?usp=3Demail">Patch Set #11, Line 340:</a> <code s=
tyle=3D"font-family:monospace,monospace">        bloom_clear(irl-&gt;bf);</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">`bloom_filter_check_reset()` already calls `bloom_clea=
r()`, no need to call it again explicitly=2E</blockquote></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30/comment/9908e1=
53_1fb91c03?usp=3Demail">Patch Set #11, Line 451:</a> <code style=3D"font-f=
amily:monospace,monospace">    irl =3D NULL;</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is =
dead code, as it sets the stack pointer parameter to `NULL` with no effects=
 inside the funct [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?=
usp=3Demail">change 30</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/30?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div=
>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D=
"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> G=
errit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9 </div>
<div styl=
e=3D"display:none"> Gerrit-Change-Number: 30 </div>
<div style=3D"display:n=
one"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;open=
vpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Fri, 06 Nov 2026 11:11:48 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment=
-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</=
body></html>
--lQ7qW/JdbDA=--


--===============9160364874455357217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9160364874455357217==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9160364874455357217==--

