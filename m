Date: Mon, 9 Nov 2009 00:29:51 +0300
From: Victor Wagner <vitus@...1066...>
Message-ID: <20091108212951.GA17607@...1066...>
References: <200911061921.nA6JLe7k088341@...1274...>
	<4AF5453E.7070808@...1114...>
	<1257605822.4466.3.camel@...1275...>
	<4AF5A594.1040105@...1114...>
	<1257628374.4466.9.camel@...1275...>
	<4AF5E9FF.1040305@...1273...>
	<4AF60012.7010904@...1114...>
	<20091108090736.GA28760@...1066...>
	<4AF6B2B3.1070906@...1114...>
MIME-Version: 1.0
In-Reply-To: <4AF6B2B3.1070906@...1114...>
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

On 2009.11.08 at 12:59:47 +0100, David Sommerseth wrote:

> 
> This flaw makes it, how I have understood it, possible to "duplicate" an
> on-going SSL connection (or transaction, which it often is referred to),
> making the SSL based server believe those two connections are the same
> client.

> The MITM attacker sends a SSL/TLS protocol renegotiation request to the
> server, the server responds to it back to the attacker, where the
> attacker and the server agrees on a new transaction protocol.  Then the
> attacker sends this server response back to the original client, and the
> client continues as before.

> I also understand it that the attacker cannot read the traffic from the
> client, but the attacker now got an accepted channel which the server
> now recognises equally as the client channel.  So it is kind of like a
> hidden hijack of an on-going connection.

No. It only makes it possible to send few packetes which server would
misinterpret as coming from legitimate client. Once real ClientHelo
message from legitimate client is send, and renegotiation takes place,
attacker can't neither read nor send any information to the server.

Problem is that HTTPS server typically don't care whether information
was send before renegotiation or after. It assembles both information
into one HTTP request and executes it.

Attack is only applicable to the situation where same server accepts
both non-authenticated and authenticated connections on the same port,
and allows clients to upgrade connection from non-authenticated to
authenticated. 

I'm not sure that this behavoir is not possible at all with OpenVPN, but
I've never seen such a configuration. Either client certificates are
required (so MitM cannot perform first handshake) or are not required at
all. 

With HTTPS it is also possible to hijack connection with basic auth (i.e
with username/password send via TLS=encrypted channel) using this
renegotiation mechanism. But only because action is send as first line
of HTTP-request and WWW-Authenticate header - later. 

For any protocol which requires client to authenticate itself before
sending commands, this attack is not applicable.

This is why this flaw go unnoticed for so many years.


