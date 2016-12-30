References: <586339C7.2606.801611@...2224...>
	<940951cb-b3e9-f2e9-dea8-43a848bce446@...515...>
	<CAKuzo_jG4Qe9oidqkH0Cy63puNTNimQORtFCEDFZvKVajz-vdg@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <e4923fba-bce1-7e5c-3737-6b32c4d99d8a@...1856...>
Date: Fri, 30 Dec 2016 12:21:30 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jG4Qe9oidqkH0Cy63puNTNimQORtFCEDFZvKVajz-vdg@...278...>
Subject: Re: [Openvpn-devel] Fwd: Re: [Openvpn-announce] OpenVPN 2.4.0
 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 29-12-16 20:06, Selva Nair wrote:
>=20
> On Thu, Dec 29, 2016 at 5:53 AM, Samuli Sepp=E4nen <samuli@...515...
> <mailto:samuli@...515...>> wrote:
>     -------- Messaggio Inoltrato --------
>     Oggetto:        Re: [Openvpn-announce] OpenVPN 2.4.0 released
>     Data:   Tue, 27 Dec 2016 22:04:23 -0600
>     Mittente:       Michael French <Mike@...2223...
>     <mailto:Mike@...2223...>>
>     A:      Samuli Sepp=E4nen <samuli@...515... <mailto:samuli@...515...>>
>=20
>     I installed 2.4 on a couple Windows 7x64 computers and all seems well.
>     I even got tls-crypt to work using the old ta.key file on both client
>     and server.

As a general rule of thumb:  if you change your cryptographic primitives
(here, exchange --tls-auth for --tls-crypt), also change your keys.  So
it would be best to generate a fresh tc.key, to replace your ta.key.

(In this case, reusing ta.key will *probably* not break the crypto, but
better be safe than sorry.)

>     However, I noticed in the documentation for 2.4 that the parameter
>     tls-version-min is supposed to work with the 'or-highest' option, but=
 it
>     does not.

Please specify what you mean when you say 'it does not'.  Do you get
connection errors?  Is a different-then-expected version negotiated?
Please elaborate.

>     I wish that it did work because I always want to run with the most
>     secure version of TLS and the 'or-highest' option would save me the
>     trouble of manually editing the TLS number every time it changes.
>=20
> I too find this option somewhat counter-intuitive. I think you can
> effectively get it set to the highest available version by specifying an
> insanely large number as the first parameter. For example,
>=20
> --tls-version-min 5.0 or-highest
>=20
> As 5.0 is larger than any available versions, the minimum will get set
> to the highest available (say Since 1.2).
>=20
> However, that will also make it impossible to connect to a server that
> doesn't support the said version.

Exactly this.  To clarify a bit more, there are two mechanisms to
enforce that the most secure version is used:

1) TLS version negotiation will automatically used the newest TLS
version *that both peers support*.  So if e.g. the server supports upto
1.2, and the client upto 1.1, TLS will negotiate 1.1.  OpenVPN does not
do any browser-like 'version fallback'.

2) To prevent any attacks on problems in the above mechanisms, or
enforce a specific version to be used, you can use OpenVPN's
--tls-version-min.  Using or-highest as Selva suggests will ensure that
the highest version support *by the local OpenVPN version* is required.
So if you peer does not support that version, the connection will fail.

Summarizing, only use --tls-version-min if you are sure that *all* peers
in you network support that version.  And if you do not use
--tls-version-min, TLS will automatically negotiate the highest version
that *is* possible to negotiate.

-Steffan

