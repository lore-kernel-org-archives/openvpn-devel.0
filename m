References: <20190613144113.6418-1-arne@...1227...>
 <20190613144113.6418-3-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <948b97f0-7f76-d8ee-418e-4bce369f40d4@...2080...>
Date: Tue, 22 Oct 2019 22:37:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190613144113.6418-3-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wHprWwY2xDyrtNX21WEX6nWnuGjTS3dEU"
Subject: Re: [Openvpn-devel] [PATCH 2/5] Implement forwarding client
 CR_RESPONSE messages to management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wHprWwY2xDyrtNX21WEX6nWnuGjTS3dEU
Content-Type: multipart/mixed; boundary="9Fkj7tjUhYeM13xaziXe3NbSuNEBOiBYl";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <948b97f0-7f76-d8ee-418e-4bce369f40d4@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 2/5] Implement forwarding client
 CR_RESPONSE messages to management
References: <20190613144113.6418-1-arne@...1227...>
 <20190613144113.6418-3-arne@...1227...>
In-Reply-To: <20190613144113.6418-3-arne@...1227...>

--9Fkj7tjUhYeM13xaziXe3NbSuNEBOiBYl
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 13/06/2019 16:41, Arne Schwabe wrote:
> When signalling the client that it should do Challenge response
> without reconnecting (IV_SSO=3Dcrtext/INFOPRE=3DCR_TEXT), the server
> needs forward the response via the management console.
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>  doc/management-notes.txt | 19 +++++++++++++++++++
>  src/openvpn/forward.c    |  4 ++++
>  src/openvpn/manage.c     | 28 +++++++++++++++++++++++++++-
>  src/openvpn/manage.h     |  4 ++++
>  src/openvpn/push.c       | 21 +++++++++++++++++++++
>  src/openvpn/push.h       |  2 ++
>  6 files changed, 77 insertions(+), 1 deletion(-)
>=20
> diff --git a/doc/management-notes.txt b/doc/management-notes.txt
> index 17645c1d..05d30b0a 100644
> --- a/doc/management-notes.txt
> +++ b/doc/management-notes.txt
> @@ -979,6 +979,24 @@ CLIENT notification types:
>=20=20
>      >CLIENT:ADDRESS,{CID},{ADDR},{PRI}
>=20=20
> +(5) Single Sign On Based Challenge/Response
> +
> +   >CLIENT:CR_RESPONSE,{CID},{KID},{response_base64}
> +   >CLIENT:ENV,name1=3Dval1
> +   >CLIENT:ENV,name2=3Dval2
> +   >CLIENT:ENV,...
> +   >CLIENT:ENV,END
> +=20=20=20
> +   CR_RESPONSE notifcation. The >CR_RESPONSE fulfils the same purpose as=
 the
> +   CRV1 response in the traditional challenge/response. See that section=
 below for more
> +   details. Since this still uses the same cid as the original response,=
 we do
> +   not use the username and opaque session data in this response.

The difference between CR_RESPONSE and CRV1, is that the CRV1 response is
passed as part of the AUTH_FAILED in the server response and the client
responds back using the password field.  And this causes the client to need=
 to
reconnect to the server, as the AUTH_FAILED disconnects the client.

With this approach the server and client handles the challenge/response
chatter over the control channel; I like this much more as it doesn't
disconnect the client and server - so it will be much faster to handle the
connection setup once the authentication is done.

I see one challenge with this approach, and it is that it locks us to one
specific format for the CR_RESPONSE.  I think it would be appropriate to
extend it with a "version" field before {CID}, so we have a chance to extend
the protocol without updating much of the core OpenVPN 2.x code base.  For
now, it could be hard coded as version 1.

So:  CLIENT:CR_RESPONSE,{VERSION},{CID},{KID},{response_base64}

I'm also wondering if this would be a reasonable approach to use to impleme=
nt
GSSAPI authentication support as well; where there is a back-and-forth
handshake happening as well.


> diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
> index 2d86dad4..a2b58296 100644
> --- a/src/openvpn/manage.c
> +++ b/src/openvpn/manage.c
[...snip...]
> +management_notify_client_cr_response(unsigned mda_key_id,
> +        const struct man_def_auth_context *mdac,
> +        const struct env_set *es,
> +        const char* response)
> +{
> +    struct gc_arena gc;
> +    if (management)
> +    {
> +        gc =3D gc_new();
> +
> +        struct buffer out =3D alloc_buf_gc(256, &gc);
> +        msg(M_CLIENT, ">CLIENT:CR_RESPONSE,%lu,%u,%s",
> +                mdac->cid, mda_key_id, response);
> +        man_output_extra_env(management, "CLIENT");
> +        if (management->connection.env_filter_level>0)

<code_style_police>
It should be spacing around '>'.
</code_style_police>

It would also be good if we could extend these new functions with doxygen
comments on what these functions work.  What information they parse, what t=
hey
expect of data, from where the data comes and how they respond/produce resu=
lts.

Other than that, it looks good.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--9Fkj7tjUhYeM13xaziXe3NbSuNEBOiBYl--

--wHprWwY2xDyrtNX21WEX6nWnuGjTS3dEU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJdr2h8AAoJEIbPlEyWcf3y4t8P/3uudf0hoqAPkUJ4tucTZ+Qm
TAzauW8eecotuEKpN/pkAVzAnR250uMlX8eW/WTTDY0fg/n3Uos4/IU66KlSDnjI
dqau67XMgKkDL1zMZAbLH+exYzk1Prcjcsl7CDbNCynnabFaKdlU3KE8KMpIhCMY
NqUaLLbnElLVcmdf/2gC5rM/ArOq9Qoan1TzItw5IRfg66ziVB3ezSIcNdJkHLro
G6L1wzZWlmB62GcQVzU/VHygL7Mr8nkjEjEyOnOz3JmIBox4YzCQECIol/2HF09i
QPH+5aEN9/tl6gnuVUQrgmYx1S2dvXSxiL5ZsGjQ/LSMPdf1eLtouHaHk+CdplD/
wiOx9eRQNTlLswjqX39RO+yryAyykTVtLHpyJQXDyt5hm+MEuJsZz1VC8rekvJyU
3kwn0XAUk5Zgu1HyfQQhgywFRsZPY+Lm7cE0zPCj6hanBdwtumsUnaO/19ve3JNZ
thXDx4c121np5oWFwb+e+BQzfQLoX88x/Y/419/c7yCNOlPnVBTe8+alATrOeKns
tGxmc3yvgdeeih0VBmytd6WLVIpFjvjAFcTgXa50JdWwnr346ml9UF6PwlY/khA/
KoGqztr9Wc6fP8gtmKD3dQLXcIdpb34Hr9rABU+hpIwwnYotOu8maT5iJO4BaJFA
XmjkoI4e5VDIPtkvE2ER
=D3tU
-----END PGP SIGNATURE-----

--wHprWwY2xDyrtNX21WEX6nWnuGjTS3dEU--

