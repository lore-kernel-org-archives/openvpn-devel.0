Message-ID: <4D08AF47.9070204@...68...>
Date: Wed, 15 Dec 2010 13:06:31 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <4D021744.7010307@...515...>
	<4D060C34.7050801@...1147...>	<BF88BCF2F8AD5843B2250C5DB8DDE0AFBF2E418F@...1436...>	<4D063404.4050208@...1147...>
	<4D077FF4.7070001@...1147...>
In-Reply-To: <4D077FF4.7070001@...1147...>
Subject: Re: [Openvpn-devel] Using certificate chains
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

Am 14.12.2010 15:32, schrieb Jan Just Keijser:
> Hi all,
> 
> I hate to reply to my own posting but I managed to get certificate chains
> working. The trick is in setting up the stacked client certificate in the right
> order. Here's what I did:
> 
> ca.crt --- server.crt
>        +-- sub-ca.crt --- client.crt
> 
> the server is configured with --ca ca.crt and --cert server.crt
> the client is configured with --ca ca.crt and --cert stacked.crt where
> 'stacked.crt' is created using
>   cat client.crt sub-ca.crt > stacked.crt

Yes. Most software also accepts certificate bundles or chains where the
documentation mentions "certificate". This is usually UNDOCUMENTED.

This intermediate-CA and certificate chaining business (chain = daisy chain) is
not very widely known and often done wrong.  It is sort of mentioned somewhere
deep in the TLS IETF standards, and you can get to it with some thinking about
how the trust transition works, as you did -- but it does not usually propagate
to the software documentation.

I've been through all this before, and the result is:

http://gitorious.org/fetchmail/fetchmail/blobs/master/README.SSL-SERVER

It also applies with exchanged roles for client-to-server authentication with
X.509 certificates.

Since it's GPL-licensed, feel free to take parts of it for the OpenVPN
documentation.

-- 
Matthias Andree

