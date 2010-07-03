MIME-version: 1.0
Date: Sat, 03 Jul 2010 10:17:11 +0200
From: Till Maas <opensource@...519...>
Message-id: <20100703081711.GA5858@...1276...>
References: <AANLkTima8VCnIP08BwlXrwvbtZRcRM-ZLeOM6FPty5Jc@...278...>
	<4C2E2652.8000607@...1114...>
	<AANLkTintkNT0hY8cRHz-MEbfAFdd25mfMNOH-r3FTbE0@...278...>
Content-type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary=Q68bSM7Ycu6FN28Q
Content-disposition: inline
In-reply-to: <AANLkTintkNT0hY8cRHz-MEbfAFdd25mfMNOH-r3FTbE0@...278...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN server listening both
 on udp and tcp?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Henno =?iso-8859-1?Q?T=E4ht?= <henno.taht@...277...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 02, 2010 at 09:51:12PM +0300, Henno T=E4ht wrote:
> Hello!
>=20
> 2010/7/2 David Sommerseth <openvpn.list@...1114...>
>=20
> > On 02/07/10 19:38, Henno T=E4ht wrote:
> > > Hello!
> > >
> > > Can anyone experienced and helpful scribble a little guide how to have
> > > the same OpenVPN server listening both on 1194 UDP (reason: fast,
> > > preferable) and 443 TCP (reason: always works, fallback)?
> >
> > That is not possible.  OpenVPN can only listen to TCP or UDP, not both.
> >  To do this, you will need two independent OpenVPN configurations and
> > run two separate OpenVPN daemons

there exists a PHP-script that is supposed to translate a TCP connection
to UDP one. I did not test it:

http://oss.tiggerswelt.net/openvpn_proxy.php

A German blog post about it is available here:
http://wohnzimmerhostblogger.de/archives/1244-OpenVPN-via-TCP-und-UDP-benut=
zen.html

Regards
Till

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAEBCgAGBQJMLvICAAoJEGo6ELMcEJUXxZEP/iTzRbLEocmYoT15ysbJgyDt
PrpnuyhXWNMX/43MRTLFBzVN9i1ed1YqSVM8rxjdNJpA8c0awVnQH5dA6uDRk31Q
8yXt46alxjBDGcQxtgDnFUga7pe/1DDKS8qjIoCjd7GiFtbP7evi5xx2QzmDWr4z
Udv1tll5e1RKaJsgt0e93rABMWgWmINzW6rOxfZUeoSDaVmyN9tsNFExXQGHNKA0
kzyv8MZKo0laWlO6/M6xsamW5Sgg1JQxat4ijRsGmWvJijcFZavxSdh3Jnn12nMj
u/gEaHkO58m7W/MuV+ARm1qbmVfrZf9F6I69ZMcUwH+tDKykolzhiYynrXoCnZ0l
LiDdYPedMuC84JnFa+fmxEMo1a+v6fBzR458x82u5QQAom49mqx4365J3dZABFe/
Gv5BLxGosgUaI9C0Q12EYZjoUrLAZjMGMEufVuj/y/dopjcNQIprk0XWMeXwarOS
hMB8Z8x1WuNsvsXQs3d/Vc29BtD6OYRkrIKNs++SHYIjaoUAP8kul1ZRlTLFvO0/
R3BtkkxscXM9MRa6u9XpUegb9IVnYyNKe6/9qsmy3fh3VXCX9Mm6Wf/wLH4xxHEA
OP7j1MxuB20ea+ykoWN2+7kA2dHlPWpe5+iQeKXf2T3kak11X1Wy6B/Sd2PWR7vl
aZNNWH7BNcqRD1im+7iX
=Wisn
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--


