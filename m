References: <1450123758-31641-1-git-send-email-steffan@...1856...>
	<566F5B01.8020109@...2080...>
	<20151215075312.GN24952@...1296...> <5670890D.7050501@...1147...>
	<20151216082452.GY24952@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5671677A.8060809@...2080...>
Date: Wed, 16 Dec 2015 14:30:34 +0100
MIME-Version: 1.0
In-Reply-To: <20151216082452.GY24952@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="Vm9w7FQWGbavhd4LmnDxkEMaWpePgTs2k"
Subject: Re: [Openvpn-devel] [PATCH] Warn user if their certificate has
 expired
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vm9w7FQWGbavhd4LmnDxkEMaWpePgTs2k
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 16/12/15 09:24, Gert Doering wrote:
>
> OTOH, 0.9.8 and 1.0.0 will be discontinued end of this year, so we should
> see vendor upgrades.

Enterprise distributions will not rebase OpenSSL on their supported
distroes.  RHEL5 will continue to ship the openssl-0.9.8 base.  But it
will be, as it always has, maintained by Red Hat.  So security and
critical bugs will be provided.  I expect SuSE does something similar to
their enterprise release as well.

FTR ... RHEL 5 is fully supported until end of March 2017.  Customers
paying for an extended life cycle support  add-on (ELS) will get
critical-impact security fixes.  For more information:
<https://access.redhat.com/support/policy/updates/errata>

Even though I know it would be good to get rid of the support for these
old OpenSSL versions ... we can't just kick them out like that.  Not
yet.  James have asked us to keep RHEL 5 support as long as it is
supported by Red Hat.  I think it is fine for us to aim for March 2017.
 Then it will be RHEL 6 which is our next target (openssl-1.0.1 base).

With that said.  I do not not think it is necessarily worthwhile to
insist on 'git master' being supported on RHEL 5, especially if it
begins to be painful to support RHEL 5 on our bleeding edge code base.
In that perspective I would not mind if we consider the coming OpenVPN
2.4 to be the newest OpenVPN release we support on RHEL 5.  I would
prefer not going any older than 2.4 though.


--=20
kind regards,

David Sommerseth


--Vm9w7FQWGbavhd4LmnDxkEMaWpePgTs2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlZxZ30ACgkQDC186MBRfrqKgQCdGqFx93yVa2U5NpoCEMSSs8DB
tMAAn28QKBjYLnLbkVmbSm/7P7mRTc6R
=JEML
-----END PGP SIGNATURE-----

--Vm9w7FQWGbavhd4LmnDxkEMaWpePgTs2k--

