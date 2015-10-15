From: Arne Schwabe <arne@...1227...>
References: <1425307803-14166-1-git-send-email-lstipakov@...277...>
	<1444747558-23291-1-git-send-email-lstipakov@...277...>
Message-ID: <561F9529.6030309@...1227...>
Date: Thu, 15 Oct 2015 13:59:37 +0200
MIME-Version: 1.0
In-Reply-To: <1444747558-23291-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH v3] Notify clients about server's
 exit/restart
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Lev Stipakov <lstipakov@...277...>, openvpn-devel@lists.sourceforge.net



Am 13.10.15 um 16:45 schrieb Lev Stipakov:
> When server exits / restarts (gets SIGUSR1, SIGTERM, SIGHUP, SIGINT) and
> explicit-exit-notify is set, server sends RESTART control channel command to
> all clients and reschedules received signal in 2 secs.
>
> When client receives RESTART command, it either reconnects to the same server or
> advances to the new one, depends on parameter comes with RESTART
> command - behavior is controlled by explicit-exit-notify in the server config.
>
> v3:
>  - Use control channel "RESTART" command instead of new OCC code to
> notify clients
>  - Configure on the server side (by value of explicit-exit-notify) if
> client should reconnect to the same server or advance to the next one
>  - Fix compilation when OCC is disabled (--enable-small)
>  - Update man page
>
>
This gets an ACK from me. As additional note, we should add a follow up
that a server shutting down should not accept new clients. My client
reconnects in the 2s shutdown interval.

Arne

