MIME-Version: 1.0
References: <20210608194330.1431202-1-arne@...1227...>
In-Reply-To: <20210608194330.1431202-1-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 8 Jun 2021 16:09:47 -0400
Message-ID: <CAKuzo_gvopmx3qXBqv35fB_Pa5wB24dM+60XGGWzOpr3c9jssA@...278...>
Content-Type: multipart/alternative; boundary="000000000000afc2b305c446bf60"
Subject: Re: [Openvpn-devel] [PATCH] Silence warning about format string in
 check_ca_required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000afc2b305c446bf60
Content-Type: text/plain; charset="UTF-8"

Hi

On Tue, Jun 8, 2021 at 3:44 PM Arne Schwabe <arne@...1227...> wrote:

> clang does not like if the format argument of printf like function
> is not a string literal:
>
> warning: format string is not a string literal (potentially insecure)
>
> Use "%s" as string literal to silence the warning.
>

Format string is often not a string literal -- we have many other such
usages in the source, though probably none without a third argument. grep
for fmt, for example.  Here str is a const char *, what more do they want?
Would const char * const str work?

Selva

--000000000000afc2b305c446bf60
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Jun 8, 2021 at 3:44 PM Arne Schwabe &lt;<a =
href=3D"mailto:arne@...1227...">arne@...1227...</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">clang does not like if the f=
ormat argument of printf like function<br>
is not a string literal:<br>
<br>
warning: format string is not a string literal (potentially insecure)<br>
<br>
Use &quot;%s&quot; as string literal to silence the warning.<br></blockquot=
e><div><br></div><div>Format string is often not a string literal -- we hav=
e many other such usages in the source, though probably=C2=A0none without a=
 third argument. grep for fmt, for example.=C2=A0 Here str is a const char =
*, what more do they want? Would const char * const str work?</div><div><br=
></div><div>Selva</div></div></div>

--000000000000afc2b305c446bf60--

