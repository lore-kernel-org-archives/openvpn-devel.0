Message-ID: <4E5DCD83.9080507@...515...>
Date: Wed, 31 Aug 2011 08:58:27 +0300
From: =?ISO-8859-15?Q?Samuli_Sepp=E4nen?= <samuli@...515...>
MIME-Version: 1.0
References: <4E4B873F.6080009@...515...>
	<1313652334-15914-1-git-send-email-samuli@...515...>
	<4E575276.80206@...1114...> <4E576922.8010209@...515...>
	<jwvty94e087.fsf-monnier+INBOX@...1269...>
	<20110829140648.GU8496@...1296...>
In-Reply-To: <20110829140648.GU8496@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Added whitespace handling for
 $KEY_CONFIG variable in easy-rsa/2.0/vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> Hi,
>
> On Fri, Aug 26, 2011 at 10:07:00AM -0400, Stefan Monnier wrote:
>> POSIX mandates $() so any posix shell will support it.  The issue is
>> with non-POSIX shells, if you do want to support them (e.g. Solaris's
>> /bin/sh).
> I'd rather not go down that rat-hole.  Even Solaris has POSIX-compliant
> shells today (ISTR that there is /bin/ksh).
>
> gert
Perhaps this is simply a documentation issue:

"Please use a POSIX-compliant shell (e.g. dash) with easy-rsa or you may
get unexpected results. For example, /bin/sh on Solaris is not
compliant, but you can use /bin/ksh instead."

What do you think?

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock


