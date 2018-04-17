MIME-Version: 1.0
In-Reply-To: <a0dcaae0-d775-c776-a1da-7546875d6f49@...1227...>
References: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
 <a0dcaae0-d775-c776-a1da-7546875d6f49@...1227...>
From: Micah Morton <mortonm@...1913...>
Date: Tue, 17 Apr 2018 12:17:56 -0700
Message-ID: <CAJ-EccPZRSiWKRNsqL1wmdSALGx_WGAPmwy5i6t8T+K7B5J21A@...278...>
Content-Type: multipart/alternative; boundary="001a113e644025f943056a10326f"
Subject: Re: [Openvpn-devel] [PATCH] Specify platform and version on command
 line.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--001a113e644025f943056a10326f
Content-Type: text/plain; charset="UTF-8"

@gert:

Good point. We should be able to use UV_* variables to do what we need.

Thanks!

On Fri, Apr 13, 2018 at 4:24 PM, Arne Schwabe <arne@...1227...> wrote:

> Am 13.04.2018 um 19:23 schrieb Micah Morton:
>
> From 557d2e73bf21ddb9d07b43f716c7914d610e7392 Mon Sep 17 00:00:00 2001
> From: Micah Morton <mortonm@...1913...>
> Date: Fri, 13 Apr 2018 09:55:22 -0700
> Subject: [PATCH] Specify platform and version on command line.
>
> Add --iv-plat and --iv-plat-rel command line args, and use the values
> passed to these args to set IV_PLAT and IV_PLAT_REL info that is pushed
> to the server.
>
> IV_PLAT (platform type) is normally inferred from the build target, but
> it would be useful to be able to override this from the command line
> (e.g. for client to set platform as ChromeOS instead of Linux).
>
> IV_PLAT_REL (platform release version) would allow for pushing the
> platform (e.g. ChromeOS) release version to the server.
>
> My Android client already uses
>
> setenv IV_PLAT_VER to send platform specific information. I think setting
> IV_PLAT_VER (and extend that to other platforms, might be android specific
> at the moment) should also work for you. E.g..
>
> setenv IV_PLAT_VER "27 8.1.0 arm64-v8a google taimen Pixel 2 XL"
>
> Arne
>

--001a113e644025f943056a10326f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">@gert:<div><br></div><div>Good point. We should be able to=
 use UV_* variables to do what we need.</div><div><br></div><div>Thanks!</d=
iv></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Fri, =
Apr 13, 2018 at 4:24 PM, Arne Schwabe <span dir=3D"ltr">&lt;<a href=3D"mail=
to:arne@...1227..." target=3D"_blank">arne@...1227...</a>&gt;</span> wrote:=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
=20=20
=20=20=20=20
=20=20
  <div text=3D"#000000" bgcolor=3D"#FFFFFF"><span class=3D"">
    <div class=3D"m_-697804746895640438moz-cite-prefix">Am 13.04.2018 um 19=
:23 schrieb Micah
      Morton:<br>
    </div>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div>From 557d2e73bf21ddb9d07b43f716c791<wbr>4d610e7392 Mon Sep 17
          00:00:00 2001</div>
        <div>From: Micah Morton &lt;<a href=3D"mailto:mortonm@...1913..." t=
arget=3D"_blank">mortonm@...1913...</a>&gt;</div>
        <div>Date: Fri, 13 Apr 2018 09:55:22 -0700</div>
        <div>Subject: [PATCH] Specify platform and version on command
          line.</div>
        <div><br>
        </div>
        <div>Add --iv-plat and --iv-plat-rel command line args, and use
          the values</div>
        <div>passed to these args to set IV_PLAT and IV_PLAT_REL info
          that is pushed</div>
        <div>to the server.</div>
        <div><br>
        </div>
        <div>IV_PLAT (platform type) is normally inferred from the build
          target, but</div>
        <div>it would be useful to be able to override this from the
          command line</div>
        <div>(e.g. for client to set platform as ChromeOS instead of
          Linux).</div>
        <div><br>
        </div>
        <div>IV_PLAT_REL (platform release version) would allow for
          pushing the</div>
        <div>platform (e.g. ChromeOS) release version to the server.</div>
        <div><br>
        </div>
      </div>
    </blockquote></span>
    My Android client already uses <br>
    <br>
    setenv IV_PLAT_VER to send platform specific information. I think
    setting IV_PLAT_VER (and extend that to other platforms, might be
    android specific at the moment) should also work for you. E.g..<br>
    <br>
    setenv IV_PLAT_VER &quot;27 8.1.0 arm64-v8a google taimen Pixel 2 XL&qu=
ot;<span class=3D"HOEnZb"><font color=3D"#888888"><br>
    <br>
    Arne<br>
  </font></span></div>

</blockquote></div><br></div>

--001a113e644025f943056a10326f--

