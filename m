References: <1cfa91c6-2c77-1d82-812b-269c941eba4d@...2489...>
 <289bfe02fdabee00b91b555e7e5759f9.squirrel@...2260...>
 <14dd534e-1ef3-8fa0-977e-8cbfff6a84ea@...2489...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a8e4e3da-dde7-a862-a3a9-fc86de457473@...1227...>
Date: Wed, 23 Jan 2019 15:01:22 +0100
MIME-Version: 1.0
In-Reply-To: <14dd534e-1ef3-8fa0-977e-8cbfff6a84ea@...2489...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9rjdyxse6AOFXHJlsrjcFKJJ0u1hR2CfU"
Subject: Re: [Openvpn-devel] [PATCH] Fix various spelling mistakes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jonathan Tooker <jonathan@...2489...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9rjdyxse6AOFXHJlsrjcFKJJ0u1hR2CfU
Content-Type: multipart/mixed; boundary="b5Ms7LlnZBncvC5ZaLlNp7NNyMKOKZ8F4";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Jonathan Tooker <jonathan@...2489...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <a8e4e3da-dde7-a862-a3a9-fc86de457473@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Fix various spelling mistakes
References: <1cfa91c6-2c77-1d82-812b-269c941eba4d@...2489...>
 <289bfe02fdabee00b91b555e7e5759f9.squirrel@...2260...>
 <14dd534e-1ef3-8fa0-977e-8cbfff6a84ea@...2489...>
In-Reply-To: <14dd534e-1ef3-8fa0-977e-8cbfff6a84ea@...2489...>

--b5Ms7LlnZBncvC5ZaLlNp7NNyMKOKZ8F4
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.01.19 um 06:15 schrieb Jonathan Tooker:
> Looks like I missed that and a few others! I fixed some more spelling
> errors across other things. Follow up patch/commit below. If I just need
> to re-make the original patch let me know.
>=20
> From: Jonathan Tooker <jonathan@...2489...>
> Date: Tue, 22 Jan 2019 23:10:33 -0600
> Subject: [PATCH] Another set of spelling fixes
>=20
> ---
>  COPYING                          |   6 +-
>  ChangeLog                        | 140 +++++++++++++++----------------
>  Changes.rst                      |   6 +-
>  INSTALL                          |   2 +-
>  TODO.IPv6                        |   6 +-
>  configure.ac                     |   2 +-
>  m4/pkg.m4                        |   2 +-
>  src/openvpn/console.h            |   2 +-
>  src/openvpn/ssl_verify_backend.h |   2 +-
>  9 files changed, 84 insertions(+), 84 deletions(-)
>=20
> diff --git a/COPYING b/COPYING
> index 9c21c177..54cc9f24 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -157,7 +157,7 @@ OpenSSL License:
>   * The implementation was written so as to conform with Netscapes SSL.
>   *=20
>   * This library is free for commercial and non-commercial use as long as
> - * the following conditions are aheared to.  The following conditions
> + * the following conditions are adhered to.  The following conditions
>   * apply to all code found in this distribution, be it the RC4, RSA,
>   * lhash, DES, etc., code; not just the SSL code.  The SSL documentation
>   * included with this distribution is covered by the same copyright terms
> @@ -182,7 +182,7 @@ OpenSSL License:
>   *    must display the following acknowledgement:
>   *    "This product includes cryptographic software written by
>   *     Eric Young (eay@...2490...)"
> - *    The word 'cryptographic' can be left out if the rouines from the l=
ibrary
> + *    The word 'cryptographic' can be left out if the routines from the =
library
>   *    being used are not cryptographic related :-).
>   * 4. If you include any Windows specific code (or a derivative thereof)=
 from=20
>   *    the apps directory (application code) you must include an acknowle=
dgement:
> @@ -200,7 +200,7 @@ OpenSSL License:
>   * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
>   * SUCH DAMAGE.
>   *=20
> - * The licence and distribution terms for any publically available versi=
on or
> + * The licence and distribution terms for any publicly available version=
 or
>   * derivative of this code cannot be changed.  i.e. this code cannot sim=
ply be
>   * copied and put under another distribution licence
>   * [including the GNU Public Licence.]


Yes there are spelling mistakes in the license but changing someone
else's license is an absolute nogo, no matter how wrong it is spelt.

Even the current OpenSSL version (1.1.1a) has the text with the spelling
mistakes in it.

[Changelog entries]

I am not sure about the changelog. Changes.rst can be spell checked but
Changelog also doubles as a list of the git commit, so I feel it should
be the same as the commits.


> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
> index 62beacae..f9481684 100644
> --- a/src/openvpn/console.h
> +++ b/src/openvpn/console.h
> @@ -35,7 +35,7 @@ struct _query_user {
>      char *prompt;             /**< Prompt to present to the user */
>      size_t prompt_len;        /**< Length of the prompt string */
>      char *response;           /**< The user's response */
> -    size_t response_len;      /**< Length the of the user reposone */
> +    size_t response_len;      /**< Length the of the user response */
>      bool echo;                /**< True: The user should see what is bei=
ng typed, otherwise mask it */
>  };
>=20=20
> diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_ba=
ckend.h
> index f4cc2c54..d6b31bfa 100644
> --- a/src/openvpn/ssl_verify_backend.h
> +++ b/src/openvpn/ssl_verify_backend.h
> @@ -176,7 +176,7 @@ void x509_setenv(struct env_set *es, int cert_depth, =
openvpn_x509_cert_t *cert);
>   *
>   * The tracked attributes are stored in ll_head.
>   *
> - * @param ll_head       The x509_track to store tracked atttributes in
> + * @param ll_head       The x509_track to store tracked attributes in
>   * @param name          Name of the attribute to track
>   * @param msglevel      Message level for errors
>   * @param gc            Garbage collection arena for temp data
> --=20
> 2.20.1.windows.1
>=20
>=20
>=20
> On 1/22/2019 9:51 PM, Simon Matter wrote:
>> Hi,
>>
>>> diff --git a/src/openvpn/console.h b/src/openvpn/console.h
>>> index 0ffd6683..62beacae 100644
>>> --- a/src/openvpn/console.h
>>> +++ b/src/openvpn/console.h
>>> @@ -33,9 +33,9 @@
>>>   */
>>> struct _query_user {
>>>      char *prompt;             /**< Prompt to present to the user */
>>> -    size_t prompt_len;        /**< Lenght of the prompt string */
>>> +    size_t prompt_len;        /**< Length of the prompt string */
>>>      char *response;           /**< The user's response */
>>> -    size_t response_len;      /**< Lenght the of the user reposone */
>>> +    size_t response_len;      /**< Length the of the user reposone */
>>                                                              ^^^^^^^^
>> response
>>
These changes are fine.

Arne


--b5Ms7LlnZBncvC5ZaLlNp7NNyMKOKZ8F4--

--9rjdyxse6AOFXHJlsrjcFKJJ0u1hR2CfU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxIc7IACgkQFRhsZwKx
RFQIAA//Q05ImIg0IdBPlyyj4gwcnDXWixrMvuMS/hKG/brSlwaw9e3YsTNSqymQ
OMBCdfmmANj85+tKGra7+Qef8w2H9Gvy0WswQ/UzGSNbZs8AByedFBLbP8VLkJPx
Ob8Louq445rmasODj4jPMA5H58/R7lUKdQEHJFmuPQOiBSe58AJ7N2d8lKVmPbRU
fWhjZ2QJvnv8A3DF9ttBo9NWC9qE5bBvf1pFRln0aEHZP3/c1LNYj2coe0u7vBsy
klnWccpJ2WYLTwqPyUauSJR0ACIV4svcVoStcNoUH/CSxe2Pa/KBDsSPIFlKIkRe
VYPKWqbp+TkXL8JhkncWMba53W80JtLOdEgPwLT8HyhHtjwKbUT0/ZmXWI3sCZSA
nYBP0ANZmGJp6PxYjVtxB7xexIyykKzpjh2MFtFuGAdw6G0E03Bfi9OssjQlhZ6z
nK8eaNNvHYcjHgk89NcaCI+LgycOKubW9NDESLdhnmYyvLXCKLck3+I2epuafylO
7rIH+FgcrBt8VrepDctbc86RfAqH8CEpYR0UnIuv+ZfK+whOmcz/7AwZQaWGo9qo
QkZVU2XcU9b7LT63fn/SCOdglp0qutw7zrzghXoB/e0W64kykxG02K/4bPRn/UqS
uyhIqhbcCn1V0QVwFmj05MDQHVJVHEWDznFlhR0XP8Vl6/3jla4=
=cYaR
-----END PGP SIGNATURE-----

--9rjdyxse6AOFXHJlsrjcFKJJ0u1hR2CfU--

