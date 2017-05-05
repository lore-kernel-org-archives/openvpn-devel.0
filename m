MIME-Version: 1.0
In-Reply-To: <20170504173605.8269-1-valdikss@...277...>
References: <20170504173605.8269-1-valdikss@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 5 May 2017 16:21:52 -0400
Message-ID: <CAKuzo_i8Jnu2yRU8J9hpMkMpN5CZpEFCN-+OeSvicgxz0wn4tw@...278...>
Content-Type: multipart/alternative; boundary=94eb2c050a920ea502054ecca539
Subject: Re: [Openvpn-devel] [PATCH] Set a low interface metric for tap
 adapter when block-outside-dns is in use
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ValdikSS <valdikss@...277...>
Cc: ValdikSS <iam@...2070...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c050a920ea502054ecca539
Content-Type: text/plain; charset=UTF-8

Hi,

On Thu, May 4, 2017 at 1:36 PM, ValdikSS <valdikss@...277...> wrote:

>
> Windows 10 before Creators Update used to resolve DNS using all available
> adapters and IP addresses in parallel.
> Now it still resolves addresses using all available adapters but in a
> round-robin way, beginning with random adapter.
>

Hmm... If it starts with a random adapter, this metric lowering is not the
right fix, isn't it? Or did you mean to say  "starting from lowest metric
adapter"?


> This behaviour introduces significant delay when block-outside-dns is in
> use.
> Fortunately, setting low metric for the TAP interface solves this issue,
> making Windows always pick with TAP adapter first.


Well, I'm looking for to excuses to avoid the hard work of a careful review
:)  If reducing metric is indeed the right approach in this cat and mouse
game with MS, I'll try to look through this over the weekend.

Selva

--94eb2c050a920ea502054ecca539
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra">Hi,<br><br></div><div class=3D"=
gmail_extra"><div class=3D"gmail_quote">On Thu, May 4, 2017 at 1:36 PM, Val=
dikSS <span dir=3D"ltr">&lt;<a href=3D"mailto:valdikss@...277..." target=3D=
"_blank">valdikss@...277...</a>&gt;</span> wrote:<br><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><br>
Windows 10 before Creators Update used to resolve DNS using all available a=
dapters and IP addresses in parallel.<br>
Now it still resolves addresses using all available adapters but in a round=
-robin way, beginning with random adapter.<br></blockquote><div><br></div><=
div>Hmm... If it starts with a random adapter, this metric lowering is not =
the right fix, isn&#39;t it? Or did you mean to say=C2=A0 &quot;starting fr=
om lowest metric adapter&quot;? <br>=C2=A0<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">
This behaviour introduces significant delay when block-outside-dns is in us=
e.<br>
Fortunately, setting low metric for the TAP interface solves this issue, ma=
king Windows always pick with TAP adapter first.</blockquote><div><br></div=
><div>Well, I&#39;m looking for to excuses to avoid the hard work of a care=
ful review :)=C2=A0 If reducing metric is indeed the right approach in this=
 cat and mouse game with MS, I&#39;ll try to look through this over the wee=
kend.<br><br></div><div>Selva<br></div></div><br><br></div></div>

--94eb2c050a920ea502054ecca539--

