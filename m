Message-ID: <4D06503C.8090900@...1114...>
Date: Mon, 13 Dec 2010 17:56:28 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <AANLkTi=NP1rL9m4PM1G0B4nZ853cig2Eh5ETFiUP6fod@...278...>	<1292241376-18056-1-git-send-email-davids@...1347...>
	<1292257796.32094.1@...1207...>
In-Reply-To: <1292257796.32094.1@...1207...>
Subject: Re: [Openvpn-devel] [PATCH] Open log files as text files on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/12/10 17:29, Karl O. Pinc wrote:
> On 12/13/2010 05:56:16 AM, David Sommerseth wrote:
>> By giving the "t" flag to _fdopen() on Windows, the file will be
>> opened in a "translate mode", where it will take care of converting
>> \n to \r\n, and also look for the CTRL-Z mark when opening the log
>> file in append mode.
>
> It should be possible to have a consistent log format
> across hydrogenous hosts so that, need be, the logs can all
> be processed in the same fashion.  (Think swatch,
> etc.)  Which raises the following
> questions in my devoid-of-MS-isms mind:
>
> How does this affect network logging; syslog et-al?
>
> Shouldn't there be a flag that turns this on (or off)?
>

This last patch will only add the "text/translate mode" on Windows
platform when it opens a log file.  In all other scenarios, the
behaviour will be as it was before.

So seeing it in this light, Alon's remark was correct - thus my new
patch which is a lot simpler.  My initial patch would fail here.

In fact the WIN32 part of the redirect_stderr_stdout() function does set
O_TEXT when opening a file descriptor.  But it seems it was forgotten on
the _fd_open() call later on.  The redirect_stderr_stdout() function is
also only called when --log or --log-append is used in the configuration
file.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0GUDoACgkQDC186MBRfrqDZwCff+8ctGZfoHbDzYrZm/91W55M
UcEAoKC/DXcmEm/Eln6ysQ1UZEFp71DY
=2g85
-----END PGP SIGNATURE-----

