MIME-Version: 1.0
In-Reply-To: <99D61A626FDA8A4B90A270669121BE10857E3A0D@...2294...>
References: <20171010231130.6832-1-simon@...2293...>
 <20171010231130.6832-5-simon@...2293...>
 <CAKuzo_iQtWLganoH3n39hASRThrqmpHYh8ec=STm9yxeeROGYg@...278...>
 <99D61A626FDA8A4B90A270669121BE10857E3A0D@...2294...>
From: Selva <selva.nair@...277...>
Date: Wed, 11 Oct 2017 10:11:48 -0400
Message-ID: <CAKuzo_hpVQV8oWLuqHfd+VQtTL92gc4Cj_PUCT97CU5CQT5F_g@...278...>
Content-Type: multipart/alternative; boundary="001a113e91645c101f055b4602f3"
Subject: Re: [Openvpn-devel] [PATCH 05/13] Function prototypes are declared
 as "typedef <return type> (<calling convention> *type_name)(<arguments>)"
 in MSVC.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Rozman <simon@...2293...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113e91645c101f055b4602f3
Content-Type: text/plain; charset="UTF-8"

Hi,


Do you still maintain 2.3 branch for Windows XP? You do know, that
> replacing GetProcAddr() with statically linked Vista+ API calls would break
> compatibility with Windows XP.
>

The interactive service is only available in 2.4 and above and was never
released for XP. Those dynamic lookups are a holdover from the original
patch that implemented this feature and somehow never got removed. All the
calls involved are supported in vista and above and removing all those
GetProcAddr() calls in interactive.c should work --  indeed there was a
patch submitted by someone  for this which never got much traction mainly
because it was for an older version of MSVC which did not support C99 and
thus included other changes.

Selva

--001a113e91645c101f055b4602f3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div><br></div><div class=3D"gmail_extra=
"><div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><div lang=3D"SL=
" link=3D"blue" vlink=3D"purple"><div class=3D"m_-7726908698724198423m_7605=
995917208064992WordSection1"><p class=3D"MsoNormal"><span lang=3D"EN-GB" st=
yle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,&quot;sans-serif&qu=
ot;;color:#1f497d">Do you still maintain 2.3 branch for Windows XP? You do =
know, that replacing GetProcAddr() with statically linked Vista+ API calls =
would break compatibility with Windows XP.</span></p></div></div></blockquo=
te><div><br></div><div>The interactive service is only available in 2.4 and=
 above and was never released for XP. Those dynamic lookups are a holdover =
from the original patch that implemented this feature and somehow never got=
 removed. All the calls involved are supported in vista and above and remov=
ing all those GetProcAddr() calls in interactive.c should work -- =C2=A0ind=
eed there was a patch submitted by someone =C2=A0for this which never got m=
uch traction mainly because it was for an older version of MSVC which did n=
ot support C99 and thus included other changes.</div><div><br></div><div>Se=
lva</div></div></div></div>

--001a113e91645c101f055b4602f3--

