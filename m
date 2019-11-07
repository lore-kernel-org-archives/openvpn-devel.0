MIME-Version: 1.0
References: <20191009143422.9419-3-a@...2181...>
 <201911062041.xA6KfP8R010468@...2054...>
 <CAGyAFMWBd2GzuZdBfTfGwROPw-hEzqSMUCUY3vrWENeqd1A46w@...278...>
 <20191107122743.GQ40538@...1296...>
 <CAGyAFMU5VAWDPuR7V3dTMKBsDbn2vgH61sgn6O9dtZNi-OTebQ@...278...>
 <20191107125707.GR40538@...1296...>
In-Reply-To: <20191107125707.GR40538@...1296...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 7 Nov 2019 23:45:14 +0200
Message-ID: <CAGyAFMUWim7Dy0x7fRegPz9AXNzrL983mQv3Z16yoC0PJ6kP0Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000562b320596c8957c"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: VLAN: add basic VLAN
 tagging support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000562b320596c8957c
Content-Type: text/plain; charset="UTF-8"

Hi,

It's lots of text that is totally uninteresting if it succeeds, but that
> you need to scroll over when looking for the reason why a build fails -
> which is the reason why it is the way it is today.
>

I have sent v2 which doesn't change the behavior for non-Windows builds.

If you volunteer to update MSVC every time we add or change a source file,
> I'm happy to send you a HEADS UP notice.  But I am not doing it, and I will
> not request it from any contributor who is not using windows.
>

All right, that would work for me. We don't add C files that often, I could
take care
of fixing Visual Studio build after getting a mail from travis / buildbot
(when we'll have MSVC there).

v2: https://patchwork.openvpn.net/patch/886/
happy travis: https://travis-ci.org/lstipakov/openvpn/builds/608949725

-- 
-Lev

--000000000000562b320596c8957c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><br><div class=3D"gmail_quote"><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">It&#39;s lots of text that is totally =
uninteresting if it succeeds, but that<br>
you need to scroll over when looking for the reason why a build fails -<br>
which is the reason why it is the way it is today.<br></blockquote><div><br=
></div><div>I have sent v2 which doesn&#39;t change the behavior for non-Wi=
ndows builds.</div><div><br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">
If you volunteer to update MSVC every time we add or change a source file,<=
br>
I&#39;m happy to send you a HEADS UP notice.=C2=A0 But I am not doing it, a=
nd I will<br>
not request it from any contributor who is not using windows.<br></blockquo=
te><div><br></div><div>All right, that would work for me. We don&#39;t add =
C files that often, I could take care</div><div>of fixing Visual Studio bui=
ld after getting a mail from travis / buildbot (when we&#39;ll have MSVC th=
ere).</div></div><div><br></div><div>v2:=C2=A0<a href=3D"https://patchwork.=
openvpn.net/patch/886/">https://patchwork.openvpn.net/patch/886/</a></div><=
div>happy travis:=C2=A0<a href=3D"https://travis-ci.org/lstipakov/openvpn/b=
uilds/608949725">https://travis-ci.org/lstipakov/openvpn/builds/608949725</=
a></div><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature">-L=
ev</div></div>

--000000000000562b320596c8957c--

