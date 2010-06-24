MIME-Version: 1.0
In-Reply-To: <1277380709.2567.73.camel@...1259...>
References: <AANLkTilYpS47A68hRLrkMYiyHBBZlBc14lz9HCoe9GYZ@...278...>
	<1277380709.2567.73.camel@...1259...>
Date: Thu, 24 Jun 2010 14:55:56 -0700
Message-ID: <AANLkTinWfGmwTgaQFphuGIBItVhNlDK-UPZDOUpoCuu2@...278...>
From: Vineet Kumar <vineet.kumar@...277...>
Content-Type: multipart/alternative; boundary=000e0cd32c160e507e0489cdb8f2
Subject: Re: [Openvpn-devel] ovpn daemon not seeing my plugin thread...
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

--000e0cd32c160e507e0489cdb8f2
Content-Type: text/plain; charset=ISO-8859-1

Perfect! The following worked:
I defined openvpn_plugin_select_initialization_point_v1() to return
OPENVPN_PLUGIN_INIT_POST_DAEMON and now it all works since the plugin
invocation now gets delayed to be after the daemon thread starts up.

Thanks a lot,

Vineet
On Thu, Jun 24, 2010 at 4:58 AM, chantra <chantra@...1258...> wrote:

>  The reason is obviously the fact that the thread-creation occurred
> *before* the daemon() call (that forked off a child which has no way
> of inheriting a copy of that thread).
> So does this mean then that the ovpn daemon infrastructure will only
> work with plugins that don't do threading of their own?
>
>  You might want to look at
> openvpn_plugin_select_initialization_point_v1  function
>
> as done here
>
> http://redmine.debuntu.org/projects/openvpn-ldap-auth/repository/revisions/master/entry/src/ldap-auth.c#L430
>
>   -- http://www.debuntu.org
>
>   !DSPAM:4c23486761678150054016!
>

--000e0cd32c160e507e0489cdb8f2
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Perfect! The following worked:<br>I defined openvpn_plugin_select_initializ=
ation_point_v1() to return OPENVPN_PLUGIN_INIT_POST_DAEMON and now it all w=
orks since the plugin invocation now gets delayed to be after the daemon th=
read starts up.<br>
<br>Thanks a lot,<br><br>Vineet<br><div class=3D"gmail_quote">On Thu, Jun 2=
4, 2010 at 4:58 AM, chantra <span dir=3D"ltr">&lt;<a href=3D"mailto:chantra=
@...1258...">chantra@...1258...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); margin=
: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">



=20=20
=20=20

<div><div class=3D"im">
<blockquote type=3D"CITE">
<pre>The reason is obviously the fact that the thread-creation occurred
*before* the daemon() call (that forked off a child which has no way
of inheriting a copy of that thread).
So does this mean then that the ovpn daemon infrastructure will only
work with plugins that don&#39;t do threading of their own?
</pre>
</blockquote></div>
You might want to look at <br>
openvpn_plugin_select_initialization_point_v1=A0 function<br>
<br>
as done here <br>
<a href=3D"http://redmine.debuntu.org/projects/openvpn-ldap-auth/repository=
/revisions/master/entry/src/ldap-auth.c#L430" target=3D"_blank">http://redm=
ine.debuntu.org/projects/openvpn-ldap-auth/repository/revisions/master/entr=
y/src/ldap-auth.c#L430</a><br>
<font color=3D"#888888">
<br>
<table width=3D"100%" cellpadding=3D"0" cellspacing=3D"0">
<tbody><tr>
<td>
<pre>--=20
<a href=3D"http://www.debuntu.org" target=3D"_blank">http://www.debuntu.org=
</a>
</pre>
</td>
</tr>
</tbody></table>

!DSPAM:4c23486761678150054016!

</font></div>



</blockquote></div><br>

--000e0cd32c160e507e0489cdb8f2--

