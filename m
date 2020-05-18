References: <CALVjyqoi3ZkOn2p+2i=xBS_pNHKbym0eReWCWHAg9+-ULwtEgQ@...278...>
 <CALVjyqo5NNddn3E+cV_eAySc1VzYeLXPvvKUykOusaZF9LhjxQ@...278...>
 <20200515204626.GO1431@...1296...>
 <CALVjyqrmhf8UVc0rwf+cfUC76s3qs6oge+=n4s37XJ8vxZQHNA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <2768b903-ff64-1119-bb1d-d59fc7a70a1b@...1227...>
Date: Mon, 18 May 2020 17:45:24 +0200
MIME-Version: 1.0
In-Reply-To: <CALVjyqrmhf8UVc0rwf+cfUC76s3qs6oge+=n4s37XJ8vxZQHNA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2XKbsqPQKg1oFJyDXlWjsL21AZXIXR0xk"
Subject: Re: [Openvpn-devel] deferred client-connect -
 https://patchwork.openvpn.net/patch/607/
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Shreyas Heranjal <mailshreyas@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2XKbsqPQKg1oFJyDXlWjsL21AZXIXR0xk
Content-Type: multipart/mixed; boundary="RdlcRta7PywNkKXkOKcuUk03D4SXpMvJ8"

--RdlcRta7PywNkKXkOKcuUk03D4SXpMvJ8
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 18.05.20 um 17:36 schrieb Shreyas Heranjal:
> Hi Gert,
>=20
> Thanks for the response.
> Also, I was wondering if there was any sample code for using
> the=C2=A0OPENVPN_PLUGIN_CLIENT_CONNECT_V2 plugin to influence the
> ifconfig-push on the clients. I want to assign client IP addresses to
> the connecting clients based on some logic in the plugin.
>=20
> I went through the code and looks like the config needs to be returned
> as part of the plugin_return struct. Is that correct? Is this the way to
> do it?
>=20

This has nothing to do with this patchset. You would do as in the
non-deferred case by using ifconfig-push. See the ccd and client-connect
in the man page for the details.

Arne


--RdlcRta7PywNkKXkOKcuUk03D4SXpMvJ8--

--2XKbsqPQKg1oFJyDXlWjsL21AZXIXR0xk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7CrZQACgkQFRhsZwKx
RFQ5dhAAqGyl0eLTVaRK/bvT3Ci4pkPy1ua8I6CjI67LkTyugjv8DqbPGtTz/CrF
j0Bb+xIhGNSyjHpKWnCfzh7wy5EokFTOlAChgQ7A9oa+SQgoiA12o+xKH7vxlwOq
RHyrg5eFGT1O+ep3BZMiUCQkzBRG5TakQ0RrRHR6bHtxVx7WIlLGSM8K4P0+Y32k
550B6WH8O5BR6m3ECdsF7rw5rzM/FT5NypHn0Zp9TCwH+pwIelU03dWgaBLI8CFz
NPm1lqzaZu04iSVYtWHI7KFIZwabRYIBEHscK9XZz7m96CacHNdmbroScuKZXw/r
dtZR1C/2g+oOQZS7KSK6q6wfIAuw0S5vSMbUqL4sNriDJV1oN8UGgdzJxLzj5lU2
ovphfSppLUmNyzNZ8YB2DT+XXpAtPzSCeCqJse7FJJjR5vdzymuE811o8JdWL6ob
zOh8Nj2O1BmLRNn/MPjRJWv+RddbvF4Kak4fAzZeY7O0fbr3KokE6vfGM+LS+Dsr
IbGKvA1j4vsu3QmBrOVjfQI8kE7QQAx0BqnoGoTdpG8aL6GZdbi5+oQ/6zEo6ekV
DzucSoiSV5O/BK8ymBsTX2AJiLNt6XDZT6F8F+woufvtrCdwsBH1Jl+qLpOH45o8
EgcfR9JL7iw+xI7FNYuHY4nvRRKsiOSScZt9If/HQ4F2uRkaBfY=
=bOBZ
-----END PGP SIGNATURE-----

--2XKbsqPQKg1oFJyDXlWjsL21AZXIXR0xk--

