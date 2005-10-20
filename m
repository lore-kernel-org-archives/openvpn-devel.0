From: Mike Ireton <mike-openvpn@...479...>
Message-ID: <dj8qb7$3fp$1@...165...>
References: <dj6pnr$gs4$1@...165...> <Pine.LNX.4.61.0510200952100.9328@...210...>
Mime-Version: 1.0
In-Reply-To: <Pine.LNX.4.61.0510200952100.9328@...210...>
Subject: [Openvpn-devel] Re: Bug report (long) - OpenVPN dropping small frames
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
Date: Thu Oct 20 12:19:40 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Mathias Sundman wrote:

> 
> Then try using the --fragment option with a rather low value which will 
> cause OpenVPN todo internal fragrentation to avoid IP fragmentation and 
> see if the frags goes away, and hopefully the problem as well!

	A problem with this - which I am open to doing if it does solve the 
problem - is that I have a number of clients and this option apparently 
isn't a negotiated option, so if I enable it on the server, I have to 
enable it on all clients and restart all of them, which would be hugely 
disruptive and not an option at this point in time.

Thanks for the suggestion.


