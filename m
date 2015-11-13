MIME-Version: 1.0
In-Reply-To: <20151113073802.GK24952@...1296...>
References: <1447382487-26031-1-git-send-email-selva.nair@...277...>
	<20151113073802.GK24952@...1296...>
From: Selva Nair <selva.nair@...277...>
Date: Fri, 13 Nov 2015 10:21:12 -0500
Message-ID: <CAKuzo_iCjV9sa=7=+2cz7JLxYNQ6-K6QYFgv67u31=aV-fQrmQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Do not hard-code windows systemroot in
	env_block
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Fri, Nov 13, 2015 at 2:38 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Thu, Nov 12, 2015 at 09:41:27PM -0500, Selva Nair wrote:
>> FWIW, fixes trac #500
>>
>> Signed-off-by: Selva Nair <selva.nair@...277...>
>> ---
>>  src/openvpn/win32.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
...
> Cool :-)
>
> This bug was nagging me since quite a while, but I did not know how
> to read the "correct" windows path - and didn't know about get_win_sys_path().
>
> OTOH, I'm not sure if this is going to work - win_sys_path is (unless
> set from options.c) initialized via
>
>   GetEnvironmentVariable (SYS_PATH_ENV_VAR_NAME, buf, sizeof(buf)
>   set_win_sys_path (buf, es);
>
> ... and that is likely to contain more than "c:\windows", but "a number
> of path elements"...  so it's not really "sysroot".

SYS_PATH_ENV_VAR_NAME is "SystemRoot" so that will set win_sys_path to
%SystemRoot% (aka "C:\\windows" for most people).

>
> What am I missing?

However, if the user specifies --win-sys some_cruft, win_sys_path will
get set to that "some_cruft" (in options.c). User is the king.

Having said that --the man-page description of win-sys is confusing
and its value is set as win_sys_path without any sanity checks. If
win_sys_path is not a single base directory name, many other things
will break; for example in route.c we construct the command line for
route.exe as

argv_printf (&argv, "%s%sc ADD %s MASK %s %s",
         get_win_sys_path(),
         WIN_ROUTE_PATH_SUFFIX, <---- defined as "\\system32\route.exe"
                 network,
                 netmask,
                 gateway);


Selva

