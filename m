MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
References: <c129e755-6c9e-a35f-2958-84b44baa96f2@...515...>
	<8a543794-fa2e-cc1b-5db5-7cc9106d126b@...2080...>
From: Emmanuel Deloget <logout@...260...>
Date: Thu, 22 Jun 2017 00:36:27 +0200
Message-ID: <CAKh=nwF2mKg_YTz34b_wH9c3dLj6ht+jvZnozzB=zXZ1n17fEQ@...278...>
Content-Type: multipart/alternative; boundary="94eb2c1b0e2cba46a305527fffe5"
Subject: Re: [Openvpn-devel] OpenVPN 2.4.3 released (with security fixes)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>, openvpn-announce@lists.sourceforge.net

--94eb2c1b0e2cba46a305527fffe5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, Jun 21, 2017 at 11:06 PM, David Sommerseth <
openvpn@...2080...> wrote:

=E2=80=8B<snip>=E2=80=8B


> But for reasons unknown to me, those tarballs got re-created somewhere
> later in the release chain.  The contents of all tarballs are
> essentially the same, but due to the "nice" artefact that the tar format
> is non-deterministic on the output, even though the input is the same,
> that begins to prepare the stage for this chaos.  Especially when what
> is being uploaded is partly from the initial run and then some files
> from a different run
> =E2=80=8B.
>

=E2=80=8BIt might be possible to pay with several tar options, including:

--sort=3Dname : sort added files by name, and not by the order specified by
the OS
--mtime=3DDATE-OR-FILE : set mtime of added file to a known value (either t=
he
mtime of a file or an arbitrary date/time string).  =E2=80=8B

=E2=80=8BThese two options should help=E2=80=8B

=E2=80=8BBoth options are being used by the LEDE project=E2=80=8B which cla=
im support of
reproducible builds for a limited list of targets (tar is used when
building packages [1]).

=E2=80=8B[1]
https://git.lede-project.org/?p=3Dsource.git;a=3Dblob;f=3Dscripts/ipkg-buil=
d#l142=E2=80=8B



> --
> kind regards,
>
> David Sommerseth
> OpenVPN Technologies, Inc
>
>
=E2=80=8BBR,

-- Emmanuel Deloget=E2=80=8B

--94eb2c1b0e2cba46a305527fffe5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:&quot;co=
urier new&quot;,monospace">Hi David,=C2=A0</div><div class=3D"gmail_extra">=
<br><div class=3D"gmail_quote">On Wed, Jun 21, 2017 at 11:06 PM, David Somm=
erseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." target=
=3D"_blank">openvpn@...2080...</a>&gt;</span> wrote:</div><div class=3D"gma=
il_quote"><br><div><div class=3D"gmail_default" style=3D"font-family:&quot;=
courier new&quot;,monospace">=E2=80=8B&lt;snip&gt;=E2=80=8B</div></div><div=
>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
But for reasons unknown to me, those tarballs got re-created somewhere<br>
later in the release chain.=C2=A0 The contents of all tarballs are<br>
essentially the same, but due to the &quot;nice&quot; artefact that the tar=
 format<br>
is non-deterministic on the output, even though the input is the same,<br>
that begins to prepare the stage for this chaos.=C2=A0 Especially when what=
<br>
is being uploaded is partly from the initial run and then some files<br>
from a different run<div class=3D"gmail_default" style=3D"font-family:&quot=
;courier new&quot;,monospace;display:inline">=E2=80=8B.</div></blockquote><=
div><br></div><div><div class=3D"gmail_default" style=3D"font-family:&quot;=
courier new&quot;,monospace">=E2=80=8BIt might be possible to pay with seve=
ral tar options, including:</div><div class=3D"gmail_default" style=3D"font=
-family:&quot;courier new&quot;,monospace"><br></div><div class=3D"gmail_de=
fault" style=3D"font-family:&quot;courier new&quot;,monospace">--sort=3Dnam=
e : sort added files by name, and not by the order specified by the OS</div=
><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,=
monospace">--mtime=3DDATE-OR-FILE : set mtime of added file to a known valu=
e (either the mtime of a file or an arbitrary date/time string). =C2=A0=E2=
=80=8B</div><br></div><div><div class=3D"gmail_default" style=3D"font-famil=
y:&quot;courier new&quot;,monospace">=E2=80=8BThese two options should help=
=E2=80=8B</div><br></div><div><div class=3D"gmail_default" style=3D"font-fa=
mily:&quot;courier new&quot;,monospace">=E2=80=8BBoth options are being use=
d by the LEDE project=E2=80=8B which claim support of reproducible builds f=
or a limited list of targets (tar is used when building packages [1]).=C2=
=A0</div><br></div><div><div class=3D"gmail_default" style=3D"font-family:&=
quot;courier new&quot;,monospace">=E2=80=8B[1] <a href=3D"https://git.lede-=
project.org/?p=3Dsource.git;a=3Dblob;f=3Dscripts/ipkg-build#l142">https://g=
it.lede-project.org/?p=3Dsource.git;a=3Dblob;f=3Dscripts/ipkg-build#l142</a=
>=E2=80=8B</div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex"><div class=3D"gmail-HOEnZb"><div class=3D"gmail-h5">
--<br>
kind regards,<br>
<br>
David Sommerseth<br>
OpenVPN Technologies, Inc<br>
<br></div></div></blockquote><div><br></div><div class=3D"gmail_default" st=
yle=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8BBR,=C2=A0</d=
iv><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot=
;,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:&q=
uot;courier new&quot;,monospace">-- Emmanuel Deloget=E2=80=8B</div></div></=
div></div>

--94eb2c1b0e2cba46a305527fffe5--

