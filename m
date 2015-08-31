MIME-Version: 1.0
In-Reply-To: <55E432F8.5040204@...1147...>
References: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
	<55E432F8.5040204@...1147...>
From: Valentin Sawadski <valentin@...2062...>
Date: Mon, 31 Aug 2015 13:17:52 +0200
Message-ID: <CABgPX1ke6bhi0oMDQ1NCbwh0ob9HJo9wDiwRvR4gRGWdZ1bCQA@...278...>
Subject: Re: [Openvpn-devel] Disable TLS for mode server
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
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Julian,

thanks for your quick response. I know about --cipher none options in
P2P mode, but for testing with multiple clients I need --mode server.

As for the --tls-cipher option, NONE is not working for me. --show-tls
also lists no other "non encrypted" cipher I could use.
Besides it still seems to do the TLS handshake right?

Is there any way I can have the unencrypted P2P communication with
multiple connected clients (without having OpenVPN running in
parallel)?

Best Regards,
Valentin

On Mon, Aug 31, 2015 at 12:56 PM, Jan Just Keijser <janjust@...1147...> wro=
te:
> Hi Valentin,
>
> Valentin Sawadski wrote:
>>
>> Hello,
>>
>> I'm looking for a way to remove any encryption or MAC from OpenVPN in
>> "--mode server".
>>
>> Since I'm new to the OpenVPN code base my starting point right now
>> will be patching "options.c" to allow "--mode server" without TLS.
>> Will this already be enough to make it work or is TLS tightly
>> integrated into the workings of the mode?
>>
>> Thanks for any pointers!
>>
>
>
> you don't need to run openvpn using '--mode server' at all. If you run a
> poin-to-point connection like this
>
>  openvpn --ifconfig 10.200.0.1 10.200.0.2 --dev tun --proto udp --cipher
> none --auth none
>
>  openvpn --ifconfig 10.200.0.2 10.200.0.1 --dev tun --proto udp --cipher
> none --auth none --remote <remote host>
>
> then you'll end up with a fully plaintext tunnel.
> If you insist on using (useless) certificates and some form of "--mode
> server" then I'd suggest using
>
>  --mode server   --tls-cipher NONE --cipher none --auth none
>
>
> this should also disable the TLS cipher as well.
> IOW, no code changes should be needed at all :)
>
> HTH,
>
> JJK
>



--=20
Valentin Sawadski
Founder & Embedded Software

Tel.: +49 - (0) 89 - 716 77 86 - 15
Fax: +49 - (0) 89 - 716 77 86 - 99
Mobil: +49 - (0) 162 - 460 163 4


facebook.com/tado | twitter.com/tado | youtube.com/tado

www.tado.com | tado=C2=B0 GmbH | Lindwurmstr. 76 | 80337 Munich | Germany

Managing Directors: Christian Deilmann | Johannes Schwarz | Leopold v. Bism=
arck

Registered with the Commercial Register Munich as HRB 194769 B |
VAT-No: DE 280012558

