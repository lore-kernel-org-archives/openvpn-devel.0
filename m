MIME-Version: 1.0
References: <CAAWBBYNLPWmjJ3whY6FAj2G8tT_qkPWZR-gUsKFHe1memta2Og@...278...>
 <CAAF3xa8T=mmZUQdyF3=AZMZZf46TJ85zH=WwAm7ORZiiGGWqZg@...278...>
 <CAKuzo_iTQWBA3t=to4sKdt21pxotNECVfTMFP_fhrEeQ3ejnQQ@...278...>
 <CAAF3xa_Jz1bjw52zBLLdXjgMymk8q+47kt9R8bP8K9Fpt8+s3g@...278...>
 <CAKuzo_jj0SXCVLrthzeCJddK2iKKXAAg4SGTA_pNRXYqcJfTQw@...278...>
 <CAAF3xa-fQ_m=Tow44wqf3DMqWEq9z90n+6Xgg6NvW-UdTaVjHQ@...278...>
 <CAKuzo_gEfixxkFVz3H4myjX9tQAXgGBMpKMJH4fWF2PesHDKDA@...278...>
 <21A02C2A-4FB5-4E3E-9D9C-B09253C9EBD9@...277...>
 <20200910073321.GR75094@...1296...>
 <CAAF3xa9CHb_xe0fn5tdiYRx-Bp3gpTfTL-KfHKqMEMdxe+XFkQ@...278...>
 <20200911055839.GZ75094@...1296...>
 <CAKuzo_hA2sSzCcYjgtqstX4o8knzBE9HjFboNX8s+T7pPY4=6Q@...278...>
 <CAAWBBYOY=61O=pfYW=cLPouRpUPJqnBypbyuVqCkuuOK13QEEw@...278...>
In-Reply-To: <CAAWBBYOY=61O=pfYW=cLPouRpUPJqnBypbyuVqCkuuOK13QEEw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 11 Sep 2020 15:45:15 -0400
Message-ID: <CAKuzo_gfo_vMRCi3QJ9f62bn-CQQHsWBLXSBQX0B4mmdmDh2Cg@...278...>
Content-Type: multipart/alternative; boundary="0000000000007128a405af0eed5d"
Subject: Re: [Openvpn-devel] problem with beta3 and wintun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Rafael Gava <gava100@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000007128a405af0eed5d
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, Sep 11, 2020 at 1:45 PM RafaeHil Gava <gava100@...277...> wrote:

> Hi Selva,
>
> I was wondering if it's possible to detect UAC during the installation.
> What do you think?
>

There are many ways of running the GUI as admin and all involve some
deliberate action on the part of the user. The best we can do is to warn
them that the GUI is running as admin and its not recommended. That will
also cover the initial launch of GUI on install with UAC disabled or from
an elevated cmdline.

Disabling UAC can be legit too if the admin knows what they are doing --
like, all users have limited privileges and admins login only to do tasks
requiring elevation etc.

Selva

--0000000000007128a405af0eed5d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Fri, Sep 11, 2020 at 1:45 PM RafaeHil Gava &lt;<=
a href=3D"mailto:gava100@...277...">gava100@...277...</a>&gt; wrote:<br></d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">Hi Se=
lva,=C2=A0<div><br></div><div>I was wondering if it&#39;s possible to detec=
t UAC during the installation. What do you=C2=A0think?</div></div></blockqu=
ote><div><br></div><div>There are many ways of running the GUI as admin and=
 all involve some deliberate action on the part of the user. The best we ca=
n do is to warn them that the GUI is running as admin and its not recommend=
ed. That will also cover the initial launch of GUI on install with UAC disa=
bled or from an elevated cmdline.</div><div><br></div><div>Disabling UAC ca=
n be legit too if the admin knows what they are doing -- like, all users ha=
ve limited privileges and admins login only to do tasks requiring elevation=
 etc.</div><div><br></div><div>Selva</div></div></div>

--0000000000007128a405af0eed5d--

