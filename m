Message-ID: <1087183633.40cd1b1160ccc@...238...>
From: Brandon Knitter <knitterb@...237...>
Subject: Re: [Openvpn-devel] Windows Command Prompt vs. Systray Icon
References: <1087017394.40ca91b21df0c@...238...> <200406130001.48507.vda@...216...> <1087085913.40cb9d593793a@...238...> <Pine.LNX.4.60.0406132016470.4959@...210...>
In-Reply-To: <Pine.LNX.4.60.0406132016470.4959@...210...>
MIME-Version: 1.0
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
Date: Sun Jun 13 20:29:15 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net

> >> I had a few of my users ask why the Windows OpenVPN connection was in a
> >> Command Prompt window and not just a Systray Icon with a status window.

> I think it would be cleanest if such a gui could be created as a 
> standalone application that just calls the openvpn binary. What I'm not 
> clear about with such a setup is how the gui should be able to communicate 
> with openvpn to check it's status, and recieve error messages?

I'm actually considering a very simple SysTray icon which would print all the
STDOUT messages to a little textbox rather than a cmd prompt window.  I don't
think it would be terrible difficult, and adding in a little "Close Session"
button which mimics the F4 (SIGTERM?) action would ne simple.   You'd still get
all the messages and such, but it would minimize to the systray rather than a
cmd prompt.

Any thoughts out there?  Developers?  Should I waste my time?

--
-bk



