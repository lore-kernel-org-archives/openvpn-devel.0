Date: Sun, 8 Nov 2009 12:07:36 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091108090736.GA28760@...1066...>
References: <200911061921.nA6JLe7k088341@...1274...>
	<4AF5453E.7070808@...1114...>
	<1257605822.4466.3.camel@...1275...>
	<4AF5A594.1040105@...1114...>
	<1257628374.4466.9.camel@...1275...>
	<4AF5E9FF.1040305@...1273...>
	<4AF60012.7010904@...1114...>
MIME-Version: 1.0
In-Reply-To: <4AF60012.7010904@...1114...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN and OpenSSL TLS issue	?
	(CVE-2009-3555)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

On 2009.11.08 at 00:17:38 +0100, David Sommerseth wrote:

> 
> Well said!  Thank you for emphasising this.  In my earlier posts, I
> never intended to suggest that this was a work around, just to be clear
> about that.  But --tls-auth is now, how I see it, the only way currently
> available "immediately" (vs. waiting for openssl to be widely available
> on all distros) which can make you safer against the current SSL/TLS flaw.

Can anybody explain, how the "current SSL/TLS flaw" can be used to
exploit OpenVPN.

As far as I can understand this flaw is ability to upgrade secure
connection from non-authenticated to authenticated transparently to
application layer. If then application applies security context of the
upgraded connection retroactively to the data send by non-authenticated
client before upgrading, exploit is possible.

This is typical behavoir of HTTP servers, which allows https connection
without client authentication, and then request renegotiation based on
URL send by encrypted, but not-authenticated connection, and if proper
client certificate is supplied - perform request send before
authentication.

Moreover, attacker cannot even read result of this request, because it
is send over upgraded coonection.

So, it is not really applicable to any connection-based protocols which
maintain state. Only stateless HTTPS is vulnerable.
I cannot imagine even  IMAP exploit, because IMAP severely limits set of
commands, available in the pre-auth state.

But OpenVPN uses TLS for authentication and key negotiation only.
So, non-authenticated man-in-the-middle attacker cannot send any commands 
which would be executed after attacker hand connection over to
legitimate client.


