Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D848606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bQKzADUo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LJc2nEmI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NRahovf4;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DzdbZEnG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q1epBazJsNMfEPvaWlqt43t2LyAYtGOtQNZ26ylWZrg=; b=bQKzADUojZlNvh29sgjvAomhau
	6oJNFksKxNS3k+rEFbH/2IvrKo6m2AdWV/Sj0cVvKKSiRtpyNDNTrbGMIITQ4FJdxjfzoatykQu2A
	vfJlhXLWtpR2Wx7n4U7AgDAdmfBQs5vnagF/hqSfnUBfY6u+sb8dB3AGzo8tevqkSrzY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLQbH-000000005L2-2fXy;
	Mon, 26 Oct 2026 19:43:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLQbG-000000005Kw-1wQ7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KgGaPYX6+aiIn5VIUEQbKKWrohHo7LGwPyfmBcp4rZY=; b=LJc2nEmI7a63KMDWQrFrPnd7+G
 OmzhCYTgdb57Knr9KGMqgFIKiLEvyunVe/twz0RoLnxk5OvkG8BrCfHCWcXpgHWVManCPF8lwRhIX
 AyTKOs5ddZo8/yo8+xFwTbbquV+OYT2q4jk9CHNDv0VpisTQLFbv5kOOnEibbSJTt0io=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KgGaPYX6+aiIn5VIUEQbKKWrohHo7LGwPyfmBcp4rZY=; b=NRahovf4qDXnW99kd8Co6cIYp1
 z51aQdgRhUuqi7TWBr5lD0+fMsvCFinHaFRPJ+jpakHwxDMGvymsUX49SgS7/hC9s9EmFQQxSjTIH
 i7sIwAibDxc+SxK+VSE3dgYMPgh2Kxw/rP9O0LvBxrtmErq0+SVyOF2+vgjU9uZDSQYk=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLQbE-000000003Ya-2rrm for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 19:43:18 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1575151f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 12:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793043790; x=1793648590; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KgGaPYX6+aiIn5VIUEQbKKWrohHo7LGwPyfmBcp4rZY=;
 b=DzdbZEnGDUtc4OqGI4A6MNva8bx4ATLO2+C9A6iBEwdBLntaGgGQxysxsvhIE33scU
 Zpvxzl9mQaLl1BNw0f5Y5Xn6QNjg/gXimRPgNVxlY+PFFXzvSMogJv/+ogRhAGgN93bK
 6HmL4v4Y3AaHd9bxYZMVvDbZJLi66LoYQeT7RaIJdVh1Ei2MCuRHm2xCowpeC4+MWYbC
 MIOKQGrNbiKj3dFLGMqehlAovEnkwmth88J19DiaNDoGCaLXRa/mBtsWJVZZzpzoodeA
 aRed3u3SsM4Hx9ssTMJ6FR298ER3aExbsFe/+MedWhXIdUqHohSwxGRgaguK8VF+pRho
 G0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793043790; x=1793648590;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KgGaPYX6+aiIn5VIUEQbKKWrohHo7LGwPyfmBcp4rZY=;
 b=aX9u8x8n7oGhuYlPlvR95BzSCBLb/1Ql+yN4FamjUTPcl5H5xG5p+7GJlhZ/OpA6C4
 UIYhmXdh988ZbISPOlXEqn9A4yCZPAovQKdHqo6Ejo11Sv7QYEXnwFSvDfdnXhRUpSU0
 Hg8ryulIWAIP4pXArJDurKSspUZf4YuotZXejqGlvbV/n5ZnGwlVf8cQx/puvwRmiAui
 /q9N0IxskwA1dAaKEnbuvtSTl43DeJo4dvdQc/7UC+LzYQmPaXa2x/YD0mw5MLQt2Emy
 3vlmqwkVVWY+igTnQ6CXA/+XHGOjeqh41cMPuVxvwR42tVUc705sPK4BePIEj76wqeG6
 hP8g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzIR6OsC4DsYN1DUxFYlhIZ1Z5uGUI05JIYayV7NbvJhZiWdYkokNuUoL4rwb0jw2ReW63tWLwC/56ydQS@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLdDjRYPBbDAYUsSZaNMTyD5ZDuXw3xx4++dHY28GTgpG4+XJCY
 cNmrTePjpg+v9xdlY0uW9xTJnhDZL9GQRYLpv3KP+fOEbLGCFoj89t+XI8WCoAmgBVRXbW9N3u1
 rV1/q4eBp01uEP+DPqwOJqO6RnaholNt+zpuF798uP2YXT9sZdECvraKqK4MGuwWIYnY0
X-Gm-Gg: AYBFou3olWCcwAwxw6RJ+9g3ejypm0s/48T6++1unwGLjxq311C1kSmT9/DetgpMIiD
 V+euOTcTqaIVfOWOMcjHhf0eks5k+9wwaqmlpfcdSx+d5pgWWrWX56uENS3G/4L+pTHuxUxiSAF
 LSJF43Abee+eAgrOmqRphmo2jJYCLLbQBZ1SJplhy1uWpfqXGF1+Z3GylbopdxfZunA1e1vwgWz
 h2D1GUxLXXVZMT+IIZDY1Rjwuki3zD88OhW1r9fyuEA+OgsQ/7TIz1sM44r1sOyybl9ccOZuQ7i
 Zfj1d9gi8Zxgtyl3x2ucmoU+6e5FpFCsn2epPbHuxvHmSIkT0ByVs/eWDhUUNGT1OMuEE8Yc4kZ
 eo0oUxqSyIEB7MRzeTxP+Jp0Wid5BaBAClHAgWah0kAoN3jlJ5RYenMybneJ7UQuG9Lu8aG2pv0
 z4i48cExuuIzAg6hiBwczWUQLJph6XYg2YXBaiHPFUtkfrTcQdnwXNRn6WfabIAZ+scxjZAK7VO
 szrqQDZnhLVYL8iqDDX/l0iEOOJnjt7gvvUISFCOmsk6n2mHudbu/xXVJD0qLnng0qxBWqIiEXR
 ZD6PGfjzLKNS7p1uTMc1GRMgGgYmChgKZzVJ4hNgnKoMiVqdrKDNC9v9tUxUXAI8Y/X2+eECSHt
 hARZeqMuB3Aq1zvUbuzCmniO0G0J9HfdujzCFQU5KHWXhU4UZKipoz3wjAvGEKn8=
X-Received: by 2002:a05:6000:2689:b0:48d:ff06:c634 with SMTP id
 ffacd0b85a97d-48e3eb9bddamr15312364f8f.54.1793043789960; 
 Mon, 26 Oct 2026 12:43:09 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecdfd8dsm17167364f8f.56.2026.10.26.12.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 12:43:09 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 19:43:07 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 1a0beff41115a8b57eff4c8aa856392cf8f5de70
X-Gerrit-Comment-Date: Mon, 26 Oct 2026 19:43:07 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eccf826074ec9c1d1e808e8549db42668aabf033-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xLQbE-000000003Ya-2rrm
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============2743678308111711176=="
X-Spam-Status: No, score=-1.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,MXG_THREAD_INDEX_BAD,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2743678308111711176==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uFV1S+KTmVY="; charset=UTF-8

--uFV1S+KTmVY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, R=C4=83zvan Cojoca=
ru=2E

Arne Schwabe has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

=
(10 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858/comment/67c33ace_d8ff7e02?usp=3Demail :
PS7, Line 8: 
> I added a bit =
of detail=2E I am not sure if that is enough or if should add more=2E
Done
=


File CMakeLists=2Etxt:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/c=
omment/ab6d594b_e19437b1?usp=3Demail :
PS11, Line 576:         src/openvpn/=
pushlist=2Eh
> Weird whitespace?
Done


File doc/man-sections/client-option=
s=2Erst:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/75eaff51_=
48fa6ee1?usp=3Demail :
PS11, Line 23:   See management-notes=2Etxt in the O=
penVPN distribution  and the OpenVPN RFC
> double space before "and"
Done

=

File src/openvpn/options=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1858/comment/d245233b_d2c68d5a?usp=3Demail :
PS11, Line 7137:     else if (=
streq(p[0], "app-custom-control") && p[1] && !p[2])
> Add to usage?
Done


=
File src/openvpn/push=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
/comment/99996347_3a1ce599?usp=3Demail :
PS11, Line 267:         parse_serv=
er_pushed_info_acc(c, &m);
> why use the string instead of the buffer here?=

No reason jsut other functions were similar=2E Changed to pass buf instead=
=2E


File src/openvpn/push_util=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1858/comment/5c7556cd_e4ffeefa?usp=3Demail :
PS11, Line 371: #endif =
/* ifdef ENABLE_MANAGEMENT */
> Superfluous change
Done


File tests/unit_t=
ests/openvpn/Makefile=2Eam:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/185=
8/comment/0d7a75d0_dd4851fb?usp=3Demail :
PS11, Line 106:     test_acc=2Ec =
test_acc=2Eh \
> whitespace
Done


File tests/unit_tests/openvpn/mock_manag=
ement=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6bf1459=
c_f17033cd?usp=3Demail :
PS11, Line 23:  *  51 Franklin Street, Fifth Floor=
, Boston, MA 02110-1301 USA=2E
> old header
Done


File tests/unit_tests/op=
envpn/mock_management=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858=
/comment/18793e25_0830c162?usp=3Demail :
PS11, Line 64: }
> Superfluous cha=
nge
Done


File tests/unit_tests/openvpn/test_acc=2Eh:

https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1858/comment/a98bceb9_e88b75f0?usp=3Demail :
PS11, =
Line 23:  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E
=
> old header
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1858?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id:=
 I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit-Change-Number: 1858
Gerri=
t-PatchSet: 13
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=
=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: chugly <charlie=2Evi=
gue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
G=
errit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment=
-Date: Mon, 26 Oct 2026 19:43:07 +0000
Gerrit-HasComments: Yes
Gerrit-Has-L=
abels: No
Comment-In-Reply-To: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Co=
mment-In-Reply-To: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--uFV1S+KTmVY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, R=C4=83zvan Cojocaru=2E </p>
<p>Ar=
ne Schwabe has posted comments on this change by Arne Schwabe=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">View Ch=
ange</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1858/comment/67c33ace_d8ff7e02?usp=3Demail">Patch Set #7, Line 8=
:</a> <code style=3D"font-family:monospace,monospace"></code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">I added a bit of detail=2E I am not sure if that is enough or if should a=
dd more=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File CMakeLists=2Etxt:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/c=
omment/ab6d594b_e19437b1?usp=3Demail">Patch Set #11, Line 576:</a> <code st=
yle=3D"font-family:monospace,monospace">        src/openvpn/pushlist=2Eh</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Weird whitespace?</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-opt=
ions=2Erst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/75eaff51_48fa6ee1?us=
p=3Demail">Patch Set #11, Line 23:</a> <code style=3D"font-family:monospace=
,monospace">  See management-notes=2Etxt in the OpenVPN distribution  and t=
he OpenVPN RFC</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">double space before &quot;and&quot;</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File src/openvpn/options=2Ec:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-botto=
m: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment=
/d245233b_d2c68d5a?usp=3Demail">Patch Set #11, Line 7137:</a> <code style=
=3D"font-family:monospace,monospace">    else if (streq(p[0], &quot;app-cus=
tom-control&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
Add to usage?</blockquote></p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/push=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1858/comment/99996347_3a1ce599?usp=3Demail">Patch Set #11, Line 267:</a> <=
code style=3D"font-family:monospace,monospace">        parse_server_pushed_=
info_acc(c, &amp;m);</code></p><p><blockquote style=3D"border-left: 1px sol=
id #aaa; margin: 10px 0; padding: 0 10px;">why use the string instead of th=
e buffer here?</blockquote></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">No reason jsut other functions were similar=
=2E Changed to pass buf instead=2E</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/push_util=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1858/comment/5c7556cd_e4ffeefa?usp=3Demail">Patch Set #11, Line 371:</=
a> <code style=3D"font-family:monospace,monospace">#endif /* ifdef ENABLE_M=
ANAGEMENT */</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">Superfluous change</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_=
tests/openvpn/Makefile=2Eam:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/0d7=
a75d0_dd4851fb?usp=3Demail">Patch Set #11, Line 106:</a> <code style=3D"fon=
t-family:monospace,monospace">    test_acc=2Ec test_acc=2Eh \</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">whitespace</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/mock_management=2Eh:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/6bf1459c_f17033cd?usp=3Demail">=
Patch Set #11, Line 23:</a> <code style=3D"font-family:monospace,monospace"=
> *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA=2E</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">old header</blockquote></p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/mock_managemen=
t=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/18793e25_0830c162?usp=3De=
mail">Patch Set #11, Line 64:</a> <code style=3D"font-family:monospace,mono=
space">}</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">Superfluous change</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tes=
ts/openvpn/test_acc=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/a98bceb=
9_e88b75f0?usp=3Demail">Patch Set #11, Line 23:</a> <code style=3D"font-fam=
ily:monospace,monospace"> *  51 Franklin Street, Fifth Floor, Boston, MA 02=
110-1301 USA=2E</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">old header</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1858?usp=3Demail">change 1858</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6=
de86b8ae4c84 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1858=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openv=
pn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-D=
ate: Mon, 26 Oct 2026 19:43:07 +0000 </div>
<div style=3D"display:none"> Ge=
rrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels=
: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Comm=
ent-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

=
</body></html>
--uFV1S+KTmVY=--


--===============2743678308111711176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2743678308111711176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2743678308111711176==--

