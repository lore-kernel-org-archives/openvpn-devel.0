MIME-Version: 1.0
References: <YZf4ch72IZYhz5Tb@...1296...>
 <BF86C1C6-216E-4D87-9D88-B5D03F84159D@...277...>
 <CAKuzo_hrpBxCT8NDosi9AbMKFCpGkCF-cE_qYVtuL3Nh-C-pCw@...278...>
 <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
 <YZwNiBRC+V/E9OeI@...1296...>
In-Reply-To: <YZwNiBRC+V/E9OeI@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 22 Nov 2021 16:55:40 -0500
Message-ID: <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
Content-Type: multipart/alternative; boundary="0000000000008a6a3b05d167b01e"
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lstipakov@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000008a6a3b05d167b01e
Content-Type: text/plain; charset="UTF-8"

On Mon, Nov 22, 2021 at 4:37 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Mon, Nov 22, 2021 at 04:33:36PM -0500, Selva Nair wrote:
> > I think setting env vars would give us extra protection as we can detect
> > the actual location of Program Files or executable's path at run time.
>
> Indeed.
>
> (Also, the PR isn't exactly proceeding smoothly... no idea why the
> vcpkg maintainer does not want to see why Lev's PR is an improvement
> of the situation)
>

I didn't realize there is a pushback for the patch..May be he needs to see
https://github.com/openssl/openssl/issues/9520,
CVE-2019-5443 <https://nvd.nist.gov/vuln/detail/CVE-2019-5443> and our own
CVE?

I have a patch setting OPENSSL_CONF etc using SetEnvironmentVariableW() but
it needs more testing especially for OPENSSL_ENGINES and OPENSSL_MODULES in
3.0.
Is _putenv preferred?

Selva

--0000000000008a6a3b05d167b01e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr" class=3D"gmail_attr">On Mon, Nov 22, 2021=
 at 4:37 PM Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1826...=
6...</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Nov 22, 2021 at 04:33:36PM -0500, Selva Nair wrote:<br>
&gt; I think setting env vars would give us extra protection as we can dete=
ct<br>
&gt; the actual location of Program Files or executable&#39;s path at run t=
ime.<br>
<br>
Indeed.<br>
<br>
(Also, the PR isn&#39;t exactly proceeding smoothly... no idea why the<br>
vcpkg maintainer does not want to see why Lev&#39;s PR is an improvement<br>
of the situation)<br></blockquote><div><br></div><div>I didn&#39;t realize =
there is a pushback for the patch..May be he needs to see=C2=A0 <a href=3D"=
https://github.com/openssl/openssl/issues/9520">https://github.com/openssl/=
openssl/issues/9520</a>, <br></div><div><a href=3D"https://nvd.nist.gov/vul=
n/detail/CVE-2019-5443" rel=3D"nofollow">CVE-2019-5443</a> and our own CVE?=
</div><div><br></div><div>I have a patch setting OPENSSL_CONF etc using Set=
EnvironmentVariableW() but it needs more testing especially for OPENSSL_ENG=
INES and OPENSSL_MODULES in 3.0. <br></div><div>Is _putenv preferred?</div>=
<div><br></div><div>Selva<br></div></div></div>

--0000000000008a6a3b05d167b01e--

