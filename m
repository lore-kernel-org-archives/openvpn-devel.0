From: Matthias Andree <ma+ovpnd@...31...>
Subject: Re: [Openvpn-devel] Re: [Openvpn-users] Re: Simultaneous Access to Console Management
Message-ID: <20051109195003.GA4429@...33...>
References: <436a8b64.270ba42e.5f77.6a8d@...492...> <Pine.LNX.4.58.0511031825100.13189@...41...> <87y844tm53.fsf@...483...> <Pine.LNX.4.58.0511041159110.13189@...41...>
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0511041159110.13189@...41...>
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
Date: Wed Nov  9 11:50:23 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On Fri, 04 Nov 2005, James Yonan wrote:

> > James> The management interface doesn't close the listening socket
> > James> when it's connected to a client, because then it would need to
> > James> reopen it after the client disconnects, and for various reasons
> > James> this causes problems (especially when privileges have been
> > James> dropped).
> > 
> > Can't you at least do a listen(fd,0) while a client is connected and
> > revert to listen(fd,1) when the server is waiting?
> 
> [moving this thread to openvpn-devel]
> 
> Unfortunately that won't work.  The second parameter to listen() is only a
> hint to the OS for advisory purposes.  Setting it to zero does not appear
> to be a portable method of temporarily rejecting new connections.
> 
> Having said that, I don't particularly like the current behaviour.  It
> would be nice if new connections would fail when a management client is
> already connected.  The original version of the management interface
> closed the listening socket once a client connected and reopened it when
> the client disconnected.  This was only changed to the current behavior
> when problems arose with the repeated closing and reopening of the
> listening socket.

I may have missed part of the story (not reading openvpn-users@...493...), but
how about accept()/close(), perhaps with an error message before the close()?

The client sees the message (if one is sent), "connection reset by peer"
and that's it. It's not too polite, but if it's a "one administration
client only" model, probably the most portable, and at least the client
might have a clue about what is going on.

-- 
Matthias Andree

