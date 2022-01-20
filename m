MIME-Version: 1.0
References: <20211214165928.30676-1-selva.nair@...277...>
 <20211214165928.30676-18-selva.nair@...277...>
 <Yel23CnlcOirY904@...1296...>
In-Reply-To: <Yel23CnlcOirY904@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 20 Jan 2022 10:21:19 -0500
Message-ID: <CAKuzo_hvFFxArr2DOKRhCo=LOChZmutxDCUqakDfobT1dvmiGg@...278...>
Content-Type: multipart/alternative; boundary="000000000000cf892605d6050ea5"
Subject: Re: [Openvpn-devel] [PATCH v3 17/18] xkey-provider: Add a test for
 generic key load and signature
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cf892605d6050ea5
Content-Type: text/plain; charset="UTF-8"

Hi

On Thu, Jan 20, 2022 at 9:51 AM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Tue, Dec 14, 2021 at 11:59:27AM -0500, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Signed-off-by: Selva Nair <selva.nair@...277...>
>
> Is it OK if I squash 16+17 together?  I dislike the "history churn"
> of modifying configure.ac and Makefile.am in 16 just to remove
> the AM_CONDITIONAL bits again in 17...
>

Yeah, a previous version had checking for OpenSSL version in configure.ac
and the AM_CONDITIONAL made sense only in that case.  I can send a
new 16/18 or please do squash 16 with 17.

Thanks,

Selva

--000000000000cf892605d6050ea5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Thu, Jan 20, 2022 at 9:51 AM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-le=
ft:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Tue, Dec 14, 2021 at 11:59:27AM -0500, <a href=3D"mailto:selva.nair@...1665...=
77..." target=3D"_blank">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." target=3D=
"_blank">selva.nair@...277...</a>&gt;<br>
&gt; <br>
&gt; Signed-off-by: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277..." =
target=3D"_blank">selva.nair@...277...</a>&gt;<br>
<br>
Is it OK if I squash 16+17 together?=C2=A0 I dislike the &quot;history chur=
n&quot;<br>
of modifying <a href=3D"http://configure.ac" rel=3D"noreferrer" target=3D"_=
blank">configure.ac</a> and Makefile.am in 16 just to remove <br>
the AM_CONDITIONAL bits again in 17...<br></blockquote><div><br></div><div>=
Yeah, a previous version had checking for OpenSSL version in <a href=3D"htt=
p://configure.ac">configure.ac</a></div><div>and the AM_CONDITIONAL made se=
nse only in that case.=C2=A0 I can send a</div><div>new 16/18 or please do =
squash 16 with 17.</div><div><br></div><div>Thanks,</div><div><br></div><di=
v>Selva</div></div></div>

--000000000000cf892605d6050ea5--

