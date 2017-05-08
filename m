From: David Sommerseth <openvpn@...2080...>
References: <20170505214624.11675-1-davids@...515...>
	<CAKuzo_hOntpCXhSUJFZk3QbKiVMLn87_t+2YAYcirLcX0z17SQ@...278...>
Message-ID: <2501c02c-8ab7-8826-628c-9385c1aa70b5@...2080...>
Date: Mon, 8 May 2017 15:56:27 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hOntpCXhSUJFZk3QbKiVMLn87_t+2YAYcirLcX0z17SQ@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GlwbCslDUL2NRbKsNRxjkAVUQ1AaNVO1B"
Subject: Re: [Openvpn-devel] [PATCH 1/2] plugin: Export base64 encode and
 decode functions
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GlwbCslDUL2NRbKsNRxjkAVUQ1AaNVO1B
Content-Type: multipart/mixed; boundary="hv2d7kiT3BnUR6qfPm2p6BDevGBlU9Pe6";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <2501c02c-8ab7-8826-628c-9385c1aa70b5@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 1/2] plugin: Export base64 encode and
	decode functions
References: <20170505214624.11675-1-davids@...515...>
	<CAKuzo_hOntpCXhSUJFZk3QbKiVMLn87_t+2YAYcirLcX0z17SQ@...278...>
In-Reply-To: <CAKuzo_hOntpCXhSUJFZk3QbKiVMLn87_t+2YAYcirLcX0z17SQ@...278...>

--hv2d7kiT3BnUR6qfPm2p6BDevGBlU9Pe6
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/05/17 05:28, Selva Nair wrote:
> Hi,
>=20
> Thanks for the patch exporting base64_encode/decode
>=20
> A quick question/comment though: quoting from your sample base64.c
>=20
> On Fri, May 5, 2017 at 5:46 PM, David Sommerseth <davids@...515...
> <mailto:davids@...515...>> wrote:
>=20
>     +    /*  Which callbacks to intercept.  */
>     +    ret->type_mask =3D
>     +        OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_TLS_VERIFY)
>     +        |OPENVPN_PLUGIN_MASK(OPENVPN_PLUGIN_CLIENT_CONNECT_V2);
>     +
>     +    /* we don't need a plug-in context in this example, but OpenVPN
>     expects "something" */
>     +    ret->handle =3D calloc(1, 1);
>=20
>=20
> While this looks right[*], in openvpn-plugin.h (lines 344-370) the
> handle in the _return struct
> is defined as openvpn_plugin_handle_t * where that type itself is void
> *, making handle void **.=20
> Also the comment accompanying  "struct openvpn_plugin_args_open_return"
> indicates=20
> *handle should be set to the pointer to the context but that cant be righ=
t.
>=20
> The compiler will not warn about void * and void ** mismatches, so
> ignoring the definition and
> saving the context pointer in ret->handle works,  but the declaration of
> handle in the return struct
> should be simply openvpn_plugin_handle_t without the *.

I had to dig into the history here, to refresh how these things came to
be.  This really puzzled me a lot.  Both the v1 and v2 APIs declares:

OPENVPN_PLUGIN_DEF openvpn_plugin_handle_t  \
OPENVPN_PLUGIN_FUNC(openvpn_plugin_open_vX)

Which basically renders to:

 openvpn_plugin_handle_t openvpn_plugin_open_vX(...)

Which then ends up as:

 void * openvpn_plugin_open_vX(...)

So these functions return a pointer.

Similar to the _func_vX(...) and _close_v1(...) functions, they also use
just `openvpn_plugin_handle_t handle` in the argument declaration, which
means the argument is a pointer (void *).

The v3 API is the only one ending up using
`openvpn_plugin_handle_t * handle`.  And the same happens to the
`return_list` member as well, which

This truly looks like an oversight in the patch review.  So the core
intention was to make it end up as 'void *'.  Instead the API was
"copy-pasted" from the v2 API without thoroughly reviewing this well
enough. And then we end up with `openvpn_plugin_handle_t *' which in
effect is `void **`.

On the other hand, I vaguely remember there were some issues in these
areas when writing the v3 plug-in API back in late 2010.  But my memory
is failing me now.  As we also didn't have the same traceability back
then as we have today, finding the threads to recall why things.

The traces I found are:

- IRC reviews

<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg04664.=
html>

<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg04689.=
html>

- Patches sent to the mailing list:
  v2:
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg04564.=
html>
  v1:
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg04238.=
html>
My hunch now is that this is just an oversight.

v3 is what got applied to the ML.

(It is so good we've improved our track-ability since those earlier days.)


I think it is a bit too risky to actually fix the plug-in API to fix
this.  So we need to use (openvpn_plugin_handle_t *) in the v3 API.

I'll update the patch accordingly.


> The same comment also refers to *type_mask instead of type_mask.which
> is not right either.

That is an error in the  documentation  That's an easy and safe fix.

> Am I missing something?

No, I don't think so.  You seem just to have caught a somewhat sloppy
review which was done many years ago.

> [*] By the way, this being an example, it may be best to show the
> correct type by casting the
> return value of calloc to (openvpn_plugin_handle_t)

Yes, but shouldn't it be `(openvpn_plugin_handle_t *)` ?


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc




--hv2d7kiT3BnUR6qfPm2p6BDevGBlU9Pe6--

--GlwbCslDUL2NRbKsNRxjkAVUQ1AaNVO1B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZEHkXAAoJEIbPlEyWcf3yXdgP/1XeQzrtj/KoehGMI0DUKlk5
5U0UaI38uZDhIggC5NJYHNoett1uZndmiRXffSs1UQbvWSXBji0P8Y42ZfqsRZ3k
pEDpFfSGqrH7brTs3LLND2H7vhhOrD+RkzIkIStbdI7IZ5S8zsKSODJzuQMVOLrT
BIzXQSZZfNnZNx8rvl+GFHe/qGAIWdJd+EdHGLOVvxzTrtubOTBYako1oLJO6/nk
fnSSriahClXJYIVXcHTuXNlROXfquKDM694NNNalC/E/wF6PsjAeQTSUZ39SUyU3
aFWTNSOWVtgOFpsOUSSfICND8xi5f0bK/IPS9+dNwa9gCQHgJSko8jGeJUfVc06o
K+KrnG1eBGEauINNAqYFfqq0E8o5fjbjzR90BV1zLcvCCVGZ5+cvQndhGlMQAY73
JAko26nlvZEGi0rs1JZ+GnrJz6eU+giuifZdAo36FuBL4roBk/JzwDPMBYSmGsZO
GFzr7TaWjQkkAn1i5PMZgii14rulqjq8paz0Wui7AHKMNKuBIXmsWJ6nf2P7W9/z
Cb9a6TxXawftlIj9/i27rzivyTD23BBT/+lWPzen2pcVUWAB5zPVrHZbJ+ZvZeWL
5uYQi4xvW+4ynWsZZXnxnTqkHCSx0kHXSrSwI64rKw7+oB0qfm6qXc4iuoCTvJsV
H9KTn+k7E8+Gdur+8JAZ
=fQxy
-----END PGP SIGNATURE-----

--GlwbCslDUL2NRbKsNRxjkAVUQ1AaNVO1B--

