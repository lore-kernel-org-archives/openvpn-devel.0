MIME-Version: 1.0
References: <20230101215109.1521549-1-selva.nair@...277...>
In-Reply-To: <20230101215109.1521549-1-selva.nair@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 2 Jan 2023 14:44:55 -0500
Message-ID: <CAKuzo_iCCtH7E+b6L4X2_e5AXRNt+29T7syg1a0hDXOe+=6cjw@...278...>
Content-Type: multipart/alternative; boundary="000000000000731db005f14d3038"
Subject: Re: [Openvpn-devel] [PATCH 0/5] Improve signals and avoid losing
 high priority ones
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000731db005f14d3038
Content-Type: text/plain; charset="UTF-8"

Please use v2 for 4/5 and 5/5 -- sorry about the noise.

On Sun, Jan 1, 2023 at 4:51 PM <selva.nair@...277...> wrote:

> From: Selva Nair <selva.nair@...277...>
>
> Back to my long-forgotten signal patch -- cleaned up and rebased.
> What better to do on a Jan 1st afternoon...
>
> Commits:
>
> 1.  Preparing for better signal handling: some code refactoring
> 2.  Refactor signal handling in openvpn_getaddrinfo
> 3.  Assign and honour signal priority order
> 4.  Fix signal handling on Windows
> 5.  Improve signal handling using POSIX sigaction
>
> Commits 1 to 4 are fairly non-intrusive and should fix trac #639 and #311
> (or github #205) for most practical purposes.
>
> Commit 5 rewrites sig.c using sigaction for proper masking of signals
> during
> updates. May be too intrusive and too late to get well-tested for 2.6.
>

--000000000000731db005f14d3038
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Please use v2 for 4/5 and 5/5 -- sorry ab=
out the noise.</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=
=3D"gmail_attr">On Sun, Jan 1, 2023 at 4:51 PM &lt;<a href=3D"mailto:selva.=
nair@...277...">selva.nair@...277...</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">From: Selva Nair &lt;<a href=3D"mailto:=
selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;<br>
<br>
Back to my long-forgotten signal patch -- cleaned up and rebased.<br>
What better to do on a Jan 1st afternoon...<br>
<br>
Commits:<br>
<br>
1.=C2=A0 Preparing for better signal handling: some code refactoring<br>
2.=C2=A0 Refactor signal handling in openvpn_getaddrinfo<br>
3.=C2=A0 Assign and honour signal priority order<br>
4.=C2=A0 Fix signal handling on Windows<br>
5.=C2=A0 Improve signal handling using POSIX sigaction<br>
<br>
Commits 1 to 4 are fairly non-intrusive and should fix trac #639 and #311<b=
r>
(or github #205) for most practical purposes.<br>
<br>
Commit 5 rewrites sig.c using sigaction for proper masking of signals durin=
g<br>
updates. May be too intrusive and too late to get well-tested for 2.6.<br>
</blockquote></div></div>

--000000000000731db005f14d3038--

