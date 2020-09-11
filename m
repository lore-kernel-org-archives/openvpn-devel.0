Date: Fri, 11 Sep 2020 07:58:39 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200911055839.GZ75094@...1296...>
References: <CAAWBBYNLPWmjJ3whY6FAj2G8tT_qkPWZR-gUsKFHe1memta2Og@...278...>
 <CAAF3xa8T=mmZUQdyF3=AZMZZf46TJ85zH=WwAm7ORZiiGGWqZg@...278...>
 <CAKuzo_iTQWBA3t=to4sKdt21pxotNECVfTMFP_fhrEeQ3ejnQQ@...278...>
 <CAAF3xa_Jz1bjw52zBLLdXjgMymk8q+47kt9R8bP8K9Fpt8+s3g@...278...>
 <CAKuzo_jj0SXCVLrthzeCJddK2iKKXAAg4SGTA_pNRXYqcJfTQw@...278...>
 <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
 <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
 <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
 <20200910073321.GR75094@...1296...>
 <CAAF3xa9CHb_xe0fn5tdiYRx-Bp3gpTfTL-KfHKqMEMdxe+XFkQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ypK2e0chMB3/6G/b"
Content-Disposition: inline
In-Reply-To: <CAAF3xa9CHb_xe0fn5tdiYRx-Bp3gpTfTL-KfHKqMEMdxe+XFkQ@...278...>
Subject: Re: [Openvpn-devel] problem with beta3 and wintun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Marvin <volleynbike@...277...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, Lev Stipakov <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Rafael Gava de Oliveira <gava100@...277...>

--ypK2e0chMB3/6G/b
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Sep 10, 2020 at 06:10:17PM -0700, Marvin wrote:
> To All 3,
> Thank you with your help I found the issue. UAC was disabled in the
> registry on this image.  IIRC we had trouble updating some software by
> automated script and turning UAC off was required.
>=20
> After re-enabling UAC, wintun started normally.

Cool, thanks for digging into this and reporting back.

Selva, is there any reasonable way to detect this?  Or do we just go
for "we always use the iservice if it is running, no matter what=20
privs the GUI is running with"?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ypK2e0chMB3/6G/b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfWxIOAAoJEB2Cnv7KVigSelgL/1hiZo/1WAspt77lZgFEWRrU
NXlJb/UExBKfuPBlPNKH4Ivg9YXrqgVQlDnNXXcKLOJ8TsLywWHaBEkCnVDU1ofT
1pXOUmuibvmOHsb6YU1132t5HlR41ps8Kxe5cU+5Qq6euEuiONHfzos9N31VB/Rm
or61/bZeJDXOo5KM3AJcIPnvDRwvRw4pjQOXux8Y/Rq8NqoBdi0+l1HQOSj4SnWQ
uTA9cvrkSxevqmNiqPkfc5UVvbR6lHYuiOpeVTXocAQlpFRcffacgapfL2GfffZ5
xUMJ55mlJJMF1HBkID9TUuqwa3YJ8/u0aK7ex+sjLNSStucve1SjAPoQW8tY0rt3
IDNoCiEtOgO0D4Qm1CfIbwGDNqzk5xOPsu+OfTS35DZeePfRvLdVUa1alcOF8JDa
66CEJQuCaM8FxUqg+QPVCgQTqxCzUn4mXw7TaV9ignXsFbPsLL9Kz4DbcY1BlfnL
jLcwBNPWHYlUpH+t7qHoYUY2E6pRK8YA/bHUkTZu5Q==
=Z+Ox
-----END PGP SIGNATURE-----

--ypK2e0chMB3/6G/b--

