MIME-version: 1.0
Date: Wed, 11 Nov 2009 14:35:34 +0100
From: Till Maas <opensource@...519...>
Message-id: <20091111133534.GA29259@...1276...>
References: <20091110161632.GA31301@...1276...>
	<4AFA789B.4070607@...1114...>
	<20091111102515.GA19782@...1066...> <4AFA9AA7.4030600@...260...>
	<fa2e1350911110320g2f1b0a97ke366d1d55a29f906@...278...>
Content-type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary=KsGdsel6WgEHnImy
Content-disposition: inline
In-reply-to: <fa2e1350911110320g2f1b0a97ke366d1d55a29f906@...278...>
Subject: Re: [Openvpn-devel] Script interface to trigger events depending	on
 the validity of a certificate
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 11, 2009 at 12:20:31PM +0100, Jonathan Petersson wrote:

> As it's doing this you can trigger a client-connect script to retrieve
> the "Validity Not After" data from the client-cert (if you have a
> local copy on the server) if the time-frame is out of realms trigger
> sendmail or preferable mail-daemon to send an email to you or the user
> notifying about renewing the certificate.

This does not really work afaics, because there are several certificates
with the same common name but overlapping validity timeframes to allow
users to seamlessy update their certificate. So the tls-verify script
does not know, whether the certificate that expires in two weeks is used
or the one that still lasts a year.

Regards
Till

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iQIcBAEBCgAGBQJK+r2hAAoJEGo6ELMcEJUXAygQAKSwlG2z6+LUUPptAY1p51GU
xKJ82iGS4EMnusWrqwr/FyWUJ6NzY9TmVRqWlUDRNme3qAalhrYwvFDH0cIvkSme
aqiwguMBBRaoJzVozYdtCBhuirHTx30teATrePxXWojvS114BmsKRDoFCL7mM59t
ttm6S4QgNCBEO8p4C57Pn/03OtNl9zcSbIqr1jOmtZz1hoYZ4ys9CmS5bzhh1vUA
TpwvlPcluedTXC3txvE9GJDdo9lMNi4Odp5+DyRf1JgzF1Gd7VWHNqKuQyXD4MuN
mrL+StDZ/BTyT0nLX+4+6OJC7Ei5kyszrb1N3u0jCqu60gn0YGkM0KpLqhMTkaD1
rj8+qcd6qml50wR18ytQsgvt5lDLJsr/5js/jUs7y/knT7PDl2kD/C7W7Oa/MQby
Xyw1MactSm2Rtm/juWJ2w0igznU/2ti37JQc6d0Q0784qw0tu9Xy5forPktAm8Iy
XSk4w5OwTBbeM/8S0hzcYZKu3mbq+5/JI7G75W5/m4sl9zmCE1Sl0Y+agDMETZ40
l4UGGnqF1PLZt/ssFs6CPHc2bTewcUMP2PUT2tkb8Ytylc19hIPbvzQwIZ+VOSPS
0srNBIRKlKcUjVsqgSNqas+SAtQu9elf3uvNuiMStDX6Kadb5f2/wsFmc+iAWlEo
XmFxMXZ7Ytu0/dSHFdIr
=Oy5u
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--


