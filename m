MIME-Version: 1.0
In-Reply-To: <ddd59c15-8908-f787-c5f1-2f2ca1494a4c@...2080...>
References: <1474538677-23301-1-git-send-email-davids@...515...>
	<CAKuzo_j+FjOCOHMBw5ca1KTPX7AoFwOPkdTRKhLh9yktmFRCwQ@...278...>
	<ddd59c15-8908-f787-c5f1-2f2ca1494a4c@...2080...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 22 Sep 2016 14:38:42 -0400
Message-ID: <CAKuzo_iXRDxzvUq7Tx6z1QyL-5jtvP=jA-tbs+hK+kLExC3Kaw@...278...>
Content-Type: multipart/alternative; boundary=001a114f42dccf5557053d1cf983
Subject: Re: [Openvpn-devel] [PATCH] Have the same username/password length
 regardless of PKCS#11 enablement
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114f42dccf5557053d1cf983
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, Sep 22, 2016 at 1:44 PM, David Sommerseth <
openvpn@...2080...> wrote:

> On 22/09/16 18:43, Selva Nair wrote:
> >
> > Also usernames > 64 bytes will break --username-as-common-name as
> > CN is limited to 64 bytes (could 64 code points, but it seems
> > openvpn interprets that as 64 bytes).
> >
> > So for most practical purposes, pkcs11-id appears to be limited to
> > ~240 bytes characters in the current code. Changing USER_PASS_LEN
> > to, say, 256 may be more sensible. That shouldn't break any
> > existing configs but may break some use cases where a long id is
> > supplied from the command line.
>
> Thank you for a thorough check-up!
>
> I have spotted a few places where 'struct userpass' have been declared
> as global variables, like in socks.c, proxy.c and ssl.c.  For
>

One could replace those static structs with static pointers to the struct
and allocate at first use.

I have no issues to set USER_PASS_LEN to 256 or 1024 or in between as
> long as we are confident we don't break anything.  But I think we
> could clean up several of these global variables too.


Code-wise, I do not think this will break anything. But any number less
than 4096 could potentially break some rare (?) use cases -- e.g.,
passwords/usernames/ids of length > 256 supplied from a file or command
line on clients (and matching server) with USER_PASS_LEN = 4096. At the
same time, anything more than 256 should also increase length of option
lines and option parameters.

I vote for 256.

That said I have no idea how long are typical pkcs11-ids. And, if pkcs11
URI is adopted, the string could get arbitrarily large depending on how
many attributes are included in the URI. In my view increasing the size to
4096 to support pkcs11-ids was the wrong approach in the first place.
Anything longer than OPTION_LINE_SIZE is better input as multiple lines and
parsed without using get_user_pass.

Selva

--001a114f42dccf5557053d1cf983
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,</div><div class=3D"gmail_ex=
tra"><br><div class=3D"gmail_quote">On Thu, Sep 22, 2016 at 1:44 PM, David =
Sommerseth <span dir=3D"ltr">&lt;<a href=3D"mailto:openvpn@...2080..." targ=
et=3D"_blank">openvpn@...2080...</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;bo=
rder-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1ex">=
<span class=3D"">On 22/09/16 18:43, Selva Nair wrote:<br></span><div><div c=
lass=3D"">&gt;<br>
&gt; Also usernames &gt; 64 bytes will break --username-as-common-name as<b=
r>
&gt; CN is limited to 64 bytes (could 64 code points, but it seems<br>
&gt; openvpn interprets that as 64 bytes).<br>
&gt;<br>
&gt; So for most practical purposes, pkcs11-id appears to be limited to<br>
&gt; ~240 bytes characters in the current code. Changing USER_PASS_LEN<br>
&gt; to, say, 256 may be more sensible. That shouldn&#39;t break any<br>
&gt; existing configs but may break some use cases where a long id is<br>
&gt; supplied from the command line.<br>
<br>
</div></div>Thank you for a thorough check-up!<br>
<br>
I have spotted a few places where &#39;struct userpass&#39; have been decla=
red<br>
as global variables, like in socks.c, proxy.c and ssl.c.=C2=A0 For<br></blo=
ckquote><div><br></div><div>One could replace those static structs with sta=
tic pointers to the struct and allocate at first use.</div><div><br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;pa=
dding-left:1ex">
I have no issues to set USER_PASS_LEN to 256 or 1024 or in between as<br>
long as we are confident we don&#39;t break anything.=C2=A0 But I think we<=
br>
could clean up several of these global variables too.</blockquote></div><di=
v class=3D"gmail_extra"><br></div>Code-wise, I do not think this will break=
 anything. But any number less than 4096 could potentially break some rare =
(?) use cases -- e.g., passwords/usernames/ids of length &gt; 256 supplied =
from a file or command line on clients (and matching server) with USER_PASS=
_LEN =3D 4096. At the same time, anything more than 256 should also increas=
e length of option lines and option parameters.</div><div class=3D"gmail_ex=
tra"><br></div><div class=3D"gmail_extra">I vote for 256.<br><br></div><div=
 class=3D"gmail_extra">That said I have no idea how long are typical pkcs11=
-ids. And, if pkcs11 URI is adopted, the string could get arbitrarily large=
 depending on how many attributes are included in the URI. In my view incre=
asing the size to 4096 to support pkcs11-ids was the wrong approach in the =
first place. Anything longer than OPTION_LINE_SIZE is better input as multi=
ple lines and parsed without using get_user_pass.</div><div class=3D"gmail_=
extra"><br></div><div class=3D"gmail_extra">Selva</div></div>

--001a114f42dccf5557053d1cf983--

