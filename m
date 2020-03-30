MIME-Version: 1.0
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
 <1585513970-32658-2-git-send-email-selva.nair@...277...>
 <CAEsd45RgM7Uh55jKS=Sqz_Wy+0r_j649WvE1w6ki7V4oMjt+UQ@...278...>
 <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
In-Reply-To: <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 30 Mar 2020 01:22:18 -0400
Message-ID: <CAEsd45SL-U7a7QJfLZXy5Z74iqSqC8V+cvCWL_gAD2hVcJGd1g@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] When auth-user-pass file has no
 password, query the management
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
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Sun, Mar 29, 2020 at 7:58 PM Selva Nair <selva.nair@...277...> wrote:
>
> Hi,
>
> On Sun, Mar 29, 2020 at 7:13 PM Jonathan K. Bullard <jkbullard@...277...> wrote:
<snip>
> > On a Mac using Tunnelblick (which uses the management interface with
> > management-query-passwords enabled), if the auth-user-pass file
> > contains only the password (and a LF), then the following occurs:
> >
> >      neither stdin nor stderr are a tty device and you have neither a
> > controlling tty nor systemd - can't ask for 'Enter Auth Password:'.
> > If you used --daemon, you need to use --askpass to make
> > passphrase-protected keys work, and you can not use --auth-nocache.
> >      Exiting due to fatal error
>
> In those cases it looks obviously wrong to use auth-file with username
> only, and I would consider that a user error. The purpose of
> my patch was to handle only some naive usages where the user
> expects the console prompt to get automatically directed to the GUI.
> Indeed, that does happen (from user's POV) for all cases except user-pass
> with only username in a file.
>
> But I agree, we should do something like this for other GUIs such as
> tunnelblick too.
>
> >
> > Note: Tunnelblick uses the "--log" option to redirect output to a
> > file. I am assuming that's what is meant by "stdout is redirected to a
> > log file".
>
> Yes, that's right. However, that logic wont be proper on OS-X, would it?
> Command line users who use --log can still see password
> prompt on /dev/tty. We'll be breaking that behaviour.

If the OS X command line user was using --management-query-passwords
(as Tunnelblick does), they wouldn't see the password prompt on
/dev/tty, would they? Your patch checks for that, so wouldn't you only
need to change
     && defined(_WIN32)
to something like
     && (defined(_WIN32) || TARGET_OSX)
 (and add OS X to the comment at the start of the patch).

