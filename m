Date: Wed, 7 Dec 2011 16:31:05 -0800
From: travis+ml-openvpn-devel@...1442...
Message-ID: <20111208003105.GC15470@...1442...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
Subject: [Openvpn-devel] suggested config settings for wifi?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--jL2BoiuKMElzg3CS
Content-Type: multipart/mixed; boundary="DIOMP1UsTsWJauNi"
Content-Disposition: inline

--DIOMP1UsTsWJauNi
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

See attach.

I'm wondering, with the default settings (used via Ubuntu's
network-manager, though that isn't really relevant I think), why I
keep getting timeouts.  I can ping the box.  It seems to work 1 out of
every 5 times, so it's not a packet filter blocking me.

Is there any setting I can set?

TY
--=20
http://www.subspacefield.org/~travis/ | A real man does not think of victory
or defeat.  He plunges recklessly towards an irrational death. -- Hagakure
If you are a spammer, please email john@...1442... to get blacklisted.

--DIOMP1UsTsWJauNi
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <openvpn-users-bounces@lists.sourceforge.net>
X-Label: travis+ml-openvpn-users@...1442...
Delivered-To: travis+ml-openvpn-users@...1442...
Received: from lists.sourceforge.net (lists.sourceforge.net [216.34.181.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by nexus.subspacefield.org (Postfix) with ESMTPS id 140C8CB054
	for <travis+ml-openvpn-users@...1442...>;
	Thu, 13 Oct 2011 15:00:33 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=sfs-ml-1.v29.ch3.sourceforge.com)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <openvpn-users-bounces@lists.sourceforge.net>)
	id 1RETJi-0002NU-VH; Thu, 13 Oct 2011 21:59:54 +0000
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <travis+ml-openvpn-users@...1442...>)
	id 1RETJh-0002NP-Ig
	for openvpn-users@lists.sourceforge.net; Thu, 13 Oct 2011 21:59:53 +0000
X-ACL-Warn: 
Received: from nexus.subspacefield.org ([64.156.192.208])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RETJg-00069o-0Z
	for openvpn-users@lists.sourceforge.net; Thu, 13 Oct 2011 21:59:53 +0000
Received: by nexus.subspacefield.org (Postfix, from userid 1001)
	id EC44CCB056; Thu, 13 Oct 2011 14:43:48 -0700 (PDT)
Date: Thu, 13 Oct 2011 14:43:48 -0700
From: travis+ml-openvpn-users@...1442...
To: openvpn-users@lists.sourceforge.net
Message-ID: <20111013214348.GA4990@...1442...>
Mail-Followup-To: openvpn-users@lists.sourceforge.net
Mime-Version: 1.0
User-Agent: Mutt/1.4.2.3i
X-Spam-Score: -0.5 (/)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	-0.5 RP_MATCHES_RCVD Envelope sender domain matches handover relay
	domain
X-Headers-End: 1RETJg-00069o-0Z
Subject: [Openvpn-users] suggested config settings for wifi?
X-BeenThere: openvpn-users@lists.sourceforge.net
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: <openvpn-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-users>, 
	<mailto:openvpn-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-users>
List-Post: <mailto:openvpn-users@lists.sourceforge.net>
List-Help: <mailto:openvpn-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-users>, 
	<mailto:openvpn-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============7571963613399983409=="
Errors-To: openvpn-users-bounces@lists.sourceforge.net

--===============7571963613399983409==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I'm getting a lot of "timeout exceeded" responses when trying to do
VPN over WiFi... sometimes it takes 4-5 attempts, especially when
doing WiFi->4G->wired connections.

Any suggested settings to make it more tolerant of
timeouts/retransmits?
--=20
http://www.subspacefield.org/~travis/
"Sweeney? It doesn't exactly sound like a super-villain's... y'know, cool n=
ame"
If you are a spammer, please email john@...1442... to get blacklisted.

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (OpenBSD)

iQIcBAEBAgAGBQJOl1uTAAoJEGQVZZEDJt9H0MYQAJKw5Fw4mdACrKkReQAHOE+W
NuhoHkqtTSnQZ6N7aCDcqXuRMPwlfuIQT6RtCZo9ByDX5CGm+CDkyVcPYKC34O5B
vhV+G++RIPDx6+BEgT7UfcYLQ+SEHTvKTpMcr47J7kR49qNb+fI4+LJC2pPPE5Tm
qRKwDY6WFKakl9p2sqJRGfe4c7yDCAjD3+d1GAkXIgm/ypsDXoZp0XRKdPgJykvB
spfrZnwA1YxoxEgqRirN2GogLVV5K54ofUK8hRsTOOoHKkp0UJt8XuCm9qbF/7gd
qYJM4e2YCaLnsL2Y2Qja06iVf8VdTSqksjkfHEc4c06FLCgYNErKl8RULaF8vl4M
KL3X7jGTwtzcUVuJJEXUYghVbxWEAUyqPTX0n/DsOGw3nraxEENvDqMObpzOkKlM
J92IzJSugYCSwcOWMT+aP8aRaOPFY5JgjkN+6U6/aHk36kVelq3WkG3bGk6rvTmm
jz6KZyjzYHAYGup/9uKHmK2Q5wTOg6MynlWf9hBBY5MOFGwcp7kF59QQXH0riyyH
SZ8qZgi/T7uZ2uMJG6aVuyCBkN0t+F4IXUiNG2Q9nuLkLdtnh0AQZTdHapNlK3cZ
zRvIa9FG85pv7dERAVP5TxQyGWE9bFVvJtV1u9Ss024r+z+AvuuCYlTmIo5RKIPd
5BrIeJt16eFeS/9ZCCqV
=bU0q
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--


--===============7571963613399983409==
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
All the data continuously generated in your IT infrastructure contains a
definitive record of customers, application performance, security
threats, fraudulent activity and more. Splunk takes this data and makes
sense of it. Business sense. IT sense. Common sense.
http://p.sf.net/sfu/splunk-d2d-oct
--===============7571963613399983409==
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-users mailing list
Openvpn-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-users

--===============7571963613399983409==--


--DIOMP1UsTsWJauNi--

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (OpenBSD)

iQIcBAEBAgAGBQJO4AVIAAoJEGQVZZEDJt9HvBsP/RSCsc6AM0tStF4zd3pkjA6j
i9XC89aDqEfXyIctELchIISKNSUukWZo2E4lzGiHETVwMsYf4ragSdtRPFyNtQQk
y8bH5h/EvTDM1fskhRpHW47B4RLGe0E8Tb3Z+iaPYKSh6yAADAswuWAXwUTx2o9q
RbaD6XAWVcfg9MtROU2yR602YpWRTKrryf+uTpbvmm4HyV2hQxdqJ4ln3THcSAf8
9qOBn0JweZDA7Ef177cY5/PjJlSXq9r91LKnjoued56/ff1u6vzefOQsHYy9zPDt
tCrH3SlDEuVjw+qKS8e0tvOwX2CIiO8bobR2+38lh8pg9s8UMr9uoxIxxUR8h4y8
pGNokKZ+OZATP5FxYHeyn+dRuJVX/ujsgYtHlRQFd8rDKlAJhntiy3slqDISKtoZ
dn/edgZTFnBJInvZfCQ6EnkAJn9yuX/BgTE05yKjkQeI9vaqvxYlIg4kATbD1yDT
jNQ4KDeU8lYplVa0D3Og1To+VNCWUELYwX0BfZ31XX0tDYTJUf6u0QBHN8jp87DP
0aSTOAPdI1/eJpMTtmXm1ryRxS9J0t9fsursRgOXK3cE8v8FMUExY3cewIASW/P+
gL2vF4RetCb9TAU6M4+ixN9Ho0/mgQYNdE86vJvcJKD359Lm4zb49rkKdxb8SYoP
Z0u1v8lon7UyuGAbTfUc
=jl7f
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--

