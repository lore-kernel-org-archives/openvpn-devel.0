Content-Type: multipart/signed;
	boundary="Apple-Mail=_C8A1B845-1050-41FC-A86A-12B8AED55961";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
From: Eric Crist <ecrist@...1286...>
In-Reply-To: <OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>
Date: Tue, 22 Jul 2014 12:37:19 -0500
Message-Id: <9998AE72-2992-4D02-8E27-BE9A55BDBDF6@...1286...>
References: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC7CB@...1923...>
	<OFF4D01B5D.C068F160-ONC1257D1D.0055C3F1-C1257D1D.005A2BE1@...1846...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.2: "Could not create temporary
	file" ....Too many open files
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arno.odermatt@...1845...
Cc: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_C8A1B845-1050-41FC-A86A-12B8AED55961
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This isn't an OpenVPN problem, directly.  It appears you have a client conn=
ect script, or are storing connection information in temp files.  You can i=
ncrease the maximum allowed open files in Fedora (you'll have to research t=
hat yourself).  Alternatively, stop storing connection data in a temp file =
for new connections.  OpenVPN, by itself, does not create these temporary f=
iles.

-----
Eric F Crist



On Jul 22, 2014, at 11:24:54, arno.odermatt@...1845... wrote:

> Dear all,=20
>=20
> we are driving O-VPN 2.3.2 on Fedora20.=20
> Since we have quit many permanently connected O-VPN clients, we have star=
ted three O-VPN processes, listening on three different ports and setting u=
p three different tap interfaces:
>=20
> Today, all three O-VPN processes crashed suddenly, whereas we found follo=
wing error:
>=20
> ip-172-16-128-101 openvpn[654]: <CN>/172.16.253.10:44214 Could not create=
 temporary file '/var/tmp/openvpn_cc_1bd37815cbacd70936015e40e25198aa.tmp':=
 Too many open files
>=20
> We did not find any helpful information, neither in the the mail-archives=
, nor in other forums/panels, beside something related to user/password aut=
hentication (openvpn-auth-pam), which we are not using (using TLS-server) a=
nd also lsof did not provide any helpful information to correlate this erro=
r to a (file-) resource problem=20
> https://forums.openvpn.net/topic13474.html=20
> https://community.openvpn.net/openvpn/ticket/201
>=20
>=20
>=20
> After this happened, we found:=20
>=20
> - in /tmp:        -rw-r--r--.  1 root    0 Jul 18 10:51 vpn3_sema_15198  =
              #sema files laying around=20
>=20
> - in /var/tmp        -rw-------.  1 root        0 Jul 18 10:51 openvpn_cc=
_0e211df697b9f5620da89bd05f44ef48.tmp=20
>=20
>=20
> Deleting of the sema-files and restarting O-VPN brought back everything t=
o life.=20
>=20
> Has anybody ever experienced something similar, can this be a bug and wha=
t could be the corrective action to overcome, this to repeat again?=20
>=20
> Thank you for any help in this=20
>=20
> Ar
>=20
>=20
> ******************************************************
> Notice: The information contained in this message is intended only for us=
e of the individual(s) named above and may contain confidential, proprietar=
y or legally privileged information. No confidentiality or privilege is wai=
ved or lost by any mistransmission. If you are not the intended recipient o=
f this message you are hereby notified that you must not use, disseminate ,=
 copy it in any form or take any action in reliance of it. If you have rece=
ived this message in error please delete it and any copies of it and notify=
 the sender immediately.
> *******************************************************
> -------------------------------------------------------------------------=
-----
> Want fast and easy access to all the code in your enterprise? Index and
> search up to 200,000 lines of code with a free copy of Black Duck
> Code Sight - the same software that powers the world's largest code
> search on Ohloh, the Black Duck Open Hub! Try it now.
> http://p.sf.net/sfu/bds_______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel


--Apple-Mail=_C8A1B845-1050-41FC-A86A-12B8AED55961
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
X-Eric-Conspiracy: There is no conspiracy.
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJTzqFPAAoJEHKWQhk5DQ0OzD8H/1dzHB8TyWMRTwhcqEXrSj2b
xEBGJg9WA0d2eI/3lCtvvZ9d4AZ05gStWxxHWtYevVCLsuRNgc+AJJaot+Eb5rnG
jmgS+wBBdkuWOJVN1qitMF1drjfbxgbgRGtQgXSd1t7PkVH/kK4UF3hgmU9+JRAO
l61Dnr9ljiuC5eZzCi/zvwXb3lSax1KqymB34xLYZ6pX9WCTqF6OwSrU+1FrrdJm
WWAWomx3RnMFOUcQeC9LsbSPKjJz+NRO24PYZu9RPByAVwPt9XTF4afYDAZycvLQ
4knBi+fQo/ZGLnl+9c+4I+ZH4zBjDGlOn175QTSDLd2yg4hnWA08K8VXVernE4U=
=2KA/
-----END PGP SIGNATURE-----

--Apple-Mail=_C8A1B845-1050-41FC-A86A-12B8AED55961--

