MIME-Version: 1.0
Sender: j.faber@...1301...
In-Reply-To: <20100204155446.GY32433@...1300...>
References: <20100204155446.GY32433@...1300...>
From: Jannes Faber <j.faber+openvpn@...1301...>
Date: Fri, 5 Feb 2010 18:26:14 +0800
Message-ID: <fdf61b021002050226h253c4a0cj9cdb17017e8a0830@...278...>
Content-Type: multipart/alternative; boundary=001485f7d29ac2c052047ed7e256
Subject: Re: [Openvpn-devel] multipath iroute
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001485f7d29ac2c052047ed7e256
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I would be very interested in such a functionality too. I ran into this same
problem a few months ago trying to get redundant VPNs as well.

(Just showing support, didn't look at the patch yet.)

--
Jannes

On Thu, Feb 4, 2010 at 23:54, Dominique Rousseau <d.rousseau@...1300...> wrote:

> Hi
>
> I wanted to make redundant VPNs by using multiple instances from same
> client to same server but current (2.1.1) implementation of OpenVPN
> override previous iroute definition when new client connects with same
> ip or same route.
>
> Attached is a proposed patch to allow for multiple paths for the same
> route.
>
> The functional target of the patch is that I modified the multi_route
> struct to have a property called instances instead of instance, which
> hosts an array of multi_instance.
>
> It's a bit rough, and I don't doubt it needs a bi refactoring, since
> it's the first time I browse through openvpn's source code, but it seems
> to be functional and hasn't caused segfault since I try it.
>
> --
> Dominique Rousseau
> Neuronnexion, Prestataire Internet & Intranet
> 50, rue Riolan 80000 Amiens
> tel: 03 22 71 61 90 - fax: 03 22 71 61 99 - http://www.neuronnexion.coop
>
>
> ------------------------------------------------------------------------------
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the
> business
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001485f7d29ac2c052047ed7e256
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,<div><br></div><div>I would be very interested in such a functionality t=
oo. I ran into this same problem a few months ago trying to get redundant V=
PNs as well.</div><div><br></div><div>(Just showing support, didn&#39;t loo=
k at the patch yet.)</div>

<div><br clear=3D"all">--<br>Jannes<br><br><div class=3D"gmail_quote">On Th=
u, Feb 4, 2010 at 23:54, Dominique Rousseau <span dir=3D"ltr">&lt;<a href=
=3D"mailto:d.rousseau@...1300...">d.rousseau@...1300...</a>&gt;</span> wrot=
e:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex;">

Hi<br>
<br>
I wanted to make redundant VPNs by using multiple instances from same<br>
client to same server but current (2.1.1) implementation of OpenVPN<br>
override previous iroute definition when new client connects with same<br>
ip or same route.<br>
<br>
Attached is a proposed patch to allow for multiple paths for the same<br>
route.<br>
<br>
The functional target of the patch is that I modified the multi_route<br>
struct to have a property called instances instead of instance, which<br>
hosts an array of multi_instance.<br>
<br>
It&#39;s a bit rough, and I don&#39;t doubt it needs a bi refactoring, sinc=
e<br>
it&#39;s the first time I browse through openvpn&#39;s source code, but it =
seems<br>
to be functional and hasn&#39;t caused segfault since I try it.<br>
<font color=3D"#888888"><br>
--<br>
Dominique Rousseau<br>
Neuronnexion, Prestataire Internet &amp; Intranet<br>
50, rue Riolan 80000 Amiens<br>
tel: 03 22 71 61 90 - fax: 03 22 71 61 99 - <a href=3D"http://www.neuronnex=
ion.coop" target=3D"_blank">http://www.neuronnexion.coop</a><br>
</font><br>----------------------------------------------------------------=
--------------<br>
The Planet: dedicated and managed hosting, cloud storage, colocation<br>
Stay online with enterprise data centers and the best network in the busine=
ss<br>
Choose flexible plans and management services without long-term contracts<b=
r>
Personal 24x7 support from experience hosting pros just a phone call away.<=
br>
<a href=3D"http://p.sf.net/sfu/theplanet-com" target=3D"_blank">http://p.sf=
.net/sfu/theplanet-com</a><br>_____________________________________________=
__<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
<br></blockquote></div><br></div>

--001485f7d29ac2c052047ed7e256--

