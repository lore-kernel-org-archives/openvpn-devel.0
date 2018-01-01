MIME-Version: 1.0
In-Reply-To: <3e1d6a01-2ceb-b01a-d903-a8d66e3a62bd@...2181...>
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
 <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
 <b09d8b3c-b8ff-1d33-06eb-fa152c168a88@...1856...>
 <3e1d6a01-2ceb-b01a-d903-a8d66e3a62bd@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 1 Jan 2018 20:54:03 +0500
Message-ID: <CAFHpkQFq7LQAkbLMjjdBvFtLVxkzLAhOZL7cCON6-hbAug0R_g@...278...>
Content-Type: multipart/alternative; boundary="001a114aca52d71f420561b8fd53"
Subject: Re: [Openvpn-devel] better handling of revoked certs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--001a114aca52d71f420561b8fd53
Content-Type: text/plain; charset="UTF-8"

2018-01-01 17:56 GMT+05:00 Antonio Quartulli <a@...2181...>:

> Hi,
>
> On 01/01/18 20:30, Steffan Karger wrote:
>
> [CUT]
>
> >
> > Note the '5 seconds' reconnect loop, which is the same as what current
> > released openvpn would do in response to an alert.  So if we change our
> > servers to send alerts, they will experience quite a bit more load from
> > clients attempting to reconnect.  We can make newer clients use some
> > exponential back-off, but older clients will be around for quite a while.
> >
>
> If we really go this way, we could even have the client "understand" the
> alert and stop retrying if the error is permanent (i.e. certificate
> revoked).
>
>
> However, are we sure we're not going to introduce surface for a DoS
> attacks by opening this hole for unauthorized clients?
>

what kind of DoS attacks are you talking about ?



> Basically anybody with a revoked certificate is now able to trigger some
> kind of logic on the server side (this is how I understand it).
>
> Consider that obtaining a revoked certificate is not that difficult
> (i.e. VPN providers granting free periods normally do that by issuing
> and revoking a new cert).
>
>
>
> Cheers,
>
>
> --
> Antonio Quartulli
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a114aca52d71f420561b8fd53
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2018-01-01 17:56 GMT+05:00 Antonio Quartulli <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On 01/01/18 20:30, Steffan Karger wrote:<br>
<br>
[CUT]<br>
<span class=3D""><br>
&gt;<br>
&gt; Note the &#39;5 seconds&#39; reconnect loop, which is the same as what=
 current<br>
&gt; released openvpn would do in response to an alert.=C2=A0 So if we chan=
ge our<br>
&gt; servers to send alerts, they will experience quite a bit more load fro=
m<br>
&gt; clients attempting to reconnect.=C2=A0 We can make newer clients use s=
ome<br>
&gt; exponential back-off, but older clients will be around for quite a whi=
le.<br>
&gt;<br>
<br>
</span>If we really go this way, we could even have the client &quot;unders=
tand&quot; the<br>
alert and stop retrying if the error is permanent (i.e. certificate<br>
revoked).<br>
<br>
<br>
However, are we sure we&#39;re not going to introduce surface for a DoS<br>
attacks by opening this hole for unauthorized clients?<br></blockquote><div=
><br></div><div>what kind of DoS attacks are you talking about ?<br></div><=
div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Basically anybody with a revoked certificate is now able to trigger some<br>
kind of logic on the server side (this is how I understand it).<br>
<br>
Consider that obtaining a revoked certificate is not that difficult<br>
(i.e. VPN providers granting free periods normally do that by issuing<br>
and revoking a new cert).<br>
<br>
<br>
<br>
Cheers,<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
<br>
--<br>
Antonio Quartulli<br>
<br>
</font></span><br>------------------------------<wbr>----------------------=
--------<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div>

--001a114aca52d71f420561b8fd53--

