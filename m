MIME-Version: 1.0
In-Reply-To: <20150725194558.GM382@...1296...>
References: <C17CBC9D7B974729BACBF182B77A8C76@...1853...>
	<20150725194558.GM382@...1296...>
From: "Jonathan K. Bullard" <jkbullard@...277...>
Date: Sat, 25 Jul 2015 16:24:50 -0400
Message-ID: <CAEsd45ROXPNs54CBQSnp-N+g=nYhgbqVKCPihAo32qXmB_6OJA@...278...>
Subject: Re: [Openvpn-devel] Docs or Bug: --push options no longer require
 double quotes
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

On Sat, Jul 25, 2015 at 3:45 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Sat, Jul 25, 2015 at 01:34:46PM +0100, debbie10t@...277... wrote:
>> As the title states --push no longer requires options to be double quoted.
>
> Well, *did* it require double quotes at some point?  If yes, when?

Double-quotes may not be required in a configuration file, but they
are required (or single-quotes, or the space must be escaped) if the
option is used on a command line, e.g.,

     openvpn --push "redirect-gateway def1" ...

Otherwise "redirect-gateway" is considered the "option" to --push, and
"def1" will be interpreted as something else (a config file? an
error?).

This is true of **any** single argument to an Openvpn command line
option: if it contains spaces or tabs, it must be enclosed in
double-quotes (or single-quotes, or have the spaces escaped with
backslashes).

It is also true of arguments in a configuration file if there is more
than one argument to the option and the first argument contains
spaces. For example, --secret file [direction]:

     secret "file-path with spaces" 0

I think it is best to always enclose any single argument that contains
spaces with double-quotes, even in a configuration file. This makes it
completely unambiguous, and future-proofs the file if a later version
of OpenVPN allows an optional argument to the option.

