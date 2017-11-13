MIME-Version: 1.0
In-Reply-To: <02ca5729-0e53-40a2-6c1a-a3fa7ce12743@...2080...>
References: <20171110163946.7656-1-fkooman@...2318...>
 <63ccd0e3-491f-3fb3-e611-9b6674d3d501@...2298...>
 <aef485c7-f619-eaac-6534-0828ab9d41f5@...2318...>
 <CAKuzo_jfJQOBhYMEyT4oiNN1xAZkvkxZm8eeDT=xcUfToaC9kQ@...278...>
 <20171112214244.GI958@...1296...>
 <34a7cc97-16e2-becc-4f97-ff8dbf8ecb0a@...2318...>
 <4ea94797-c52a-da17-b5ba-c7f8d9411326@...2181...>
 <4717a1f2-b8c6-26ae-2cf4-42ae5f34c3eb@...1435...>
 <6ad9db3e-63b5-78fe-0105-81c92746feb2@...2080...>
 <d74c3e94-2d0c-a897-5993-76b2bb4b7b13@...2318...>
 <02ca5729-0e53-40a2-6c1a-a3fa7ce12743@...2080...>
From: Selva <selva.nair@...277...>
Date: Mon, 13 Nov 2017 17:57:39 -0500
Message-ID: <CAKuzo_gWqH3auM5TVkWYBnGgrp5kenOhhb_EW6L2ubuFkrYw2g@...278...>
Content-Type: multipart/alternative; boundary="94eb2c04422abc7268055de53320"
Subject: Re: [Openvpn-devel] [PATCH] Implement "status 4" (JSON) for
 management interface
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c04422abc7268055de53320
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 13, 2017 at 3:40 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> On 13/11/17 14:44, Fran=C3=A7ois Kooman wrote:
> > On 11/13/2017 01:16 PM, David Sommerseth wrote:
> [...snip...]
> >> But we should consider if we want to make use of a JSON library
> >> producing the JSON streams.  The reason is to ensure the output is
> >> according to the specification and that escaping if contents is
> >> consistent and proper.  Imagine if someone puts a double-quote into the
> >> CN field of a certificate?
> >>
> >>  CN=3D"} Lets explode things, O=3DHacktivist0
> >>
> >> Or other characters which needs escaping.
> >
> > Another very good point. I do have some experience with json-c [1],
> > would it be acceptable to add this as a project dependency? That is the
> > main reason I started out by just outputting a string and conveniently
> > forgot escaping issues...
>
> Yes, I think that should be fine.  I see it is available in RHEL6 (the
> oldest Linux distribution we support, json-c-0.11-13.el6), so this
> should work out just fine.  So keep in mind to not use a bleeding fresh
> version only available in the latest faster-moving Linux distros.


> What would be needed though is to enable/disable this via ./configure
> (tackled in configure.ac).  We basically can have three approaches here:
>
>  a)  If json-c is found, enable --status 4 by default. If not found,
>      this feature is unavailable.
>

There is no libjson-c for Windows, I guess... Probably no one cares if
--status 4 is not supported on Windows.


>
> > 1. use json-c to generate (human readable) JSON;
> > 2. also support --status (command line) in addition to "status" in
> > management interface
> > 3. do not print "END" marker any longer
>

I suppose that means no "END" as a part of the JSON output (ie., not written
to console or file) but if the output is multi-line, management still needs
to get a
terminating  "END\n" line. Else we will be breaking the management
interface protocol as it stands now.

Selva

--94eb2c04422abc7268055de53320
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Mon, Nov 13, 2017 at 3:40 PM, David <span class=3D"" id=3D":aj5.1=
" tabindex=3D"-1">Sommerseth</span> <span dir=3D"ltr">&lt;<a href=3D"mailto=
:openvpn@...2080..." target=3D"_blank"><span class=3D"" id=3D":aj5.2" tabin=
dex=3D"-1">openvpn</span>@sf.lists.<span class=3D"" id=3D":aj5.3" tabindex=
=3D"-1">topphemmelig</span>.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><span class=3D"gmail-">On 13/11/17 14:44, =
Fran=C3=A7ois Kooman wrote:<br>
&gt; On 11/13/2017 01:16 PM, David Sommerseth wrote:<br>
</span>[...snip...]<br>
<span class=3D"gmail-">&gt;&gt; But we should consider if we want to make u=
se of a JSON library<br>
&gt;&gt; producing the JSON streams.=C2=A0 The reason is to ensure the outp=
ut is<br>
&gt;&gt; according to the specification and that escaping if contents is<br>
&gt;&gt; consistent and proper.=C2=A0 Imagine if someone puts a double-quot=
e into the<br>
&gt;&gt; CN field of a certificate?<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 CN=3D&quot;} Lets explode things, O=3DHacktivist0<br>
&gt;&gt;<br>
&gt;&gt; Or other characters which needs escaping.<br>
&gt;<br>
&gt; Another very good point. I do have some experience with json-c [1],<br>
&gt; would it be acceptable to add this as a project dependency? That is th=
e<br>
&gt; main reason I started out by just outputting a string and conveniently=
<br>
&gt; forgot escaping issues...<br>
<br>
</span>Yes, I think that should be fine.=C2=A0 I see it is available in RHE=
L6 (the<br>
oldest Linux distribution we support, json-c-0.11-13.el6), so this<br>
should work out just fine.=C2=A0 So keep in mind to not use a bleeding fres=
h<br>
version only available in the latest faster-moving Linux distros.</blockquo=
te><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
What would be needed though is to enable/disable this via ./configure<br>
(tackled in <a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_b=
lank">configure.ac</a>).=C2=A0 We basically can have three approaches here:=
<br>
<br>
=C2=A0a)=C2=A0 If json-c is found, enable --status 4 by default. If not fou=
nd,<br>
=C2=A0 =C2=A0 =C2=A0this feature is unavailable.<br></blockquote><div><div>=
<br></div><div>There is no <span class=3D"" id=3D":aj5.4" tabindex=3D"-1">l=
ibjson</span>-c for Windows, I guess... Probably no one cares if</div><div>=
--status 4 is not supported on Windows.</div><div>=C2=A0</div></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-"><br>
&gt; 1. use json-c to generate (human readable) JSON;<br>
&gt; 2. also support --status (command line) in addition to &quot;status&qu=
ot; in<br>
&gt; management interface<br>
&gt; 3. do not print &quot;END&quot; marker any longer<br></span></blockquo=
te><div><br></div><div>I suppose that means no &quot;END&quot; as a part of=
 the <span class=3D"" id=3D":aj5.5" tabindex=3D"-1">JSON</span> output (<sp=
an class=3D"" id=3D":aj5.6" tabindex=3D"-1">ie</span>., not written</div><d=
iv>to console or file) but if the output is multi-line, management still ne=
eds to get a</div><div>terminating =C2=A0&quot;END\n&quot; line. Else we wi=
ll be breaking the management</div><div>interface protocol as it stands now=
.</div><div><br></div><div><span class=3D"" id=3D":aj5.7" tabindex=3D"-1">S=
elva</span></div></div></div></div>

--94eb2c04422abc7268055de53320--

