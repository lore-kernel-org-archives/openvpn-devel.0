Subject: Re: [Openvpn-devel] add a server feature to openvpn to share udp
	ports ?
From: Jan Johansson <jan.johansson@...1...>
In-Reply-To: <20020627171625.F6806@...27...>
References: <1024902829.1463.9.camel@...2...>
	<Pine.LNX.4.44.0206241311040.32473-100000@...21...> 
	<20020627171625.F6806@...27...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Q7za+b/A1OVP9T8Cuv9j"
Message-Id: <1025250451.1388.37.camel@...2...>
Mime-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Fri Jun 28 00:48:02 2002
To: openvpn-devel@lists.sourceforge.net

--=-Q7za+b/A1OVP9T8Cuv9j
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> Is it a different problem than with an unknown ip address allowed to conn=
ect
> to a single port ?
>=20
> Does somebody know about an udp server forking and using different ports,=
 with
> code available, of course ;-).
>=20
> I may be wrong, but I think that it is not common because in the classica=
l=20
> udp servers all the datagramms carry an identifier, or just need a respon=
se
> and no long term association. Thus there is no need of forking. In the
> openvpn case, there is a need of multi packet exchange during tls auth and
> afterwards a long term tunnel is established.

When I first read this, I thought as you did, no udp server forks like
that. Stuff like dns-servers respond as soon as they can and drop what
they can't handle. But then nfs-servers struck me. Whatever they do,
when they have literally hundreds of udp clients transferring files must
work for OpenVPN too.

I can't really see a difference between nfs handles and OpenVPN
tls-stuff, but that might be me. =3D)
I know NFS is stateless, but in this case I can't see what that might
make nfs differ from OpenVPN in regards of handling hundreds of clients
that all "call in" on the same udp port (2049 IIRC) and start long
conversations with the fileserver. nfs clients might talk less in
regards of authentications and have some u_int32 for id, but apart from
that, they do function somewhat alike.=20

Just my 0.02 euros.

--=20
Jan Johansson (jan.johansson@...1...)
BioMat System AB
Klarabergsgatan 37, III
SE-111 21 Stockholm, Sweden
Phone: +46-(0)8-233500, Fax: +46-(0)70-3873952

THIS COMMUNICATION IS ONLY INTENDED FOR THE USE OF THE INDIVIDUAL, OR
ENTITY, TO WHICH IT IS DIRECTED AND MAY CONTAIN INFORMATION THAT IS
PRIVILEGED, CONFIDENTIAL AND EXEMPT FROM DISCLOSURE UNDER APPLICABLE
LAW.  IF RECEIVED IN ERROR: PLEASE NOTIFY US IMMEDIATELY THROUGH
INFO@...25...

--=-Q7za+b/A1OVP9T8Cuv9j
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9HBSSNJYxu+mj1OkRAoBkAJ9s6MNe1p+//kPzoQ8nNfJysrxcUACgwKds
QKvbNiGG7z+K8ejEfwDOqZc=
=SNhu
-----END PGP SIGNATURE-----

--=-Q7za+b/A1OVP9T8Cuv9j--


