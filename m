MIME-Version: 1.0
In-Reply-To: <CAHODtZThxjAUb-sZ4bA1Y238hPeK=zKGcSbU9d3nib+8rt0YMg@...278...>
References: <20171205121952.13008-1-EngyCZ@...277...>
 <CAKuzo_g6YTkx+-3i=TEFn9b2yPjx9rBweTz=4H7uuOT8VokEdg@...278...>
 <CAHODtZSTyD8NOc8cVNaGaZ9z+HZrKK-+L6h_t0gqhAh3pJMk+w@...278...>
 <CAHODtZQRb48Aa8AsxXoSnUUSLE27u-EjCOWavFJj7nwZqPYd7w@...278...>
 <CAKuzo_g8KXGKN-A-egEonQEFpkro5wb5OigDbycg0j_Ae=5Tow@...278...>
 <CAHODtZThxjAUb-sZ4bA1Y238hPeK=zKGcSbU9d3nib+8rt0YMg@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Mar 2018 12:17:05 -0400
Message-ID: <CAKuzo_gb4Sdqa3WLb=34kdwqvz507mKeyVyfhKvY6RassZz7Mg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Add a warning for disabled DHCP media
 sense on Window
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?SmnFmcOtIEVuZ2VsdGhhbGVy?= <engycz@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On Wed, Mar 14, 2018 at 3:32 AM, Ji=C5=99=C3=AD Engelthaler <engycz@...1354...=
..> wrote:
> Hi.
>   You right. Disabled dhcp media sense can be set as global for all
> interfaces or in adapter specific setting if it supports it (TAP supports
> it).
> But for must users is the global settings hidden deep in the system and f=
or
> me it took several months to find the cause of my problems. Interface
> specific settings can be cleared by uninstalling and reinstalling OpenVPN.

Well, Windows ships with media sense enabled, isn't it? So if its
disabled, either the user did that or some third party application did
it for some reason. Without knowing those unknowables, we can't even
decide whether to suggest the user to enable it back or not.

Whereas, using --dhcp-renew (or making it the default) looks much
simpler and something in our control. Anyone knows why it shouldn't be
the default?  I don't see how it could hurt except that openvpn needs
to fork to run --dhcp-renew when the parent process is waiting for the
the interface to get the address. But that's not a big deal on a
Windows client.

Selva

