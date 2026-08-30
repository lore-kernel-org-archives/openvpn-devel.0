Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC0CC61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 22:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:
	From:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h6HOHWQK/oa1J0FJqgYZVikVR6VmpK/r6pypuK2FPCM=; b=CRJGo6+35qF2Epa/TvfdIP/z/6
	7G3Oo4Iw82feAlQNHwLR8lp5CTNhWZ9NwCrp2PZHxInBDoGjBqFWKi8qPEzECnkgRHXo/V5fd5FwP
	2HDD90XmDuufcAyOEzfivc9vaIDtWqC1rTKDrH+serKm549AsICrBsz3PEd/vWk4W3YI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0ngj-0001yt-8g;
	Sun, 30 Aug 2026 22:07:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gypsyface8@gmail.com>) id 1x0ngh-0001yk-Ar
 for Openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 22:07:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:Subject:Message-ID:Date:From:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IXANoVbKRFF0m4p1VU1s3r8iVFE27lbQ8m6cD0i8siI=; b=koBdHxDmHJN1hFAolkyWNMz+25
 0VdpsUaYeTY0wSnTFyHU8qFkcccbdg0xI7Zqorvrd4d5ahVdh8DAfdlirhy8CYSHp4NIGxVkemG2P
 GXUD5wamMqPfus8MIAk5FOqny09h9pcNVzC8HoxISezoLpKsLJZ+Qe7Mp0CyzRi5QHQg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:Subject:Message-ID:Date:From:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IXANoVbKRFF0m4p1VU1s3r8iVFE27lbQ8m6cD0i8siI=; b=G
 dVwNkOQG9gav4/DTM4ABOHgIczd3oypFYVQZcTVBk7eltJ18O9NCCHtcSXX6u7iihgn1h7HMHMo0w
 QZyC+wKR2/dIJumoiVgaO11IXw+Sjc3PfYDPHnlAd9obAajgw+53WCKwOt+PRiPg0tRMeRktxZnjZ
 T1JyeRDSAt9pZtQM=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0ngh-0007V3-O3 for Openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 22:07:39 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4843c41f35bso172256f8f.0
 for <Openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 15:07:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788127653; cv=none;
 d=google.com; s=arc-20260327;
 b=MZLN6WhtqnqlT/jGYJcBm3bWAKMmhbG0iWArYbsSx4x7MEOBCw5USdMkK/8aTSOVqI
 jIWFyU2FwrRvCqJXXG1A+xNcxq/XJZR626IEdltyyU/6/Kcp0UUtOxN6EuOJo4LVo+4K
 kNWbdrraWoIe0v83krIz7Sk9Q4CMG5tQiSOTnduJ4QRBcD+/00QDLYg/zc9s/0N2nhSY
 T7Q3R/JN6jTsmBaF3nnp9FYL6R/mczEO6CtU9EeCuC4xO5Tt2RnVvfZmEVm8x4Fzjc8G
 BM1bUjU6A8OWB2uqFy8O3N6xmHZJ858NODjSIUgqXIpx3qIAKxfz9QuPIwQ5+9mChMIW
 4AGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=IXANoVbKRFF0m4p1VU1s3r8iVFE27lbQ8m6cD0i8siI=;
 fh=OljYZ0flD44HzTtWRoSqxyxV9EjoHd9ZwZlknptwnZo=;
 b=J59Tt4w+r3Jaku86vYBzmbHYk2T1qq5Z6ygnkopv1tXLW9C1vX6kONoHMuzW/k2uF9
 h8liKtb9s08J23381/snvSG6dqKiG1qomw0hsvdVNTx+vrYdA/ZtvbxxPYLjQCfQBQjq
 luK/CJSHhFVx+TzAYaBIDsdNhAcCe67NtslbysC+mHpjN4+emHKKmFvLYV1YF0VMWQGY
 k0zGbt89GVtbjTzTI8GaccrjA/tRqZjcvcNfcf+ehVC9AQ41mKZMyFllzO88cMGNf0do
 46Ksb+7p9A3kGz0U23/pKjiyi7UIn/Z/LtUkWsRkoqyq+KGMUlNp4VBZkBEViJ3sqt4k
 KkvQ==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788127653; x=1788732453; darn=lists.sourceforge.net;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IXANoVbKRFF0m4p1VU1s3r8iVFE27lbQ8m6cD0i8siI=;
 b=Ud/gLJ+kT8Y+JfSLcnxLqa/e4fyYH/SgbP3IDf1Ee3n4DggF+quKU5wCn/2jjChx2p
 NE5iBS3i9PiTILlWUPItCwuoQyWTeflwPHuhd15OQ8i9bJ5FglnIGWO1R/x+W2H0tqBF
 1QPABe7A1bs9v7c0JxHKYMgOlXV8xtdb6UPlOkCEkFo+eGvM0iHNRmuFPsD1lSWXw8d7
 77HrGrQZj74QrjaXNZGxyh/+xljISt8aLV53lr03ktJnGd824z/TsZZRRWu43eh50M/M
 SHoGfnJbMqUlcxWqeqnQMzUNgYHwK+jTyEU/yQYjGRSQuKkvBcYo3Mixnn+GmbbCkKmJ
 AoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788127653; x=1788732453;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IXANoVbKRFF0m4p1VU1s3r8iVFE27lbQ8m6cD0i8siI=;
 b=PODLC9k6erq2nrfQhVOSnYy9l3Cj916japdmt7VQUJcpSc7OEHQMU0OZuwboy0DeHf
 jth5di++XO4gOr0JywMWYrI6MvbPFZYy2bWUTRC6j52MVCtMYWwGeEVnaK15oDkj96ns
 RImuWf3yslGtz4aF+TuqATKnGFcZGTxY0hIm6aITEKYwHx/Ei83+TrAVHJflVrnfEcbI
 4qgFG6ZHVsOavsTVhL3QexEhEMH4crkjcJblKIqgUxHKNjF/wK8hZj/lBrEjP5meGgL9
 UUAXE0uMK73Jsy1fkPaGuwjKCvljKy0Nv1+uXLVesrUOpTWLbVvyLRp5l45gnKcN29J/
 grsw==
X-Gm-Message-State: AFuF++k6//86jSa4JMtX0ha2TQhQY0sQUzBVOzmdKbJFOWjNNaKYX2dJ
 rxb1HYs46ZsArQtLAKKeSZugXsnKR1V16h3sKhjRcMUFn7dT59Gp4XkAJoj66bqdYigloon1uQC
 EkUGDjhHsNBrw+SL7av/4q34r5qa8PwUvZX2s
X-Gm-Gg: AYBFou2gFzsNWm1rkpgONnij+uSVdTelt+GJ+Ah5KYFMIWwAg5TPcp2B/9FK02Gpxqi
 L955InWCOg4+LNZMp9IX3KKaYwGh/jvAFN8UiX6q11yHdv/TnNs1TuYD53l7e6c22CMHCpffz8a
 YVwlRR7FZjjk9sHzcl6I1PFTt6H/cenkv9QuJkaiIAkd9vo1+wo+uMWusSyqDcu9+Tr0Hh3OjlO
 WpKHPYVYM8VZdGDWqv60J5+/8bhSWV9LWnPIVNvM0IOvZP5lwdbKZ2wGZ9THNPrV4J1MFfl5iNp
 ojaJYVrqXEEnIvMH2e2kLXw+bwt/E/lLsPtF/eeP93B9nFOT8C08FlJpNLvl9QsII0lNUQ==
X-Received: by 2002:a5d:5f84:0:b0:484:3165:ef47 with SMTP id
 ffacd0b85a97d-4843973a805mr7308057f8f.0.1788127653146; Sun, 30 Aug 2026
 15:07:33 -0700 (PDT)
MIME-Version: 1.0
From: JB 1989 <gypsyface8@gmail.com>
Date: Mon, 31 Aug 2026 00:07:21 +0200
X-Gm-Features: AcwNN1Xm26VFGeZGLdQXhja4ne5LP9paoS8Fd6O2RTi_N8AgSbP-thTZ2K9Y6Ac
Message-ID: <CAKALmhhyV7ZHB-GZ9tMifa8fF06Z4F=1FFKCe-gyaKGJEPVE7g@mail.gmail.com>
To: Openvpn-devel@lists.sourceforge.net
X-Headers-End: 1x0ngh-0007V3-O3
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
Content-Type: multipart/mixed; boundary="===============2459940432394824858=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2459940432394824858==
Content-Type: multipart/alternative; boundary="0000000000009435c6065a4ae94c"

--0000000000009435c6065a4ae94c
Content-Type: text/plain; charset="UTF-8"



--0000000000009435c6065a4ae94c
Content-Type: text/html; charset="UTF-8"

<div dir="auto"></div>

--0000000000009435c6065a4ae94c--


--===============2459940432394824858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2459940432394824858==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2459940432394824858==--

