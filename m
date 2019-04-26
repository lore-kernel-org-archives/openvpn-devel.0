References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
 <59329176-c948-a816-d128-4601d7720dcd@...2181...>
From: Jan Just Keijser <janjust@...1147...>
Message-ID: <0600680d-4eb6-0790-9990-26a7cdf0b7cc@...1147...>
Date: Fri, 26 Apr 2019 16:05:19 +0200
MIME-Version: 1.0
In-Reply-To: <59329176-c948-a816-d128-4601d7720dcd@...2181...>
Content-Language: nl-NL
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Antonio Quartulli <a@...2181...>, Pieter Hulshoff <pieter.hulshoff@...2499...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net, Gert Doering <gert@...1296...>

Hi Antonio,

On 26/04/19 16:02, Antonio Quartulli wrote:
> Hi,
>
> On 26/04/2019 15:57, Jan Just Keijser wrote:
>> I'd look into the way session tickets are configured and used in
>> mbedtls, e.g. read up on
>> https://tls.mbed.org/discussions/generic/what-is-the-correct-way-to-use-session-tickets
>>
>>
>> For OpenSSL, OpenVPN uses SSL_OP_NO_TICKET, i.e. no session tickets are
>> allowed. I don't know the mbedtls code base well enough, but as a start,
>> I'd make sure that mbedtls is also configured to NOT accept session
>> tickets.
> PUSH messages are exchanged on the control channel *after* the TLS
> handshake has completed, therefore I am not sure session tickets can
> play any role at that point, no?
>
fully correct, however, my suspicion is that the mbedtls version does 
not see the reconnect as a new connection on the control channel, 
whereas the openssl version does - that could explain the difference in 
push-logic.
Most likely the openssl version also does not like to push messages if 
it "thinks" it is simply a TLS control channel session resumption.
And at any rate, it can't hurt to rule this one out ;)

JJK


