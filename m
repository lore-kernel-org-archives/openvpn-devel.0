Message-ID: <5367801D.5060904@...1114...>
Date: Mon, 05 May 2014 14:12:13 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <CALufPjXL2hX-W25uBvGNk1M_TbbrkZcUMe-3dYwD2oa9f6DD2Q@...278...>
In-Reply-To: <CALufPjXL2hX-W25uBvGNk1M_TbbrkZcUMe-3dYwD2oa9f6DD2Q@...278...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Oo6j2ujQpukitr3OgpL5lCiEpDDFS6tIR"
Subject: Re: [Openvpn-devel] [New Plugin] Diifferent subnet for different
 Group of user
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marine B <yunai39@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Oo6j2ujQpukitr3OgpL5lCiEpDDFS6tIR
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

On 05/05/14 08:02, Marine B wrote:
> Good Morning,
>=20
> I have made an atempte at creating a new plugin for OpenVPN. My goal was
> to be able to give ip, comming from different subnet , to user from
> different group. Let me explain:
>=20
> You have two group:
> Group A, where user common name follow the regex ^A* and those people
> need to have an ip in 10.0.0.0/24 <http://10.0.0.0/24>
> Group B, where user common name follow the regex ^B* and those people
> need to have an ip in 10.0.1.0/24 <http://10.0.1.0/24>

Can you please explain why it's important that these groups have
different IP subnets?

Because, if it's due to access control and firewalling your VPN clients
(the most common argument for doing this), a dynamic firewall is far
better suitable, IMO.  One approach is to use the built-in packet
filter.  It's not too easy to work with, but here's a pretty good walk
through of it:
<http://backreference.org/2010/06/18/openvpns-built-in-packet-filter/>
... Another approach which is much more Linux centric can be found here:
<http://www.eurephia.net/>

I can see that having your users grouped is nice feature.  But I think
that should be implemented in a different layer.  Perhaps make use of
X.509 certificate fields (like OU/Organizational Unit).  Having a group
variable being passed to plug-ins/script hooks.

But it all depends on why you need different sub-nets for your user groups.


--=20
kind regards,

David Sommerseth


--Oo6j2ujQpukitr3OgpL5lCiEpDDFS6tIR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNngCAACgkQDC186MBRfro3gwCfdaSuAVC03YpvlUj7R8YwEyHd
MckAmwSI5rIKmCqRWiyS6SJQVcH5gLtr
=TDjU
-----END PGP SIGNATURE-----

--Oo6j2ujQpukitr3OgpL5lCiEpDDFS6tIR--

