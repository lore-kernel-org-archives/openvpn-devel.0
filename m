MIME-Version: 1.0
In-Reply-To: <CAKuzo_i77hGdm3at0EnnmpRZiyT9Vt_8=bUqQfGwiPAHOpqQ+w@...278...>
References: <CAKuzo_i77hGdm3at0EnnmpRZiyT9Vt_8=bUqQfGwiPAHOpqQ+w@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 9 Oct 2016 13:17:27 -0400
Message-ID: <CAKuzo_iVf4DrhCNnMK3bD6+M-u99DAg8Q70y7eNJyDQoKeTH9Q@...278...>
Content-Type: multipart/alternative; boundary=001a113be29e8e17b6053e71d251
Subject: Re: [Openvpn-devel] strtok on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113be29e8e17b6053e71d251
Content-Type: text/plain; charset=UTF-8

On Sun, Oct 9, 2016 at 11:02 AM, Selva Nair <selva.nair@...277...> wrote:

> As per MSDN, strtok on Windows is thread-safe --- uses thread-local
> static for the internal state (though not reentrant). Anyone knows
> whether this is true even when mingw is used --- does it use strtok from
> Microsoft's run time or some internal implementation?
>

Well, I went ahead and tested it: indeed strtok is thread-safe on windows
(obviously not reentrant).

I guess it uses strtok in MS runtime, not a typical C library
implementation.
(Tested on Debian jessie with mingw-w64 version 4.9.1-19+14.3.)

Selva

--001a113be29e8e17b6053e71d251
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>On Sun, Oct 9, 2016 at 11:02 AM, Selva Nair <span dir=
=3D"ltr">&lt;<a href=3D"mailto:selva.nair@...277..." target=3D"_blank">selv=
a.nair@...277...</a>&gt;</span> wrote:<br><div class=3D"gmail_extra"><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div=
 dir=3D"ltr"><div>As per <span id=3D"m_-2791676301338561089gmail-m_12778545=
00348236962m_6504433406838415296:1r7.1">MSDN</span>, <span id=3D"m_-2791676=
301338561089gmail-m_1277854500348236962m_6504433406838415296:1r7.2">strtok<=
/span> on Windows is thread-safe --- uses thread-local static for the inter=
nal state (though not <span id=3D"m_-2791676301338561089gmail-m_12778545003=
48236962m_6504433406838415296:1r7.3">reentrant</span>). Anyone knows whethe=
r this is true even when <span id=3D"m_-2791676301338561089gmail-m_12778545=
00348236962m_6504433406838415296:1r7.4">mingw</span> is used --- does it us=
e <span id=3D"m_-2791676301338561089gmail-m_1277854500348236962m_6504433406=
838415296:1r7.5">strtok</span> from Microsoft&#39;s run time or some intern=
al implementation?<br></div></div></blockquote><div><br></div><div>Well, I =
went ahead and tested it: indeed strtok is thread-safe on windows (obviousl=
y not reentrant). <br><br>I guess it uses strtok in MS runtime, not a typic=
al C library implementation.<br>(Tested on Debian jessie with mingw-w64 ver=
sion 4.9.1-19+14.3.)<br><br></div><div>Selva<br></div><div><br></div></div>=
</div></div>

--001a113be29e8e17b6053e71d251--

