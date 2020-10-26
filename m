References: <20201023113431.26691-1-arne@...1227...>
 <20201023113431.26691-2-arne@...1227...>
 <20201024194301.GB976@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c0f890fb-bd6c-1e76-7316-590c95bfb34e@...1227...>
Date: Mon, 26 Oct 2020 10:49:12 +0100
MIME-Version: 1.0
In-Reply-To: <20201024194301.GB976@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zVAJDhJ56cKqAHDXpD2NKZE9tinN9B7PN"
Subject: Re: [Openvpn-devel] [PATCH 2/5] xmit_hold is only required for
 port_share
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zVAJDhJ56cKqAHDXpD2NKZE9tinN9B7PN
Content-Type: multipart/mixed; boundary="nrcNKgVGgcq1gd6Q0OIEBn0KSRVkaxVSt"

--nrcNKgVGgcq1gd6Q0OIEBn0KSRVkaxVSt
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 24.10.20 um 21:43 schrieb Gert Doering:
> Hi,
>=20
> On Fri, Oct 23, 2020 at 01:34:28PM +0200, Arne Schwabe wrote:
>> Make options.c only set xmit_hold when port_share is active to least
>> document this dependency. I have not actually tested if this dependency
>> is actually true (or if port_share could work without xmit_hold).
>=20
> I'm not sure I understand this patch, or the flow.  Before this patch,
> xmit_hold is always set to "true" for TCP_SERVER, after this patch,
> only for server *and* port_share.
>=20
> What am I overlooking?
>=20

No. This feature was introduced as part of port-share and I am not even
sure it is really required for port-share. Normally we do not send
anything unless there is a valid OpenVPN RESET packet. So I want to
limit it again to part-share before I can really reliable say that even
port-share doesn't need it.

Arne



--nrcNKgVGgcq1gd6Q0OIEBn0KSRVkaxVSt--

--zVAJDhJ56cKqAHDXpD2NKZE9tinN9B7PN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl+Wm5kACgkQFRhsZwKx
RFQYzA//Rjj1YGe/x7J1PXf3UuHv53QNcVHJnp7RmTJfMlx5kY1z5uYZBoDdS8sj
+HKuZrDdL+MHEvnCIUPUvWPWDDTY8cjMibB4INj42YeV/nDIYvz0SEDqFU7flBI7
I6QErYEayR4piinDgPQIs7dQb7jxQITqkMWDebdqHItXsVYKOpTIxZpYFNwRTTlT
RNPdm+muZtFrYVLwHAwBfSUezkO6yRrTPoolqhipLRspFExebHji7FLf67bH+XJK
wXFI++6M0IxCVWEOR94fESn3hL7ydgRWU1GLZU/xrF6Q5aAoXyDwzP5OAWINqTkb
H6dfJOqh837iwEEVBUXQ4YHJO2u5klk3p4oPpjHGEsyssfJcYELH6pssgg1iYZYf
Xor1cC0+BfzORWXzE6NNyilqAppbC+Vu+dg5vBFLB738xG4ed0fnY5r73SNE5dTB
1mRPMoTsmex5M/CEGsASEJIE/TfBWPnBSiq3Wj/ap3ZnlksONZ2ikkDD6jFdt4J0
vmB5Yjc68FtkBRUaDPx28XcfFMPkeYuX+VMJLS9dHP1+VIJSa0/2qGDCHgU3tBbr
ta1gQ0uU6k3X3wjF6tO0iDtpbtqVFBwXLjTgmvFq16r9/n/iQfKWOYo3+R7mlXha
jngjUUNDt3ri89DmdiHq3/lPRNqmnG7FS+7qmaZX2Gt4fspvZh8=
=Pmrt
-----END PGP SIGNATURE-----

--zVAJDhJ56cKqAHDXpD2NKZE9tinN9B7PN--

