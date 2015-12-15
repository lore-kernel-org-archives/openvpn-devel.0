MIME-Version: 1.0
In-Reply-To: <CAA1AbxKm2cjH3EahH4pdjdRsN9W06aRXAybgWZb1MQc7+X6qYA@...278...>
References: <1448852638-2644-1-git-send-email-fukawi2@...277...>
	<56706E28.8030900@...2080...>
	<CAA1AbxKm2cjH3EahH4pdjdRsN9W06aRXAybgWZb1MQc7+X6qYA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 15 Dec 2015 15:13:56 -0500
Message-ID: <CAKuzo_iGf018xoorQA2eEz5zFZ2qDBv=npRpVMj6EBPHad4WPg@...278...>
Content-Type: multipart/alternative; boundary=089e012298ec1a9f400526f56f6b
Subject: Re: [Openvpn-devel] [PATCH] Use example.com to improve clarity of
	documentation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--089e012298ec1a9f400526f56f6b
Content-Type: text/plain; charset=UTF-8

On Tue, Dec 15, 2015 at 2:54 PM, Steffan Karger <steffan@...1856...> wrote:

> On Tue, Dec 15, 2015 at 8:46 PM, David Sommerseth
> <openvpn@...2080...> wrote:
> > On 30/11/15 04:03, Phillip Smith wrote:
> >> This patch uses the generic "host1.example.com" and "host2.example.com"
> to
> >> replace the current "may" and "june" hostname examples. Generic names
> chosen
> >> rather than other names like "server"/"client" or
> "head-office"/"remote-office"
> >> etc which may create other unintended or implicit meanings to the
> reader.
>
> [..]

> >
> > It doesn't need to be may or june.  Could even be
> > "alice-laptop.example.org", "bob-workstaion.example.org" or something
> > more even more unique.  Just have a broader variety.
>
> Ooh, I like using alice and bob!  Typical crypto example names, and
> easy to differentiate.  But I would prefer to ditch the -laptop and
> -workstation, to prevent unintended or implicit meanings as Philip
> suggested.
>


Yes, alice and bob please.

Alas, we have no mention of middlemen in the manpage -- having
eve.example.com as well would made it complete and more fun to read.

Cheers,

Selva

--089e012298ec1a9f400526f56f6b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Tue, Dec 15, 2015 at 2:54 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On Tue,=
 Dec 15, 2015 at 8:46 PM, David Sommerseth<br>
&lt;<a href=3D"mailto:openvpn@...2080...">openvpn@...2080...</a>&gt; wrote:=
<br>
&gt; On 30/11/15 04:03, Phillip Smith wrote:<br>
&gt;&gt; This patch uses the generic &quot;<a href=3D"http://host1.example.=
com" rel=3D"noreferrer" target=3D"_blank">host1.example.com</a>&quot; and &=
quot;<a href=3D"http://host2.example.com" rel=3D"noreferrer" target=3D"_bla=
nk">host2.example.com</a>&quot; to<br>
&gt;&gt; replace the current &quot;may&quot; and &quot;june&quot; hostname =
examples. Generic names chosen<br>
&gt;&gt; rather than other names like &quot;server&quot;/&quot;client&quot;=
 or &quot;head-office&quot;/&quot;remote-office&quot;<br>
&gt;&gt; etc which may create other unintended or implicit meanings to the =
reader.<br>
</span><span class=3D""><br></span></blockquote><div>[..] <br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><span class=3D"">
&gt;<br>
&gt; It doesn&#39;t need to be may or june.=C2=A0 Could even be<br>
&gt; &quot;<a href=3D"http://alice-laptop.example.org" rel=3D"noreferrer" t=
arget=3D"_blank">alice-laptop.example.org</a>&quot;, &quot;<a href=3D"http:=
//bob-workstaion.example.org" rel=3D"noreferrer" target=3D"_blank">bob-work=
staion.example.org</a>&quot; or something<br>
&gt; more even more unique.=C2=A0 Just have a broader variety.<br>
<br>
</span>Ooh, I like using alice and bob!=C2=A0 Typical crypto example names,=
 and<br>
easy to differentiate.=C2=A0 But I would prefer to ditch the -laptop and<br>
-workstation, to prevent unintended or implicit meanings as Philip<br>
suggested.<br>
</blockquote></div><br><br></div><div class=3D"gmail_extra">Yes, alice and =
bob please. <br><br>Alas, we have no mention of middlemen in the manpage --=
 having <br><a href=3D"http://eve.example.com">eve.example.com</a> as well =
would made it complete and more fun to read.<br><br></div><div class=3D"gma=
il_extra">Cheers,<br><br></div><div class=3D"gmail_extra">Selva<br></div></=
div>

--089e012298ec1a9f400526f56f6b--

