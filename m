MIME-Version: 1.0
References: <20221214164824.172-1-lstipakov@...277...>
 <CAKuzo_iZPLJvSyK53oziTO99ZW6ua-DFvEWMoPAK3MjrjQ5PdA@...278...>
 <CAGyAFMV=QqUUPj8-Z8_U3JWG3qoBOZOKpMMVAztpdc-8qT+0HQ@...278...>
 <CAKuzo_g6Pc6djBCu05-k5oJFWYuTYBFa60Ucay+z1BebJK=9Gg@...278...>
 <CAGyAFMUTjZuN+W8FagK+F=4P+iuUAEYS0qmieb3kNQYKN-z=gg@...278...>
 <Y5pEEhAGyKzbNn8u@...1296...>
 <CAGyAFMUQUx_oL_Qi6SBcAdB94VCW+1tmTQVkoCh5B0BnYThkLg@...278...>
 <CAKuzo_imcQLV60uJN9mXTR8ti7gctgR=iZVpi+2AvDvSTJ_x0g@...278...>
In-Reply-To: <CAKuzo_imcQLV60uJN9mXTR8ti7gctgR=iZVpi+2AvDvSTJ_x0g@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 14 Dec 2022 21:34:56 -0500
Message-ID: <CAKuzo_jVnAUeKM9=x1vU_DztqPrwYJfHe=YTy5AS8PKF2_Tv1g@...278...>
Content-Type: multipart/alternative; boundary="000000000000d128e005efd4b3d5"
Subject: Re: [Openvpn-devel] [PATCH] Introduce dco_get_peer_stats API and
 Windows implementation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Lev Stipakov <lev@...515...>, openvpn-devel@lists.sourceforge.net

--000000000000d128e005efd4b3d5
Content-Type: text/plain; charset="UTF-8"

More on the data channel traffic stats getting reset on reconnect:


>> Here is MSI installer which incorporates required client patches
>>
>>  - management: add timer to output BYTECOUNT
>>  - Introduce dco_get_peer_stats API and Windows implementation
>>
>> and a new driver version (0.8.3) with stats fixes.
>>
>> https://github.com/lstipakov/openvpn-build/actions/runs/3699097077
>
>
> Thanks.
>
> Tested again using this. Ignore my previous comment about Out bytes not
> reported. Something must be wrong with my build --- this one shows in and
> out bytes correctly. But the problem with data getting reset on
> reconnect is real.
>

In non-dco use, the stats as persisted by the management interface are not
reset throughout the lifetime of the process. With dco, what the driver
provides is "Peer Stats" which is reset in OvpnPeerNew()  (linux appears to
do the same). A quick option would be to move the zero-ing
to OvpnEvtFileCleanup() which, I guess, would work at least when
persist-tun is in use. Or in a new callback that gets called on
tun-open. But then it wont be strictly "Peer Stats".

Otherwise we need a way to add the current data channel stats to the
accumulated control-channel stats just before SIGUSR1 and SIGHUP. Or learn
to live with the new paradigm.

Selva

>

--000000000000d128e005efd4b3d5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>More on the data channel traffic stats getting reset =
on reconnect:</div><div><br></div><div class=3D"gmail_quote"><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div class=3D"gmail_qu=
ote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
Here is MSI installer which incorporates required client patches<br>
<br>
=C2=A0- management: add timer to output BYTECOUNT<br>
=C2=A0- Introduce dco_get_peer_stats API and Windows implementation<br>
<br>
and a new driver version (0.8.3) with stats fixes.<br>
<br>
<a href=3D"https://github.com/lstipakov/openvpn-build/actions/runs/36990970=
77" rel=3D"noreferrer" target=3D"_blank">https://github.com/lstipakov/openv=
pn-build/actions/runs/3699097077</a></blockquote><div><br></div><div>Thanks=
.</div><div><br></div><div>Tested again using this. Ignore my previous comm=
ent about Out bytes not reported. Something must be wrong with my build ---=
 this one shows in and out bytes correctly. But the problem with data getti=
ng reset on reconnect=C2=A0is real.</div></div></div></blockquote><div><br>=
</div><div>In non-dco use, the stats as persisted by the management interfa=
ce are not reset throughout=C2=A0the lifetime of the process. With dco, wha=
t the driver provides is &quot;Peer Stats&quot; which is reset in OvpnPeerN=
ew()=C2=A0 (linux appears to do the same). A quick option would be to move =
the zero-ing to=C2=A0OvpnEvtFileCleanup() which, I guess, would work at lea=
st when persist-tun is in use. Or in a new callback that gets called on tun=
-open.=C2=A0But then it wont be strictly &quot;Peer Stats&quot;.</div><div>=
<br></div><div>Otherwise we need a way to add the current data channel stat=
s to the accumulated control-channel stats just before=C2=A0SIGUSR1 and SIG=
HUP. Or learn to live with the new paradigm.</div><div><br></div><div>Selva=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;b=
order-left:1px solid rgb(204,204,204);padding-left:1ex">
</blockquote></div></div>

--000000000000d128e005efd4b3d5--

