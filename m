Date: Wed, 02 Jun 2021 09:43:26 +0000
From: tincantech <tincantech@...2282...>
Reply-To: tincantech <tincantech@...2282...>
Message-ID: <m0MOBw13uxOraK2lWDVmC0c3z15x-gmUlobbi7nJLH8Ix_SW7cYCo5vN8yB5IlJHZm8z6VNwl8l3ze-FrXIwpKvnopJ5pULGe4XwnJMiVZU=@protonmail.com>
In-Reply-To: <20210602034253.19984-2-selva.nair@...277...>
References: <20210602034253.19984-1-selva.nair@...277...>
 <20210602034253.19984-2-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_8HDLvpoi1vF9Ed8BpsA1TUhOyFobvvgAH4GJd84fo"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Improve documentation of
 AUTH_PENDING related directives
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "selva.nair@...277..." <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.

--b1_8HDLvpoi1vF9Ed8BpsA1TUhOyFobvvgAH4GJd84fo
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Him

I read through it and it looks good to me.
One tiny omission inserted:  Scroll to end.

Regards
R


Sent with ProtonMail Secure Email. Which still can't handle patches.

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Wednesday, 2 June 2021 04:42, <selva.nair@...277...> wrote:

> From: Selva Nair selva.nair@...277...
>
> Also fix some typos.
>
> Signed-off-by: Selva Nair selva.nair@...277...
>
> doc/man-sections/server-options.rst | 4 ++
> doc/management-notes.txt | 101 +++++++++++++++++-----------
> 2 files changed, 67 insertions(+), 38 deletions(-)
>
> diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/serve=
r-options.rst
> index 036323b9..047f2270 100644
> --- a/doc/man-sections/server-options.rst
> +++ b/doc/man-sections/server-options.rst
> @@ -460,6 +460,10 @@ fast hardware. SSL/TLS authentication must be used i=
n this mode.
> The UI version of a UI if one is running, for example
> :code:`de.blinkt.openvpn 0.5.47` for the Android app.
>
> -   :code:`IV_SSO=3D[crtext,][openurl,][proxy_url]`
> -          Additional authentication methods supported by the client.
>
>
> -          This may be set by the client UI/GUI using ``--setenv``
>
>
> -   When `--push-peer-info` is enabled the additional information consists
>     of the following data:
>
>     diff --git a/doc/management-notes.txt b/doc/management-notes.txt
>     index 3aff6eb6..9f064764 100644
>     --- a/doc/management-notes.txt
>     +++ b/doc/management-notes.txt
>     @@ -199,7 +199,7 @@ Command examples:
>     COMMAND -- kill
>
>
> -In server mode, kill a particlar client instance.
> +In server mode, kill a particular client instance.
>
> Command examples:
>
> @@ -407,6 +407,7 @@ RECONNECTING -- A restart has occurred.
> EXITING -- A graceful exit is in progress.
> RESOLVE -- (Client only) DNS lookup
> TCP_CONNECT -- (Client only) Connecting to TCP server
> +AUTH_PENDING -- (Client only) Authentication pending
>
> Command examples:
>
> @@ -437,6 +438,11 @@ Fields (e)-(h) are shown for CONNECTED state,
> (e) is available starting from OpenVPN 2.1
> (f)-(i) are available starting from OpenVPN 2.4
>
> +For AUTH_PENDING, if (c) is present, it would read
> +as "timeout number" where number is the number of seconds
> +before authentication will timeout. It is printed as an
> +unsigned integer (%u).
> +
> Real-time state notifications will have a ">STATE:" prefix
> prepended to them.
>
> @@ -608,7 +614,7 @@ COMMAND -- client-pending-auth (OpenVPN 2.5 or higher)
> Instruct OpenVPN server to send AUTH_PENDING and INFO_PRE message
> to signal a pending authenticating to the client. A pending auth means
> that the connecting requires extra authentication like a one time
> -password or doing a single sign one via web.
> +password or doing a single sign on via web.
>
> client-pending-auth {CID} {EXTRA} {TIMEOUT}
>
> @@ -624,22 +630,22 @@ the timeout proposed by the server, even if the tim=
eout is shorter.
> If the client does not receive a packet from the server for hand-window t=
he
> connection times out regardless of the timeout. This ensures that the con=
nection
> still times out relatively quickly in case of network problems. The clien=
t will
> -continously send PULL_REQUEST messages to the server until the timeout i=
s reached.
> +continuously send PULL_REQUEST messages to the server until the timeout =
is reached.
> This message also triggers an ACK message from the server that resets the
> hand-window based timeout.
>
> Both client and server limit the maximum timeout to the smaller value of =
half the
> --tls-reneg minimum time and --hand-window time (defaults to 60s).
>
> -For the format of EXTRA see below. For the OpenVPN server this is a stat=
eless
> +For the format of {EXTRA} see below. For OpenVPN server this is a statel=
ess
> operation and needs to be followed by a client-deny/client-auth[-nt] comm=
and
> (that is the result of the out of band authentication).
>
> Before issuing a client-pending-auth to a client instead of a
> client-auth/client-deny, the server should check the IV_SSO
> -environment variable if the method is support. The currently
> -defined method are crtext for challenge/response using text
> -(e.g. TOTP), openurl and proxy_url for opening an URL in the client to
> +environment variable for whether the method is supported. Currently
> +defined methods are crtext for challenge/response using text
> +(e.g., TOTP), openurl and proxy_url for opening a URL in the client to
> continue authentication. A client supporting the first two methods would
> set
>
> @@ -649,17 +655,30 @@ The variable name IV_SSO is historic as AUTH_PENDIN=
G was first used
> to signal single sign on support. To keep compatibility with existing
> implementations the name IV_SSO is kept in lieu of a better name.
>
> +The management interface of the client receives notification of
> +pending auth via
> +
> +>STATE:datetime,AUTH_PENDING,[timeout number]
>
> -
>
> +If {EXTRA} is present the client is informed using INFOMSG
> +notification as
> +
> +>INFOMSG:{EXTRA}
>
> -
>
> +where {EXTRA} is formatted as received from the server.
> +Currently defined formats for {EXTRA} are detailed below.
> +
> openurl
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> For a web based extra authentication (like for
> -SSO/SAML) EXTRA should be
> +SSO/SAML) {EXTRA} should be
>
> OPEN_URL:url
>
> -and client should ask to the user to open the URL to continue.
> +and client should ask the user to open the URL to continue.
>
> The space in a control message is limited, so this url should be kept
> -short to avoid issues. If a loger url is required a URL that redirects
> +short to avoid issues. If a longer url is required a URL that redirects
> to the longer URL should be sent instead.
>
> A complete documentation how URLs should be handled on the client is avai=
lable
> @@ -667,17 +686,18 @@ in the openvpn3 repository:
>
> https://github.com/OpenVPN/openvpn3/blob/master/doc/webauth.md
>
> -url_proxy
> +proxy_url
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -To avoid issues with OpenVPN connection persist-tun and not able
> -to reach the web server, a variant of openurl via a HTTPS
> -Proxy exists. The client should announce url_proxy in its IV_SSO
> -and parse the PROXY_URL message. The format is
> +This is a variant of openurl that allows opening a url via an
> +HTTP proxy. It could be used to avoid issues with OpenVPN connection's
> +persist-tun that may cause the web server to be unreachable.
> +The client should announce proxy_url in its IV_SSO and parse the
> +PROXY_URL message. The format of {EXTRA} in this case is
>
> PROXY_URL:<proxy>:<proxy_port>:<proxyuser_base64>:<proxy_password_base64>=
:url
>
> -The proxy should be a literal IPv4 address or IPv6 address in [] to avoid
> -ambiguity in parsing. A literal IP address is preferred as DNS might not=
 be
> +The proxy should be a literal IPv4 address or IPv6 address enclosed in [=
] to avoid
> +ambiguity in parsing. A literal IP address is preferred as DNS might not=
 be
> available when the client needs to open the url. The IP address will usua=
lly
> be the address that client uses to connect to the VPN server. For dual-ho=
med
> VPN servers, the server should respond with the same address that the cli=
ent
> @@ -685,19 +705,18 @@ connects to.
>
> This address is also usually excluded from being redirected over the VPN
> by a host route. If the platform (like Android) uses another way of prote=
cting
> -the VPN connection routing loops the client needs to also exclude the
> +the VPN connection from routing loops, the client needs to also exclude =
the
> connection to the proxy in the same manner.
>
> Should another IP be used, then the VPN configuration should include a ro=
ute
> -statement to exclude that route from being routed over the VPN.
> +statement to exclude that address from being routed over the VPN.
>
> crtext
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> -
>
> -The format of EXTRA is similar to the already used two step authenticati=
on
> +The format of {EXTRA} is similar to the already used two step authentica=
tion
> described in Challenge/Response Protocol section of this document. Since
> -most of the fields are not necessary or can be infered only the <flags>
> -and <challgenge_text> fields are used:
> +most of the fields are not necessary or can be inferred, only the <flags>
> +and <challenge_text> fields are used:
>
> CR_TEXT:<flags>:<challenge_text>
>
> @@ -707,7 +726,8 @@ and <challgenge_text> fields are used:
>
> <challenge_text>: the challenge text to be shown to the user.
>
> --
>
> +The client should return the response to the crtext challenge
> +using the cr-response command.
>
> COMMAND -- client-deny (OpenVPN 2.1 or higher)
>
> -------------------------------------------------------------------------=
----------------------------------------------------------------------
>
> @@ -925,17 +945,18 @@ To accept connecting to the host and port directly,=
 use this command:
>
> COMMAND -- cr-response (OpenVPN 2.5 or higher)
>
> -------------------------------------------------------------------------=
-------------------------------------------------------------------
>
> -Provides support for sending responses a challenge/response
> -query via INFOMSG,CR_TEXT. The response should be base64 encoded:
> +Provides support for sending responses to a challenge/response
> +query via INFOMSG,CR_TEXT (client-only). The response should
> +be base64 encoded:
>
> cr-response SGFsbG8gV2VsdCE=3D
>
> -The document is intended to be used after the client received a
> -CR_TEXT challenge (see send-pending-auth section). The answer is
> -the answer to the challenge and depends on the challenge itself
> -for a TOTP challenge this would the number encoded as base64 or
> -just a string for a challenge like "what day is it today?".
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
-----------------------------
>
> +This command is intended to be used after the client receives a
> +CR_TEXT challenge (see client-pending-auth section). The argument
> +to cr-response is the base64 encoded answer to the challenge and
> +depends on the challenge itself. For a TOTP challenge this would


Insert "be" after "this would" (Otherwise it is a bit Yoda)


> +a number encoded as base64; for a challenge like "what day is it today?"
> +it would be a string encoded as base64.
>

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAGBQJgt1K5ACEJEE+XnPZrkLidFiEECbw9RGejjXJ5xVVVT5ec
9muQuJ3QkwgApXDMefVrhrU2V5ncU6JZQTxmjMRP7/jOaJD0SvphieaxXYu/
KKoBXFlCqdeTjJm8cHaKcZcmQiV020PKRSDvn787ZCr4oJFDH+aUB+MjgouN
IlRF2nlAN/rYR6Jjda781wKYcuKSfk/E7hhDNvrgO6+svyVZq6fgnzMoi8Ov
mUvhRjBkN8YbHI4fsDlG1IvtYX29lWI8iGRSMv8eriYTk/ljhCiIFW+/XmPl
57bKjkh4t7BwFf+98TM3C3YX5EvOOq3wGUAdZwrfZ1LrxpB+HQPGixV4TD+t
h9QPsCVzidyTmYfUkZw3AI/OST1L35F0ny1+10jUl00uifHgrNDZIA=3D=3D
=3DfKES
-----END PGP SIGNATURE-----

--b1_8HDLvpoi1vF9Ed8BpsA1TUhOyFobvvgAH4GJd84fo
Content-Type: application/pgp-keys; name="publickey - tincantech@...2282... - 0x09BC3D44.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tDQpWZXJzaW9uOiBPcGVuUEdQLmpz
IHY0LjEwLjEwDQpDb21tZW50OiBodHRwczovL29wZW5wZ3Bqcy5vcmcNCg0KeHNCTkJGdndTY2NC
Q0FET21IRW5RbExtT2pKUnRKTDJsNTNNTHd3RlR5N1huRXBzM2IxUTBVd1dZRkN2DQpMMm9OcDBu
cmRHbEtLREpxNTBZMDlTUitVUllCUW1LbVkzRW16cHlVSUtNL3JnbzFSeXViSHBNUkhiRHANCjdK
cDhMeGtmZkZCVkpqL3Q1Vk1wRDZlTVI2YVVjaVFqZ1JMOE5aZTYrVDd4ZlhYWHdWNWhvUmVaM2pP
Kw0KekhpNlNSN3hUdkdYbGErTVF6NkVFcFdubGJMdmcyb3J0OUtzZXVWallycXZSTXhjZFAwbzlj
WldKNWVwDQpKTm1nZUI2TTcrT1cwOFUxU3NYdEtycExSY0k2eUttVjM4amh6UHIyWmdQOXJtcmxF
clIvMWlxUVFIWFkNCm84LzBEZlB5RjBtSDl5blFJaUxFL2wrRll1NHJzRzhWaUtseGhYY3plUHpB
dExDamlCMGEwbVJWQUJFQg0KQUFITk55SjBhVzVqWVc1MFpXTm9RSEJ5YjNSdmJtMWhhV3d1WTI5
dElpQThkR2x1WTJGdWRHVmphRUJ3DQpjbTkwYjI1dFlXbHNMbU52YlQ3Q3dIOEVFQUVJQUNrRkFs
dndTY2NHQ3drSENBTUNDUkJQbDV6MmE1QzQNCm5RUVZDQW9DQXhZQ0FRSVpBUUliQXdJZUFRQUtD
UkJQbDV6MmE1QzRuUUJEQi85WlVvOUJPWEpSNjFObQ0KMDJvWi84YVJYTzlOblVTRnQ2R0xPV2NE
TnZBczRJSldNRFZFUWZZYW5iKzQyMVFOZC81ZDZIMWlYRitpDQo0TERLME02YWdDK2dzTkZKbmpQ
R0l0dlB0ajdXeWp5blpSeDhENDBQUFhpZ2ZIWXV3Mm9SdTBscitQMXANCjFxZVVlNE5iY3FJdjhJ
SXZMejJ6Q2xZWk9OZ0FzUVZjTkFIaTdaNG9ydFEyaW8yQkFWai84MTlKUFlNdA0KdEhnWTgxd1Mx
Vjd2OEdEVFpnOG9hUGhYR2ZhQzRUWkZHdFpyL2J5YmNxcnNvMzVqYVFtQzU0eE1iWHBGDQpBVXJj
M3VHVk9IK09kRy9CVzJnY1lxcHZVRkJ1a1h4Q1VCWUhQMk5mWGhOZnpHdDluQzF1bE5LWWVQMTkN
ClRHbE9vckJNWUlBRUhvR3h2cGJVWGZiYU5XQ1V6c0JOQkZ2d1NjY0JDQUM5S3lWWlJTNWFNYUc1
UGkwbg0KZng4YU5vczNiWXAyNDZNdGZhb0tCZlRRQXJkK0daVytXbkZ5SkVpU3lMZHowclV1dHlD
QWRmNWxnVkgrDQpXdkx2SW1pR3JTcnpWcE1UMm5DUzA5THFMNTBRano4QTdncDVIL2hRenRaOGlO
eXNHRDlOTzQ2T25JNzUNCjkwZEhmQ3JYalFQU0Z0RkdzVHpnRHhRSWlNdXp6OURSN0Jla0tQbXVP
RkloQmU5ZUVacWJ4YzhSV2VRdA0KaGE3aS9EckpUUk5LMWFPQURRRlZ1VjEvQW01VGhHUFdGTS9Z
SlV5VFloTVcweWVQaDQ1T2JXdVJRWmtzDQpsK2FPbTRMMEtHRERZbG0vRlF4L0VNQ3Vidmx6eS96
eERkQjZucUZpaDJxWnJmeW1uaVNPS2FqRzBqb1QNCnBab3ovRXorNGZBdGc2eTBQc3BOUjZpZEFC
RUJBQUhDd0drRUdBRUlBQk1GQWx2d1NjY0pFRStYblBacg0Ka0xpZEFoc01BQW9KRUUrWG5QWnJr
TGlkUmUwSC9qNUNJRklBdWN1YWlFTWtMa05LRUFPNXM3eDQ3ZU55DQpHUGZac2x5WStIanpHVTBk
MDdNa2tHbVZrUFRWendxVnpOWmJueTdaQXYxemxXMFV5MHlIcDFBUHB5WXQNCjhidVVwcFRCcTdk
NDdvZ3hFUll6dC9MYzJMNWEvVktGTlJiaE4xL1hRbVBpejJFbGU0dHlpcGJUYXBjeQ0KK3pieWZ6
QU1EMTNjSWRaMTNoVHNOUDBvbGdCaEFxVUFVVVlweFJsa0FIZUorRHQzTmJ6SFM0S1FLNTM4DQpO
Si9sN2JYU0tzR3FvWXFKZVo4Vk5CeHdXV1VidUc0ampyaDQzTUlSZ1VaNVdzUFVZVjZIeDA1NmtN
amINCi9iWUJqSTBURU12SDgxNjB1cXpGWGVIdll5VWxxMFNpbkQvWjlpb0llOFFkc0hHQkRVSVJZ
WXViMXBPOA0KcXJDelJaeDBvTkE9DQo9L0RlYQ0KLS0tLS1FTkQgUEdQIFBVQkxJQyBLRVkgQkxP
Q0stLS0tLQ0K

--b1_8HDLvpoi1vF9Ed8BpsA1TUhOyFobvvgAH4GJd84fo
Content-Type: application/pgp-signature; name="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - tincantech@...2282... - 0x09BC3D44.asc.sig"

sROkDgryUUOkbZXyZJUTgelwcXJFyzFGKCej1MvPGIzpOdOZMu8VfSkOZnsLjYcWf4szrv4hTi36
Pg1U

--b1_8HDLvpoi1vF9Ed8BpsA1TUhOyFobvvgAH4GJd84fo--


