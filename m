Subject: Re: [Openvpn-devel] Sending signals to a process in Windows
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1092497811.54687@...41...>
In-Reply-To: <Pine.LNX.4.60.0408141718400.7916@...210...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Aug 14 08:37:02 2004
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>, openvpn-devel@lists.sourceforge.net

Mathias Sundman <mathias@...209...> said:

> I'd like my Windows OpenVPN GUI to be able to send signals to the openvpn 
> processes.
> 
> Is it possible to send signals (like SIGHUP, SIGUSR1) to processses in 
> Windows? How?

Windows doesn't really have signals like *nix.

When I want something signal-like I usually use a named Windows event object
(see CreateEvent).

Then if you have an event loop which you want to be signalable, just add the
handle returned by CreateEvent to the list of handles you are waiting for.

> If not, how do I pass a scancode (like a function key) to a Pipe? I've 
> used WriteFile() to pass the passphrase string, but that can only contain 
> ASCII chars, right?

Not sure about scancodes <-> pipes.  As far as getting scancodes, see the
win32_keyboard_get function in win32.c.

James


