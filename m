References: <b10bce22-0b79-100f-d880-8388d23c6267@...1856...>
	<1494279878-24601-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <18f36661-f955-86d6-e948-755bdb401fd7@...2080...>
Date: Tue, 9 May 2017 12:46:48 +0200
MIME-Version: 1.0
In-Reply-To: <1494279878-24601-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="K1AUxFsGI4H28siegmsWc7FwHqtwR4QjO"
Subject: Re: [Openvpn-devel] [PATCH] Restore pre-NCP frame parameters for
 new sessions
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K1AUxFsGI4H28siegmsWc7FwHqtwR4QjO
Content-Type: multipart/mixed; boundary="JLwEEXMvBrFGdpDKX36qGm4fUhT78AMKo";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <18f36661-f955-86d6-e948-755bdb401fd7@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Restore pre-NCP frame parameters for new
	sessions
References: <b10bce22-0b79-100f-d880-8388d23c6267@...1856...>
	<1494279878-24601-1-git-send-email-steffan@...1856...>
In-Reply-To: <1494279878-24601-1-git-send-email-steffan@...1856...>

--JLwEEXMvBrFGdpDKX36qGm4fUhT78AMKo
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/05/17 23:44, Steffan Karger wrote:
> As reported in trac #879, as of the introduction of NCP we always adjust
> the frame parameters on session negotiations, but do not reset the frame
> state for a new session on an existing state instance.  That caused the
> frame parameters to be reduced for each reconnect, resulting in smaller
> and smaller packet size limits until no traffic could go through the
> tunnel at all.  This patch resolves that omission.


Only glared at the code changes, and it makes sense to me.  I'll try to
run a few tests to see if I can reproduce this issue.  If others can
help test this patch, that will also help tremendously - and I'll try to
remember to add a Tested-by: tag in the commit log too for all those
confirming this fix.

A little nit-pick below though.


> Trac: #879
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/forward.c | 7 +++++++
>  src/openvpn/init.c    | 2 ++
>  src/openvpn/openvpn.h | 3 ++-
>  src/openvpn/ssl.c     | 9 +--------
>  src/openvpn/ssl.h     | 8 ++++++++
>  5 files changed, 20 insertions(+), 9 deletions(-)
>=20
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 8102e94..2f3f3c5 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -866,9 +866,16 @@ process_incoming_link_part1(struct context *c, struc=
t link_socket_info *lsi, boo
>               * will load crypto_options with the correct encryption key
>               * and return false.
>               */
> +            uint8_t opcode =3D *BPTR(&c->c2.buf) >> P_OPCODE_SHIFT;
>              if (tls_pre_decrypt(c->c2.tls_multi, &c->c2.from, &c->c2.buf=
, &co,
>                                  floated, &ad_start))
>              {

Wouldn't it make more sense to move the opcode declaration to inside the
if (tls_pre_decrypt(...)) block?  I can do that on-the-fly though.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--JLwEEXMvBrFGdpDKX36qGm4fUhT78AMKo--

--K1AUxFsGI4H28siegmsWc7FwHqtwR4QjO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEZ4YAAoJEIbPlEyWcf3yClkP/R+Vqf7Ov++ew24EB073l59W
Kb+ZgJPCf+H9iGjnODrL5bpv+ZkU7Bo3zqz3+/M+QiIvfPJVsoxGFQ5iVRH6+4lM
lJOO02kVyLeYafthl8tCjmij145tBfZlpIz0e70KYdwJujPPZpPgsqyV7yptP2gh
FmblOfZ1xdfMqZOykLDF8Z1qcgIB4/MIuYSilc/THn2Ud8lnAzQZVNwP5Ulwb2a8
2coMnPivsy/nRhKK6Gqi0KOPbQtKfh9cIW+mZShxHt9M6Pbuf46IM1H/AieRD0UE
2uALhrKSHxg/oWzQfulXrjCmLjnJ6RzA5d+/0yIohYl6fbwOMYiySfnwyijowgNd
fOYTmTK0JluXukBJ2TD1hqfcf6pBIdo9vqY8Is4jOGzuJwBIR2rs6iGfMKVJI59S
Pd8hXAl5loXqJQFaKi+olfXZH9Dw4VNynz3V3a0FDdsb9eCLzaCkszS16lGEI8/a
4GtsPt6hzOt61LEDHcYvOMd0pjUG9bPXw7ug1PZq9FtNzDU/Og4orLsA2ET/0/P3
VaH0XGnIuxy+bJzHVPQjLMAKBqDiuDHwxvoIvuQ6k4YwFOlvW4GLm9w6WzW4jrVn
UnA6v8odifgWJ/WYWhC1Clzq6sn5mRj3VHUbXEjRn4r+q+/aI/W00I57lku58U4f
PRzFRJnaft2yMIqmcL8a
=xgw6
-----END PGP SIGNATURE-----

--K1AUxFsGI4H28siegmsWc7FwHqtwR4QjO--

