MIME-Version: 1.0
References: <1539014950-21921-1-git-send-email-lstipakov@...277...>
 <a3899483-efab-51c7-e1de-cb497896f193@...1856...>
In-Reply-To: <a3899483-efab-51c7-e1de-cb497896f193@...1856...>
From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 10 Oct 2018 10:13:56 +0300
Message-ID: <CAGyAFMULV02g3gyCbvQ1+L+cMdE4UZMmzVfey-T1g4Y0NcmKeg@...278...>
Content-Type: multipart/alternative; boundary="000000000000aae8d90577da994d"
Subject: Re: [Openvpn-devel] [PATCH] options.c: fix broken unary minus usage
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--000000000000aae8d90577da994d
Content-Type: text/plain; charset="UTF-8"

Hi,

This was catched by Visual Studio. Moreover, with SDL enabled
(
https://docs.microsoft.com/fi-fi/cpp/build/reference/sdl-enable-additional-security-checks?view=vs-2017
)
this warning is treated as an error.

It is probably a good idea to trigger Visual Studio build on every commit
to master
(and enable SDL), have to think what would be the best way to do it.
Currently
we build with VS when making PRs to openvpn-build, which we don't do that
often.

I'm just not sure whether we should add casts, or stop using the 'hack'
> of supplying a negative value to frame_add_to_extra_frame. Maybe we
> should add a frame_remove_from_extra_frame function instead. What do you
> think?
>

Agreed, semantically it is more clear when _add_ method adds and
_remove_ method removes.

I'll add _remove_ method and change type of "increment" parameter
to unsigned in both methods so that next time when we'll try to use _add_
with negative value, we'll get a warning.

-- 
-Lev

--000000000000aae8d90577da994d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi,<div><br></div><div>This was catched b=
y Visual Studio. Moreover, with SDL enabled</div><div>(<a href=3D"https://d=
ocs.microsoft.com/fi-fi/cpp/build/reference/sdl-enable-additional-security-=
checks?view=3Dvs-2017">https://docs.microsoft.com/fi-fi/cpp/build/reference=
/sdl-enable-additional-security-checks?view=3Dvs-2017</a>)</div><div>this w=
arning is treated as an error.</div><div><br></div><div>It is probably a go=
od idea to trigger Visual Studio build on every commit to master</div><div>=
(and enable SDL), have to think what would be the best way to do it. Curren=
tly</div><div>we build with VS when making PRs to openvpn-build, which we d=
on&#39;t do that often.</div><div><br><div class=3D"gmail_quote"><blockquot=
e class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px s=
olid rgb(204,204,204);padding-left:1ex">I&#39;m just not sure whether we sh=
ould add casts, or stop using the &#39;hack&#39;<br>
of supplying a negative value to frame_add_to_extra_frame. Maybe we<br>
should add a frame_remove_from_extra_frame function instead. What do you<br>
think?<br></blockquote><div><br></div><div>Agreed, semantically it is more =
clear when _add_ method adds and</div><div>_remove_ method removes.</div><d=
iv><br></div><div>I&#39;ll add _remove_ method and change type of &quot;inc=
rement&quot; parameter</div><div>to unsigned in both methods so that next t=
ime when we&#39;ll try to use _add_</div><div>with negative value, we&#39;l=
l get a warning.=C2=A0</div><div>=C2=A0</div></div>-- <br><div dir=3D"ltr" =
class=3D"gmail_signature">-Lev</div></div></div></div>

--000000000000aae8d90577da994d--

