MIME-Version: 1.0
References: <20230311052403.1154030-1-selva.nair@...277...>
 <c471a93d-6c95-62f1-6b30-da39a744c5f3@...2108...>
 <a0ae9930-ec24-3a2f-cdf8-5f3d68f97068@...2108...>
 <da212e29-254b-bc16-8a00-30bd4bb9dbaa@...2108...>
In-Reply-To: <da212e29-254b-bc16-8a00-30bd4bb9dbaa@...2108...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 14 Mar 2023 08:46:41 -0400
Message-ID: <CAKuzo_iSSM8KP4R1rH71ogoFzEJTUs41BQPRBW-VV=f+o-6kzA@...278...>
Content-Type: multipart/alternative; boundary="00000000000072670705f6db9fdf"
Subject: Re: [Openvpn-devel] [PATCH] Bugfix: Convert ECDSA signature form
 pkcs11-helper to DER encoded form
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <dazo+openvpn@...2108...>
Cc: openvpn-devel@lists.sourceforge.net

--00000000000072670705f6db9fdf
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 14, 2023 at 5:54=E2=80=AFAM David Sommerseth <dazo+openvpn@...1665...=
108...>
wrote:

>
>
> Just got feedback from the reporter in the Fedora bugzilla; this patch
> works well on Fedora 38.
>
> I suggest adding this tag to the commit log.  Feel free to add the URL
> tag to the bugzilla ticket too.
>
> Tested-by: florian@...2720...


Thanks. Updated patch is on the list.

I "heard" whispers of "2.6.2 coming soon" in another thread. Would be great
if this fix can make it.

As this also touches cryptoapicert (via a refactor), an independent test on
Windows
would be useful.

Selva

--00000000000072670705f6db9fdf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Tue, Mar 14, 2023 at 5:54=E2=80=AFAM David Somm=
erseth &lt;<a href=3D"mailto:dazo%2Bopenvpn@...2108..." target=3D"_blank">d=
azo+openvpn@...2108...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex"><br>
<br>
Just got feedback from the reporter in the Fedora bugzilla; this patch <br>
works well on Fedora 38.<br>
<br>
I suggest adding this tag to the commit log.=C2=A0 Feel free to add the URL=
<br>
tag to the bugzilla ticket too.<br>
<br>
Tested-by: <a href=3D"mailto:florian@...2720..." target=3D"_blank">florian@=
...2720...</a></blockquote><div><br></div><div>Thanks. Updated patch is on =
the list.</div><div><br></div><div>I &quot;heard&quot; whispers of &quot;2.=
6.2 coming soon&quot; in another thread. Would be great if this fix can mak=
e it.</div><div><br></div><div>As this also touches cryptoapicert (via a re=
factor), an independent test on Windows</div><div>would be useful.</div><di=
v><br></div><div>Selva</div></div></div>

--00000000000072670705f6db9fdf--

