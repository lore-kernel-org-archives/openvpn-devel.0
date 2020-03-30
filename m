MIME-Version: 1.0
References: <1585513970-32658-1-git-send-email-selva.nair@...277...>
 <1585513970-32658-2-git-send-email-selva.nair@...277...>
 <CAEsd45RgM7Uh55jKS=Sqz_Wy+0r_j649WvE1w6ki7V4oMjt+UQ@...278...>
 <CAKuzo_hp5ojMrr0KmnHVR335uJ58QTveuqC5C9Brqv-SUq_nTA@...278...>
 <20200330060754.GU1431@...1296...>
 <CAKuzo_gXnxLCFLpQB7Rsg+2VNP4U0jUTAjKLL_4A5nx9rdkBZw@...278...>
In-Reply-To: <CAKuzo_gXnxLCFLpQB7Rsg+2VNP4U0jUTAjKLL_4A5nx9rdkBZw@...278...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Mon, 30 Mar 2020 12:11:14 -0400
Message-ID: <CAEsd45R3571EMBik_KauVWyfwyjS2oMKkxnbX5hj5UkniS4n3Q@...278...>
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
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On Mon, Mar 30, 2020 at 11:12 AM Selva Nair <selva.nair@...277...> wrote:
> Jonathan K. Bullard <jkbullard@...277...> wrote:
> >
> > If the OS X command line user was using --management-query-passwords
> > (as Tunnelblick does), they wouldn't see the password prompt on
> > /dev/tty, would they?
>
> In case of auth-file missing password, they would see it on /dev/tty
> on linux, and I would guess on OSX as well, but I've not checked.

The password prompt appears on /dev/tty on OS X only if --daemon is not used.

If --daemon and --management-query-passwords are used but --askpass is
not (whether or not --auth-nocache is also used), which is typical for
a Tunnelblick configuration on OS X, the following appears in the log:

     neither stdin nor stderr are a tty device and you have neither a
          controlling tty nor systemd - can't ask for 'Enter Auth Password:'.
          If you used --daemon, you need to use --askpass to make
          passphrase-protected keys work, and you can not use
          --auth-nocache.
     Exiting due to fatal error

if --daemon, --management-query-passwords, and --askpass are all used
(whether or not --auth-nocache is used), you get:

     Need password(s) from management interface, waiting...

If Windows GUI uses --daemon, that could be an additional requirement
that would work for Tunnelblick and OS X, which would mean one less
incompatibility between Windows and OS X.

Or it could test for Windows || (OS X && --daemon).

Best regards,

Jon Bullard

