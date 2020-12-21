MIME-Version: 1.0
References: <20201220105430.GP976@...1296...>
 <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
In-Reply-To: <CACDCbPrvwmEGyAt1C4pVmzmCi0p-7nWkBqmDgDZAR00Bw6S8Zg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 21 Dec 2020 12:57:08 +0500
Message-ID: <CAFHpkQG+vH5LfZXfN0Zs2PVaW1_40tjuFD8ObF7FhBCyXV_JtQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000b3dee705b6f4cec9"
Subject: Re: [Openvpn-devel] wanted: mechanism to send text messages to
 client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Greg Cox <gcox@...1057...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000b3dee705b6f4cec9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 21 =D0=B4=D0=B5=D0=BA. 2020 =D0=B3. =D0=B2 03:37, Greg Cox <g=
cox@...1057...>:

> tl;dr - anything that lets me selectively put a message in front of my
> users is great.  Yes please.
>
>
> The number one problem my users come across is expired certs.  Nobody
> reads logs until they're forced to.
>


that's interesting point.
being dependent on whether users logs or not does not look very good.
I'd say it is identity management related thing to renew user cert when it
is about to expire.
i.e. notify user in proper way and tell him to renew.

as a side question, how do you inform users ? i.e. is it some self service
portal ?



>
> A notif mechanism like you're describing would be great.
> With that I can set up scripts that push notices when someone is
> connected + within some amount of expiry, and instructions on what to do.
>
> But there's also those users that almost never connect.  I dream of having
> GUI clients changing their text/icons and/or refusing to even attempt to
> connect, with an explicit warning of "your cert is expired", rather than
> connections failing 'silently' when they use the VPN for the first time in
> forever.  A user complaint of "it says my cert is expired, what do I do?"
> is much easier to handle than "is the vpn broken? it worked yesterday!"
> 95% of the time it's certs, but I still have to triage it more fully for
> the times it's not.
>
>
> So IMO, 1-2 are fundamental, 3-5 are
> wishlist/consideration/extensions/ideas, use or ignore as you see fit:
> * Make the ability for receiving messages on a client as described.
> Enabled by default, maybe selectively disable-able because someone will
> think it's spammy, but I'd almost suggest not allowing it.
> * Make the ability to send a user a message via management.  Enabled by
> default, maybe selectively disable-able as a safety mechanism / make
> someone "key the mic to speak."
> * Make the ability to 'wall' a message out to all connected users in one
> command, e.g. 'wall "server going down in 5 mins"' or something like that.
> * Make the ability to 'post' a message for some amount of time, e.g.
> 'wallpost 60m "server going down at 1700"'  Sending a message gets someone
> who is connected now, but misses the user who connects 2m after I go
> through the list of users and I stop looking.  So, this would hang around
> and pop a message to everyone connected now, plus each new connection, for
> the next 60m.
> * Add an option ala --[no-]use-expired-certs.  When true, proceed like you
> do today; when false, if certs are expired, have the client feed itself a
> message via this mechanism to popup that your certs are expired, so a user
> knows right away what's wrong.  It'd be a spammy option if it tried to te=
ll
> you what to do, so I'm keeping the idea simple and generic.
>
> Thanks for considering.
>
> On Sun, Dec 20, 2020 at 10:55 AM Gert Doering <gert@...1296...> wrote:
>
>> Hi,
>>
>> I find myself looking for a mechanism by which I could send informational
>> messages ("your cert expires in two weeks, go refresh!" - "your openvpn
>> client needs an upgrade") from the openvpn server to incoming clients.
>>
>> Of course this should work with all connecting clients, that is, "text
>> clients", windows GUI, Tunnelblick, iOS Connect, Android.
>>
>> As far as I am aware, there is no such mechanism today.
>>
>> Do we want to make one?
>>
>>
>> From the server / openvpn core side, it could be something totally
>> trivial:
>>
>>   push "info-msg hey there!"
>>
>> ... and the client would then either print this on the console
>> (if !management) or dump it to management, where the GUI/Tunnelblick
>> could pick it up and create a popup window.
>>
>> What do you think?
>>
>> gert
>> --
>> "If was one thing all people took for granted, was conviction that if you
>>  feed honest figures into a computer, honest figures come out. Never
>> doubted
>>  it myself till I met a computer with a sense of humor."
>>                              Robert A. Heinlein, The Moon is a Harsh
>> Mistress
>>
>> Gert Doering - Munich, Germany
>> gert@...1296...
>> _______________________________________________
>> Openvpn-devel mailing list
>> Openvpn-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000b3dee705b6f4cec9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 21 =D0=B4=D0=B5=D0=BA. =
2020 =D0=B3. =D0=B2 03:37, Greg Cox &lt;<a href=3D"mailto:gcox@...1057...">=
gcox@...1057...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:courier new,monospace=
"><div style=3D"font-family:courier new,monospace">tl;dr - anything that le=
ts me selectively put a message in front of my users is great.=C2=A0 Yes pl=
ease.<br></div></div><div style=3D"font-family:courier new,monospace"><br><=
/div><div style=3D"font-family:courier new,monospace"><br></div><div style=
=3D"font-family:courier new,monospace">The number one problem my users come=
 across is expired certs.=C2=A0 Nobody reads logs until they&#39;re forced =
to.</div></div></blockquote><div><br></div><div><br></div><div>that&#39;s i=
nteresting point.</div><div>being dependent on whether users logs or not do=
es not look very good.</div><div>I&#39;d say it is identity management rela=
ted thing to renew user cert when it is about to expire.</div><div>i.e. not=
ify user in proper way and tell him to renew.</div><div><br></div><div>as a=
 side question, how do you inform users ? i.e. is it some self service port=
al ?<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,20=
4);padding-left:1ex"><div dir=3D"ltr"><div style=3D"font-family:courier new=
,monospace"><br></div><div style=3D"font-family:courier new,monospace">A no=
tif mechanism like you&#39;re describing would be great.</div><div style=3D=
"font-family:courier new,monospace">With that I can set up scripts that pus=
h notices when someone is connected=C2=A0+ within some amount of expiry, an=
d instructions on what to do.<br></div><div style=3D"font-family:courier ne=
w,monospace"><br></div><div style=3D"font-family:courier new,monospace">But=
 there&#39;s also those users that almost never connect.=C2=A0 I dream of h=
aving GUI clients changing their text/icons and/or refusing to even attempt=
 to connect, with an explicit warning of &quot;your cert is expired&quot;, =
rather than connections failing &#39;silently&#39; when they use the VPN fo=
r the first time in forever.=C2=A0 A user complaint of &quot;it says my cer=
t is expired, what do I do?&quot; is much easier to handle than &quot;is th=
e vpn broken? it worked yesterday!&quot; =C2=A0 95% of the time it&#39;s ce=
rts, but I still have to triage it more fully for the times it&#39;s not.</=
div><div style=3D"font-family:courier new,monospace"><br></div><div style=
=3D"font-family:courier new,monospace"><br></div><div style=3D"font-family:=
courier new,monospace">So IMO, 1-2 are fundamental, 3-5 are wishlist/consid=
eration/extensions/ideas, use or ignore as you see fit:<br></div><div style=
=3D"font-family:courier new,monospace">* Make the ability for receiving mes=
sages on a client as described.=C2=A0 Enabled by default, maybe selectively=
 disable-able because someone will think it&#39;s spammy, but I&#39;d almos=
t suggest not allowing it.</div><div style=3D"font-family:courier new,monos=
pace">* Make the ability to send a user a message via management.=C2=A0 Ena=
bled by default, maybe selectively disable-able as a safety mechanism / mak=
e someone &quot;key the mic to speak.&quot;<br></div><div style=3D"font-fam=
ily:courier new,monospace">* Make the ability to &#39;wall&#39; a message o=
ut to all connected users in one command, e.g. &#39;wall &quot;server going=
 down in 5 mins&quot;&#39; or something like that.</div><div style=3D"font-=
family:courier new,monospace">* Make the ability to &#39;post&#39; a messag=
e for some amount of time, e.g. &#39;wallpost 60m &quot;server going down a=
t 1700&quot;&#39;=C2=A0 Sending a message gets someone who is connected now=
, but misses the user who connects 2m after I go through the list of users =
and I stop looking.=C2=A0 So, this would hang around and pop a message to e=
veryone connected now, plus each new connection, for the next 60m.<br></div=
><div style=3D"font-family:courier new,monospace">* Add an option ala --[no=
-]use-expired-certs.=C2=A0 When true, proceed like you do today; when false=
, if certs are expired, have the client feed itself a message via this mech=
anism to popup that your certs are expired, so a user knows right away what=
&#39;s wrong.=C2=A0 It&#39;d be a spammy option if it tried to tell you wha=
t to do, so I&#39;m keeping the idea simple and generic.<br></div><div styl=
e=3D"font-family:courier new,monospace"><br></div><div style=3D"font-family=
:courier new,monospace">Thanks for considering.<br></div></div><br><div cla=
ss=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Sun, Dec 20, 20=
20 at 10:55 AM Gert Doering &lt;<a href=3D"mailto:gert@...1296..." target=
=3D"_blank">gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi,<br>
<br>
I find myself looking for a mechanism by which I could send informational<b=
r>
messages (&quot;your cert expires in two weeks, go refresh!&quot; - &quot;y=
our openvpn<br>
client needs an upgrade&quot;) from the openvpn server to incoming clients.=
<br>
<br>
Of course this should work with all connecting clients, that is, &quot;text=
<br>
clients&quot;, windows GUI, Tunnelblick, iOS Connect, Android.<br>
<br>
As far as I am aware, there is no such mechanism today.<br>
<br>
Do we want to make one?<br>
<br>
<br>
From the server / openvpn core side, it could be something totally trivial=
:<br>
<br>
=C2=A0 push &quot;info-msg hey there!&quot;<br>
<br>
... and the client would then either print this on the console <br>
(if !management) or dump it to management, where the GUI/Tunnelblick<br>
could pick it up and create a popup window.<br>
<br>
What do you think?<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--000000000000b3dee705b6f4cec9--

