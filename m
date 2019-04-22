MIME-Version: 1.0
References: <CAM1xzG1X-iERU2ZXFS_m_VqCKOwjt_gD8oi0F8J5h38Xx+FQ9A@...278...>
 <CAKuzo_gXgqWSLhpvMhjTS+VfbWmQ8JXnHEiOVEPyPSOMCbPKcQ@...278...>
 <63b81ed6-dce7-94b8-0dd5-8864a8314ec6@...1147...>
 <CAKuzo_iikr28FJcXNMz+xSbkoqZAyutJ3cx5J5zBvnEnEEw5bw@...278...>
 <d2f35ef2-dfbc-0202-2eb9-68e69051f742@...1147...>
 <CAKuzo_jn38kJm4izesNzK6fedgbc55MUYmmsyZRrZa1oaix5wg@...278...>
 <f120b337-53d1-b6b3-2188-db81fadc5bae@...1147...>
 <20190419191555.GK31008@...1296...>
In-Reply-To: <20190419191555.GK31008@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 21 Apr 2019 21:04:04 -0400
Message-ID: <CAKuzo_jWvtLxbt_SXyRhKAYTaV=YJWxfk4pzH9wx3A=JTStCwg@...278...>
Content-Type: multipart/alternative; boundary="0000000000006767760587140c7e"
Subject: Re: [Openvpn-devel] Issue with smartcard authentication for openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Jan Just Keijser <janjust@...1147...>, Francois Gelis <francois.gelis@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000006767760587140c7e
Content-Type: text/plain; charset="UTF-8"

Hi,

On Fri, Apr 19, 2019 at 3:15 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Apr 19, 2019 at 03:12:49PM +0200, Jan Just Keijser wrote:
> > Can you do a pull request for your pkcs11-helper patch on the
> > pkcs11helper github page?  or shall we simply patch pkcs11-helper
> ourselves?
>
> I agree with Selva that it should go upstream - since this is not about
> windows, we do not provide our own pkcs11-helper builds anywhere, so
> either we get the distribution maintainers involved (lots...) or
> upstream.
>
> (On *windows* we could just patch whatever library we use for our builds)
>
>
I've submitted a PR upstream:
https://github.com/OpenSC/pkcs11-helper/pull/22

Selva

--0000000000006767760587140c7e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr">Hi,</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Apr 19, 2019=
 at 3:15 PM Gert Doering &lt;<a href=3D"mailto:gert@...1296...">gert@...1826...=
6...</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1=
ex">Hi,<br>
<br>
On Fri, Apr 19, 2019 at 03:12:49PM +0200, Jan Just Keijser wrote:<br>
&gt; Can you do a pull request for your pkcs11-helper patch on the <br>
&gt; pkcs11helper github page?=C2=A0 or shall we simply patch pkcs11-helper=
 ourselves?<br>
<br>
I agree with Selva that it should go upstream - since this is not about<br>
windows, we do not provide our own pkcs11-helper builds anywhere, so<br>
either we get the distribution maintainers involved (lots...) or<br>
upstream.<br>
<br>
(On *windows* we could just patch whatever library we use for our builds)<b=
r><br></blockquote><div><br></div><div>I&#39;ve submitted a PR upstream:</d=
iv><div><a href=3D"https://github.com/OpenSC/pkcs11-helper/pull/22">https:/=
/github.com/OpenSC/pkcs11-helper/pull/22</a></div><div><br></div><div>Selva=
</div></div></div></div>

--0000000000006767760587140c7e--

