MIME-Version: 1.0
In-Reply-To: <20171105171135.GL958@...1296...>
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <41c0e750-b27e-22ea-d5fb-b17fe391636d@...1147...>
 <689096e2-8bb8-95b8-5daf-22fd600a00ca@...515...>
 <da7671c8-6768-f718-79a0-996cdb0d8d87@...1147...>
 <82ec1478-ec53-3980-05b1-4529a74aa789@...1147...>
 <20170717121451.GQ70062@...1296...>
 <a3d45ab2-63e9-2849-6118-775a8f43ec87@...1147...>
 <20171105171135.GL958@...1296...>
From: Selva <selva.nair@...277...>
Date: Sun, 5 Nov 2017 12:33:09 -0500
Message-ID: <CAKuzo_hmEbhN6S9FOwgDSYACy4zSr8BxMLuROQDNz9_A+DMJLw@...278...>
Content-Type: multipart/alternative; boundary="94eb2c048b6e73cc21055d3fbcd2"
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Jan Just Keijser <janjust@...1147...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c048b6e73cc21055d3fbcd2
Content-Type: text/plain; charset="UTF-8"

On Sun, Nov 5, 2017 at 12:11 PM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Jul 17, 2017 at 02:22:55PM +0200, Jan Just Keijser wrote:
> > On 17/07/17 14:14, Gert Doering wrote:
> > > Hi,
> > >
> > > On Mon, Jul 17, 2017 at 02:10:11PM +0200, Jan Just Keijser wrote:
> > >> this problem is NOT present in OpenVPN 2.3.17; the same warning
> appears (route gateway is ambiguous) but the route is added
> > >> anyway. This seems to be a regression in 2.4.
> > > Can we have a log, please?
> > attached: config and log (with hostnames anonymized)
>
> This indeed is a regression, or a "non-handled special case in the
> iservice"
> (waking up Selva and Heiko).


> 2.3 is calling route.exe, which seems to just handle this case fine
> ("the given gateway address is present on two different interfaces",
> which I find ambiguous myself :-) ).
>

When this was reported I had made a patch to handle this, somehow forgot to
send it in. Or could be that I was not totally happy with it (or not
tested). Anyway,
the next email has the patch as I have it -- will do any cleanup if needed
provided
it looks sensible.

Selva

--94eb2c048b6e73cc21055d3fbcd2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Sun, Nov 5, 2017 at 12:11 PM, Gert Doering <span dir=3D"ltr">&lt;<a =
href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;</=
span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8e=
x;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Mon, Jul 17, 2017 at 02:22:55PM +0200, Jan Just Keijser wrote:<br>
&gt; On 17/07/17 14:14, Gert Doering wrote:<br>
&gt; &gt; Hi,<br>
&gt; &gt;<br>
&gt; &gt; On Mon, Jul 17, 2017 at 02:10:11PM +0200, Jan Just Keijser wrote:=
<br>
&gt; &gt;&gt; this problem is NOT present in OpenVPN 2.3.17; the same warni=
ng appears (route gateway is ambiguous) but the route is added<br>
&gt; &gt;&gt; anyway. This seems to be a regression in 2.4.<br>
&gt; &gt; Can we have a log, please?<br>
&gt; attached: config and log (with hostnames anonymized)<br>
<br>
</span>This indeed is a regression, or a &quot;non-handled special case in =
the iservice&quot;<br>
(waking up Selva and Heiko).=C2=A0</blockquote><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<br>
2.3 is calling route.exe, which seems to just handle this case fine<br>
(&quot;the given gateway address is present on two different interfaces&quo=
t;,<br>
which I find ambiguous myself :-) ).<br></blockquote><div><br></div><div>Wh=
en this was reported I had made a patch to handle this, somehow forgot to=
=C2=A0</div><div>send it in. Or could be that I was not totally happy with =
it (or not tested). Anyway,</div><div>the next email has the patch as I hav=
e it -- will do any cleanup if needed provided</div><div>it looks sensible.=
</div><div><br></div><div>Selva</div></div></div></div>

--94eb2c048b6e73cc21055d3fbcd2--

