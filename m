References: <1493106641-16173-1-git-send-email-chipitsine@...277...>
	<078f6fd3-c344-6a02-d0c3-bfbe3167fbe4@...1856...>
	<CAFHpkQF5H_x5=cSFZxh6C76cGAnwiEdttrTtsxuT+7TdPvH8yw@...278...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <0c4170cf-0cf1-c078-1b6c-44fbd3e62db7@...1856...>
Date: Tue, 25 Apr 2017 21:28:47 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQF5H_x5=cSFZxh6C76cGAnwiEdttrTtsxuT+7TdPvH8yw@...278...>
Subject: Re: [Openvpn-devel] [PATCH] travis-ci: add 2 mingw "build only"
 configurations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

On 25-04-17 20:51, Илья Шипицин wrote:
> 2017-04-25 22:49 GMT+05:00 Steffan Karger <steffan@...1856...
> <mailto:steffan@...1856...>>:
> 
>     On 25-04-17 09:50, Ilya Shipitsin wrote:
>     > Inspired by https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13032.html
>     <https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13032.html>
>     > build options are taken from regular windows installer builds
>     >
>     > Signed-off-by: Ilya Shipitsin <chipitsine@...277... <mailto:chipitsine@...277...>>
>     > ---
>     > v2: moved download/build dependencies into functions, changed cross build
>     > detection from shell expansion ${CHOST+x} to more recognised -z "${CHOST}",
>     > which required changing 'set -eux' to 'set -ex'. Added comments to make
>     > code readable without looking into commit message.
> 
>     Thanks, this looks much better now!  Just one nit: if we give $CHOST a
>     default value, we don't have to remove set -u:
> 
> defining CHOST when we actually do not need it does not make any sense.
> I can keep "set -u" and use shell variable expansion trick
> 
> http://stackoverflow.com/questions/3601515/how-to-check-if-a-variable-is-set-in-bash

Yeah, shell scripting can be a bit cumbersome...  Both options are
hacks, and I do not have a clear preference.  As long as we can have
"set -u" :-)

>     > --- a/.travis/build-deps.sh
>     > +++ b/.travis/build-deps.sh
>     > @@ -1,9 +1,58 @@
>     >  #!/bin/sh
>     > -set -eux
>     > +set -ex
>     >
>     >  # Set defaults
>     >  PREFIX="${PREFIX:-${HOME}/opt}"
> 
>     Just add a CHOST="${CHOST:-}" line here.  Keeping -u will help us catch
>     future problems (typos in variable names, for example).
> 
> we already had problems with such complicated definition
> 
> https://github.com/OpenVPN/openvpn/commit/368991264d82f038bde30a67910ac6c7681a4ba9#diff-ff51f64442ce689bd8d8466e365dd600R6
> 
> those errors are not easy to catch, so I would avoid defining variables
> in such way.
> 
> I think, we need to remove PREFIX definition as well.

Ok, let's do that.  (But as a separate patch, as it does not have
anything to do with windows builds.)

-Steffan

