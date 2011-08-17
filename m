MIME-Version: 1.0
In-Reply-To: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
References: <1313588569-18927-1-git-send-email-heiko.hund@...1489...>
Date: Wed, 17 Aug 2011 16:59:10 +0300
Message-ID: <CAOazyz2vHfiUTEtpHO7r8-9sidJQLYWQyKdDBnMSERmfF5N3DA@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 0/3] better --auto-proxy support for
	Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Heiko Hund <heiko.hund@...1489...>
Cc: openvpn-devel@lists.sourceforge.net

Won't it make it harder to configure openvpn as service?

On Wed, Aug 17, 2011 at 4:42 PM, Heiko Hund <heiko.hund@...1489...> wrote:
> Hi,
>
> the auto-proxy support for Windows was rather sub-optimal. Since Internet
> Explorer 5 proxy settings were configured with the network or VPN connect=
ion,
> but OpenVPN always queried the settings for the LAN connection. Truely au=
tomatic
> proxy configuration via WPAD and PAC script was not used, either.
>
> This patch series tries to change that. Auto proxy detetction is done with
> WinHTTP which has support for WPAD, PAC and per connection proxy settings.
>
> Another thing that is changed is the time at which the auto proxy config
> takes place in OpenVPN. Instead of doing it once during start-up, potenti=
ally
> changed settings are now fetched once every connect.
>
> Heiko Hund (3):
> =C2=A0add MinGW WinHTTP compatibility layer
> =C2=A0do automatic proxy detection on Windows right
> =C2=A0query auto-proxy information when connecting
>
> =C2=A0configure.ac | =C2=A0 30 ++++++++++
> =C2=A0init.c =C2=A0 =C2=A0 =C2=A0 | =C2=A0 23 ++++++-
> =C2=A0openvpn.8 =C2=A0 =C2=A0| =C2=A0 =C2=A09 ++-
> =C2=A0options.c =C2=A0 =C2=A0| =C2=A0 15 ++---
> =C2=A0options.h =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0proxy.c =C2=A0 =C2=A0 =C2=A0| =C2=A0173 +++++++++++++++++++++++++++=
++++++-------------------------
> =C2=A0proxy.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A04 +-
> =C2=A0win32.c =C2=A0 =C2=A0 =C2=A0| =C2=A0108 +++++++++++++++++++++++++++=
+++++++++
> =C2=A0win32.h =C2=A0 =C2=A0 =C2=A0| =C2=A0 61 ++++++++++++++++++++
> =C2=A09 files changed, 330 insertions(+), 95 deletions(-)
>
> Regards
> Heiko
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> Get a FREE DOWNLOAD! and learn more about uberSVN rich system,
> user administration capabilities and model configuration. Take
> the hassle out of deploying and managing Subversion and the
> tools developers use with it. http://p.sf.net/sfu/wandisco-d2d-2
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

