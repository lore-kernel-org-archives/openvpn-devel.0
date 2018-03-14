MIME-Version: 1.0
In-Reply-To: <CAHODtZQRb48Aa8AsxXoSnUUSLE27u-EjCOWavFJj7nwZqPYd7w@...278...>
References: <20171205121952.13008-1-EngyCZ@...277...>
 <CAKuzo_g6YTkx+-3i=TEFn9b2yPjx9rBweTz=4H7uuOT8VokEdg@...278...>
 <CAHODtZSTyD8NOc8cVNaGaZ9z+HZrKK-+L6h_t0gqhAh3pJMk+w@...278...>
 <CAHODtZQRb48Aa8AsxXoSnUUSLE27u-EjCOWavFJj7nwZqPYd7w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 13 Mar 2018 23:33:26 -0400
Message-ID: <CAKuzo_g8KXGKN-A-egEonQEFpkro5wb5OigDbycg0j_Ae=5Tow@...278...>
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

On Tue, Mar 13, 2018 at 7:36 AM, Ji=C5=99=C3=AD Engelthaler <engycz@...1354...=
..> wrote:
>
> Any discussion / opinions ? Here https://github.com/OpenVPN/openvpn/pull/=
97#issuecomment-372530059
> one user reported, that this patch were useful for him.

Though I agree that checking for whether media sense is globally
disabled would help some, I'm not convinced that this is the right
approach. The media sense can be disabled on individual adaptors too
isn't it? -- say tap adaptor media status set as "always connected". And
that won't be caught or fixed by this check.

If dhcp-renew will cure this, why not just make --dhcp-renew the
default? That way we get rid of another config option and no new
code is needed. Is there an argument why that option should not be on
by default?

Selva

