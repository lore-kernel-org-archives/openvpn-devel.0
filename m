MIME-Version: 1.0
References: <20181008214923.11058-1-arne@...1227...>
 <20181008214923.11058-2-arne@...1227...>
In-Reply-To: <20181008214923.11058-2-arne@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 9 Oct 2018 01:01:52 -0400
Message-ID: <CAKuzo_iLEXJvFMdd--GFju_Zmv0hCX3-BZYRP5hXtPBDLsFm=w@...278...>
Content-Type: multipart/alternative; boundary="000000000000cbd5300577c4a37e"
Subject: Re: [Openvpn-devel] [PATCH v2 2/3] Add support for OpenSSL TLS 1.3
 when using management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000cbd5300577c4a37e
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, Oct 8, 2018 at 5:50 PM Arne Schwabe <arne@...1227...> wrote:

> For TLS 1.0 to 1.2 OpenSSL calls us and requires a PKCS1 padded
> response, for TLS 1.3 it requires to an unpadded response. Since we
> can PCKS1 pad an unpadded response, we prefer to always query for
> an unpadded response from the management interface and add the PCKS1
> padding ourselves when needed.
>
> This patch adds an 'unpadded' parameter to the management-external-key
> option to signal that it is uses the new unpadded API. Since we cannot
> support TLS 1.3 without unpadded queries we disable TLS 1.3 otherwise.
> We also do the same for cryptoapi since it uses the same API.
>
> Using the management api client version instead might seem like the
> more logical way but since we only now that version very late,
> it would extra logic and complexity to deal with this asynchronous
> behaviour .
>

I am a bit confused about these patches.

Is it that old 3/4 and 4/4 of became v2 2/3 and v2 3/3 ? If so, is 1/3
mistakenly added to this series (it about removing some superfluous
MANAGEMENT_xxx defines..)  or does 2/3 and 3/3 depend on it?

It may help if you mark the superseded patches as such on patchwork so that
the newest versions stand out.

Thanks,

Selva

--000000000000cbd5300577c4a37e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<br><br><div class=3D"gmail_quote"><di=
v dir=3D"ltr">On Mon, Oct 8, 2018 at 5:50 PM Arne <span class=3D"" id=3D":6=
91.1" tabindex=3D"-1">Schwabe</span> &lt;<span class=3D"" id=3D":691.2" tab=
index=3D"-1">arne</span>@<a href=3D"http://rfc2549.org">rfc2549.org</a>&gt;=
 wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">For TLS =
1.0 to 1.2 OpenSSL calls us and requires a PKCS1 padded<br>
response, for TLS 1.3 it requires to an unpadded response. Since we<br>
can PCKS1 pad an unpadded response, we prefer to always query for<br>
an unpadded response from the management interface and add the PCKS1<br>
padding ourselves when needed.<br>
<br>
This patch adds an &#39;unpadded&#39; parameter to the management-external-=
key<br>
option to signal that it is uses the new unpadded API. Since we cannot<br>
support TLS 1.3 without unpadded queries we disable TLS 1.3 otherwise.<br>
We also do the same for cryptoapi since it uses the same API.<br>
<br>
Using the management api client version instead might seem like the<br>
more logical way but since we only now that version very late,<br>
it would extra logic and complexity to deal with this asynchronous<br>
behaviour .<br></blockquote><div><br></div><div>I am a bit confused about t=
hese patches.</div><div><br></div><div>Is it that old 3/4 and 4/4 of became=
 v2 2/3 and v2 3/3 ? If so, is 1/3 mistakenly added to this series (it abou=
t removing some superfluous MANAGEMENT_xxx defines..) =C2=A0or does 2/3 and=
 3/3 depend on it?</div><div><br></div><div><div>It may help if you mark th=
e superseded patches as such on patchwork so that the newest versions stand=
 out.</div></div><div><br></div><div>Thanks,</div><div><br></div><div><span=
 class=3D"" id=3D":691.4" tabindex=3D"-1">Selva</span></div></div></div></d=
iv>

--000000000000cbd5300577c4a37e--

