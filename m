MIME-Version: 1.0
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
 <1585513970-32658-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1585513970-32658-2-git-send-email-selva.nair@...277...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sun, 29 Mar 2020 19:12:39 -0400
Message-ID: <CAEsd45RgM7Uh55jKS=Sqz_Wy+0r_j649WvE1w6ki7V4oMjt+UQ@...278...>
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

On Sun, Mar 29, 2020 at 4:34 PM <selva.nair@...277...> wrote:
>
> From: Selva Nair <selva.nair@...277...>
>
> If only username is found in the file, redirect the auth-user-pass
> query to the management on Windows if (i) management-query-passwords
> is enabled and (ii) stdout is redirected to a log file. These
> restrictions avoid regressive behaviour: those running from the
> command line will continue to get the prompt on the console
> and if both username and password are in the file those will
> continue to get used.
>
> Note that the management will prompt for both username and password
> ignoring the username read from the file. As the GUI saves the
> username, this is a one-time inconvenience.
>
> Currently, the password is queried on the console (or systemd)
> in such cases. This is not sensible on windows if log file is
> redirected (prompt goes to the log file), or the console
> is not available as happens when the GUI is in use.

Why only Windows? I'd like this for macOS, too!

On a Mac using Tunnelblick (which uses the management interface with
management-query-passwords enabled), if the auth-user-pass file
contains only the password (and a LF), then the following occurs:

     neither stdin nor stderr are a tty device and you have neither a
controlling tty nor systemd - can't ask for 'Enter Auth Password:'.
If you used --daemon, you need to use --askpass to make
passphrase-protected keys work, and you can not use --auth-nocache.
     Exiting due to fatal error

Note: Tunnelblick uses the "--log" option to redirect output to a
file. I am assuming that's what is meant by "stdout is redirected to a
log file".

It would be nice to have the same behavior on both Windows and Mac.
For Tunnelblick, too, the username from the file would be lost but, as
with the Windows GUI, the user can opt to save it so it isn't asked
for again.

Best regards,

Jon Bullard

