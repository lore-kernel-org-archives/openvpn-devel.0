Date: Thu, 30 Oct 2025 19:12:20 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <aQOqhNumTK_4xu_9@...1296...>
References: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
 <28143412a9658f544a35b30e574cd3cfd98b08f7-EmailReplacePatchSet-HTML@...2715...>
 <CAKuzo_gpF7Tzx85O023M-sMqA7VJ0RZYvMnmEPDPccK3+gNfBQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="FXLmfPJDCe2FWk4H"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gpF7Tzx85O023M-sMqA7VJ0RZYvMnmEPDPccK3+gNfBQ@...278...>
Subject: Re: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv:
 validate openvpn-gui process path
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: lstipakov@...277..., arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

--FXLmfPJDCe2FWk4H
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Oct 30, 2025 at 12:56:35PM -0400, Selva Nair wrote:
> Do we really want to do this? I thought allowing any user process to use
> the interactive service was deliberate: the only restriction being user
> whitelisted as "OpenVPNAdministrators" or else we allow only a limited set
> of config directives.
>=20
> Currently, starting openvpn.exe through the service using a script or a
> custom application works. Without having to install it in the "OpenVPN/bi=
n"
> directory. Do we want to take away that functionality? The threat being
> addressed here is unclear to me.

I'm also sceptic on this.

The report was, if I understand this correctly, about "non logged in
users" to be able to access the pipe (by means of whatever means windows
has for this).  "Only allow programs from openvpn\bin\ to access the
pipe" fixes something else.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--FXLmfPJDCe2FWk4H
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJpA6qEAAoJEB2Cnv7KVigSVoAL/2/mFstmPQXP1/1KPISlfT1m
YFuTFIlLgH76tg5nbDZT7hKdeC295mNbH7eWWLrml0hPDcbyGbbFx+jAhS7rKHwR
GpwwajeGbcX6ZYfkiwY7nvjLBptIDnQnIsfePea6kulLh3dSn5CJrFECTZXDDcna
YHBnX/PFdz+Ry+KcRxNtvdhryhL3n6CUmYhIza406h/4sfatlotjsT4HUN+PV8T5
MhVEYKRoymoGSrH7Ib/Bpjv24dBtWOZLLdGGg+TqqKzTi7IlTdY94dqpEuzamPjA
MErXpeb0fFzbOldD8hv1gdW4lhUegowFo6GCtQMhrul6b4X/QSlUrmbtAyFgsYuD
O/FFswb41AEa1alUJiTqMfQe4eVokznZV8q4J0DzuULPYh6K65pQOqRNZ3R3IHk7
QVaQEasQULssqNTOhfQcRlDXl2JYln3YmL/OwJ+zURRTl9NVskbLdt6f4tjdVVyK
tRnLoXc5/XIPJNjtlqH6qmy78/6RWXEiToiqzZ24qg==
=wwyZ
-----END PGP SIGNATURE-----

--FXLmfPJDCe2FWk4H--

