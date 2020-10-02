MIME-Version: 1.0
References: <20201001154658.9798-1-davids@...515...>
 <346aa358-47be-2563-a75c-3ef81b3a5e8f@...1227...>
In-Reply-To: <346aa358-47be-2563-a75c-3ef81b3a5e8f@...1227...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 2 Oct 2020 15:03:12 +0500
Message-ID: <CAFHpkQFaeM4pWsvyHC+ysSwL7OJLVW1fMzk7VxYAnCLJi6GOiw@...278...>
Content-Type: multipart/alternative; boundary="00000000000035d1d405b0ad3ee4"
Subject: Re: [Openvpn-devel] [PATCH] compat/lz4: Update to v1.9.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000035d1d405b0ad3ee4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 2 =D0=BE=D0=BA=D1=82. 2020 =D0=B3. =D0=B2 13:51, Arne Schwabe=
 <arne@...1227...>:

> Am 01.10.20 um 17:46 schrieb David Sommerseth:
> > It's a long while since the bundled lz4 library has received an update.
> > It pulls in a lot of various fixes and enhancements, some of the changes
> > fixes compiler warnings and hardens the code a bit too.
> >
>
> Ack for release/2.5. I double checked that the file is identical (modulo
> compat defines) to the upsteam.
>
> I think that this file is outdated so much shows that we do not really
> care about compression so much. Also since we included it, lz4 libraries
> have been available on all major distribution and not having lz4 is not
> as problematic as before. For master I would like to see this
> compat-lz4.* removed instead of being updated. For the 2.5.0 release it
> is too late to remove, so okay for that.
>


windows build process uses bundled lz4. if we simply remove it, windows
build silently switch to "no lz4 enabled ... and that is ok"


>
>
> Acked-By: Arne Schwabe <arne@...1227...>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--00000000000035d1d405b0ad3ee4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 2 =D0=BE=D0=BA=D1=82. 2=
020 =D0=B3. =D0=B2 13:51, Arne Schwabe &lt;<a href=3D"mailto:arne@...2477...=
.">arne@...1227...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Am 01.10.20 um 17:46 schrieb David Sommerseth:<br>
&gt; It&#39;s a long while since the bundled lz4 library has received an up=
date.<br>
&gt; It pulls in a lot of various fixes and enhancements, some of the chang=
es<br>
&gt; fixes compiler warnings and hardens the code a bit too.<br>
&gt; <br>
<br>
Ack for release/2.5. I double checked that the file is identical (modulo<br>
compat defines) to the upsteam.<br>
<br>
I think that this file is outdated so much shows that we do not really<br>
care about compression so much. Also since we included it, lz4 libraries<br>
have been available on all major distribution and not having lz4 is not<br>
as problematic as before. For master I would like to see this<br>
compat-lz4.* removed instead of being updated. For the 2.5.0 release it<br>
is too late to remove, so okay for that.<br></blockquote><div><br></div><di=
v><br></div><div>windows build process uses bundled lz4. if we simply remov=
e it, windows build silently switch to &quot;no lz4 enabled ... and that is=
 ok&quot;<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
<br>
<br>
Acked-By: Arne Schwabe &lt;<a href=3D"mailto:arne@...1227..." target=3D"_bl=
ank">arne@...1227...</a>&gt;<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div></div>

--00000000000035d1d405b0ad3ee4--

