MIME-Version: 1.0
References: <20210529013516.767555-1-sergio@...2617...>
 <07e67b76-c007-053d-a02c-f079c4815dc5@...2080...>
In-Reply-To: <07e67b76-c007-053d-a02c-f079c4815dc5@...2080...>
From: Greg Cox <gcox@...1057...>
Date: Sat, 6 Nov 2021 20:28:03 +0000
Message-ID: <CACDCbPoSd2R2R--tZ+xiQHn4Q9BbZZ8HouvL4wwfqDjcDRpycA@...278...>
Content-Type: multipart/alternative; boundary="00000000000068cc2205d02499c2"
Subject: Re: [Openvpn-devel] [PATCH] resolvconf fails with -p
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000068cc2205d02499c2
Content-Type: text/plain; charset="UTF-8"

On Sat, Nov 6, 2021 at 7:37 PM David Sommerseth <
openvpn@...2080...> wrote:

> I quickly checked resolveconf on Ubuntu {18,20,21}.04 and Debian 9-11.
> Neither of them supports the '-p' argument.
>
> I've checked Fedora 34, RHEL-{7,8} too, where I could not find any
> obvious alternative to the old version of resolvconf tool.  On RHEL-8
> and Fedora, systemd-resolved is available and provides a different
> resolveconf which targets to replace this old utility.  This replacement
> neither support '-p'.
>
> This option got added in commit 3adf2f558e157ef508 back in 2010, but
> there's too little information why it was needed back then.  But given
> that neither relevant Linux distributions supports this option today,
> it's reasonable to remove it now.
>

Openresolv uses it, and Arch offers that package.
https://github.com/NetworkConfiguration/openresolv/blob/master/resolvconf.in#L108
has a -p

That's my best guess where this came from.  And then, since this is off
buried in 'contrib', "nobody" noticed it for years.

(I don't disagree with removing it, I just like forensics).

--00000000000068cc2205d02499c2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Nov 6, 2021 =
at 7:37 PM David Sommerseth &lt;<a href=3D"mailto:openvpn@...2080..." targe=
t=3D"_blank">openvpn@...2080...</a>&gt; wrote:<br></div><div class=3D"gmail=
_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">I quickly checked=
 resolveconf on Ubuntu {18,20,21}.04 and Debian 9-11. <br>
Neither of them supports the &#39;-p&#39; argument.<br>
<br>
I&#39;ve checked Fedora 34, RHEL-{7,8} too, where I could not find any <br>
obvious alternative to the old version of resolvconf tool.=C2=A0 On RHEL-8 =
<br>
and Fedora, systemd-resolved is available and provides a different <br>
resolveconf which targets to replace this old utility.=C2=A0 This replaceme=
nt <br>
neither support &#39;-p&#39;.<br>
<br>
This option got added in commit 3adf2f558e157ef508 back in 2010, but <br>
there&#39;s too little information why it was needed back then.=C2=A0 But g=
iven <br>
that neither relevant Linux distributions supports this option today, <br>
it&#39;s reasonable to remove it now.<br></blockquote><div><br></div><div s=
tyle=3D"font-family:courier new,monospace" class=3D"gmail_default">Openreso=
lv uses it, and Arch offers that package.</div><div style=3D"font-family:co=
urier new,monospace" class=3D"gmail_default"> <a href=3D"https://github.com=
/NetworkConfiguration/openresolv/blob/master/resolvconf.in#L108">https://gi=
thub.com/NetworkConfiguration/openresolv/blob/master/resolvconf.in#L108</a>=
 has a -p</div><div style=3D"font-family:courier new,monospace" class=3D"gm=
ail_default"><br></div><div style=3D"font-family:courier new,monospace" cla=
ss=3D"gmail_default">That&#39;s my best guess where this came from.=C2=A0 A=
nd then, since this is off buried in &#39;contrib&#39;, &quot;nobody&quot; =
noticed it for years.<br></div><div style=3D"font-family:courier new,monosp=
ace" class=3D"gmail_default"><br></div><div style=3D"font-family:courier ne=
w,monospace" class=3D"gmail_default">(I don&#39;t disagree with removing it=
, I just like forensics).<br></div></div>
</div>

--00000000000068cc2205d02499c2--

