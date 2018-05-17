References: <20180417165000.3872-1-Jason@...2390...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <10978590-889a-0ccc-4cb8-31c862ee565c@...1856...>
Date: Thu, 17 May 2018 20:31:31 +0200
MIME-Version: 1.0
In-Reply-To: <20180417165000.3872-1-Jason@...2390...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Support fingerprint authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi Jason,

[ Dumping my thoughts so this doesn't remain completely unanswered for
even longer. ]

On 17-04-18 18:50, Jason A. Donenfeld wrote:
> OpenVPN traditionally works around CAs. However many TLS-based protocols also
> allow an alternative simpler mode in which rather than verify certificates
> against CAs, the certificate itself is hashed and compared against a
> pre-known set of acceptable hashes. This is usually referred to as
> "fingerprint verification". It's popular across SMTP servers, IRC servers,
> XMPP servers, and even in the context of HTTP with pinning.
> 
> So, I'd like to propose an extremely simple and non-invasive way of
> supporting this in OpenVPN, by re-using several features that already
> basically support it. Namely, what I propose is:
> 
>    * Allow specifying 'none' to the --ca parameter, to specify that
>      certificates should not be checked against a CA. Note that 'none'
>      is already used in other similar options as a special placeholder.
> 
>    * When '--ca none' is in use, --verify-hash checks all depths instead
>      of just level 1.
> 
> With these very simple changes, fingerprint authentication is easily achieved
> via the --tls-verify script on the server and via --verify-hash on the client.

Adding support for fingerprint authentication sounds like a good idea to
me.  Even if it was just to simplify config for peer-to-peer and small
(home) setups by getting rid of the need to create and maintain a CA.
So: feature Ack.

However, if we were to add this, I think I'd rather make it a
first-class citizen.  For example by adding a peer fingerprint
verification option that works in both client and server configs, and is
mutually exclusive with --ca.  I'd expect such an option to accept an
(inline-able) file that contains a list of fingerprints, so one can make
a config like:

<allowed-peers>
AA:BB:CC:DD:..
AA:BB:CC:DE:..
</allowed-peers>

Or maybe base64 fingerprints, because a lot of people have been trained
by SSH to recognize short base64 strings as fingerprints.

Anyone else from the community that has some thoughts on this?

As for implementation:  I'm already having problems getting to my review
queue, so am not promising to implement this.  I would definitely put a
patch for this on my review queue though :)

-Steffan

