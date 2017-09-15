MIME-Version: 1.0
In-Reply-To: <41521e18-121d-ebda-3ac9-044310599288@...1227...>
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
 <41521e18-121d-ebda-3ac9-044310599288@...1227...>
From: Selva <selva.nair@...277...>
Date: Fri, 15 Sep 2017 11:56:28 -0400
Message-ID: <CAKuzo_i0h7NbSwFhN4DD1ZnisA5_mdMrPc_nywqguks-DhokLA@...278...>
Content-Type: multipart/alternative; boundary="001a113de988d8d23f05593c70c9"
Subject: Re: [Openvpn-devel] [PATCH] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113de988d8d23f05593c70c9
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 15, 2017 at 11:44 AM, Arne Schwabe <arne@...1227...> wrote:

> On 9/15/17 6:41 AM, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Eliminate the confusing message that says "explicit-exit-notify is
> ignored by
> > previous <connection> blocks" when the option is pushed.
> > Reported by: Eike Lohmann e.lohmann@...1294...
> > https://www.mail-archive.com/openvpn-users@...282...
> .net/msg04052.html
>
> The problem exists for all connection block options that are pushable.
> We rather need to signal when options are pushed (or do a dirty
> streq(file, [pushed-options]) and then only ignore the warning. The
> warning is just bogus for pushed options.
>


Isn't that what the variable pull_mode is for? Its True when we are
processing a pushed option False otherwise.

Selva



> Arne
>

--001a113de988d8d23f05593c70c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Sep 15, 2017 at 11:44 AM, Arne Schwabe <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex"><span>On 9/15/17 6:41 AM, <=
a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...1354...=
..</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt;<br>
&gt; Eliminate the confusing message that says &quot;explicit-exit-notify i=
s ignored by<br>
&gt; previous &lt;connection&gt; blocks&quot; when the option is pushed.<br>
&gt; Reported by: Eike Lohmann <a href=3D"mailto:e.lohmann@...1294..." targ=
et=3D"_blank">e.lohmann@...1294...</a><br>
&gt; <a href=3D"https://www.mail-archive.com/openvpn-users@...1483...=
e.net/msg04052.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-=
archive.com/o<wbr>penvpn-users@...282...<wbr>.net/msg04052.html</a><br>
<br>
</span>The problem exists for all connection block options that are pushabl=
e.<br>
We rather need to signal when options are pushed (or do a dirty<br>
streq(file, [pushed-options]) and then only ignore the warning. The<br>
warning is just bogus for pushed options.<br></blockquote><div><br></div><d=
iv><br></div><div>Isn&#39;t that what the variable pull_mode is for? Its Tr=
ue when we are processing a pushed option False otherwise.</div><div><br></=
div><div>Selva</div><div><br></div><div><br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left=
:1ex">
<span class=3D"m_4531974659254807547HOEnZb"><font color=3D"#888888"><br>
Arne<br>
</font></span></blockquote></div><br></div></div>

--001a113de988d8d23f05593c70c9--

