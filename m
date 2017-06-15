MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <87h8zhmp8b.fsf@...2274...>
References: <CAA1AbxLbVut1Z8pWF78kD=vy3rx5mxDf8MyDSR4BpxfbXoQZiQ@...278...>
	<20170612134330.20971-1-logout@...260...>
	<87h8zhmp8b.fsf@...2274...>
From: Emmanuel Deloget <logout@...260...>
Date: Thu, 15 Jun 2017 17:37:03 +0200
Message-ID: <CAKh=nwHK9P+MW8hFjuHrWGGTTf32V33HnTMxfgZcJ=zns6-1GQ@...278...>
Content-Type: multipart/alternative; boundary="001a1141dedac97a630552017009"
Subject: Re: [Openvpn-devel] [PATCH v7 0/8] OpenSSL: support for version 1.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>, openvpn-devel@lists.sourceforge.net

--001a1141dedac97a630552017009
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeremie,

On Thu, Jun 15, 2017 at 2:04 PM, Jeremie Courreges-Anglas <jca@...2272...>
wrote:

>
> Hi,
>
> fwiw, this builds fine against LibreSSL, which seems to provide some but
> not all of the functions for which you wrote fallback implementations.
> LibreSSL as shipped in OpenBSD-current, ie the development version.
>
> make check passes, openvpn seems to behave correctly in client mode.
>


=E2=80=8BThanks ! (and it's good to know :)=E2=80=8B)

Frankly, testing against LibreSSL didn't even cross my mind :) I guess I
(wrongly) assumed that LibreSSL and OpenSSL were too different by now --
it's good to see than some of the API is still the same (for any definition
of good ; I guess the folk at LibreSSL find this a bit discouraging...).

Best regards,

-- Emmanuel Deloget

--001a1141dedac97a630552017009
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:courier =
new,monospace">Hi Jeremie,</div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Thu, Jun 15, 2017 at 2:04 PM, Jeremie Courreges-Anglas =
<span dir=3D"ltr">&lt;<a href=3D"mailto:jca@...2272..." target=3D"_blank">j=
ca@...2272...</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
Hi,<br>
<br>
fwiw, this builds fine against LibreSSL, which seems to provide some but<br>
not all of the functions for which you wrote fallback implementations.<br>
LibreSSL as shipped in OpenBSD-current, ie the development version.<br>
<br>
make check passes, openvpn seems to behave correctly in client mode.<br></b=
lockquote><div><br></div><div><div class=3D"gmail_default" style=3D"font-fa=
mily:&quot;courier new&quot;,monospace"><br></div><div class=3D"gmail_defau=
lt" style=3D"font-family:&quot;courier new&quot;,monospace">=E2=80=8BThanks=
 ! (and it&#39;s good to know :)=E2=80=8B)</div><div class=3D"gmail_default=
" style=3D"font-family:&quot;courier new&quot;,monospace"><br></div><div cl=
ass=3D"gmail_default" style=3D"font-family:&quot;courier new&quot;,monospac=
e">Frankly, testing against LibreSSL didn&#39;t even cross my mind :) I gue=
ss I (wrongly) assumed that LibreSSL and OpenSSL were too different by now =
-- it&#39;s good to see than some of the API is still the same (for any def=
inition of good ; I guess the folk at LibreSSL find this a bit discouraging=
...).=C2=A0</div></div><div class=3D"gmail_default" style=3D"font-family:&q=
uot;courier new&quot;,monospace"><br></div><div class=3D"gmail_default" sty=
le=3D"font-family:&quot;courier new&quot;,monospace">Best regards,=C2=A0</d=
iv><div class=3D"gmail_default" style=3D"font-family:&quot;courier new&quot=
;,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:&q=
uot;courier new&quot;,monospace">-- Emmanuel Deloget</div></div><br></div><=
/div>

--001a1141dedac97a630552017009--

