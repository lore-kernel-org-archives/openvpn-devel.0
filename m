Message-ID: <4AF60012.7010904@...1114...>
Date: Sun, 08 Nov 2009 00:17:38 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <200911061921.nA6JLe7k088341@...1274...>	<4AF5453E.7070808@...1114...>	<1257605822.4466.3.camel@...1275...>	<4AF5A594.1040105@...1114...>	<1257628374.4466.9.camel@...1275...>
	<4AF5E9FF.1040305@...1273...>
In-Reply-To: <4AF5E9FF.1040305@...1273...>
Subject: Re: [Openvpn-devel] [Openvpn-users] OpenVPN and OpenSSL TLS issue ?
	(CVE-2009-3555)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Leonardo Rodrigues <leolistas@...1273...>, openvpn-devel@lists.sourceforge.net
Cc: ML OpenVPN <openvpn-users@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 07/11/09 22:43, Leonardo Rodrigues wrote:
> 
>     just to make clear, using tls-auth is NOT a 'current workaround'. It 
> was always on the documentations and it's use was always recommended.
> 
> 
> from OpenVPN Security Overview
> http://openvpn.net/index.php/open-source/documentation/security-overview.html
> 
> 
> One notable security improvement that OpenVPN provides over vanilla TLS 
> is that it gives the user the opportunity to use a pre-shared passphrase 
> (or static key) in conjunction with the --tls-auth directive to generate 
> an HMAC key to authenticate the packets that are themselves part of the 
> TLS handshake sequence. This protects against buffer overflows in the 
> OpenSSL TLS implementation, because an attacker cannot even initiate a 
> TLS handshake without being able to generate packets with the currect 
> HMAC signature.
> 
> 
> 
> from OpenVPN HOWTO
> http://openvpn.net/index.php/open-source/documentation/howto.html
> 
> 
> 
> Hardening OpenVPN Security
> 
> One of the often-repeated maxims of network security is that one should 
> never place so much trust in a single security component that its 
> failure causes a catastrophic security breach. OpenVPN provides several 
> mechanisms to add additional security layers to hedge against such an 
> outcome.
> 
> tls-auth
> 
> The tls-auth directive adds an additional HMAC signature to all SSL/TLS 
> handshake packets for integrity verification. Any UDP packet not bearing 
> the correct HMAC signature can be dropped without further processing. 
> The tls-auth HMAC signature provides an additional level of security 
> above and beyond that provided by SSL/TLS. It can protect against:  [ 
> ... continues ... ]

Well said!  Thank you for emphasising this.  In my earlier posts, I
never intended to suggest that this was a work around, just to be clear
about that.  But --tls-auth is now, how I see it, the only way currently
available "immediately" (vs. waiting for openssl to be widely available
on all distros) which can make you safer against the current SSL/TLS flaw.

Having said that, --tls-auth is really recommended to increase the
overall security, no matter if there is a flaw in the SSL/TLS layer or
not.  So Leonardo Rodrigues got a good point here.

I just wanted to make sure my earlier messages would not be
misunderstood further.

But to be honest, it would be greatly appreciated if an official
statement about how the developers see the situation as well.  This is
such a critical flaw which really need some critical eyes into the
OpenVPN code by someone who can understand it well.  Just to confirm or
reject the current assumptions.  I'm not comfortable with the little
discussion this thread has generated.


kind regards,

David Sommerseth




> Mr. Olli escreveu:
>> Hi,
>>
>> I understand your point. tls-auth seems to be the best work-around
>> currently.
>>   
> 
> 

(further info about mail thread from openvpn-users list)

> On Sat, 2009-11-07 at 11:00 +0100, David Sommerseth wrote:
> > > On 06/11/09 20:21, Mike Tancsa wrote:
>>>> > >>>> Hi Everyone,
>>>> > >>>>          Just wondering if the issue identified at
>>>> > >>>> http://extendedsubset.com/ impacts OpenVPN.
>>>> > >>>>
> > >
> > > I've read through the proposed RFC [1] for a fix to the TLS
protocol.  I
> > > am by no means a security expert, but from what I can understand this
> > > can be a potential issue for OpenVPN as well.  Anyhow, the solution is
> > > most probably not to fix OpenVPN but the TLS protocol.  But I do
see one
> > > feature which can make OpenVPN a little bit safer in the mean
time, more
> > > on that later on.
> > >
> > > A simple explanation, how I've understood it:  The problem is that the
> > > TLS and SSL protocols allows a renegotiation of the secured channel.
> > > This even happens in clear text, as far as I can understand.  The
> > > problem is that this is now discovered to be prune to a MITM attack.
> > > The attacker can issue such a renegotiation request to an already
> > > on-going secured channel, and then the attacker will send the
agreed TLS
> > > handshake further to the client.  The attacker will not be able to
read
> > > the the client-server traffic, but when the attacker can now
contact the
> > > server, where the server do not differentiate the traffic from the
> > > attacker or the real client.
> > >
> > > The proposed solution is to extend the TLS protocol with a 12
bytes long
> > > string with information generated during the first initial
negotiation,
> > > as a way to authenticate the renegotiation request.  On clients which
> > > supports this sends this info to a server and the server do not
respond
> > > back in this information, it should close the connection.
> > >
> > > On the server side, the server should decline to renegotiate the
channel
> > > unless the client supports this new feature.  That way, a connection
> > > will not be closed on the server side with older clients which don't
> > > support this feature but prevents a MITM attack.
> > >
> > > In regards to OpenVPN, I don't know how OpenVPN will react if it
> > > receives network packets which the OpenSSL implementation believes is
> > > from a trusted host, while it in reality is a attacker.  And
further, I
> > > don't know how OpenVPN will handle the situation of one real
client and
> > > in parallel having an active channel to an attacker.  I don't believe
> > > the OpenVPN protocol does any kind of authentication of the decrypted
> > > OpenVPN packets.  This should really be investigated further, to
see the
> > > complete impact of this failure in the SSL/TLS protocols.
> > >
> > > The solution which I believe can be OpenVPN's way how to handle this
> > > situation until OpenSSL is fixed is to make use of the --tls-auth
> > > feature.  This implies the clients must have a distributed static
key in
> > > addition, and the OpenVPN server will not respond to network packets
> > > which do not provide correct HMAC control packets which is based
on this
> > > static key.
> > >
> > >
> > > kind regards,
> > >
> > > David Sommerseth
> > >
> > >
> > >
> > > [1]
> > >
<http://svn.resiprocate.org/rep/ietf-drafts/ekr/draft-rescorla-tls-renegotiate.txt>
>> > >>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkr2AA0ACgkQDC186MBRfrpicwCfRH/opiP9uu089kEVTS2rCpml
oBAAnA/PfonQetaogJfL49ntXDT6rMPe
=z6Ww
-----END PGP SIGNATURE-----

