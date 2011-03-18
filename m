Date: Fri, 18 Mar 2011 15:43:25 +0100
From: Thomas Glanzmann <thomas@...1029...>
Message-ID: <20110318144325.GF26254@...1029...>
References: <20110317054155.GA9684@...1029...>
	<201103181331.51247.hhund@...194...>
	<20110318130226.GD26254@...1029...>
	<201103181442.48308.hhund@...194...>
MIME-Version: 1.0
In-Reply-To: <201103181442.48308.hhund@...194...>
Subject: Re: [Openvpn-devel] OpenVPN GUI and ntlm Proxy password
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net, info@...454...

Hello Heiko,

> > Fri Mar 18 13:56:53 2011 Error opening 'HTTP Proxy' auth file:
> > C:\DOCUME~1\adglth0\LOCALS~1\Temp\openvpn_authfile.: Das System kann die
> > angegebene Datei nicht finden.   (errno=2)

> That's a openvpn error message not one of the GUI. Did you see the dot
> (.) at the end of the filename? How does openvpn know about it? I
> don't see it mentioned in your configuration.

I used the configuration I sent, but configured in your version of the
GUI the following:

Right Click => Settings => Proxy

        [x] Manual Configuration

        [x] HTTP Proxy

        Address: proxy.corp.com Port: 8080

        [x] Prompt for username/password when connection.

I thought that the GUI now adds a line to the openvpn command line when
starting the config and writing out the above file, but it doesn't seem
to do that.  Am I mistaken?

See proxy configuration: http://thomas.glanzmann.de/tmp/guifork.png

When I try to connect I'm first asked by the gui for proxy login and
password and than for username and password for OpenVPN. After that I
get the message that it can't find the authentication files that I
thought the GUI would create containing login and password.

> >         - When using 'Intenet Explorer' to determine the proxy, it
> >           doesn't work with proxy pac but doesn't mention  it (the
> >           OpenVPN Gui 1.3 did mention that it doesn't work with proxy
> >           pacs).

> How or where did it mention this? I can't recall removing anything like it.

When I install openvpn 2.2 RC from the openvpn community website[1] it
says 'Use Internet Explorer Settings (manually configured)'. Your
version says 'Use Internet Explorer Settings'.

Gui that ships with 2.2 RC: http://thomas.glanzmann.de/tmp/legacy.png
Your Gui fork: http://thomas.glanzmann.de/tmp/guifork.png

[1] http://swupdate.openvpn.net/community/releases/openvpn-2.2-RC-install.exe

Cheers,
        Thomas

