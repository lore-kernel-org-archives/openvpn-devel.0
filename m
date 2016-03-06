MIME-Version: 1.0
In-Reply-To: <CAKuzo_jvCxAs8zrNABX02BENdsk+hk=KpwzXB8NA1J_8av-bQA@...278...>
References: <20160225125008.GD24952@...1296...>
	<1456457091-3872-1-git-send-email-selva.nair@...277...>
	<20160306134402.GW24952@...1296...>
	<CAKuzo_jvCxAs8zrNABX02BENdsk+hk=KpwzXB8NA1J_8av-bQA@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 6 Mar 2016 09:26:26 -0500
Message-ID: <CAKuzo_j31+GejAiC0mG=jvSSjSx6LteCuNnr53tW9csO+n3h0A@...278...>
Content-Type: multipart/alternative; boundary=047d7b417921514bf3052d62233f
Subject: Re: [Openvpn-devel] [PATCH v2 1/2] Refactor and move the
 block-outside-dns code to a new file (block_dns.[ch])
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b417921514bf3052d62233f
Content-Type: text/plain; charset=UTF-8

On Sun, Mar 6, 2016 at 9:20 AM, Selva Nair <selva.nair@...277...> wrote:

>
>> So, question 1: is this a mingw issue, or just a 32bit windows requirement
>> and you only tested on 64bit?
>>
>
> Strange thing is that it compiles and links without error (even with
> -Wall) using mingw I have here (uses gcc 4.6.3).
>


For got to add, I meant the above for both 32 bit and 64 bit.

--047d7b417921514bf3052d62233f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Mar 6, 2016 at 9:20 AM, Selva Nair <span dir=3D"ltr">&lt;<a href=3D=
"mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt=
;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex"><span><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex"><div style=3D"overflow:hidden"><br>
So, question 1: is this a mingw issue, or just a 32bit windows requirement<=
br>
and you only tested on 64bit?<br></div></blockquote><div><br></div></span><=
div>Strange thing is that it compiles and links without error (even with -W=
all) using mingw I have here (uses gcc 4.6.3).</div></blockquote></div><br>=
<br></div><div class=3D"gmail_extra">For got to add, I meant the above for =
both 32 bit and 64 bit.<br></div></div>

--047d7b417921514bf3052d62233f--

