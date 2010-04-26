MIME-Version: 1.0
In-Reply-To: <6B68DFBC-517B-4031-8E84-A29922AE9C58@...1348...>
References: <6B68DFBC-517B-4031-8E84-A29922AE9C58@...1348...>
Date: Mon, 26 Apr 2010 10:42:37 +0200
Message-ID: <y2p7f02a2eb1004260142r20f55dffqbbeda2588cc44401@...278...>
From: Arnoud Vermeer <a.vermeer@...1359...>
Content-Type: multipart/alternative; boundary=001636c9237e547db004851fc2cf
Subject: Re: [Openvpn-devel] [ANN] OS X packages - OpenVPN 2.1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Toby Thain <toby@...1348...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--001636c9237e547db004851fc2cf
Content-Type: text/plain; charset=ISO-8859-1

Hi Toby,

I for one appreciate your effort and would love to see this in the standard
release process.

Kind regards,

Arnoud Vermeer

On Mon, Apr 26, 2010 at 1:47 AM, Toby Thain <toby@...1348...>wrote:

> Hi,
>
> I have put together a generic packaging script for OS X (pkg/dmg), and
> created basic binary Installer packages for PowerPC and Intel. It's
> meant only for distributing the generic binary distribution, analogous
> to any other UNIX binary package. A small addition is a script which
> installs an OS X launchd service, net.openvpn.
>
> The binary package can be combined with a separate per-client key pkg
> that installs configuration and keys and starts the launchd service
> (scripts also available for this, in key-package directory).
>
> This may help people with simple deployments that include OS X
> clients. I have not linked to built packages, on the theory that
> there's little reason you should trust my builds. (If you have the
> Apple Developer Tools, and archives for openvpn and lzo, then creating
> the binary packages and disk image yourself, for whatever architecture
> you run, is as simple as 'make dmg'. Package build, install and run
> have been tested on 32-bit PowerPC and Intel.)
>
> cc'd devel list in case there is any interest in adopting the
> packaging script(s), perhaps as contrib?
>
> http://telegraphics.com.au/svn/openvpn-package/trunk/
>
> --Toby
>
>
>
> ------------------------------------------------------------------------------
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001636c9237e547db004851fc2cf
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Toby,<div><br></div><div>I for one appreciate your=A0effort and would lo=
ve to see this in the standard release process.</div><div><br></div><div>Ki=
nd regards,</div><div><br></div><div>Arnoud Vermeer<br><br><div class=3D"gm=
ail_quote">
On Mon, Apr 26, 2010 at 1:47 AM, Toby Thain <span dir=3D"ltr">&lt;<a href=
=3D"mailto:toby@...1348...">toby@...1348...</a>&gt;</span> wrote:<br><block=
quote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc=
 solid;padding-left:1ex;">
Hi,<br>
<br>
I have put together a generic packaging script for OS X (pkg/dmg), and<br>
created basic binary Installer packages for PowerPC and Intel. It&#39;s<br>
meant only for distributing the generic binary distribution, analogous<br>
to any other UNIX binary package. A small addition is a script which<br>
installs an OS X launchd service, net.openvpn.<br>
<br>
The binary package can be combined with a separate per-client key pkg<br>
that installs configuration and keys and starts the launchd service<br>
(scripts also available for this, in key-package directory).<br>
<br>
This may help people with simple deployments that include OS X<br>
clients. I have not linked to built packages, on the theory that<br>
there&#39;s little reason you should trust my builds. (If you have the<br>
Apple Developer Tools, and archives for openvpn and lzo, then creating<br>
the binary packages and disk image yourself, for whatever architecture<br>
you run, is as simple as &#39;make dmg&#39;. Package build, install and run=
<br>
have been tested on 32-bit PowerPC and Intel.)<br>
<br>
cc&#39;d devel list in case there is any interest in adopting the<br>
packaging script(s), perhaps as contrib?<br>
<br>
<a href=3D"http://telegraphics.com.au/svn/openvpn-package/trunk/" target=3D=
"_blank">http://telegraphics.com.au/svn/openvpn-package/trunk/</a><br>
<br>
--Toby<br>
<br>
<br>
---------------------------------------------------------------------------=
---<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" targ=
et=3D"_blank">https://lists.sourceforge.net/lists/listinfo/openvpn-devel</a=
><br>
</blockquote></div><br></div>

--001636c9237e547db004851fc2cf--

