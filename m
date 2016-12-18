MIME-Version: 1.0
In-Reply-To: <1482085616-17149-1-git-send-email-steffan@...1856...>
References: <949ac6c4-093f-3c03-c597-2ac6855b3477@...1856...>
	<1482085616-17149-1-git-send-email-steffan@...1856...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 18 Dec 2016 14:09:48 -0500
Message-ID: <CAKuzo_jbZ=bL4SgRJvpTrT+19zg07wk-vUKLcCWvUSs6Ht+Jjw@...278...>
Content-Type: multipart/alternative; boundary=001a114349c230ea700543f38d35
Subject: Re: [Openvpn-devel] [PATCH v2] reformatting: fix style in
	crypto*.{c, h}
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a114349c230ea700543f38d35
Content-Type: text/plain; charset=UTF-8

On Sun, Dec 18, 2016 at 1:26 PM, Steffan Karger <steffan@...1856...> wrote:

> Now that we have touched each and every file anyway, I decided to go over
> the code I regularly work with and reformat it some more by hand.  This is
> how for I got today, and is a large enough patch I think.
>
> This commit is mostly just reordering and changing whitespace, with one
> exception: it removes the #if 0 around some debugging code in
> read_key_file(), and now always print the debugging if D_SHOW_KEYS is
> enabled.
>
> This patch is best reviewed with something like
> 'git diff --ignore-space-change'.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> v2: fix wrong indent, add more 'for () {' -> 'for ()\n{' fixes.



Looks good (though one "for loop" missed in crypto.h, we'll get the bugger
some other time -- else there is no end to reformatting :-)

ACK.

Selva

--001a114349c230ea700543f38d35
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">=
On Sun, Dec 18, 2016 at 1:26 PM, Steffan Karger <span dir=3D"ltr">&lt;<a hr=
ef=3D"mailto:steffan@...1856..." target=3D"_blank">steffan@...1856...</a>&g=
t;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">Now tha=
t we have touched each and every file anyway, I decided to go over<br>
the code I regularly work with and reformat it some more by hand.=C2=A0 Thi=
s is<br>
how for I got today, and is a large enough patch I think.<br>
<br>
This commit is mostly just reordering and changing whitespace, with one<br>
exception: it removes the #if 0 around some debugging code in<br>
read_key_file(), and now always print the debugging if D_SHOW_KEYS is<br>
enabled.<br>
<br>
This patch is best reviewed with something like<br>
&#39;git diff --ignore-space-change&#39;.<br>
<br>
Signed-off-by: Steffan Karger &lt;<a href=3D"mailto:steffan@...1856...">ste=
ffan@...1856...</a>&gt;<br>
---<br>
</span>v2: fix wrong indent, add more &#39;for () {&#39; -&gt; &#39;for ()\=
n{&#39; fixes.</blockquote></div><br><br></div><div class=3D"gmail_extra">L=
ooks good (though one &quot;for loop&quot; missed in crypto.h, we&#39;ll ge=
t the bugger some other time -- else there is no end to reformatting :-)<br=
><br>ACK.<br><br></div><div class=3D"gmail_extra">Selva<br></div></div>

--001a114349c230ea700543f38d35--

