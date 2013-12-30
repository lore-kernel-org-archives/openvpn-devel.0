MIME-Version: 1.0
Sender: heikki.hannikainen@...277...
In-Reply-To: <52B84C1F.8010500@...1847...>
References: <8c01c399-7f0c-477d-9bbe-dab589231ffc@...1848...>
	<52B75C6B.9080100@...1847...> <52B76494.5010903@...1847...>
	<20131223113229.GB161@...1296...>
	<52B84C1F.8010500@...1847...>
Date: Mon, 30 Dec 2013 17:10:59 +0200
Message-ID: <CAHqXQkMpp9ayVdfgnyvvFjUy-HcmS0BYO--N_SDEbOUDUE9zbw@...278...>
From: Heikki Hannikainen <hessu@...1822...>
Subject: Re: [Openvpn-devel] [PATCH v3] Floating: Add support for floating
 in TLS mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

On Mon, Dec 23, 2013 at 4:43 PM, Andr=C3=A9 Valentin <avalentin@...1847...>=
 wrote:
> On 23.12.2013 12:32, Gert Doering wrote:
>> We've discussed the patch on the Munich Hackathon, and we intend to do
>> it in a different way.  James wants to change the packet format for
>> data packets anyway (due to bad alignment in the current packet format),
>> and the new format would have the option to send the session ID in the
>> data packet as well, like "normally it's not sent, but if we have't heard
>> from the server longer than <x> time units, send a session ID so that
>> hmac-float will work".
>
> Of course, this is a better idea and should have less problems with scali=
ng.
> But there should be an option for the client to always send the session i=
d,
> so that there are no timeouts if the user decides to do so.

+1 to that - it'd be really neat if floating would work seamlessly
without timeouts + retransmissions. It'd be very useful on mobile
devices, which often get hit by NAT timeouts on UDP (around 30 or 60
seconds typically), switches between WIFI and 3G, and keepalive pings
with tight timers (sub-30-second range) consume a lot of battery.

The regular SSL session ID is maybe a bit long to be sent with each
and every packet, though.

Which other enhancements to the packet format are necessary? I
gathered that the encrypted data needs to be aligned for AES-NI to
work, which probably means that either the packet headers need to be
padded so that the data starts on a nice word boundary, or that the
data packet needs to begin with the encrypted data and all the headers
need to be placed in the end of the packet. Right?

And then some backwards compatibility in the handshake - it'd be good
if old clients could optionally be allowed on new servers using the
new packet format.

>> This code has not been written yet, though, and we have no specific
>> timelines when it will happen.
> So what does this mean for my work and the current format? Is there still
> a possibility that it will be integrated for the 'old packet format'?

We could also start working on the new packet format, do a prototype
if you'd like. Just need to figure out what the exact requirements
would be.

 - Hessu

