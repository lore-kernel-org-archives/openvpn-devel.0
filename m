MIME-Version: 1.0
References: <CAHmME9r1VmJLSqrb8vQN3HOqeVX2QLs1-9wPYQL-UwNU6EJNLA@...278...>
 <0fe186bb-7df2-e3c4-cccd-b3b624fbc1bf@...1227...>
In-Reply-To: <0fe186bb-7df2-e3c4-cccd-b3b624fbc1bf@...1227...>
From: "Jason A. Donenfeld" <Jason@...2390...>
Date: Mon, 25 Mar 2019 11:37:19 +0100
Message-ID: <CAHmME9rMuAXh97168Cdhh3NYPvX_On_rmn3+3+9hzMuYGv9s1g@...278...>
Subject: Re: [Openvpn-devel] [ANNOUNCE] Wintun: Layer 3 TUN Driver for
 Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Arne Schwabe <arne@...1227...>
Cc: WireGuard mailing list <wireguard@...2500...>, openvpn-devel@lists.sourceforge.net, dev@...2501..., Simon Rozman <simon@...2293...>

Hey Arne,

On Mon, Mar 25, 2019 at 11:23 AM Arne Schwabe <arne@...1227...> wrote:
> I wish you good luck in this endeavour and welcome the prospect of
> having a better tun driver for Windows. We know that our own TAP/TUN
> driver is a pain point for us as well and having a better alternative is
> something we would definitively like to have/support a more modern driver.
> The lack of tap is not a big deal for OpenVPN anymore. The world shifted
> quite a bit and tap support is not needed that much anymore. Android
> does not support it. MacOS client supports tun natively (utun) and tap
> requires extra kext. And so on...

That's good to know. I wasn't aware that that perspective was there
for OpenVPN as well. It certainly makes things simpler. In that case,
I'll certainly try to continue to keep OpenVPN in mind when developing
this. And depending on everybody's time availability, maybe at some
point we could work together in adding experimental support for Wintun
in OpenVPN.

> I am afraid our project members are currently busy and cannot really
> contribute much to your new shiny driver. We barely have enough time for
> OpenVPN itself. But if you have something that is good enough at least
> for testing and has a reasonable stable API just an extra mail and I
> think we can implement it as alternative to our own driver.

Great. I'll send a follow-up when we're at that point. At the moment
we're working out some details with IO_CSQ, and then we'll try to put
together some half-decent API documentation to make this easy. Then,
I'll poke you and we can get rolling with this.

> Frome the site: The source code is provided under the GPL 2.0 and is
> available via git:
>
> One detail here. If you have/add a file that defines the API for
> external programs, to license it under a freeer license for 3rd party to
> include that API file without license worries. Like our tap-windows.h
> (https://github.com/OpenVPN/tap-windows6/blob/master/src/tap-windows.h).
> This was primarily requested by the Freeswan developer iirc.

That's a good point. I'll certainly do something like that. Or,
possibly I'll just relicense the whole driver to MIT so nobody has to
worry. Will give it some thought.

Jason

