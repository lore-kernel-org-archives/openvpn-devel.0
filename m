MIME-Version: 1.0
In-Reply-To: <CAOazyz1+Px-wFYd3DVdm-1Sxponr0xsp2w4m8Mum+HTDyMtovg@...278...>
References: <CAEsd45Rh9zu=FC_Qdt4KiUfGayMqRzshF4OpxsHcszVH+8vBHw@...278...>
	<CAOazyz1+Px-wFYd3DVdm-1Sxponr0xsp2w4m8Mum+HTDyMtovg@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 18 Jul 2012 09:00:02 -0400
Message-ID: <CAEsd45R3Or3izDGLamLOoft=xSNBNH8Qq8ztWb+N5Um4nitdJg@...278...>
Content-Type: multipart/alternative; boundary=20cf3071c6642597d404c51a40c9
Subject: Re: [Openvpn-devel] New build system questions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--20cf3071c6642597d404c51a40c9
Content-Type: text/plain; charset=UTF-8

On Mon, Jul 16, 2012 at 12:45 PM, Alon Bar-Lev <alon.barlev@...277...>wrote:

> > (1) Is there a way to disable building "openvpnserv" and the "auth-pam"
> > plugin?
> --disable-plugin-auth-pam
>

Thanks. I have found the configure documentation. However, I can't get it
to do what I want it to do: I want to build a single openvpn binary that
includes (is statically linked to) lzo, openssl, and pkcs11-helper) and a
separate openvpn-down-root.so that can be used by the binary. (I now
understand that pkcs11 shouldn't be statically linked, but right now I'm
just trying to duplicate the openvpn setup that Tunnelblick has used for
years.)


Do you build for windows? if not, please send me the compile error and
> config.log.
> The windows service should not be built on none windows.
>

No. On OS X, for OS X. And you're right, it does not build the service.
Sorry for my confusion.


 > (3) I want to build "compat" as a static library. How can I do that?
> <snip>
> You don't need the above... just add LDFLAGS="-static", I guess.
>

That doesn't work -- it doesn't make compat static. I still get the same
"Warning: Linking the shared library libcompat.la" message, and no
libcompat.a is produced.

I've fiddled around and haven't been able to get it to build as static,
so I'll just move compat/*.* into src/openvpn and not have a compat library
at all. compat seems to be needed only by openvpn and openvpnserv,
apparently, but not by the down-root plugin. Since I'm not using
openvpnserv, I don't need it as a separate library.


To compile static, you need to build openvpn without plugins
> (--disable-plugins) and all dependencies such as openssl the same.
>

This seems like an unnecessary restriction and breaks what can be done now.
The plugins should always be dynamic, but there is no reason I shouldn't be
able to static-link OpenVPN with OpenSSL and LZO. I do that now, and
OpenVPN builds with plugin support. Then I build the plugin separately. It
all works.

(I had been hoping to be able to use something like
xxx_LIBTOOLSFLAGS="-static" for libraries I want to be static, letting the
other(s) default to shared. That way one build would generate an OpenVPN
binary with everything statically linked into it and a down-root plugin as
a shared library. That's was my goal until another comment mentioned that
pkcs11-helper can't be static. It's been static for years in Tunnelblick,
but that's a whole other issue that I will have to address.)

All this plugin stuff is moot if plugin paths can no longer be absolute
paths, so I'll wait and if that ends up being the case (and it looks like
it will), I will drop plugin support from Tunnelblick.

However, the same problem apparently exists for pkcs11-helper -- it must be
shared. So I may drop support for that in Tunnelblick as well, although
I'll probably leave it in for earlier versions of OpenVPN. (Tunnelblick
contains multiple versions of OpenVPN and lets the user select which one to
use.)

Again, thanks for your help.

--20cf3071c6642597d404c51a40c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Mon, Jul 16, 2012 at 12:45 PM, Alon Bar-Lev <=
span dir=3D"ltr">&lt;<a href=3D"mailto:alon.barlev@...277..." target=3D"_bl=
ank">alon.barlev@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">





<div>&gt; (1) Is there a way to disable building &quot;openvpnserv&quot; an=
d the &quot;auth-pam&quot;<br>
&gt; plugin?<br>
</div>--disable-plugin-auth-pam<br></blockquote><div><br></div><div>Thanks.=
 I have found the configure documentation. However, I can&#39;t get it to d=
o what I want it to do: I want to build a single openvpn binary that includ=
es (is statically linked to) lzo, openssl, and pkcs11-helper) and a separat=
e openvpn-down-root.so that can be used by the binary.=C2=A0(I now understa=
nd that pkcs11 shouldn&#39;t be statically linked, but right now I&#39;m ju=
st trying to duplicate the openvpn setup that Tunnelblick has used for year=
s.)</div>




<div><br></div><div><br></div></div><div><div class=3D"gmail_quote"><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">

Do you build for windows? if not, please send me the compile error and<br>
config.log.<br>
The windows service should not be built on none windows.<br></blockquote><d=
iv><br></div><div>No. On OS X, for OS X. And you&#39;re right, it does not =
build the service. Sorry for my confusion.</div><div><br></div><div><br>




</div>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<div>&gt; (3) I want to build &quot;compat&quot; as a static library. How c=
an I do that?</div><div>&lt;snip&gt;
</div>You don&#39;t need the above... just add LDFLAGS=3D&quot;-static&quot=
;, I guess.<br></blockquote><div><br></div><div>That doesn&#39;t work -- it=
 doesn&#39;t make compat static. I still get the same &quot;Warning: Linkin=
g the shared library <a href=3D"http://libcompat.la" target=3D"_blank">libc=
ompat.la</a>&quot; message, and no libcompat.a is produced.</div>



<div><br></div><div>I&#39;ve fiddled around and haven&#39;t been able to ge=
t it to build as static, so=C2=A0I&#39;ll just move compat/*.* into src/ope=
nvpn and not have a compat library at all. compat seems to be needed only b=
y openvpn and openvpnserv, apparently, but not by the down-root plugin. Sin=
ce I&#39;m not using openvpnserv, I don&#39;t need it as a separate library=
.</div>




<div><br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div>To compile static, you need to build openvpn without plugins</div>
(--disable-plugins) and all dependencies such as openssl the same.<br></blo=
ckquote><div><br></div><div>This seems like an unnecessary restriction and =
breaks what can be done now. The plugins should always be dynamic, but ther=
e is no reason I shouldn&#39;t be able to static-link OpenVPN with OpenSSL =
and LZO. I do that now, and OpenVPN builds with plugin support. Then I buil=
d the plugin separately. It all works.</div>

<div><br></div><div>(I had been hoping to be able to use something like xxx=
_LIBTOOLSFLAGS=3D&quot;-static&quot; for libraries I want to be static, let=
ting the other(s) default to shared. That way one build would generate an O=
penVPN binary with everything statically linked into it and a down-root plu=
gin as a shared library. That&#39;s was my goal until another comment menti=
oned that pkcs11-helper can&#39;t be static. It&#39;s been static for years=
 in Tunnelblick, but that&#39;s a whole other issue that I will have to add=
ress.)</div>




<div><br></div><div>All this plugin stuff is moot if plugin paths can no lo=
nger be absolute paths, so I&#39;ll wait and if that ends up being the case=
 (and it looks like it will), I will drop plugin support from Tunnelblick.<=
/div>

<div><br></div><div>However, the same problem apparently exists for pkcs11-=
helper -- it must be shared. So I may drop support for that in Tunnelblick =
as well, although I&#39;ll probably leave it in for earlier versions of Ope=
nVPN. (Tunnelblick contains multiple versions of OpenVPN and lets the user =
select which one to use.)</div>

<div><br></div><div>Again, thanks for your help.</div>

</div>
</div>

--20cf3071c6642597d404c51a40c9--

