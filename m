MIME-Version: 1.0
In-Reply-To: <3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
	<3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 15 Dec 2016 00:09:09 -0500
Message-ID: <CAKuzo_gFnsY-6nsEsP_jPmfXLrJs0mDj-9fhwKQC-12TwfVAYg@...278...>
Content-Type: multipart/alternative; boundary=001a113bc88046429f0543ab75be
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113bc88046429f0543ab75be
Content-Type: text/plain; charset=UTF-8

On Wed, Dec 14, 2016 at 4:18 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

> On 13/12/16 22:42, David Sommerseth wrote:
> >
> > Hi all,
> >
> > So the first phase of the great reformatting is on its way.  I have
> > just pushed out a reformatting branch to the following
> > repositories:
> >
> > https://github.com:OpenVPN/openvpn.git
> > https://gitlab.com:openvpn/openvpn.git
> > git://git.code.sf.net/p/openvpn/openvpn
> >
>
> An updated reformatting branch have been pushed out.  If you have
> already fetched the it, git will most likely complain as to make
> these tests flow reasonably well without cluttering the git tree
> too much we have used forced pushes on this branch.
>
> And again, the The Great Reformatting patch is PGP signed as well,
> which can be verified with 'git log --show-signature'.  The
> signing key is 0x86CF944C9671FDF2, which is the same as this mail
> is signed with.


The reformatting looks pretty good for an automated process. The result
agrees with independently running the script on master.

The only issue I noticed is that some functions, for loops and switch
statements have their opening braces on the same line
ssl.c line 272, tun.c line 697 and many such in the several files.
(try grep ") {$"  *.c).

Probably needed nl_switch_brace, nl_fcall_brace etc in the config -- urgh..
Too many options is a blessing and bane at the same time..

This is not a show stopper for me. Could be handled manually in future
edits when code in the vicinity is touched..

Selva

--001a113bc88046429f0543ab75be
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Wed, Dec 14, 2016 at 4:18 PM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2142...<wbr=
>topphemmelig.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><span>On 13/12/16 22:42, David Sommerseth wrote:<br>
&gt;<br>
&gt; Hi all,<br>
&gt;<br>
&gt; So the first phase of the great reformatting is on its way.=C2=A0 I ha=
ve<br>
&gt; just pushed out a reformatting branch to the following<br>
&gt; repositories:<br>
&gt;<br>
&gt; https://github.com:OpenVPN/ope<wbr>nvpn.git<br>
&gt; https://gitlab.com:openvpn/ope<wbr>nvpn.git<br>
&gt; git://<a href=3D"http://git.code.sf.net/p/openvpn/openvpn" rel=3D"nore=
ferrer" target=3D"_blank">git.code.sf.net/p/openvp<wbr>n/openvpn</a><br>
&gt;<br>
<br>
</span>An updated reformatting branch have been pushed out.=C2=A0 If you ha=
ve<br>
already fetched the it, git will most likely complain as to make<br>
these tests flow reasonably well without cluttering the git tree<br>
too much we have used forced pushes on this branch.<br>
<br>
And again, the The Great Reformatting patch is PGP signed as well,<br>
which can be verified with &#39;git log --show-signature&#39;.=C2=A0 The<br>
signing key is 0x86CF944C9671FDF2, which is the same as this mail<br>
<span>is signed with.</span></blockquote></div><br></div><div class=3D"gmai=
l_extra">The reformatting looks pretty good for an automated process. The r=
esult agrees with independently running the script on master. <br><br></div=
><div class=3D"gmail_extra">The only issue I noticed is that some functions=
, for loops and switch statements have their opening braces on the same lin=
e <br></div><div class=3D"gmail_extra">ssl.c line 272, tun.c line 697 and m=
any such in the several files.<br></div><div class=3D"gmail_extra">(try gre=
p &quot;) {$&quot;=C2=A0 *.c).<br><br></div><div class=3D"gmail_extra">Prob=
ably needed nl_switch_brace, nl_fcall_brace etc in the config -- urgh.. Too=
 many options is a blessing and bane at the same time..<br></div><div class=
=3D"gmail_extra"><br></div><div class=3D"gmail_extra">This is not a show st=
opper for me. Could be handled manually in future edits when code in the vi=
cinity is touched..</div><div class=3D"gmail_extra"><br>Selva<br></div></di=
v>

--001a113bc88046429f0543ab75be--

