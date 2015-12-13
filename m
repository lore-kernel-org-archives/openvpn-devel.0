Date: Sun, 13 Dec 2015 21:41:00 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151213204100.GY24952@...1296...>
References: <1447079709-17806-1-git-send-email-lstipakov@...277...>
	<20151109145555.GE24952@...1296...>
	<5642F6B7.7090902@...277...>
	<20151111081604.GU24952@...1296...>
	<566B2704.8070500@...277...>
	<20151211200722.GU24952@...1296...>
	<566B322D.1040300@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9faJzSu0rU4kggus"
Content-Disposition: inline
In-Reply-To: <566B322D.1040300@...277...>
Subject: Re: [Openvpn-devel] [PATCH v2] Use adapter index instead of name
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel@lists.sourceforge.net

--9faJzSu0rU4kggus
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 11, 2015 at 10:29:33PM +0200, Lev Stipakov wrote:
> Thanks, I think (I think!) I got it now.
>=20
> 1) Since we have tt->adapter_index (which temporarily disappeared from=20
> my perception of reality), no need to add new member to tuntap or=20
> tuntap_options.
>=20
> 2) tt->adapter_index has nothing to do with rgi->adapter_index, first=20
> one is windows adapter index (which we pass to netsh), last one is for=20
> routing (which we pass to netsh too in special case).
>=20
> 3) In add/del_route* we (try to) use tt->adapter_index.

Right :-)

> Regarding master's "special case" code. Should it be something like this:
>=20
>    if ( r6->adapter_index )		/* vpn server special route */
>      {
>        struct buffer out =3D alloc_buf_gc (64, &gc);
>        buf_printf (&out, "interface=3D%d", r6->adapter_index );
>        device =3D buf_bptr(&out);
>        gateway_needed =3D true;
>      }
>    else
>      {
>        /* device =3D interface=3Dtt->adapter_index */
>      }

Already committed ;-) - but yes, exactly like this.

So if we need to have route that points elsewhere (/128 to existing
default gateway to enable overlapping v6-in-v6), r6->adapter_index is
set.  If not, the tap index is used.

... and it works (except that my win7 vm started to really misbehave
regarding IPv6 today, so my tests took much longer than planned... grrr)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9faJzSu0rU4kggus
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVm3X26kuBuNlUUl1AQL4cgP/dqAOeP3kkjpWHvr7GFrgrGzb9HgZfoqh
YBlkmccH2KbjEB7CuyRT/bUNfP32zX5EKAcSXTp1uIgcB3Q/k75fXIJ5d5C42LZl
VdM/yLsx9FuUBBSLPozhHjpe7dID7EmwoZhsQ83T/EjkQapkS+XqwAuMtRu6KNFb
/OofGvx6Qms=
=HWpD
-----END PGP SIGNATURE-----

--9faJzSu0rU4kggus--

