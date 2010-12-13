Message-ID: <4D06A10A.3060204@...1114...>
Date: Mon, 13 Dec 2010 23:41:14 +0100
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1292271825.25909.0@...1207...>
In-Reply-To: <1292271825.25909.0@...1207...>
Subject: Re: [Openvpn-devel] [PATCH] Open log files as text files on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 13/12/10 21:23, Karl O. Pinc wrote:
| On 12/13/2010 10:56:28 AM, David Sommerseth wrote:
|> On 13/12/10 17:29, Karl O. Pinc wrote:
|>> On 12/13/2010 05:56:16 AM, David Sommerseth wrote:
|>>> By giving the "t" flag to _fdopen() on Windows, the file will be
|>>> opened in a "translate mode", where it will take care of
|> converting
|>>> \n to \r\n, and also look for the CTRL-Z mark when opening the log
|>>> file in append mode.
|>>
|>> It should be possible to have a consistent log format
|>> across hydrogenous hosts so that, need be, the logs can all
|>> be processed in the same fashion.  (Think swatch,
|>> etc.)  Which raises the following
|>> questions in my devoid-of-MS-isms mind:
|>>
|>> How does this affect network logging; syslog et-al?
|>>
|>> Shouldn't there be a flag that turns this on (or off)?
|>>
|>
|> This last patch will only add the "text/translate mode" on Windows
|> platform when it opens a log file.  In all other scenarios, the
|> behaviour will be as it was before.
|
| Just because it's a file does not mean that it's
| local to MS Windows.  E.g., there could be a samba mount
| involved.
|
| It just sounds spooky to have a sometimes-this-way
| sometimes-that-way file format without a way to
| force a single file format.  Especially when
| this is a backwards-incompatible change.

I do see your argument here.  But I will still claim that the current
implementation is more broken.  If you write a log file to C:\ and open it in
notepad, you get all log lines on one line.  Of course, more advanced users
will try to open these files in wordpad instead.  But not everyone knows this.
~ Most Windows applications expects \r\n for newline.

I would even probably claim that the majority of Windows users uses these log
files in a Windows environment, thus not having proper newlines are much more
annoying for the majority of the users.

| Having said that I've no immediate need for
| the log format to be universally uniform.
| We could always add a flag later if someone
| complains.

System admins who sets up Windows applications to write text files to a Samba
share will in most cases be aware of the origins of these files and can parse
these files accordingly.  It's also a pretty straight forward call using the
'file' command to get the newline format identified.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAk0GoQoACgkQDC186MBRfrrLfQCeISxGqyEo1dY4GESAbe2wBDOf
tSIAn2HQPiubZHSOh6YMGEzpxScDRRLR
=3UCL
-----END PGP SIGNATURE-----

