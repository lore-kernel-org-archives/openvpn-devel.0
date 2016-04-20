MIME-Version: 1.0
In-Reply-To: <571726E9.1080304@...515...>
References: <5710B96E.6070603@...515...>
	<CAKuzo_gObagUmAuwRzh8vRPiP0Z0YG5GtOamtyKQX3W4q6xNfA@...278...>
	<5714AA48.8090507@...515...>
	<CAKuzo_gS7BXxkHZ1X0sqWEnhXieKSS3d4W1QSQV+sujpod1yxQ@...278...>
	<5715ED48.2010005@...515...> <57163836.4080404@...515...>
	<571726E9.1080304@...515...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 20 Apr 2016 10:55:50 -0400
Message-ID: <CAKuzo_gxRSf1n6ZnB=odEw-U1k8rs+mY_-cOzG=7DdPrPoW4qg@...278...>
Content-Type: multipart/alternative; boundary=94eb2c0ba1824a9aff0530ebcbc8
Subject: Re: [Openvpn-devel] New EV-signed tap-windows6 driver ready for
	testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0ba1824a9aff0530ebcbc8
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 20, 2016 at 2:51 AM, Samuli Sepp=C3=A4nen <samuli@...515...> wr=
ote:

> Hi,
>
> So far the new driver (tap6-dual-sha1-sha2ev) looks promising: it works on
> 64-bit Vista, 7 and 10:
>
> <https://community.openvpn.net/openvpn/wiki/TapWindows6CodesignTests>
>
> Selva: can you try this new driver on your Vista 32-bit and Windows Server
> 2008? If you still have not updated them then please don't: it's probably
> best to test again systems which are more likely to cause issues.
>

To add to what's already confirmed, the new driver works for me too on
Windows 10 and window 7 (both 64bit) -- no problems with installation or
use; same as the earlier sha2-only version.

The behaviour on vista 32 (still not updated) is somewhat strange -- both
the -sha2 and -sha1-sha2 now installs without any warning after the first
forced installation  --- i.e.,  install ignoring a stern warning, remove,
and then install again and the second time onwards there are no warnings. I
did not select the "trust this publisher" button or anything, but it
behaves as if.  Anyway, dual signatures appear to be fine even with this
out-of-date vista machine though it may be seeing only the first signature:
file properties shows only one digest -- sha2 on the first version and sha1
on the second one.

Updating the vista machine is probably not going to happen -- too many
failures trying to do so and considering this was booted into vista first
time in 2 years, it looks like a lost battle.

Selva

--94eb2c0ba1824a9aff0530ebcbc8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Wed, Apr 20, 2016 at 2:51 AM, <span>=
Samuli</span> <span>Sepp=C3=A4nen</span> <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:samuli@...515..." target=3D"_blank"><span>samuli</span>@<span>openvpn=
</span>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
So far the new driver (tap6-dual-sha1-sha2ev) looks promising: it works on =
64-bit Vista, 7 and 10:<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/TapWindows6Codesi=
gnTests" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net=
/openvpn/wiki/TapWindows6CodesignTests</a>&gt;<br>
<br>
Selva: can you try this new driver on your Vista 32-bit and Windows Server =
2008? If you still have not updated them then please don&#39;t: it&#39;s pr=
obably best to test again systems which are more likely to cause issues.<br=
></blockquote><div><br></div><div>To add to what&#39;s already confirmed, t=
he new driver works for me too on Windows 10 and window 7 (both 64bit) -- n=
o problems with installation or use; same as the earlier sha2-only version.=
</div><div><br></div><div>The behaviour on vista 32 (still not updated) is =
somewhat strange -- both the -sha2 and -sha1-sha2 now installs without any =
warning after the first forced installation =C2=A0--- i.e., =C2=A0install i=
gnoring a stern warning, remove, and then install again and the second time=
 onwards there are no warnings. I did not select the &quot;trust this publi=
sher&quot; button or anything, but it behaves as if.=C2=A0 Anyway, dual sig=
natures appear to be fine=C2=A0even with this out-of-date vista machine tho=
ugh it may be seeing only the first signature: file properties shows only o=
ne digest -- sha2 on the first version and sha1 on the second one.</div><di=
v><br></div><div>Updating the vista machine is probably not going to happen=
 -- too many failures trying to do so and considering this was booted into =
vista first time in 2 years, it looks like a lost battle.</div><div><br></d=
iv><div><span>Selva</span></div></div></div></div>

--94eb2c0ba1824a9aff0530ebcbc8--

