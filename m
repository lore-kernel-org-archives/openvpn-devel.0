MIME-Version: 1.0
In-Reply-To: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 8 Dec 2016 16:56:09 -0500
Message-ID: <CAKuzo_gH06N2yip+h-=Q_w1xpyP62d6v4-7=Bb2NK-=+ji6iKw@...278...>
Content-Type: multipart/alternative; boundary=001a114c8946b27ebb05432cb56d
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

--001a114c8946b27ebb05432cb56d
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Dec 8, 2016 at 4:15 PM, David Sommerseth <openvpn@...2142...
topphemmelig.net> wrote:

>
> This is fairly inline with the initial agreement from the 2014 Munich
> hackathon [3] and the summarized CodeStyle wiki page [4].
>
> This proposal allows for the "open bracing" question, which allows
> '} else {'  and '} else if () {'.
>
>
> So now the bike shed debate opens up ... Is this something we can get
> consensus around?
>
> And a few examples of reformatted files:
>
>  tun.c: <https://paste.fedoraproject.org/501999/81229253/>
>  ssl.c: <https://paste.fedoraproject.org/502010/22971814/>


Looks excellent.

Yes, responding to the call for bikeshedding , some questions/comments:

Reformatted tun.c has at least two instances of char* xxx, we want char
*xxx, right? So why not add some sp_xxx_ptr_star options.

Less of a concern at least for me is function_name (...) and
function_name(...) both appears to be allowed. Just because we can do it,
why not add some sp_func_xxxx_paren options to normalize those..

Selva

--001a114c8946b27ebb05432cb56d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Thu, Dec 8, 2016 at 4:15 PM, Dav=
id Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." t=
arget=3D"_blank">openvpn@...2142...<wbr>topphemmelig.net</a>&gt;</span> wro=
te:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><br>
This is fairly inline with the initial agreement from the 2014 Munich<br>
hackathon [3] and the summarized CodeStyle wiki page [4].<br>
<br>
This proposal allows for the &quot;open bracing&quot; question, which allow=
s<br>
&#39;} else {&#39;=C2=A0 and &#39;} else if () {&#39;.<br>
<br>
<br>
So now the bike shed debate opens up ... Is this something we can get<br>
consensus around?<br>
<br>
And a few examples of reformatted files:<br>
<br>
=C2=A0tun.c: &lt;<a href=3D"https://paste.fedoraproject.org/501999/81229253=
/" rel=3D"noreferrer" target=3D"_blank">https://paste.fedoraproject.o<wbr>r=
g/501999/81229253/</a>&gt;<br>
=C2=A0ssl.c: &lt;<a href=3D"https://paste.fedoraproject.org/502010/22971814=
/" rel=3D"noreferrer" target=3D"_blank">https://paste.fedoraproject.o<wbr>r=
g/502010/22971814/</a>&gt;</blockquote></div><br></div><div class=3D"gmail_=
extra">Looks excellent. <br><br>Yes, responding to the call for bikesheddin=
g , some questions/comments:<br><br></div><div class=3D"gmail_extra">Reform=
atted tun.c has at least two instances of char* xxx, we want char *xxx, rig=
ht? So why not add some sp_xxx_ptr_star options.<br><br></div><div class=3D=
"gmail_extra">Less of a concern at least for me is function_name (...) and =
function_name(...) both appears to be allowed. Just because we can do it, w=
hy not add some sp_func_xxxx_paren options to normalize those.. <br><br></d=
iv><div class=3D"gmail_extra">Selva<br></div><div class=3D"gmail_extra"><br=
></div></div>

--001a114c8946b27ebb05432cb56d--

