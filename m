Message-ID: <4C777C6F.8000809@...1114...>
Date: Fri, 27 Aug 2010 10:50:55 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <1239166995l.18482l.9l@...1207...>	<F9B005F620B74BD29BB0A36AF509BCED@...576...>
	<1239203062l.18482l.11l@...1207...>	<9e0cf0bf0904081546y3daea253u62c234e63a6e5b08@...278...>	<1239246215l.5600l.0l@...1207...>	<9e0cf0bf0904082301ia16b642n3781adc357958de3@...278...>	<1239281926l.5600l.2l@...1207...>
	<1239299083l.17083l.3l@...1207...>
In-Reply-To: <1239299083l.17083l.3l@...1207...>
Subject: Re: [Openvpn-devel] Unpackged Windows binaries? -- Problems
 building 2.1 rc15 on Windows XP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Karl O. Pinc" <kop@...1206...>
Cc: Openvpn-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 09/04/09 19:44, Karl O. Pinc wrote:
> 
> On 04/09/2009 07:58:46 AM, Karl O. Pinc wrote:
>>
>> On 04/09/2009 01:01:50 AM, Alon Bar-Lev wrote:
>> > On Thu, Apr 9, 2009 at 6:03 AM, Karl O. Pinc <kop@...1206...> wrote:
>> > > It occurs to me that if I want to do more than
>> > > beg I should submit a patch, so one is attached.

Sorry it has taken way too long time to get this one reviewed.  It's
just been quite a lot to do, and this was not considered critical enough.

> It occurs to me that it's no good having an unpackaged
> Windows binary archive without instructions regarding
> how to use it.

Agreed!

> Attached is a patch to INSTALL-win32.html that
> documents how to make a custom Windows installer using
> the archive produced by my previous patch.
> 
> I hope OpenVPN will consider these patches for inclusion.

Review follows below.


- --- INSTALL-win32.html	2005-10-18 03:46:47.000000000 -0500
+++ INSTALL-win32.html.patched	2009-04-09 12:38:59.000000000 -0500
    ^^^^^^^^^^^^^^^^^^

This is not a file which is available directly in the source tree.  It
is in best case generated somehow.  How that is done, I have no idea
(I'm not using Windows platform for development).  However, there is a
INSTALL-win32.txt file - the patch should really be against that file -
and without the HTML mark-ups.  Please do so against the git tree,
preferably the feat_misc or master branch.

[...snip...]

+<p>Note that an MS Windows machine is <em>not</em> a requirement.</p>

Why so? If I've understood you correctly, if having the needed windows
binaries available, you just rebuild the NSIS installer.  This should be
possible to do also in Linux or *BSD.

   "Portable Compiler
    The NSIS compiler can be compiled for POSIX platforms
    like Linux and *BSD. Generated installer will still
    run on Windows only, but this way they can be
    generated without Windows or WINE."
    <http://nsis.sourceforge.net/Features#Portable_Compiler>


[...snip...]

+	<li>Nullsoft Install System<br />
+	<a
href="http://www.nullsoft.com/free/nsis/">http://www.nullsoft.com/free/nsis/</a></li>

This redirects to: http://nsis.sourceforge.net/Main_Page

[...snip...]

+         <li>Unpack the OpenVPN unpackaged windows binaries.  The
+         result should be a directory, the unpacked OpenVPN binary
+         directory.  This directory should have subdirectories.</li>

Confusing sentences ... a lot of unpacked unpacked binaries unpacked.
+
+         <li>Using Internet Explorer (TM) navigate to the
+         <code>nsi</code> subdirectory of the unpacked OpenVPN binary
+         directory.

Using "Internet Explorer"?!?  Why not "Using the file browser ..."?

+         <li>Right click on the icon labeled <code>openvpn</code> and
+         select "Compile NSIS script".  Un*x users can use the
+         <code>makensis openvpn.nsi</code> command.</li>
+</ol>

Okay, here you have the cross-platform stuff.  I'd probably prefer to
state "Linux or *BSD users", as that is the supported platforms by NSIS.

[...snip...]

+         <li> Add the 2 lines:<br /><code>File
+         "myserver.ovpn"</code><br /><code>File "ca.crt"</code><br />
+         to the <code>nsi/openvpn.nsi</code> file at the bottom of
+         the section titled: <code>Section "${P`'RODUCT_NAME} Service"
                                               ^^^^^^^^^^^^^^^
Is this really correct?

+         SecService</code></li>
+</ol>
+
+<p>Note that putting your configuration and CA certificate files into
+the <code>nsi</code> subdirectory is not the most organized approach.
+It is simply the easiest way to get started with NSIS.</p>

What about to explain properly how to do it more organised?  Most users
won't care, and when they learn the sloppy way - they will never improve
it if it works.

[...snip...]


Thank you once again for you patch and patience.  If we can have these
things straightened up, I'm able to pull it into the git tree.  As this
patch do not touch any code, we can pretty sure get this on into the 2.2
release.  We're about to send out a beta release pretty soon, but this
patch have the possibility to get accepted into a later beta release.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iEYEARECAAYFAkx3fG0ACgkQDC186MBRfrqJPQCdFkQzJzGhh6O3+Jq5tBcOJjkk
zKkAn1CuXj5J9ke5xaZYKdbDG37x4O1p
=GeDb
-----END PGP SIGNATURE-----

