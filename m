MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10806F444A@...2294...>
References: <99D61A626FDA8A4B90A270669121BE10806D5BC3@...2294...>
 <20170811102147.GT4090@...1281...>
 <99D61A626FDA8A4B90A270669121BE10806F444A@...2294...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 11 Aug 2017 21:25:50 -0400
Message-ID: <CAKuzo_jtNGcwu3-wnijVGvd0zmuBF8A5gxbXDDnQW7fSyORJBg@...278...>
Content-Type: multipart/alternative; boundary="001a113e7cf2978fba05568450e0"
Subject: Re: [Openvpn-devel] OVPN Interactive Service for non-admin users
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113e7cf2978fba05568450e0
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 11, 2017 at 10:05 AM, Simon Rozman via Openvpn-devel <
openvpn-devel@lists.sourceforge.net> wrote:

>
> But that's what I wanted in the first place, as I believe Interactive
> Service "security" scheme makes no sense.
>
> Why does OpenVPN restrict non-admin users from using Interactive Service in
> the first place, while Windows' out-of-the-box VPN connects them just fine?
> If you are afraid a malware would start connecting - they already can:
> using
> Windows' VPN.
>

AFAIK, Windows VPN can be setup without admin rights only if the connection
is not shared with other users. Thus a limited user cannot redirect traffic
of all users. In openvpn we do not have a provision for such a separation
-- at least not as yet.


>
> Flushing ARP cache, client DNS registration, and other tasks OpenVPN can't
> perform as non-admin user is a technical issue of OpenVPN running in user
> space. Not a security one. Interactive Service overcomes that, but in the
> same time it assumes it's a security sensitive issue.
>

These tasks normally require admin rights (or some privilege like Network
Configuration Operators). So admin has to decide who is allowed to do such
actions.


> This limitation can and will be turned off with one or another simple
> administrator task (performed by eduVPN setup). So, this is no biggie...
>

Yes, a simple "administrator task" is all that is required to provide extra
privileges to users. In case of interactive service its supposed to be done
at the time of installation.

Selva

--001a113e7cf2978fba05568450e0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Aug 11, 2017 at 10:05 AM, Simon Rozman via Openvpn-devel <span =
dir=3D"ltr">&lt;<a href=3D"mailto:openvpn-devel@lists.sourceforge.net" targ=
et=3D"_blank">openvpn-devel@...1768...<wbr>ge.net</a>&gt;</span> wrote:<br>=
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><br>
But that&#39;s what I wanted in the first place, as I believe Interactive<b=
r>
Service &quot;security&quot; scheme makes no sense.<br>
<br>
Why does OpenVPN restrict non-admin users from using Interactive Service in=
<br>
the first place, while Windows&#39; out-of-the-box VPN connects them just f=
ine?<br>
If you are afraid a malware would start connecting - they already can: usin=
g<br>
Windows&#39; VPN.<br></blockquote><div><br></div><div>AFAIK, Windows VPN ca=
n be setup without admin rights only if the connection is not shared with o=
ther users. Thus a limited user cannot redirect traffic of all users. In op=
envpn we do not have a provision for such a separation -- at least not as y=
et.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Flushing ARP cache, client DNS registration, and other tasks OpenVPN can&#3=
9;t<br>
perform as non-admin user is a technical issue of OpenVPN running in user<b=
r>
space. Not a security one. Interactive Service overcomes that, but in the<b=
r>
same time it assumes it&#39;s a security sensitive issue.<br></blockquote><=
div><br></div><div>These tasks normally require admin rights (or some privi=
lege like Network Configuration Operators). So admin has to decide who is a=
llowed to do such actions.</div><div><br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
This limitation can and will be turned off with one or another simple<br>
administrator task (performed by eduVPN setup). So, this is no biggie...<br=
></blockquote><div><br></div><div>Yes, a simple &quot;administrator task&qu=
ot; is all that is required to provide extra privileges to users. In case o=
f interactive service its supposed to be done at the time of installation.<=
br></div><div><br></div><div>Selva</div></div></div></div>

--001a113e7cf2978fba05568450e0--

