MIME-Version: 1.0
In-Reply-To: <1292286924.6222.3.camel@...1259...>
References: <AANLkTi=Fykb-NkSxx+=HM1U0ob4mmD0GkyfP_Mhb9=m1@...278...>
	<1292286924.6222.3.camel@...1259...>
Date: Tue, 14 Dec 2010 09:47:12 -0800
Message-ID: <AANLkTikhRr-YhNP4OaZM8kCJ++-OcKh=eQ9jAeedxjNj@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Content-Type: multipart/alternative; boundary=0016367f967817f9a6049762690e
Subject: Re: [Openvpn-devel] Can *plugin* kill specific ovpn tunnel?...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: chantra <chantra@...1258...>
Cc: openvpn-devel@lists.sourceforge.net

--0016367f967817f9a6049762690e
Content-Type: text/plain; charset=ISO-8859-1

Thanks for your response. This seems to involve file I/O and iptables right?
File I/O seems like a performance bottleneck, no?

Vineet
On Mon, Dec 13, 2010 at 4:35 PM, chantra <chantra@...1258...> wrote:

>  Vineet,
>
> I think you could use Packet filtering plugin hook and use the [KILL] tag
> at the end of the pf file .
>
> See
> http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=openvpn/openvpn-testing.git;a=blob;f=openvpn-plugin.h;h=56b0a701574e6913b3a714e941cdc4899dbea8e1;hb=HEAD#l316
>
> I have never used it myself, but I think that should sort you out.
>
> The doc says that this file may be dynamically updated during a client
> session. I assume the main process will pick up the change quick fast.
>
> Chantra
>
>
> On Mon, 2010-12-13 at 15:16 -0800, Vineet Kumar wrote:
>
> Hi,
>   If my openvpn plugin spawns its own thread and from that thread
> wants to kill a tunnel specified by IP:port how can that be done?
> (something like what the 'telnet' management provides: "kill IP:port")
> This plugin is meant to do other stuff and in certain scenarios wants
> to close specific tunnels.
> First I thought of using the plugin to write code to establish a
> telnet-client sessions and send over "kill IP:port" command. But I
> notice an issue with the management listener: if I run more than 1
> telnet session only the first one can pass through data whereas all
> others' telnet sessions just hang.
>
> Is this even possible?
>
> Vineet
>
> ------------------------------------------------------------------------------
> Lotusphere 2011
> Register now for Lotusphere 2011 and learn how
> to connect the dots, take your collaborative environment
> to the next level, and enter the era of Social Business.http://p.sf.net/sfu/lotusphere-d2d
> _______________________________________________
> Openvpn-devel mailing listOpenvpn-devel@...1440...://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>
>   -- http://www.debuntu.org
>
>

--0016367f967817f9a6049762690e
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Thanks for your response. This seems to involve file I/O and iptables right=
? File I/O seems like a performance bottleneck, no?<br><br>Vineet<br><div c=
lass=3D"gmail_quote">On Mon, Dec 13, 2010 at 4:35 PM, chantra <span dir=3D"=
ltr">&lt;<a href=3D"mailto:chantra@...1258...">chantra@...1258...</a>&gt;</=
span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">


=20=20
=20=20

<div>
Vineet,<br>
<br>
I think you could use Packet filtering plugin hook and use the [KILL] tag a=
t the end of the pf file .<br>
<br>
See <a href=3D"http://openvpn.git.sourceforge.net/git/gitweb.cgi?p=3Dopenvp=
n/openvpn-testing.git;a=3Dblob;f=3Dopenvpn-plugin.h;h=3D56b0a701574e6913b3a=
714e941cdc4899dbea8e1;hb=3DHEAD#l316" target=3D"_blank">http://openvpn.git.=
sourceforge.net/git/gitweb.cgi?p=3Dopenvpn/openvpn-testing.git;a=3Dblob;f=
=3Dopenvpn-plugin.h;h=3D56b0a701574e6913b3a714e941cdc4899dbea8e1;hb=3DHEAD#=
l316</a><br>

<br>
I have never used it myself, but I think that should sort you out.<br>
<br>
The doc says that this file may be dynamically updated during a client sess=
ion. I assume the main process will pick up the change quick fast.<br>
<br>
Chantra<div><div></div><div class=3D"h5"><br>
<br>
On Mon, 2010-12-13 at 15:16 -0800, Vineet Kumar wrote:
</div></div><blockquote type=3D"CITE">
<pre>Hi,
  If my openvpn plugin spawns its own thread and from that thread
wants to kill a tunnel specified by IP:port how can that be done?
(something like what the &#39;telnet&#39; management provides: &quot;kill I=
P:port&quot;)
This plugin is meant to do other stuff and in certain scenarios wants
to close specific tunnels.
First I thought of using the plugin to write code to establish a
telnet-client sessions and send over &quot;kill IP:port&quot; command. But I
notice an issue with the management listener: if I run more than 1
telnet session only the first one can pass through data whereas all
others&#39; telnet sessions just hang.

Is this even possible?

Vineet

---------------------------------------------------------------------------=
---
Lotusphere 2011
Register now for Lotusphere 2011 and learn how
to connect the dots, take your collaborative environment
to the next level, and enter the era of Social Business.
<a href=3D"http://p.sf.net/sfu/lotusphere-d2d" target=3D"_blank">http://p.s=
f.net/sfu/lotusphere-d2d</a>
_______________________________________________
Openvpn-devel mailing list
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a>

</pre>
</blockquote>
<br>
<table cellpadding=3D"0" cellspacing=3D"0" width=3D"100%">
<tbody><tr>
<td>
<pre>--=20
<a href=3D"http://www.debuntu.org" target=3D"_blank">http://www.debuntu.org=
</a>
</pre>
</td>
</tr>
</tbody></table>
</div>

</blockquote></div><br>

--0016367f967817f9a6049762690e--

