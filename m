From: Jean-Michel =?ISO-8859-1?Q?Pour=E9?= - GOOZE <jmpoure@...1457...>
In-Reply-To: <20110713163816.GT32373@...1281...>
References: <20110713163816.GT32373@...1281...>
Date: Wed, 13 Jul 2011 23:11:47 +0200
Message-ID: <1310591507.5803.12.camel@...1331...>
Mime-Version: 1.0
Subject: Re: [Openvpn-devel] openvpn support for challenge-response otp
 (user+pass+otp)
Reply-To: jmpoure@...1457...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Le mercredi 13 juillet 2011 =C3=A0 19:38 +0300, Pasi K=C3=A4rkk=C3=A4inen a=
 =C3=A9crit :
> Openvpn gui would need to be able to present additional prompt after
> the usual user+pass prompt..
> For example openssh supports challenge-response, so user+pass+otp is
> possible with it.
>=20
> Thoughts/plans?=20

These are great news.=20
OTPs are very interesting devices.

We recommend using OATH OTP tokens. The main algorithms are hotp (event
based) and totp (time based). GOOZE offers the c100 (event based) and
the c200 (time based). We always deliver seed codes.

In order to help OpenVPN community add support for OTPs, GOOZE is happy
to offer 10 OTP c200 tokens to interested developers.

To receive a free token, visit this page:
http://www.gooze.eu/feitian-otp-c200-for-free-software-development

There are numerous projects using GOOZE Feitian c100 and C200, including
OATH toolkit: http://www.nongnu.org/oath-toolkit/

Kind regards,
--=20
                  Jean-Michel Pour=C3=A9 - Gooze - http://www.gooze.eu


