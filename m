MIME-Version: 1.0
References: <20200725235023.22441-1-arne@...1227...>
In-Reply-To: <20200725235023.22441-1-arne@...1227...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 25 Jul 2020 20:31:29 -0400
Message-ID: <CAEsd45Seh_4O1DmNcOBOwWknZKi4oDSTfVC+L3OAAOTP=OCFuA@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Include utun device number in utun
 error messages
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sat, Jul 25, 2020 at 7:51 PM Arne Schwabe <arne@...1227...> wrote:
>
> For lack of a better API (or knowledge about a better API) we try to
> open utun devices on macOS by trying utun0 to utun255 and use the
> first one that works. On my Mac I have already 4 devices that
> do nothing but are just there and another VPN connection resulting in a
> number of error messages. This explicitly  shows in the log that we
> tried the devices instead of some unspecific error.
>
> This changes the log from:
>
> Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opened utun device utun5
>
> to
>
> Opening utun0 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opening utun1 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opening utun2 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opening utun3 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opening utun4 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
> Opened utun device utun5

Feature-ACK. The failure messages have concerned some Tunnelblick
users. This _might_ help clarify things for them and it certainly
won't hurt.

I have not tested the code, but it looks fine.

Note that the last half of the patch consists only of whitespace
changes (starting at "@@ -5682,15 +5685,15 @@).

Note also that macOS itself creates some utun devices, which is why
the failures to open happen even on a clean install of macOS and only
OpenVPN. The number created depends on the version of macOS and the
Apple services such as iCloud Drive and Screen Sharing that are
enabled.

Best regards,

Jon Bullard

