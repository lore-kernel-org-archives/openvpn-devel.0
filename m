MIME-Version: 1.0
In-Reply-To: <989fe285-59a8-ad15-4e1d-1f25486dfe1e@...2080...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<f55ae849-32a0-5f7e-829f-1158bc3d68fc@...2080...>
	<3a78050c-8c18-d54e-fc37-330272de6d44@...2080...>
	<CAKuzo_gFnsY-6nsEsP_jPmfXLrJs0mDj-9fhwKQC-12TwfVAYg@...278...>
	<989fe285-59a8-ad15-4e1d-1f25486dfe1e@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 15 Dec 2016 10:53:56 -0500
Message-ID: <CAKuzo_iAOULdks1WQKxRCR9rDDmb0nRc84=O7qqJ87+TaUWr+w@...278...>
Content-Type: multipart/alternative; boundary=94eb2c05b50a378dc60543b4774b
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

--94eb2c05b50a378dc60543b4774b
Content-Type: text/plain; charset=UTF-8

On Thu, Dec 15, 2016 at 8:00 AM, David Sommerseth <
openvpn@...2080...> wrote:

> > The only issue I noticed is that some functions, for loops and switch
> > statements have their opening braces on the same line
> > ssl.c line 272, tun.c line 697 and many such in the several files.
> > (try grep ") {$"  *.c).
> >
> > Probably needed nl_switch_brace, nl_fcall_brace etc in the config --
> > urgh.. Too many options is a blessing and bane at the same time..
>
> Agreed.  I think that we can do some minor reformatting changes later on
> if we decide to change some more options.  Those reformatting changes
> will most likely not be as invasive as this one has been.
>

There are also some multi-line comments with closing "*/" not on a line by
itself.

If we want to fix any of this I think this is the time -- massive
reformatting is not something to be done often.


> > This is not a show stopper for me. Could be handled manually in future
> > edits when code in the vicinity is touched..
>
> I will now write a new script which patch contributors should run
> against modified files before committing and submitting.  This should
> hopefully make it better in the long run.  But with that in mind, we
> will need to re-run the reformat-all.sh script each time we decide to
> modify uncrustify options.


We have to be cautious here. Running uncrustify on is not something we
should do frequently -- I thought this was a once in a lifetime
reformatting to be followed by some self-imposed discipline for future
patches guided by the CodeStyle page.

First, uncrustify is not idempotent, although running two or three times
appears to make the source settle into an invariant form. Sometimes
multiple runs slightly messes up some otherwise good formatting.  Secondly,
its an actively developed code so behaviour could change. In fact they
already fixed the segfault bug that I had reported upstream.

So I'd be wary of adopting a policy that patch submission be preceded by an
uncrustify run.

Selva

--94eb2c05b50a378dc60543b4774b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Thu, Dec 15, 2016 at 8:00 AM, David Sommerseth <span dir=3D"ltr">&lt;<a =
href=3D"mailto:openvpn@...2080..." target=3D"_blank">openvpn@...2156...<wbr=
>.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"m=
argin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span>&gt; Th=
e only issue I noticed is that some functions, for loops and switch<br>
&gt; statements have their opening braces on the same line<br>
&gt; ssl.c line 272, tun.c line 697 and many such in the several files.<br>
&gt; (try grep &quot;) {$&quot;=C2=A0 *.c).<br>
&gt;<br>
&gt; Probably needed nl_switch_brace, nl_fcall_brace etc in the config --<b=
r>
&gt; urgh.. Too many options is a blessing and bane at the same time..<br>
<br>
</span>Agreed.=C2=A0 I think that we can do some minor reformatting changes=
 later on<br>
if we decide to change some more options.=C2=A0 Those reformatting changes<=
br>
will most likely not be as invasive as this one has been.<br></blockquote><=
div><br></div><div>There are also some multi-line comments with closing &qu=
ot;*/&quot; not on a line by itself.</div><div><br></div><div>If we want to=
 fix any of this I think this is the time -- massive reformatting is not so=
mething to be done often.</div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
<span><br>
&gt; This is not a show stopper for me. Could be handled manually in future=
<br>
&gt; edits when code in the vicinity is touched..<br>
<br>
</span>I will now write a new script which patch contributors should run<br>
against modified files before committing and submitting.=C2=A0 This should<=
br>
hopefully make it better in the long run.=C2=A0 But with that in mind, we<b=
r>
will need to re-run the reformat-all.sh script each time we decide to<br>
modify uncrustify options.</blockquote><div><br></div><div>We have to be ca=
utious here. Running uncrustify on is not something we should do frequently=
 -- I thought this was a once in a lifetime reformatting to be followed by =
some self-imposed discipline for future patches guided by the CodeStyle pag=
e. =C2=A0</div><div><br></div><div>First, uncrustify is not idempotent, alt=
hough running two or three times appears to make the source settle into an =
invariant form. Sometimes multiple runs slightly messes up some otherwise g=
ood formatting.=C2=A0 Secondly, its an actively developed code so behaviour=
 could change. In fact they already fixed the segfault bug that I had repor=
ted upstream.</div><div><br></div><div>So I&#39;d be wary of adopting a pol=
icy that patch submission be preceded by an uncrustify run.</div><div><br><=
/div><div>Selva</div></div></div></div>

--94eb2c05b50a378dc60543b4774b--

