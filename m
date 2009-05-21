MIME-Version: 1.0
In-Reply-To: <20090521063658.GB28090@...1221...>
References: <4A13BBB4.8020101@...41...>
	<20090520093956.GA18980@...33...>
	<20090521063658.GB28090@...1221...>
Date: Thu, 21 May 2009 09:51:36 +0300
Message-ID: <9e0cf0bf0905202351u56559c42pbc5db3c1b6de51b@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc16 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Felix Kronlage <fkr@...1138...>
Cc: openvpn-devel@lists.sourceforge.net

On 5/21/09, Felix Kronlage <fkr@...1138...> wrote:
> On Wed, May 20, 2009 at 11:39:57AM +0200, Matthias Andree wrote:
>
>  > + release openvpn 2.1 without Windows GUI as soon as you believe it's done
>  >    * your changelog below suggests that RC16 needs more than just
>  >      a week of testing
>  > + stabilize (through beta and RC) the Windows GUI as a separate add-on
>  >   package (if you want, these test releases can then comprise 2.1_rc,
>  >   2.1.0, 2.1.1, ... whichever is current, for user convenience)
>
>
> ack.
>  Small and fast release cycles. At least 'fast' compared to now would
>  be nice.

Yes...
OpenVPN has several separate components, each can be released separately:

1. OpenVPN core (Source).
2. OpenVPN easy-rsa (Source)
3. OpenVPN binaries (Whoever use this, Windows is important).
4. OpenVPN TAP device (Windows only, device driver).
5. OpenVPN UI (Windows only, binary?)
6. OpenVPN Windows Installer (Installer + OpenVPN Windows binaries +
easy-rsa + Tap + UI)

It would be much easier if every component has its own version and dependency.

For example OpenVPN-2.1 requires >=TAP-1.0.5 on target machine.
OpenVPN-2.1-win32-build-22 is build 22 out of OpenVPN-2.1 sources.
OpenVPN-2.1-installer-23-x86 - is installer version 23 for x86 which
is a bundle of OpenVPN-2.1-win32-build22, easy-rsa-2.0.2, tap-1.0.5,
UI-2.2.2

etc...

Alon.

