References: <cc3981e2-742c-37b1-e8fc-fa32f64b7d11@...1147...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <521e4a89-ee97-4ca5-d6db-ca5bcc412b2b@...1856...>
Date: Fri, 10 Nov 2017 09:52:36 +0100
MIME-Version: 1.0
In-Reply-To: <cc3981e2-742c-37b1-e8fc-fa32f64b7d11@...1147...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] Possible bug: AEAD Decrypt error: cipher final
 failed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

Hi,

On 03-11-17 15:03, Jan Just Keijser wrote:
> whilst testing some new hardware with OpenVPN I ran into the following
> messages which keep popping up from time to time:
>=20
> =A0AEAD Decrypt error: cipher final failed
>=20
>=20
> Config:
>=20
> server running OpenVPN 2.4.3, basic config, Ubuntu 17, kernel 4.14,
> openssl 1.0.2g
> client running OpenVPN 2.4.4, basic config, CentOS 7.4, kernel 3.10,
> openssl 1.0.2k
>=20
> it's the client that is throwing the above message during heavy load
> (900 Mbps VPN traffic). It happens only with NCP ciphers , I am not
> seeing any cipher messages with 'ncp-disable' set.
>=20
> as soon as I add 'verb 5' or higher, the message goes away, because
> performance drops to below 500 Mbps due to excessive output.
> Any idea how to tackle this?

This is (most likely) the GCM authentication check failing.  What would
be interesting is to see at least what is on the wire and what the
receiving process thinks it's receiving.  Also, printing the session
keys would help to verify the crypto.

The verb level do not allow enough granularity to achieve this, so
you'll have to change the code to print the session keys (after the kex)
and the full received packet if this error occurs, and keep a pcap of
the transfer.  Though I'm not very sure whether it's doable to store a
pcap @ 900 mbit - it's probably not on my old/cheap hw ;-)

-Steffan

