Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C03AC531CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 23 Jul 2026 11:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:
	From:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l7aGntWchKsKji6MEdt0GGf6IXx5YZveVfz77hadlEc=; b=RrLEUwTPN/+Gd4RsZUp5qrjnBa
	mAqYt7R4GyGLmwNOa5UHf2bW5DESLwaVNZ2kOtUgRsg6GjpFYQ0PwQO2P75+igf4RMo1fXYb6gGFW
	//FXDDQdAexQQWakcIaBhiuHFS1qtPsmYAKCBijIqeasSrjqvAHB7dP5CpXuR1f5LuJ8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmrrV-0005Ss-4J;
	Thu, 23 Jul 2026 11:45:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gypsyface8@gmail.com>) id 1wmrrT-0005Rm-Nx
 for Openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 11:45:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NPKtRu6BXDaDbPN0QrQw6AGNo9oXvBua0/KrX56Fm7I=; b=EOyxVzfMv01+XFLjYAinWeWUM2
 jF++gKpJ1bVxBwmORS+KRhDC2GKEtIRHoJUK0ZTSX6/OMu16tBswYAknqE6jwqhtgh9O3WdysG7I4
 tFMU6sO1bjP4aF4vdXL42NZ08fAKFs2PbDgd+OV1FHm+NIxO+0AB6XmVPazU1Y4AdWrc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=NPKtRu6BXDaDbPN0QrQw6AGNo9oXvBua0/KrX56Fm7I=; b=S
 p9RCnBgp4IO87GSTWMFAqy6eIshcqRHPrFCYZWduWqlztqBEH2Nr7QjJTBwV7ZgGWdlK0PzinMdPo
 IazbCNP3XIfzVHjeCUo746ARjiD62vGlu/MpAy0x7j7hMnxYJYsUNuDrfuEZZsproehjTGpTBo3X+
 hcZPnX9IJY0T63ik=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmrrE-0003oJ-Jo for Openvpn-devel@lists.sourceforge.net;
 Thu, 23 Jul 2026 11:44:57 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso291909f8f.3
 for <Openvpn-devel@lists.sourceforge.net>;
 Thu, 23 Jul 2026 04:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784807081; cv=none;
 d=google.com; s=arc-20260327;
 b=gFipvzS8+e0YKsVN5rvALU9rWBZaf0YF/GXpq6W42fs40gIkaqm7KYXTIk+LusswTu
 7FHmpf8UQWW5SQqoqwG9Q1kzr8efzP45R5KLJiWAH7qJ5AiHP6lfh6OzC7cs2P6lSxOA
 Z+vw/hpX8Chr0f8sVfnf0+5rjnoItbuz+DJ6x8gL4Ft8UdrRq3kaCc9tXCHP1rHnfGB0
 dfi9GhPdyw23GJUfDPqBRYMyxcGeJKvSPS91hHVai97eeyupiAmwHKaqWxU5f4xZKI36
 Og1996BcDWyFXbaso+tQbRYt/vvdRD6nLSLn/pkBeBhX+3GvV3qrKKG0TuWS8NK5iULA
 /oDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=NPKtRu6BXDaDbPN0QrQw6AGNo9oXvBua0/KrX56Fm7I=;
 fh=OljYZ0flD44HzTtWRoSqxyxV9EjoHd9ZwZlknptwnZo=;
 b=Vytjng8t8z3f1nOuJhRGmEnY8FFGH5v2F+7Miho17wUSx/wI2xVuHeRz0uiNWfPgWL
 G8SwnWMqlmWITREisJx6IhKGkq2WnWhQy/I13mK6Qmi0rulFzNqTh0HEnrCmawFVseND
 GSWqaqYbE1DHEVOHOmV0VW0S+eovSqH6kXIdGrM2zlwh9TUoWyXUmQHeFNPrWURFxcym
 oJbHIutSSN1w8JVjqhoSwYqHYImleOMKHHOC9noji22MqLn91bEc/VZTMzr0IoE5lkYA
 5aYMyp6hV3Ef12m2yeKN5Wey7RzQy/rQc7yetPmGFuWDmC+p0EtwdNp1utjzrLDe8s5M
 2pIw==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784807081; x=1785411881; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=NPKtRu6BXDaDbPN0QrQw6AGNo9oXvBua0/KrX56Fm7I=;
 b=k6TTgL4qQQ7zVOOQKiaNVLdnfckQVul34VTWxo7HnLs4ulkkHlEE2T2lpbq85CWeWJ
 YId5PGcOZceJeVLdTqaAnCuGPN8o9JtolyEbCJ/f+stcFkXcVP9DS9sbQDzKhTLpaCFU
 +NqHQkN3jG0oSLctIq3Ebj32mDdw1N3A0kcW62Q09Eh40moxoBKC1dXyzplxh4IWlTUD
 7W/9hXyb1kWJzCwUyngEzKAki2lqkZ8FU24Q/lq58AoUX/OO4D1EsvMK7q2Vvh2Mdy+n
 hxg9VhKkAacJ5LspdoeXF1qK2P5hS5cfEUjy89hbzFp2RhsnUsy1ttFUiDlmEgWlr03k
 l8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784807081; x=1785411881;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NPKtRu6BXDaDbPN0QrQw6AGNo9oXvBua0/KrX56Fm7I=;
 b=fiVhLTffwVDXIg85d7vQFqt7T2FW9RnHclEGPYUIFR1YJ92ZnNwb0RPLBmkCKOyFCy
 Z+rdTnUX4NfMjvltaMaP6xqFFY/zIhk6T9nnEUBkeIzbBpdUwkbfcF95DbGO1xHZOHUO
 k9dVGPlzC7sMtcK8BKPUyk6qGvNzkuCBQJFrbPdbv8h4aGpMYWzXlYU+u+Zn7bjPLOd8
 DeCIkzeIbG9wOWhk5z6l1ditA7+xzUR9zWT33XnbjR8s7SYlCvdZX/wdPHou9JthtGh9
 HkfWowv387MiPdjzC+S4SZ++TQUjVS4SHLixm4N5rbMY1qfjgGoaUOzrIBYAZDdBWWHl
 fHGg==
X-Gm-Message-State: AOJu0Yw2KtONU45n92Pm+HC4Qpnh5rvQhbS7rXr+U89xlduDn+QCGomh
 ox4fQNRZZj/vFIKv5byhjB0QZ6JpJc1zws6x5RnVdQuhUrzdfHZ2h5QzqJJCkjTVFdL5rfcqudo
 sLsceKx8V66lmJJIsYadkadx9gB7iAHPu9kX15Pu32w==
X-Gm-Gg: AR+sD13M6yGpEvM/YGaKXV2DlSdrtZtuM6ZUNImVFjI6ERpSnOooz7rPv67PE/M1keT
 7KDvarku8mbBCi+jNhEDlEv/INIIpycjA8rxEGvn0v8lELEUj41A79hntX2eVkhMgDWnzhGR2RS
 vkVGGqmjcg3DZc1w8uqNY2DaRqPsdnswbfOVqmMJiD3cfSubXoIjhjrxoUluf9XVprMU/PvDujW
 iFYZBg46t1O5enb41uoZUeYj0RWzs892hE545bTr+h+z9ArXWxW2c4GjQLLyA==
X-Received: by 2002:a05:6000:38b:b0:460:70ae:f1af with SMTP id
 ffacd0b85a97d-47f8da82d06mr3384692f8f.27.1784807081292; Thu, 23 Jul 2026
 04:44:41 -0700 (PDT)
MIME-Version: 1.0
From: JB 1989 <gypsyface8@gmail.com>
Date: Thu, 23 Jul 2026 13:44:28 +0200
X-Gm-Features: AUfX_mzcZHmC9VaKoakK-XuZCYCTC2Zm6gf-LjlLl0S-o71teCc4zsXs07QAOG4
Message-ID: <CAKALmhjtTfecb0CLc5DytmMj8iqjDjLB9M2OBYunYTfDYYsEjg@mail.gmail.com>
To: Openvpn-devel@lists.sourceforge.net
X-Headers-End: 1wmrrE-0003oJ-Jo
Subject: [Openvpn-devel] (no subject)
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
Content-Type: multipart/mixed; boundary="===============0511417862642333608=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0511417862642333608==
Content-Type: multipart/alternative; boundary="00000000000012b8b1065745c801"

--00000000000012b8b1065745c801
Content-Type: text/plain; charset="UTF-8"



--00000000000012b8b1065745c801
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--00000000000012b8b1065745c801--


--===============0511417862642333608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0511417862642333608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0511417862642333608==--

