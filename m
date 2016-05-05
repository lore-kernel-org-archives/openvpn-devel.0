MIME-Version: 1.0
In-Reply-To: <CAA1AbxJcWAGNKuDVRxq=qn=sPqOJ7fnptresFX-SONjuUAzuxA@...278...>
References: <CAP=zTkNE-53SstE=tobE9xKWbpT=ERgstxQNy0EqxrN4GMs0Eg@...278...>
	<CAA1AbxJRmjTJhzCAekF0yX24ztA1JsYbfjQJ1JnW0Z+OXYrbMg@...278...>
	<CAP=zTkP6E+k0ku5t9=A=4b33QLtW1dxOaWrpte+J49bRHE7iZw@...278...>
	<CAA1AbxJcWAGNKuDVRxq=qn=sPqOJ7fnptresFX-SONjuUAzuxA@...278...>
Date: Thu, 5 May 2016 19:15:29 +0530
Message-ID: <CAP=zTkMy3DAD13RT5CaUVhHZvb2sD4WsV5Wc8LaKbrO75d4r0w@...278...>
From: Shubham Chauhan <shubham13099@...2124...>
Content-Type: multipart/alternative; boundary=001a11411d6e3978e40532188ea9
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

--001a11411d6e3978e40532188ea9
Content-Type: text/plain; charset=UTF-8

Thank you for the help. Appreciate it.
On May 5, 2016 7:00 PM, "Steffan Karger" <steffan@...1856...> wrote:

>
> On 5 May 2016 3:24 p.m., "Shubham Chauhan" <shubham13099@...2124...>
> wrote:
> > So, what I get from this is that OpenVPN will do a ssl/tls handshake
> irrespective of the --cipher none option, because this configuration will
> only be used in the data channel. Is this right?
>
> Yes.
>
> > Also, will using --cipher none get me a faster VPN connection?
> > I hope so because we are removing encryption - decryption operations
> which use a lot of time and CPU (keeping security issues aside for a minute
> here)
>
> Most of the time, yes. Unless the speed is limited by the network, rather
> than your cup, of course.
>
> > My original question was actually based on the Wireshark traces I saw. I
> was expecting no ssl/tls handshake when I had set --cipher none. Is there a
> config/alternate way which would lead me to show literally no handshake at
> all (just curious).
>
> Yes, there is. But only for one-to-one connections, not for one-to-many
> (which is the traditional one see many clients).
>
> See the static-home.conf and static-office.conf example configs.
>
> -Steffan
>

--001a11411d6e3978e40532188ea9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Thank you for the help. Appreciate it. </p>
<div class=3D"gmail_quote">On May 5, 2016 7:00 PM, &quot;Steffan Karger&quo=
t; &lt;<a href=3D"mailto:steffan@...1856...">steffan@...1856...</a>&gt; wro=
te:<br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"marg=
in:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><p dir=3D"ltr"><=
br>
On 5 May 2016 3:24 p.m., &quot;Shubham Chauhan&quot; &lt;<a href=3D"mailto:=
shubham13099@...2124..." target=3D"_blank">shubham13099@...2124...</a>&gt; =
wrote:<br>
&gt; So, what I get from this is that OpenVPN will do a ssl/tls handshake i=
rrespective of the --cipher none option, because this configuration will on=
ly be used in the data channel. Is this right?</p>
<p dir=3D"ltr">Yes.</p>
<p dir=3D"ltr">&gt; Also, will using --cipher none get me a faster VPN conn=
ection? <br>
&gt; I hope so because we are removing encryption - decryption operations w=
hich use a lot of time and CPU (keeping security issues aside for a minute =
here)</p>
<p dir=3D"ltr">Most of the time, yes. Unless the speed is limited by the ne=
twork, rather than your cup, of course.</p>
<p dir=3D"ltr">&gt; My original question was actually based on the Wireshar=
k traces I saw. I was expecting no ssl/tls handshake when I had set --ciphe=
r none. Is there a config/alternate way which would lead me to show literal=
ly no handshake at all (just curious).</p>
<p dir=3D"ltr">Yes, there is. But only for one-to-one connections, not for =
one-to-many (which is the traditional one see many clients).</p>
<p dir=3D"ltr">See the static-home.conf and static-office.conf example conf=
igs. </p>
<p dir=3D"ltr">-Steffan</p>
</blockquote></div>

--001a11411d6e3978e40532188ea9--

