References: <20200717190801.17780-1-gert@...1296...>
 <20200811104401.31075-1-gert@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <15bba1d3-81e9-e37b-9d30-ad99b2425767@...2080...>
Date: Fri, 11 Sep 2020 21:03:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200811104401.31075-1-gert@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="mUWvmqFANDBoRENqtgaxT8UXkLr7JfB2A"
Subject: Re: [Openvpn-devel] [PATCH v2] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mUWvmqFANDBoRENqtgaxT8UXkLr7JfB2A
Content-Type: multipart/mixed; boundary="MbmrUWb0C3MLiGWnkjqhUvXFemXHB0KOB";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Cc: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>
Message-ID: <15bba1d3-81e9-e37b-9d30-ad99b2425767@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add demo plugin that excercises
 "CLIENT_CONNECT" and "CLIENT_CONNECT_V2" paths
References: <20200717190801.17780-1-gert@...1296...>
 <20200811104401.31075-1-gert@...1296...>
In-Reply-To: <20200811104401.31075-1-gert@...1296...>

--MbmrUWb0C3MLiGWnkjqhUvXFemXHB0KOB
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/08/2020 12:44, Gert Doering wrote:
> This is a new "samples" plugin which does not do many useful things,
> besides
>  - show how a plugin is programmed
>  - how the various messages get dispatched
>  - how to pass back information from a client-connect/v2 plugin
>  - how to do async-cc plugins  [not yet implemented]
>=20
> the operation of the plugin is controlled by UV_WANT_* environment variab=
les
> controlled by the client ("--setenv UV_WANT_CC_FAIL 1 --push-peer-info"),
> to "fail CLIENT_CONNECT" or "use async-cc for CLIENT_CONNECT_V2" or
> "send 'disable' back from ...") - which is useful for automated testing
> of server success/defer/fail code paths for the CLIENT_CONNECT_* function=
s.
>=20
> See samples/sample-plugins/client-connect/README for details how to do th=
is.
>=20
> v2:
>   - implement async / deferred operation both for CLIENT_CONNECT and
>     CLIENT_CONNECT_V2 plugin calls
>   - implement returning openvpn-controlled (setenv) config snippets
>     (so the client side can verify in automated testing that the plugin
>     operated correctly, without hard-coding something in the plugin code)
> ---
>  sample/sample-plugins/client-connect/Makefile |  16 +
>  sample/sample-plugins/client-connect/README   |  34 +
>  .../client-connect/sample-client-connect.c    | 609 ++++++++++++++++++
>  3 files changed, 659 insertions(+)
>  create mode 100644 sample/sample-plugins/client-connect/Makefile
>  create mode 100644 sample/sample-plugins/client-connect/README
>  create mode 100644 sample/sample-plugins/client-connect/sample-client-co=
nnect.c
>=20
> diff --git a/sample/sample-plugins/client-connect/Makefile b/sample/sampl=
e-plugins/client-connect/Makefile
> new file mode 100644
> index 00000000..ff187c43
> --- /dev/null
> +++ b/sample/sample-plugins/client-connect/Makefile
> @@ -0,0 +1,16 @@
> +all: sample-client-connect.so
> +
> +
> +sample-client-connect.o: sample-client-connect.c
> +
> +# This directory is where we will look for openvpn-plugin.h
> +CPPFLAGS=3D-I../../../include
> +
> +CC=3Dgcc

If you don't set this; CC will normally be 'cc', which is normally linked to
gcc on Linux systems.

> +CFLAGS=3D-O2 -Wall -Wno-unused-variable -g

I would probably skip the -Wno-unused-variable and rather not declare unused
variables.

[...snip...]

> --- /dev/null
> +++ b/sample/sample-plugins/client-connect/sample-client-connect.c

[...snip...]

> +/* use v3 functions so we can use openvpn's logging and base64 etc. */
> +OPENVPN_EXPORT int
> +openvpn_plugin_open_v3(const int v3structver,
> +                       struct openvpn_plugin_args_open_in const *args,
> +                       struct openvpn_plugin_args_open_return *ret)
> +{
> +    const char **argv =3D args->argv;
--MbmrUWb0C3MLiGWnkjqhUvXFemXHB0KOB--

--mUWvmqFANDBoRENqtgaxT8UXkLr7JfB2A--
