Subject: Re: [Openvpn-devel] add a server feature to openvpn to share udp
	ports ?
From: Jan Johansson <jan.johansson@...1...>
In-Reply-To: <01e501c21a86$244c8690$1000000a@...4...>
References: <20020621200138.J4523@...27...> 
	<01e501c21a86$244c8690$1000000a@...4...>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-56l+YW9GxG4ggi4/7O2U"
Message-Id: <1024902829.1463.9.camel@...2...>
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
Date: Mon Jun 24 00:14:03 2002
To: openvpn-devel@lists.sourceforge.net

--=-56l+YW9GxG4ggi4/7O2U
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2002-06-23 at 09:18, James Yonan wrote:
> Hello Pat,
>=20
> I think it's a good idea, something we're considering for the next releas=
e.

I would like to have some info then on how to stop accepting a certain
client certificate, since I base my "expirations" on stopping the port
in question in case I no longer want a specific certificate to be able
to connect to the network. I mean, of course the one-port-per-person
will work after such an addition, but for folks that get in later.

> > Hi,
> >
> > I would like to use openvpn to secure nfs on my network. However, as it=
 is
> > strictly peer to peer I would have to specify an udp port for every
> > client-server nfs relationships. I would have liked to avoid that. Thus=
 I
> > though it could be a nice addition to openvpn if it ws possible to sett=
le
> > it as a server, which forks for any childs.
> >
> > Does it conflicts with the design of openvpn, or could it accepted as a
> > feature ?

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

--=-56l+YW9GxG4ggi4/7O2U
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9FsasNJYxu+mj1OkRArTdAJ0aKsX9XJh/k6A+qsve8rpBKa5+CwCZAWg8
kA/6DNV4gZbvxHb/7jLsTlI=
=lUc0
-----END PGP SIGNATURE-----

--=-56l+YW9GxG4ggi4/7O2U--


