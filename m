From: James Yonan <jim@...41...>
Subject: Interface with GUI agent, was: Re: [Openvpn-devel] [Patch] revoke scripts were broken
References: <40E18559.8020407@...244...> <Pine.LNX.4.60.0406301609260.6264@...210...> <40E2DAEB.9060705@...83...>
In-Reply-To: <40E2DAEB.9060705@...83...>
MIME-Version: 1.0
Message-Id: <200406301202.59262.jim@...41...>
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
Date: Wed Jun 30 09:03:04 2004
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net
Cc: Jan Kiszka <jan.kiszka@...83...>, Mathias Sundman <mathias@...209...>

> I would furthermore suggest to discuss the required interface between
> the GUI and the OpenVPN daemon on this list. Starting and stopping would
> be possibly by just running the main binary, but I think a more
> sophisticated status and diagnosis interface requires some other
> mechanism (e.g. a local socket). Such an interface could furthermore
> prevent that the actual user who switches some configuration or just
> checks the status must own superuser privileges to start/stop a OpenVPN
> service and - even worse - read the secret key files.

Yes, I would like to see some kind of interface for control of OpenVPN from 
external programs.

The mechanism of the interface would be a socket on *nix or a named pipe on 
Windows.

The interface would primarily be for interaction with a GUI agent and would 
allow for:

* Stop/Restart control
* Get status (like SIGUSR2)
* Provide authentication info

James

