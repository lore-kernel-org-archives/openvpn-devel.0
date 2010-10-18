MIME-Version: 1.0
In-Reply-To: <4CBC9C8B.6090302@...1299...>
References: <7a2e6f85bccdf9dc5b9d2a1c05d7bd91.squirrel@...1166...>
	<20101018194332.4f607b78@...1391...>
	<4CBC9C8B.6090302@...1299...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 18 Oct 2010 17:32:20 -0400
Message-ID: <AANLkTiktL1mFakBfYzXp0rgddyH4i8q1H4JqGrtXtr8-@...278...>
Content-Type: multipart/alternative; boundary=0016e6d7f0b774c99b0492eaead6
Subject: Re: [Openvpn-devel] Intelligent OpenVPN service?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0016e6d7f0b774c99b0492eaead6
Content-Type: text/plain; charset=ISO-8859-1

You might want to look at the client GUI. For example, Tunnelblick (OS X GUI
which also includes imbedded tun/tap kexts, OpenVPN and OpenSSL binaries)
has just such a "pre-connnection" feature. People can call a script before
OpenVPN is started, and when OpenVPN finishes. It is used to do such things
as unload Cisico AnyVPN tun before running OpenVPN, and reloading it
afterward. Of course, it would be nice to have it be a part of OpenVPN.

On Mon, Oct 18, 2010 at 3:14 PM, Jason Haar <Jason.Haar@...1299...>wrote:

>  On 10/19/2010 07:43 AM, Davide Brini wrote:
> > Sorry for the silly question, but how do you expect the OpenVPN link to
> be
> > established if the computer "does not already have a connection"?
> >
> > What do you mean with the above statement?
> I think he means: if the machine is on the corporate network, then don't
> kick off an openvpn connection to the corporate network
>
> We did that here using firewall trickery. We block access to the openvpn
> server ports from the corporate network - that way openvpn can remain
> permanently running on all clients, and it will only work when clients
> connect from non-corporate networks.
>
> It's a kludge (hard to scale when you have dozens of corporate Internet
> address ranges) - what's really needed is a "--pre-connection" option -
> so that we can run scripts before the openvpn service even starts. Then
> the "pre" script could explicitly check if the corporate network is
> available (eg attempt to download a HTTPS page from an exclusively
> internal server) and error if it is - causing openvpn to not attempt to
> make a connection
>
> See "2.1 client - how to autorun script post-connect" for further
> comments about why I think a "pre" script option would be a good idea.
>
> --
> Cheers
>
> Jason Haar
> Information Security Manager, Trimble Navigation Ltd.
> Phone: +64 3 9635 377 Fax: +64 3 9635 417
> PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1
>
>
>
> ------------------------------------------------------------------------------
> Download new Adobe(R) Flash(R) Builder(TM) 4
> The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly
> Flex(R) Builder(TM)) enable the development of rich applications that run
> across multiple browsers and platforms. Download your free trials today!
> http://p.sf.net/sfu/adobe-dev2dev
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--0016e6d7f0b774c99b0492eaead6
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

You might want to look at the client GUI. For example, Tunnelblick (OS X GU=
I which also includes imbedded tun/tap kexts, OpenVPN and OpenSSL binaries)=
 has just such a &quot;pre-connnection&quot; feature. People can call a scr=
ipt before OpenVPN is started, and when OpenVPN finishes. It is used to do =
such things as unload Cisico AnyVPN tun before running OpenVPN, and reloadi=
ng it afterward. Of course, it would be nice to have it be a part of OpenVP=
N.<br>

<br><div class=3D"gmail_quote">On Mon, Oct 18, 2010 at 3:14 PM, Jason Haar =
<span dir=3D"ltr">&lt;<a href=3D"mailto:Jason.Haar@...1299...">Jason.Haar@...220...=
..1299...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex;">

<div class=3D"im">=A0On 10/19/2010 07:43 AM, Davide Brini wrote:<br>
&gt; Sorry for the silly question, but how do you expect the OpenVPN link t=
o be<br>
&gt; established if the computer &quot;does not already have a connection&q=
uot;?<br>
&gt;<br>
&gt; What do you mean with the above statement?<br>
</div>I think he means: if the machine is on the corporate network, then do=
n&#39;t<br>
kick off an openvpn connection to the corporate network<br>
<br>
We did that here using firewall trickery. We block access to the openvpn<br>
server ports from the corporate network - that way openvpn can remain<br>
permanently running on all clients, and it will only work when clients<br>
connect from non-corporate networks.<br>
<br>
It&#39;s a kludge (hard to scale when you have dozens of corporate Internet=
<br>
address ranges) - what&#39;s really needed is a &quot;--pre-connection&quot=
; option -<br>
so that we can run scripts before the openvpn service even starts. Then<br>
the &quot;pre&quot; script could explicitly check if the corporate network =
is<br>
available (eg attempt to download a HTTPS page from an exclusively<br>
internal server) and error if it is - causing openvpn to not attempt to<br>
make a connection<br>
<br>
See &quot;2.1 client - how to autorun script post-connect&quot; for further=
<br>
comments about why I think a &quot;pre&quot; script option would be a good =
idea.<br>
<font color=3D"#888888"><br>
--<br>
Cheers<br>
<br>
Jason Haar<br>
Information Security Manager, Trimble Navigation Ltd.<br>
Phone: +64 3 9635 377 Fax: +64 3 9635 417<br>
PGP Fingerprint: 7A2E 0407 C9A6 CAF6 2B9F 8422 C063 5EBB FE1D 66D1<br>
</font><div><div></div><div class=3D"h5"><br>
<br>
---------------------------------------------------------------------------=
---<br>
Download new Adobe(R) Flash(R) Builder(TM) 4<br>
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly<br>
Flex(R) Builder(TM)) enable the development of rich applications that run<b=
r>
across multiple browsers and platforms. Download your free trials today!<br>
<a href=3D"http://p.sf.net/sfu/adobe-dev2dev" target=3D"_blank">http://p.sf=
.net/sfu/adobe-dev2dev</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</div></div></blockquote></div><br>

--0016e6d7f0b774c99b0492eaead6--

