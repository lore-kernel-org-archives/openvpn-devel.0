Message-ID: <03d501c22ee9$db3dbff0$1000000a@...4...>
From: "James Yonan" <jim@...3...>
References: <20020718220430.GG32636@...35...>
Subject: Re: [Openvpn-devel] Replay attacks
MIME-Version: 1.0
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=openvpn-devel>
Date: Thu Jul 18 23:01:03 2002
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: Michael Grigoriev <mag@...34...>, openvpn-devel@lists.sourceforge.net

Hi Michael,

You are right that it is not difficult for an attacker to replay UDP
datagrams.  OpenVPN uses a variant of the "sliding-window" algorithm used by
IPSec where each packet is tagged with a unique, incrementing sequence
number, allowing any replayed datagrams to be identified and dropped.

Various methods are used to ensure the uniqueness of the sequence number.
To prevent the sequence number from wrapping around in static-key mode
(which uses a long-term, pre-shared key), the sequence number is 64 bits,
where 32 bits is a unix timestamp at daemon initialization and the other 32
bits is an incrementing number.  If the incrementing number wraps to 0, then
we also update the unix timestamp to the current time.  In TLS mode we use
32 bits for the sequence number, with a mandatory re-keying if the sequence
number approaches its wrap around value.  See packet_id.c for the
anti-replay algorithm.

While it is true that block cipher chaining is made more complex due to the
unreliable nature of UDP transport (where packets can be dropped or received
out-of-order), OpenVPN (and IPSec as well)make each datagram atomic and
stateless by using an "Explicit IV" where the initialiation vector is
explicitly recorded in the datagram header, rather than being implicitly
assumed based on the residual IV of the previous datagram.  This means that
datagrams can be decrypted regardless of the order in which they are
received.  In CBC cipher mode (the default in OpenVPN), the initial IV on
daemon initialization is randomized, and each subsequent datagram is
encrypted using the current key and the residual IV of the previous
datagram.  The uncertainty in the IV combined with the uniqueness of the
sequence number ensures that it is highly unlikely that two identical
plaintext blocks would encrypt to the same ciphertext.  OFB and CFB cipher
modes handle the IV slightly differently (using the sequence number as the
IV) to ensure that IV collisions never occur. Most of the IV logic can be
found in crypto.c.

Cut and paste attacks where the datagram ciphertext is modified are made
infeasable by the use of a keyed HMAC hash controlled by the --auth option.
For several papers on HMAC, see:

http://www.cs.ucsd.edu/users/mihir/papers/hmac.html

Note that OpenVPN takes the HMAC of the ciphertext rather than the
plaintext, so it is not vulnerable to the ssh exploit described here:

http://openvpn.sourceforge.net/papers/ssh-security.pdf

For additional discussion into the problems of encrypting and authenticating
an unreliable data stream (such as UDP), check out the IPSec ESP spec:

http://www.ietf.org/internet-drafts/draft-ietf-ipsec-esp-v3-03.txt

OpenVPN borrows much in the way of theory and concepts from IPSec with the
goal of producing a portable, lightweight, user-space VPN implementation.
Since IPSec must also deal with securing an unreliable data stream, several
concepts have been transferable such as sliding window-based replay
protection and explicit IV.

For additional theoretical documentation you might want to check out the
book Applied Cryptography by Bruce Schneier, which while being an extremely
well-written practical guide to cryptography, contains references to a great
deal of theoretical material.

James

----- Original Message -----
From: "Michael Grigoriev" <mag@...34...>
To: <openvpn-devel@lists.sourceforge.net>
Sent: Thursday, July 18, 2002 4:04 PM
Subject: [Openvpn-devel] Replay attacks


> Hi all,
>
> I am wondering how OpenVPN overcomes the inherit vulnerability of UDP
> comunications to "replay" or "cut-and-paste" attacks, since it is
> impossible to implement cipher block chaining.
> Also, if anybody could point me to any theoretical documentation on the
> subject, it would be greatly appreciated.
> Thanks in advance,
> -- mag
>
>
>
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>


