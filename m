MIME-Version: 1.0
In-Reply-To: <20161005123444.GS78279@...1296...>
References: <1475613736-1529-1-git-send-email-lstipakov@...277...>
	<842a27b1-8ce3-db91-2c76-71cfc705e1eb@...1435...>
	<20161005123444.GS78279@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 5 Oct 2016 17:29:46 +0200
Message-ID: <CAGyAFMUvHvgFTH4=M2OrcpnZFKuXq3r6Rb4DcL4KHXS353wcGg@...278...>
Content-Type: multipart/alternative; boundary=047d7ba97952dbbe60053e1fd8ba
Subject: Re: [Openvpn-devel] [PATCH 2.3] Fix compilation in pedantic mode
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7ba97952dbbe60053e1fd8ba
Content-Type: text/plain; charset=UTF-8

Hi,


I am, and the first version is what we do in (most?) other places, so I'll
> change that on the fly.
>

Got it.


> Also, the patch introduces spurious tab<->whitespace changes "close to
> comments" in a few places - will undo those, too.


I noticed that in few places indentation is a bit off - like 8 whitespaces
instead of tab so I decided to "fix" it.

Should I just ignore those things or do it in separate PR?

-- 
-Lev

--047d7ba97952dbbe60053e1fd8ba
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div=
>Hi,=C2=A0</div><div><br></div><div><br></div><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">I am, and the first version is what we do in (most?) other places, so I&#=
39;ll<br>
change that on the fly.<br></blockquote><div><br></div><div>Got it.</div><d=
iv>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex=
;border-left:1px #ccc solid;padding-left:1ex">
Also, the patch introduces spurious tab&lt;-&gt;whitespace changes &quot;cl=
ose to<br>
comments&quot; in a few places - will undo those, too.</blockquote><div><br=
></div><div>I noticed that in few places indentation is a bit off - like 8 =
whitespaces instead of tab so I decided to &quot;fix&quot; it.</div><div><b=
r></div><div>Should I just ignore those things or do it in separate PR?</di=
v></div><div><br></div>-- <br><div class=3D"gmail_signature" data-smartmail=
=3D"gmail_signature">-Lev</div>
</div></div>

--047d7ba97952dbbe60053e1fd8ba--

