MIME-Version: 1.0
References: <CAGyAFMWpLKixwrmOqLy-OZ86h-zXwgPMyJQ3HqV8O3GQRGE1UA@...278...>
 <193E6898-A1C8-4319-8847-866E3CEB3E97@...2293...>
 <CAKuzo_ihkXkr_-2+VQ5bSaoi-MrEM+u051_WNoMtdhVdubOhAw@...278...>
 <20190612052402.GL1097@...1296...>
In-Reply-To: <20190612052402.GL1097@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 12 Jun 2019 10:50:44 +0300
Message-ID: <CAGyAFMX9ZxkArOT+A9f14cHYE37vwEiuTGBvgmvXPe6xy=bA9Q@...278...>
Content-Type: multipart/alternative; boundary="00000000000066f678058b1bac16"
Subject: Re: [Openvpn-devel] Preliminary Wintun support in OpenVPN2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000066f678058b1bac16
Content-Type: text/plain; charset="UTF-8"

Hi,

Agree.  This is the first thought I had when I heard about "you must
> have privileges to access wintun" - just use our existing privilege
> handling mechanism.  I have no idea how to actually *do* that (= pass
> a handle to wintun over our service pipe), but I'm all willing to
> review and test :-)
>

Seems that we have a consensus here.


> I wonder if we couldn't do this with tap-windows6 as well - read/write
> multiple packets at once.  The driver should handle this - from what
> I saw when reading patches "all is done using NBL lists"...
>

Not sure what is missing in OpenVPN 2.x to do multi-packet read/write,
> not sure if there is anything missing in the tap6-driver.
>

We would have to modify tap-windows6 to write multiple packets
to userspace with some encapsulation. Maybe Wintun / tap-windows6
could employ scatter / gather IO and return list of per-packet buffers.

Is Steffan's code available somewhere? On openvpn2 we would need a list of
link write buffers. WSASend / WSASendTo methods, which we use to write to
link on Windows,
already support multiple buffers (but we do not use that feature):

        WSABUF wsabuf[1];

        wsabuf[0].buf = BPTR(&sock->writes.buf);
        wsabuf[0].len = BLEN(&sock->writes.buf);

        status = WSASendTo(
                sock->sd,
                wsabuf,
                1,             // The number of WSABUF structures in the
lpBuffers array.


What does OpenVPN 3 do on Windows?
>


Basically the same what openvpn2 does - processes IP packets one by one.
I'll try this approach
on openvpn3/wintun first to see what happens.

-- 
-Lev

--00000000000066f678058b1bac16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div class=3D"gmail_quote"><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">
Agree.=C2=A0 This is the first thought I had when I heard about &quot;you m=
ust<br>
have privileges to access wintun&quot; - just use our existing privilege<br>
handling mechanism.=C2=A0 I have no idea how to actually *do* that (=3D pas=
s<br>
a handle to wintun over our service pipe), but I&#39;m all willing to <br>
review and test :-)<br></blockquote><div><br></div><div>Seems that we have =
a consensus here.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
I wonder if we couldn&#39;t do this with tap-windows6 as well - read/write<=
br>
multiple packets at once.=C2=A0 The driver should handle this - from what<b=
r>
I saw when reading patches &quot;all is done using NBL lists&quot;...<br></=
blockquote><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin=
:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"=
>Not sure what is missing in OpenVPN 2.x to do multi-packet read/write,<br>
not sure if there is anything missing in the tap6-driver.<br></blockquote><=
div><br></div><div><div>We would have to modify tap-windows6 to write multi=
ple packets</div><div>to userspace with some encapsulation. Maybe Wintun / =
tap-windows6=C2=A0</div></div><div>could employ scatter / gather IO and ret=
urn list of per-packet buffers.</div><div>=C2=A0</div><div>Is Steffan&#39;s=
 code available somewhere? On openvpn2 we would need a list of</div><div>li=
nk write buffers. WSASend / WSASendTo methods, which we use to write to lin=
k on Windows,</div><div>already support multiple buffers (but we do not use=
 that feature):</div><div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 WSABUF=
 wsabuf[1];</div><div><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 wsabuf[0].buf =3D BPT=
R(&amp;sock-&gt;writes.buf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 wsabuf[0].len =
=3D BLEN(&amp;sock-&gt;writes.buf);<br></div><div><br></div><div>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 status =3D WSASendTo(<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 sock-&gt;sd,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 wsabuf,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 1,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// The numb=
er of WSABUF structures in the lpBuffers array.<br></div><div>=C2=A0</div><=
div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
What does OpenVPN 3 do on Windows?=C2=A0<br></blockquote><div>=C2=A0<br></d=
iv><div><br></div><div>Basically the same what openvpn2 does - processes IP=
 packets one by one. I&#39;ll try this approach</div><div>on openvpn3/wintu=
n first to see what happens.</div><div><br></div></div>-- <br><div dir=3D"l=
tr" class=3D"gmail_signature">-Lev</div></div>

--00000000000066f678058b1bac16--

