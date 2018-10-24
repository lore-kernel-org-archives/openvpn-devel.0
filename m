MIME-Version: 1.0
References: <1540375925-6111-1-git-send-email-steffan.karger@...1435...>
 <CAEsd45TFqoJOvEX3p_HhOr5m24rN5p63sU-Y8MkrKCveaSEc0A@...278...>
In-Reply-To: <CAEsd45TFqoJOvEX3p_HhOr5m24rN5p63sU-Y8MkrKCveaSEc0A@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Wed, 24 Oct 2018 07:06:04 -0400
Message-ID: <CAEsd45Qs1eRyKXJVKMk4M1T9jHFZSV77ho-HmzL9chxD0PY-sQ@...278...>
Subject: [Openvpn-devel] Fwd: [PATCH] Remove deprecated --compat-x509-names
 and --no-name-remapping
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Sorry, sent to Steffan but not the list:

---------- Forwarded message ---------
From: Jonathan K. Bullard <jkbullard@...277...>
Date: Wed, Oct 24, 2018 at 7:00 AM
Subject: Re: [Openvpn-devel] [PATCH] Remove deprecated
--compat-x509-names and --no-name-remapping
To: Steffan Karger <steffan.karger@...1435...>


Hi,

The actual option name is --compat-names, not --compat-x509-names, so
the subject line of this email should be

     "[Openvpn-devel] [PATCH] Remove deprecated --compat-names and
--no-name-remapping"

The existing source code (as of commit 2b15c11) uses compat-names
everywhere except one place, which is in a message (shown in the
patch, see below).

In addition, https://community.openvpn.net/openvpn/wiki/DeprecatedOptions
says --compat-names was deprecated in 2.3 and removed in 2.5. There is
no mention of --compat-x509-names.


On Wed, Oct 24, 2018 at 6:13 AM Steffan Karger
<steffan.karger@...1435...> wrote:
>
> As promised, remove these options for OpenVPN 2.5.
>
> If a user still uses these, print an error that the user should update it's
> configuration. Just printing a warning would cause much more confusing
> errors, somewhere in middle of a failed connection attempt because the
> (non-compat) names no longer match the expected names.

<snip>

> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -2422,10 +2422,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>          {
>              msg(M_USAGE, "--stale-routes-check requires --mode server");
>          }
> -        if (compat_flag(COMPAT_FLAG_QUERY | COMPAT_NO_NAME_REMAPPING))
> -        {
> -            msg(M_USAGE, "--compat-x509-names no-remapping requires --mode server");
> -        }
>      }
>  #endif /* P2MP_SERVER */

That's the sole reference to --compat-x509-names in the source code
that I found (as of commit 2b15c11).

Best regards,

Jon Bullard

