Subject: Re: [Openvpn-devel] RE: [Openvpn-users] Windows tun driver
From: "James Yonan" <jim@...41...>
Message-ID: <twig.1063847557.28023@...41...>
In-Reply-To: <20030917224712.GA27967@...33...>
References: <946499570EB7294690F512C1EF182F881EB899@...102...> <twig.1063739039.66173@...41...>, <twig.1063739039.66173@...41...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Sep 17 18:17:03 2003
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Matthias Andree <ma+ovpnd@...31...>, openvpn-devel@lists.sourceforge.net

Matthias Andree <ma+ovpnd@...31...> said:

> On Tue, 16 Sep 2003, James Yonan wrote:
> 
> > While I do believe that the majority of Windows users will prefer a tap
> > interface, I say this simply because in my experience _most_ Windows users
> > prefer the option that is the easiest to configure.  Once you stop
> > automatically routing broadcasts and non-IP protocols, then you have to start
> > doing more configuration on Windows, i.e. setting up WINS servers and clients,
> > configuring samba differently, etc.
> 
> Would the TUN device really be much different from any random PPP
> device? Either is a point-to-point connection. Granted, with current
> Windoze versions, SMB and all that stuff isn't bound to PPP devices by
> default but is likely that the user wants it bound to TUN, however,
> there are convenience features like --ifconfig.

Yes, tun and ppp are very similar.  I know that the linux tun driver basically
just sets the ppp bits and the kernel does most of the work.

Windows kernel hacking is more complicated, as it requires a great deal more
support code to do even simple things.  I just did a wc *.[ch] on the source,
and ...

TAP-Win32 -- 3061 lines of code for TAP only
Linux TUN/TAP -- 699 lines of code for TUN and TAP

Incidentally, beta8 has an expanded --ifconfig function that works on both tun
and tap devices (including tap devices on windows).  It also has a --route
convenience function that figures out the appropriate per-platform syntax for
route, and it too works on windows.

James


