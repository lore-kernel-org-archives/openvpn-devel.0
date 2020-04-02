MIME-Version: 1.0
References: <1585513970-32658-2-git-send-email-selva.nair@...277...>
 <1585591527-23734-1-git-send-email-selva.nair@...277...>
 <1585591527-23734-2-git-send-email-selva.nair@...277...>
 <CAEsd45TURv8WK_OQ-7OOy8EHXtVpGhD9+vH0_iPVMS9NOAdKeA@...278...>
In-Reply-To: <CAEsd45TURv8WK_OQ-7OOy8EHXtVpGhD9+vH0_iPVMS9NOAdKeA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 2 Apr 2020 13:09:49 -0400
Message-ID: <CAKuzo_g1MVtooHcHiRZi_wLiKYRSm=UB2pLG4wDB1kvwt0-WRw@...278...>
Content-Type: multipart/alternative; boundary="0000000000004b0ec405a251dfa5"
Subject: Re: [Openvpn-devel] [PATCH v2 2/2] When auth-user-pass file has no
 password, query the management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000004b0ec405a251dfa5
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Apr 2, 2020 at 12:56 PM Jonathan K. Bullard <jkbullard@...277...>
wrote:

> Hi,
>
> On Mon, Mar 30, 2020 at 2:06 PM <selva.nair@...277...> wrote:
> >
> > From: Selva Nair <selva.nair@...277...>
> >
> > When only username is found in the file, redirect the auth-user-pass
> > query to the management if management-query-passwords is enabled.
> > Otherwise the user is prompted on console, if available, as before.
> >
> > This changes the behaviour for those who run from the command line,
> > with --management-query-passwords, but still expect the prompt
> > on the console.
> >
> > Note that the management will prompt for both username and password
> > ignoring the username read from the file. As most GUIs can save the
> > the username, this is a one-time inconvenience.
> >
> > Currently, the password is queried on the console (or systemd)
> > in such cases. This is not sensible when console is not available
> > (windows GUI, tunnelblick etc.) or when the log is redirected
> > to a file on Windows (for some reason prompt goes to the log file).
> >
> > Trac # 757
>
> snip..


>
> Works for Tunnelblick, thanks!
>

Good to know.


>
> One minor point: in all four places, plus in the email subject, "the
> management" should be changed to "the management interface".
>
>
agreed.

Selva

--0000000000004b0ec405a251dfa5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Apr 2, 2020 at 12:56 PM Jonathan K. Bullar=
d &lt;<a href=3D"mailto:jkbullard@...277...">jkbullard@...277...</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Mar 30, 2020 at 2:06 PM &lt;<a href=3D"mailto:selva.nair@...277..."=
 target=3D"_blank">selva.nair@...277...</a>&gt; wrote:<br>
&gt;<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt;<br>
&gt; When only username is found in the file, redirect the auth-user-pass<b=
r>
&gt; query to the management if management-query-passwords is enabled.<br>
&gt; Otherwise the user is prompted on console, if available, as before.<br>
&gt;<br>
&gt; This changes the behaviour for those who run from the command line,<br>
&gt; with --management-query-passwords, but still expect the prompt<br>
&gt; on the console.<br>
&gt;<br>
&gt; Note that the management will prompt for both username and password<br>
&gt; ignoring the username read from the file. As most GUIs can save the<br>
&gt; the username, this is a one-time inconvenience.<br>
&gt;<br>
&gt; Currently, the password is queried on the console (or systemd)<br>
&gt; in such cases. This is not sensible when console is not available<br>
&gt; (windows GUI, tunnelblick etc.) or when the log is redirected<br>
&gt; to a file on Windows (for some reason prompt goes to the log file).<br>
&gt;<br>
&gt; Trac # 757<br><br></blockquote><div>snip..</div><div>=C2=A0</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
<br>
Works for Tunnelblick, thanks!<br></blockquote><div><br></div><div>Good to =
know.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">
<br>
One minor point: in all four places, plus in the email subject, &quot;the<b=
r>
management&quot; should be changed to &quot;the management interface&quot;.=
<br>
<br></blockquote><div><br></div><div>agreed.</div><div><br></div><div>Selva=
</div></div></div>

--0000000000004b0ec405a251dfa5--

