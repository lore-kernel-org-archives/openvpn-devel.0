Message-ID: <fbbe96e9-ced3-472b-94f5-5acb95928da1@...1823...>
Date: Thu, 6 Jun 2024 17:23:31 +0400
MIME-Version: 1.0
References: <ZmGqRY9vRywrLUHD@...1296...>
Content-Language: en-US
From: Dmitry Melekhov <dm@...1823...>
In-Reply-To: <ZmGqRY9vRywrLUHD@...1296...>
Subject: Re: [Openvpn-devel] windows client tests needed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

06.06.2024 16:23, Gert Doering пишет:

Hello!

> We used to have
>
>    block-outside-dns
>
> to prevent Windows from doing DNS lookups "around the VPN" - the main
> intent of this was "make sure split DNS works", but a side effect has
> also been "avoid DNS leaks".
>
> Heiko has now extended this code to be able to "block everything not
> going into the VPN".  To activate this, you need
>
>    redirect-gateway def1 block-local
>
> in your config ("block-local" is the keyword, but without "def1" you
> end up with a split-tunnel and "nothing else is allowed", which is rarely
> a really good combination).
>
> Repeat: if "redirect-gateway block-local" is active, NO packets leave
> via LAN/WiFi/... interfaces, except those sourced by the openvpn.exe
> process.  This is important for maximum privacy, especially if you
> roam into a network with an untrusted DHCP server.
Will

redirect-gateway def1 block-local

also apply block-outside-dns ?

Thank you!


