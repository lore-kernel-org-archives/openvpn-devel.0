MIME-Version: 1.0
In-Reply-To: <55E439ED.1020706@...1227...>
References: <CABgPX1maNQDV9XzTi8E8NCYSPPvAXgX2=-mza7j=1tQTUgEcXw@...278...>
	<55E432F8.5040204@...1147...>
	<CABgPX1ke6bhi0oMDQ1NCbwh0ob9HJo9wDiwRvR4gRGWdZ1bCQA@...278...>
	<55E439ED.1020706@...1227...>
From: Valentin Sawadski <valentin@...2062...>
Date: Mon, 31 Aug 2015 13:33:06 +0200
Message-ID: <CABgPX1nGoy2L9n_v=Y6YM362rg2s_gvvwx=WacxZSDJ5yYWEFg@...278...>
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi Arne,

thanks for the explanation on --tls-cipher NONE.

I know that TLS is only used for Authentication. But the other peer
still would have to do a TLS handshake, which is undesired in my case
as well.

Assuming I want to remove the TLS handshake as well, would patching
options.c enough or where else should I start looking?

Many thanks,
Valentin

On Mon, Aug 31, 2015 at 1:26 PM, Arne Schwabe <arne@...1227...> wrote:
>
>
> Am 31.08.15 um 13:17 schrieb Valentin Sawadski:
>> Hello Julian,
>>
>> thanks for your quick response. I know about --cipher none options in
>> P2P mode, but for testing with multiple clients I need --mode server.
>>
>> As for the --tls-cipher option, NONE is not working for me. --show-tls
>> also lists no other "non encrypted" cipher I could use.
>> Besides it still seems to do the TLS handshake right?
> Current TLS libraries (OpenSSl, PolarSSL) might not allow NONE as
> ciphersuite in default setting, you may need to recompile OpenSSL for tha=
t.
>>
>> Is there any way I can have the unencrypted P2P communication with
>> multiple connected clients (without having OpenVPN running in
>> parallel)?
>>
> No. Current implementation requires TLS handshake for that. And only the
> handshake is encrypted, not the communication itself.
>
> Arne



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

