Message-ID: <53263C71.5020900@...515...>
Date: Sun, 16 Mar 2014 18:06:09 -0600
From: James Yonan <james@...515...>
MIME-Version: 1.0
References: <20A288CF-1387-4616-B6C4-9DAEADAB02A7@...1837...>
	<CAA1Abx+WKEMwkcKA-VmNF7oLEN3+KRNACeKY+fHZGcNodJF0ww@...278...>
In-Reply-To: <CAA1Abx+WKEMwkcKA-VmNF7oLEN3+KRNACeKY+fHZGcNodJF0ww@...278...>
Subject: Re: [Openvpn-devel] TLS (SSL) handshake upon reconnecting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

On 14/03/2014 05:53, Steffan Karger wrote:
> Hi,
>
> On 03/13/2014 10:37 PM, Abdullah Alshalan wrote:
> > Hi,
> > I have a few questions about OpenVPN and I would appreciate if you 
> can answer whatever you can.
>
> I'll give it a try. I assume these questions relate to the 'Triple 
> Handshake'-attack (https://secure-resumption.com/). I do not 
> understand all the details of the attack, but I can tell you what I 
> know about OpenVPN.
>
> > 1- Does OpenVPN use a lightweight SSL handshake upon automatic 
> reconnection?
>
> No. OpenVPN does not initiate TLS session renegotiation or resumption. 
> The renegotiation messages in OpenVPN connection logs relate to 
> OpenVPN's data-session key renegotiations, which are not affected by 
> this attack. For OpenVPN's control channel, it heavily depends on the 
> underlying crypto library, either OpenSSL of PolarSSL.
>
> The OpenSSL builds of OpenVPN however might respond to session 
> renegotiations initiated by a malicious server, I'm not completely 
> sure on OpenSSL's behaviour. It is not clear to me whether a 
> mitm-initiated renegotiation is enough to mount the secure-resumption 
> attack.
>
> The PolarSSL builds of OpenVPN have session renegotiation disabled, 
> and will not participate in session renegotiation at all. These are 
> thus not affected.

My understanding, based on discussions with Dr. Stephen Henson of the 
OpenSSL project, is that OpenVPN (when built with OpenSSL) is protected 
from the Triple Handshake attack because we declare a verification 
callback method that verifies the peer certificate.

The Triple Handshake attack can only succeed if the attacker is able to 
force a mid-session certificate change that bypasses certificate and 
identity verification on the client.

But because OpenVPN declares a verification callback:

SSL_CTX_set_verify (ctx, SSL_VERIFY_PEER | 
SSL_VERIFY_FAIL_IF_NO_PEER_CERT, verify_callback);

and because the OpenVPN verification callback always returns a failure 
status if peer certificate verification fails, it means that the attack 
could only succeed if the attacker has a cert and private key already 
trusted by the client, i.e. the server cert was signed by the CA 
declared in the client config file, and trusted by other identity checks 
required by the client config (such as tls-remote, remote-cert-tls, 
ns-cert-type, etc.).  But if this were the case, then the client would 
already be vulnerable to MiTM attacks, even in the absence of the Triple 
Handshake attack.

So given that (a) the verify callback is always called on the client 
when the server presents a certificate, and (b) the verify callback 
cannot be bypassed by a mid-session certificate change operation 
initiated by the server, I think we are safe for now.

>
> > 2- If so, when does OpenVPN do a full handshake vs. lightweight 
> (abbreviated) handshake?
>
> See above.

OpenVPN doesn't rely on SSL/TLS renegotiation and always does a full 
handshake from scratch when renegotiating.

>
> > 3- Does it renogotiate the master key upon reconnection?
>
> On any TLS errors reported by OpenSSL, OpenVPN shuts down the previous 
> TLS session, and starts a new session from scratch. It relies on 
> OpenSSL to do the master key renegotiation.
>
> > 4- In a mobile environment, would it be better to replace openssl 
> with WTLS? what's your take on that?
>
> I don't know. WTLS has some interesting properties for mobile 
> environments, but its security has not been researched as thoroughly 
> as TLS's. It differs enough from TLS to require its own thorough analysis.
>
> On a final note, I would like to recommend everybody to use OpenVPN's 
> 'TLS auth'-keys. These add another layer of security to the TLS 
> channel, and protect against both DoS and MitM attacks on TLS.
>

I would be concerned about some of the shortcuts in WTLS that reduce 
security such as digest truncation.  Just Google for "attacks against 
the WTLS protocol".

James


