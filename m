From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] askpass and key-method 2
In-Reply-To: <20041016182529.74188.qmail@...295...>
Message-ID: <Pine.LNX.4.58.0410162131010.12753@...269...>
References: <20041016182529.74188.qmail@...295...>
MIME-Version: 1.0
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
Date: Sat Oct 16 20:46:01 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Jan Jaeger <pa3efu@...109...>
Cc: openvpn-devel@lists.sourceforge.net

On Sat, 16 Oct 2004, Jan Jaeger wrote:

> Hi list,
> openvpn v2 now defaults to key-method 2, which means
> that the key exchange now takes place over the tls
> channel rather then encrypted with the private key of
> the user. 
> As a result of this the private key of the user is no
> longer required.  The additional security that the
> passphase provides is no longer there.  Anyone who has
> a copy of the public key can now setup a session.
> I think this is somewhat of an integrity exposure. 
> Is this working as designed?

I'm not sure that you're understanding this correctly.

The only difference between key method 1 and 2 is this:

1: tunnel session keys are derived from RAND_bytes

2: tunnel session keys are derived from RAND_bytes passed through
   TLS PRF function.

I think you might be misunderstanding the fact that there are two 
separate levels of keying occurring here.

(1) First there is the TLS connection which is negotiated, with both sides
of the connection producing certificates and verifying the certificate of
the other side.  The key-method parameter has no effect on this process.

(2) After the TLS connection is established, the tunnel sessions keys are
separately negotiated over the existing secure TLS channel.  Here,
key-method determines the derivation of the random tunnel session keys.

The only part of this process affected by an encrypted private key, is
that the TLS initialization (before step 1 above) passes the file-stored
private key through a decryption algorithm using the --askpass password as
the decryption key.  This process occurs locally before the TLS handshake
even begins.

So there's really no interaction between --askpass and --key-method.  
--askpass affects step (1) while --key-method affects step (2).

James

