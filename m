References: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <a0dcaae0-d775-c776-a1da-7546875d6f49@...1227...>
Date: Sat, 14 Apr 2018 01:24:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...>
Content-Type: multipart/alternative;
 boundary="------------236D344A0FA1043641F36FFB"
Content-Language: de-DE
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
To: Micah Morton <mortonm@...1913...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------236D344A0FA1043641F36FFB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Am 13.04.2018 um 19:23 schrieb Micah Morton:
> From 557d2e73bf21ddb9d07b43f716c7914d610e7392 Mon Sep 17 00:00:00 2001
> From: Micah Morton <mortonm@...1913... <mailto:mortonm@...1913...>>
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
My Android client already uses

setenv IV_PLAT_VER to send platform specific information. I think
setting IV_PLAT_VER (and extend that to other platforms, might be
android specific at the moment) should also work for you. E.g..

setenv IV_PLAT_VER "27 8.1.0 arm64-v8a google taimen Pixel 2 XL"

Arne

--------------236D344A0FA1043641F36FFB
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Am 13.04.2018 um 19:23 schrieb Micah
      Morton:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAJ-EccN7eQsSaFn4MH4qRTKx+zZ-1YcGAe0XU8813p7k=W2i4g@...278...">
      <div dir="ltr">
        <div>From 557d2e73bf21ddb9d07b43f716c7914d610e7392 Mon Sep 17
          00:00:00 2001</div>
        <div>From: Micah Morton &lt;<a
            href="mailto:mortonm@...1913..." moz-do-not-send="true">mortonm@...1913...</a>&gt;</div>
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
    </blockquote>
    My Android client already uses <br>
    <br>
    setenv IV_PLAT_VER to send platform specific information. I think
    setting IV_PLAT_VER (and extend that to other platforms, might be
    android specific at the moment) should also work for you. E.g..<br>
    <br>
    setenv IV_PLAT_VER "27 8.1.0 arm64-v8a google taimen Pixel 2 XL"<br>
    <br>
    Arne<br>
  </body>
</html>

--------------236D344A0FA1043641F36FFB--

