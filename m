Message-ID: <534A9635.2090704@...1227...>
Date: Sun, 13 Apr 2014 15:50:45 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1397389435-20170-1-git-send-email-gert@...1296...>	<20140413115257.GO16637@...1296...>
	<20140413130102.GR16637@...1296...>
In-Reply-To: <20140413130102.GR16637@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="ks8m1fg6NAna4LLbgwgoKFhRN01nBHDxw"
Subject: Re: [Openvpn-devel] [PATCH] Fix SOCKSv5 method selection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net
Cc: Yawning Angel <yawning@...1897...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ks8m1fg6NAna4LLbgwgoKFhRN01nBHDxw
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Am 13.04.14 15:01, schrieb Gert Doering:
> Hi,
>
> On Sun, Apr 13, 2014 at 01:52:57PM +0200, Gert Doering wrote:
>> I'll amend that when committing.
> Here is the patch with the MSVC build change, plus some changes to the
> commit message to point to the pull request and trac.
>
>
ACK from me for the patch. It looks reasonable and if the change breaks
configs than these configs were fishy to begin with.

Please compile test the const ssize_t size; size =3D ... split. I think
you need to drop the const keyword.

Arne


--ks8m1fg6NAna4LLbgwgoKFhRN01nBHDxw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (Darwin)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlNKljUACgkQe8+cMNS4zRff7gCglYaqIF6csTCGZS97qzV07DFx
K0EAoNpsYgsUZIehh2cKsysOP/7p3aOV
=zhKx
-----END PGP SIGNATURE-----

--ks8m1fg6NAna4LLbgwgoKFhRN01nBHDxw--

