MIME-Version: 1.0
In-Reply-To: <CAA1AbxJRmjTJhzCAekF0yX24ztA1JsYbfjQJ1JnW0Z+OXYrbMg@...278...>
References: <CAP=zTkNE-53SstE=tobE9xKWbpT=ERgstxQNy0EqxrN4GMs0Eg@...278...>
	<CAA1AbxJRmjTJhzCAekF0yX24ztA1JsYbfjQJ1JnW0Z+OXYrbMg@...278...>
Date: Thu, 5 May 2016 18:54:17 +0530
Message-ID: <CAP=zTkP6E+k0ku5t9=A=4b33QLtW1dxOaWrpte+J49bRHE7iZw@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a11c3c26c5dfea40532184223
Subject: Re: [Openvpn-devel] SSL handshake and OpenVPN config cipher none
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--001a11c3c26c5dfea40532184223
Content-Type: text/plain; charset=UTF-8

Hello.  Thanks for the reply.

> Disabling crypto is possible, but not what OpenVPN was designed for.
> Also, disabling encryption (using --cipher) does not disable
> authentication (--auth) too. If you want to control the TLS crypto,
> use --tls-cipher.  Note however that the TLS control channel is only
> used for configuration, so disabling the crypto there won't give you a
> faster VPN connection.

I understood it partially.
So, what I get from this is that OpenVPN will do a ssl/tls handshake
irrespective of the --cipher none option, because this configuration will
only be used in the data channel. Is this right?

Also, will using --cipher none get me a faster VPN connection?
I hope so because we are removing encryption - decryption operations which
use a lot of time and CPU (keeping security issues aside for a minute here)

My original question was actually based on the Wireshark traces I saw. I
was expecting no ssl/tls handshake when I had set --cipher none. Is there a
config/alternate way which would lead me to show literally no handshake at
all (just curious).

Thanks

--001a11c3c26c5dfea40532184223
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Hello.=C2=A0 Thanks for the reply. </p>
<p dir=3D"ltr">&gt; Disabling crypto is possible, but not what OpenVPN was =
designed for.<br>
&gt; Also, disabling encryption (using --cipher) does not disable<br>
&gt; authentication (--auth) too. If you want to control the TLS crypto,<br>
&gt; use --tls-cipher.=C2=A0 Note however that the TLS control channel is o=
nly<br>
&gt; used for configuration, so disabling the crypto there won&#39;t give y=
ou a<br>
&gt; faster VPN connection.</p>
<p dir=3D"ltr">I understood it partially. <br>
So, what I get from this is that OpenVPN will do a ssl/tls handshake irresp=
ective of the --cipher none option, because this configuration will only be=
 used in the data channel. Is this right? </p>
<p dir=3D"ltr">Also, will using --cipher none get me a faster VPN connectio=
n? <br>
I hope so because we are removing encryption - decryption operations which =
use a lot of time and CPU (keeping security issues aside for a minute here)=
</p>
<p dir=3D"ltr">My original question was actually based on the Wireshark tra=
ces I saw. I was expecting no ssl/tls handshake when I had set --cipher non=
e. Is there a config/alternate way which would lead me to show literally no=
 handshake at all (just curious). </p>
<p dir=3D"ltr">Thanks</p>

--001a11c3c26c5dfea40532184223--

