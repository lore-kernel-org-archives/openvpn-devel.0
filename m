Message-ID: <4AF6B2B3.1070906@...1114...>
Date: Sun, 08 Nov 2009 12:59:47 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <200911061921.nA6JLe7k088341@...1274...>	<4AF5453E.7070808@...1114...>	<1257605822.4466.3.camel@...1275...>	<4AF5A594.1040105@...1114...>	<1257628374.4466.9.camel@...1275...>	<4AF5E9FF.1040305@...1273...>	<4AF60012.7010904@...1114...>
	<20091108090736.GA28760@...1066...>
In-Reply-To: <20091108090736.GA28760@...1066...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN and OpenSSL TLS issue
 ?	(CVE-2009-3555)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 08/11/09 10:07, Victor Wagner wrote:
> On 2009.11.08 at 00:17:38 +0100, David Sommerseth wrote:
> 
>>
>> Well said!  Thank you for emphasising this.  In my earlier posts, I
>> never intended to suggest that this was a work around, just to be clear
>> about that.  But --tls-auth is now, how I see it, the only way currently
>> available "immediately" (vs. waiting for openssl to be widely available
>> on all distros) which can make you safer against the current SSL/TLS flaw.
> 
> Can anybody explain, how the "current SSL/TLS flaw" can be used to
> exploit OpenVPN.
> 
> As far as I can understand this flaw is ability to upgrade secure
> connection from non-authenticated to authenticated transparently to
> application layer. If then application applies security context of the
> upgraded connection retroactively to the data send by non-authenticated
> client before upgrading, exploit is possible.
> 
> This is typical behavoir of HTTP servers, which allows https connection
> without client authentication, and then request renegotiation based on
> URL send by encrypted, but not-authenticated connection, and if proper
> client certificate is supplied - perform request send before
> authentication.
> 
> Moreover, attacker cannot even read result of this request, because it
> is send over upgraded coonection.
> 
> So, it is not really applicable to any connection-based protocols which
> maintain state. Only stateless HTTPS is vulnerable.
> I cannot imagine even  IMAP exploit, because IMAP severely limits set of
> commands, available in the pre-auth state.
> 
> But OpenVPN uses TLS for authentication and key negotiation only.
> So, non-authenticated man-in-the-middle attacker cannot send any commands 
> which would be executed after attacker hand connection over to
> legitimate client.

This flaw makes it, how I have understood it, possible to "duplicate" an
on-going SSL connection (or transaction, which it often is referred to),
making the SSL based server believe those two connections are the same
client.

The MITM attacker sends a SSL/TLS protocol renegotiation request to the
server, the server responds to it back to the attacker, where the
attacker and the server agrees on a new transaction protocol.  Then the
attacker sends this server response back to the original client, and the
client continues as before.

I also understand it that the attacker cannot read the traffic from the
client, but the attacker now got an accepted channel which the server
now recognises equally as the client channel.  So it is kind of like a
hidden hijack of an on-going connection.

OpenVPN does not do authentication of the clients continuously, it only
does it on the initial TLS connections, and during the the --reneg-*
configured phases.  I don't know if this authentication is also
triggered when the SSL/TLS protocol initiates a protocol renegotiation.
 And my fear is that it does not do that, which means such an attack can
let you sneak in into an VPN connection.

My reason for this fear, is that this protocol renegotiation is normally
handled by OpenSSL.  But as OpenVPN seems to use OpenSSL in a little bit
different way than normal implementations, it might be that this
implementation is safer against this particular flaw - this is really
unclear to me right now.

The reason for my suspicion is that the --tls-auth mechanism seems to be
encapsulated on top of the TLS layer. It seems like OpenVPN interacts
with the packets before it is sent to the OpenSSL layer.  While a more
traditional implementation just passes the established TCP connection
straight to the OpenSSL layer and uses OpenSSL functions to read and
write data.

Another thing is that, how I've understood the OpenSSL implementation,
the traditional implementations requires TCP for SSL to work, while
OpenVPN also supports SSL over UDP.  So OpenVPN has to do something
which is much more different than what other more traditional OpenSSL
implementations does.

Anyhow, if --tls-auth only triggers is a HMAC calculation on the packets
received before sending it to OpenSSL layer and the rest of the
implementation is more like traditional implementations, this makes it
required to use --tls-auth to avoid this SSL/TLS protocol flaw.  But if
OpenVPN have used an even more untraditional OpenSSL implementation, it
could be that the OpenVPN in theory is safer against this flaw.  This is
what I'm wondering about.

A few words on the more specifics about OpenVPN and its OpenSSL
implementation from the core developers would really be highly
appreciated now, to clear up the real facts and false assumptions.

For now, it seems to me that --tls-auth is the only way to protect
yourself against this flaw.  But if I'm wrong, I would like to know that
as well, to avoid spreading false information :)


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr2sq8ACgkQDC186MBRfrrPUwCgkb4x8ivi+j2RSC1m5TySeDcA
HycAnA1cWagvX2lY6BZZ5Dc/djPkHaMh
=Li4/
-----END PGP SIGNATURE-----

