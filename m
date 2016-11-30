MIME-Version: 1.0
In-Reply-To: <bcec447a-d77b-996e-e1ed-b2daf9a88696@...1227...>
References: <1480466372-2396-1-git-send-email-selva.nair@...277...>
	<201611301858.uAUIwRPD071804@...2054...>
	<bcec447a-d77b-996e-e1ed-b2daf9a88696@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 30 Nov 2016 17:12:43 -0500
Message-ID: <CAKuzo_hNxHKzAYUOj4HPCKbJMHfXjghGUG0+tQ4Wy=bRL4dX4g@...278...>
Content-Type: multipart/alternative; boundary=94eb2c06cdea3942dc05428c0230
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Force 'def1' method when
 --redirect-gateway is done through service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c06cdea3942dc05428c0230
Content-Type: text/plain; charset=UTF-8

On Wed, Nov 30, 2016 at 5:06 PM, Arne Schwabe <arne@...1227...> wrote:

> >
> > The patch does what we agreed on in the trac ticket ("no user changes"
> > for the normal case, and "in the service pipe change, imply def1 if
> > no flags set").  This is very little extra code and easily checked,
> > while fixing this in other ways would need much more code - for a sort-of
> > historic approach to routing table handling (we really shouldn't be
> > *removing* other people's routes, and we don't do that for IPv6 either).
> >
> > Semi-ACK on the approach from Arne ("that's what we do on Android") :-)
>
> Slight correction. We actually set 0.0.0.0/0 on Android but Android
> *always* translates that into a 0.0.0.0/1 and a 128.0.0.0/1 rule.
>
> We could do the same and do the translation in the interactive service
> instead of OpenVPN itself.


Yeah  that's an option but we'll have to make the HandleRouteMsg() code in
service
parse and understand the default route. Currently it just does what its
told to do (touch wood!).
When the service is taught to change things like that, it could come and
bite us one day..
The current approach is probably simpler.

Selva

--94eb2c06cdea3942dc05428c0230
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Nov 30, 2016 at 5:06 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=
=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span=
> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><span class=3D"">&gt;<br>
&gt; The patch does what we agreed on in the trac ticket (&quot;no user cha=
nges&quot;<br>
&gt; for the normal case, and &quot;in the service pipe change, imply def1 =
if<br>
&gt; no flags set&quot;).=C2=A0 This is very little extra code and easily c=
hecked,<br>
&gt; while fixing this in other ways would need much more code - for a sort=
-of<br>
&gt; historic approach to routing table handling (we really shouldn&#39;t b=
e<br>
&gt; *removing* other people&#39;s routes, and we don&#39;t do that for IPv=
6 either).<br>
&gt;<br>
&gt; Semi-ACK on the approach from Arne (&quot;that&#39;s what we do on And=
roid&quot;) :-)<br>
<br>
</span>Slight correction. We actually set <a href=3D"http://0.0.0.0/0" rel=
=3D"noreferrer" target=3D"_blank">0.0.0.0/0</a> on Android but Android<br>
*always* translates that into a <a href=3D"http://0.0.0.0/1" rel=3D"norefer=
rer" target=3D"_blank">0.0.0.0/1</a> and a <a href=3D"http://128.0.0.0/1" r=
el=3D"noreferrer" target=3D"_blank">128.0.0.0/1</a> rule.<br>
<br>
We could do the same and do the translation in the interactive service<br>
instead of OpenVPN itself.</blockquote></div><br>Yeah =C2=A0that&#39;s an o=
ption but we&#39;ll have to make the HandleRouteMsg() code in service</div>=
<div class=3D"gmail_extra">parse and understand the default route. Currentl=
y it just does what its told to do (touch wood!).</div><div class=3D"gmail_=
extra">When the service is taught to change things like that, it could come=
 and bite us one day..</div><div class=3D"gmail_extra">The current approach=
 is probably simpler.</div><div class=3D"gmail_extra"><br></div><div class=
=3D"gmail_extra">Selva</div><div class=3D"gmail_extra"><br></div></div>

--94eb2c06cdea3942dc05428c0230--

